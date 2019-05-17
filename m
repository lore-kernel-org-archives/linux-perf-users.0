From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/73] perf scripts python: exported-sql-viewer.py: Add context menu
Date: Fri, 17 May 2019 16:35:15 -0300
Message-ID: <20190517193611.4974-18-acme@kernel.org>
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

Add a context menu (right-click) that provides options for copying to
clipboard, including, for trees, the ability to copy only the cell under
the mouse pointer.

Committer testing:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db

  Simply right click and pick "Copy selection", that at this point has
  just the first line, not expanded, then see what was copied by pressing
  shift+control+v on a terminal:

Call Path,Object,Count,Time (ns),Time (%),Branch Count,Branch Count (%)
▶ simple-retpolin,,,,,,

  Ditto after expanding, i.e. the selection continues to be just one
  line:

Call Path           Object   Count   Time (ns)   Time (%)   Branch Count   Branch Count (%)
▼ simple-retpolin

   Now select all the lines with the mouse and control+shift+v again:

Call Path                     Object             Count   Time (ns)   Time (%)   Branch Count   Branch Count (%)
  ▼ 14503:14503
    ▼ _start                  ld-2.28.so             1      156267      100.0          10602              100.0
      ▶ unknown               unknown                1        2276        1.5              1                0.0
      ▶ _dl_start             ld-2.28.so             1      137047       87.7          10088               95.2
      ▶ _dl_init              ld-2.28.so             1        9142        5.9            326                3.1
      ▼ _start                simple-retpoline       1        7457        4.8            182                1.7
        ▶ unknown             unknown                1         805       10.8              1                0.5
        ▶ __libc_start_main   libc-2.28.so           1        6347       85.1            179               98.4

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190503120828.25326-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index baa2b220238a..affd80ebcae0 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -887,6 +887,8 @@ class TreeWindowBase(QMdiSubWindow):
 		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
 		self.view.CopyCellsToClipboard = CopyTreeCellsToClipboard
 
+		self.context_menu = TreeContextMenu(self.view)
+
 	def DisplayFound(self, ids):
 		if not len(ids):
 			return False
@@ -1660,6 +1662,8 @@ class BranchWindow(QMdiSubWindow):
 
 		self.ResizeColumnsToContents()
 
+		self.context_menu = TreeContextMenu(self.view)
+
 		self.find_bar = FindBar(self, self, True)
 
 		self.finder = ChildDataItemFinder(self.model.root)
@@ -2469,6 +2473,39 @@ def CopyCellsToClipboardHdr(view):
 def CopyCellsToClipboardCSV(view):
 	CopyCellsToClipboard(view, True, True)
 
+# Context menu
+
+class ContextMenu(object):
+
+	def __init__(self, view):
+		self.view = view
+		self.view.setContextMenuPolicy(Qt.CustomContextMenu)
+		self.view.customContextMenuRequested.connect(self.ShowContextMenu)
+
+	def ShowContextMenu(self, pos):
+		menu = QMenu(self.view)
+		self.AddActions(menu)
+		menu.exec_(self.view.mapToGlobal(pos))
+
+	def AddCopy(self, menu):
+		menu.addAction(CreateAction("&Copy selection", "Copy to clipboard", lambda: CopyCellsToClipboardHdr(self.view), self.view))
+		menu.addAction(CreateAction("Copy selection as CS&V", "Copy to clipboard as CSV", lambda: CopyCellsToClipboardCSV(self.view), self.view))
+
+	def AddActions(self, menu):
+		self.AddCopy(menu)
+
+class TreeContextMenu(ContextMenu):
+
+	def __init__(self, view):
+		super(TreeContextMenu, self).__init__(view)
+
+	def AddActions(self, menu):
+		i = self.view.currentIndex()
+		text = str(i.data()).strip()
+		if len(text):
+			menu.addAction(CreateAction('Copy "' + text + '"', "Copy to clipboard", lambda: QApplication.clipboard().setText(text), self.view))
+		self.AddCopy(menu)
+
 # Table window
 
 class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
@@ -2492,6 +2529,8 @@ class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
 
 		self.ResizeColumnsToContents()
 
+		self.context_menu = ContextMenu(self.view)
+
 		self.find_bar = FindBar(self, self, True)
 
 		self.finder = ChildDataItemFinder(self.data_model)
@@ -2608,6 +2647,8 @@ class TopCallsWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
 		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
 		self.view.CopyCellsToClipboard = CopyTableCellsToClipboard
 
+		self.context_menu = ContextMenu(self.view)
+
 		self.ResizeColumnsToContents()
 
 		self.find_bar = FindBar(self, self, True)
-- 
2.20.1
