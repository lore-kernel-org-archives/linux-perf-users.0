Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89057C677F1
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Jan 2023 09:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbjAMJ2m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Jan 2023 04:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjAMJ10 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Jan 2023 04:27:26 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07912431B7;
        Fri, 13 Jan 2023 01:22:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VZUDRVM_1673601761;
Received: from srmbuffer011165236051.sqa.eu95(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZUDRVM_1673601761)
          by smtp.aliyun-inc.com;
          Fri, 13 Jan 2023 17:22:41 +0800
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
Subject: [PATCH v7 8/9] perf vendor events arm64: Add PE utilization metrics for neoverse-n2-v2
Date:   Fri, 13 Jan 2023 17:22:19 +0800
Message-Id: <1673601740-122788-9-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add PE utilization related metrics. In cpu_utilization metric, if it is
neoverse-n2 which slots are 5, the real stall_slot need to subtract the
cpu_cycles according to the neoverse-n2 errata [0].

[0] https://documentation-service.arm.com/static/636a66a64e6cf12278ad89cb?token=

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../arch/arm64/arm/neoverse-n2-v2/metrics.json     | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
index afcdb17..3d6ac0c 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
@@ -160,5 +160,51 @@
         "MetricGroup": "Branch",
         "MetricName": "branch_miss_pred_rate",
         "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "instructions / CPU_CYCLES",
+        "BriefDescription": "The average number of instructions executed for each cycle.",
+        "MetricGroup": "PEutilization",
+        "MetricName": "ipc"
+    },
+    {
+        "MetricExpr": "ipc / 5",
+        "BriefDescription": "IPC percentage of peak. The peak of IPC is 5.",
+        "MetricGroup": "PEutilization",
+        "MetricName": "ipc_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "INST_RETIRED / CPU_CYCLES",
+        "BriefDescription": "Architecturally executed Instructions Per Cycle (IPC)",
+        "MetricGroup": "PEutilization",
+        "MetricName": "retired_ipc"
+    },
+    {
+        "MetricExpr": "INST_SPEC / CPU_CYCLES",
+        "BriefDescription": "Speculatively executed Instructions Per Cycle (IPC)",
+        "MetricGroup": "PEutilization",
+        "MetricName": "spec_ipc"
+    },
+    {
+        "MetricExpr": "OP_RETIRED / OP_SPEC",
+        "BriefDescription": "Of all the micro-operations issued, what percentage are retired(committed)",
+        "MetricGroup": "PEutilization",
+        "MetricName": "retired_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",
+        "BriefDescription": "Of all the micro-operations issued, what percentage are not retired(committed)",
+        "MetricGroup": "PEutilization",
+        "MetricName": "wasted_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "OP_RETIRED / OP_SPEC * (1 - (STALL_SLOT if (#slots - 5) else (STALL_SLOT - CPU_CYCLES)) / (#slots * CPU_CYCLES))",
+        "BriefDescription": "The truly effective ratio of micro-operations executed by the CPU, which means that misprediction and stall are not included",
+        "MetricGroup": "PEutilization",
+        "MetricName": "cpu_utilization",
+        "ScaleUnit": "100%"
     }
 ]
-- 
1.8.3.1

