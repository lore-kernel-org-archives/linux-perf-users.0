From: Ian Rogers <irogers@google.com>
Subject: [PATCH v2 08/11] perf metrics: fix parse errors in power8 metrics
Date: Wed, 22 Apr 2020 15:04:27 -0700
Message-ID: <20200422220430.254014-9-irogers@google.com>
References: <20200422220430.254014-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

Mismatched parentheses.

Fixes: dd81eafacc52 (perf vendor events power8: Cpi_breakdown & estimated_dcache_miss_cpi metrics)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/powerpc/power8/metrics.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
index bffb2d4a6420..ad71486a38e3 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
@@ -169,7 +169,7 @@
     },
     {
         "BriefDescription": "Cycles GCT empty where dispatch was held",
-        "MetricExpr": "(PM_GCT_NOSLOT_DISP_HELD_MAP + PM_GCT_NOSLOT_DISP_HELD_SRQ + PM_GCT_NOSLOT_DISP_HELD_ISSQ + PM_GCT_NOSLOT_DISP_HELD_OTHER) / PM_RUN_INST_CMPL)",
+        "MetricExpr": "(PM_GCT_NOSLOT_DISP_HELD_MAP + PM_GCT_NOSLOT_DISP_HELD_SRQ + PM_GCT_NOSLOT_DISP_HELD_ISSQ + PM_GCT_NOSLOT_DISP_HELD_OTHER) / PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "gct_empty_disp_held_cpi"
     },
@@ -886,7 +886,7 @@
     },
     {
         "BriefDescription": "GCT slot utilization (11 to 14) as a % of cycles this thread had atleast 1 slot valid",
-        "MetricExpr": "PM_GCT_UTIL_11_14_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
+        "MetricExpr": "PM_GCT_UTIL_11_14_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC ) * 100",
         "MetricGroup": "general",
         "MetricName": "gct_util_11to14_slots_percent"
     },
-- 
2.26.2.303.gf8c07b1a785-goog
