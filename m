Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE5CC3DA7D
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Jan 2023 11:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbjACLkA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 Jan 2023 06:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjACLj7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Jan 2023 06:39:59 -0500
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DADBD7;
        Tue,  3 Jan 2023 03:39:56 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VYn6ldB_1672745991;
Received: from srmbuffer011165236051.sqa.eu95(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VYn6ldB_1672745991)
          by smtp.aliyun-inc.com;
          Tue, 03 Jan 2023 19:39:52 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v5 2/6] perf vendor events arm64: Add TLB metrics for neoverse-n2
Date:   Tue,  3 Jan 2023 19:39:32 +0800
Message-Id: <1672745976-2800146-3-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add TLB related metrics.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 .../arch/arm64/arm/neoverse-n2/metrics.json        | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
index c126f1bc..8a74e07 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
@@ -26,5 +26,54 @@
         "MetricGroup": "TopdownL1",
         "MetricName": "backend_bound",
         "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "L1D_TLB_REFILL / L1D_TLB",
+        "BriefDescription": "The rate of L1D TLB refill to the overall L1D TLB lookups",
+        "MetricGroup": "TLB",
+        "MetricName": "l1d_tlb_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "L1I_TLB_REFILL / L1I_TLB",
+        "BriefDescription": "The rate of L1I TLB refill to the overall L1I TLB lookups",
+        "MetricGroup": "TLB",
+        "MetricName": "l1i_tlb_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "L2D_TLB_REFILL / L2D_TLB",
+        "BriefDescription": "The rate of L2D TLB refill to the overall L2D TLB lookups",
+        "MetricGroup": "TLB",
+        "MetricName": "l2_tlb_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "DTLB_WALK / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of TLB Walks per kilo instructions for data accesses",
+        "MetricGroup": "TLB",
+        "MetricName": "dtlb_mpki",
+        "ScaleUnit": "MPKI"
+    },
+    {
+        "MetricExpr": "DTLB_WALK / L1D_TLB",
+        "BriefDescription": "The rate of DTLB Walks to the overall L1D TLB lookups",
+        "MetricGroup": "TLB",
+        "MetricName": "dtlb_walk_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "ITLB_WALK / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of TLB Walks per kilo instructions for instruction accesses",
+        "MetricGroup": "TLB",
+        "MetricName": "itlb_mpki",
+        "ScaleUnit": "MPKI"
+    },
+    {
+        "MetricExpr": "ITLB_WALK / L1I_TLB",
+        "BriefDescription": "The rate of ITLB Walks to the overall L1I TLB lookups",
+        "MetricGroup": "TLB",
+        "MetricName": "itlb_walk_rate",
+        "ScaleUnit": "100%"
     }
 ]
-- 
1.8.3.1

