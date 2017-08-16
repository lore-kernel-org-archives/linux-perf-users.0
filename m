From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/10] perf script python: Add support for sqlite3 to call-graph-from-sql.py
Date: Wed, 16 Aug 2017 17:20:48 -0300
Message-ID: <20170816202050.8865-9-acme@kernel.org>
References: <20170816202050.8865-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816202050.8865-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add support for SQLite 3 to the call-graph-from-sql.py script. The SQL
statements work as is, so just detect the database type by checking if the
SQLite 3 file exists.

Committer notes:

Tested collecting the PT data on a RHEL7.4, generating the SQLite3
database there and then moving it to a Fedora 26 system where the
call-graph-from-sql.py script was run, using python-pyside version
1.2.2-7fc26 to see the callgraphs using Qt4.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lkml.kernel.org/r/1501749090-20357-6-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 60 ++++++++++++++----------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index f18406d3faf7..b494a67a1c67 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -1,5 +1,5 @@
 #!/usr/bin/python2
-# call-graph-from-sql.py: create call-graph from postgresql database
+# call-graph-from-sql.py: create call-graph from sql database
 # Copyright (c) 2014-2017, Intel Corporation.
 #
 # This program is free software; you can redistribute it and/or modify it
@@ -11,16 +11,17 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
-# To use this script you will need to have exported data using the
-# export-to-postgresql.py script.  Refer to that script for details.
+# To use this script you will need to have exported data using either the
+# export-to-sqlite.py or the export-to-postgresql.py script.  Refer to those
+# scripts for details.
 #
-# Following on from the example in the export-to-postgresql.py script, a
+# Following on from the example in the export scripts, a
 # call-graph can be displayed for the pt_example database like this:
 #
 #	python tools/perf/scripts/python/call-graph-from-sql.py pt_example
 #
-# Note this script supports connecting to remote databases by setting hostname,
-# port, username, password, and dbname e.g.
+# Note that for PostgreSQL, this script supports connecting to remote databases
+# by setting hostname, port, username, password, and dbname e.g.
 #
 #	python tools/perf/scripts/python/call-graph-from-sql.py "hostname=myhost username=myuser password=mypassword dbname=pt_example"
 #
@@ -296,24 +297,35 @@ if __name__ == '__main__':
 
 	dbname = sys.argv[1]
 
-	db = QSqlDatabase.addDatabase('QPSQL')
-
-	opts = dbname.split()
-	for opt in opts:
-		if '=' in opt:
-			opt = opt.split('=')
-			if opt[0] == 'hostname':
-				db.setHostName(opt[1])
-			elif opt[0] == 'port':
-				db.setPort(int(opt[1]))
-			elif opt[0] == 'username':
-				db.setUserName(opt[1])
-			elif opt[0] == 'password':
-				db.setPassword(opt[1])
-			elif opt[0] == 'dbname':
-				dbname = opt[1]
-		else:
-			dbname = opt
+	is_sqlite3 = False
+	try:
+		f = open(dbname)
+		if f.read(15) == "SQLite format 3":
+			is_sqlite3 = True
+		f.close()
+	except:
+		pass
+
+	if is_sqlite3:
+		db = QSqlDatabase.addDatabase('QSQLITE')
+	else:
+		db = QSqlDatabase.addDatabase('QPSQL')
+		opts = dbname.split()
+		for opt in opts:
+			if '=' in opt:
+				opt = opt.split('=')
+				if opt[0] == 'hostname':
+					db.setHostName(opt[1])
+				elif opt[0] == 'port':
+					db.setPort(int(opt[1]))
+				elif opt[0] == 'username':
+					db.setUserName(opt[1])
+				elif opt[0] == 'password':
+					db.setPassword(opt[1])
+				elif opt[0] == 'dbname':
+					dbname = opt[1]
+			else:
+				dbname = opt
 
 	db.setDatabaseName(dbname)
 	if not db.open():
-- 
2.13.5
