Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1C3C43334
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Jun 2022 04:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349464AbiFDE3v (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 4 Jun 2022 00:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350545AbiFDE3s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 4 Jun 2022 00:29:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EB035DF0
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Jun 2022 21:29:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s14so8127989plk.8
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2022 21:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jM/sDeO4U2b4h2S+xzCc/+ixKFmLKt6xKRqSB9F6ZDM=;
        b=M1oR6nK7JLNOHvDBdHdGF5Tg9GU3k8NU5xpU8s/fOBwPXKNq2LUoriK8PgfpecIrsS
         4C5TLfXlrVzMtcl+Rf2p+3k3csC0w4WqddRlryJ7bj00+m11R+Bq/x7uX0HOhEj79nIc
         FwQbDaTbGkQEVfq+VLfq0c5hi9+0FZaat5tRtk4NI0j8NoHkg1E/sIXPGWdUhO/QUfCT
         QvEYw+E8+l1R5jK/7ZWPPumCogDmdkqZCYMD0fKo4O/DB8OsVc/FdRUxHpOl+RX0BzK5
         Um3npMFnlR3j9g5MrXYQ6t4NuminB/U+sidiYSLGtb6YtBf15zx23ncYcbLNUIXtpT9d
         RQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jM/sDeO4U2b4h2S+xzCc/+ixKFmLKt6xKRqSB9F6ZDM=;
        b=SkQ9UlbG6TIp3sVJtaru9nxVVtzIckoiskYj+1dIjwoNPSl/VJhSz4x1ol04nR/Yss
         z5iZdjQVEKvroH6H+fqxMB18QgAmD2fLRckeYryAG0HGhqd0vUMHSbkCUcKxPYHAHqxL
         HEjyP9/coeP4fqtYtBL2asKgRPDv8wAqztgmtE+4tyxulLfarriXFMBQ/0vH4vOtT6tq
         urmi6qmR5AArer8m9AzRW10AGbSStxfgrtPyatiBD9oIEC/GDRV9CDi4+Cnj+FVNzPF0
         oZ6bx21rvxB+zYiiIHd+j98s9N1Ec5FjZ7dW6jexxcXYYa5yl+XhXlxZkDtE2fCq8F9K
         qYVA==
X-Gm-Message-State: AOAM532shC3Fx4Gcwmt02P1EwOZGkRkZxFTdhXT/0Qbq+TxAqDf4S7DO
        hjWYM7/wmP93R7bqZJwr4Ualcw==
X-Google-Smtp-Source: ABdhPJw+ZOhVMyeltzfkIU2tUDIfzLaQiCLHnaLd3hyh7H1sTw74x08+5CUaWJ5kRU2tBr9kC3YpAw==
X-Received: by 2002:a17:902:d64e:b0:163:5074:c130 with SMTP id y14-20020a170902d64e00b001635074c130mr13484672plh.125.1654316974140;
        Fri, 03 Jun 2022 21:29:34 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:29:33 -0700 (PDT)
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
Subject: [PATCH v5 09/17] perf c2c: Add dimensions of peer metrics for cache line view
Date:   Sat,  4 Jun 2022 12:28:12 +0800
Message-Id: <20220604042820.2270916-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
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
2.25.1

