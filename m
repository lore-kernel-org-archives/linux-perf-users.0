From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/28] perf db-export: Factor out db_export__threads()
Date: Mon, 15 Jul 2019 18:11:53 -0300
Message-ID: <20190715211200.10984-22-acme@kernel.org>
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

In preparation for exporting switch events, factor out
db_export__threads().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-19-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 82 ++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 5057fdd7f62d..e6a9c450133e 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -286,50 +286,32 @@ int db_export__branch_type(struct db_export *dbe, u32 branch_type,
 	return 0;
 }
 
-int db_export__sample(struct db_export *dbe, union perf_event *event,
-		      struct perf_sample *sample, struct perf_evsel *evsel,
-		      struct addr_location *al)
+static int db_export__threads(struct db_export *dbe, struct thread *thread,
+			      struct thread *main_thread,
+			      struct machine *machine, struct comm **comm_ptr)
 {
-	struct thread *thread = al->thread;
-	struct export_sample es = {
-		.event = event,
-		.sample = sample,
-		.evsel = evsel,
-		.al = al,
-	};
-	struct thread *main_thread;
 	struct comm *comm = NULL;
 	struct comm *curr_comm;
 	int err;
 
-	err = db_export__evsel(dbe, evsel);
-	if (err)
-		return err;
-
-	err = db_export__machine(dbe, al->machine);
-	if (err)
-		return err;
-
-	main_thread = thread__main_thread(al->machine, thread);
 	if (main_thread) {
 		/*
 		 * A thread has a reference to the main thread, so export the
 		 * main thread first.
 		 */
-		err = db_export__thread(dbe, main_thread, al->machine,
-					main_thread);
+		err = db_export__thread(dbe, main_thread, machine, main_thread);
 		if (err)
-			goto out_put;
+			return err;
 		/*
 		 * Export comm before exporting the non-main thread because
 		 * db_export__comm_thread() can be called further below.
 		 */
-		comm = machine__thread_exec_comm(al->machine, main_thread);
+		comm = machine__thread_exec_comm(machine, main_thread);
 		if (comm) {
 			err = db_export__exec_comm(dbe, comm, main_thread);
 			if (err)
-				goto out_put;
-			es.comm_db_id = comm->db_id;
+				return err;
+			*comm_ptr = comm;
 		}
 	}
 
@@ -340,23 +322,55 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		 */
 		bool export_comm_thread = comm && !thread->db_id;
 
-		err = db_export__thread(dbe, thread, al->machine, main_thread);
+		err = db_export__thread(dbe, thread, machine, main_thread);
 		if (err)
-			goto out_put;
+			return err;
 
 		if (export_comm_thread) {
 			err = db_export__comm_thread(dbe, comm, thread);
 			if (err)
-				goto out_put;
+				return err;
 		}
 	}
 
 	curr_comm = thread__comm(thread);
-	if (curr_comm) {
-		err = db_export__comm(dbe, curr_comm, thread);
-		if (err)
-			goto out_put;
-	}
+	if (curr_comm)
+		return db_export__comm(dbe, curr_comm, thread);
+
+	return 0;
+}
+
+int db_export__sample(struct db_export *dbe, union perf_event *event,
+		      struct perf_sample *sample, struct perf_evsel *evsel,
+		      struct addr_location *al)
+{
+	struct thread *thread = al->thread;
+	struct export_sample es = {
+		.event = event,
+		.sample = sample,
+		.evsel = evsel,
+		.al = al,
+	};
+	struct thread *main_thread;
+	struct comm *comm = NULL;
+	int err;
+
+	err = db_export__evsel(dbe, evsel);
+	if (err)
+		return err;
+
+	err = db_export__machine(dbe, al->machine);
+	if (err)
+		return err;
+
+	main_thread = thread__main_thread(al->machine, thread);
+
+	err = db_export__threads(dbe, thread, main_thread, al->machine, &comm);
+	if (err)
+		goto out_put;
+
+	if (comm)
+		es.comm_db_id = comm->db_id;
 
 	es.db_id = ++dbe->sample_last_db_id;
 
-- 
2.21.0
