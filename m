From: Ian Rogers <irogers@google.com>
Subject: [PATCH v3 09/12] perf metrics: fix parse errors in power9 metrics
Date: Thu, 30 Apr 2020 00:51:41 -0700
Message-ID: <20200430075144.132716-10-irogers@google.com>
References: <20200430075144.132716-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org, kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

Mismatched parentheses.

Fixes: 7f3cf5ac7743 (perf vendor events power9: Cpi_breakdown & estimated_dcache_miss_cpi metrics)
Reviewed-by: Paul A. Clarke <pc@us.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/powerpc/power9/metrics.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index 811c2a8c1c9e..f427436f2c0a 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -362,7 +362,7 @@
     },
     {
         "BriefDescription": "Completion stall for other reasons",
-        "MetricExpr": "PM_CMPLU_STALL - PM_CMPLU_STALL_NTC_DISP_FIN - PM_CMPLU_STALL_NTC_FLUSH - PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_BRU)/PM_RUN_INST_CMPL",
+        "MetricExpr": "(PM_CMPLU_STALL - PM_CMPLU_STALL_NTC_DISP_FIN - PM_CMPLU_STALL_NTC_FLUSH - PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_BRU)/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "other_stall_cpi"
     },
-- 
2.26.2.303.gf8c07b1a785-goog
