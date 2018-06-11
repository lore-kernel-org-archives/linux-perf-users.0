From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/12] perf stat: Use only color_fprintf call in print_metric_only
Date: Mon, 11 Jun 2018 14:48:05 -0300
Message-ID: <20180611174810.14815-8-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We can call color_fprintf also for non color case, it's handled
properly. This change simplifies following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180606221513.11302-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f1532e3ac7d7..9e7b6f108956 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1008,10 +1008,7 @@ static void print_metric_only(void *ctx, const char *color, const char *fmt,
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(buf, os->evsel, unit);
-	if (color)
-		n = color_fprintf(out, color, fmt, val);
-	else
-		n = fprintf(out, fmt, val);
+	n = color_fprintf(out, color ?: "", fmt, val);
 	if (n > METRIC_ONLY_LEN)
 		n = METRIC_ONLY_LEN;
 	if (mlen < strlen(unit))
-- 
2.14.3
