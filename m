Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D0173320
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Oct 2024 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158174; cv=none; b=Y02C4YWt6GatIgxKSjPIcZ8yLPd461SNYgtRAysO7YV9Mr+fTSfM/QA/w7NTjtO+PYk1QLfDDisZ9ITCCa5L/rm28Y9cLarwA599fj3OilWb93SIvYC7uqzMJtPhQ4hLvQ11gD++cs1A31Fg5MrnXOAPIhVKKx+UlpUfu05hmkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158174; c=relaxed/simple;
	bh=q4ft2hc9O4eMqPDP0cD0efN6RrA3dpWYVF7Lq3jWEYo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HZAXphFTOtVuHDsnu5YcBN+3BIUthQfmtm7JBlaOA8ydJAFLEq/PMcVavi7zT46D6JcfqqSpLRORV4CMOjKsVjny8vxH3yTYFa6MJl7p42FBrBXqd2RXZpP6lwI146lSE+aU/Omw2sAEi10TbG+CWZqaJ5/ABB4JrJC5EK0W0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yz7DyHmX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yz7DyHmX"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e21dcc7044so48809687b3.1
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158172; x=1728762972; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5T5tCPOGyJCvNBSpHWk2GY1SqD0ik3fhg7b1kYtWk8k=;
        b=yz7DyHmX2bhTqDLAQX7KOnjJGZRxn60ZSzAjxdIWKRR8PoKCVczG4EVoBEUwUVzTAV
         o5WTiAeWQTHfmt4rocbA9mFlY4M3lAr2qyaGqocz4gWqN8u9yLnb6ZFbijNHOZONdC4Z
         k7XWSb4OI7Pp+bd+03VHdxd0/JsI5/h03Gvw5JNiruDQ+OKnjLh2rWmTq4QdMJhcQpN2
         k/sdgRZeV2Kib2Y4hUXPoAp6IO+LWxY53C1zQaUPFOfNFOEF2kLU6p0xFTQ7mSBGaoP5
         aaIQSVr/P8IqtiloHZe8PGny13EY27NNiKX1XNh4Mc+COFp2ZOtvfI3Tda91+0zG07wV
         PgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158172; x=1728762972;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5T5tCPOGyJCvNBSpHWk2GY1SqD0ik3fhg7b1kYtWk8k=;
        b=gjVTcgCAgBOZ9/Dqd7/zp8Lt5bKNiv+YByoVXlPcLbAyIYi6hnsCYY1MomPVwOODDx
         efyaUz3nKh1pkgxLS9Tz7QBn7IwEKytNkNEvBewlisO1ZvetzYp3yuBldNpTcAp+wH0R
         ZHH7fDs8erWMfmHDxNaIW5SyVhPqnAylFgk2drJrtQMEh2p8+eOLFvK/76tm7066bLWb
         JIoWp4GkWzDL5WPPfDR68aOsPQPSoPGBnESUfzX4SI2F3lapDcXqCpXhYSy8dMNe9yP7
         KgsrlTRAEa3bR6OjJKTWqnrHRXtTD6tjlKYXD5KJQuWhOEkvDnqqSiyS/ppaRIDzxt3L
         uwMw==
X-Forwarded-Encrypted: i=1; AJvYcCU7+emvrktUjGlQxCWha2rh9UNBPXFKnbqm8dZKepvBphN6DXPDicS0n/M1YDZgMcSRqmvXYfmMMA24rioUBf0p@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmagiXJv9YI6mrWXBiB+qvVbeR89YV/WcD6p7m6LjnIMnZFrF
	nOWcp29946hMfc3j8ElwpCmhWtsP86MeXUa62KEZrUoqazxZJHH5ta0ALL597A+DhZannvyjPfj
	7EdhF/w==
X-Google-Smtp-Source: AGHT+IFUof9q2cilWVpyDs4oVP+nAlyKWLNvJCEvU13NF2KeKjgTJ+lCLvaeS32rFGhkBh06FROgvfGUuw0Q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a05:690c:3581:b0:6e2:6f2:efc with SMTP id
 00721157ae682-6e2c7290b3emr1498087b3.5.1728158171884; Sat, 05 Oct 2024
 12:56:11 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:16 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 06/31] perf build: Combine test-dwarf-getlocations into test-libdw
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
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Yury Norov <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
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
2.47.0.rc0.187.ge670bccf7e-goog

