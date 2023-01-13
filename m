Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7E4C678D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Jan 2023 09:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbjAMJ2n (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Jan 2023 04:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240980AbjAMJ1X (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Jan 2023 04:27:23 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30684319E;
        Fri, 13 Jan 2023 01:22:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VZUDRVD_1673601760;
Received: from srmbuffer011165236051.sqa.eu95(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZUDRVD_1673601760)
          by smtp.aliyun-inc.com;
          Fri, 13 Jan 2023 17:22:40 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
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
Subject: [PATCH v7 7/9] perf vendor events arm64: Add branch metrics for neoverse-n2-v2
Date:   Fri, 13 Jan 2023 17:22:18 +0800
Message-Id: <1673601740-122788-8-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add branch related metrics.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../arch/arm64/arm/neoverse-n2-v2/metrics.json      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
index 08c6aaa..afcdb17 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
@@ -139,5 +139,26 @@
         "MetricGroup": "Cache",
         "MetricName": "ll_cache_read_hit_rate",
         "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "BR_MIS_PRED_RETIRED / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of branches mis-predicted per kilo instructions",
+        "MetricGroup": "Branch",
+        "MetricName": "branch_mpki",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricExpr": "BR_RETIRED / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of branches retired per kilo instructions",
+        "MetricGroup": "Branch",
+        "MetricName": "branch_pki",
+        "ScaleUnit": "1PKI"
+    },
+    {
+        "MetricExpr": "BR_MIS_PRED_RETIRED / BR_RETIRED",
+        "BriefDescription": "The rate of branches mis-predited to the overall branches",
+        "MetricGroup": "Branch",
+        "MetricName": "branch_miss_pred_rate",
+        "ScaleUnit": "100%"
     }
 ]
-- 
1.8.3.1

