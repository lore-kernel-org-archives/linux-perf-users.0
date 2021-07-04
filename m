Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED001C07E96
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A3561879
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhGDHTu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 4 Jul 2021 03:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhGDHTr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 4 Jul 2021 03:19:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F1C061762
        for <linux-perf-users@vger.kernel.org>; Sun,  4 Jul 2021 00:17:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b5so8373021plg.2
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Jul 2021 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvAJvuDnRJDe9YMY5R2L+q2C0nSKQeIr4jFz4M7hp0E=;
        b=TZxJVJis8rrNqPFI2hPub+IQfdfSZOkJvS/N4Qc2wxUB09wr1MfwYw1dKN+vYgsgxl
         +Mw6TONqRDqKeND/1XROo+0oJBqtXUbdgINfQoBXo4dBxDewpTNZdUI9j/6aKcpmSgM3
         iHoBfBgzdrgEKW1w9eEw/yo9n68nOGSRzFaBYfz8+xj/UsFgdQdIuyIyhKsFcFBvK5SS
         hZGglCMveOrpWRvzb2l4gaI6UDMU6bnGi4zzkAtZoFuJzYDoxDBKV9iIQIPDWg7q21uf
         79funWYO59ZfD/q9HuDmV5JenmxPZK414wjMSav5wpCdUR0h+ZPJ/O0vA1pfYA7sRXcx
         +chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvAJvuDnRJDe9YMY5R2L+q2C0nSKQeIr4jFz4M7hp0E=;
        b=IN9LARKYlHrtbYwaVvQg9PuhSPyrFag/7eZPEXNp/GtG2lNtucoY8/C/HCskXTdpS+
         d9E273jOUGdvoluHo6PzbXwFjsM8MSP9szje/zCiVOiWrMwq7djFNOafn7LfisDBsECb
         6MKCfGM5q17ELQ5lRDgTfuhCuvnMIWkMaA6nvO1YVDV4r722q3zZkNHslxh/uEpi4Mof
         jXHTwnIFymfkjDP8hbqGVYyIcGr9h15q2uup2NOnvdSCpiN45Ke0/b+KHLvsQX6CWUBO
         t4WTCqzMTgCcdQ+x0sy+7DGIrPySYmwyqyeOGC2DOLhkGT7Nr0Oympb8Zgc6pMR0jQbW
         U7YQ==
X-Gm-Message-State: AOAM530ZQ5AnvrhNVQXNsqtC9IZOAiEstEbSiZl6UShdGiUDWCHwM6gk
        GxGM95oE150QKl/tOvzwQwTM9g==
X-Google-Smtp-Source: ABdhPJziL8cAnRjboZ1UlxOOR0Cvu9NdT7Stl0UJiINuPwjmGxQlpm2Sj8AWQP4DU4sVlQP2iThQ2A==
X-Received: by 2002:a17:90a:5903:: with SMTP id k3mr8545239pji.104.1625383032314;
        Sun, 04 Jul 2021 00:17:12 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id i18sm553232pgb.83.2021.07.04.00.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:11 -0700 (PDT)
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
Subject: [PATCH v3 02/10] coresight: tmc-etr: Add barrier after updating AUX ring buffer
Date:   Sun,  4 Jul 2021 15:16:36 +0800
Message-Id: <20210704071644.107397-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704071644.107397-1-leo.yan@linaro.org>
References: <20210704071644.107397-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since a memory barrier is required between AUX trace data store and
aux_head store, and the AUX trace data is filled with memcpy(), it's
sufficient to use smp_wmb() so can ensure the trace data is visible
prior to updating aux_head.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index acdb59e0e661..713205db15a1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1563,6 +1563,14 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	 */
 	if (etr_perf->snapshot)
 		handle->head += size;
+
+	/*
+	 * It requires the ordering between the AUX trace data and aux_head
+	 * store, below smp_wmb() ensures the AUX trace data is visible prior
+	 * to updating aux_head.
+	 */
+	smp_wmb();
+
 out:
 	/*
 	 * Don't set the TRUNCATED flag in snapshot mode because 1) the
-- 
2.25.1

