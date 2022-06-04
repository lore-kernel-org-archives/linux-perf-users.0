Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C732C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Jun 2022 04:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350398AbiFDE37 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 4 Jun 2022 00:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350589AbiFDE3u (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 4 Jun 2022 00:29:50 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8267059BAB
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Jun 2022 21:29:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s68so8666462pgs.10
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2022 21:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D1zDapSGMri2EcwZUI87fBe3l89UfGHtqbVcPddjTxg=;
        b=HOlju+XOFSK9bTHri58+pxpWFgXQRr2HfFgWZJIwQvpUQOHPpbrtK40oEnURHRbuDO
         aHPCT1HpumIku94ea8UiAh4nqtKomcUXsO6opKd/w4+4vopwwhoOjhtNwYaClCDXpmQ/
         ilbdUs/J1FZXGvKYROZO8dTcxbRIIQLlozz4Xdrhh7fJW9jKZ5O/h8yLyK2Sgv3nVIHe
         pUShyaouhWvx8MlIeJwlUR4hOnuB3lZaMHx7BjBuPURYoFjGqbTVwcngKsY0uGGZjBnu
         isvUrgku0xtc8HbnxKh2PdRaLAJjoQrKXIixJdF2SsN0BLjF6gRHTP4SQSY7WE7xBGnG
         E49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1zDapSGMri2EcwZUI87fBe3l89UfGHtqbVcPddjTxg=;
        b=Wv7kWmaj2w/qB/NcMtdg5Nyyeu4RlkKi3QIWkUH0bX+7r1wLGn52hhtzou4/Xur50X
         01U/17VCFzIc/CH+pwNUe3BXPPsH6ZcTk9NDU+N0o4a++zutQ3Po9hda13J6nKShXDos
         j80+dfa/7PZrhFYB03rAZdWWxKBwsAvp7qYRJ0/U4V1lhCTBjDVyM3e/54au5HHT4BO9
         IZ0HYW9qOjrgEkGJCI/467kvkeU9FifLuNHcQ59GZw+wxRu0qGNs1ikfWSQ31Bp+eUL9
         bMTDS5oQd8JwHQ2FdN/l3fAU4yoZLaVh+6wY2ioQRtxtreG0zCpuHcH0r1m3t3IKV6hi
         Cy9A==
X-Gm-Message-State: AOAM533b8g/mjAzkZiLTKVy1A/v3NXcToOUa15FMOGFiAjz/h7epnSHa
        d02xvjqcQXL8/ilh/U11ZtUhGQ==
X-Google-Smtp-Source: ABdhPJwwzPl159CKDXSKdv8OGV/pd2Dd/pV47vqflW+FsePSWlZAF9H+gY8DqGOJ1tVXEFDA2ZF7yw==
X-Received: by 2002:a63:6a4a:0:b0:3fd:4f3a:3f0f with SMTP id f71-20020a636a4a000000b003fd4f3a3f0fmr2185912pgc.625.1654316985522;
        Fri, 03 Jun 2022 21:29:45 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:29:44 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 11/17] perf c2c: Use explicit names for display macros
Date:   Sat,  4 Jun 2022 12:28:14 +0800
Message-Id: <20220604042820.2270916-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
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
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 58 ++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 8dd9218a052f..cbeb1878a71c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -115,16 +115,16 @@ struct perf_c2c {
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
@@ -811,15 +811,15 @@ static double percent_hitm(struct c2c_hist_entry *c2c_he)
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
@@ -1217,15 +1217,15 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
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
@@ -1606,9 +1606,9 @@ static struct c2c_dimension dim_tot_loads = {
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
@@ -2101,15 +2101,15 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
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
@@ -2132,13 +2132,13 @@ static inline bool is_valid_hist_entry(struct hist_entry *he)
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
@@ -2835,11 +2835,11 @@ static int setup_display(const char *str)
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
@@ -2927,9 +2927,9 @@ static int setup_coalesce(const char *coalesce, bool no_source)
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
@@ -3087,11 +3087,11 @@ static int perf_c2c__report(int argc, const char **argv)
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

