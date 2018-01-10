From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/27] perf report: Add --stats option to display quick data statistics
Date: Wed, 10 Jan 2018 18:28:40 -0300
Message-ID: <20180110212844.12441-24-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add --stats option to display quick data statistics of event numbers,
without any further processing, like the one at the end of the perf
report -D command.

  $ perf report --stat

  Aggregated stats:
             TOTAL events:       4566
              MMAP events:        113
              LOST events:         19
              COMM events:          3
              FORK events:        400
            SAMPLE events:       3315
             MMAP2 events:         32
    FINISHED_ROUND events:        681
        THREAD_MAP events:          1
           CPU_MAP events:          1
         TIME_CONV events:          1

I found this useful when hunting lost events for another change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180107160356.28203-12-jolsa@kernel.org
[ Rename it to --stats, plural ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |  4 ++++
 tools/perf/builtin-report.c              | 26 +++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 1e02c4e1a81f..a7d11ef2fe25 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -457,6 +457,10 @@ include::itrace.txt[]
 	will be printed. Each entry is function name or file/line. Enabled by
 	default, disable with --no-inline.
 
+--stats::
+	Display overall events statistics without any further processing.
+	(like the one at the end of the perf report -D command)
+
 include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 770bf8a614f2..8e67a8c25ab1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -62,6 +62,7 @@ struct report {
 	bool			show_threads;
 	bool			inverted_callchain;
 	bool			mem_mode;
+	bool			stats_mode;
 	bool			header;
 	bool			header_only;
 	bool			nonany_branch_mode;
@@ -588,6 +589,20 @@ static void report__output_resort(struct report *rep)
 	ui_progress__finish();
 }
 
+static void stats_setup(struct report *rep)
+{
+	memset(&rep->tool, 0, sizeof(rep->tool));
+	rep->tool.no_warn = true;
+}
+
+static int stats_print(struct report *rep)
+{
+	struct perf_session *session = rep->session;
+
+	perf_session__fprintf_nr_events(session, stdout);
+	return 0;
+}
+
 static int __cmd_report(struct report *rep)
 {
 	int ret;
@@ -619,12 +634,18 @@ static int __cmd_report(struct report *rep)
 		return ret;
 	}
 
+	if (rep->stats_mode)
+		stats_setup(rep);
+
 	ret = perf_session__process_events(session);
 	if (ret) {
 		ui__error("failed to process sample\n");
 		return ret;
 	}
 
+	if (rep->stats_mode)
+		return stats_print(rep);
+
 	report__warn_kptr_restrict(rep);
 
 	evlist__for_each_entry(session->evlist, pos)
@@ -781,6 +802,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_BOOLEAN('q', "quiet", &quiet, "Do not show any message"),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
+	OPT_BOOLEAN(0, "stats", &report.stats_mode, "Display event stats"),
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
 	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
@@ -1042,6 +1064,8 @@ int cmd_report(int argc, const char **argv)
 		report.tool.show_feat_hdr = SHOW_FEAT_HEADER;
 	if (report.show_full_info)
 		report.tool.show_feat_hdr = SHOW_FEAT_HEADER_FULL_INFO;
+	if (report.stats_mode)
+		use_browser = 0;
 
 	if (strcmp(input_name, "-") != 0)
 		setup_browser(true);
@@ -1064,7 +1088,7 @@ int cmd_report(int argc, const char **argv)
 			ret = 0;
 			goto error;
 		}
-	} else if (use_browser == 0 && !quiet) {
+	} else if (use_browser == 0 && !quiet && !report.stats_mode) {
 		fputs("# To display the perf.data header info, please use --header/--header-only options.\n#\n",
 		      stdout);
 	}
-- 
2.14.3
