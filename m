Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DABD1AC44B
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193897; cv=none; b=doqKZrBX4uXeAcUgGsB5phE4yOQT6+QbQUYKySTp2nZGtfyhpU66nevwUHXr6iswdbD5l23J0j16Zavnw/nSlyppbt83qT7ajAjebuzI1085QYph2AUX2eebyQlr+mpxu3gLIW8xkWqVKjDnwoYP9ok+WVzG1qCLJKLgThXksxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193897; c=relaxed/simple;
	bh=rruGH38TSZOYfjW1/N60pJ/41Dq2JxcGpa5/2StUC4I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oE7kGQJMWH0wRiORG7YVUCY1vT89EWeTlVGx3RqQ3xSe7NCwDYOmXTtTeALUG9e67Ia0shZJw+Af0OGDSRqjfuWs9Kf+QDa9vFY80rXzgKxymKHy/fTjgkdZELPqNX6HmUCQh7742BrJHTxO+KXtAvY/85N3gw6vppU25v6y6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xbnkjaXL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xbnkjaXL"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e211e439a3so9798907b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727193894; x=1727798694; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azi3lOMKsZm5eq2iYCYCweyd2aFTYwHfrQ9vExF9G2E=;
        b=xbnkjaXL2mVZ9JAPzj8k0K5jRSjXQYTu+0n0Z7pP8/JHn8R7Rf1pjtFgnugdGMwYks
         2Wl2ULnBh5V+ss57L1cc+fgTLA9EJZ+9jZ2qb8ufwWw76sxPlQQ4EY6RU2JXN5i8FkJ0
         pOH/INPrlpV/wtx8vXoRhJy7k8ydHeFw3FgbGaLeaX1XC4P0xNn7mKSCLUKd500lhFha
         TaL0q+epF425XnEY3560kKAM/LLpkhqvMMpUfute7k+HK92u/TAX4H7b9A3YmT7T27uN
         1bqGYUvUSVmmNpXUyl2/yBoWNAUDanA8N07qaqMqU/ABtuEfbDYVaRgg8KlF/dvj2sU4
         ZxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193894; x=1727798694;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azi3lOMKsZm5eq2iYCYCweyd2aFTYwHfrQ9vExF9G2E=;
        b=uCrXOa6KP78N1MucchDcdjyyk6o0c2ew+Z2WemW0MB7S3ReGG/gDVwyPhZKLcq5zwM
         HLcg0vsIwOHfmfCBvtCLF47GQWIQ7kAd919tjDMx67sW4GA3LKciADXCTgvB/uN1VAqa
         dAks0TwnB13lhI7m2ew+cug+LkPCTFLFUntqecTKJjXtFmYKj+RAMCLo2EuveelX4+vB
         tpEDMZAsvS39L2YMfMbRgUfc8UHhIhOE08LxoS+B4W9JM9B3hnSmZUbVZEFEVlkrW0Ck
         t3vPT5W+S7hmBpnadgg8vkHKwOaouwQw99kuf7wygTlydTcZelgQY6UPpZpxt9O9mRfF
         jqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc/jbrp5tVKK0nEPW5z6TCtER7bCZOw2IIAvWA1aS3OfMmGSudSe97ZxwordoORQXUQBb4z2YrA2++ok+dV6RE@vger.kernel.org
X-Gm-Message-State: AOJu0YzNPJRMc2hu85yoNeyMtHb4NdjmBQ7jE8TsIYoUryXYdVa0TfN6
	ox/Q6Yrut/M2CtOJaufpvIBTvvJrFO65S80h+sMimjYKWXLQE5hkmQjjh3+gvoeyRMi6l9JPEKB
	1sTsCyw==
X-Google-Smtp-Source: AGHT+IFn//Bxcg3ECI3/hVbMi2EJYSViXIOaG1A9ioaU0lUv/zG4eCg+ouDnNx9U6BnSyTpMXpRdK1ayN/4Q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a81:8603:0:b0:6b0:57ec:c5f9 with SMTP id
 00721157ae682-6dfeea02193mr1014207b3.0.1727193894573; Tue, 24 Sep 2024
 09:04:54 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:04:12 -0700
In-Reply-To: <20240924160418.1391100-1-irogers@google.com>
Message-Id: <20240924160418.1391100-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 05/11] perf build: Combine test-dwarf-getlocations into test-libdw
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

dwarf_getlocations support in libdw is more than 10 years old. Make
libdw imply dwarf_getlocations support and simplify build logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature                  |  2 --
 tools/build/feature/Makefile                  |  4 ----
 tools/build/feature/test-all.c                |  5 -----
 tools/build/feature/test-dwarf_getlocations.c | 13 -------------
 tools/build/feature/test-libdw.c              | 14 +++++++++++++-
 tools/perf/Makefile.config                    | 10 ++--------
 6 files changed, 15 insertions(+), 33 deletions(-)
 delete mode 100644 tools/build/feature/test-dwarf_getlocations.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index db3695ec5f83..cf6a967575ea 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -31,7 +31,6 @@ endef
 FEATURE_TESTS_BASIC :=                  \
         backtrace                       \
         libdw                           \
-        dwarf_getlocations              \
         dwarf_getcfi                    \
         eventfd                         \
         fortify-source                  \
@@ -120,7 +119,6 @@ endif
 
 FEATURE_DISPLAY ?=              \
          libdw                  \
-         dwarf_getlocations     \
          glibc                  \
          libbfd                 \
          libbfd-buildid		\
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7bb409c1f7e6..7683d171f744 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -6,7 +6,6 @@ FILES=                                          \
          test-backtrace.bin                     \
          test-bionic.bin                        \
          test-libdw.bin                         \
-         test-dwarf_getlocations.bin            \
          test-dwarf_getcfi.bin                  \
          test-eventfd.bin                       \
          test-fortify-source.bin                \
@@ -185,9 +184,6 @@ endif
 $(OUTPUT)test-libdw.bin:
 	$(BUILD) $(DWLIBS)
 
-$(OUTPUT)test-dwarf_getlocations.bin:
-	$(BUILD) $(DWLIBS)
-
 $(OUTPUT)test-dwarf_getcfi.bin:
 	$(BUILD) $(DWLIBS)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 863c82516433..59ef3d7fe6a4 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -42,10 +42,6 @@
 # include "test-libdw.c"
 #undef main
 
-#define main main_test_dwarf_getlocations
-# include "test-dwarf_getlocations.c"
-#undef main
-
 #define main main_test_eventfd
 # include "test-eventfd.c"
 #undef main
@@ -184,7 +180,6 @@ int main(int argc, char *argv[])
 	main_test_gettid();
 	main_test_glibc();
 	main_test_libdw();
-	main_test_dwarf_getlocations();
 	main_test_eventfd();
 	main_test_libelf_getphdrnum();
 	main_test_libelf_gelf_getnote();
diff --git a/tools/build/feature/test-dwarf_getlocations.c b/tools/build/feature/test-dwarf_getlocations.c
deleted file mode 100644
index 78fb4a1fa68c..000000000000
--- a/tools/build/feature/test-dwarf_getlocations.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdlib.h>
-#include <elfutils/libdw.h>
-
-int main(void)
-{
-	Dwarf_Addr base, start, end;
-	Dwarf_Attribute attr;
-	Dwarf_Op *op;
-        size_t nops;
-	ptrdiff_t offset = 0;
-        return (int)dwarf_getlocations(&attr, offset, &base, &start, &end, &op, &nops);
-}
diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
index 793f4ac49514..83ea5d5f235d 100644
--- a/tools/build/feature/test-libdw.c
+++ b/tools/build/feature/test-libdw.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
 #include <dwarf.h>
 #include <elfutils/libdw.h>
 #include <elfutils/libdwfl.h>
@@ -22,7 +23,18 @@ int test_libdw_unwind(void)
 	return 0;
 }
 
+int test_libdw_getlocations(void)
+{
+	Dwarf_Addr base, start, end;
+	Dwarf_Attribute attr;
+	Dwarf_Op *op;
+	size_t nops;
+	ptrdiff_t offset = 0;
+
+	return (int)dwarf_getlocations(&attr, offset, &base, &start, &end, &op, &nops);
+}
+
 int main(void)
 {
-	return test_libdw() + test_libdw_unwind();
+	return test_libdw() + test_libdw_unwind() + test_libdw_getlocations();
 }
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 93fd6bd74d20..903de48c140d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -161,8 +161,6 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
 endif
 FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
-FEATURE_CHECK_CFLAGS-dwarf_getlocations := $(LIBDW_CFLAGS)
-FEATURE_CHECK_LDFLAGS-dwarf_getlocations := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-dwarf_getcfi := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-dwarf_getcfi := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 
@@ -464,15 +462,11 @@ else
   else
     ifneq ($(feature-libdw), 1)
       ifndef NO_LIBDW
-        $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
+        $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.157, disables dwarf support. Please install new elfutils-devel/libdw-dev)
         NO_LIBDW := 1
       endif
     else
-      ifneq ($(feature-dwarf_getlocations), 1)
-        $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157)
-      else
-        CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
-      endif # dwarf_getlocations
+      CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
       ifneq ($(feature-dwarf_getcfi), 1)
         $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.142)
       else
-- 
2.46.0.792.g87dc391469-goog

