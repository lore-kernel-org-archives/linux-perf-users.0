From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/13] perf annotate stdio: Support --show-nr-samples option
Date: Mon, 21 Aug 2017 16:25:46 -0300
Message-ID: <20170821192549.17251-11-acme@kernel.org>
References: <20170821192549.17251-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821192549.17251-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

Add --show-nr-samples option to "perf annotate" so that it matches "perf
report".

Committer note:

Note that it can't be used together with --show-total-period, which
seems like a silly limitation, that can be lifted at some point.

Made it bail out if not on --stdio.

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1503046008-5511-1-git-send-email-treeze.taeung@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt |  4 ++++
 tools/perf/builtin-annotate.c              | 16 ++++++++++++++--
 tools/perf/util/annotate.c                 |  6 +++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index a89273d8e744..2a5975c91cbd 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -43,6 +43,10 @@ OPTIONS
 --quiet::
 	Do not show any message.  (Suppress -v)
 
+-n::
+--show-nr-samples::
+	Show the number of samples for each symbol
+
 -D::
 --dump-raw-trace::
         Dump raw trace in ASCII.
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 658c920d74b9..89fc0389dc76 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -403,7 +403,7 @@ int cmd_annotate(int argc, const char **argv)
 	struct perf_data_file file = {
 		.mode  = PERF_DATA_MODE_READ,
 	};
-	const struct option options[] = {
+	struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
 	OPT_STRING('d', "dsos", &symbol_conf.dso_list_str, "dso[,dso...]",
@@ -445,13 +445,20 @@ int cmd_annotate(int argc, const char **argv)
 		    "Show event group information together"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
+	OPT_BOOLEAN('n', "show-nr-samples", &symbol_conf.show_nr_samples,
+		    "Show a column with the number of samples"),
 	OPT_CALLBACK_DEFAULT(0, "stdio-color", NULL, "mode",
 			     "'always' (default), 'never' or 'auto' only applicable to --stdio mode",
 			     stdio__config_color, "always"),
 	OPT_END()
 	};
-	int ret = hists__init();
+	int ret;
+
+	set_option_flag(options, 0, "show-total-period", PARSE_OPT_EXCLUSIVE);
+	set_option_flag(options, 0, "show-nr-samples", PARSE_OPT_EXCLUSIVE);
+
 
+	ret = hists__init();
 	if (ret < 0)
 		return ret;
 
@@ -467,6 +474,11 @@ int cmd_annotate(int argc, const char **argv)
 		annotate.sym_hist_filter = argv[0];
 	}
 
+	if (symbol_conf.show_nr_samples && !annotate.use_stdio) {
+		pr_err("--show-nr-samples is only available in --stdio mode at this time\n");
+		return ret;
+	}
+
 	if (quiet)
 		perf_quiet_option();
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2dab0e5a7f2f..4397a8b6e6cd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1145,6 +1145,9 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 			if (symbol_conf.show_total_period)
 				color_fprintf(stdout, color, " %11" PRIu64,
 					      sample.period);
+			else if (symbol_conf.show_nr_samples)
+				color_fprintf(stdout, color, " %7" PRIu64,
+					      sample.nr_samples);
 			else
 				color_fprintf(stdout, color, " %7.2f", percent);
 		}
@@ -1825,7 +1828,8 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 		width *= evsel->nr_members;
 
 	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples)\n",
-				  width, width, symbol_conf.show_total_period ? "Event count" : "Percent",
+				  width, width, symbol_conf.show_total_period ? "Period" :
+				  symbol_conf.show_nr_samples ? "Samples" : "Percent",
 				  d_filename, evsel_name, h->nr_samples);
 
 	printf("%-*.*s----\n",
-- 
2.13.5
