From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/73] perf scripts python: exported-sql-viewer.py: Add copy to clipboard
Date: Fri, 17 May 2019 16:35:14 -0300
Message-ID: <20190517193611.4974-17-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add support for copying to clipboard. Two menu options are added to copy the
selected rows / columns with normal spacing, or as comma-separated-values.
In the case of trees, only entire rows can be copied.

Comitter testing:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db

Select the lines, press control+C and on the same terminal,
press control+shift+V and voilà:

Call Path                           Object           Count  Time (ns)  Time (%)  Branch Count  Branch Count (%)
  ▼ 14503:14503
    ▼ _start                        ld-2.28.so           1     156267     100.0         10602             100.0
        unknown                     unknown              1       2276       1.5             1               0.0
      ▼ _dl_start                   ld-2.28.so           1     137047      87.7         10088              95.2
        ▶ unknown                   unknown              4       4127       3.0             4               0.0
          _dl_setup_hash            ld-2.28.so           1          0       0.0             1               0.0
        ▶ _dl_sysdep_start          ld-2.28.so           1     131342      95.8          9981              98.9
      ▼ _dl_init                    ld-2.28.so           1       9142       5.9           326               3.1
        ▼ call_init.part.0          ld-2.28.so           3       9133      99.9           319              97.9
          ▶ _init                   libc-2.28.so         1       6877      75.3           110              34.5
          ▶ check_stdfiles_vtables  libc-2.28.so         1         76       0.8             2               0.6
          ▶ init_cacheinfo          libc-2.28.so         1       1991      21.8           197              61.8
      ▶ _start                      simple-retpoline     1       7457       4.8           182               1.7

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190503120828.25326-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 217 ++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 48953257a1f0..baa2b220238a 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -884,6 +884,8 @@ class TreeWindowBase(QMdiSubWindow):
 		self.find_bar = None
 
 		self.view = QTreeView()
+		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
+		self.view.CopyCellsToClipboard = CopyTreeCellsToClipboard
 
 	def DisplayFound(self, ids):
 		if not len(ids):
@@ -1652,6 +1654,8 @@ class BranchWindow(QMdiSubWindow):
 
 		self.view = QTreeView()
 		self.view.setUniformRowHeights(True)
+		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
+		self.view.CopyCellsToClipboard = CopyTreeCellsToClipboard
 		self.view.setModel(self.model)
 
 		self.ResizeColumnsToContents()
@@ -2264,6 +2268,207 @@ class ResizeColumnsToContentsBase(QObject):
 		self.data_model.rowsInserted.disconnect(self.UpdateColumnWidths)
 		self.ResizeColumnsToContents()
 
+# Convert value to CSV
+
+def ToCSValue(val):
+	if '"' in val:
+		val = val.replace('"', '""')
+	if "," in val or '"' in val:
+		val = '"' + val + '"'
+	return val
+
+# Key to sort table model indexes by row / column, assuming fewer than 1000 columns
+
+glb_max_cols = 1000
+
+def RowColumnKey(a):
+	return a.row() * glb_max_cols + a.column()
+
+# Copy selected table cells to clipboard
+
+def CopyTableCellsToClipboard(view, as_csv=False, with_hdr=False):
+	indexes = sorted(view.selectedIndexes(), key=RowColumnKey)
+	idx_cnt = len(indexes)
+	if not idx_cnt:
+		return
+	if idx_cnt == 1:
+		with_hdr=False
+	min_row = indexes[0].row()
+	max_row = indexes[0].row()
+	min_col = indexes[0].column()
+	max_col = indexes[0].column()
+	for i in indexes:
+		min_row = min(min_row, i.row())
+		max_row = max(max_row, i.row())
+		min_col = min(min_col, i.column())
+		max_col = max(max_col, i.column())
+	if max_col > glb_max_cols:
+		raise RuntimeError("glb_max_cols is too low")
+	max_width = [0] * (1 + max_col - min_col)
+	for i in indexes:
+		c = i.column() - min_col
+		max_width[c] = max(max_width[c], len(str(i.data())))
+	text = ""
+	pad = ""
+	sep = ""
+	if with_hdr:
+		model = indexes[0].model()
+		for col in range(min_col, max_col + 1):
+			val = model.headerData(col, Qt.Horizontal)
+			if as_csv:
+				text += sep + ToCSValue(val)
+				sep = ","
+			else:
+				c = col - min_col
+				max_width[c] = max(max_width[c], len(val))
+				width = max_width[c]
+				align = model.headerData(col, Qt.Horizontal, Qt.TextAlignmentRole)
+				if align & Qt.AlignRight:
+					val = val.rjust(width)
+				text += pad + sep + val
+				pad = " " * (width - len(val))
+				sep = "  "
+		text += "\n"
+		pad = ""
+		sep = ""
+	last_row = min_row
+	for i in indexes:
+		if i.row() > last_row:
+			last_row = i.row()
+			text += "\n"
+			pad = ""
+			sep = ""
+		if as_csv:
+			text += sep + ToCSValue(str(i.data()))
+			sep = ","
+		else:
+			width = max_width[i.column() - min_col]
+			if i.data(Qt.TextAlignmentRole) & Qt.AlignRight:
+				val = str(i.data()).rjust(width)
+			else:
+				val = str(i.data())
+			text += pad + sep + val
+			pad = " " * (width - len(val))
+			sep = "  "
+	QApplication.clipboard().setText(text)
+
+def CopyTreeCellsToClipboard(view, as_csv=False, with_hdr=False):
+	indexes = view.selectedIndexes()
+	if not len(indexes):
+		return
+
+	selection = view.selectionModel()
+
+	first = None
+	for i in indexes:
+		above = view.indexAbove(i)
+		if not selection.isSelected(above):
+			first = i
+			break
+
+	if first is None:
+		raise RuntimeError("CopyTreeCellsToClipboard internal error")
+
+	model = first.model()
+	row_cnt = 0
+	col_cnt = model.columnCount(first)
+	max_width = [0] * col_cnt
+
+	indent_sz = 2
+	indent_str = " " * indent_sz
+
+	expanded_mark_sz = 2
+	if sys.version_info[0] == 3:
+		expanded_mark = "\u25BC "
+		not_expanded_mark = "\u25B6 "
+	else:
+		expanded_mark = unicode(chr(0xE2) + chr(0x96) + chr(0xBC) + " ", "utf-8")
+		not_expanded_mark =  unicode(chr(0xE2) + chr(0x96) + chr(0xB6) + " ", "utf-8")
+	leaf_mark = "  "
+
+	if not as_csv:
+		pos = first
+		while True:
+			row_cnt += 1
+			row = pos.row()
+			for c in range(col_cnt):
+				i = pos.sibling(row, c)
+				if c:
+					n = len(str(i.data()))
+				else:
+					n = len(str(i.data()).strip())
+					n += (i.internalPointer().level - 1) * indent_sz
+					n += expanded_mark_sz
+				max_width[c] = max(max_width[c], n)
+			pos = view.indexBelow(pos)
+			if not selection.isSelected(pos):
+				break
+
+	text = ""
+	pad = ""
+	sep = ""
+	if with_hdr:
+		for c in range(col_cnt):
+			val = model.headerData(c, Qt.Horizontal, Qt.DisplayRole).strip()
+			if as_csv:
+				text += sep + ToCSValue(val)
+				sep = ","
+			else:
+				max_width[c] = max(max_width[c], len(val))
+				width = max_width[c]
+				align = model.headerData(c, Qt.Horizontal, Qt.TextAlignmentRole)
+				if align & Qt.AlignRight:
+					val = val.rjust(width)
+				text += pad + sep + val
+				pad = " " * (width - len(val))
+				sep = "   "
+		text += "\n"
+		pad = ""
+		sep = ""
+
+	pos = first
+	while True:
+		row = pos.row()
+		for c in range(col_cnt):
+			i = pos.sibling(row, c)
+			val = str(i.data())
+			if not c:
+				if model.hasChildren(i):
+					if view.isExpanded(i):
+						mark = expanded_mark
+					else:
+						mark = not_expanded_mark
+				else:
+					mark = leaf_mark
+				val = indent_str * (i.internalPointer().level - 1) + mark + val.strip()
+			if as_csv:
+				text += sep + ToCSValue(val)
+				sep = ","
+			else:
+				width = max_width[c]
+				if c and i.data(Qt.TextAlignmentRole) & Qt.AlignRight:
+					val = val.rjust(width)
+				text += pad + sep + val
+				pad = " " * (width - len(val))
+				sep = "   "
+		pos = view.indexBelow(pos)
+		if not selection.isSelected(pos):
+			break
+		text = text.rstrip() + "\n"
+		pad = ""
+		sep = ""
+
+	QApplication.clipboard().setText(text)
+
+def CopyCellsToClipboard(view, as_csv=False, with_hdr=False):
+	view.CopyCellsToClipboard(view, as_csv, with_hdr)
+
+def CopyCellsToClipboardHdr(view):
+	CopyCellsToClipboard(view, False, True)
+
+def CopyCellsToClipboardCSV(view):
+	CopyCellsToClipboard(view, True, True)
+
 # Table window
 
 class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
@@ -2282,6 +2487,8 @@ class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
 		self.view.verticalHeader().setVisible(False)
 		self.view.sortByColumn(-1, Qt.AscendingOrder)
 		self.view.setSortingEnabled(True)
+		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
+		self.view.CopyCellsToClipboard = CopyTableCellsToClipboard
 
 		self.ResizeColumnsToContents()
 
@@ -2398,6 +2605,8 @@ class TopCallsWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
 		self.view.setModel(self.model)
 		self.view.setEditTriggers(QAbstractItemView.NoEditTriggers)
 		self.view.verticalHeader().setVisible(False)
+		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
+		self.view.CopyCellsToClipboard = CopyTableCellsToClipboard
 
 		self.ResizeColumnsToContents()
 
@@ -2735,6 +2944,8 @@ class MainWindow(QMainWindow):
 		file_menu.addAction(CreateExitAction(glb.app, self))
 
 		edit_menu = menu.addMenu("&Edit")
+		edit_menu.addAction(CreateAction("&Copy", "Copy to clipboard", self.CopyToClipboard, self, QKeySequence.Copy))
+		edit_menu.addAction(CreateAction("Copy as CS&V", "Copy to clipboard as CSV", self.CopyToClipboardCSV, self))
 		edit_menu.addAction(CreateAction("&Find...", "Find items", self.Find, self, QKeySequence.Find))
 		edit_menu.addAction(CreateAction("Fetch &more records...", "Fetch more records", self.FetchMoreRecords, self, [QKeySequence(Qt.Key_F8)]))
 		edit_menu.addAction(CreateAction("&Shrink Font", "Make text smaller", self.ShrinkFont, self, [QKeySequence("Ctrl+-")]))
@@ -2767,6 +2978,12 @@ class MainWindow(QMainWindow):
 			except:
 				pass
 
+	def CopyToClipboard(self):
+		self.Try(CopyCellsToClipboardHdr)
+
+	def CopyToClipboardCSV(self):
+		self.Try(CopyCellsToClipboardCSV)
+
 	def Find(self):
 		win = self.mdi_area.activeSubWindow()
 		if win:
-- 
2.20.1
