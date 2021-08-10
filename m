Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2695C4320A
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 02:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD87261051
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 02:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbhHJCHX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 22:07:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:10920 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237340AbhHJCHU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 22:07:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="212962418"
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="scan'208";a="212962418"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 19:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="scan'208";a="444808338"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga007.fm.intel.com with ESMTP; 09 Aug 2021 19:06:55 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        irogers@google.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 3/6] perf vendor events: Update metrics for CascadeLake Server
Date:   Tue, 10 Aug 2021 10:05:05 +0800
Message-Id: <20210810020508.31261-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810020508.31261-1-yao.jin@linux.intel.com>
References: <20210810020508.31261-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update JSON metrics for CascadeLake Server.

Based on TMA metrics 4.21 at 01.org.
https://download.01.org/perfmon/

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 .../arch/x86/cascadelakex/clx-metrics.json    | 253 ++++++------------
 1 file changed, 86 insertions(+), 167 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 00f4fcffa815..5d6b2e6fcb7b 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -1,61 +1,4 @@
 [
-    {
-        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Machine_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Machine_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example."
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU."
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
-        "MetricConstraint": "NO_NMI_WATCHDOG",
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound."
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) )",
-        "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. "
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU."
-    },
     {
         "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
@@ -71,49 +14,79 @@
     {
         "BriefDescription": "Instruction per taken branch",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
-        "MetricGroup": "Branches;Fetch_BW;PGO",
+        "MetricGroup": "Branches;FetchBW;PGO",
         "MetricName": "IpTB"
     },
     {
         "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
-        "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
-        "MetricGroup": "Pipeline;Summary",
+        "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)",
+        "MetricGroup": "Pipeline",
         "MetricName": "CPI"
     },
     {
         "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Summary",
+        "MetricGroup": "Pipeline",
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "4 * cycles",
-        "MetricGroup": "TopDownL1",
-        "MetricName": "SLOTS"
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "SMT;TmaL1",
+        "MetricName": "CoreIPC"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "MetricGroup": "TopDownL1_SMT",
-        "MetricName": "SLOTS_SMT"
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
+        "MetricGroup": "SMT;TmaL1",
+        "MetricName": "CoreIPC_SMT"
+    },
+    {
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "Flops",
+        "MetricName": "FLOPc"
+    },
+    {
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
+        "MetricGroup": "Flops_SMT",
+        "MetricName": "FLOPc_SMT"
+    },
+    {
+        "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricGroup": "Pipeline;PortsUtil",
+        "MetricName": "ILP"
+    },
+    {
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "BrMispredicts",
+        "MetricName": "IpMispredict"
+    },
+    {
+        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
+        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "SMT",
+        "MetricName": "CORE_CLKS"
     },
     {
         "BriefDescription": "Instructions per Load (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
-        "MetricGroup": "Instruction_Type",
+        "MetricGroup": "InsType",
         "MetricName": "IpLoad"
     },
     {
         "BriefDescription": "Instructions per Store (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
-        "MetricGroup": "Instruction_Type",
+        "MetricGroup": "InsType",
         "MetricName": "IpStore"
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Branches;Instruction_Type",
+        "MetricGroup": "Branches;InsType",
         "MetricName": "IpBranch"
     },
     {
@@ -131,13 +104,13 @@
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operation (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )",
-        "MetricGroup": "FLOPS;FP_Arith;Instruction_Type",
+        "MetricGroup": "Flops;FpArith;InsType",
         "MetricName": "IpFLOP"
     },
     {
-        "BriefDescription": "Total number of retired Instructions",
+        "BriefDescription": "Total number of retired Instructions, Sample with: INST_RETIRED.PREC_DIST",
         "MetricExpr": "INST_RETIRED.ANY",
-        "MetricGroup": "Summary;TopDownL1",
+        "MetricGroup": "Summary;TmaL1",
         "MetricName": "Instructions"
     },
     {
@@ -149,164 +122,110 @@
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
         "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS)",
-        "MetricGroup": "DSB;Fetch_BW",
+        "MetricGroup": "DSB;FetchBW",
         "MetricName": "DSB_Coverage"
     },
-    {
-        "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / cycles",
-        "MetricGroup": "SMT;TopDownL1",
-        "MetricName": "CoreIPC"
-    },
-    {
-        "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "MetricGroup": "SMT;TopDownL1",
-        "MetricName": "CoreIPC_SMT"
-    },
-    {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / cycles",
-        "MetricGroup": "FLOPS",
-        "MetricName": "FLOPc"
-    },
-    {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "MetricGroup": "FLOPS_SMT",
-        "MetricName": "FLOPc_SMT"
-    },
-    {
-        "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / ( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 )",
-        "MetricGroup": "Pipeline;Ports_Utilization",
-        "MetricName": "ILP"
-    },
-    {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
-        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles))) + (4 * ( IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE - ( FRONTEND_RETIRED.LATENCY_GE_1 - FRONTEND_RETIRED.LATENCY_GE_2 ) / (UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY) ) / (4 * cycles)) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * ( IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE - ( FRONTEND_RETIRED.LATENCY_GE_1 - FRONTEND_RETIRED.LATENCY_GE_2 ) / (UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY) ) / (4 * cycles)) ) * (4 * cycles) / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "BrMispredicts",
-        "MetricName": "Branch_Misprediction_Cost"
-    },
-    {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
-        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (4 * ( IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE - ( FRONTEND_RETIRED.LATENCY_GE_1 - FRONTEND_RETIRED.LATENCY_GE_2 ) / (UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * ( IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE - ( FRONTEND_RETIRED.LATENCY_GE_1 - FRONTEND_RETIRED.LATENCY_GE_2 ) / (UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) ) * (4 * ( ( CPU_
 CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "BrMispredicts_SMT",
-        "MetricName": "Branch_Misprediction_Cost_SMT"
-    },
-    {
-        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "BrMispredicts",
-        "MetricName": "IpMispredict"
-    },
-    {
-        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
-        "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "MetricGroup": "SMT",
-        "MetricName": "CORE_CLKS"
-    },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
-        "MetricGroup": "Memory_Bound;Memory_Lat",
+        "MetricGroup": "MemoryBound;MemoryLat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
         "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-Logical Processor)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
-        "MetricGroup": "Memory_Bound;Memory_BW",
+        "MetricGroup": "MemoryBound;MemoryBW",
         "MetricName": "MLP"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
         "MetricConstraint": "NO_NMI_WATCHDOG",
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
-        "MetricGroup": "TLB",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * CORE_CLKS )",
+        "MetricGroup": "MemoryTLB",
         "MetricName": "Page_Walks_Utilization"
     },
-    {
-        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ) )",
-        "MetricGroup": "TLB_SMT",
-        "MetricName": "Page_Walks_Utilization_SMT"
-    },
     {
         "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
-        "MetricGroup": "Memory_BW",
+        "MetricGroup": "MemoryBW",
         "MetricName": "L1D_Cache_Fill_BW"
     },
     {
         "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
         "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
-        "MetricGroup": "Memory_BW",
+        "MetricGroup": "MemoryBW",
         "MetricName": "L2_Cache_Fill_BW"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
         "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
-        "MetricGroup": "Memory_BW",
+        "MetricGroup": "MemoryBW",
         "MetricName": "L3_Cache_Fill_BW"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "BriefDescription": "Average per-core data access bandwidth to the L3 cache [GB / sec]",
         "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
-        "MetricGroup": "Memory_BW;Offcore",
+        "MetricGroup": "MemoryBW;Offcore",
         "MetricName": "L3_Cache_Access_BW"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "Cache_Misses",
+        "MetricGroup": "CacheMisses",
         "MetricName": "L1MPKI"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "Cache_Misses",
+        "MetricGroup": "CacheMisses",
         "MetricName": "L2MPKI"
     },
     {
         "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
-        "MetricGroup": "Cache_Misses;Offcore",
+        "MetricGroup": "CacheMisses;Offcore",
         "MetricName": "L2MPKI_All"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
         "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
-        "MetricGroup": "Cache_Misses",
+        "MetricGroup": "CacheMisses",
         "MetricName": "L2HPKI_All"
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "Cache_Misses",
+        "MetricGroup": "CacheMisses",
         "MetricName": "L3MPKI"
     },
     {
         "BriefDescription": "Rate of silent evictions from the L2 cache per Kilo instruction where the evicted lines are dropped (no writeback to L3 or memory)",
         "MetricExpr": "1000 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
-        "MetricGroup": "",
+        "MetricGroup": "L2Evicts;Server",
         "MetricName": "L2_Evictions_Silent_PKI"
     },
     {
         "BriefDescription": "Rate of non silent evictions from the L2 cache per Kilo instruction",
         "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY",
-        "MetricGroup": "",
+        "MetricGroup": "L2Evicts;Server",
         "MetricName": "L2_Evictions_NonSilent_PKI"
     },
     {
         "BriefDescription": "Average CPU Utilization",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
-        "MetricGroup": "Summary",
+        "MetricGroup": "HPC;Summary",
         "MetricName": "CPU_Utilization"
     },
+    {
+        "BriefDescription": "Measured Average Frequency for unhalted processors [GHz]",
+        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC) * msr@tsc@ / 1000000000 / duration_time",
+        "MetricGroup": "Summary;Power",
+        "MetricName": "Average_Frequency"
+    },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
         "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / 1000000000 ) / duration_time",
-        "MetricGroup": "FLOPS;Summary",
+        "MetricGroup": "Flops;HPC",
         "MetricName": "GFLOPs"
     },
     {
@@ -317,62 +236,62 @@
     },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
-        "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 )",
-        "MetricGroup": "SMT;Summary",
+        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "MetricGroup": "SMT",
         "MetricName": "SMT_2T_Utilization"
     },
     {
         "BriefDescription": "Fraction of cycles spent in the Operating System (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "OS",
         "MetricName": "Kernel_Utilization"
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
-        "MetricExpr": "( ( ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) * 1048576 ) / 1000000000 ) / duration_time",
-        "MetricGroup": "Memory_BW;SoC",
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
+        "MetricGroup": "HPC;MemoryBW;SoC",
         "MetricName": "DRAM_BW_Use"
     },
     {
         "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
         "MetricExpr": "1000000000 * ( cha@event\\=0x36\\,umask\\=0x21\\,config\\=0x40433@ / cha@event\\=0x35\\,umask\\=0x21\\,config\\=0x40433@ ) / ( cha_0@event\\=0x0@ / duration_time )",
-        "MetricGroup": "Memory_Lat;SoC",
+        "MetricGroup": "MemoryLat;SoC",
         "MetricName": "MEM_Read_Latency"
     },
     {
         "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
         "MetricExpr": "cha@event\\=0x36\\,umask\\=0x21\\,config\\=0x40433@ / cha@event\\=0x36\\,umask\\=0x21\\,config\\=0x40433\\,thresh\\=1@",
-        "MetricGroup": "Memory_BW;SoC",
+        "MetricGroup": "MemoryBW;SoC",
         "MetricName": "MEM_Parallel_Reads"
     },
     {
         "BriefDescription": "Average latency of data read request to external 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-read prefetches",
         "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ )",
-        "MetricGroup": "Memory_Lat;SoC;Server",
+        "MetricGroup": "MemoryLat;SoC;Server",
         "MetricName": "MEM_PMM_Read_Latency"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [GB / sec]",
         "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time )",
-        "MetricGroup": "Memory_BW;SoC;Server",
+        "MetricGroup": "MemoryBW;SoC;Server",
         "MetricName": "PMM_Read_BW"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes [GB / sec]",
         "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time )",
-        "MetricGroup": "Memory_BW;SoC;Server",
+        "MetricGroup": "MemoryBW;SoC;Server",
         "MetricName": "PMM_Write_BW"
     },
     {
         "BriefDescription": "Average IO (network or disk) Bandwidth Use for Writes [GB / sec]",
         "MetricExpr": "( UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3 ) * 4 / 1000000000 / duration_time",
-        "MetricGroup": "IO_BW;SoC;Server",
+        "MetricGroup": "IoBW;SoC;Server",
         "MetricName": "IO_Write_BW"
     },
     {
         "BriefDescription": "Average IO (network or disk) Bandwidth Use for Reads [GB / sec]",
         "MetricExpr": "( UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3 ) * 4 / 1000000000 / duration_time",
-        "MetricGroup": "IO_BW;SoC;Server",
+        "MetricGroup": "IoBW;SoC;Server",
         "MetricName": "IO_Read_BW"
     },
     {
@@ -383,7 +302,7 @@
     },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches apply upon transition from application to operating system, handling interrupts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "INST_RETIRED.ANY / ( BR_INST_RETIRED.FAR_BRANCH / 2 )",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
         "MetricGroup": "Branches;OS",
         "MetricName": "IpFarBranch"
     },
-- 
2.17.1

