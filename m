Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B7AC19F2D
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Aug 2022 06:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiHKG03 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Aug 2022 02:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbiHKG0D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Aug 2022 02:26:03 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D00B6C113
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 23:26:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m2so16186560pls.4
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 23:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KK3AYhpOaEZyFXc2AM+ccZ9AFCKAu0zd/QkjACqJ+To=;
        b=EAWk6DSIbWhUS/bq3fETlI7OJ0dqzQseOxYT3zdPzuKIgZ/8C8N6XUiKa6hNWr8PLN
         wYCAc2McNQYSgcKaLfNoAiYnUF5OVxCRqul+r0iQ4B28VIXsR1Kb4FCn4PVhcitQNY90
         537FTs6OGExUglqrhISwZmTmBb49qkreKdKfH2WshhLMADWVpZHEuKYJuDrFil5lBgY3
         mf+OClbCsCJhO24WytV+Y/vC69h33JDjDcPAZot59CHjWtc5wla/Rchbz1J9poU+RUj1
         0mm+9VKEZq7+4U/KWShT2+yqF+zn72kyzofJhno1T+2NuHwI6ExQWkqbgIOCY1z/zmvZ
         fvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KK3AYhpOaEZyFXc2AM+ccZ9AFCKAu0zd/QkjACqJ+To=;
        b=OQjeZ4IPALF1Cth7q/+DNNSVnMi3FTGq10/+Lmod5eFN1AfBjRCgC4q5m5QbOCEC1T
         e+TEzcITIwnszNh5Ajc4JS9V909cHjBNHx36YeTeuo0EQDrvavtGpbDyOr0Vj8FoITyk
         AK2PR7HNSrdLx61zoMsDxlgcA5/I/stw60BsHMckVMNL41XRzykkoC6uQwFHH3s1LOtx
         BY5jLxcxf549buCrKe/EPZiIP0jEBePH02KpP6Yrt/LAcnPSLwPYga5Z6B364JqatO8U
         g0FksfbTsTX2r+ZTN3J/DfrkMc5d12X2oLOEeMS5zErJv0JdN5TB9Wdra4Dip+xrqwcM
         jGVw==
X-Gm-Message-State: ACgBeo2iMqxDA0XFQQ+dCrbC3Vuh3Je9bGbBXMCH6vI2/+XlSMIheZSb
        FQHZsFl3jz41iX6QMSkqYkGsaw==
X-Google-Smtp-Source: AA6agR79F0yErYBI6IchkNV6wVJkvnnl7tUKqNDXOOXvqUl0+GXnCOmGbKcBgfBgeV6xVuuLvXiDGw==
X-Received: by 2002:a17:903:24e:b0:16b:9fa2:41e5 with SMTP id j14-20020a170903024e00b0016b9fa241e5mr31188685plh.127.1660199159907;
        Wed, 10 Aug 2022 23:25:59 -0700 (PDT)
Received: from leoy-yangtze.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a55cc00b001f506009036sm2766926pjm.49.2022.08.10.23.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:25:59 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Timothy Hayes <timothy.hayes@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 10/15] perf c2c: Rename dimension from 'percent_hitm' to 'percent_costly_snoop'
Date:   Thu, 11 Aug 2022 14:24:46 +0800
Message-Id: <20220811062451.435810-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220811062451.435810-1-leo.yan@linaro.org>
References: <20220811062451.435810-1-leo.yan@linaro.org>
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
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index cbeb1878a71c..66ff834516a2 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -798,7 +798,7 @@ percent_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return hpp_color_scnprintf(hpp, "%*.2f%%", width - 1, per);
 }
 
-static double percent_hitm(struct c2c_hist_entry *c2c_he)
+static double percent_costly_snoop(struct c2c_hist_entry *c2c_he)
 {
 	struct c2c_hists *hists;
 	struct c2c_stats *stats;
@@ -838,8 +838,8 @@ static double percent_hitm(struct c2c_hist_entry *c2c_he)
 })
 
 static int
-percent_hitm_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
-		   struct hist_entry *he)
+percent_costly_snoop_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			   struct hist_entry *he)
 {
 	struct c2c_hist_entry *c2c_he;
 	int width = c2c_width(fmt, hpp, he->hists);
@@ -847,20 +847,20 @@ percent_hitm_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
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
@@ -870,8 +870,8 @@ percent_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	c2c_left  = container_of(left, struct c2c_hist_entry, he);
 	c2c_right = container_of(right, struct c2c_hist_entry, he);
 
-	per_left  = percent_hitm(c2c_left);
-	per_right = percent_hitm(c2c_right);
+	per_left  = percent_costly_snoop(c2c_left);
+	per_right = percent_costly_snoop(c2c_right);
 
 	return per_left - per_right;
 }
@@ -1605,17 +1605,17 @@ static struct c2c_dimension dim_tot_loads = {
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
 
@@ -1844,7 +1844,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_ld_rmthit,
 	&dim_tot_recs,
 	&dim_tot_loads,
-	&dim_percent_hitm,
+	&dim_percent_costly_snoop,
 	&dim_percent_rmt_hitm,
 	&dim_percent_lcl_hitm,
 	&dim_percent_rmt_peer,
@@ -2748,7 +2748,7 @@ static int ui_quirks(void)
 		nodestr = "CL";
 	}
 
-	dim_percent_hitm.header = percent_hitm_header[c2c.display];
+	dim_percent_costly_snoop.header = percent_costly_snoop_header[c2c.display];
 
 	/* Fix the zero line for dcacheline column. */
 	buf = fill_line("Cacheline", dim_dcacheline.width +
@@ -3076,7 +3076,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		     "dcacheline,"
 		     "dcacheline_node,"
 		     "dcacheline_count,"
-		     "percent_hitm,"
+		     "percent_costly_snoop,"
 		     "tot_hitm,lcl_hitm,rmt_hitm,"
 		     "tot_recs,"
 		     "tot_loads,"
-- 
2.34.1

