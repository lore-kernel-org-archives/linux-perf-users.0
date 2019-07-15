From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/28] perf db-export: Rename db_export__comm() to db_export__exec_comm()
Date: Mon, 15 Jul 2019 18:11:37 -0300
Message-ID: <20190715211200.10984-6-acme@kernel.org>
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

Rename db_export__comm() to db_export__exec_comm() to better reflect
what it does and add explanatory comments.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 22 +++++++++++++++++++---
 tools/perf/util/db-export.h |  4 ++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 34cf197fe74f..8fab57f90cbc 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -105,8 +105,14 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 	return err;
 }
 
-int db_export__comm(struct db_export *dbe, struct comm *comm,
-		    struct thread *main_thread)
+/*
+ * Export the "exec" comm. The "exec" comm is the program / application command
+ * name at the time it first executes. It is used to group threads for the same
+ * program. Note that the main thread pid (or thread group id tgid) cannot be
+ * used because it does not change when a new program is exec'ed.
+ */
+int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
+			 struct thread *main_thread)
 {
 	int err;
 
@@ -121,6 +127,16 @@ int db_export__comm(struct db_export *dbe, struct comm *comm,
 			return err;
 	}
 
+	/*
+	 * Record the main thread for this comm. Note that the main thread can
+	 * have many "exec" comms because there will be a new one every time it
+	 * exec's. An "exec" comm however will only ever have 1 main thread.
+	 * That is different to any other threads for that same program because
+	 * exec() will effectively kill them, so the relationship between the
+	 * "exec" comm and non-main threads is 1-to-1. That is why
+	 * db_export__comm_thread() is called here for the main thread, but it
+	 * is called for non-main threads when they are exported.
+	 */
 	return db_export__comm_thread(dbe, comm, main_thread);
 }
 
@@ -313,7 +329,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		goto out_put;
 
 	if (comm) {
-		err = db_export__comm(dbe, comm, main_thread);
+		err = db_export__exec_comm(dbe, comm, main_thread);
 		if (err)
 			goto out_put;
 		es.comm_db_id = comm->db_id;
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 261cfece8dee..148a657b1887 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -76,8 +76,8 @@ int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel);
 int db_export__machine(struct db_export *dbe, struct machine *machine);
 int db_export__thread(struct db_export *dbe, struct thread *thread,
 		      struct machine *machine, struct comm *comm);
-int db_export__comm(struct db_export *dbe, struct comm *comm,
-		    struct thread *main_thread);
+int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
+			 struct thread *main_thread);
 int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
 			   struct thread *thread);
 int db_export__dso(struct db_export *dbe, struct dso *dso,
-- 
2.21.0
