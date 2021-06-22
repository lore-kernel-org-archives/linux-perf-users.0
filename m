Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87BAC49EA4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 04:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B293B61289
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 04:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhFVEks (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 00:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhFVEkp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 00:40:45 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC62C061768
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 21:38:29 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id s9-20020ad452490000b02902786b63dbfeso796920qvq.5
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 21:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f6S0WBq/K51AHVi882cH7yHUVw3RgS/c1EddbRfRkGY=;
        b=XJjB3vfBTB14D/uOjWqlVbSdqEOMEKvPIBDNxqz245aG6s4iP3Wt97k13nN3heVdJ6
         yXw2rg1ihfW005qDP9buBaE/4XCpAr6GhYC5TM1rGAWqXqEnGIbUT9NzTC2IO3wV0X6y
         l2cdyBKSDaIn1cK13477PFiSXrMIx2fHhT7jw6dtr8TV2eURw2ahAjI9WxgX/tdOP7pe
         dWwJnArXjAmVRrsmOrux8UnQ9D0HS34lORpdLT37kpx9c4dUxm8lIR39IT0+FJNiEVOn
         h80EAvdKxtL+saT21doNHKY4cidpkUkGP+WtTrFAa+Bg1/wTXKkJ6H03TaTjMZs7gaCG
         3f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f6S0WBq/K51AHVi882cH7yHUVw3RgS/c1EddbRfRkGY=;
        b=WmBFjE+/dwO8PpAjNiUd4csYbIqjPd+FUlXM6dfg36TLTIFKfkipWjksjdutbexJnb
         wh5CA+mhzJm3J0E2XluiUMyPWmbUzLqVa8bg6JoZijHQmC+oxHbSoayktRTMTCZnWq7x
         orZ8VEvseH27zO1t1htG+erXVws7jwYtQUCNSoAhO8zznvZuTI1I1OZW6nPB9aUQFA+u
         tgywKhhXmvSnlcifeUBDKmKJ1rowJ2Dl9obNlja9mqSUq/XeYV3sH7AN7tMzTsu/zw1w
         2pwqpuFTyasZ7PIGieABPMRdFFira0n6oH3w4oZfiHNCLx/3zXy0uqdly1w6auPBjznc
         kP0g==
X-Gm-Message-State: AOAM532VTZobol1zNlQu4DZKjjK8eYxFbXzmxEAI4ZhSnz0ASO5ix0wa
        3xvwzzdysMImk67A2YFT2zRmEsP8ngAz
X-Google-Smtp-Source: ABdhPJxEEY/xt/NvaDOiUGhk4FeaGmtuHEugG55zaUrYTpgmZHnDr8YgjhvtfkrruUch1MG0uXP4KH/hY/1A
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ffd6:b7f5:87ee:7be2])
 (user=irogers job=sendgmr) by 2002:ad4:4e13:: with SMTP id
 dl19mr23694833qvb.9.1624336708448; Mon, 21 Jun 2021 21:38:28 -0700 (PDT)
Date:   Mon, 21 Jun 2021 21:38:10 -0700
In-Reply-To: <20210622043811.3108564-1-irogers@google.com>
Message-Id: <20210622043811.3108564-3-irogers@google.com>
Mime-Version: 1.0
References: <20210622043811.3108564-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 3/4] perf: Add define for libtracefs version
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-users@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Claire Jensen <cjense@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This will allow version specific support of libtracefs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6f318c16e8f1..9389ef68e2fb 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1108,6 +1108,12 @@ ifdef LIBTRACEFS_DYNAMIC
   $(call feature_check,libtracefs)
   ifeq ($(feature-libtracefs), 1)
     EXTLIBS += -ltracefs
+    LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs)
+    LIBTRACEFS_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEFS_VERSION)))
+    LIBTRACEFS_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEFS_VERSION)))
+    LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
+    LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
+    CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
   else
     dummy := $(error Error: No libtracefs devel library found, please install libtracefs-dev);
   endif
-- 
2.32.0.288.g62a8d224e6-goog

