Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AFEC07E9B
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E796611CC
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhGKKoK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jul 2021 06:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhGKKoK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jul 2021 06:44:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77594C0613E5
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso8742283pjp.2
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvAJvuDnRJDe9YMY5R2L+q2C0nSKQeIr4jFz4M7hp0E=;
        b=er914k1odHGQXFxKzwCAlSjDGT1lEhzg/54+63PQydsGFVX2c9kqX4DPnaoiLiqnTP
         Sw261DSe/328/xnD6Q0ZHboHc2K56SXChdQ8gad+HDOsfl/dCd/Zkfda9mRDkkuz4V/F
         PxnXcnEgmWJSCgPt0zXCAszYveUShnZMGHu5vn5yxmAVcIC0pjjHzjY1X6lRErUI/oa6
         PbqT1IFNUz5O3YrANKzyUQ/XhuAG3SdAY3lRCQzDVoUvMMdrEFpLSQw1ENZ9znLkXwvM
         wM6qimqRDCqFO3Wq2+eZ1BIfH/Im3aalssq5IIu+S5UCtJLL58kuPYMZwjGiJfUrW15c
         73jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvAJvuDnRJDe9YMY5R2L+q2C0nSKQeIr4jFz4M7hp0E=;
        b=dm6nIyb9cHwhEOGjBXqjSXAMq68syZmWJ8fyjzzfgSGbw86AQm/Rmj/QaV8l7my9x3
         +4C831dLT9pU/XUjNg3GOS4KhvpmNacRQ9YDgk3OtaKg4TytAzuXYDyrCYPEQXlWdSgq
         FCrLzeVHElPo5k5dgEDgqNV8Dg6nGugLpiuu+9+XyV0KdR/jRLURYRi8RozkG4Am90zt
         iM5uxfDcPlJjnfwkWu5cmyyUgZPfleVhXhOQFHf/DkC0LCj6UCyguQxvseWPA6F3lMpT
         grvbG4Eytx9HOdTLYNuZxggMAzdLH5kwjpoXdDO57u/QHWxCztxi/08OK0hNUAFsKX2i
         AC+w==
X-Gm-Message-State: AOAM5310fOmdnONrrrWEU8QfdvDDKpZyYpW1KAYOWvGG4L8vkdMuGSQR
        +lUv3nSDPqJTvaZghReDStZz4Q==
X-Google-Smtp-Source: ABdhPJx3EsK700CJoPDmV2uQscNMM5W/vzqGJIPYWH/E+Oq8jMLYvmO+fUcusoi8LDNTAkzV9oH4bg==
X-Received: by 2002:a17:90a:4681:: with SMTP id z1mr7368243pjf.156.1626000082010;
        Sun, 11 Jul 2021 03:41:22 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id d191sm13945165pga.27.2021.07.11.03.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:21 -0700 (PDT)
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
Subject: [PATCH v4 02/11] coresight: tmc-etr: Add barrier after updating AUX ring buffer
Date:   Sun, 11 Jul 2021 18:40:56 +0800
Message-Id: <20210711104105.505728-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711104105.505728-1-leo.yan@linaro.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
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

