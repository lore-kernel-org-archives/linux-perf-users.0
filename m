Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0451C43461
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 04:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8545F61364
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 04:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbhESER2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 00:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353264AbhESER1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 00:17:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A407C061760
        for <linux-perf-users@vger.kernel.org>; Tue, 18 May 2021 21:16:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g24so6649403pji.4
        for <linux-perf-users@vger.kernel.org>; Tue, 18 May 2021 21:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D1RKoRUPuNTpnbjdR5aGjDE7LDjBJaTYkeLxTxjV2B0=;
        b=XdLYknR3fS24BTVvcLO3iqnPV+utzH9WZmcaLVtD0da3CEd5nRSGOsYgETlrU0h0be
         XTFcdN16VnEGZSiAQWx8Jvxu/bc14GkHzaqJE4Bu8qqEv0DIneoy8ewj7eTQndwMZPSc
         gMc5biLXt5doir7/csUoUlJz92NHQKPnwJRvauj5n/4ZF0VmfmQ8D3xND0+36/esjZZ6
         QxTtkq8kQ+bqIEwOhilUnMl49r1x2PXqe2KXNzy5JYhS/yzDGtCky1lMghgG9DNIt0Ow
         28n2CzKD7dRk6sQKo+KjWubnmO+eTbzcjJoPmVHTmanbu2q1OWqbL0wgMeBB9WVpOnBJ
         +lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1RKoRUPuNTpnbjdR5aGjDE7LDjBJaTYkeLxTxjV2B0=;
        b=SQEh+6fTtk9ZJ4fpc+qPtHBaUNItA8aEwuCXtjm1XvlhEKUQDdZ/ugTz2zPCoasC/w
         HHF2257yCoKrZmb1ZMuR9i+j+SHlMa3jvjr7RjYaEO+m5jR8bkpIMLkmGng9RS5iK6iQ
         HLh98m6t3foQR2g8gZqr4ArooZqkSd2k3yV0cC+Gye1Ae/xAWGTzDMw7u266ai2Eh8hD
         bDvFw2DsshEB/UCrX0B2TKRpRQoRlsNjc92bzmEuoDFzEKhSeQaLdupajGFUy0wXIEUA
         k8hndlKK6qzrKgAM0/4kJRyHaz2tezWT607DdQPw2UKQs5vPi0WRRI0cApvx9ZpZe9Rg
         r04g==
X-Gm-Message-State: AOAM532Ztz1YheAUd5CJ6X2ZTu9AELQDUKPgTTh5V9cAR9jm+jxloXTR
        xE1qA/AcXWjufrjN2M7qPtQg1QMLZPM6Qj7SsGg=
X-Google-Smtp-Source: ABdhPJyh6+EMoF+CHQhlbWP3oQvoiUYhgaYPgM56CYEO/3syDO+eek0q9XYJLvBDwxuc46LHh4nY5A==
X-Received: by 2002:a17:902:f784:b029:ef:8e2f:430e with SMTP id q4-20020a170902f784b02900ef8e2f430emr8615252pln.28.1621397767625;
        Tue, 18 May 2021 21:16:07 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id np1sm3007388pjb.13.2021.05.18.21.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 21:16:07 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/4] perf arm-spe: Remove redundant checking for "full_auxtrace"
Date:   Wed, 19 May 2021 12:15:46 +0800
Message-Id: <20210519041546.1574961-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519041546.1574961-1-leo.yan@linaro.org>
References: <20210519041546.1574961-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The option "opts->full_auxtrace" is checked at the earlier place, if it
is false the function will directly bail out.  So remove the redundant
checking for "opts->full_auxtrace".

Suggested-by: James Clark <james.clark@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index bacdf366040d..a4420d4df503 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -116,7 +116,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		return 0;
 
 	/* We are in full trace mode but '-m,xyz' wasn't specified */
-	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
+	if (!opts->auxtrace_mmap_pages) {
 		if (privileged) {
 			opts->auxtrace_mmap_pages = MiB(4) / page_size;
 		} else {
-- 
2.25.1

