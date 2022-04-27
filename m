Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6501C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Apr 2022 15:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbiD0PyZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Apr 2022 11:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbiD0PyY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Apr 2022 11:54:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ED755491
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Apr 2022 08:51:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p6so1851700pjm.1
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Apr 2022 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGgnAx4Mmsc3hvOXFTE9LvmnzJdy1NstuQsMaBF2v6k=;
        b=jZfqziaMwqBPhEUX1dILp3PQ35E2S1QSqstePpWCc7dvBWpMrlLWfOny2P7bmpSsJn
         jkosoLF3BRYW5oz/sKefFJflfOiYeoBN/XA9nXmFT68amrM6xcrukpV24pLUPIkh9reE
         CqjyPGuhSa5c6KmmrKwT3b9sxnotpc/Kx/QUDbTqxR/uLh1GgetrOS+NaVDTJIhb84JP
         /3YV3jKhkVcb0DZNViZ2tRNHFi3YiR+Y8Kzv+kbUioqSajAYJINM7OPc9b4kOW4DATZY
         whkcubeaW+QSN98F/++IydC2/+kBjNYLqU2Bp31t40vY5IKb18j5aoR8HPwjr7dBveHD
         MpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGgnAx4Mmsc3hvOXFTE9LvmnzJdy1NstuQsMaBF2v6k=;
        b=flX20xnZJKyJL0xxOjUM0lk9A0HJyDgxDA+vC9EWq4oxSbhxkyXGSL17vQA1te7HTb
         MzZp0S39Rx7UTpXEpDb4aaeIXiS7Bn92S+jFAhko1vfm1x8JPpZuEyanHvnk5vK6aDNX
         2DJO5f77OAtmF95vhapavZvFYt6RqTRC6z0pYabNboc70tO12N+IQ9FPIjLOotdgb0rt
         wWHHBwsIF2nmelxnOe5Z/69Zlj6CxCxqx3CLs4km/+7nsgcgot01uyHkc5FQl8tpzRGL
         8SrK1YoFhJsLdmPfWM3XniD7K+K3T3WZRE4v8Vblf/zAi3tzC2ep7VXDOxeuAgzMNntC
         YoGw==
X-Gm-Message-State: AOAM533xhc2fBdSU0nL5KwRTSUGlJ+K571i/6z0pNoHSkdfmqJC/54k+
        aPo5+Cie5Nun5EvO9XlrGqah8A==
X-Google-Smtp-Source: ABdhPJwdjCgONXFUE3FwPDhQL9ISzYMBoY57LwZ6Sz+XlLzu7O9ILkvuqgEpf8KlbS8gSXNC8l+l5A==
X-Received: by 2002:a17:902:8501:b0:15c:ea4b:1398 with SMTP id bj1-20020a170902850100b0015cea4b1398mr22238822plb.109.1651074665565;
        Wed, 27 Apr 2022 08:51:05 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm19164127pfb.185.2022.04.27.08.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:51:05 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Ali Saidi <alisaidi@amazon.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 06/11] perf c2c: Use explicit names for display macros
Date:   Wed, 27 Apr 2022 23:50:08 +0800
Message-Id: <20220427155013.1833222-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427155013.1833222-1-leo.yan@linaro.org>
References: <20220427155013.1833222-1-leo.yan@linaro.org>
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
index cef6513012e2..e4697cdbdfc2 100644
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
@@ -807,15 +807,15 @@ static double percent_hitm(struct c2c_hist_entry *c2c_he)
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
@@ -1181,15 +1181,15 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
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
@@ -1545,9 +1545,9 @@ static struct c2c_dimension dim_tot_loads = {
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
@@ -2018,15 +2018,15 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
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
@@ -2049,13 +2049,13 @@ static inline bool is_valid_hist_entry(struct hist_entry *he)
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
@@ -2752,11 +2752,11 @@ static int setup_display(const char *str)
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
@@ -2846,9 +2846,9 @@ static int setup_coalesce(const char *coalesce, bool no_source)
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
@@ -3005,11 +3005,11 @@ static int perf_c2c__report(int argc, const char **argv)
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

