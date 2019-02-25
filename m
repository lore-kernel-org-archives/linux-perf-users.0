From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/37] perf scripts python: exported-sql-viewer.py: Factor out ReportVars
Date: Mon, 25 Feb 2019 18:20:07 -0300
Message-ID: <20190225212035.24781-10-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Factor out ReportVars to provide a single container for information from
report dialogs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 37 ++++++++++++-------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index d3ffb3e9d1fc..03428df8ddd5 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1398,18 +1398,26 @@ class BranchModel(TreeModel):
 	def HasMoreRecords(self):
 		return self.more
 
+# Report Variables
+
+class ReportVars():
+
+	def __init__(self, where_clause = ""):
+		self.where_clause = where_clause
+
+	def UniqueId(self):
+		return str(self.where_clause)
+
 # Branch window
 
 class BranchWindow(QMdiSubWindow):
 
-	def __init__(self, glb, event_id, name, where_clause, parent=None):
+	def __init__(self, glb, event_id, name, report_vars, parent=None):
 		super(BranchWindow, self).__init__(parent)
 
-		model_name = "Branch Events " + str(event_id)
-		if len(where_clause):
-			model_name = where_clause + " " + model_name
+		model_name = "Branch Events " + str(event_id) +  " " + report_vars.UniqueId()
 
-		self.model = LookupCreateModel(model_name, lambda: BranchModel(glb, event_id, where_clause))
+		self.model = LookupCreateModel(model_name, lambda: BranchModel(glb, event_id, report_vars.where_clause))
 
 		self.view = QTreeView()
 		self.view.setUniformRowHeights(True)
@@ -1703,7 +1711,7 @@ class ReportDialogBase(QDialog):
 		self.glb = glb
 
 		self.name = ""
-		self.where_clause = ""
+		self.report_vars = ReportVars()
 
 		self.setWindowTitle(title)
 		self.setMinimumWidth(600)
@@ -1742,6 +1750,7 @@ class ReportDialogBase(QDialog):
 		self.setLayout(self.vbox);
 
 	def Ok(self):
+		vars = self.report_vars
 		self.name = self.data_items[0].value
 		if not self.name:
 			self.ShowMessage("Report name is required")
@@ -1751,14 +1760,14 @@ class ReportDialogBase(QDialog):
 				return
 		for d in self.data_items[1:]:
 			if len(d.value):
-				if len(self.where_clause):
-					self.where_clause += " AND "
-				self.where_clause += d.value
-		if len(self.where_clause):
+				if len(vars.where_clause):
+					vars.where_clause += " AND "
+				vars.where_clause += d.value
+		if len(vars.where_clause):
 			if self.partial:
-				self.where_clause = " AND ( " + self.where_clause + " ) "
+				vars.where_clause = " AND ( " + vars.where_clause + " ) "
 			else:
-				self.where_clause = " WHERE " + self.where_clause + " "
+				vars.where_clause = " WHERE " + vars.where_clause + " "
 		else:
 			self.ShowMessage("No selection")
 			return
@@ -2383,13 +2392,13 @@ class MainWindow(QMainWindow):
 		CallGraphWindow(self.glb, self)
 
 	def NewBranchView(self, event_id):
-		BranchWindow(self.glb, event_id, "", "", self)
+		BranchWindow(self.glb, event_id, "", ReportVars(), self)
 
 	def NewSelectedBranchView(self, event_id):
 		dialog = SelectedBranchDialog(self.glb, self)
 		ret = dialog.exec_()
 		if ret:
-			BranchWindow(self.glb, event_id, dialog.name, dialog.where_clause, self)
+			BranchWindow(self.glb, event_id, dialog.name, dialog.report_vars, self)
 
 	def NewTableView(self, table_name):
 		TableWindow(self.glb, table_name, self)
-- 
2.20.1
