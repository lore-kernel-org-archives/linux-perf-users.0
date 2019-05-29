From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/41] perf scripts python: exported-sql-viewer.py: Use argparse module for argument parsing
Date: Wed, 29 May 2019 10:36:00 -0300
Message-ID: <20190529133605.21118-37-acme@kernel.org>
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

The argparse module makes it easier to add new arguments.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 9ff92a130655..498b79454012 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -91,6 +91,7 @@
 from __future__ import print_function
 
 import sys
+import argparse
 import weakref
 import threading
 import string
@@ -3361,18 +3362,26 @@ class DBRef():
 # Main
 
 def Main():
-	if (len(sys.argv) < 2):
-		printerr("Usage is: exported-sql-viewer.py {<database name> | --help-only}");
-		raise Exception("Too few arguments")
-
-	dbname = sys.argv[1]
-	if dbname == "--help-only":
+	usage_str =	"exported-sql-viewer.py [--pyside-version-1] <database name>\n" \
+			"   or: exported-sql-viewer.py --help-only"
+	ap = argparse.ArgumentParser(usage = usage_str, add_help = False)
+	ap.add_argument("dbname", nargs="?")
+	ap.add_argument("--help-only", action='store_true')
+	args = ap.parse_args()
+
+	if args.help_only:
 		app = QApplication(sys.argv)
 		mainwindow = HelpOnlyWindow()
 		mainwindow.show()
 		err = app.exec_()
 		sys.exit(err)
 
+	dbname = args.dbname
+	if dbname is None:
+		ap.print_usage()
+		print("Too few arguments")
+		sys.exit(1)
+
 	is_sqlite3 = False
 	try:
 		f = open(dbname, "rb")
-- 
2.20.1
