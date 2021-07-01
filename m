Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5A9C11F64
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 09:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE726144F
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 09:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhGAJi1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 05:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbhGAJi1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 05:38:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D562C061756
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jul 2021 02:35:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ie21so2158957pjb.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jul 2021 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4ZZRhosUp1CcazcGUG0vt93v9b9C4M9CrUlbcO8C/g=;
        b=MtlUQfURw0WXxxuNuMUXgJ+/ERQOOr5yxWHEW6MLQz7DV3RQdXBVsyHega5LHmSPUj
         kTqz3i3YRsz0VPKwCJN6ofcUQNMW/eicuwOOsk5AUIkp+8pG55er1Q2inHHuvvorNsae
         ahDHfw8nXjtsgRn7KKIYoHLGfMQwPi2C6oV2pTRSev4Y9Uh4Zsp+XCwlaugPsnGPork6
         S1QRmOuKCgWphlOIkXezNIGyUIQ5rBmiBhiUsyMHhpdLv6GcaFbUKVQvHuenl2QfdwOl
         Fg54SQbIHecKRnZoLzj7Bd49iBxdAKYNO1dBq2ur7BxrlSe/0tmUNIWI7dPyw9+mLIHQ
         0ZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4ZZRhosUp1CcazcGUG0vt93v9b9C4M9CrUlbcO8C/g=;
        b=jkvEo5Y+Lw2uzedBXtVFLMVrO4JQubwas3fcVXbWfWkxKDZPcGqwzg0i2fz+/8gdeK
         BSf1i4m/C+E166UKHmckCmcYEU0GhIROsT1xg4dnjf99/NPo/ke9PSUF86GbQ+pEt1hY
         a4oPfdFcMO/PC9EyCpYFV14w4ApcjjMdejIveKuAB6NTCHFwLnebO47dwUcmArsXYY0/
         +GOEwYgZUYhEjltdwjrfSViviidHT6sEBEfJwO/jwGSo5WyJqCOsdl1KORQeHpdKE8gv
         8yGTb7xPhKU8WOQaVJwsijZnlN1I/Ubwy6h3l0ghtO3xBGWYeE6VhAfSwqbxaO8tBlOo
         pCSg==
X-Gm-Message-State: AOAM531Z2VIlEKGBucAThB+0+tWfcG7yu5WtFlZOGKHD73R5KwdDI9vv
        qJ2goX/yLqFvx337eHeBGcZ6gA==
X-Google-Smtp-Source: ABdhPJyNAkTr6TG4gwd0yAmimm0dzypa9fXjWmKkYxb7d1333M1b1+Pbi0cCt1vqIGAXMhaERHFKeQ==
X-Received: by 2002:a17:903:1243:b029:ed:8298:7628 with SMTP id u3-20020a1709031243b02900ed82987628mr35822148plh.11.1625132156604;
        Thu, 01 Jul 2021 02:35:56 -0700 (PDT)
Received: from localhost ([202.131.71.237])
        by smtp.gmail.com with ESMTPSA id a33sm15459119pga.68.2021.07.01.02.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 02:35:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/3] coresight: Update comments for removing cs_etm_find_snapshot()
Date:   Thu,  1 Jul 2021 17:35:37 +0800
Message-Id: <20210701093537.90759-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701093537.90759-1-leo.yan@linaro.org>
References: <20210701093537.90759-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since the function cs_etm_find_snapshot() has been removed in the user
space, it directly uses the perf common function __auxtrace_mmap__read()
to calcualte the head and size for AUX trace data in snapshot mode.

Updates the comments in drivers to reflect the changes.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index f775cbee12b8..1cdb627d6c38 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -557,7 +557,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
-	 * that were written.  User space function  cs_etm_find_snapshot() will
+	 * that were written.  User space function __auxtrace_mmap__read() will
 	 * figure out how many bytes to get from the AUX buffer based on the
 	 * position of the head.
 	 */
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 45b85edfc690..fec8ef3694cf 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -546,7 +546,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
-	 * that were written.  User space function  cs_etm_find_snapshot() will
+	 * that were written.  User space function __auxtrace_mmap__read() will
 	 * figure out how many bytes to get from the AUX buffer based on the
 	 * position of the head.
 	 */
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index b22823d67680..960515e01171 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1555,7 +1555,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
-	 * that were written.  User space function  cs_etm_find_snapshot() will
+	 * that were written.  User space function __auxtrace_mmap__read() will
 	 * figure out how many bytes to get from the AUX buffer based on the
 	 * position of the head.
 	 */
-- 
2.25.1

