From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/44] perf annotate: Add PERCENT_PERIOD_GLOBAL percent value
Date: Thu,  9 Aug 2018 11:58:01 -0300
Message-ID: <20180809145822.21391-24-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding and computing global period percent value for annotation line.
Storing it in struct annotation_data percent array under new
PERCENT_PERIOD_GLOBAL index.

At the moment it's not displayed, it's coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 3 +++
 tools/perf/util/annotate.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b37e8cc18668..e890164592b0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1783,6 +1783,9 @@ static void calc_percent(struct sym_hist *sym_hist,
 
 	if (sym_hist->period)
 		data->percent[PERCENT_PERIOD_LOCAL] = 100.0 * period / sym_hist->period;
+
+	if (hists->stats.total_period)
+		data->percent[PERCENT_PERIOD_GLOBAL] = 100.0 * period / hists->stats.total_period;
 }
 
 static void annotation__calc_percent(struct annotation *notes,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 890b6869caa9..48fe2aa6b5a8 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -105,6 +105,7 @@ enum {
 	PERCENT_HITS_LOCAL,
 	PERCENT_HITS_GLOBAL,
 	PERCENT_PERIOD_LOCAL,
+	PERCENT_PERIOD_GLOBAL,
 	PERCENT_MAX,
 };
 
-- 
2.14.4
