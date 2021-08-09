Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8475BC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 11:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ACE86103B
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 11:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhHILQN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 07:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbhHILQE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 07:16:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C420AC0617A2
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Aug 2021 04:15:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c16so15968800plh.7
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Aug 2021 04:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LPazFJ4r8q67LCTGt2fdXct+L4YxBkcY5QLx/BSTmrQ=;
        b=Y37NeWeM8ygxFN4RiHvbkan+MaeJwrFayZTpBNaCeDDH8fKKm4bpBNKixRxVrqFS7Z
         dxeNKAzOAoxVahIuXzem57PUjcJjPegN3KJMMl1pUooq/DbOBHAi71oJhXadH+zDS8/g
         IPA4uUq63TLJQJGLobhD91tzGzhhekRTD/U5llmlwOdEQT7G9yrHCGE77ee2uvidGAN5
         hmO7ThrnPz7GKvts73DCbSA3ZQrbZI20YpvQoZJzPQOrinBU0P6xtrHRc1PZLpcUCPIR
         EkN9+574DjseV6Ppp06abJEvAWMtGiLs5RIq3L5NQa6J/E2vJ3zvs+CZyGZAVt1CchPh
         0eXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LPazFJ4r8q67LCTGt2fdXct+L4YxBkcY5QLx/BSTmrQ=;
        b=GpXx8y+pdBLhcZJetrcCmZk2u1Kng2xKk2Ge7J0SRp7oPVcbGHyC0wlu801cmH36ri
         CHu2KRzuPnpRrH9iwxz00Wf3Wo09EflGbw9+YF89ql4Ih98gdnMb3mYKdCjBOKck9W+2
         HG6h7lNwx+Fk4ye2AYqNBi8IANjstPoqhC7+BVBi7dgcm3RmO+V8w4mlNp+pJHwsmIZ8
         Z040bgvLJUKoQZiJUg9ZxhHGd9ygAiyIQ4gADE8qoucapp4RAFORViAX1A0Hn4Bim8Qb
         BndAwCRl+urV1b5q2ezke66V+nHprvWRMNgP7EwedMWgAHgv0yU99GJ4Y/3JXtnhopld
         yVRw==
X-Gm-Message-State: AOAM532ybFei5mXiWidDUCJc3XXs42zmBGRFuOODwDC52sVD6WPnuQ33
        4ogib5/wqby2f8aCZhymzKvZCQ==
X-Google-Smtp-Source: ABdhPJyNRUiLvwAeyayLK8GRSGYueC2D8c/065kp0jX3tzimYMHZ2HpvOp+REZs7Zc2SGXyC2WeCKw==
X-Received: by 2002:a17:902:d114:b029:12d:4202:655a with SMTP id w20-20020a170902d114b029012d4202655amr215137plw.0.1628507742274;
        Mon, 09 Aug 2021 04:15:42 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id b10sm19656631pfi.122.2021.08.09.04.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:15:41 -0700 (PDT)
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
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 9/9] tools: Remove feature-sync-compare-and-swap feature detection
Date:   Mon,  9 Aug 2021 19:14:07 +0800
Message-Id: <20210809111407.596077-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809111407.596077-1-leo.yan@linaro.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since the __sync functions have been removed from perf, it's needless
for perf tool to test the feature sync-compare-and-swap.

The feature test is not used by any other components, remove it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/build/Makefile.feature                     |  1 -
 tools/build/feature/Makefile                     |  4 ----
 tools/build/feature/test-all.c                   |  4 ----
 tools/build/feature/test-sync-compare-and-swap.c | 15 ---------------
 4 files changed, 24 deletions(-)
 delete mode 100644 tools/build/feature/test-sync-compare-and-swap.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 04a8e3db8a54..3dd2f68366f9 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -34,7 +34,6 @@ FEATURE_TESTS_BASIC :=                  \
         dwarf_getlocations              \
         eventfd                         \
         fortify-source                  \
-        sync-compare-and-swap           \
         get_current_dir_name            \
         gettid				\
         glibc                           \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index ec203e28407f..eff55d287db1 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -9,7 +9,6 @@ FILES=                                          \
          test-dwarf_getlocations.bin            \
          test-eventfd.bin                       \
          test-fortify-source.bin                \
-         test-sync-compare-and-swap.bin         \
          test-get_current_dir_name.bin          \
          test-glibc.bin                         \
          test-gtk2.bin                          \
@@ -260,9 +259,6 @@ $(OUTPUT)test-libdw-dwarf-unwind.bin:
 $(OUTPUT)test-libbabeltrace.bin:
 	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
 
-$(OUTPUT)test-sync-compare-and-swap.bin:
-	$(BUILD)
-
 $(OUTPUT)test-compile-32.bin:
 	$(CC) -m32 -o $@ test-compile.c
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 464873883396..920439527291 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -106,10 +106,6 @@
 # include "test-libdw-dwarf-unwind.c"
 #undef main
 
-#define main main_test_sync_compare_and_swap
-# include "test-sync-compare-and-swap.c"
-#undef main
-
 #define main main_test_zlib
 # include "test-zlib.c"
 #undef main
diff --git a/tools/build/feature/test-sync-compare-and-swap.c b/tools/build/feature/test-sync-compare-and-swap.c
deleted file mode 100644
index 3bc6b0768a53..000000000000
--- a/tools/build/feature/test-sync-compare-and-swap.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdint.h>
-
-volatile uint64_t x;
-
-int main(int argc, char *argv[])
-{
-	uint64_t old, new = argc;
-
-	(void)argv;
-	do {
-		old = __sync_val_compare_and_swap(&x, 0, 0);
-	} while (!__sync_bool_compare_and_swap(&x, old, new));
-	return old == new;
-}
-- 
2.25.1

