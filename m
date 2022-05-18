Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BE8C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 05:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiERF6Y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 01:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiERF6X (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 01:58:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23312BDA11
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 22:58:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a11so1201905pff.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 22:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdRNftbqz062SUroi+THMp5EdRuTKbxiiPN4BQzcTvk=;
        b=qaZvYrewIp1zkBkvCC9lD0FDnwg/+cKd1kjPbUY4NSGhDFmw9cEEKfRKnTDUqFaeA5
         7kUz/JXrZEr6CVLoN33PqY/lz4puAVsVR5LHyUa44ca+IG4Q74/MAu9r4PkfYwsbDqj+
         Dn2kO1+hwhurlmTAW412KjyPzUsLTEneh03i/DubB0CWo+QUkiFgoJsC0qy2QJaJdvqG
         DUao1WcXd4vzqMKzABmrTpG50m8qOFW4UsHAZHKJylAiC4/uhS59Z4Fa7n24hxsLB+2E
         M4f1fjzQVU6pALhTw5YJxvQoC8sCnhlY2ib5ITVsH17Naypf/lC6tk5IYjZ7VQ3IvE7Q
         kdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdRNftbqz062SUroi+THMp5EdRuTKbxiiPN4BQzcTvk=;
        b=mETlD6NgDhSz/KQSbAT6MrO1mVw715DV2uO+rMp4aFNZuPzXALJcrRC0Gjqr++edR3
         zKf1LStI6zQ6ZcIwfCnNnB7rybzlLe6VEOqeJPONDhvNpF+1iGqtpFFjgNSXGKMQ8xbX
         mKM5eXemcBcIHWERTcjYrCVE3+wnHRlMGSMr/kA98VtjoN6lTAvG0IwVwFc63lvMrH9x
         xY1zTrfpc6+6hUPRvbCgpt4xda4nZhn+DcGaFkPN/zMT7bH7di54NWg3kpOvwlcgvgDA
         9QL1f92BnBVWUadNas/rH8RURkruERIfOJ/SJ5NHIy038+pYK6CG5kod47RtfQyJwELd
         0Jcg==
X-Gm-Message-State: AOAM5315paEuVUQKGpDUpfDxiKm8dlgjeJDUbTU2eqJVySJt3TEI6sPS
        2xXgmCqQp3c5Pd2eR9tGiCxtgw==
X-Google-Smtp-Source: ABdhPJxxdQHjfLdMJZp3OR5O+9b3kIKwRq7/rFJaWfRoiCiXsPl9wtUxPufZEW79F6MVst7w3ykZLw==
X-Received: by 2002:a63:1716:0:b0:3f2:52bc:b4f3 with SMTP id x22-20020a631716000000b003f252bcb4f3mr14969890pgl.610.1652853501654;
        Tue, 17 May 2022 22:58:21 -0700 (PDT)
Received: from localhost.localdomain (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb2c2sm627127plb.268.2022.05.17.22.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:58:21 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adam Li <adamli@amperemail.onmicrosoft.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 06/11] perf c2c: Use explicit names for display macros
Date:   Wed, 18 May 2022 13:57:24 +0800
Message-Id: <20220518055729.1869566-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518055729.1869566-1-leo.yan@linaro.org>
References: <20220518055729.1869566-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Perf c2c tool has an assumption that it heavily depends on HITM snoop
type to detect cache false sharing, unfortunately, HITM is not supported
on some architectures.

Essentially, perf c2c tool wants to find some very costly snooping
operations for false cache sharing, this means it's not necessarily
to stick using HITM tags and we can explore other snooping types
(e.g. SNOOPX_PEER).

For this reason, this patch renames HITM related display macros with
suffix '_HITM', so it can be distinct if later add more display types
for on other snooping type.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 58 ++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index b0695cfe793f..47da9ede644b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -114,16 +114,16 @@ struct perf_c2c {
 };
 
 enum {
-	DISPLAY_LCL,
-	DISPLAY_RMT,
-	DISPLAY_TOT,
+	DISPLAY_LCL_HITM,
+	DISPLAY_RMT_HITM,
+	DISPLAY_TOT_HITM,
 	DISPLAY_MAX,
 };
 
 static const char *display_str[DISPLAY_MAX] = {
-	[DISPLAY_LCL] = "Local",
-	[DISPLAY_RMT] = "Remote",
-	[DISPLAY_TOT] = "Total",
+	[DISPLAY_LCL_HITM] = "Local",
+	[DISPLAY_RMT_HITM] = "Remote",
+	[DISPLAY_TOT_HITM] = "Total",
 };
 
 static const struct option c2c_options[] = {
@@ -805,15 +805,15 @@ static double percent_hitm(struct c2c_hist_entry *c2c_he)
 	total = &hists->stats;
 
 	switch (c2c.display) {
-	case DISPLAY_RMT:
+	case DISPLAY_RMT_HITM:
 		st  = stats->rmt_hitm;
 		tot = total->rmt_hitm;
 		break;
-	case DISPLAY_LCL:
+	case DISPLAY_LCL_HITM:
 		st  = stats->lcl_hitm;
 		tot = total->lcl_hitm;
 		break;
-	case DISPLAY_TOT:
+	case DISPLAY_TOT_HITM:
 		st  = stats->tot_hitm;
 		tot = total->tot_hitm;
 	default:
@@ -1179,15 +1179,15 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 			advance_hpp(hpp, ret);
 
 			switch (c2c.display) {
-			case DISPLAY_RMT:
+			case DISPLAY_RMT_HITM:
 				ret = display_metrics(hpp, stats->rmt_hitm,
 						      c2c_he->stats.rmt_hitm);
 				break;
-			case DISPLAY_LCL:
+			case DISPLAY_LCL_HITM:
 				ret = display_metrics(hpp, stats->lcl_hitm,
 						      c2c_he->stats.lcl_hitm);
 				break;
-			case DISPLAY_TOT:
+			case DISPLAY_TOT_HITM:
 				ret = display_metrics(hpp, stats->tot_hitm,
 						      c2c_he->stats.tot_hitm);
 				break;
@@ -1543,9 +1543,9 @@ static struct c2c_dimension dim_tot_loads = {
 };
 
 static struct c2c_header percent_hitm_header[] = {
-	[DISPLAY_LCL] = HEADER_BOTH("Lcl", "Hitm"),
-	[DISPLAY_RMT] = HEADER_BOTH("Rmt", "Hitm"),
-	[DISPLAY_TOT] = HEADER_BOTH("Tot", "Hitm"),
+	[DISPLAY_LCL_HITM] = HEADER_BOTH("Lcl", "Hitm"),
+	[DISPLAY_RMT_HITM] = HEADER_BOTH("Rmt", "Hitm"),
+	[DISPLAY_TOT_HITM] = HEADER_BOTH("Tot", "Hitm"),
 };
 
 static struct c2c_dimension dim_percent_hitm = {
@@ -2016,15 +2016,15 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 
 	switch (c2c.display) {
-	case DISPLAY_LCL:
+	case DISPLAY_LCL_HITM:
 		he->filtered = filter_display(c2c_he->stats.lcl_hitm,
 					      stats->lcl_hitm);
 		break;
-	case DISPLAY_RMT:
+	case DISPLAY_RMT_HITM:
 		he->filtered = filter_display(c2c_he->stats.rmt_hitm,
 					      stats->rmt_hitm);
 		break;
-	case DISPLAY_TOT:
+	case DISPLAY_TOT_HITM:
 		he->filtered = filter_display(c2c_he->stats.tot_hitm,
 					      stats->tot_hitm);
 		break;
@@ -2047,13 +2047,13 @@ static inline bool is_valid_hist_entry(struct hist_entry *he)
 		return true;
 
 	switch (c2c.display) {
-	case DISPLAY_LCL:
+	case DISPLAY_LCL_HITM:
 		has_record = !!c2c_he->stats.lcl_hitm;
 		break;
-	case DISPLAY_RMT:
+	case DISPLAY_RMT_HITM:
 		has_record = !!c2c_he->stats.rmt_hitm;
 		break;
-	case DISPLAY_TOT:
+	case DISPLAY_TOT_HITM:
 		has_record = !!c2c_he->stats.tot_hitm;
 		break;
 	default:
@@ -2750,11 +2750,11 @@ static int setup_display(const char *str)
 	const char *display = str ?: "tot";
 
 	if (!strcmp(display, "tot"))
-		c2c.display = DISPLAY_TOT;
+		c2c.display = DISPLAY_TOT_HITM;
 	else if (!strcmp(display, "rmt"))
-		c2c.display = DISPLAY_RMT;
+		c2c.display = DISPLAY_RMT_HITM;
 	else if (!strcmp(display, "lcl"))
-		c2c.display = DISPLAY_LCL;
+		c2c.display = DISPLAY_LCL_HITM;
 	else {
 		pr_err("failed: unknown display type: %s\n", str);
 		return -1;
@@ -2844,9 +2844,9 @@ static int setup_coalesce(const char *coalesce, bool no_source)
 		return -1;
 
 	if (asprintf(&c2c.cl_resort, "offset,%s",
-		     c2c.display == DISPLAY_TOT ?
+		     c2c.display == DISPLAY_TOT_HITM ?
 		     "tot_hitm" :
-		     c2c.display == DISPLAY_RMT ?
+		     c2c.display == DISPLAY_RMT_HITM ?
 		     "rmt_hitm,lcl_hitm" :
 		     "lcl_hitm,rmt_hitm") < 0)
 		return -ENOMEM;
@@ -3003,11 +3003,11 @@ static int perf_c2c__report(int argc, const char **argv)
 		     "ld_rmthit,rmt_hitm,"
 		     "dram_lcl,dram_rmt";
 
-	if (c2c.display == DISPLAY_TOT)
+	if (c2c.display == DISPLAY_TOT_HITM)
 		sort_str = "tot_hitm";
-	else if (c2c.display == DISPLAY_RMT)
+	else if (c2c.display == DISPLAY_RMT_HITM)
 		sort_str = "rmt_hitm";
-	else if (c2c.display == DISPLAY_LCL)
+	else if (c2c.display == DISPLAY_LCL_HITM)
 		sort_str = "lcl_hitm";
 
 	c2c_hists__reinit(&c2c.hists, output_str, sort_str);
-- 
2.25.1

