Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2257C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD63A60F9D
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbhJFIN0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:13:26 -0400
Received: from foss.arm.com ([217.140.110.172]:56852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237411AbhJFINY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 04:13:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3FC1ED1;
        Wed,  6 Oct 2021 01:11:32 -0700 (PDT)
Received: from ubuntu-18-04-aarch64-spe-2.warwick.arm.com (ubuntu-18-04-aarch64-spe-2.warwick.arm.com [10.32.33.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD91A3F766;
        Wed,  6 Oct 2021 01:11:30 -0700 (PDT)
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
Subject: [PATCH v2 2/3] perf vendor events: Add new armv8 pmu events
Date:   Wed,  6 Oct 2021 09:11:04 +0100
Message-Id: <20211006081106.8649-2-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211006081106.8649-1-andrew.kilroy@arm.com>
References: <20211006081106.8649-1-andrew.kilroy@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add new armv8 common events for use by Arm Neoverse V1 cores in a later
commit. These are defined in the ArmV8 architecture reference manual
available from

  https://developer.arm.com/documentation/ddi0487/gb/?lang=en

Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
---
 .../arm64/armv8-common-and-microarch.json     | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
index 913fb200ea52..423767510aff 100644
--- a/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
@@ -257,6 +257,78 @@
         "EventName": "LL_CACHE_MISS_RD",
         "BriefDescription": "Last level cache miss, read"
     },
+    {
+        "PublicDescription": "Level 1 data cache long-latency read miss.  The counter counts each memory read access counted by L1D_CACHE that incurs additional latency because it returns data from outside the Level 1 data or unified cache of this processing element.",
+        "EventCode": "0x39",
+        "EventName": "L1D_CACHE_LMISS_RD",
+        "BriefDescription": "Level 1 data cache long-latency read miss"
+    },
+    {
+        "PublicDescription": "Micro-operation architecturally executed.  The counter counts each operation counted by OP_SPEC that would be executed in a simple sequential execution of the program.",
+        "EventCode": "0x3A",
+        "EventName": "OP_RETIRED",
+        "BriefDescription": "Micro-operation architecturally executed"
+    },
+    {
+        "PublicDescription": "Micro-operation speculatively executed.  The counter counts the number of operations executed by the processing element, including those that are executed speculatively and would not be executed in a simple sequential execution of the program.",
+        "EventCode": "0x3B",
+        "EventName": "OP_SPEC",
+        "BriefDescription": "Micro-operation speculatively executed"
+    },
+    {
+        "PublicDescription": "No operation sent for execution.  The counter counts every attributable cycle on which no attributable instruction or operation was sent for execution on this processing element.",
+        "EventCode": "0x3C",
+        "EventName": "STALL",
+        "BriefDescription": "No operation sent for execution"
+    },
+    {
+        "PublicDescription": "No operation sent for execution on a slot due to the backend.  Counts each slot counted by STALL_SLOT where no attributable instruction or operation was sent for execution because the backend is unable to accept it.",
+        "EventCode": "0x3D",
+        "EventName": "STALL_SLOT_BACKEND",
+        "BriefDescription": "No operation sent for execution on a slot due to the backend"
+    },
+    {
+        "PublicDescription": "No operation sent for execution on a slot due to the frontend.  Counts each slot counted by STALL_SLOT where no attributable instruction or operation was sent for execution because there was no attributable instruction or operation available to issue from the processing element from the frontend for the slot.",
+        "EventCode": "0x3E",
+        "EventName": "STALL_SLOT_FRONTEND",
+        "BriefDescription": "No operation sent for execution on a slot due to the frontend"
+    },
+    {
+        "PublicDescription": "No operation sent for execution on a slot.  The counter counts on each attributable cycle the number of instruction or operation slots that were not occupied by an instruction or operation attributable to the processing element.",
+        "EventCode": "0x3F",
+        "EventName": "STALL_SLOT",
+        "BriefDescription": "No operation sent for execution on a slot"
+    },
+    {
+        "PublicDescription": "Constant frequency cycles.  The counter increments at a constant frequency equal to the rate of increment of the system counter, CNTPCT_EL0.",
+        "EventCode": "0x4004",
+        "EventName": "CNT_CYCLES",
+        "BriefDescription": "Constant frequency cycles"
+    },
+    {
+        "PublicDescription": "Memory stall cycles.  The counter counts each cycle counted by STALL_BACKEND where there is a cache miss in the last level of cache within the processing element clock domain",
+        "EventCode": "0x4005",
+        "EventName": "STALL_BACKEND_MEM",
+        "BriefDescription": "Memory stall cycles"
+    },
+    {
+        "PublicDescription": "Level 1 instruction cache long-latency read miss.  If the L1I_CACHE_RD event is implemented, the counter counts each access counted by L1I_CACHE_RD that incurs additional latency because it returns instructions from outside of the Level 1 instruction cache of this PE.  If the L1I_CACHE_RD event is not implemented, the counter counts each access counted by L1I_CACHE that incurs additional latency because it returns instructions from outside the Level 1 instruction cache of this PE.  The event indicates to software that the access missed in the Level 1 instruction cache and might have a significant performance impact due to the additional latency, compared to the latency of an access that hits in the Level 1 instruction cache.",
+        "EventCode": "0x4006",
+        "EventName": "L1I_CACHE_LMISS",
+        "BriefDescription": "Level 1 instruction cache long-latency read miss"
+    },
+    {
+        "PublicDescription": "Level 2 data cache long-latency read miss.  The counter counts each memory read access counted by L2D_CACHE that incurs additional latency because it returns data from outside the Level 2 data or unified cache of this processing element.  The event indicates to software that the access missed in the Level 2 data or unified cache and might have a significant performance impact compared to the latency of an access that hits in the Level 2 data or unified cache.",
+        "EventCode": "0x4009",
+        "EventName": "L2D_CACHE_LMISS_RD",
+        "BriefDescription": "Level 2 data cache long-latency read miss"
+    },
+    {
+        "PublicDescription": "Level 3 data cache long-latency read miss.  The counter counts each memory read access counted by L3D_CACHE that incurs additional latency because it returns data from outside the Level 3 data or unified cache of this processing element.  The event indicates to software that the access missed in the Level 3 data or unified cache and might have a significant performance impact compared to the latency of an access that hits in the Level 3 data or unified cache.",
+        "EventCode": "0x400B",
+        "EventName": "L3D_CACHE_LMISS_RD",
+        "BriefDescription": "Level 3 data cache long-latency read miss"
+    },
     {
         "PublicDescription": "SIMD Instruction architecturally executed.",
         "EventCode": "0x8000",
-- 
2.17.1

