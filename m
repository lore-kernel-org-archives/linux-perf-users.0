Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16CBC43334
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Jun 2022 04:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbiFDE3r (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 4 Jun 2022 00:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350527AbiFDE3k (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 4 Jun 2022 00:29:40 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F1F53A6F
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Jun 2022 21:29:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o17so8139767pla.6
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2022 21:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKXILwkRVdA3Fa6aqPRmJrL7mZPDO3MwqGuWltaS794=;
        b=ZrMrMwxNoNF0zzyxwZDgysg7jGahVeGE+iX35PIPdmiZHQuLQPSCD2dwYqttdPyhjP
         LS8HOl95nRarD3I1q40CBFOGFpyQF1HnOGJUYfmt9tf0/trGGgXRpdAEbdkHtWZ9dK8c
         4ePr9RZeG8RsaZaRSmLPYIqZEbzlcpQGeC43SCEj1f3Ycl645cfIiWeRjfCUMamtjKtr
         9yzd6SXtxBiihWFKC1q5sVx86zgmxhwWGaFtYbL5Nh5yqJIZ7X2wM/twI0j6k8e0pkF7
         SsKJBoYIMJ3/FzLSBV7Um07NWAe/DaJ2yu96eC+Zf5jNjWNzd9J2mtxetOyjDxmVgaEZ
         GNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKXILwkRVdA3Fa6aqPRmJrL7mZPDO3MwqGuWltaS794=;
        b=NY3UvYVxMaDz5Z28R814FLgSk4Msvlmvx9saEWYl9l2VWTDj6sNqgmvX7U6rLnqqiS
         irzYtU6SPHGoMX0rsYGhl5mpdl8aueift0gt7P9gfhNrdemAblW+Dp6aoeSiWzOmAO7w
         AQnb5bzC82oVFK3wF+rMLsU3TdXF2GAajHDez9oI7v9SyyDGJa0Tnj8EoRZlKw6nFI11
         jyqSbu2x9vZTHuq49Jw5c6KUefJWbk/sSQpWPIlz24yXvRRaEwT2f0o+hKy949p0xJdd
         pao78fUII+RnckCsVw/+IkwITw5Uy3g4Wbl4Kscq+8tAPPXjfE0iKQErC+/x5t9DoT51
         wQXw==
X-Gm-Message-State: AOAM530EfSmLse662TpfFa69P9AKH/yQe84cbYPK9rntmen0LKF6cm9B
        +TXWeI/3AqYWPHqKa7y+Wiu7Zg==
X-Google-Smtp-Source: ABdhPJwrfo/O3rcVKswOwm/BY0TFIFuj5/gOCyu21b7yZFXaclT6zOL9KrFQgfNXmNibPS1S5xKBLQ==
X-Received: by 2002:a17:902:ee8d:b0:164:7dd:6cc6 with SMTP id a13-20020a170902ee8d00b0016407dd6cc6mr13858875pld.84.1654316968262;
        Fri, 03 Jun 2022 21:29:28 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:29:27 -0700 (PDT)
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
Subject: [PATCH v5 08/17] perf c2c: Add dimensions for peer load operations
Date:   Sat,  4 Jun 2022 12:28:11 +0800
Message-Id: <20220604042820.2270916-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds three dimensions for peer load operations of 'lcl_peer',
'rmt_peer' and 'tot_peer'.  These three dimensions will be used in the
shared data cache line table.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 37bebeb6c11b..99c0c7307a4a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -650,6 +650,9 @@ __f ## _cmp(struct perf_hpp_fmt *fmt __maybe_unused,			\
 
 STAT_FN(rmt_hitm)
 STAT_FN(lcl_hitm)
+STAT_FN(rmt_peer)
+STAT_FN(lcl_peer)
+STAT_FN(tot_peer)
 STAT_FN(store)
 STAT_FN(st_l1hit)
 STAT_FN(st_l1miss)
@@ -1360,6 +1363,30 @@ static struct c2c_dimension dim_rmt_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_tot_peer = {
+	.header		= HEADER_SPAN("------- Load Peer -------", "Total", 2),
+	.name		= "tot_peer",
+	.cmp		= tot_peer_cmp,
+	.entry		= tot_peer_entry,
+	.width		= 7,
+};
+
+static struct c2c_dimension dim_lcl_peer = {
+	.header		= HEADER_SPAN_LOW("Local"),
+	.name		= "lcl_peer",
+	.cmp		= lcl_peer_cmp,
+	.entry		= lcl_peer_entry,
+	.width		= 7,
+};
+
+static struct c2c_dimension dim_rmt_peer = {
+	.header		= HEADER_SPAN_LOW("Remote"),
+	.name		= "rmt_peer",
+	.cmp		= rmt_peer_cmp,
+	.entry		= rmt_peer_entry,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_cl_rmt_hitm = {
 	.header		= HEADER_SPAN("----- HITM -----", "Rmt", 1),
 	.name		= "cl_rmt_hitm",
@@ -1672,6 +1699,9 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_tot_hitm,
 	&dim_lcl_hitm,
 	&dim_rmt_hitm,
+	&dim_tot_peer,
+	&dim_lcl_peer,
+	&dim_rmt_peer,
 	&dim_cl_lcl_hitm,
 	&dim_cl_rmt_hitm,
 	&dim_tot_stores,
-- 
2.25.1

