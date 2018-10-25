From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/37] perf scripts python: call-graph-from-sql.py: Add a class for global data
Date: Thu, 25 Oct 2018 08:10:16 -0300
Message-ID: <20181025111031.3440-23-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Keep global data in a single object that is easy to pass around as
needed, without polluting the global namespace.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 26 +++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index 9d056deab2b1..0a4dc13d4818 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -264,17 +264,19 @@ class TreeModel(QAbstractItemModel):
 
 class MainWindow(QMainWindow):
 
-	def __init__(self, db, dbname, parent=None):
+	def __init__(self, glb, parent=None):
 		super(MainWindow, self).__init__(parent)
 
+		self.glb = glb
+
 		self.setObjectName("MainWindow")
-		self.setWindowTitle("Call Graph: " + dbname)
+		self.setWindowTitle("Call Graph: " + glb.dbname)
 		self.move(100, 100)
 		self.resize(800, 600)
 		self.setWindowIcon(self.style().standardIcon(QStyle.SP_ComputerIcon))
 		self.setMinimumSize(200, 100)
 
-		self.model = TreeModel(db)
+		self.model = TreeModel(glb.db)
 
 		self.view = QTreeView()
 		self.view.setModel(self.model)
@@ -284,6 +286,17 @@ class MainWindow(QMainWindow):
 
 		self.setCentralWidget(self.view)
 
+# Global data
+
+class Glb():
+
+	def __init__(self, dbref, db, dbname):
+		self.dbref = dbref
+		self.db = db
+		self.dbname = dbname
+		self.app = None
+		self.mainwindow = None
+
 # Database reference
 
 class DBRef():
@@ -340,9 +353,12 @@ def Main():
 
 	dbref = DBRef(is_sqlite3, dbname)
 	db, dbname = dbref.Open("main")
+	glb = Glb(dbref, db, dbname)
 	app = QApplication(sys.argv)
-	window = MainWindow(db, dbname)
-	window.show()
+	glb.app = app
+	mainwindow = MainWindow(glb)
+	glb.mainwindow = mainwindow
+	mainwindow.show()
 	err = app.exec_()
 	db.close()
 	sys.exit(err)
-- 
2.14.4
