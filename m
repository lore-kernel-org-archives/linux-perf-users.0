Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75B5C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 02:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC6E61040
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 02:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbhHJCHS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 22:07:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:10920 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237332AbhHJCHR (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 22:07:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="212962412"
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="scan'208";a="212962412"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 19:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="scan'208";a="444808325"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga007.fm.intel.com with ESMTP; 09 Aug 2021 19:06:51 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        irogers@google.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 2/6] perf vendor events intel: Update uncore event list for CascadeLake Server
Date:   Tue, 10 Aug 2021 10:05:04 +0800
Message-Id: <20210810020508.31261-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810020508.31261-1-yao.jin@linux.intel.com>
References: <20210810020508.31261-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update JSON uncore events for CascadeLake Server.

Based on JSON list v1.11:

https://download.01.org/perfmon/CLX/

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 .../arch/x86/cascadelakex/uncore-memory.json  |  21 +--
 .../arch/x86/cascadelakex/uncore-other.json   | 161 ++++++++++++++++--
 2 files changed, 157 insertions(+), 25 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
index 4ba9e6d9f25e..2600fd8d7a54 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
@@ -64,15 +64,6 @@
         "UMask": "0x4",
         "Unit": "iMC"
     },
-    {
-        "BriefDescription": "Pre-charge for writes",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2",
-        "EventName": "UNC_M_PRE_COUNT.WR",
-        "PerPkg": "1",
-        "UMask": "0x8",
-        "Unit": "iMC"
-    },
     {
         "BriefDescription": "Write requests allocated in the PMM Write Pending Queue for Intel Optane DC persistent memory",
         "Counter": "0,1,2,3",
@@ -90,32 +81,32 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Intel Optane DC persistent memory bandwidth read (MB). Derived from unc_m_pmm_rpq_inserts",
+        "BriefDescription": "Intel Optane DC persistent memory bandwidth read (MB/sec). Derived from unc_m_pmm_rpq_inserts",
         "Counter": "0,1,2,3",
         "EventCode": "0xE3",
         "EventName": "UNC_M_PMM_BANDWIDTH.READ",
         "PerPkg": "1",
-        "ScaleUnit": "6.103515625E-5MB",
+        "ScaleUnit": "6.103515625E-5MB/sec",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Intel Optane DC persistent memory bandwidth write (MB). Derived from unc_m_pmm_wpq_inserts",
+        "BriefDescription": "Intel Optane DC persistent memory bandwidth write (MB/sec). Derived from unc_m_pmm_wpq_inserts",
         "Counter": "0,1,2,3",
         "EventCode": "0xE7",
         "EventName": "UNC_M_PMM_BANDWIDTH.WRITE",
         "PerPkg": "1",
-        "ScaleUnit": "6.103515625E-5MB",
+        "ScaleUnit": "6.103515625E-5MB/sec",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Intel Optane DC persistent memory bandwidth total (MB). Derived from unc_m_pmm_rpq_inserts",
+        "BriefDescription": "Intel Optane DC persistent memory bandwidth total (MB/sec). Derived from unc_m_pmm_rpq_inserts",
         "Counter": "0,1,2,3",
         "EventCode": "0xE3",
         "EventName": "UNC_M_PMM_BANDWIDTH.TOTAL",
         "MetricExpr": "UNC_M_PMM_RPQ_INSERTS + UNC_M_PMM_WPQ_INSERTS",
         "MetricName": "UNC_M_PMM_BANDWIDTH.TOTAL",
         "PerPkg": "1",
-        "ScaleUnit": "6.103515625E-5MB",
+        "ScaleUnit": "6.103515625E-5MB/sec",
         "Unit": "iMC"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
index 0cd083839e75..3be09986ce8b 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
@@ -103,15 +103,6 @@
         "UMask": "0x04",
         "Unit": "CHA"
     },
-    {
-        "BriefDescription": "write requests from remote home agent",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.WRITES_REMOTE",
-        "PerPkg": "1",
-        "UMask": "0x08",
-        "Unit": "CHA"
-    },
     {
         "BriefDescription": "UPI interconnect send bandwidth for payload. Derived from unc_upi_txl_flits.all_data",
         "Counter": "0,1,2,3",
@@ -544,7 +535,7 @@
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
         "Filter": "config1=0x40433",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : DRds issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores that Missed the LLC : Counts the number of entries successfuly inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
         "Unit": "CHA"
     },
@@ -567,6 +558,98 @@
         "PublicDescription": "Counts clockticks of the 1GHz trafiic controller clock in the IIO unit.",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions with data: Part 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
+        "FCMask": "0x4",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "PCIe Completion Buffer Inserts of completions with data: Part 0",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions with data: Part 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART1",
+        "FCMask": "0x4",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "PCIe Completion Buffer Inserts of completions with data: Part 1",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions with data: Part 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART2",
+        "FCMask": "0x4",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "PCIe Completion Buffer Inserts of completions with data: Part 2",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions with data: Part 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART3",
+        "FCMask": "0x4",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "PCIe Completion Buffer Inserts of completions with data: Part 3",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer occupancy of completions with data: Part 0",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART0",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PublicDescription": "PCIe Completion Buffer occupancy of completions with data: Part 0",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer occupancy of completions with data: Part 1",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART1",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PublicDescription": "PCIe Completion Buffer occupancy of completions with data: Part 1",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer occupancy of completions with data: Part 2",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART2",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PublicDescription": "PCIe Completion Buffer occupancy of completions with data: Part 2",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer occupancy of completions with data: Part 3",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART3",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PublicDescription": "PCIe Completion Buffer occupancy of completions with data: Part 3",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Read request for 4 bytes made by the CPU to IIO Part0",
         "Counter": "2,3",
@@ -1239,6 +1322,64 @@
         "UMask": "0x02",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Total IRP occupancy of inbound read and write requests.",
+        "Counter": "0,1",
+        "EventCode": "0xF",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.MEM",
+        "PerPkg": "1",
+        "PublicDescription": "Total IRP occupancy of inbound read and write requests.  This is effectively the sum of read occupancy and write occupancy.",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "PCIITOM request issued by the IRP unit to the mesh with the intention of writing a full cacheline.",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.PCITOM",
+        "PerPkg": "1",
+        "PublicDescription": "PCIITOM request issued by the IRP unit to the mesh with the intention of writing a full cacheline to coherent memory, without a RFO.  PCIITOM is a speculative Invalidate to Modified command that requests ownership of the cacheline and does not move data from the mesh to IRP cache.",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "RFO request issued by the IRP unit to the mesh with the intention of writing a partial cacheline.",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.RFO",
+        "PerPkg": "1",
+        "PublicDescription": "RFO request issued by the IRP unit to the mesh with the intention of writing a partial cacheline to coherent memory.  RFO is a Read For Ownership command that requests ownership of the cacheline and moves data from the mesh to IRP cache.",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound read requests received by the IRP and inserted into the FAF queue.",
+        "Counter": "0,1",
+        "EventCode": "0x18",
+        "EventName": "UNC_I_FAF_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Inbound read requests to coherent memory, received by the IRP and inserted into the Fire and Forget queue (FAF), a queue used for processing inbound reads in the IRP.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Occupancy of the IRP FAF queue.",
+        "Counter": "0,1",
+        "EventCode": "0x19",
+        "EventName": "UNC_I_FAF_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy of the IRP Fire and Forget (FAF) queue, a queue used for processing inbound reads in the IRP.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound write (fast path) requests received by the IRP.",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "Inbound write (fast path) requests to coherent memory, received by the IRP resulting in write ownership requests issued by IRP to the mesh.",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Traffic in which the M2M to iMC Bypass was not taken",
         "Counter": "0,1,2,3",
-- 
2.17.1

