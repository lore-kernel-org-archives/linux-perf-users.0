Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194E7CCA483
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Jun 2022 04:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350696AbiFDEax (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 4 Jun 2022 00:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350572AbiFDE3u (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 4 Jun 2022 00:29:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B99A3AA7C
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Jun 2022 21:29:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so13524487pjl.4
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2022 21:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Qm66nfhudmwJA9iVinA9JP0NApAajjTf2BuY1M3OaI=;
        b=kK5aeXkDtX7iX8griW86CyYEXdl/A0eEoOAH35kMiy8zC5YxZ13vkmUz41hNukiVED
         mwOD/eHzHg/ydHq9EnMam14CC+qi74lZ5DT/BZLht4Ycg8oUmzkBZjyRvP10Zabr1bml
         pM1ANKzvXgjiQFcGdB9yBK2kbxntk93fVC8L8EGzg5bWrtj+cW0HA62JIklUfPSZPpBY
         JDX4X7ZtLv2ApTgr9o96CGNSHF9wrVPb++OYdBxWV9Af+auINOLjKL/8fwy9yJG6h9FN
         qJlps4+jXViETOdDnbJUJNm1u+nf/wo2MAZWn914jK2uKqI6n0arJcJqgH+uKM8h8vhY
         WiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Qm66nfhudmwJA9iVinA9JP0NApAajjTf2BuY1M3OaI=;
        b=2a+FCj6A1trzgAtlkWcGhlhPzNX7GvtLgf+XvmkgcP75F1HLHMLjUkHfxFuKbvsXGf
         q0CHTRZp2LKs+zgSCWF91i2PrQseEBJl5JAECPET3GGzr1mIZ4EVz9ySwiPHUIHc7Voo
         ptXw/Zmdt4+ASo0UzAkJloMQOKcj4LymAvCNdBmNL02ksj+t/KXkZ1myWi78xSZ0h6+7
         3yrwtk9ikOkUx1LyCyu6xZ19V5ooQkEVpVknUMemUdJ+7yyugAs/lQ0rR5yP85mgOqI/
         B+7kpRr6kFn8flD5sOX6/Vgp7WUU3cmEXoWuYd6esutbvFMhyFGw5DGcwieCTCMwOClJ
         QzLQ==
X-Gm-Message-State: AOAM5312LqapJvxh8SP7l+O7p5+rcGlHlNYijuuT9fMOTlhKA8gj+2Gc
        M6vGRC4oeki8X3i3p1aJGlDSZA==
X-Google-Smtp-Source: ABdhPJwhqQsWGwdhBIJ5vTo2aAtQciKAeP/FJizUt9b/VLhWNxzBpnmgnb4AcoR7NQR0tJzKw6Rx1A==
X-Received: by 2002:a17:902:b694:b0:162:6ea:30 with SMTP id c20-20020a170902b69400b0016206ea0030mr13186546pls.95.1654316979740;
        Fri, 03 Jun 2022 21:29:39 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:29:39 -0700 (PDT)
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
Subject: [PATCH v5 10/17] perf c2c: Add mean dimensions for peer operations
Date:   Sat,  4 Jun 2022 12:28:13 +0800
Message-Id: <20220604042820.2270916-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds two dimensions for the mean value of peer operations.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index dd47f068b8da..8dd9218a052f 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -55,6 +55,8 @@ struct c2c_hists {
 struct compute_stats {
 	struct stats		 lcl_hitm;
 	struct stats		 rmt_hitm;
+	struct stats		 lcl_peer;
+	struct stats		 rmt_peer;
 	struct stats		 load;
 };
 
@@ -154,6 +156,8 @@ static void *c2c_he_zalloc(size_t size)
 
 	init_stats(&c2c_he->cstats.lcl_hitm);
 	init_stats(&c2c_he->cstats.rmt_hitm);
+	init_stats(&c2c_he->cstats.lcl_peer);
+	init_stats(&c2c_he->cstats.rmt_peer);
 	init_stats(&c2c_he->cstats.load);
 
 	return &c2c_he->he;
@@ -253,6 +257,10 @@ static void compute_stats(struct c2c_hist_entry *c2c_he,
 		update_stats(&cstats->rmt_hitm, weight);
 	else if (stats->lcl_hitm)
 		update_stats(&cstats->lcl_hitm, weight);
+	else if (stats->rmt_peer)
+		update_stats(&cstats->rmt_peer, weight);
+	else if (stats->lcl_peer)
+		update_stats(&cstats->lcl_peer, weight);
 	else if (stats->load)
 		update_stats(&cstats->load, weight);
 }
@@ -1280,6 +1288,8 @@ __func(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp, struct hist_entry *he)	\
 MEAN_ENTRY(mean_rmt_entry,  rmt_hitm);
 MEAN_ENTRY(mean_lcl_entry,  lcl_hitm);
 MEAN_ENTRY(mean_load_entry, load);
+MEAN_ENTRY(mean_rmt_peer_entry, rmt_peer);
+MEAN_ENTRY(mean_lcl_peer_entry, lcl_peer);
 
 static int
 cpucnt_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
@@ -1750,6 +1760,22 @@ static struct c2c_dimension dim_mean_load = {
 	.width		= 8,
 };
 
+static struct c2c_dimension dim_mean_rmt_peer = {
+	.header		= HEADER_SPAN("---------- cycles ----------", "rmt peer", 2),
+	.name		= "mean_rmt_peer",
+	.cmp		= empty_cmp,
+	.entry		= mean_rmt_peer_entry,
+	.width		= 8,
+};
+
+static struct c2c_dimension dim_mean_lcl_peer = {
+	.header		= HEADER_SPAN_LOW("lcl peer"),
+	.name		= "mean_lcl_peer",
+	.cmp		= empty_cmp,
+	.entry		= mean_lcl_peer_entry,
+	.width		= 8,
+};
+
 static struct c2c_dimension dim_cpucnt = {
 	.header		= HEADER_BOTH("cpu", "cnt"),
 	.name		= "cpucnt",
@@ -1835,6 +1861,8 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_node,
 	&dim_mean_rmt,
 	&dim_mean_lcl,
+	&dim_mean_rmt_peer,
+	&dim_mean_lcl_peer,
 	&dim_mean_load,
 	&dim_cpucnt,
 	&dim_srcline,
-- 
2.25.1

