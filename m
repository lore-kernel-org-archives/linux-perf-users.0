From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/37] perf scripts python: call-graph-from-sql.py: Separate the database details into a class
Date: Thu, 25 Oct 2018 08:10:15 -0300
Message-ID: <20181025111031.3440-22-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Separate the database details into a class that can provide different
connections using the same connection information.  That paves the way
for sub-processes that require their own connection.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 63 ++++++++++++++----------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index 2b74b94eeccc..9d056deab2b1 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -284,6 +284,42 @@ class MainWindow(QMainWindow):
 
 		self.setCentralWidget(self.view)
 
+# Database reference
+
+class DBRef():
+
+	def __init__(self, is_sqlite3, dbname):
+		self.is_sqlite3 = is_sqlite3
+		self.dbname = dbname
+
+	def Open(self, connection_name):
+		dbname = self.dbname
+		if self.is_sqlite3:
+			db = QSqlDatabase.addDatabase("QSQLITE", connection_name)
+		else:
+			db = QSqlDatabase.addDatabase("QPSQL", connection_name)
+			opts = dbname.split()
+			for opt in opts:
+				if "=" in opt:
+					opt = opt.split("=")
+					if opt[0] == "hostname":
+						db.setHostName(opt[1])
+					elif opt[0] == "port":
+						db.setPort(int(opt[1]))
+					elif opt[0] == "username":
+						db.setUserName(opt[1])
+					elif opt[0] == "password":
+						db.setPassword(opt[1])
+					elif opt[0] == "dbname":
+						dbname = opt[1]
+				else:
+					dbname = opt
+
+		db.setDatabaseName(dbname)
+		if not db.open():
+			raise Exception("Failed to open database " + dbname + " error: " + db.lastError().text())
+		return db, dbname
+
 # Main
 
 def Main():
@@ -302,31 +338,8 @@ def Main():
 	except:
 		pass
 
-	if is_sqlite3:
-		db = QSqlDatabase.addDatabase('QSQLITE')
-	else:
-		db = QSqlDatabase.addDatabase('QPSQL')
-		opts = dbname.split()
-		for opt in opts:
-			if '=' in opt:
-				opt = opt.split('=')
-				if opt[0] == 'hostname':
-					db.setHostName(opt[1])
-				elif opt[0] == 'port':
-					db.setPort(int(opt[1]))
-				elif opt[0] == 'username':
-					db.setUserName(opt[1])
-				elif opt[0] == 'password':
-					db.setPassword(opt[1])
-				elif opt[0] == 'dbname':
-					dbname = opt[1]
-			else:
-				dbname = opt
-
-	db.setDatabaseName(dbname)
-	if not db.open():
-		raise Exception("Failed to open database " + dbname + " error: " + db.lastError().text())
-
+	dbref = DBRef(is_sqlite3, dbname)
+	db, dbname = dbref.Open("main")
 	app = QApplication(sys.argv)
 	window = MainWindow(db, dbname)
 	window.show()
-- 
2.14.4
