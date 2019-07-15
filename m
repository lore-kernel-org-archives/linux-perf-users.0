From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/28] perf scripts python: export-to-postgresql.py: Export comm details
Date: Mon, 15 Jul 2019 18:11:45 -0300
Message-ID: <20190715211200.10984-14-acme@kernel.org>
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
Link: http://lkml.kernel.org/r/20190710085810.1650-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 92713d93e956..01f37877f5bb 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -353,7 +353,10 @@ do_query(query, 'CREATE TABLE threads ('
 		'tid		integer)')
 do_query(query, 'CREATE TABLE comms ('
 		'id		bigint		NOT NULL,'
-		'comm		varchar(16))')
+		'comm		varchar(16),'
+		'c_thread_id	bigint,'
+		'c_time		bigint,'
+		'exec_flag	boolean)')
 do_query(query, 'CREATE TABLE comm_threads ('
 		'id		bigint		NOT NULL,'
 		'comm_id	bigint,'
@@ -763,7 +766,7 @@ def trace_begin():
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
 	thread_table(0, 0, 0, -1, -1)
-	comm_table(0, "unknown")
+	comm_table(0, "unknown", 0, 0, 0)
 	dso_table(0, 0, "unknown", "unknown", "")
 	symbol_table(0, 0, 0, 0, 0, "unknown")
 	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
@@ -851,6 +854,8 @@ def trace_end():
 	do_query(query, 'ALTER TABLE threads '
 					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
 					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
+	do_query(query, 'ALTER TABLE comms '
+					'ADD CONSTRAINT threadfk   FOREIGN KEY (c_thread_id)  REFERENCES threads    (id)')
 	do_query(query, 'ALTER TABLE comm_threads '
 					'ADD CONSTRAINT commfk     FOREIGN KEY (comm_id)      REFERENCES comms      (id),'
 					'ADD CONSTRAINT threadfk   FOREIGN KEY (thread_id)    REFERENCES threads    (id)')
@@ -935,11 +940,11 @@ def thread_table(thread_id, machine_id, process_id, pid, tid, *x):
 	value = struct.pack("!hiqiqiqiiii", 5, 8, thread_id, 8, machine_id, 8, process_id, 4, pid, 4, tid)
 	thread_file.write(value)
 
-def comm_table(comm_id, comm_str, *x):
+def comm_table(comm_id, comm_str, thread_id, time, exec_flag, *x):
 	comm_str = toserverstr(comm_str)
 	n = len(comm_str)
-	fmt = "!hiqi" + str(n) + "s"
-	value = struct.pack(fmt, 2, 8, comm_id, n, comm_str)
+	fmt = "!hiqi" + str(n) + "s" + "iqiqiB"
+	value = struct.pack(fmt, 5, 8, comm_id, n, comm_str, 8, thread_id, 8, time, 1, exec_flag)
 	comm_file.write(value)
 
 def comm_thread_table(comm_thread_id, comm_id, thread_id, *x):
-- 
2.21.0
