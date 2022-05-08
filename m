Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778DBC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun,  8 May 2022 09:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiEHJ3R (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 8 May 2022 05:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbiEHJ3N (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 8 May 2022 05:29:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE38E019
        for <linux-perf-users@vger.kernel.org>; Sun,  8 May 2022 02:25:23 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id bo5so9861445pfb.4
        for <linux-perf-users@vger.kernel.org>; Sun, 08 May 2022 02:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUGLoaJd3B+TtNu4b8kB3fkRxS/7EQl4VGMpMCSV3Jc=;
        b=WcsX1Z9JcIs+2mCuBtKVYji34LP/dT9i3R1idr1sUXRNJ9K+X++C8Sjl9mL8UbnUii
         CigGlzLmEtYk/4yFMQjo3mccYBhlj76aqiP8tdbgYtPb7RPT/PIrwMu22q48fqrOL80j
         dbnP/S11EPibLBVpJym5ahAFCbwh7f4PVb43L+8Ekl6gg7F7SBCLbJVVgO6fnP/T8Cid
         H0AiB1Ri3I0nC1izG1lGgjeG+OnaLUJF+cPAz0iit5YbVVMuNKBSnHlSxc4NOmsEme2Q
         fUO0qDUX9ANXfiF975UZx1LukOByflPmNNRhShEENC71z74qyezRrrj5XNKs+vLXMcEY
         lXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUGLoaJd3B+TtNu4b8kB3fkRxS/7EQl4VGMpMCSV3Jc=;
        b=MfhpKDeNJE1PofdYoACzM7Vg8EIrl4KWmVaVkhNgpZ+Dc7SdzYKmnCiyNGn71QxF1U
         eVd8hdb3FFLnxN3oFmlXr7P4ST05+y1+X7gsVqXVl/gMQ+oXoIMjEVfFHIdLatTmvDAp
         cH26iw86XM9Fx7M7PG7fXHkAOyecL8GEbN50axu82TqXIASsUQVPsh3lBzMSPiFP6JhP
         FxLgKHUjgWr+D2gndGtH/PbA42mCDcx3csXiKwBJMgFilpU2717GUVd27qnZ4eQWqTAX
         V8Z9Csf14f4hhXeldDlQZa5dku7Qx2kdaO9PQMWnRU9HIii4PMhGWTe02v4D+yLJJJCP
         Galw==
X-Gm-Message-State: AOAM5309JhB7Edw9WRjJMs7v+Z5GsUgI9ujuE48p/A/gl0pyENEWJYkJ
        OHwhcAYQoB4/Xz8O35kfevU6wg==
X-Google-Smtp-Source: ABdhPJwCPH/k/zt3g/jrNWG8ycYHnRc7fh3h5PiX/79iqwYBimO1ycFpR5t4XPtcqlzjeLUPvYHjjQ==
X-Received: by 2002:a05:6a00:4385:b0:510:4422:aa3a with SMTP id bt5-20020a056a00438500b005104422aa3amr11139190pfb.16.1652001922968;
        Sun, 08 May 2022 02:25:22 -0700 (PDT)
Received: from localhost.localdomain (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b003c14af505f7sm6155088pgd.15.2022.05.08.02.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 02:25:22 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Ian Rogers <irogers@google.com>,
        Alyssa Ross <hi@alyssa.is>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 07/11] perf c2c: Rename dimension from 'percent_hitm' to 'percent_costly_snoop'
Date:   Sun,  8 May 2022 17:23:42 +0800
Message-Id: <20220508092346.255826-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508092346.255826-1-leo.yan@linaro.org>
References: <20220508092346.255826-1-leo.yan@linaro.org>
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
index 180208a4085f..1e1565e5d396 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -794,7 +794,7 @@ percent_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return hpp_color_scnprintf(hpp, "%*.2f%%", width - 1, per);
 }
 
-static double percent_hitm(struct c2c_hist_entry *c2c_he)
+static double percent_costly_snoop(struct c2c_hist_entry *c2c_he)
 {
 	struct c2c_hists *hists;
 	struct c2c_stats *stats;
@@ -834,8 +834,8 @@ static double percent_hitm(struct c2c_hist_entry *c2c_he)
 })
 
 static int
-percent_hitm_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
-		   struct hist_entry *he)
+percent_costly_snoop_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			   struct hist_entry *he)
 {
 	struct c2c_hist_entry *c2c_he;
 	int width = c2c_width(fmt, hpp, he->hists);
@@ -843,20 +843,20 @@ percent_hitm_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
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
@@ -866,8 +866,8 @@ percent_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	c2c_left  = container_of(left, struct c2c_hist_entry, he);
 	c2c_right = container_of(right, struct c2c_hist_entry, he);
 
-	per_left  = percent_hitm(c2c_left);
-	per_right = percent_hitm(c2c_right);
+	per_left  = percent_costly_snoop(c2c_left);
+	per_right = percent_costly_snoop(c2c_right);
 
 	return per_left - per_right;
 }
@@ -1544,17 +1544,17 @@ static struct c2c_dimension dim_tot_loads = {
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
 
@@ -1763,7 +1763,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_ld_rmthit,
 	&dim_tot_recs,
 	&dim_tot_loads,
-	&dim_percent_hitm,
+	&dim_percent_costly_snoop,
 	&dim_percent_rmt_hitm,
 	&dim_percent_lcl_hitm,
 	&dim_percent_ld_peer,
@@ -2665,7 +2665,7 @@ static int ui_quirks(void)
 		nodestr = "CL";
 	}
 
-	dim_percent_hitm.header = percent_hitm_header[c2c.display];
+	dim_percent_costly_snoop.header = percent_costly_snoop_header[c2c.display];
 
 	/* Fix the zero line for dcacheline column. */
 	buf = fill_line("Cacheline", dim_dcacheline.width +
@@ -2993,7 +2993,7 @@ static int perf_c2c__report(int argc, const char **argv)
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

