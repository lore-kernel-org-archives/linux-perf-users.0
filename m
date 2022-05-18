Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D1BC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 05:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiERF6e (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 01:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiERF62 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 01:58:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E150BDA30
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 22:58:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m1so825267plx.3
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 22:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJUhjlZ9ED7ajIYwzQoH8AvOBsr3wqVHoXYlCKCmbYM=;
        b=Xj82cjpjjDHFMAEcEEptzgCrEudqLRxVW6xOD1YIdqoKUH4vipaX/6pbKk5zc20av3
         O3Eu+oCvFV2/sNreA2ZS7LssqtlLjuPzzzdzPHyN0DmDvZoQPuSen3itDXyEQSrrm+A8
         /edKNyqGz3rSP5d94y0+tglI7AntzzWpZGhl1UR32fO/avNf/QsY21ay7K1olZRZVEnZ
         fZPoSwvDGZFiJiNppMCnQOwh7gelkkY95XE+Q+2Rn22MzeON7G3rnXbv6ZsYlRRZz4Zv
         m+Raootb0qnTa9vmZeSu5+0xIs2nS6SMONpc92xSkYD9PkHli8YLPc31rg+mSS0vkzKu
         +KCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJUhjlZ9ED7ajIYwzQoH8AvOBsr3wqVHoXYlCKCmbYM=;
        b=pk5Sf1CVARe/iPnk5Y9/hfkmUg9T08c+hbllQqQV+MBkTJ/u/a/RebORZ764hDWMpa
         WlTE2u6zIcOaYL5mOBw6paIUn+QPdpiv5y7Mm3UaQJ1/EhzHLhemBmKCuRtrJi/sr1N1
         Qs6XPuV1gSrOyBzt/IzS3mpwgCUmlqma2u7fjBf2fbSo/C/RyPNhdBiVev3B/5a9TMQ3
         wFf5oEMM5mq1Co1idHaLdNQKKwZAXbJ+yLa5Fi/BcnaOHgz+/XjOEF5YFVPhaMDXluWn
         LEJ3V+EJcdlaj77bhi8D6vswubfQlWmm6g+F6PdnGrHWShngHQTE+V9we3pv/CancZ5/
         fWfw==
X-Gm-Message-State: AOAM531E+iMExDDT2xooHn8s9B2eVOMMe7svus53qlJmhTRAdf+qvQ7g
        9hq0cx0VRSohdxyjrXIAXDI2ig==
X-Google-Smtp-Source: ABdhPJy9oCJW+zIRsVElc0K+ARi4WOdaNP+S1ilr+NcDiyTROuZjwCElBrGjHLR4kel7ldMlwNf0vw==
X-Received: by 2002:a17:902:ccd0:b0:156:7ac2:5600 with SMTP id z16-20020a170902ccd000b001567ac25600mr26139354ple.156.1652853506568;
        Tue, 17 May 2022 22:58:26 -0700 (PDT)
Received: from localhost.localdomain (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb2c2sm627127plb.268.2022.05.17.22.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:58:26 -0700 (PDT)
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
Subject: [PATCH v3 07/11] perf c2c: Rename dimension from 'percent_hitm' to 'percent_costly_snoop'
Date:   Wed, 18 May 2022 13:57:25 +0800
Message-Id: <20220518055729.1869566-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518055729.1869566-1-leo.yan@linaro.org>
References: <20220518055729.1869566-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use more general naming for the main sort dimension, this can allow us
not to sort only on HITM snoop type, so it can be extended to support
other costly snooping operations.  So rename the dimension to the prefix
'percent_costly_".

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 47da9ede644b..ace7ead4ab75 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -792,7 +792,7 @@ percent_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return hpp_color_scnprintf(hpp, "%*.2f%%", width - 1, per);
 }
 
-static double percent_hitm(struct c2c_hist_entry *c2c_he)
+static double percent_costly_snoop(struct c2c_hist_entry *c2c_he)
 {
 	struct c2c_hists *hists;
 	struct c2c_stats *stats;
@@ -832,8 +832,8 @@ static double percent_hitm(struct c2c_hist_entry *c2c_he)
 })
 
 static int
-percent_hitm_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
-		   struct hist_entry *he)
+percent_costly_snoop_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			   struct hist_entry *he)
 {
 	struct c2c_hist_entry *c2c_he;
 	int width = c2c_width(fmt, hpp, he->hists);
@@ -841,20 +841,20 @@ percent_hitm_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	double per;
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
-	per = percent_hitm(c2c_he);
+	per = percent_costly_snoop(c2c_he);
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
 }
 
 static int
-percent_hitm_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
-		   struct hist_entry *he)
+percent_costly_snoop_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			   struct hist_entry *he)
 {
-	return percent_color(fmt, hpp, he, percent_hitm);
+	return percent_color(fmt, hpp, he, percent_costly_snoop);
 }
 
 static int64_t
-percent_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
-		 struct hist_entry *left, struct hist_entry *right)
+percent_costly_snoop_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			 struct hist_entry *left, struct hist_entry *right)
 {
 	struct c2c_hist_entry *c2c_left;
 	struct c2c_hist_entry *c2c_right;
@@ -864,8 +864,8 @@ percent_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	c2c_left  = container_of(left, struct c2c_hist_entry, he);
 	c2c_right = container_of(right, struct c2c_hist_entry, he);
 
-	per_left  = percent_hitm(c2c_left);
-	per_right = percent_hitm(c2c_right);
+	per_left  = percent_costly_snoop(c2c_left);
+	per_right = percent_costly_snoop(c2c_right);
 
 	return per_left - per_right;
 }
@@ -1542,17 +1542,17 @@ static struct c2c_dimension dim_tot_loads = {
 	.width		= 7,
 };
 
-static struct c2c_header percent_hitm_header[] = {
+static struct c2c_header percent_costly_snoop_header[] = {
 	[DISPLAY_LCL_HITM] = HEADER_BOTH("Lcl", "Hitm"),
 	[DISPLAY_RMT_HITM] = HEADER_BOTH("Rmt", "Hitm"),
 	[DISPLAY_TOT_HITM] = HEADER_BOTH("Tot", "Hitm"),
 };
 
-static struct c2c_dimension dim_percent_hitm = {
-	.name		= "percent_hitm",
-	.cmp		= percent_hitm_cmp,
-	.entry		= percent_hitm_entry,
-	.color		= percent_hitm_color,
+static struct c2c_dimension dim_percent_costly_snoop = {
+	.name		= "percent_costly_snoop",
+	.cmp		= percent_costly_snoop_cmp,
+	.entry		= percent_costly_snoop_entry,
+	.color		= percent_costly_snoop_color,
 	.width		= 7,
 };
 
@@ -1761,7 +1761,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_ld_rmthit,
 	&dim_tot_recs,
 	&dim_tot_loads,
-	&dim_percent_hitm,
+	&dim_percent_costly_snoop,
 	&dim_percent_rmt_hitm,
 	&dim_percent_lcl_hitm,
 	&dim_percent_ld_peer,
@@ -2663,7 +2663,7 @@ static int ui_quirks(void)
 		nodestr = "CL";
 	}
 
-	dim_percent_hitm.header = percent_hitm_header[c2c.display];
+	dim_percent_costly_snoop.header = percent_costly_snoop_header[c2c.display];
 
 	/* Fix the zero line for dcacheline column. */
 	buf = fill_line("Cacheline", dim_dcacheline.width +
@@ -2991,7 +2991,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		     "dcacheline,"
 		     "dcacheline_node,"
 		     "dcacheline_count,"
-		     "percent_hitm,"
+		     "percent_costly_snoop,"
 		     "tot_hitm,lcl_hitm,rmt_hitm,"
 		     "ld_peer,"
 		     "tot_recs,"
-- 
2.25.1

