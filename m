From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/24] perf vendor events: Update JSON metrics for JakeTown
Date: Mon, 23 Oct 2017 20:47:19 -0300
Message-ID: <20171023234736.5335-8-acme@kernel.org>
References: <20171023234736.5335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023234736.5335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/r/20170914200748.GA13837@tassilo.jf.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index b35b1c153c8a..2b18008cf482 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -13,7 +13,7 @@
     },
     {
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4) )",
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4) )",
         "MetricGroup": "Frontend",
         "MetricName": "IFetch_Line_Utilization"
     },
@@ -25,7 +25,7 @@
     },
     {
         "BriefDescription": "Cycles Per Instruction (threaded)",
-        "MetricExpr": "1 / INST_RETIRED.ANY / cycles",
+        "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
@@ -37,7 +37,7 @@
     },
     {
         "BriefDescription": "Total issue-pipeline slots",
-        "MetricExpr": "4*( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles",
+        "MetricExpr": "4*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
@@ -49,13 +49,13 @@
     },
     {
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles",
+        "MetricExpr": "INST_RETIRED.ANY / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-	"MetricExpr": "UOPS_DISPATCHED.THREAD / ( cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@ / 2) if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@",
+        "MetricExpr": "UOPS_DISPATCHED.THREAD / (( UOPS_DISPATCHED.CORE:c1 / 2) if #SMT_on else UOPS_DISPATCHED.CORE:c1)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
@@ -73,7 +73,7 @@
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "( 1*( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2* FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4*( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8* SIMD_FP_256.PACKED_SINGLE ) / 1000000000 / duration_time",
+        "MetricExpr": "(( 1*( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2* FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4*( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8* SIMD_FP_256.PACKED_SINGLE )) / 1000000000 / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
-- 
2.13.6
