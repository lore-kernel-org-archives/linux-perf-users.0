From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/37] perf scripts python: exported-sql-viewer.py: Hide Call Graph option if no calls table
Date: Mon, 25 Feb 2019 18:20:04 -0300
Message-ID: <20190225212035.24781-7-acme@kernel.org>
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

The Call Graph depends on the calls table which is optional when exporting
data, so hide the Call Graph option if there is no calls table.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index c20b510ace8f..58a95241ff70 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1786,6 +1786,16 @@ def GetEventList(db):
 		events.append(query.value(0))
 	return events
 
+# Is a table selectable
+
+def IsSelectable(db, table):
+	query = QSqlQuery(db)
+	try:
+		QueryExec(query, "SELECT * FROM " + table + " LIMIT 1")
+	except:
+		return False
+	return True
+
 # SQL data preparation
 
 def SQLTableDataPrep(query, count):
@@ -2298,7 +2308,8 @@ class MainWindow(QMainWindow):
 		edit_menu.addAction(CreateAction("&Enlarge Font", "Make text bigger", self.EnlargeFont, self, [QKeySequence("Ctrl++")]))
 
 		reports_menu = menu.addMenu("&Reports")
-		reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
+		if IsSelectable(glb.db, "calls"):
+			reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
 
 		self.EventMenu(GetEventList(glb.db), reports_menu)
 
-- 
2.20.1
