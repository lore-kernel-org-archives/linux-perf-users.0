From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/28] perf scripts python: export-to-sqlite.py: Export comm details
Date: Mon, 15 Jul 2019 18:11:44 -0300
Message-ID: <20190715211200.10984-13-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add table columns for thread id, comm start time and exec flag.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 021326c46285..97aa66dd2fe1 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -177,7 +177,10 @@ do_query(query, 'CREATE TABLE threads ('
 		'tid		integer)')
 do_query(query, 'CREATE TABLE comms ('
 		'id		integer		NOT NULL	PRIMARY KEY,'
-		'comm		varchar(16))')
+		'comm		varchar(16),'
+		'c_thread_id	bigint,'
+		'c_time		bigint,'
+		'exec_flag	boolean)')
 do_query(query, 'CREATE TABLE comm_threads ('
 		'id		integer		NOT NULL	PRIMARY KEY,'
 		'comm_id	bigint,'
@@ -536,7 +539,7 @@ machine_query.prepare("INSERT INTO machines VALUES (?, ?, ?)")
 thread_query = QSqlQuery(db)
 thread_query.prepare("INSERT INTO threads VALUES (?, ?, ?, ?, ?)")
 comm_query = QSqlQuery(db)
-comm_query.prepare("INSERT INTO comms VALUES (?, ?)")
+comm_query.prepare("INSERT INTO comms VALUES (?, ?, ?, ?, ?)")
 comm_thread_query = QSqlQuery(db)
 comm_thread_query.prepare("INSERT INTO comm_threads VALUES (?, ?, ?)")
 dso_query = QSqlQuery(db)
@@ -576,7 +579,7 @@ def trace_begin():
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
 	thread_table(0, 0, 0, -1, -1)
-	comm_table(0, "unknown")
+	comm_table(0, "unknown", 0, 0, 0)
 	dso_table(0, 0, "unknown", "unknown", "")
 	symbol_table(0, 0, 0, 0, 0, "unknown")
 	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
@@ -642,7 +645,7 @@ def thread_table(*x):
 	bind_exec(thread_query, 5, x)
 
 def comm_table(*x):
-	bind_exec(comm_query, 2, x)
+	bind_exec(comm_query, 5, x)
 
 def comm_thread_table(*x):
 	bind_exec(comm_thread_query, 3, x)
-- 
2.21.0
