From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/6] perf inject: Fix processing of ID index for injected instruction tracing
Date: Thu,  5 Dec 2019 16:32:22 -0300
Message-ID: <20191205193224.24629-5-acme@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The ID index event is used when decoding, but can result in the
following error:

 $ perf record --aux-sample -e '{intel_pt//,branch-misses}:u' ls
 $ perf inject -i perf.data -o perf.data.inj --itrace=be
 $ perf script -i perf.data.inj
 0x1020 [0x410]: failed to process type: 69 [No such file or directory]

Fix by having 'perf inject' drop the ID index event.

Fixes: c0a6de06c446 ("perf record: Add support for AUX area sampling")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191204120800.8138-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 9664a72a089d..7e124a7b8bfd 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -403,17 +403,6 @@ static int perf_event__repipe_tracing_data(struct perf_session *session,
 	return err;
 }
 
-static int perf_event__repipe_id_index(struct perf_session *session,
-				       union perf_event *event)
-{
-	int err;
-
-	perf_event__repipe_synth(session->tool, event);
-	err = perf_event__process_id_index(session, event);
-
-	return err;
-}
-
 static int dso__read_build_id(struct dso *dso)
 {
 	if (dso->has_build_id)
@@ -651,7 +640,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		inject->tool.comm	    = perf_event__repipe_comm;
 		inject->tool.namespaces	    = perf_event__repipe_namespaces;
 		inject->tool.exit	    = perf_event__repipe_exit;
-		inject->tool.id_index	    = perf_event__repipe_id_index;
+		inject->tool.id_index	    = perf_event__process_id_index;
 		inject->tool.auxtrace_info  = perf_event__process_auxtrace_info;
 		inject->tool.auxtrace	    = perf_event__process_auxtrace;
 		inject->tool.aux	    = perf_event__drop_aux;
-- 
2.21.0
