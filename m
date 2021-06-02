Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D57C47083
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 10:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1705613B8
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 10:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhFBKcf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbhFBKcU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Jun 2021 06:32:20 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F77C061756
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Jun 2021 03:30:37 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e22so1855617pgv.10
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jun 2021 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SAzHmAT4S261rPuHMSSnq0NUaRVlh+m0eXDWd0+8YM=;
        b=f5uETbSu0slGWjnOwVuhzwPC2PeWII4nuiVKyGsySkKsiOlhCZVuLFaAmWRtGZ60sB
         YbIERc223XE3G01FEVHlcbj3rvS7//wS5itbOp97GGEsx0Kyr8ZGCk39CmYYLITMGLpV
         nCl7zxU+QNBhlW7OdD4Ys4A0pphOOYxKQf7Daxdc2Np8SYp5xnGCPYuv/ZeYfLVqrk5E
         xfkgOQyGpeaObgBXApw6mLViAj3nsLAy1d1FHBsJRJd9jA63q3/+MUjcJjQLPmtx5JaP
         Fz2fXM9j5S6jradPxmeQal2Ny+kaG8pUiHNyocTcrPYv9AjaZkNtix4iGYxkWLYyb8X2
         pnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SAzHmAT4S261rPuHMSSnq0NUaRVlh+m0eXDWd0+8YM=;
        b=g1XyGcPSp+OyNcga76er8HJ3LCMURHTa7pocZFYaHOqF0M7IOQqBLrlKAIEQvc4lyq
         fPDZRmDSKXBrdAqjfQA5znFvkY2FWVJwh4uawRlakSAAOMBHxQmeiS/mwqjSAKG1+GH5
         sw3JS7YR3al/CVZMC8Dgz9OZ9RYFWe21k8SOwFByWWr4GINs2NogleR3lagwilKFezcQ
         oqdR6HAhcwtQr/Pzgg5AW39zcDpeeyysLsXzx76HIZeF2eK7AKmSKa51yFlmets4TiH7
         OW+AutetC2DlUTcgP8D6v6Ef9M+1rJVYQBM3Fixacz+60Y/H1DmJPF3U1RUU2Q4w2j1+
         Yh8Q==
X-Gm-Message-State: AOAM532EhHe69beUqTiqybXwkaEJp/jGjGpQISjmdBZWEJvCtkeC19H5
        pikP5FCFznROKywqCL41fpLR7w==
X-Google-Smtp-Source: ABdhPJzfEEAZBOb+E52o6ECvVa+XAO+vxjOcpz63OhpG4yHtgnos+M5nlRF7RsaNERHXQVqG6bWx8Q==
X-Received: by 2002:a62:7587:0:b029:2e9:a997:1449 with SMTP id q129-20020a6275870000b02902e9a9971449mr20698327pfc.57.1622629837509;
        Wed, 02 Jun 2021 03:30:37 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id r10sm18379761pga.48.2021.06.02.03.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:30:37 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 7/8] perf auxtrace: Use WRITE_ONCE() for updating aux_tail
Date:   Wed,  2 Jun 2021 18:30:06 +0800
Message-Id: <20210602103007.184993-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602103007.184993-1-leo.yan@linaro.org>
References: <20210602103007.184993-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use WRITE_ONCE() for updating aux_tail, so can avoid unexpected memory
behaviour.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/auxtrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index e625bc76cdde..abc4282f5272 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -458,7 +458,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 
 	/* Ensure all reads are done before we write the tail out */
 	smp_mb();
-	pc->aux_tail = tail;
+	WRITE_ONCE(pc->aux_tail, tail);
 }
 
 int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
-- 
2.25.1

