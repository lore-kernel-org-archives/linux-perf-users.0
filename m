From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/77] perf stat: Add 'identifier' flag to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:03:53 -0300
Message-ID: <20180905220440.20256-31-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add 'identifier' flag to 'struct perf_stat_config' to carry the info
whether to use PERF_SAMPLE_IDENTIFIER for events.

This makes create_perf_stat_counter() independent.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 22 ++++++++++++----------
 tools/perf/util/stat.h    |  1 +
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 47789558899a..48c88f568fe1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -261,16 +261,7 @@ static int create_perf_stat_counter(struct perf_evsel *evsel,
 	 */
 	attr->sample_period = 0;
 
-	/*
-	 * But set sample_type to PERF_SAMPLE_IDENTIFIER, which should be harmless
-	 * while avoiding that older tools show confusing messages.
-	 *
-	 * However for pipe sessions we need to keep it zero,
-	 * because script's perf_evsel__check_attr is triggered
-	 * by attr->sample_type != 0, and we can't run it on
-	 * stat sessions.
-	 */
-	if (!(STAT_RECORD && perf_stat.data.is_pipe))
+	if (config->identifier)
 		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
 
 	/*
@@ -3064,6 +3055,17 @@ int cmd_stat(int argc, const char **argv)
 	if (perf_stat_init_aggr_mode())
 		goto out;
 
+	/*
+	 * Set sample_type to PERF_SAMPLE_IDENTIFIER, which should be harmless
+	 * while avoiding that older tools show confusing messages.
+	 *
+	 * However for pipe sessions we need to keep it zero,
+	 * because script's perf_evsel__check_attr is triggered
+	 * by attr->sample_type != 0, and we can't run it on
+	 * stat sessions.
+	 */
+	stat_config.identifier = !(STAT_RECORD && perf_stat.data.is_pipe);
+
 	/*
 	 * We dont want to block the signals - that would cause
 	 * child tasks to inherit that and Ctrl-C would not work.
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 53b2415ba3f3..918cde064cdc 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -89,6 +89,7 @@ struct perf_stat_config {
 	enum aggr_mode		 aggr_mode;
 	bool			 scale;
 	bool			 no_inherit;
+	bool			 identifier;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.14.4
