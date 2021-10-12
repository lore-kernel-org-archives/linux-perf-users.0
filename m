Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB044C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 02:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A593161039
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 02:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhJLCP2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 22:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhJLCP1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Oct 2021 22:15:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9AFC061570
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 19:13:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u84-20020a254757000000b005bbc2bc51fcso10457124yba.3
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 19:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KXLwmwE4TrX9P6IfHZohm8oMSZRK5w3cuXTwrGX29F8=;
        b=s6h5WrvxdhfH8nPtVCEp6yhLe6ki5NJkW+X0HSOkzIm7FaG/nM7ZNv4StjZs3cN8qx
         FYoTKqfmeGy1MOSKo4Q3i6O/q+MKGpflPvh5SsGZAiM04or+oe6FezB+360Ra+pE1ixN
         JaTWixNi5478C09QmtT0KvRY0s8sVz7n6uvkw0q0Izaa5TRFMr6Ffoi6p2mTBsI3dpmh
         EW2qhP9uhfo1hM+x2ZIwOofiN5n6fennQEE+QzRa4olAEQlrPOhBqZX4WRVDHlIyX823
         Kn1FtbQ7jgS08c37hYUeN5p8Mg5YoDME/EROZCWDuFw96pXQoEgVtBMmQUBxVITKn78/
         DWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KXLwmwE4TrX9P6IfHZohm8oMSZRK5w3cuXTwrGX29F8=;
        b=X+qcyf6ctSyCa5u7FiuqJPEKOgoS6aBT72MJQXveis8Gf7JqGHOU/9sNp76FULbVxe
         wg+pu2c4BZs9tBD7ebisZwqCTsS8PnR9CHZ+654gFpInlrTBpmX6jpWJFdMlwSLUkAYo
         5w5u+T3CrdvxOL/UH2StEW/j+NyN6B3IGaOE5MIyhcbsjGLgxLPG8vaNQO6o+I44ppEo
         o3yFxqBvv76QYiu76YooIHCBx8cyo4aU0ttMvrhA+peKsmcpPqan5fkrv/VHNYzVVuGM
         gOFhIpmq3NQ2HNZCq7UEHPqvB3fCKnuymbLtCLtuXunV9BrQ0OSM8IBFfaG4zBTa1IyR
         dzeA==
X-Gm-Message-State: AOAM532crh0KBoRHhfvYn8hz+p2ljomK1HAlqfVyo5Aro+qeaskjky5R
        xG1lioS47lH0bGA8h41mjsLujGTkrZFG
X-Google-Smtp-Source: ABdhPJxfuUu/Fl1OhTq4pm+CzhQzuD9E4KsYwVBblC10vTGer3AmqY3riet4zRq0i5pEY9PK3+keIiba7UVd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2ad2:cb91:6fbd:a6f2])
 (user=irogers job=sendgmr) by 2002:a25:cc4a:: with SMTP id
 l71mr24630825ybf.41.1634004806327; Mon, 11 Oct 2021 19:13:26 -0700 (PDT)
Date:   Mon, 11 Oct 2021 19:13:20 -0700
Message-Id: <20211012021321.291635-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 1/2] tools: Bump minimum LLVM C++ std to GNU++14
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, Fangrui Song <maskray@google.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

LLVM 9 (current release is LLVM 13) moved the minimum C++ version to
GNU++14. Bump the version numbers in the feature test and perf build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/Makefile | 6 +++---
 tools/perf/Makefile.config   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index d024b5204ba0..19f145a35a43 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -300,7 +300,7 @@ $(OUTPUT)test-jvmti-cmlr.bin:
 	$(BUILD)
 
 $(OUTPUT)test-llvm.bin:
-	$(BUILDXX) -std=gnu++11 				\
+	$(BUILDXX) -std=gnu++14 				\
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
 		-L$(shell $(LLVM_CONFIG) --libdir)		\
 		$(shell $(LLVM_CONFIG) --libs Core BPF)		\
@@ -308,12 +308,12 @@ $(OUTPUT)test-llvm.bin:
 		> $(@:.bin=.make.output) 2>&1
 
 $(OUTPUT)test-llvm-version.bin:
-	$(BUILDXX) -std=gnu++11 				\
+	$(BUILDXX) -std=gnu++14					\
 		-I$(shell $(LLVM_CONFIG) --includedir)		\
 		> $(@:.bin=.make.output) 2>&1
 
 $(OUTPUT)test-clang.bin:
-	$(BUILDXX) -std=gnu++11 				\
+	$(BUILDXX) -std=gnu++14					\
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
 		-L$(shell $(LLVM_CONFIG) --libdir)		\
 		-Wl,--start-group -lclangBasic -lclangDriver	\
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0ae2e3d8b832..86be3f6ec018 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -285,7 +285,7 @@ CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
 CORE_CFLAGS += -std=gnu99
 
-CXXFLAGS += -std=gnu++11 -fno-exceptions -fno-rtti
+CXXFLAGS += -std=gnu++14 -fno-exceptions -fno-rtti
 CXXFLAGS += -Wall
 CXXFLAGS += -fno-omit-frame-pointer
 CXXFLAGS += -ggdb3
-- 
2.33.0.882.g93a45727a2-goog

