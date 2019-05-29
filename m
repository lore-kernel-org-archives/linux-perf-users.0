From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/41] perf scripts python: exported-sql-viewer.py: Add support for pyside2
Date: Wed, 29 May 2019 10:36:01 -0300
Message-ID: <20190529133605.21118-38-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

pyside2 is the future for pyside support.

Note pyside use Qt4 whereas pyside2 uses Qt5.

Committer testing:

On a system with just:

  # rpm -qa| grep -i pyside
  python2-pyside-1.2.4-7.fc29.x86_64
  #

Running:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db &
  [1] 7438

Makes it use the pyside 1 files:

  $ grep -i pyside /proc/7438/maps | cut -d ' ' -f 6- | sort -u
     /usr/lib64/libpyside-python2.7.so.1.2.4
     /usr/lib64/python2.7/site-packages/PySide/QtCore.so
     /usr/lib64/python2.7/site-packages/PySide/QtGui.so
     /usr/lib64/python2.7/site-packages/PySide/QtSql.so
  $ rpm -qf /usr/lib64/libpyside-python2.7.so.1.2.4
  python2-pyside-1.2.4-7.fc29.x86_64
  $

To get PySide2 I guess one needs to do:

  $ pip install PySide2

But thats a 142MiB download I can't do right now, perhaps before pushing
upstream...

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 498b79454012..6fe553258ce5 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -105,10 +105,23 @@ except ImportError:
 	glb_nsz = 16
 import re
 import os
-from PySide.QtCore import *
-from PySide.QtGui import *
-from PySide.QtSql import *
+
 pyside_version_1 = True
+if not "--pyside-version-1" in sys.argv:
+	try:
+		from PySide2.QtCore import *
+		from PySide2.QtGui import *
+		from PySide2.QtSql import *
+		from PySide2.QtWidgets import *
+		pyside_version_1 = False
+	except:
+		pass
+
+if pyside_version_1:
+	from PySide.QtCore import *
+	from PySide.QtGui import *
+	from PySide.QtSql import *
+
 from decimal import *
 from ctypes import *
 from multiprocessing import Process, Array, Value, Event
@@ -2755,7 +2768,7 @@ class WindowMenu():
 			action = self.window_menu.addAction(label)
 			action.setCheckable(True)
 			action.setChecked(sub_window == self.mdi_area.activeSubWindow())
-			action.triggered.connect(lambda x=nr: self.setActiveSubWindow(x))
+			action.triggered.connect(lambda a=None,x=nr: self.setActiveSubWindow(x))
 			self.window_menu.addAction(action)
 			nr += 1
 
@@ -3115,14 +3128,14 @@ class MainWindow(QMainWindow):
 			event = event.split(":")[0]
 			if event == "branches":
 				label = "All branches" if branches_events == 1 else "All branches " + "(id=" + dbid + ")"
-				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda x=dbid: self.NewBranchView(x), self))
+				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda a=None,x=dbid: self.NewBranchView(x), self))
 				label = "Selected branches" if branches_events == 1 else "Selected branches " + "(id=" + dbid + ")"
-				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda x=dbid: self.NewSelectedBranchView(x), self))
+				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda a=None,x=dbid: self.NewSelectedBranchView(x), self))
 
 	def TableMenu(self, tables, menu):
 		table_menu = menu.addMenu("&Tables")
 		for table in tables:
-			table_menu.addAction(CreateAction(table, "Create a new window containing a table view", lambda t=table: self.NewTableView(t), self))
+			table_menu.addAction(CreateAction(table, "Create a new window containing a table view", lambda a=None,t=table: self.NewTableView(t), self))
 
 	def NewCallGraph(self):
 		CallGraphWindow(self.glb, self)
@@ -3365,6 +3378,7 @@ def Main():
 	usage_str =	"exported-sql-viewer.py [--pyside-version-1] <database name>\n" \
 			"   or: exported-sql-viewer.py --help-only"
 	ap = argparse.ArgumentParser(usage = usage_str, add_help = False)
+	ap.add_argument("--pyside-version-1", action='store_true')
 	ap.add_argument("dbname", nargs="?")
 	ap.add_argument("--help-only", action='store_true')
 	args = ap.parse_args()
-- 
2.20.1
