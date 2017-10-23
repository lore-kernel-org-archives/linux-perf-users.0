From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/24] perf vendor events: Update JSON metrics for Skylake Server
Date: Mon, 23 Oct 2017 20:47:22 -0300
Message-ID: <20171023234736.5335-11-acme@kernel.org>
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
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  | 42 +++++++---------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 68f12a26c816..36c903faed0b 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -13,19 +13,19 @@
     },
     {
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1) )",
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ((UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1) )",
         "MetricGroup": "Frontend",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)",
         "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS )",
         "MetricGroup": "DSB; Frontend_Bandwidth",
         "MetricName": "DSB_Coverage"
     },
     {
         "BriefDescription": "Cycles Per Instruction (threaded)",
-        "MetricExpr": "1 / INST_RETIRED.ANY / cycles",
+        "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
@@ -36,8 +36,8 @@
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots (per-core)",
-        "MetricExpr": "4*cycles if not #SMT_on else (( CPU_CLK_UNHALTED.THREAD / 2) * (CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK )) if #EBS_Mode else ( CPU_CLK_UNHALTED.THREAD_ANY / 2 )",
+        "BriefDescription": "Total issue-pipeline slots",
+        "MetricExpr": "4*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
@@ -49,25 +49,25 @@
     },
     {
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / cycles if not #SMT_on else (( CPU_CLK_UNHALTED.THREAD / 2) * (CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK )) if #EBS_Mode else ( CPU_CLK_UNHALTED.THREAD_ANY / 2 )",
+        "MetricExpr": "INST_RETIRED.ANY / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / ( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
         "BriefDescription": "Average Branch Address Clear Cost (fraction of cycles)",
-        "MetricExpr": "( RS_EVENTS.EMPTY_CYCLES - (ICACHE_16B.IFDATA_STALL +2* ICACHE_16B.IFDATA_STALL:c1:e1) - ICACHE_64B.IFTAG_STALL ) / RS_EVENTS.EMPTY_END",
+        "MetricExpr": "2* (( RS_EVENTS.EMPTY_CYCLES - ICACHE_16B.IFDATA_STALL  - ICACHE_64B.IFTAG_STALL ) / RS_EVENTS.EMPTY_END)",
         "MetricGroup": "Unknown_Branches",
         "MetricName": "BAClear_Cost"
     },
     {
         "BriefDescription": "Core actual clocks when any thread is active on the physical core",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD if not #SMT_on else (( CPU_CLK_UNHALTED.THREAD / 2) * (CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK )) if 1 else ( CPU_CLK_UNHALTED.THREAD_ANY / 2 )",
+        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
@@ -79,35 +79,17 @@
     },
     {
         "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least 1 such miss)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( L1D_PEND_MISS.PENDING_CYCLES_ANY / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (( L1D_PEND_MISS.PENDING_CYCLES_ANY / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles if not #SMT_on else (( CPU_CLK_UNHALTED.THREAD / 2) * (CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK )) if #EBS_Mode else ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) )",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles) )",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "BriefDescription": "L1 cache miss per kilo instruction for demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS_PS / INST_RETIRED.ANY",
-        "MetricGroup": "Cache_Misses;",
-        "MetricName": "L1MPKI"
-    },
-    {
-        "BriefDescription": "L2 cache miss per kilo instruction for demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS_PS / INST_RETIRED.ANY",
-        "MetricGroup": "Cache_Misses;",
-        "MetricName": "L2MPKI"
-    },
-    {
-        "BriefDescription": "L3 cache miss per kilo instruction for demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS_PS / INST_RETIRED.ANY",
-        "MetricGroup": "Cache_Misses;",
-        "MetricName": "L3MPKI"
-    },
-    {
         "BriefDescription": "Average CPU Utilization",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
@@ -115,7 +97,7 @@
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "( 1*( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2* FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4*( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8* (FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16* FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) / 1000000000 / duration_time",
+        "MetricExpr": "(( 1*( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2* FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4*( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8* FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
-- 
2.13.6
