Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038BAECAAD8
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Sep 2022 12:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiINMBI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Sep 2022 08:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiINMAn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Sep 2022 08:00:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2477F090
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Sep 2022 05:00:41 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MSJhp07bGzlVqQ;
        Wed, 14 Sep 2022 19:56:42 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 20:00:40 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 20:00:39 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 4/5] perf stat: Add print_cache_common helper
Date:   Wed, 14 Sep 2022 20:35:06 +0800
Message-ID: <20220914123507.23319-5-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914123507.23319-1-shangxiaojing@huawei.com>
References: <20220914123507.23319-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Wrap repeated code in helper function print_cache_common, which is used
to print cache event.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/util/stat-shadow.c | 80 +++++++++++------------------------
 1 file changed, 25 insertions(+), 55 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 788ce5e46470..706b71db50f7 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -533,23 +533,34 @@ static void print_stalled_cycles_backend(struct perf_stat_config *config,
 	out->print_metric(config, out->ctx, color, "%7.2f%%", "backend cycles idle", ratio);
 }
 
-static void print_branch_misses(struct perf_stat_config *config,
+static void print_cache_common(struct perf_stat_config *config,
 				int cpu_map_idx, double avg,
 				struct perf_stat_output_ctx *out,
 				struct runtime_stat *st,
-				struct runtime_stat_data *rsd)
+				struct runtime_stat_data *rsd,
+				enum stat_type type, const char *desc)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_BRANCHES, cpu_map_idx, rsd);
+	total = runtime_stat_avg(st, type, cpu_map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
 
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all branches", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", desc, ratio);
+}
+
+static void print_branch_misses(struct perf_stat_config *config,
+				int cpu_map_idx, double avg,
+				struct perf_stat_output_ctx *out,
+				struct runtime_stat *st,
+				struct runtime_stat_data *rsd)
+{
+	print_cache_common(config, cpu_map_idx, avg, out, st, rsd,
+			   STAT_BRANCHES, "of all branches");
 }
 
 static void print_l1_dcache_misses(struct perf_stat_config *config,
@@ -558,17 +569,8 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
 				   struct runtime_stat *st,
 				   struct runtime_stat_data *rsd)
 {
-	double total, ratio = 0.0;
-	const char *color;
-
-	total = runtime_stat_avg(st, STAT_L1_DCACHE, cpu_map_idx, rsd);
-
-	if (total)
-		ratio = avg / total * 100.0;
-
-	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache accesses", ratio);
+	print_cache_common(config, cpu_map_idx, avg, out, st, rsd,
+			   STAT_L1_DCACHE, "of all L1-dcache accesses");
 }
 
 static void print_l1_icache_misses(struct perf_stat_config *config,
@@ -577,16 +579,8 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
 				   struct runtime_stat *st,
 				   struct runtime_stat_data *rsd)
 {
-	double total, ratio = 0.0;
-	const char *color;
-
-	total = runtime_stat_avg(st, STAT_L1_ICACHE, cpu_map_idx, rsd);
-
-	if (total)
-		ratio = avg / total * 100.0;
-
-	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache accesses", ratio);
+	print_cache_common(config, cpu_map_idx, avg, out, st, rsd,
+			   STAT_L1_ICACHE, "of all L1-icache accesses");
 }
 
 static void print_dtlb_cache_misses(struct perf_stat_config *config,
@@ -595,16 +589,8 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
 				    struct runtime_stat *st,
 				    struct runtime_stat_data *rsd)
 {
-	double total, ratio = 0.0;
-	const char *color;
-
-	total = runtime_stat_avg(st, STAT_DTLB_CACHE, cpu_map_idx, rsd);
-
-	if (total)
-		ratio = avg / total * 100.0;
-
-	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache accesses", ratio);
+	print_cache_common(config, cpu_map_idx, avg, out, st, rsd,
+			   STAT_DTLB_CACHE, "of all dTLB cache accesses");
 }
 
 static void print_itlb_cache_misses(struct perf_stat_config *config,
@@ -613,16 +599,8 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
 				    struct runtime_stat *st,
 				    struct runtime_stat_data *rsd)
 {
-	double total, ratio = 0.0;
-	const char *color;
-
-	total = runtime_stat_avg(st, STAT_ITLB_CACHE, cpu_map_idx, rsd);
-
-	if (total)
-		ratio = avg / total * 100.0;
-
-	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache accesses", ratio);
+	print_cache_common(config, cpu_map_idx, avg, out, st, rsd,
+			   STAT_ITLB_CACHE, "of all iTLB cache accesses");
 }
 
 static void print_ll_cache_misses(struct perf_stat_config *config,
@@ -631,16 +609,8 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
 				  struct runtime_stat *st,
 				  struct runtime_stat_data *rsd)
 {
-	double total, ratio = 0.0;
-	const char *color;
-
-	total = runtime_stat_avg(st, STAT_LL_CACHE, cpu_map_idx, rsd);
-
-	if (total)
-		ratio = avg / total * 100.0;
-
-	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache accesses", ratio);
+	print_cache_common(config, cpu_map_idx, avg, out, st, rsd,
+			   STAT_LL_CACHE, "of all LL-cache accesses");
 }
 
 /*
-- 
2.17.1

