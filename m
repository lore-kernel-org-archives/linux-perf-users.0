From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/24] perf vendor events: Update JSON metrics for IvyBridge
Date: Mon, 23 Oct 2017 20:47:17 -0300
Message-ID: <20171023234736.5335-6-acme@kernel.org>
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
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json     | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
index 057a832f1a6a..7c2679514efb 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
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
@@ -49,19 +49,19 @@
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
-        "MetricExpr": "UOPS_EXECUTED.THREAD / ( cpu@uops_executed.core\\,cmask\\=1@ / 2) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
         "BriefDescription": "Average Branch Address Clear Cost (fraction of cycles)",
-        "MetricExpr": "2* ( RS_EVENTS.EMPTY_CYCLES - ICACHE.IFETCH_STALL ) / RS_EVENTS.EMPTY_END",
+        "MetricExpr": "2* (( RS_EVENTS.EMPTY_CYCLES - ICACHE.IFETCH_STALL ) / RS_EVENTS.EMPTY_END)",
         "MetricGroup": "Unknown_Branches",
         "MetricName": "BAClear_Cost"
     },
@@ -79,13 +79,13 @@
     },
     {
         "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least 1 such miss)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( cpu@l1d_pend_miss.pending_cycles\\,any\\=1@ / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (( cpu@l1d_pend_miss.pending_cycles\\,any\\=1@ / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
@@ -97,7 +97,7 @@
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
