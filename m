Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4691AC43B
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193894; cv=none; b=rLa0gxDQ0h2J+oKV2CUgqHzO9O8WHNEAWzvJ5sFe4riCGrc8zaDtstoaYgpU7BswSk/CVriqY6ctfVfTYYuT1qXzQaZ8ZXAaiQquScID0W23cPS+QH1fuD3nLK/YK7V+yu6cBHvj2qzVDDImMLwoySp4CxCll2GnCMlZBlD+YxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193894; c=relaxed/simple;
	bh=5+TP5c012LI2AoqEdXEI8GvA+4ixa18Xpdmo9YFnRNM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hAKY/28lsKiWXV8C2NWPLrg6dsmNRZfUHObhe2XnT1CFP/tbyPDMv0qeWlmQwI4UhjyYPSzytmFv6r6sWdi1sLZVHS5q4CtbBo9jhZ+L7EFsUtAns1YwaEB/SDzdLdjeK3tWaqMJb+28FJYZWTYA7o7vNQKGFErcfCkIfRlMhnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AvRnai/N; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AvRnai/N"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4bd76f5a8so88681587b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727193892; x=1727798692; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjuTqW9o4pHYWqMKRuPj6vA5c1OHRz2lfcyVQCR2e1g=;
        b=AvRnai/NHed3oA0L7RUeFmI3cZRl+yrXrkijyDnJHAnwGQPk0JEmhPia4Q7zHUJJo1
         J6OdzkA6t+JbzmbP81BqBOqycV/dPojMjlYPmEG54bdNIJOwuGWV/G6kngG2XVQN/76R
         io/qDtiVIsQbg/FM+xVFmefbcxT6VNxTxjd37pcJMEJEQ8SCJgq+BSDDTAVYqsRXO+Ey
         L5DeWhfy7gVoDomWN34JG8sKbO8TRwcs+lfXR8wLQeKYYinHw2ugfdzqDLBEGSETaZZ6
         OSt9bjflV5VPqtffuxWbtWIAD52Tgo5PoZT3Wc1H7MV2pZvDWqJo3pXvbh9q64C48gEO
         nh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193892; x=1727798692;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjuTqW9o4pHYWqMKRuPj6vA5c1OHRz2lfcyVQCR2e1g=;
        b=apz7V+mLj99nM049SQAxkuJ+o1m3o8aDQc1G4S4CB/vUkqhpZqzhl1OcJ4u66YhbFB
         lvfl523kNlvAiLTcLbnvYKyr2BWwQ5T0gOWtDxfMWSzdhFjeAnzTASXx7fLVz1wVadwI
         Aa4LFDKz1Y4AjFgzhtpBv+Eq8Yg/1cBOcldRjHS9D0Z6cNY214TuI4JWaW9l3vjINMZM
         OV+SZNZx5W/Nkh051pOov0MM0vmpLlSqr0BcMBJvlKgaUP5Xt8S097PgE1HsuIPuJh94
         71Zy/ZXzy38QXzPth1JYBjZ8vDZRNP9oONlYzru+n0wyKbuqETbOY5fUxi1bqvBHq98k
         wbjg==
X-Forwarded-Encrypted: i=1; AJvYcCVLOlvz6ws2PynbuRJD9iNyb1LTCmeRLvvn/zJoiGbJ8SUag6Ifn2hCmcGM7UdFanZcfLTFB6ia8e5EiPQ1E0tw@vger.kernel.org
X-Gm-Message-State: AOJu0YwStSwGKl4ePHG8k/1MhQb9APYtaVdmw67v2qo6LPCvY5e1ua0j
	pt9/C052+X+KU06iP7+kBboLtXkeBFymBfvAQdsepVbRMX7tSQQsuSVsYLy1rjRWVNCdMIkIrjP
	pxm3h4g==
X-Google-Smtp-Source: AGHT+IGhTzyOV9p0U4//yxmppvbUdb592+O3yKg5lTmRXUxVgP8HrO/MQGhSKuOL5lMIGVLVUgkiQTtmBrFa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a25:dcd3:0:b0:e11:7246:963b with SMTP id
 3f1490d57ef6-e2252f1c53emr49215276.1.1727193891984; Tue, 24 Sep 2024 09:04:51
 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:04:11 -0700
In-Reply-To: <20240924160418.1391100-1-irogers@google.com>
Message-Id: <20240924160418.1391100-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 04/11] perf build: Combine libdw-dwarf-unwind into libdw
 feature tests
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

Support in libdw has been present for 10 years so let's simplify the
build logic with a single feature test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature                  |  2 --
 tools/build/feature/Makefile                  |  4 ----
 tools/build/feature/test-all.c                |  5 -----
 tools/build/feature/test-libdw-dwarf-unwind.c | 14 --------------
 tools/build/feature/test-libdw.c              | 19 ++++++++++++++++++-
 tools/perf/Makefile.config                    |  8 --------
 6 files changed, 18 insertions(+), 34 deletions(-)
 delete mode 100644 tools/build/feature/test-libdw-dwarf-unwind.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 6025810cc346..db3695ec5f83 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -60,7 +60,6 @@ FEATURE_TESTS_BASIC :=                  \
         reallocarray                    \
         stackprotector-all              \
         timerfd                         \
-        libdw-dwarf-unwind              \
         zlib                            \
         lzma                            \
         get_cpuid                       \
@@ -133,7 +132,6 @@ FEATURE_DISPLAY ?=              \
          libpython              \
          libcrypto              \
          libunwind              \
-         libdw-dwarf-unwind     \
          libcapstone            \
          llvm-perf              \
          zlib                   \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index bece326ac93b..7bb409c1f7e6 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -52,7 +52,6 @@ FILES=                                          \
          test-pthread-barrier.bin		\
          test-stackprotector-all.bin            \
          test-timerfd.bin                       \
-         test-libdw-dwarf-unwind.bin            \
          test-libbabeltrace.bin                 \
          test-libcapstone.bin			\
          test-compile-32.bin                    \
@@ -314,9 +313,6 @@ $(OUTPUT)test-backtrace.bin:
 $(OUTPUT)test-timerfd.bin:
 	$(BUILD)
 
-$(OUTPUT)test-libdw-dwarf-unwind.bin:
-	$(BUILD) # -ldw provided by $(FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind)
-
 $(OUTPUT)test-libbabeltrace.bin:
 	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index d60e072b6eca..863c82516433 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -98,10 +98,6 @@
 # include "test-stackprotector-all.c"
 #undef main
 
-#define main main_test_libdw_dwarf_unwind
-# include "test-libdw-dwarf-unwind.c"
-#undef main
-
 #define main main_test_zlib
 # include "test-zlib.c"
 #undef main
@@ -202,7 +198,6 @@ int main(int argc, char *argv[])
 	main_test_numa_num_possible_cpus();
 	main_test_timerfd();
 	main_test_stackprotector_all();
-	main_test_libdw_dwarf_unwind();
 	main_test_zlib();
 	main_test_pthread_attr_setaffinity_np();
 	main_test_pthread_barrier();
diff --git a/tools/build/feature/test-libdw-dwarf-unwind.c b/tools/build/feature/test-libdw-dwarf-unwind.c
deleted file mode 100644
index ed03d9505609..000000000000
--- a/tools/build/feature/test-libdw-dwarf-unwind.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <elfutils/libdwfl.h>
-
-int main(void)
-{
-	/*
-	 * This function is guarded via: __nonnull_attribute__ (1, 2).
-	 * Passing '1' as arguments value. This code is never executed,
-	 * only compiled.
-	 */
-	dwfl_thread_getframes((void *) 1, (void *) 1, NULL);
-	return 0;
-}
diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
index 8d474bd7371b..793f4ac49514 100644
--- a/tools/build/feature/test-libdw.c
+++ b/tools/build/feature/test-libdw.c
@@ -1,11 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dwarf.h>
 #include <elfutils/libdw.h>
+#include <elfutils/libdwfl.h>
 #include <elfutils/version.h>
 
-int main(void)
+int test_libdw(void)
 {
 	Dwarf *dbg = dwarf_begin(0, DWARF_C_READ);
 
 	return (long)dbg;
 }
+
+int test_libdw_unwind(void)
+{
+	/*
+	 * This function is guarded via: __nonnull_attribute__ (1, 2).
+	 * Passing '1' as arguments value. This code is never executed,
+	 * only compiled.
+	 */
+	dwfl_thread_getframes((void *) 1, (void *) 1, NULL);
+	return 0;
+}
+
+int main(void)
+{
+	return test_libdw() + test_libdw_unwind();
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c8e157cc0c5e..93fd6bd74d20 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -161,8 +161,6 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
 endif
 FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
-FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
-FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-dwarf_getlocations := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-dwarf_getlocations := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-dwarf_getcfi := $(LIBDW_CFLAGS)
@@ -464,12 +462,6 @@ else
       endif
     endif
   else
-    ifndef NO_LIBDW_DWARF_UNWIND
-      ifneq ($(feature-libdw-dwarf-unwind),1)
-        NO_LIBDW_DWARF_UNWIND := 1
-        $(warning No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR)
-      endif
-    endif
     ifneq ($(feature-libdw), 1)
       ifndef NO_LIBDW
         $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
-- 
2.46.0.792.g87dc391469-goog

