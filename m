From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/24] perf vendor events: Update JSON metrics for Skylake
Date: Mon, 23 Oct 2017 20:47:21 -0300
Message-ID: <20171023234736.5335-10-acme@kernel.org>
References: <20171023234736.5335-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbdJWXsO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Oct 2017 19:48:14 -0400
In-Reply-To: <20171023234736.5335-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Andi Kleen <ak@linux.intel.com>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/r/20170914200748.GA13837@tassilo.jf.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/x86/skylake/skl-metrics.json     | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 411f9411ec9e..36c903faed0b 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -13,7 +13,7 @@
     },
     {
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1) )",
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ((UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1) )",
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
-        "MetricExpr": "UOPS_EXECUTED.THREAD / ( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
         "BriefDescription": "Average Branch Address Clear Cost (fraction of cycles)",
-        "MetricExpr": "2* ( RS_EVENTS.EMPTY_CYCLES - ICACHE_16B.IFDATA_STALL  - ICACHE_64B.IFTAG_STALL ) / RS_EVENTS.EMPTY_END",
+        "MetricExpr": "2* (( RS_EVENTS.EMPTY_CYCLES - ICACHE_16B.IFDATA_STALL  - ICACHE_64B.IFTAG_STALL ) / RS_EVENTS.EMPTY_END)",
         "MetricGroup": "Unknown_Branches",
         "MetricName": "BAClear_Cost"
     },
@@ -73,19 +73,19 @@
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
-	"MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS_PS + MEM_LOAD_RETIRED.FB_HIT_PS )",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
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
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles )",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles) )",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
@@ -97,7 +97,7 @@
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "( 1*( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2* FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4*( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8* FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE ) / 1000000000 / duration_time",
+        "MetricExpr": "(( 1*( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2* FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4*( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8* FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
-- 
2.13.6
