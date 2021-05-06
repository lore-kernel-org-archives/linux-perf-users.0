Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C297CC433ED
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 May 2021 13:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EC761104
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 May 2021 13:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhEFNPD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 May 2021 09:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhEFNPC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 May 2021 09:15:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D17C061574;
        Thu,  6 May 2021 06:14:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 124so7733104lff.5;
        Thu, 06 May 2021 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIQmySH5rKYkaTCMdU5HD5HriPXQiPhjgd9Q3vz0FwQ=;
        b=iwwdl9SJ9MXhgLtAr3AL0yPOQSixzfVczE8lcM3b2WqWvzIZIIu86Kt9HJi+05YU9R
         rVAwfYk05XNIFyIIhl3fBAhn/FjLpXs+n8tOqw3vWZwxpsERZAxJalPMS03QDwIHrUW3
         ktIdd+qUIoQoY6UXl9JcqQOacmNOoI5N7nOW7VkxXeK+Oqi8RXnklDUqrSojF2TdzhJl
         QI1LaPgMu9zijBhmIao0LyfvnAOphpQyh/hUtIQEayIZEXuXb6XJwPXX0s7FPdiRu0jM
         lgS5PeZ1Iit96KZfpw4oGzTOKtr5ib4zyssMXsQ3zVUptLpu9PfUJR5R0FE9AZIhZnpU
         im7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIQmySH5rKYkaTCMdU5HD5HriPXQiPhjgd9Q3vz0FwQ=;
        b=VyVx5x4SpD67g7zroG/hJMuYtZ3rVD8TybzvX1UWK63GK5IU0BY4xzexWFYMBs/LdR
         mHAGrl2ME2msFqroWGpM4QSQl2E951Eip0uKp4pVa621Ru41WVTr6eS88OrjcGY+RpHO
         BHn4lEi7CWjq74Oab9tGaagPLtU3iAuV7S3q+L05PYrw68GTu27egVpVq1iVGYvAjzXW
         1M6iphBwl5DCylZRhX1/hizdCuNFl8+fff83/U2HIWH1j2mdL8Ig1l+xAjDFJStXITA6
         c6cuB6iW/fgzREcQyKjE5uO/4EjDgp94Tv1zrnA+gUXmQ+pR/dmvSzaMr5Q1Jm5HoF5O
         z6VA==
X-Gm-Message-State: AOAM533TxOZhI3Cb0dkhgYYh6m7f2QRaqVM9QFpLECOsoRcIkyrT/ipb
        yp17S0zYGl8XM5x+zwBQH8Hb+C/tqfpuvtyu
X-Google-Smtp-Source: ABdhPJzRDF2BBtmUtOrZOOvY9BImc9I/xrh2tEMvP4C+fQKZ43Hb9abMvWsRMPNd8DNISQR8RQENgQ==
X-Received: by 2002:ac2:5feb:: with SMTP id s11mr2742580lfg.99.1620306841532;
        Thu, 06 May 2021 06:14:01 -0700 (PDT)
Received: from localhost.localdomain ([185.30.229.161])
        by smtp.googlemail.com with ESMTPSA id v21sm867332ljv.80.2021.05.06.06.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 06:14:01 -0700 (PDT)
From:   Dmitry Koshelev <karaghiozis@gmail.com>
Cc:     Dmitry Koshelev <karaghiozis@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf: Fix swapping of cpu_map and stat_config records
Date:   Thu,  6 May 2021 13:11:49 +0000
Message-Id: <20210506131244.13328-1-karaghiozis@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

'data' field in perf_record_cpu_map_data struct is 16-bit
wide and so should be swapped using bswap_16().

'nr' field in perf_record_stat_config struct should be
swapped before being used for size calculation.

Signed-off-by: Dmitry Koshelev <karaghiozis@gmail.com>
---
 tools/perf/util/session.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a12cf4f0e97a..106b3d60881a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -904,7 +904,7 @@ static void perf_event__cpu_map_swap(union perf_event *event,
 	struct perf_record_record_cpu_map *mask;
 	unsigned i;
 
-	data->type = bswap_64(data->type);
+	data->type = bswap_16(data->type);
 
 	switch (data->type) {
 	case PERF_CPU_MAP__CPUS:
@@ -937,7 +937,7 @@ static void perf_event__stat_config_swap(union perf_event *event,
 {
 	u64 size;
 
-	size  = event->stat_config.nr * sizeof(event->stat_config.data[0]);
+	size  = bswap_64(event->stat_config.nr) * sizeof(event->stat_config.data[0]);
 	size += 1; /* nr item itself */
 	mem_bswap_64(&event->stat_config.nr, size);
 }
-- 
2.25.1

