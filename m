From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/41] perf scripts python: export-to-postgresql.py: Add support for pyside2
Date: Wed, 29 May 2019 10:36:03 -0300
Message-ID: <20190529133605.21118-40-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

pyside2 is the future for pyside support.

Note pyside use Qt4 whereas pyside2 uses Qt5.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/export-to-postgresql.py    | 43 +++++++++++++++----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index c3eae1d77d36..b2f481b0d28d 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -27,18 +27,31 @@ import datetime
 #
 # fedora:
 #
-#	$ sudo yum install postgresql postgresql-server python-pyside qt-postgresql
+#	$ sudo yum install postgresql postgresql-server qt-postgresql
 #	$ sudo su - postgres -c initdb
 #	$ sudo service postgresql start
 #	$ sudo su - postgres
-#	$ createuser <your user id here>
+#	$ createuser -s <your user id here>    # Older versions may not support -s, in which case answer the prompt below:
 #	Shall the new role be a superuser? (y/n) y
+#	$ sudo yum install python-pyside
+#
+#	Alternately, to use Python3 and/or pyside 2, one of the following:
+#		$ sudo yum install python3-pyside
+#		$ pip install --user PySide2
+#		$ pip3 install --user PySide2
 #
 # ubuntu:
 #
-#	$ sudo apt-get install postgresql python-pyside.qtsql libqt4-sql-psql
+#	$ sudo apt-get install postgresql
 #	$ sudo su - postgres
 #	$ createuser -s <your user id here>
+#	$ sudo apt-get install python-pyside.qtsql libqt4-sql-psql
+#
+#	Alternately, to use Python3 and/or pyside 2, one of the following:
+#
+#		$ sudo apt-get install python3-pyside.qtsql libqt4-sql-psql
+#		$ sudo apt-get install python-pyside2.qtsql libqt5sql5-psql
+#		$ sudo apt-get install python3-pyside2.qtsql libqt5sql5-psql
 #
 # An example of using this script with Intel PT:
 #
@@ -199,7 +212,16 @@ import datetime
 #                   print "{0:>6}  {1:>10}  {2:>9}  {3:<30}  {4:>6}  {5:<30}".format(query.value(0), query.value(1), query.value(2), query.value(3), query.value(4), query.value(5))
 #                   call_path_id = query.value(6)
 
-from PySide.QtSql import *
+pyside_version_1 = True
+if not "pyside-version-1" in sys.argv:
+	try:
+		from PySide2.QtSql import *
+		pyside_version_1 = False
+	except:
+		pass
+
+if pyside_version_1:
+	from PySide.QtSql import *
 
 if sys.version_info < (3, 0):
 	def toserverstr(str):
@@ -255,11 +277,12 @@ def printdate(*args, **kw_args):
         print(datetime.datetime.today(), *args, sep=' ', **kw_args)
 
 def usage():
-	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]")
-	printerr("where:	columns		'all' or 'branches'")
-	printerr("		calls		'calls' => create calls and call_paths table")
-	printerr("		callchains	'callchains' => create call_paths table")
-	raise Exception("Too few arguments")
+	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>] [<pyside-version-1>]");
+	printerr("where:  columns            'all' or 'branches'");
+	printerr("        calls              'calls' => create calls and call_paths table");
+	printerr("        callchains         'callchains' => create call_paths table");
+	printerr("        pyside-version-1   'pyside-version-1' => use pyside version 1");
+	raise Exception("Too few or bad arguments")
 
 if (len(sys.argv) < 2):
 	usage()
@@ -281,6 +304,8 @@ for i in range(3,len(sys.argv)):
 		perf_db_export_calls = True
 	elif (sys.argv[i] == "callchains"):
 		perf_db_export_callchains = True
+	elif (sys.argv[i] == "pyside-version-1"):
+		pass
 	else:
 		usage()
 
-- 
2.20.1
