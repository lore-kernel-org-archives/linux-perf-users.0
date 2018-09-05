From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/77] perf stat: Move STAT_RECORD out of perf_evlist__print_counters()
Date: Wed,  5 Sep 2018 19:04:04 -0300
Message-ID: <20180905220440.20256-42-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

It's stat related and should stay in the 'perf stat' command.  The
perf_evlist__print_counters function will be moved out in the following
patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index db11832bbdbc..4ffbb6594eb6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1701,10 +1701,6 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	struct perf_evsel *counter;
 	char buf[64], *prefix = NULL;
 
-	/* Do not print anything if we record to the pipe. */
-	if (STAT_RECORD && perf_stat.data.is_pipe)
-		return;
-
 	if (interval)
 		print_interval(prefix = buf, ts);
 	else
@@ -1766,6 +1762,10 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 
 static void print_counters(struct timespec *ts, int argc, const char **argv)
 {
+	/* Do not print anything if we record to the pipe. */
+	if (STAT_RECORD && perf_stat.data.is_pipe)
+		return;
+
 	perf_evlist__print_counters(evsel_list, ts, argc, argv);
 }
 
-- 
2.14.4
