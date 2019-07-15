From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/28] perf db-export: Move export__comm_thread into db_export__sample()
Date: Mon, 15 Jul 2019 18:11:41 -0300
Message-ID: <20190715211200.10984-10-acme@kernel.org>
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

Move call to db_export__comm_thread() from db_export__thread() into
db_export__sample() because it makes the code easier to understand, and
add explanatory comments.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 35 +++++++++++++++++++++--------------
 tools/perf/util/db-export.h |  3 +--
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 99ad759561de..78f62a733b9d 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -59,25 +59,17 @@ int db_export__machine(struct db_export *dbe, struct machine *machine)
 }
 
 int db_export__thread(struct db_export *dbe, struct thread *thread,
-		      struct machine *machine, struct comm *comm,
-		      struct thread *main_thread)
+		      struct machine *machine, struct thread *main_thread)
 {
 	u64 main_thread_db_id = 0;
-	int err;
 
 	if (thread->db_id)
 		return 0;
 
 	thread->db_id = ++dbe->thread_last_db_id;
 
-	if (main_thread) {
-		if (main_thread != thread && comm) {
-			err = db_export__comm_thread(dbe, comm, thread);
-			if (err)
-				return err;
-		}
+	if (main_thread)
 		main_thread_db_id = main_thread->db_id;
-	}
 
 	if (dbe->export_thread)
 		return dbe->export_thread(dbe, thread, main_thread_db_id,
@@ -303,15 +295,19 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 
 	main_thread = thread__main_thread(al->machine, thread);
 	if (main_thread) {
-		comm = machine__thread_exec_comm(al->machine, main_thread);
 		/*
 		 * A thread has a reference to the main thread, so export the
 		 * main thread first.
 		 */
-		err = db_export__thread(dbe, main_thread, al->machine, comm,
+		err = db_export__thread(dbe, main_thread, al->machine,
 					main_thread);
 		if (err)
 			goto out_put;
+		/*
+		 * Export comm before exporting the non-main thread because
+		 * db_export__comm_thread() can be called further below.
+		 */
+		comm = machine__thread_exec_comm(al->machine, main_thread);
 		if (comm) {
 			err = db_export__exec_comm(dbe, comm, main_thread);
 			if (err)
@@ -321,10 +317,21 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	}
 
 	if (thread != main_thread) {
-		err = db_export__thread(dbe, thread, al->machine, comm,
-					main_thread);
+		/*
+		 * For a non-main thread, db_export__comm_thread() must be
+		 * called only if thread has not previously been exported.
+		 */
+		bool export_comm_thread = comm && !thread->db_id;
+
+		err = db_export__thread(dbe, thread, al->machine, main_thread);
 		if (err)
 			goto out_put;
+
+		if (export_comm_thread) {
+			err = db_export__comm_thread(dbe, comm, thread);
+			if (err)
+				goto out_put;
+		}
 	}
 
 	es.db_id = ++dbe->sample_last_db_id;
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 6e267321594c..811a678a910d 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -75,8 +75,7 @@ void db_export__exit(struct db_export *dbe);
 int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel);
 int db_export__machine(struct db_export *dbe, struct machine *machine);
 int db_export__thread(struct db_export *dbe, struct thread *thread,
-		      struct machine *machine, struct comm *comm,
-		      struct thread *main_thread);
+		      struct machine *machine, struct thread *main_thread);
 int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
 			 struct thread *main_thread);
 int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
-- 
2.21.0
