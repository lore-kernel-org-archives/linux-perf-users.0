From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/28] perf stat: Use perf_evsel__is_clocki() for clock events
Date: Thu, 22 Nov 2018 00:36:06 -0300
Message-ID: <20181122033611.15890-24-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Anton Blanchard <anton@samba.org>, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, yuzhoujian@didichuxing.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

We already have function to check if a given event is either
SW_CPU_CLOCK or SW_TASK_CLOCK. Utilize it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: yuzhoujian@didichuxing.com
Link: http://lkml.kernel.org/r/20181115095533.16930-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 8ad32763cfff..f0a8cec55c47 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -212,8 +212,7 @@ void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
 
 	count *= counter->scale;
 
-	if (perf_evsel__match(counter, SOFTWARE, SW_TASK_CLOCK) ||
-	    perf_evsel__match(counter, SOFTWARE, SW_CPU_CLOCK))
+	if (perf_evsel__is_clock(counter))
 		update_runtime_stat(st, STAT_NSECS, 0, cpu, count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
 		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
-- 
2.14.5
