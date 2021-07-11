Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC2CC07E9B
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6395C610D2
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhGKKoO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jul 2021 06:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhGKKoM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jul 2021 06:44:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00B8C0613DD
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b14-20020a17090a7aceb029017261c7d206so10912708pjl.5
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxgwZHP/NxGkiYvHiVeQZZDAd7piMTreovHUTu3tJE4=;
        b=JnuDDQXdPNRWlCR6EUfqkyGZnRvs0mSk1aPj/Uw0zb9ip1uVoMooO0nZVAE95eQfnv
         kfCjTMTDJ/fMr+7C5yf8Okx2Jjki94LXLE+IyjUJpC3C8ekWoOjmhx2ZET2xjTshaek8
         SE+r8bWo5Ny0o+tjd21vcqXk6NLBsdwYVnC+XePA7mrnPJ+wc29/fqwkhDczXnHsjWiz
         DzKbhXhthyWAdTC7z+XEpYoprPi+T5VTVvRX4KOGes1D9ZtC1iuAOxJ1Odpy27OSUcLk
         k1egAO/BrwnfRXozDkX5tpWtT+FL1XQ86ru3oeKW8+VurrYCqZzm2B5Xiw0IFu6PyEyV
         cVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxgwZHP/NxGkiYvHiVeQZZDAd7piMTreovHUTu3tJE4=;
        b=C4mDI0MMNvebBANwaHD64aAsWssQGCD1dKP8kxl0LpDwoJWMsHVsrN+AoO3JbbAfiB
         PQwY2lnLFu3wcPwm9OEKyFE5T7W0buWF7u+gDzUCkBU6dEwbX878J23r8izPcC3RTJ9d
         T6zt656F50bQZFH8+TKyjuoE7Wi7Xzz1Dx6V3E/GvY7P/JfuSXHV6sKumOl23Bup3X0c
         yjQIa6jcPESTv2WHZipx0lB3FTXx5j8foZcDLcG5eXqY0vIaapSUNM9y8rupec5A/x8y
         ppnMtWQAIjLOetZvGWo8mCXIuiifyAHuvWAmCVqNX14Z2OJnwaUj8s+9ctQckQ7U1+tX
         TchA==
X-Gm-Message-State: AOAM531UM1bT41J30sRZYi59yVEvl7PEpOp/CYbzeJH56Q4LKd3tn3AC
        cYBsLIzzpqPt7BFpyZdwbKlk1Q==
X-Google-Smtp-Source: ABdhPJzNZQip/BwALlXE7Z7NBJGyg6SKSf+M0vJ6RYGbUSs5QT+KzgE2IUOJho/3zqy/j8F/SKOUnA==
X-Received: by 2002:a17:90b:3844:: with SMTP id nl4mr8431143pjb.78.1626000085273;
        Sun, 11 Jul 2021 03:41:25 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id j6sm10570265pji.23.2021.07.11.03.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:24 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v4 03/11] coresight: tmc-etf: Add comment for store ordering
Date:   Sun, 11 Jul 2021 18:40:57 +0800
Message-Id: <20210711104105.505728-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711104105.505728-1-leo.yan@linaro.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
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

