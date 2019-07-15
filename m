From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/28] perf db-export: Export main_thread in db_export__sample()
Date: Mon, 15 Jul 2019 18:11:39 -0300
Message-ID: <20190715211200.10984-8-acme@kernel.org>
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

Export main_thread in db_export__sample() because it makes the code
easier to understand, and prepares db_export__thread() for further
simplification.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 14501236c046..63f9edf65eee 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -71,16 +71,10 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 	thread->db_id = ++dbe->thread_last_db_id;
 
 	if (main_thread) {
-		if (main_thread != thread) {
-			err = db_export__thread(dbe, main_thread, machine,
-						comm, main_thread);
+		if (main_thread != thread && comm) {
+			err = db_export__comm_thread(dbe, comm, thread);
 			if (err)
 				return err;
-			if (comm) {
-				err = db_export__comm_thread(dbe, comm, thread);
-				if (err)
-					return err;
-			}
 		}
 		main_thread_db_id = main_thread->db_id;
 	}
@@ -308,12 +302,24 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		return err;
 
 	main_thread = thread__main_thread(al->machine, thread);
-	if (main_thread)
+	if (main_thread) {
 		comm = machine__thread_exec_comm(al->machine, main_thread);
+		/*
+		 * A thread has a reference to the main thread, so export the
+		 * main thread first.
+		 */
+		err = db_export__thread(dbe, main_thread, al->machine, comm,
+					main_thread);
+		if (err)
+			goto out_put;
+	}
 
-	err = db_export__thread(dbe, thread, al->machine, comm, main_thread);
-	if (err)
-		goto out_put;
+	if (thread != main_thread) {
+		err = db_export__thread(dbe, thread, al->machine, comm,
+					main_thread);
+		if (err)
+			goto out_put;
+	}
 
 	if (comm) {
 		err = db_export__exec_comm(dbe, comm, main_thread);
-- 
2.21.0
