From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/85] perf db-export: Export IPC information
Date: Tue, 11 Jun 2019 15:58:04 -0300
Message-ID: <20190611185911.11645-19-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Export cycle and instruction counts on samples and call-returns.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 22f52b669871..6acb379b53ec 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1111,7 +1111,7 @@ static int python_export_sample(struct db_export *dbe,
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;
 
-	t = tuple_new(22);
+	t = tuple_new(24);
 
 	tuple_set_u64(t, 0, es->db_id);
 	tuple_set_u64(t, 1, es->evsel->db_id);
@@ -1135,6 +1135,8 @@ static int python_export_sample(struct db_export *dbe,
 	tuple_set_s32(t, 19, es->sample->flags & PERF_BRANCH_MASK);
 	tuple_set_s32(t, 20, !!(es->sample->flags & PERF_IP_FLAG_IN_TX));
 	tuple_set_u64(t, 21, es->call_path_id);
+	tuple_set_u64(t, 22, es->sample->insn_cnt);
+	tuple_set_u64(t, 23, es->sample->cyc_cnt);
 
 	call_object(tables->sample_handler, t, "sample_table");
 
@@ -1173,7 +1175,7 @@ static int python_export_call_return(struct db_export *dbe,
 	u64 comm_db_id = cr->comm ? cr->comm->db_id : 0;
 	PyObject *t;
 
-	t = tuple_new(12);
+	t = tuple_new(14);
 
 	tuple_set_u64(t, 0, cr->db_id);
 	tuple_set_u64(t, 1, cr->thread->db_id);
@@ -1187,6 +1189,8 @@ static int python_export_call_return(struct db_export *dbe,
 	tuple_set_u64(t, 9, cr->cp->parent->db_id);
 	tuple_set_s32(t, 10, cr->flags);
 	tuple_set_u64(t, 11, cr->parent_db_id);
+	tuple_set_u64(t, 12, cr->insn_count);
+	tuple_set_u64(t, 13, cr->cyc_count);
 
 	call_object(tables->call_return_handler, t, "call_return_table");
 
-- 
2.20.1
