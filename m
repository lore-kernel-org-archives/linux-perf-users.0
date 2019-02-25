From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/37] perf scripts python: exported-sql-viewer.py: Move report name into ReportVars
Date: Mon, 25 Feb 2019 18:20:08 -0300
Message-ID: <20190225212035.24781-11-acme@kernel.org>
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

The report name is a report variable so move it into into ReportVars.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 03428df8ddd5..ed39a0153dd3 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1402,7 +1402,8 @@ class BranchModel(TreeModel):
 
 class ReportVars():
 
-	def __init__(self, where_clause = ""):
+	def __init__(self, name = "", where_clause = ""):
+		self.name = name
 		self.where_clause = where_clause
 
 	def UniqueId(self):
@@ -1412,7 +1413,7 @@ class ReportVars():
 
 class BranchWindow(QMdiSubWindow):
 
-	def __init__(self, glb, event_id, name, report_vars, parent=None):
+	def __init__(self, glb, event_id, report_vars, parent=None):
 		super(BranchWindow, self).__init__(parent)
 
 		model_name = "Branch Events " + str(event_id) +  " " + report_vars.UniqueId()
@@ -1435,7 +1436,7 @@ class BranchWindow(QMdiSubWindow):
 
 		self.setWidget(self.vbox.Widget())
 
-		AddSubWindow(glb.mainwindow.mdi_area, self, name + " Branch Events")
+		AddSubWindow(glb.mainwindow.mdi_area, self, report_vars.name + " Branch Events")
 
 	def ResizeColumnToContents(self, column, n):
 		# Using the view's resizeColumnToContents() here is extrememly slow
@@ -1710,7 +1711,6 @@ class ReportDialogBase(QDialog):
 
 		self.glb = glb
 
-		self.name = ""
 		self.report_vars = ReportVars()
 
 		self.setWindowTitle(title)
@@ -1751,8 +1751,8 @@ class ReportDialogBase(QDialog):
 
 	def Ok(self):
 		vars = self.report_vars
-		self.name = self.data_items[0].value
-		if not self.name:
+		vars.name = self.data_items[0].value
+		if not vars.name:
 			self.ShowMessage("Report name is required")
 			return
 		for d in self.data_items:
@@ -2392,13 +2392,13 @@ class MainWindow(QMainWindow):
 		CallGraphWindow(self.glb, self)
 
 	def NewBranchView(self, event_id):
-		BranchWindow(self.glb, event_id, "", ReportVars(), self)
+		BranchWindow(self.glb, event_id, ReportVars(), self)
 
 	def NewSelectedBranchView(self, event_id):
 		dialog = SelectedBranchDialog(self.glb, self)
 		ret = dialog.exec_()
 		if ret:
-			BranchWindow(self.glb, event_id, dialog.name, dialog.report_vars, self)
+			BranchWindow(self.glb, event_id, dialog.report_vars, self)
 
 	def NewTableView(self, table_name):
 		TableWindow(self.glb, table_name, self)
-- 
2.20.1
