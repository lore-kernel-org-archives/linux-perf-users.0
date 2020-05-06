From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/91] perf top: Move sb_evlist to 'struct perf_top'
Date: Wed,  6 May 2020 12:21:27 -0300
Message-ID: <20200506152234.21977-25-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Where state related to a 'perf top' session is grouped.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200429131106.27974-3-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 7 +++----
 tools/perf/util/top.h    | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 6b067a5ba1d5..70e1c732db6a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1580,7 +1580,6 @@ int cmd_top(int argc, const char **argv)
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
-	struct evlist *sb_evlist = NULL;
 	const char * const top_usage[] = {
 		"perf top [<options>]",
 		NULL
@@ -1744,9 +1743,9 @@ int cmd_top(int argc, const char **argv)
 	}
 
 	if (!top.record_opts.no_bpf_event)
-		bpf_event__add_sb_event(&sb_evlist, &perf_env);
+		bpf_event__add_sb_event(&top.sb_evlist, &perf_env);
 
-	if (perf_evlist__start_sb_thread(sb_evlist, target)) {
+	if (perf_evlist__start_sb_thread(top.sb_evlist, target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
 		opts->no_bpf_event = true;
 	}
@@ -1754,7 +1753,7 @@ int cmd_top(int argc, const char **argv)
 	status = __cmd_top(&top);
 
 	if (!opts->no_bpf_event)
-		perf_evlist__stop_sb_thread(sb_evlist);
+		perf_evlist__stop_sb_thread(top.sb_evlist);
 
 out_delete_evlist:
 	evlist__delete(top.evlist);
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 45dc84ddff37..ff8391208ecd 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -18,7 +18,7 @@ struct perf_session;
 
 struct perf_top {
 	struct perf_tool   tool;
-	struct evlist *evlist;
+	struct evlist *evlist, *sb_evlist;
 	struct record_opts record_opts;
 	struct annotation_options annotation_opts;
 	struct evswitch	   evswitch;
-- 
2.21.1
