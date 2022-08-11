Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7920AC19F2D
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Aug 2022 06:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiHKG0H (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Aug 2022 02:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiHKGZt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Aug 2022 02:25:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC35F6DF89
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 23:25:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o3-20020a17090a0a0300b001f7649cd317so4449860pjo.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 23:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vISqy0c46VUo7jta0UtXmJx/Ve8c21OQoVpZLZn1UYc=;
        b=h7rsvlA/DKHR/BdvhLttV1R8+DWflxwegrY19QrEYi/HrJLaOrVadDv0Y8BndWg086
         9PaM7exnp8eudXhUPvQJBxuhh8dlyUNnfocSegrWeaZTHPvt2zbOJOJDzFMCMW+Af2sW
         HbErtOvVSamm1w46ylLVlWdbMvRA3nt1FS56fnBCfYT+y8KDwe5dl2dbTrpk0ClsKxAJ
         Ad4vEN1vJqJ+xqgoe/ebyl2Nnu9uDE+TJ5+B9ln3UkhVQtgBnJWkp34QEy5Iq/CE0j9o
         ZXpGtENYY+VQcoprTGCEScYf9j4WHXV5UuTDBHXscy8wjGD0NRMBJ7jvzRIu1OAUl+9l
         BIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vISqy0c46VUo7jta0UtXmJx/Ve8c21OQoVpZLZn1UYc=;
        b=Chg6aNK7YyBjViXb/BbaxnMFi+LWcFSPppHAAauXojvXFOL8UGrpz7bT1mtV8hT6FO
         VkcvZuSF1tejKO/h0soV8ruarEGqkwYM3X0aoNrzo2bhifYiPZupmQK3EdaTVUvV8M6h
         zdGXIAc8B1vWAuYrnwj+2nzfUg/lyuZOsSnTe8D41D53ac5+xv5rUQgZrn5G4seERM1M
         dFvzSNcCCLVrVFUrrmeIP1QhFBXrLqHRBhUNPxzEpe+QJzeX9lBUmb5uZrElf8iW72pe
         2GFPiDBLVW7lc53Wy/Nb63hV7EvZFile0zJ2JYvexurYpmD70XM59NY5I1qrP4WJIQ2G
         NZaQ==
X-Gm-Message-State: ACgBeo0+eteTpZEwp+QeHubLMQkSqx9Qld3WKRMvVIhnG4ZWV08uVc/r
        4icyDAnjMdvCwg54rayKk1AvlQ==
X-Google-Smtp-Source: AA6agR7lkSLN6rJ6hUBSmVi8yPIjpU1fCn3mFsbOnrulHhaKiTNkZ5V/2K5DvZG4DWeSBLU+RN8GKg==
X-Received: by 2002:a17:902:dacb:b0:16f:63c:3e8b with SMTP id q11-20020a170902dacb00b0016f063c3e8bmr31372372plx.64.1660199143892;
        Wed, 10 Aug 2022 23:25:43 -0700 (PDT)
Received: from leoy-yangtze.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a55cc00b001f506009036sm2766926pjm.49.2022.08.10.23.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:25:43 -0700 (PDT)
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
Subject: [PATCH v6 07/15] perf c2c: Add dimensions of peer metrics for cache line view
Date:   Thu, 11 Aug 2022 14:24:43 +0800
Message-Id: <20220811062451.435810-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220811062451.435810-1-leo.yan@linaro.org>
References: <20220811062451.435810-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds dimensions of peer ops, which will be used for Shared
cache line distribution pareto.

It adds the percentage dimensions for local and remote peer operations,
and the dimensions for accounting operation numbers which is used for
stdio mode.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 102 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 99c0c7307a4a..dd47f068b8da 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -902,6 +902,8 @@ static double percent_ ## __f(struct c2c_hist_entry *c2c_he)			\
 
 PERCENT_FN(rmt_hitm)
 PERCENT_FN(lcl_hitm)
+PERCENT_FN(rmt_peer)
+PERCENT_FN(lcl_peer)
 PERCENT_FN(st_l1hit)
 PERCENT_FN(st_l1miss)
 PERCENT_FN(st_na)
@@ -968,6 +970,68 @@ percent_lcl_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return per_left - per_right;
 }
 
+static int
+percent_lcl_peer_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	double per = PERCENT(he, lcl_peer);
+	char buf[10];
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int
+percent_lcl_peer_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he)
+{
+	return percent_color(fmt, hpp, he, percent_lcl_peer);
+}
+
+static int64_t
+percent_lcl_peer_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		     struct hist_entry *left, struct hist_entry *right)
+{
+	double per_left;
+	double per_right;
+
+	per_left  = PERCENT(left, lcl_peer);
+	per_right = PERCENT(right, lcl_peer);
+
+	return per_left - per_right;
+}
+
+static int
+percent_rmt_peer_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	double per = PERCENT(he, rmt_peer);
+	char buf[10];
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int
+percent_rmt_peer_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he)
+{
+	return percent_color(fmt, hpp, he, percent_rmt_peer);
+}
+
+static int64_t
+percent_rmt_peer_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		     struct hist_entry *left, struct hist_entry *right)
+{
+	double per_left;
+	double per_right;
+
+	per_left  = PERCENT(left, rmt_peer);
+	per_right = PERCENT(right, rmt_peer);
+
+	return per_left - per_right;
+}
+
 static int
 percent_stores_l1hit_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			   struct hist_entry *he)
@@ -1403,6 +1467,22 @@ static struct c2c_dimension dim_cl_lcl_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_cl_rmt_peer = {
+	.header		= HEADER_SPAN("----- Peer -----", "Rmt", 1),
+	.name		= "cl_rmt_peer",
+	.cmp		= rmt_peer_cmp,
+	.entry		= rmt_peer_entry,
+	.width		= 7,
+};
+
+static struct c2c_dimension dim_cl_lcl_peer = {
+	.header		= HEADER_SPAN_LOW("Lcl"),
+	.name		= "cl_lcl_peer",
+	.cmp		= lcl_peer_cmp,
+	.entry		= lcl_peer_entry,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_tot_stores = {
 	.header		= HEADER_BOTH("Total", "Stores"),
 	.name		= "tot_stores",
@@ -1547,6 +1627,24 @@ static struct c2c_dimension dim_percent_lcl_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_percent_rmt_peer = {
+	.header		= HEADER_SPAN("-- Peer Snoop --", "Rmt", 1),
+	.name		= "percent_rmt_peer",
+	.cmp		= percent_rmt_peer_cmp,
+	.entry		= percent_rmt_peer_entry,
+	.color		= percent_rmt_peer_color,
+	.width		= 7,
+};
+
+static struct c2c_dimension dim_percent_lcl_peer = {
+	.header		= HEADER_SPAN_LOW("Lcl"),
+	.name		= "percent_lcl_peer",
+	.cmp		= percent_lcl_peer_cmp,
+	.entry		= percent_lcl_peer_entry,
+	.color		= percent_lcl_peer_color,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_percent_stores_l1hit = {
 	.header		= HEADER_SPAN("------- Store Refs ------", "L1 Hit", 2),
 	.name		= "percent_stores_l1hit",
@@ -1704,6 +1802,8 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_rmt_peer,
 	&dim_cl_lcl_hitm,
 	&dim_cl_rmt_hitm,
+	&dim_cl_lcl_peer,
+	&dim_cl_rmt_peer,
 	&dim_tot_stores,
 	&dim_stores_l1hit,
 	&dim_stores_l1miss,
@@ -1721,6 +1821,8 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_percent_hitm,
 	&dim_percent_rmt_hitm,
 	&dim_percent_lcl_hitm,
+	&dim_percent_rmt_peer,
+	&dim_percent_lcl_peer,
 	&dim_percent_stores_l1hit,
 	&dim_percent_stores_l1miss,
 	&dim_percent_stores_na,
-- 
2.34.1

