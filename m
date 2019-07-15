From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/28] perf db-export: Export comm before exporting thread
Date: Mon, 15 Jul 2019 18:11:40 -0300
Message-ID: <20190715211200.10984-9-acme@kernel.org>
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

Export comm before exporting the non-main thread because
db_export__thread() also exports the comm_thread.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 63f9edf65eee..99ad759561de 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -312,6 +312,12 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 					main_thread);
 		if (err)
 			goto out_put;
+		if (comm) {
+			err = db_export__exec_comm(dbe, comm, main_thread);
+			if (err)
+				goto out_put;
+			es.comm_db_id = comm->db_id;
+		}
 	}
 
 	if (thread != main_thread) {
@@ -321,13 +327,6 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 			goto out_put;
 	}
 
-	if (comm) {
-		err = db_export__exec_comm(dbe, comm, main_thread);
-		if (err)
-			goto out_put;
-		es.comm_db_id = comm->db_id;
-	}
-
 	es.db_id = ++dbe->sample_last_db_id;
 
 	err = db_ids_from_al(dbe, al, &es.dso_db_id, &es.sym_db_id, &es.offset);
-- 
2.21.0
