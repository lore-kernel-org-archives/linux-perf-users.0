From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/28] perf db-export: Pass main_thread to db_export__thread()
Date: Mon, 15 Jul 2019 18:11:38 -0300
Message-ID: <20190715211200.10984-7-acme@kernel.org>
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

Calls to db_export__thread() already have main_thread so there is no
reason to get it again, instead pass it as a parameter. Note that one
difference in this approach is that the main thread is not created if it
does not exist. It is better if it is not created because:

   - If main_thread is being traced it will have been created already.

   - If it is not being traced, there will be no other information about
     it, and it will never get deleted because there will be no EXIT event.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 29 ++++++++---------------------
 tools/perf/util/db-export.h |  3 ++-
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 8fab57f90cbc..14501236c046 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -59,9 +59,9 @@ int db_export__machine(struct db_export *dbe, struct machine *machine)
 }
 
 int db_export__thread(struct db_export *dbe, struct thread *thread,
-		      struct machine *machine, struct comm *comm)
+		      struct machine *machine, struct comm *comm,
+		      struct thread *main_thread)
 {
-	struct thread *main_thread;
 	u64 main_thread_db_id = 0;
 	int err;
 
@@ -70,28 +70,19 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 
 	thread->db_id = ++dbe->thread_last_db_id;
 
-	if (thread->pid_ != -1) {
-		if (thread->pid_ == thread->tid) {
-			main_thread = thread;
-		} else {
-			main_thread = machine__findnew_thread(machine,
-							      thread->pid_,
-							      thread->pid_);
-			if (!main_thread)
-				return -ENOMEM;
+	if (main_thread) {
+		if (main_thread != thread) {
 			err = db_export__thread(dbe, main_thread, machine,
-						comm);
+						comm, main_thread);
 			if (err)
-				goto out_put;
+				return err;
 			if (comm) {
 				err = db_export__comm_thread(dbe, comm, thread);
 				if (err)
-					goto out_put;
+					return err;
 			}
 		}
 		main_thread_db_id = main_thread->db_id;
-		if (main_thread != thread)
-			thread__put(main_thread);
 	}
 
 	if (dbe->export_thread)
@@ -99,10 +90,6 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 					  machine);
 
 	return 0;
-
-out_put:
-	thread__put(main_thread);
-	return err;
 }
 
 /*
@@ -324,7 +311,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	if (main_thread)
 		comm = machine__thread_exec_comm(al->machine, main_thread);
 
-	err = db_export__thread(dbe, thread, al->machine, comm);
+	err = db_export__thread(dbe, thread, al->machine, comm, main_thread);
 	if (err)
 		goto out_put;
 
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 148a657b1887..6e267321594c 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -75,7 +75,8 @@ void db_export__exit(struct db_export *dbe);
 int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel);
 int db_export__machine(struct db_export *dbe, struct machine *machine);
 int db_export__thread(struct db_export *dbe, struct thread *thread,
-		      struct machine *machine, struct comm *comm);
+		      struct machine *machine, struct comm *comm,
+		      struct thread *main_thread);
 int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
 			 struct thread *main_thread);
 int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
-- 
2.21.0
