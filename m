Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91688C4320A
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 05:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E73F60F55
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 05:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhHBFgb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 01:36:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:50150 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231932AbhHBFgb (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Aug 2021 01:36:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10063"; a="210281240"
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="210281240"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2021 22:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="457815949"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2021 22:36:19 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/2] perf vendor events intel: Add basic metrics for Elkhartlake
Date:   Mon,  2 Aug 2021 13:34:40 +0800
Message-Id: <20210802053440.21035-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210802053440.21035-1-yao.jin@linux.intel.com>
References: <20210802053440.21035-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add JSON metrics for Elkhartlake to perf.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
v2:
 - No change.

 .../arch/x86/elkhartlake/ehl-metrics.json     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json

diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json b/tools/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json
new file mode 100644
index 000000000000..b6f7126be1fd
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json
@@ -0,0 +1,57 @@
+[
+    {
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
+        "MetricName": "IPC"
+    },
+    {
+        "MetricExpr": "1 / IPC",
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
+        "MetricName": "CPI"
+    },
+    {
+        "MetricExpr": "cycles",
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
+        "MetricName": "CLKS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
+        "MetricName": "IpMispredict"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
+        "MetricName": "IpBranch"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions",
+        "MetricName": "Instructions"
+    },
+    {
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 ",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
+        "MetricName": "CPU_Utilization"
+    },
+    {
+        "MetricExpr": "(cycles / CPU_CLK_UNHALTED.REF_TSC) * msr@tsc@ / 1000000000 ",
+        "BriefDescription": "Measured Average Frequency for unhalted processors [GHz]",
+        "MetricName": "Average_Frequency"
+    },
+    {
+        "MetricExpr": "cycles / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricName": "Turbo_Utilization"
+    },
+    {
+        "MetricExpr": "cycles:k / cycles",
+        "BriefDescription": "Fraction of cycles spent in the Operating System (OS) Kernel mode",
+        "MetricName": "Kernel_Utilization"
+    }
+]
-- 
2.17.1

