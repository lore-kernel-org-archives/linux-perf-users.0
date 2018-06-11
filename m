From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/12] perf stat: Allow to specify specific metric column len
Date: Mon, 11 Jun 2018 14:48:07 -0300
Message-ID: <20180611174810.14815-10-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The following change will introduce new metrics, that doesn't need such
wide hard coded spacing. Switch METRIC_ONLY_LEN macro usage with
metric_only_len variable.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180606221513.11302-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8f3fdc052728..3fc1f5286d50 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -145,6 +145,8 @@ static struct target target = {
 
 typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 
+#define METRIC_ONLY_LEN 20
+
 static int			run_count			=  1;
 static bool			no_inherit			= false;
 static volatile pid_t		child_pid			= -1;
@@ -182,6 +184,7 @@ static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
 static bool			ru_display			= false;
 static struct rusage		ru_data;
+static unsigned int		metric_only_len			= METRIC_ONLY_LEN;
 
 struct perf_stat {
 	bool			 record;
@@ -969,8 +972,6 @@ static void print_metric_csv(void *ctx,
 	fprintf(out, "%s%s%s%s", csv_sep, vals, csv_sep, unit);
 }
 
-#define METRIC_ONLY_LEN 20
-
 /* Filter out some columns that don't work well in metrics only mode */
 
 static bool valid_only_metric(const char *unit)
@@ -1002,7 +1003,7 @@ static void print_metric_only(void *ctx, const char *color, const char *fmt,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char buf[1024], str[1024];
-	unsigned mlen = METRIC_ONLY_LEN;
+	unsigned mlen = metric_only_len;
 
 	if (!valid_only_metric(unit))
 		return;
@@ -1054,7 +1055,7 @@ static void print_metric_header(void *ctx, const char *color __maybe_unused,
 	if (csv_output)
 		fprintf(os->fh, "%s%s", unit, csv_sep);
 	else
-		fprintf(os->fh, "%*s ", METRIC_ONLY_LEN, unit);
+		fprintf(os->fh, "%*s ", metric_only_len, unit);
 }
 
 static void nsec_printout(int id, int nr, struct perf_evsel *evsel, double avg)
-- 
2.14.3
