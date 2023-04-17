Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69811C77B76
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Apr 2023 19:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjDQT0B (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjDQTZ7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Apr 2023 15:25:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ED45FD6
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Apr 2023 12:25:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b5-20020a253405000000b00b8f66e29f5cso9418267yba.21
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Apr 2023 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681759557; x=1684351557;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SXudyeJ/Cf8/L3rur43uuTWwi+2mrCWXl6MOmXE+mSM=;
        b=rQDKQl9K0v4uhRr1ziEwpXOTAKKrLhUvSE6jNAZAHgj/2Zyh5/9gE5FzIWiR8ii5wK
         dSmZoVARdmz+EAfLi+thJjqnn//w48INpmm2zFqS6zs8i8InU8XIOgDHY8c5XPHv2aZr
         /7ZXNDX74WAi6heqXRHqZ36vmKROgF8EZrtzOE/BTFEJTX6/sKTzcsRoUtenMR4Pdeje
         v3C3qramZ8e8neBgcbkvUVIA5ghWVnnXd41tUJyLZPqxJSnnQTiu5SwWpQAH/eY+ss4a
         lTHdexOT/WbK1HYMPAQmbsB0d3GLQoDhgWKMpfnG5xTqqXa/NHGlYMOSkSx6X56azY2b
         f8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681759557; x=1684351557;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXudyeJ/Cf8/L3rur43uuTWwi+2mrCWXl6MOmXE+mSM=;
        b=mGrMnjdyMf1drRjMZq+5HBtoCmI+5ycDHbN1YUYoQC7VAnXsSz8H1Yip67pJrn/Xn1
         2zDhV9UEFfqYgYjhnHP2yTfzYCyft8c371wMAHCITUB81PQzzHgM4vGO2uFY8vIu+3sY
         aw7a1Xjch8bEnmjULRBuVkcgIMuJuwN2nEucxN617mQRm+ovYNO+J80vP9P++eYknI31
         pARUb5WBYqvyBVqFzhRrXE1sG2Bp6KGmslBc2sY3jbf6ncOnDkdTZL0YdxGoS7BPQIV9
         MWnSeu5wp3xcwSHYHKGlTJNa6AaPXt+U1Nf6XCa+njAGYzkqs/49c/K/buhpRK5nakGd
         Cc3Q==
X-Gm-Message-State: AAQBX9cvW/AhBNtMdm7fCy+EBz0mLzYM2Q7m3HbfzPyC8b5sro7xAsec
        A90WzQqR0CNrmQOcR+wConXT1bAXjI3t
X-Google-Smtp-Source: AKy350axqLr5/aptfTTOZfKVP35oXDiOhVWyisXf+vfqQI8tQhZy3EwoF57xWjk89OFBHizuQdy/v9EcQRrK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d607:b4c5:5ac0:b831])
 (user=irogers job=sendgmr) by 2002:a25:d44a:0:b0:b77:676c:773c with SMTP id
 m71-20020a25d44a000000b00b77676c773cmr10297154ybf.2.1681759557123; Mon, 17
 Apr 2023 12:25:57 -0700 (PDT)
Date:   Mon, 17 Apr 2023 12:25:46 -0700
Message-Id: <20230417192546.99923-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Subject: [PATCH v1] perf build: Don't compile demangle-cxx.cpp if not necessary
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Qi Liu <liuqi115@huawei.com>, Leo Yan <leo.yan@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

demangle-cxx.cpp requires a C++ compiler, but feature checks may fail
because of the absence of this. Add a CONFIG_CXX_DEMANGLE so that the
source isn't built if not supported. Copy libbfd and cplus demangle
variants to a weak symbol-elf.c version so they aren't dependent on
C++. These variants are only built with the build option
BUILD_NONDISTRO=1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config   |  1 +
 tools/perf/util/Build        |  2 +-
 tools/perf/util/symbol-elf.c | 27 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 71442c54c25f..5f0f24b56f50 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -923,6 +923,7 @@ ifndef NO_DEMANGLE
     EXTLIBS += -lstdc++
     CFLAGS += -DHAVE_CXA_DEMANGLE_SUPPORT
     CXXFLAGS += -DHAVE_CXA_DEMANGLE_SUPPORT
+    $(call detected,CONFIG_CXX_DEMANGLE)
   endif
   ifdef BUILD_NONDISTRO
     ifeq ($(filter -liberty,$(EXTLIBS)),)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index bd18fe5f2719..f9df1df1eec0 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -214,7 +214,7 @@ perf-$(CONFIG_ZSTD) += zstd.o
 
 perf-$(CONFIG_LIBCAP) += cap.o
 
-perf-y += demangle-cxx.o
+perf-$(CONFIG_CXX_DEMANGLE) += demangle-cxx.o
 perf-y += demangle-ocaml.o
 perf-y += demangle-java.o
 perf-y += demangle-rust.o
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 35724f6a84fa..cd08bdb9824f 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -31,6 +31,13 @@
 #include <bfd.h>
 #endif
 
+#if defined(HAVE_LIBBFD_SUPPORT) || defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
+#ifndef DMGL_PARAMS
+#define DMGL_PARAMS     (1 << 0)  /* Include function args */
+#define DMGL_ANSI       (1 << 1)  /* Include const, volatile, etc */
+#endif
+#endif
+
 #ifndef EM_AARCH64
 #define EM_AARCH64	183  /* ARM 64 bit */
 #endif
@@ -271,6 +278,26 @@ static bool want_demangle(bool is_kernel_sym)
 	return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
 }
 
+/*
+ * Demangle C++ function signature, typically replaced by demangle-cxx.cpp
+ * version.
+ */
+__weak char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unused,
+			      bool modifiers __maybe_unused)
+{
+#ifdef HAVE_LIBBFD_SUPPORT
+	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
+
+	return bfd_demangle(NULL, str, flags);
+#elif defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
+	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
+
+	return cplus_demangle(str, flags);
+#else
+	return NULL;
+#endif
+}
+
 static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 {
 	char *demangled = NULL;
-- 
2.40.0.634.g4ca3ef3211-goog

