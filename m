From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/37] perf scripts python: call-graph-from-sql.py: Factor out CallGraphModel from TreeModel
Date: Thu, 25 Oct 2018 08:10:18 -0300
Message-ID: <20181025111031.3440-25-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Factor out CallGraphModel from TreeModel, which paves the way to reuse
TreeModel in future reports.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 90 ++++++++++++++++--------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index 65c18e351bc4..ada486048ad8 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -201,42 +201,47 @@ class TreeItem():
 			self.selectCalls()
 		return self.child_count
 
-	def columnCount(self):
-		return 7
-
-	def columnHeader(self, column):
-		headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
-		return headers[column]
+	def hasChildren(self):
+		if not self.query_done:
+			return True
+		return self.child_count > 0
 
 	def getData(self, column):
 		return self.data[column]
 
+# Tree data model
+
 class TreeModel(QAbstractItemModel):
 
-	def __init__(self, db, parent=None):
+	def __init__(self, root, parent=None):
 		super(TreeModel, self).__init__(parent)
-		self.db = db
-		self.root = TreeItem(db, 0, None)
+		self.root = root
+		self.last_row_read = 0
 
-	def columnCount(self, parent):
-		return self.root.columnCount()
-
-	def rowCount(self, parent):
+	def Item(self, parent):
 		if parent.isValid():
-			parent_item = parent.internalPointer()
+			return parent.internalPointer()
 		else:
-			parent_item = self.root
-		return parent_item.childCount()
+			return self.root
+
+	def rowCount(self, parent):
+		result = self.Item(parent).childCount()
+		if result < 0:
+			result = 0
+			self.dataChanged.emit(parent, parent)
+		return result
+
+	def hasChildren(self, parent):
+		return self.Item(parent).hasChildren()
 
 	def headerData(self, section, orientation, role):
 		if role == Qt.TextAlignmentRole:
-			if section > 1:
-				return Qt.AlignRight
+			return self.columnAlignment(section)
 		if role != Qt.DisplayRole:
 			return None
 		if orientation != Qt.Horizontal:
 			return None
-		return self.root.columnHeader(section)
+		return self.columnHeader(section)
 
 	def parent(self, child):
 		child_item = child.internalPointer()
@@ -246,21 +251,48 @@ class TreeModel(QAbstractItemModel):
 		return self.createIndex(parent_item.getRow(), 0, parent_item)
 
 	def index(self, row, column, parent):
-		if parent.isValid():
-			parent_item = parent.internalPointer()
-		else:
-			parent_item = self.root
-		child_item = parent_item.getChildItem(row)
+		child_item = self.Item(parent).getChildItem(row)
 		return self.createIndex(row, column, child_item)
 
+	def DisplayData(self, item, index):
+		return item.getData(index.column())
+
+	def columnAlignment(self, column):
+		return Qt.AlignLeft
+
+	def columnFont(self, column):
+		return None
+
 	def data(self, index, role):
 		if role == Qt.TextAlignmentRole:
-			if index.column() > 1:
-				return Qt.AlignRight
+			return self.columnAlignment(index.column())
+		if role == Qt.FontRole:
+			return self.columnFont(index.column())
 		if role != Qt.DisplayRole:
 			return None
-		index_item = index.internalPointer()
-		return index_item.getData(index.column())
+		item = index.internalPointer()
+		return self.DisplayData(item, index)
+
+# Context-sensitive call graph data model
+
+class CallGraphModel(TreeModel):
+
+	def __init__(self, glb, parent=None):
+		super(CallGraphModel, self).__init__(TreeItem(glb.db, 0, None), parent)
+		self.glb = glb
+
+	def columnCount(self, parent=None):
+		return 7
+
+	def columnHeader(self, column):
+		headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
+		return headers[column]
+
+	def columnAlignment(self, column):
+		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
+		return alignment[column]
+
+# Main window
 
 class MainWindow(QMainWindow):
 
@@ -275,7 +307,7 @@ class MainWindow(QMainWindow):
 		self.setWindowIcon(self.style().standardIcon(QStyle.SP_ComputerIcon))
 		self.setMinimumSize(200, 100)
 
-		self.model = TreeModel(glb.db)
+		self.model = CallGraphModel(glb)
 
 		self.view = QTreeView()
 		self.view.setModel(self.model)
-- 
2.14.4
