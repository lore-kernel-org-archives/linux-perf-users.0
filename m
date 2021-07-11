Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BCBC07E9B
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345ED6124B
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhGKKob (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jul 2021 06:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbhGKKo3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jul 2021 06:44:29 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B5FC0613F0
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p36so3620726pfw.11
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LPazFJ4r8q67LCTGt2fdXct+L4YxBkcY5QLx/BSTmrQ=;
        b=POvLLo4cHkWQlMAsLQ4Y9JpAuqI1FU+6UmXnb8T6wONYc1quoDbOal1BKMsRaoWMLI
         2tU94Nw0RiwIvRb/uzrwla4KSNUP6QXgiL38agwG8J9ly8dMUFKHoUriKWWqhaLB+PFO
         ytG8fe+mo/Oe8BpVaJGb6cJhRkKD4ik9TOh8sNDaAGk9s21p/NXV+hNuym5T+ZxE3utr
         M2WKoakee71J8E43t7Bm0OPLCu+Nu4aa61gEpmo3UvvF9L7oUjB0/V172k6hpVVytFF6
         IlyYSVjs3Q8DjFrN6tqXry+5+YMnMwpJ7+rf3HMf6AwRpQImiztGNS0pe/7xwueIOiGY
         wBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LPazFJ4r8q67LCTGt2fdXct+L4YxBkcY5QLx/BSTmrQ=;
        b=Bf2nX8hZaK1G1gGBrkaS8QdPqLqYZ5uAbqErcpB1QA0HQ9lsaSI/WjMAxuR49wevou
         TxIl6ikL1XmYnts2atLU4bZiLk6XULDx2vwoBS44dXscjuQB2kbbVMBdR+IeietiQXy3
         HgBQGDnLUy7DDKIMHK94RDS8paMQIoNxxRw/j2I4bitGLZLhVitbFsuHT0c6Z5gP6Jss
         4NHPLFTmvj6kosT8SNt0wOQPutGtjhGCQxCviy+VCCCOISwbgGal95i2pXSVVsV6uEFa
         g0/zF+Bcb2/V6uhWJbQ5/Y6mIgo5bE/FBxwXhI4YgugYn4FyZLjMVuKwQGD4AVHHltWu
         iWuQ==
X-Gm-Message-State: AOAM533chMmmvjDeHu2C9o+EpUgJNHFJM9dfmDvBm8U/+KVCktq3s2dC
        c08fTAlTi2F4dRTmbV7qIxyF2A==
X-Google-Smtp-Source: ABdhPJxB9gRNxabK5m9zDDqBPjCJQYStcE6pZh/+2ENwklS8HlAU8vKuEB6cKafXlP6K7pQJO8CTHQ==
X-Received: by 2002:a63:cc0c:: with SMTP id x12mr46939866pgf.1.1626000102841;
        Sun, 11 Jul 2021 03:41:42 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id e16sm14171739pgl.54.2021.07.11.03.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:42 -0700 (PDT)
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
Subject: [PATCH v4 09/11] tools: Remove feature-sync-compare-and-swap feature detection
Date:   Sun, 11 Jul 2021 18:41:03 +0800
Message-Id: <20210711104105.505728-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711104105.505728-1-leo.yan@linaro.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
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

