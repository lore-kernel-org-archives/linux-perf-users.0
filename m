From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/85] perf db-export: Add brief documentation
Date: Tue, 11 Jun 2019 15:58:03 -0300
Message-ID: <20190611185911.11645-18-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add brief documentation to explain how the database export maintains
backward and forward compatibility.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-15-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/db-export.txt | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 tools/perf/Documentation/db-export.txt

diff --git a/tools/perf/Documentation/db-export.txt b/tools/perf/Documentation/db-export.txt
new file mode 100644
index 000000000000..52ffccb02d55
--- /dev/null
+++ b/tools/perf/Documentation/db-export.txt
@@ -0,0 +1,41 @@
+Database Export
+===============
+
+perf tool's python scripting engine:
+
+	tools/perf/util/scripting-engines/trace-event-python.c
+
+supports scripts:
+
+	tools/perf/scripts/python/export-to-sqlite.py
+	tools/perf/scripts/python/export-to-postgresql.py
+
+which export data to a SQLite3 or PostgreSQL database.
+
+The export process provides records with unique sequential ids which allows the
+data to be imported directly to a database and provides the relationships
+between tables.
+
+Over time it is possible to continue to expand the export while maintaining
+backward and forward compatibility, by following some simple rules:
+
+1. Because of the nature of SQL, existing tables and columns can continue to be
+used so long as the names and meanings (and to some extent data types) remain
+the same.
+
+2. New tables and columns can be added, without affecting existing SQL queries,
+so long as the new names are unique.
+
+3. Scripts that use a database (e.g. exported-sql-viewer.py) can maintain
+backward compatibility by testing for the presence of new tables and columns
+before using them. e.g. function IsSelectable() in exported-sql-viewer.py
+
+4. The export scripts themselves maintain forward compatibility (i.e. an existing
+script will continue to work with new versions of perf) by accepting a variable
+number of arguments (e.g. def call_return_table(*x)) i.e. perf can pass more
+arguments which old scripts will ignore.
+
+5. The scripting engine tests for the existence of script handler functions
+before calling them.  The scripting engine can also test for the support of new
+or optional features by checking for the existence and value of script global
+variables.
-- 
2.20.1
