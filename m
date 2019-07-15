From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/28] perf db-export: Export comm details
Date: Mon, 15 Jul 2019 18:11:43 -0300
Message-ID: <20190715211200.10984-12-acme@kernel.org>
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

In preparation for exporting the current comm for a thread, export comm
thread id, start time and exec flag.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c                            | 2 +-
 tools/perf/util/db-export.h                            | 3 ++-
 tools/perf/util/scripting-engines/trace-event-python.c | 8 ++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 2c3a4ad68428..b0504d3eb130 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -95,7 +95,7 @@ int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
 	comm->db_id = ++dbe->comm_last_db_id;
 
 	if (dbe->export_comm) {
-		err = dbe->export_comm(dbe, comm);
+		err = dbe->export_comm(dbe, comm, main_thread);
 		if (err)
 			return err;
 	}
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 811a678a910d..29f7c3b035a7 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -43,7 +43,8 @@ struct db_export {
 	int (*export_machine)(struct db_export *dbe, struct machine *machine);
 	int (*export_thread)(struct db_export *dbe, struct thread *thread,
 			     u64 main_thread_db_id, struct machine *machine);
-	int (*export_comm)(struct db_export *dbe, struct comm *comm);
+	int (*export_comm)(struct db_export *dbe, struct comm *comm,
+			   struct thread *thread);
 	int (*export_comm_thread)(struct db_export *dbe, u64 db_id,
 				  struct comm *comm, struct thread *thread);
 	int (*export_dso)(struct db_export *dbe, struct dso *dso,
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c9837f0f0fd6..28167e938cef 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1011,15 +1011,19 @@ static int python_export_thread(struct db_export *dbe, struct thread *thread,
 	return 0;
 }
 
-static int python_export_comm(struct db_export *dbe, struct comm *comm)
+static int python_export_comm(struct db_export *dbe, struct comm *comm,
+			      struct thread *thread)
 {
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;
 
-	t = tuple_new(2);
+	t = tuple_new(5);
 
 	tuple_set_u64(t, 0, comm->db_id);
 	tuple_set_string(t, 1, comm__str(comm));
+	tuple_set_u64(t, 2, thread->db_id);
+	tuple_set_u64(t, 3, comm->start);
+	tuple_set_s32(t, 4, comm->exec);
 
 	call_object(tables->comm_handler, t, "comm_table");
 
-- 
2.21.0
