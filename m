Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB08FC07E95
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE3E6144E
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGDHTx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 4 Jul 2021 03:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhGDHTu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 4 Jul 2021 03:19:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0830C061764
        for <linux-perf-users@vger.kernel.org>; Sun,  4 Jul 2021 00:17:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w22so9906859pff.5
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Jul 2021 00:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxgwZHP/NxGkiYvHiVeQZZDAd7piMTreovHUTu3tJE4=;
        b=F1Cm5HUe/W4qcO/YZMWcovyfhoTTd7gdBbhgFkxstFf0BT+ShATGv4q4OrsnJaIrpy
         G4hBHinkVsHh9Cfi4t7lXKwp5Oxp9ulth8gE3AIWRBetNA5chQJnCJiQvuemKUVHuRbe
         n0wOB5of97stC16+0L9Omkrn0PANT9WTrxCCu0YAkC2y8zgYlpDzcjMJCdW8dgPW9exy
         jJFzAoQSAkB35DvhbQtr8+GytWS5knvOXGvmCHZMucdYoV2PvCimYoGHVZxDSmDOZndZ
         LSQX4DwreOLmKwZYR3Nnikg/vk+UqtTmzHo34jmqqdyoIqKfxd2J+rzWJEchXwCUteoI
         NSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxgwZHP/NxGkiYvHiVeQZZDAd7piMTreovHUTu3tJE4=;
        b=NFP64llQzzRGySg6cc30D2efJefmfc7hYMGd3/312sFZZeUg1A3HeJmbEfQpGMmiE1
         FRnW5AU92lyPs5M4t+scblt4m9ZIRHAvuaW6xBvwZaP6ao8kzz2IRX95x1oAWAmkCRAo
         Mqckzv0FescPkauVsBZBY0Dl0aW71pNayE60bMl0qXxzehajcMjA4f71dhEDtbkVvRd7
         gLBddilMfhiXVI+qK9cipl4BkczO/zGuGZppvVGqGtHuwKCKe240ArNmbTlvm/JvgY9e
         wwG8qzQQzgH8m30ASrerh2jXtaXLEYf+Q28hJ4/Ae38K93Uenvfx/QKcCkaF0YR6ajgb
         NnzA==
X-Gm-Message-State: AOAM53060P0mW699UDFySwQHdwbsSm0JSTn+mlwfUlela53F4YeLX28B
        wEbrMen0lS2s1Vy+QWBlfovdcQ==
X-Google-Smtp-Source: ABdhPJxEg+L08YtRvHwbnJK9hTdwmsSSxA7M6/KGLxIa5RV8pIXUL0HVBWpIwu5ahxkZusKImzIv+Q==
X-Received: by 2002:a65:62d8:: with SMTP id m24mr9309521pgv.150.1625383035208;
        Sun, 04 Jul 2021 00:17:15 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id la17sm6983974pjb.34.2021.07.04.00.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:14 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 03/10] coresight: tmc-etf: Add comment for store ordering
Date:   Sun,  4 Jul 2021 15:16:37 +0800
Message-Id: <20210704071644.107397-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704071644.107397-1-leo.yan@linaro.org>
References: <20210704071644.107397-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

AUX ring buffer is required to separate the data store and aux_head
store, since the function CS_LOCK() has contained memory barrier mb(),
mb() is a more conservative barrier than smp_wmb() on Arm32/Arm64, thus
it's needless to add any explicit barrier anymore.

Add comment to make clear for the barrier usage for ETF.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 45b85edfc690..9a42ee689921 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -553,6 +553,12 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	if (buf->snapshot)
 		handle->head += to_read;
 
+	/*
+	 * AUX ring buffer requires to use memory barrier to separate the trace
+	 * data store and aux_head store, because CS_LOCK() contains mb() which
+	 * gives more heavy barrier than smp_wmb(), it's not necessary to
+	 * explicitly invoke any barrier.
+	 */
 	CS_LOCK(drvdata->base);
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-- 
2.25.1

