From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 56/66] perf evsel: Remove need for symbol_conf in evsel_fprintf.c
Date: Wed, 25 Sep 2019 21:32:34 -0300
Message-ID: <20190926003244.13962-57-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we an later link it to the python binding without having to
drag the symbol object files.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8823tveyasocnuoelq4qopwf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c      |  2 +-
 tools/perf/builtin-script.c     |  6 ++++--
 tools/perf/builtin-trace.c      |  2 +-
 tools/perf/util/evsel.h         |  7 ++++---
 tools/perf/util/evsel_fprintf.c | 14 ++++++--------
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 079e67a36904..f9706306fea0 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2055,7 +2055,7 @@ static void timehist_print_sample(struct perf_sched *sched,
 			    EVSEL__PRINT_SYM | EVSEL__PRINT_ONELINE |
 			    EVSEL__PRINT_CALLCHAIN_ARROW |
 			    EVSEL__PRINT_SKIP_IGNORED,
-			    &callchain_cursor, stdout);
+			    &callchain_cursor, symbol_conf.bt_stop_list,  stdout);
 
 out:
 	printf("\n");
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 22c1d114014c..0d43e2e5afff 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1325,7 +1325,8 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 		} else
 			printed += fprintf(fp, "\n");
 
-		printed += sample__fprintf_sym(sample, al, 0, print_opts, cursor, fp);
+		printed += sample__fprintf_sym(sample, al, 0, print_opts, cursor,
+					       symbol_conf.bt_stop_list, fp);
 	}
 
 	/* print branch_to information */
@@ -1867,7 +1868,8 @@ static void process_event(struct perf_script *script,
 			cursor = &callchain_cursor;
 
 		fputc(cursor ? '\n' : ' ', fp);
-		sample__fprintf_sym(sample, al, 0, output[type].print_ip_opts, cursor, fp);
+		sample__fprintf_sym(sample, al, 0, output[type].print_ip_opts, cursor,
+				    symbol_conf.bt_stop_list, fp);
 	}
 
 	if (PRINT_FIELD(IREGS))
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c52c3120a811..318225c8d7a7 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2076,7 +2076,7 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 				        EVSEL__PRINT_DSO |
 				        EVSEL__PRINT_UNKNOWN_AS_ADDR;
 
-	return sample__fprintf_callchain(sample, 38, print_opts, &callchain_cursor, trace->output);
+	return sample__fprintf_callchain(sample, 38, print_opts, &callchain_cursor, symbol_conf.bt_stop_list, trace->output);
 }
 
 static const char *errno_to_name(struct evsel *evsel, int err)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a5b29ac10da0..4a4c64833893 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -428,12 +428,13 @@ int perf_evsel__fprintf(struct evsel *evsel,
 struct callchain_cursor;
 
 int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
-			      unsigned int print_opts,
-			      struct callchain_cursor *cursor, FILE *fp);
+			      unsigned int print_opts, struct callchain_cursor *cursor,
+			      struct strlist *bt_stop_list, FILE *fp);
 
 int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 			int left_alignment, unsigned int print_opts,
-			struct callchain_cursor *cursor, FILE *fp);
+			struct callchain_cursor *cursor,
+			struct strlist *bt_stop_list, FILE *fp);
 
 bool perf_evsel__fallback(struct evsel *evsel, int err,
 			  char *msg, size_t msgsize);
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index a8cbdf4c2753..756b1e852db7 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -102,7 +102,7 @@ int perf_evsel__fprintf(struct evsel *evsel,
 
 int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			      unsigned int print_opts, struct callchain_cursor *cursor,
-			      FILE *fp)
+			      struct strlist *bt_stop_list, FILE *fp)
 {
 	int printed = 0;
 	struct callchain_cursor_node *node;
@@ -175,10 +175,8 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 				printed += fprintf(fp, "\n");
 
 			/* Add srccode here too? */
-			if (symbol_conf.bt_stop_list &&
-			    node->sym &&
-			    strlist__has_entry(symbol_conf.bt_stop_list,
-					       node->sym->name)) {
+			if (bt_stop_list && node->sym &&
+			    strlist__has_entry(bt_stop_list, node->sym->name)) {
 				break;
 			}
 
@@ -193,7 +191,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 
 int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 			int left_alignment, unsigned int print_opts,
-			struct callchain_cursor *cursor, FILE *fp)
+			struct callchain_cursor *cursor, struct strlist *bt_stop_list, FILE *fp)
 {
 	int printed = 0;
 	int print_ip = print_opts & EVSEL__PRINT_IP;
@@ -204,8 +202,8 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 	int print_unknown_as_addr = print_opts & EVSEL__PRINT_UNKNOWN_AS_ADDR;
 
 	if (cursor != NULL) {
-		printed += sample__fprintf_callchain(sample, left_alignment,
-						     print_opts, cursor, fp);
+		printed += sample__fprintf_callchain(sample, left_alignment, print_opts,
+						     cursor, bt_stop_list, fp);
 	} else {
 		printed += fprintf(fp, "%-*.*s", left_alignment, left_alignment, " ");
 
-- 
2.21.0
