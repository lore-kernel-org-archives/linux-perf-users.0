From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/12] perf stat: Fix metric column header display alignment
Date: Mon, 11 Jun 2018 14:48:06 -0300
Message-ID: <20180611174810.14815-9-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Make the metric only display aligned.

Before:
  # perf stat --topdown -I 1000
  #           time core         cpus retiring             bad speculation      frontend bound       backend bound
       1.000394323 S0-C0           2     37.4%               12.0%               31.4%               19.2%
       1.000394323 S0-C1           2     25.1%                9.2%               43.8%               21.9%
       2.001521204 S0-C0           2     36.4%               11.4%               32.4%               19.8%
       2.001521204 S0-C1           2     26.2%                9.4%               43.1%               21.3%
       3.001930208 S0-C0           2     35.1%               10.7%               33.6%               20.6%
       3.001930208 S0-C1           2     28.9%               10.0%               40.0%               21.1%

After:
  # perf stat --topdown -I 1000
  #           time core         cpus             retiring      bad speculation       frontend bound        backend bound
       1.000303722 S0-C0           2                34.2%                 7.6%                34.2%                24.0%
       1.000303722 S0-C1           2                33.1%                 6.4%                36.9%                23.6%
       2.001281055 S0-C0           2                34.6%                 6.7%                36.8%                21.8%
       2.001281055 S0-C1           2                32.8%                 7.1%                38.1%                22.0%
       3.001546080 S0-C0           2                39.3%                 5.5%                32.7%                22.5%
       3.001546080 S0-C1           2                37.8%                 6.0%                33.1%                23.1%

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180606221513.11302-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9e7b6f108956..8f3fdc052728 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1001,19 +1001,20 @@ static void print_metric_only(void *ctx, const char *color, const char *fmt,
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
-	int n;
-	char buf[1024];
+	char buf[1024], str[1024];
 	unsigned mlen = METRIC_ONLY_LEN;
 
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(buf, os->evsel, unit);
-	n = color_fprintf(out, color ?: "", fmt, val);
-	if (n > METRIC_ONLY_LEN)
-		n = METRIC_ONLY_LEN;
 	if (mlen < strlen(unit))
 		mlen = strlen(unit) + 1;
-	fprintf(out, "%*s", mlen - n, "");
+
+	if (color)
+		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
+
+	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
+	fprintf(out, "%*s ", mlen, str);
 }
 
 static void print_metric_only_csv(void *ctx, const char *color __maybe_unused,
@@ -1053,7 +1054,7 @@ static void print_metric_header(void *ctx, const char *color __maybe_unused,
 	if (csv_output)
 		fprintf(os->fh, "%s%s", unit, csv_sep);
 	else
-		fprintf(os->fh, "%-*s ", METRIC_ONLY_LEN, unit);
+		fprintf(os->fh, "%*s ", METRIC_ONLY_LEN, unit);
 }
 
 static void nsec_printout(int id, int nr, struct perf_evsel *evsel, double avg)
@@ -1721,7 +1722,7 @@ static void print_interval(char *prefix, struct timespec *ts)
 				fprintf(output, "             counts %*s events\n", unit_width, "unit");
 			break;
 		case AGGR_NONE:
-			fprintf(output, "#           time CPU");
+			fprintf(output, "#           time CPU    ");
 			if (!metric_only)
 				fprintf(output, "                counts %*s events\n", unit_width, "unit");
 			break;
-- 
2.14.3
