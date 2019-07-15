From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/28] perf db-export: Factor out db_export__comm()
Date: Mon, 15 Jul 2019 18:11:46 -0300
Message-ID: <20190715211200.10984-15-acme@kernel.org>
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

In preparation for exporting the current comm for a thread, factor out
db_export__comm().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-12-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 30 +++++++++++++++++++++++-------
 tools/perf/util/db-export.h |  2 ++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index b0504d3eb130..b1e581c13963 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -78,6 +78,26 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 	return 0;
 }
 
+static int __db_export__comm(struct db_export *dbe, struct comm *comm,
+			     struct thread *thread)
+{
+	comm->db_id = ++dbe->comm_last_db_id;
+
+	if (dbe->export_comm)
+		return dbe->export_comm(dbe, comm, thread);
+
+	return 0;
+}
+
+int db_export__comm(struct db_export *dbe, struct comm *comm,
+		    struct thread *thread)
+{
+	if (comm->db_id)
+		return 0;
+
+	return __db_export__comm(dbe, comm, thread);
+}
+
 /*
  * Export the "exec" comm. The "exec" comm is the program / application command
  * name at the time it first executes. It is used to group threads for the same
@@ -92,13 +112,9 @@ int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
 	if (comm->db_id)
 		return 0;
 
-	comm->db_id = ++dbe->comm_last_db_id;
-
-	if (dbe->export_comm) {
-		err = dbe->export_comm(dbe, comm, main_thread);
-		if (err)
-			return err;
-	}
+	err = __db_export__comm(dbe, comm, main_thread);
+	if (err)
+		return err;
 
 	/*
 	 * Record the main thread for this comm. Note that the main thread can
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 29f7c3b035a7..f5f0865f07e1 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -77,6 +77,8 @@ int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel);
 int db_export__machine(struct db_export *dbe, struct machine *machine);
 int db_export__thread(struct db_export *dbe, struct thread *thread,
 		      struct machine *machine, struct thread *main_thread);
+int db_export__comm(struct db_export *dbe, struct comm *comm,
+		    struct thread *thread);
 int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
 			 struct thread *main_thread);
 int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
-- 
2.21.0
