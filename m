Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D69C433ED
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 May 2021 17:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8D861352
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 May 2021 17:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhEMRr1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 May 2021 13:47:27 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:43582 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhEMRr0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 May 2021 13:47:26 -0400
Received: by mail-oi1-f173.google.com with SMTP id j75so26020232oih.10;
        Thu, 13 May 2021 10:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zdTDXiO3NCoXj2kA8r3dNvE7uEpdg8I31kDVNthsFDo=;
        b=gpY5EbX4xu/u+ROrmiRe8Kr7I/UEZELKt2apMxu2zSqx8zX2KArlf8wq4cXyFwz2xb
         mnG52vTLo/wknb4UvEMngl/FxclmMkepKaayRA9N8TkUbgUittshbL5tm1AMscB71Lo3
         ai/qfSYdxGAax7zN6h3MCNwM3Lgq2uDL8VUjiI9B+9tTKVlMJwywfY8XefDd68LM8aQf
         Fo+RLwxacrTWARCvdlZNtKF2NnHYvwHB9IZ3UN5r7u+G8bMle1Zjam2N+vMjQbHRaqBy
         tDD5YEaYfeah1BKPjoqLpE99u8OrDZApO0FbhcNIHCRBR8g5/6XOYlb7pyJuFGXca+JY
         pPNQ==
X-Gm-Message-State: AOAM53030PQ8uCwWaUHoY+IzNWSpyyINbux1Cbdh9VRfajo75uPuZPMw
        znZK/V+HAOZs0JBoOKJVMA==
X-Google-Smtp-Source: ABdhPJwu1PMiWUZJT7NXkbCBsBEbkfjyoJAb+z9Xpcg555TCUXYlw1jL00oWGRfvNungPOXDwuivBQ==
X-Received: by 2002:aca:1a16:: with SMTP id a22mr31566448oia.55.1620927976007;
        Thu, 13 May 2021 10:46:16 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id r7sm799574oom.46.2021.05.13.10.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 10:46:15 -0700 (PDT)
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
Subject: [PATCH 1/2] perf tests: Consolidate test__arch_unwind_sample declaration
Date:   Thu, 13 May 2021 12:46:13 -0500
Message-Id: <20210513174614.2242210-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There's no reason for making the test__arch_unwind_sample declaration per
arch. Currently that's done 2 different ways either with a declaration in
arch-tests.h or with an arch define. Unify all this with an unconditional
declaration in tests.h.

Cc: Matt Fleming <matt.fleming@intel.com>
Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Note that the only thing really arch specific is getting the stack
pointer. I'm happy to refactor this further to just an arch function to
get the stack pointer reg.

Compiled on arm64 and x86.

---
 tools/perf/arch/arm/include/arch-tests.h     | 5 -----
 tools/perf/arch/arm64/include/arch-tests.h   | 5 -----
 tools/perf/arch/powerpc/include/arch-tests.h | 7 -------
 tools/perf/arch/powerpc/tests/dwarf-unwind.c | 1 -
 tools/perf/arch/x86/include/arch-tests.h     | 7 -------
 tools/perf/arch/x86/tests/dwarf-unwind.c     | 1 -
 tools/perf/tests/dwarf-unwind.c              | 4 ----
 tools/perf/tests/tests.h                     | 2 --
 8 files changed, 32 deletions(-)

diff --git a/tools/perf/arch/arm/include/arch-tests.h b/tools/perf/arch/arm/include/arch-tests.h
index 90ec4c8cb880..c62538052404 100644
--- a/tools/perf/arch/arm/include/arch-tests.h
+++ b/tools/perf/arch/arm/include/arch-tests.h
@@ -2,11 +2,6 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
-#ifdef HAVE_DWARF_UNWIND_SUPPORT
-struct thread;
-struct perf_sample;
-#endif
-
 extern struct test arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
index 90ec4c8cb880..c62538052404 100644
--- a/tools/perf/arch/arm64/include/arch-tests.h
+++ b/tools/perf/arch/arm64/include/arch-tests.h
@@ -2,11 +2,6 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
-#ifdef HAVE_DWARF_UNWIND_SUPPORT
-struct thread;
-struct perf_sample;
-#endif
-
 extern struct test arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/powerpc/include/arch-tests.h b/tools/perf/arch/powerpc/include/arch-tests.h
index 1c7be75cbc78..c62538052404 100644
--- a/tools/perf/arch/powerpc/include/arch-tests.h
+++ b/tools/perf/arch/powerpc/include/arch-tests.h
@@ -2,13 +2,6 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
-#ifdef HAVE_DWARF_UNWIND_SUPPORT
-struct thread;
-struct perf_sample;
-int test__arch_unwind_sample(struct perf_sample *sample,
-			     struct thread *thread);
-#endif
-
 extern struct test arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index 8efd9ed9e9db..c9cb4b059392 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -7,7 +7,6 @@
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
-#include "arch-tests.h"
 
 #define STACK_SIZE 8192
 
diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index 0e20f3dc69f3..462546bfc5f7 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -12,13 +12,6 @@ int test__intel_pt_pkt_decoder(struct test *test, int subtest);
 int test__bp_modify(struct test *test, int subtest);
 int test__x86_sample_parsing(struct test *test, int subtest);
 
-#ifdef HAVE_DWARF_UNWIND_SUPPORT
-struct thread;
-struct perf_sample;
-int test__arch_unwind_sample(struct perf_sample *sample,
-			     struct thread *thread);
-#endif
-
 extern struct test arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 478078fb0f22..a54dea7c112f 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -7,7 +7,6 @@
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
-#include "arch-tests.h"
 
 #define STACK_SIZE 8192
 
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 83638097c3bc..a288035eb362 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -17,10 +17,6 @@
 #include "callchain.h"
 #include "util/synthetic-events.h"
 
-#if defined (__x86_64__) || defined (__i386__) || defined (__powerpc__)
-#include "arch-tests.h"
-#endif
-
 /* For bsearch. We try to unwind functions in shared object. */
 #include <stdlib.h>
 
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index b85f005308a3..1100dd55b657 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -133,14 +133,12 @@ bool test__bp_account_is_supported(void);
 bool test__wp_is_supported(void);
 bool test__tsc_is_supported(void);
 
-#if defined(__arm__) || defined(__aarch64__)
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 struct thread;
 struct perf_sample;
 int test__arch_unwind_sample(struct perf_sample *sample,
 			     struct thread *thread);
 #endif
-#endif
 
 #if defined(__arm__)
 int test__vectors_page(struct test *test, int subtest);
-- 
2.27.0

