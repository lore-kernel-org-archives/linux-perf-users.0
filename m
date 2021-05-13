Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA6C433B4
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 May 2021 17:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25F861352
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 May 2021 17:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhEMRrc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 May 2021 13:47:32 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:42596 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhEMRr2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 May 2021 13:47:28 -0400
Received: by mail-oi1-f173.google.com with SMTP id w22so12175807oiw.9;
        Thu, 13 May 2021 10:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtMRaGidq5AIIb5NEfzMSRmyxAUVpPVeHx2ahJS34Sw=;
        b=VFqb8jRH5S0P9IP6YlKpF69niCSdHokrPRz1A2LPqma+X+YtRSz3t6vD44viA3jMov
         9A35nBcruyKnE22cr92P7VJgxTpNFCEnhV4v2JN39CVtWBV4wTghWn1cSzWTstnDmY4U
         HCqgYqLsv5PINCd2Lrx4AIeiStrYjeS4OKnkm0CcmMHeHinZSJQ4LtEZemYeVHSwln3S
         phyqFeQSxkJbi+L9uSKGGL/GjT1hmxnIXiBevk5OAS0QPtNDtY9AC8pAseOakcYmv3es
         Qja9K6X4bwwDmS/jVv9411FMbOzS+Mq0+ESQwYyficrFJNDzqO8gcl8fDgDMmFho3LMh
         9y3w==
X-Gm-Message-State: AOAM532M7G1SrHXXnkEeQ+IeFal4Mj0WrYPruR6Es50y9cvAIyit5Orb
        gmhUt0azyqyrTUSlzGrB+w==
X-Google-Smtp-Source: ABdhPJwuMdqfKqn9iX2iIR2PPwGy55N98LKN3VvKhFptsqRWnJyzDnOhEEPv9Vyxo+12EJy9VC8Ugw==
X-Received: by 2002:aca:5758:: with SMTP id l85mr4047077oib.120.1620927977614;
        Thu, 13 May 2021 10:46:17 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id r7sm799574oom.46.2021.05.13.10.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 10:46:17 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Matt Fleming <matt.fleming@intel.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf tests: Drop __maybe_unused on x86 test declarations
Date:   Thu, 13 May 2021 12:46:14 -0500
Message-Id: <20210513174614.2242210-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210513174614.2242210-1-robh@kernel.org>
References: <20210513174614.2242210-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Function declarations don't need __maybe_unused annotations, only the
implementations do. Drop them on the perf x86 tests.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 tools/perf/arch/x86/include/arch-tests.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index 462546bfc5f7..9599e7a3f1af 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -2,12 +2,11 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
-#include <linux/compiler.h>
 struct test;
 
 /* Tests */
-int test__rdpmc(struct test *test __maybe_unused, int subtest);
-int test__insn_x86(struct test *test __maybe_unused, int subtest);
+int test__rdpmc(struct test *test, int subtest);
+int test__insn_x86(struct test *test, int subtest);
 int test__intel_pt_pkt_decoder(struct test *test, int subtest);
 int test__bp_modify(struct test *test, int subtest);
 int test__x86_sample_parsing(struct test *test, int subtest);
-- 
2.27.0

