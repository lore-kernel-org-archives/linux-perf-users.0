From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/91] perf stat: Zero all the 'ena' and 'run' array slot stats for interval mode
Date: Wed,  6 May 2020 12:21:08 -0300
Message-ID: <20200506152234.21977-6-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

As the code comments in perf_stat_process_counter() say, we calculate
counter's data every interval, and the display code shows ps->res_stats
avg value. We need to zero the stats for interval mode.

But the current code only zeros the res_stats[0], it doesn't zero the
res_stats[1] and res_stats[2], which are for ena and run of counter.

This patch zeros the whole res_stats[] for interval mode.

Fixes: 51fd2df1e882 ("perf stat: Fix interval output values")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200409070755.17261-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 5f26137b8d60..242476eb808c 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -368,8 +368,10 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	 * interval mode, otherwise overall avg running
 	 * averages will be shown for each interval.
 	 */
-	if (config->interval)
-		init_stats(ps->res_stats);
+	if (config->interval) {
+		for (i = 0; i < 3; i++)
+			init_stats(&ps->res_stats[i]);
+	}
 
 	if (counter->per_pkg)
 		zero_per_pkg(counter);
-- 
2.21.1
