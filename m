Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4E8C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 02:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJDCQb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJDCQ1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Oct 2022 22:16:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F253470E
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Oct 2022 19:16:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-349423f04dbso127694827b3.13
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Oct 2022 19:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=wOCqkT73lJOPzqaB3XEFUXibp2QpYAyxpfecU9cIBE4=;
        b=JZhzkD5ZqZtOT3UKRzXlsN0OQks5rBzok3hFTCsqpWyhl/VqLajyu6ZGb4tXq/aHB+
         LFaqL8zUcTccXJUlCicXWA4dxAjXc84C3adPultI/ppkxOhfBe255mBJPrIiqlKDvYtO
         wDm0y6ktV2vIqb2U8gluFuavvcIWkb9+Tfuhcyuzxrla8s3OMMIDC1XKkwI3IYL8V1w4
         Zo6Ih79avQhkW6WOkeCXTHLOHLIywt3p0p3GlbHLszWCwXKeZobFKBZ4h37SVsJun61U
         SaRGMrJ4FNKGdpF7tBWHm47UY8kdH4S4T8TxP4O6IE8LTSzX60UApeO+TV5h3HcgPkJH
         Jmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=wOCqkT73lJOPzqaB3XEFUXibp2QpYAyxpfecU9cIBE4=;
        b=Dhqy1ypeWw0CsSvPt1YLeuFl86dBQ1YD0tghQwy5mt/StpUOYphznFOzVeKRmFOd9B
         9vEFWXbtF5s7iU8MqyfyDuF9o/rG7QlaTY50o3nhb1IC6yupN3xMWupkBbgXp5Vup3er
         k0Wpsc6xvP/EG1hIVCN7jBiUi8S4CnJsiRdi+73/mtpJbMqz4DoUXsG/7QaH5DzPhrry
         ufb4aa4bBpRrIgJ0wzAbb1pr7W0/gUtgOLRcRmWlZv6KF5GmChFHTmXa1PEhmTw/z0uB
         r/jzwv777Ps3mJkKk5T8af1CM//YBADHNlcoS2eq7X9RS6A92M5RNiYpWrgX0/X36bFv
         8kjQ==
X-Gm-Message-State: ACrzQf2XdlSgNXOTkLIQn+XFd0/ko5eauUAP5irL3Nsuh0hcxj2njllo
        +OJbmu05YWa1KLws/ZZOOxZbv8EPQO8e
X-Google-Smtp-Source: AMsMyM5ufCSceSnxBnOra9CRgFOpPjR8kby9rXIFwIYlKYsssFTdf639OMMNcDBPrjE8GHuJbsPrOmPOkt9F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a81:8ac1:0:b0:357:335:fc2a with SMTP id
 a184-20020a818ac1000000b003570335fc2amr14746770ywg.334.1664849782333; Mon, 03
 Oct 2022 19:16:22 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:15:51 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-3-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 02/23] perf test: Adjust case of test metrics
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Icelake and later architectures have slots events and SLOTS metrics
meaning case sensitivity is important. Make the test metrics case
agree with the name of the metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json | 6 +++---
 tools/perf/pmu-events/empty-pmu-events.c                  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json
index 42d9b5242fd7..70ec8caaaf6f 100644
--- a/tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json
+++ b/tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json
@@ -34,15 +34,15 @@
     "MetricName": "DCache_L2_All_Miss"
   },
   {
-    "MetricExpr": "dcache_l2_all_hits + dcache_l2_all_miss",
+    "MetricExpr": "DCache_L2_All_Hits + DCache_L2_All_Miss",
     "MetricName": "DCache_L2_All"
   },
   {
-    "MetricExpr": "d_ratio(dcache_l2_all_hits, dcache_l2_all)",
+    "MetricExpr": "d_ratio(DCache_L2_All_Hits, DCache_L2_All)",
     "MetricName": "DCache_L2_Hits"
   },
   {
-    "MetricExpr": "d_ratio(dcache_l2_all_miss, dcache_l2_all)",
+    "MetricExpr": "d_ratio(DCache_L2_All_Miss, DCache_L2_All)",
     "MetricName": "DCache_L2_Misses"
   },
   {
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 5ed8c0aa4817..480e8f0d30c8 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -142,15 +142,15 @@ static const struct pmu_event pme_test_soc_cpu[] = {
 		.metric_name	= "DCache_L2_All_Miss",
 	},
 	{
-		.metric_expr	= "dcache_l2_all_hits + dcache_l2_all_miss",
+		.metric_expr	= "DCache_L2_All_Hits + DCache_L2_All_Miss",
 		.metric_name	= "DCache_L2_All",
 	},
 	{
-		.metric_expr	= "d_ratio(dcache_l2_all_hits, dcache_l2_all)",
+		.metric_expr	= "d_ratio(DCache_L2_All_Hits, DCache_L2_All)",
 		.metric_name	= "DCache_L2_Hits",
 	},
 	{
-		.metric_expr	= "d_ratio(dcache_l2_all_miss, dcache_l2_all)",
+		.metric_expr	= "d_ratio(DCache_L2_All_Miss, DCache_L2_All)",
 		.metric_name	= "DCache_L2_Misses",
 	},
 	{
-- 
2.38.0.rc1.362.ged0d419d3c-goog

