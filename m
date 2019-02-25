From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/37] perf scripts python: exported-sql-viewer.py: Factor out ReportDialogBase
Date: Mon, 25 Feb 2019 18:20:06 -0300
Message-ID: <20190225212035.24781-9-acme@kernel.org>
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

Factor out ReportDialogBase so it can be re-used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 47 ++++++++++++-------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 7bd5263d3f39..d3ffb3e9d1fc 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1693,34 +1693,25 @@ class SQLTableDialogDataItem():
 			return False
 		return True
 
-# Selected branch report creation dialog
+# Report Dialog Base
 
-class SelectedBranchDialog(QDialog):
+class ReportDialogBase(QDialog):
 
-	def __init__(self, glb, parent=None):
-		super(SelectedBranchDialog, self).__init__(parent)
+	def __init__(self, glb, title, items, partial, parent=None):
+		super(ReportDialogBase, self).__init__(parent)
 
 		self.glb = glb
 
 		self.name = ""
 		self.where_clause = ""
 
-		self.setWindowTitle("Selected Branches")
+		self.setWindowTitle(title)
 		self.setMinimumWidth(600)
 
-		items = (
-			("Report name:", "Enter a name to appear in the window title bar", "", "", "", ""),
-			("Time ranges:", "Enter time ranges", "<timeranges>", "", "samples.id", ""),
-			("CPUs:", "Enter CPUs or ranges e.g. 0,5-6", "<ranges>", "", "cpu", ""),
-			("Commands:", "Only branches with these commands will be included", "comms", "comm", "comm_id", ""),
-			("PIDs:", "Only branches with these process IDs will be included", "threads", "pid", "thread_id", ""),
-			("TIDs:", "Only branches with these thread IDs will be included", "threads", "tid", "thread_id", ""),
-			("DSOs:", "Only branches with these DSOs will be included", "dsos", "short_name", "samples.dso_id", "to_dso_id"),
-			("Symbols:", "Only branches with these symbols will be included", "symbols", "name", "symbol_id", "to_symbol_id"),
-			("Raw SQL clause: ", "Enter a raw SQL WHERE clause", "", "", "", ""),
-			)
 		self.data_items = [SQLTableDialogDataItem(glb, *x, parent=self) for x in items]
 
+		self.partial = partial
+
 		self.grid = QGridLayout()
 
 		for row in xrange(len(self.data_items)):
@@ -1764,7 +1755,10 @@ class SelectedBranchDialog(QDialog):
 					self.where_clause += " AND "
 				self.where_clause += d.value
 		if len(self.where_clause):
-			self.where_clause = " AND ( " + self.where_clause + " ) "
+			if self.partial:
+				self.where_clause = " AND ( " + self.where_clause + " ) "
+			else:
+				self.where_clause = " WHERE " + self.where_clause + " "
 		else:
 			self.ShowMessage("No selection")
 			return
@@ -1776,6 +1770,25 @@ class SelectedBranchDialog(QDialog):
 	def ClearMessage(self):
 		self.status.setText("")
 
+# Selected branch report creation dialog
+
+class SelectedBranchDialog(ReportDialogBase):
+
+	def __init__(self, glb, parent=None):
+		title = "Selected Branches"
+		items = (
+			("Report name:", "Enter a name to appear in the window title bar", "", "", "", ""),
+			("Time ranges:", "Enter time ranges", "<timeranges>", "", "samples.id", ""),
+			("CPUs:", "Enter CPUs or ranges e.g. 0,5-6", "<ranges>", "", "cpu", ""),
+			("Commands:", "Only branches with these commands will be included", "comms", "comm", "comm_id", ""),
+			("PIDs:", "Only branches with these process IDs will be included", "threads", "pid", "thread_id", ""),
+			("TIDs:", "Only branches with these thread IDs will be included", "threads", "tid", "thread_id", ""),
+			("DSOs:", "Only branches with these DSOs will be included", "dsos", "short_name", "samples.dso_id", "to_dso_id"),
+			("Symbols:", "Only branches with these symbols will be included", "symbols", "name", "symbol_id", "to_symbol_id"),
+			("Raw SQL clause: ", "Enter a raw SQL WHERE clause", "", "", "", ""),
+			)
+		super(SelectedBranchDialog, self).__init__(glb, title, items, True, parent)
+
 # Event list
 
 def GetEventList(db):
-- 
2.20.1
