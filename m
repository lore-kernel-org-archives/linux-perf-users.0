Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBAEC433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 11:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815C761413
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 11:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhD1L7K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 07:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhD1L7C (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Apr 2021 07:59:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B197C061574
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Apr 2021 04:58:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h20so32687669plr.4
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Apr 2021 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGpAm2p7nVFSJJsJKeJMpjJThBwUlAbTNq+bU/9Fn3Q=;
        b=FL7BAZQmkr4jiQ4maVnPoFh1fLwvYAfaVbHWWEyw0ZePg/D2kOwEtTwL/W/kHKNTF4
         BA2l/O3IyWRGV54A3zBJyabNUKaxv6tvnvFwVnWRIbWIyp1pTT5MLQPg+az0Vm5U31sY
         onMW25R5fPBY3wZyKEDoquRYMmN/Nq8f2GPPJqwzd2OcmCiEkFQwXkVnbdeZsTAe1qN5
         ZV7kyNl9aWqDYtZVkjdrOmYEdxsj7A0j28nGjmsom9B2deyOlGhpxiRFWVhJT1sLr8N+
         k9PCDCr0ggT/mWMssYPGL+6LXXyrKiR5eFFvQ1IGYwYKS4vl/XrcruHLtaW+gWY8fLur
         QilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGpAm2p7nVFSJJsJKeJMpjJThBwUlAbTNq+bU/9Fn3Q=;
        b=DcCrtzVaILYWjebdWhXyW6KGh4T+6H74xrFm1llBhpc+XSF2ZlZvky0qwNIovP6BYM
         AM1jtRKlwYRuWuSFDXxDIh5wOuyux9qTmLtnMlcd+ga9OfaXZUZ+jyYwRmpJoIfDWCvl
         JnzG341+AnwHC92oMeCMbOpw744vIYt4kdWRx5bVTYofMCAOT6k+O+e84Z2xu8/WPmF4
         PWUjX2zjEZn1FJ/LhItvj6NscsEgFralAzCSteKRaPAdUPXUDyBO9dRRMD4zFxZMTpyR
         l82nIfvZugEQrBHDPMOo0JC0l+0xpdhHMc/g73kou7FC338UA02HEBFdayORkjTKAcZH
         dB8g==
X-Gm-Message-State: AOAM530J7n4IYwaSTBEbgeOAuFtKxAvql6pfakN1tkeumE8rupM7y0uh
        Q4ErFT6O4GDRk9cwD0OXyd85qA==
X-Google-Smtp-Source: ABdhPJygA3+wJlqq/7i4ARv3CsflKFlPPEWz+QnFqwuzRmBpzcCDeEkLvXXazoHvBOFkCy4fOso2uA==
X-Received: by 2002:a17:90a:5911:: with SMTP id k17mr32248046pji.73.1619611095619;
        Wed, 28 Apr 2021 04:58:15 -0700 (PDT)
Received: from localhost (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id j11sm4770222pfj.182.2021.04.28.04.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:58:15 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/4] perf tool: Change fields type in cap_user_time_short
Date:   Wed, 28 Apr 2021 19:57:46 +0800
Message-Id: <20210428115749.5229-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428115749.5229-1-leo.yan@linaro.org>
References: <20210428115749.5229-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

C standard claims "An object declared as type _Bool is large enough to
store the values 0 and 1", bool type size can be 1 byte or larger than
1 byte.  Thus it's uncertian for bool type size with different
compilers.

This patch changes the bool type in structure cap_user_time_short to
__u8 type, and pads extra bytes for 8-byte alignment; this can give
reliable structure size.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: d110162cafc8 ("perf tsc: Support cap_user_time_short for event TIME_CONV")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/lib/perf/include/perf/event.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index d82054225fcc..48583e441d9b 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -346,8 +346,9 @@ struct perf_record_time_conv {
 	__u64			 time_zero;
 	__u64			 time_cycles;
 	__u64			 time_mask;
-	bool			 cap_user_time_zero;
-	bool			 cap_user_time_short;
+	__u8			 cap_user_time_zero;
+	__u8			 cap_user_time_short;
+	__u8			 reserved[6];	/* For alignment */
 };
 
 struct perf_record_header_feature {
-- 
2.25.1

