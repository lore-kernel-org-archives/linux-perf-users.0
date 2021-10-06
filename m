Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6321C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B837661019
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhJFINV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:13:21 -0400
Received: from foss.arm.com ([217.140.110.172]:56824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237411AbhJFINV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 04:13:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CD82D6E;
        Wed,  6 Oct 2021 01:11:29 -0700 (PDT)
Received: from ubuntu-18-04-aarch64-spe-2.warwick.arm.com (ubuntu-18-04-aarch64-spe-2.warwick.arm.com [10.32.33.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 53E293F766;
        Wed,  6 Oct 2021 01:11:27 -0700 (PDT)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] perf vendor events: Syntax corrections in Neoverse N1 json
Date:   Wed,  6 Oct 2021 09:11:03 +0100
Message-Id: <20211006081106.8649-1-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There are some syntactical mistakes in the json files for the Cortex A76
N1 (Neoverse N1).  This was obstructing parsing from an external tool.

This patch fixes the erroneous placement of commas causing the problems.

Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
---
 .../arch/arm64/arm/cortex-a76-n1/branch.json  |  4 +--
 .../arch/arm64/arm/cortex-a76-n1/bus.json     | 12 +++----
 .../arch/arm64/arm/cortex-a76-n1/cache.json   | 34 +++++++++----------
 .../arm64/arm/cortex-a76-n1/exception.json    |  4 +--
 .../arm64/arm/cortex-a76-n1/instruction.json  | 18 +++++-----
 .../arch/arm64/arm/cortex-a76-n1/memory.json  |  2 +-
 .../arch/arm64/arm/cortex-a76-n1/other.json   |  2 +-
 .../arm64/arm/cortex-a76-n1/pipeline.json     |  4 +--
 8 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
index ec0dc92288ab..db68de188390 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
@@ -1,10 +1,10 @@
 [
     {
         "PublicDescription": "This event counts any predictable branch instruction which is mispredicted either due to dynamic misprediction or because the MMU is off and the branches are statically predicted not taken",
-        "ArchStdEvent": "BR_MIS_PRED",
+        "ArchStdEvent": "BR_MIS_PRED"
     },
     {
         "PublicDescription": "This event counts all predictable branches.",
-        "ArchStdEvent": "BR_PRED",
+        "ArchStdEvent": "BR_PRED"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
index 6263929efce2..e0875d3a685d 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
@@ -1,21 +1,21 @@
 [
     {
-        "PublicDescription": "The number of core clock cycles"
+        "PublicDescription": "The number of core clock cycles",
         "ArchStdEvent": "CPU_CYCLES",
         "BriefDescription": "The number of core clock cycles."
     },
     {
         "PublicDescription": "This event counts for every beat of data transferred over the data channels between the core and the SCU. If both read and write data beats are transferred on a given cycle, this event is counted twice on that cycle. This event counts the sum of BUS_ACCESS_RD and BUS_ACCESS_WR.",
-        "ArchStdEvent": "BUS_ACCESS",
+        "ArchStdEvent": "BUS_ACCESS"
     },
     {
-        "PublicDescription": "This event duplicates CPU_CYCLES."
-        "ArchStdEvent": "BUS_CYCLES",
+        "PublicDescription": "This event duplicates CPU_CYCLES.",
+        "ArchStdEvent": "BUS_CYCLES"
     },
     {
-        "ArchStdEvent":  "BUS_ACCESS_RD",
+        "ArchStdEvent":  "BUS_ACCESS_RD"
     },
     {
-        "ArchStdEvent":  "BUS_ACCESS_WR",
+        "ArchStdEvent":  "BUS_ACCESS_WR"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
index cd67bb9df139..fc448c2d5ea4 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
@@ -1,47 +1,47 @@
 [
     {
         "PublicDescription": "This event counts any instruction fetch which misses in the cache.",
-        "ArchStdEvent": "L1I_CACHE_REFILL",
+        "ArchStdEvent": "L1I_CACHE_REFILL"
     },
     {
         "PublicDescription": "This event counts any refill of the instruction L1 TLB from the L2 TLB. This includes refills that result in a translation fault.",
-        "ArchStdEvent": "L1I_TLB_REFILL",
+        "ArchStdEvent": "L1I_TLB_REFILL"
     },
     {
         "PublicDescription": "This event counts any load or store operation or page table walk access which causes data to be read from outside the L1, including accesses which do not allocate into L1.",
-        "ArchStdEvent": "L1D_CACHE_REFILL",
+        "ArchStdEvent": "L1D_CACHE_REFILL"
     },
     {
         "PublicDescription": "This event counts any load or store operation or page table walk access which looks up in the L1 data cache. In particular, any access which could count the L1D_CACHE_REFILL event causes this event to count.",
-        "ArchStdEvent": "L1D_CACHE",
+        "ArchStdEvent": "L1D_CACHE"
     },
     {
         "PublicDescription": "This event counts any refill of the data L1 TLB from the L2 TLB. This includes refills that result in a translation fault.",
-        "ArchStdEvent": "L1D_TLB_REFILL",
+        "ArchStdEvent": "L1D_TLB_REFILL"
     },
-    {,
+    {
         "PublicDescription": "Level 1 instruction cache access or Level 0 Macro-op cache access. This event counts any instruction fetch which accesses the L1 instruction cache or L0 Macro-op cache.",
-        "ArchStdEvent": "L1I_CACHE",
+        "ArchStdEvent": "L1I_CACHE"
     },
     {
         "PublicDescription": "This event counts any write-back of data from the L1 data cache to L2 or L3. This counts both victim line evictions and snoops, including cache maintenance operations.",
-        "ArchStdEvent": "L1D_CACHE_WB",
+        "ArchStdEvent": "L1D_CACHE_WB"
     },
     {
         "PublicDescription": "This event counts any transaction from L1 which looks up in the L2 cache, and any write-back from the L1 to the L2. Snoops from outside the core and cache maintenance operations are not counted.",
-        "ArchStdEvent": "L2D_CACHE",
+        "ArchStdEvent": "L2D_CACHE"
     },
     {
         "PublicDescription": "L2 data cache refill. This event counts any cacheable transaction from L1 which causes data to be read from outside the core. L2 refills caused by stashes into L2 should not be counted",
-        "ArchStdEvent": "L2D_CACHE_REFILL",
+        "ArchStdEvent": "L2D_CACHE_REFILL"
     },
     {
         "PublicDescription": "This event counts any write-back of data from the L2 cache to outside the core. This includes snoops to the L2 which return data, regardless of whether they cause an invalidation. Invalidations from the L2 which do not write data outside of the core and snoops which return data from the L1 are not counted",
-        "ArchStdEvent": "L2D_CACHE_WB",
+        "ArchStdEvent": "L2D_CACHE_WB"
     },
     {
         "PublicDescription": "This event counts any full cache line write into the L2 cache which does not cause a linefill, including write-backs from L1 to L2 and full-line writes which do not allocate into L1.",
-        "ArchStdEvent": "L2D_CACHE_ALLOCATE",
+        "ArchStdEvent": "L2D_CACHE_ALLOCATE"
     },
     {
         "PublicDescription": "This event counts any load or store operation which accesses the data L1 TLB. If both a load and a store are executed on a cycle, this event counts twice. This event counts regardless of whether the MMU is enabled.",
@@ -75,21 +75,21 @@
     },
     {
         "PublicDescription": "This event counts on any access to the L2 TLB (caused by a refill of any of the L1 TLBs). This event does not count if the MMU is disabled.",
-        "ArchStdEvent": "L2D_TLB",
+        "ArchStdEvent": "L2D_TLB"
     },
     {
         "PublicDescription": "This event counts on any data access which causes L2D_TLB_REFILL to count.",
-        "ArchStdEvent": "DTLB_WALK",
+        "ArchStdEvent": "DTLB_WALK"
     },
     {
         "PublicDescription": "This event counts on any instruction access which causes L2D_TLB_REFILL to count.",
-        "ArchStdEvent": "ITLB_WALK",
+        "ArchStdEvent": "ITLB_WALK"
     },
     {
-        "ArchStdEvent": "LL_CACHE_RD",
+        "ArchStdEvent": "LL_CACHE_RD"
     },
     {
-        "ArchStdEvent": "LL_CACHE_MISS_RD",
+        "ArchStdEvent": "LL_CACHE_MISS_RD"
     },
     {
         "ArchStdEvent": "L1D_CACHE_INVAL"
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
index ea4631db41b5..ce942324ee60 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
@@ -1,10 +1,10 @@
 [
     {
-        "ArchStdEvent": "EXC_TAKEN",
+        "ArchStdEvent": "EXC_TAKEN"
     },
     {
         "PublicDescription": "This event counts any correctable or uncorrectable memory error (ECC or parity) in the protected core RAMs",
-        "ArchStdEvent": "MEMORY_ERROR",
+        "ArchStdEvent": "MEMORY_ERROR"
     },
     {
         "ArchStdEvent": "EXC_DABORT"
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
index 8e59566cba8b..b0b439a36ae9 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
@@ -1,32 +1,32 @@
 [
     {
-        "ArchStdEvent": "SW_INCR",
+        "ArchStdEvent": "SW_INCR"
     },
     {
         "PublicDescription": "This event counts all retired instructions, including those that fail their condition check.",
-        "ArchStdEvent": "INST_RETIRED",
+        "ArchStdEvent": "INST_RETIRED"
     },
     {
-        "ArchStdEvent": "EXC_RETURN",
+        "ArchStdEvent": "EXC_RETURN"
     },
     {
         "PublicDescription": "This event only counts writes to CONTEXTIDR in AArch32 state, and via the CONTEXTIDR_EL1 mnemonic in AArch64 state.",
-        "ArchStdEvent": "CID_WRITE_RETIRED",
+        "ArchStdEvent": "CID_WRITE_RETIRED"
     },
     {
-        "ArchStdEvent": "INST_SPEC",
+        "ArchStdEvent": "INST_SPEC"
     },
     {
         "PublicDescription": "This event only counts writes to TTBR0/TTBR1 in AArch32 state and TTBR0_EL1/TTBR1_EL1 in AArch64 state.",
-        "ArchStdEvent": "TTBR_WRITE_RETIRED",
+        "ArchStdEvent": "TTBR_WRITE_RETIRED"
     },
-    {,
+    {
         "PublicDescription": "This event counts all branches, taken or not. This excludes exception entries, debug entries and CCFAIL branches.",
-        "ArchStdEvent": "BR_RETIRED",
+        "ArchStdEvent": "BR_RETIRED"
     },
     {
         "PublicDescription": "This event counts any branch counted by BR_RETIRED which is not correctly predicted and causes a pipeline flush.",
-        "ArchStdEvent": "BR_MIS_PRED_RETIRED",
+        "ArchStdEvent": "BR_MIS_PRED_RETIRED"
     },
     {
         "ArchStdEvent": "ASE_SPEC"
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
index f06f399051c1..20a929e7728d 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
@@ -1,7 +1,7 @@
 [
     {
         "PublicDescription": "This event counts memory accesses due to load or store instructions. This event counts the sum of MEM_ACCESS_RD and MEM_ACCESS_WR.",
-        "ArchStdEvent": "MEM_ACCESS",
+        "ArchStdEvent": "MEM_ACCESS"
     },
     {
          "ArchStdEvent": "MEM_ACCESS_RD"
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
index c2ccbf6fbfa0..20d8365756c5 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
@@ -1,5 +1,5 @@
 [
     {
-        "ArchStdEvent": "REMOTE_ACCESS",
+        "ArchStdEvent": "REMOTE_ACCESS"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json
index d79f0aeaf7f1..b4e96551d51a 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json
@@ -1,10 +1,10 @@
 [
     {
         "PublicDescription": "The counter counts on any cycle when there are no fetched instructions available to dispatch.",
-        "ArchStdEvent": "STALL_FRONTEND",
+        "ArchStdEvent": "STALL_FRONTEND"
     },
     {
         "PublicDescription": "The counter counts on any cycle fetched instructions are not dispatched due to resource constraints.",
-        "ArchStdEvent": "STALL_BACKEND",
+        "ArchStdEvent": "STALL_BACKEND"
     }
 ]
-- 
2.17.1

