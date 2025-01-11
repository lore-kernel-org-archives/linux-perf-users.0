Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B61B983F
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627343; cv=none; b=O1+m/J699YqcRC7sTEFSzSvj7putVWVwnHNeH8jpZWLIstZEFQkRyd6f5AqDgUNLSi4fdqaP08lTUGujwVRX6Qt+ZGDgUF+6nKQewYZyI07pA3Ura04IOgpsrwbzcgR92+RgA94gFLqwCam+kSg0Vyd34bJplHm5mXKUToWjv4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627343; c=relaxed/simple;
	bh=vBpZoAJV5ZOTYmr23Y1WVIS7/yi5sM9Ci/vypXLjlr4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qpU4w/TL+uy+SFbkf9Df0zqb++xO/prPxbWmZL3CNduIzgCEliLJdb/1Jwd3IuRUkllvJHZSYfh5nE5NoFglxyZ6RE9z7lqG3J++gnW8cXLO6lAQnuy5f/1N93a2YpiXcsd/c8S6e816O0yPVC9x7JI2S2s71qMMABoFXn2sUFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ckXQq0g; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ckXQq0g"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e544c8dae18so7882575276.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 12:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736627340; x=1737232140; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERQ++MSZHNKVH6KxsLg8v8E2btrNQhdFMhM0Mn52wJs=;
        b=3ckXQq0g3NMfa4Qx+VBqBEHggYb5C4TF3lXBgmRSlELdUF216d2+dHV3zRv5rDdrJ6
         ++V6kJsDm6wLMVUOBcxrJRWVbbP3jaQ3Sl54uv1ktqg8BQ6hyAPiUksAbCEigPfuaW2n
         PhaSp+3cbSAHjjv6PaTh97XXFo4iZEETU4rTG2HTr1kw4SOdqjwCdC1aIqwRkxvwyuGn
         +hc6SHuBQGo7kvCxSMSHLUFOUaF3yUarx8VwICIzDYoRYKrK2ZXwWQWIctTtAHLk7O1f
         EVUloLlCYTRmBZR7lH+EuWGBuXCyDAQlL51Ir+/wHF3fv/asnaDU5Jm9XF3801HVgcS7
         Wj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736627340; x=1737232140;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERQ++MSZHNKVH6KxsLg8v8E2btrNQhdFMhM0Mn52wJs=;
        b=tSB4tGoJntLqoxDHzLevIR16wneSnu+GZzGmBXE9A7SrrMAXUerPyNw/gb4DRyNaql
         edAqP2/dky+dyNdGdkKHQXIUqSyVug7VsV+teaJWOczWJquBDr8fZ0hIcXSXThEAWglS
         47cGoQolJSHsM8hMAp2sAggmyYRjUxA0aHFxHKMmlk0DbWWyFEvr2QKv4Dr0jhn9OlPg
         ws0IXOcD6FWjDARZJX/C7yQKeIfixnBm+AXOYsE5kHBdZykGMy6TZoDLs7jZ1080Q2dE
         8xx/tytcXazaiPht0Tj66E0Ch9x+uJUgzgkd34CWQySfznfIIWal49fMnVmxZuXVIoLA
         MRcg==
X-Forwarded-Encrypted: i=1; AJvYcCWjnMpdrwXqcyWeAWn3zXBz6rSNYU3ecCMf9mvIPIdO3qGn630D6d+wpPFlVjhrVIJHuCP24tVnj7fdyAdt/aA4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6057vAl9cyMmgPpwLPxdeUUmWGqZCf6Kb4Xqns8BOg/Fb+qIP
	Qr6rw2CYNl2qzc/LVLllJH4ODJk3Grwa4pfLtmTTxHfpr0FJHJl5d14kQ6GiYJ9lLL8coy6UHnh
	KHTcGfQ==
X-Google-Smtp-Source: AGHT+IE+viIYhxxDMKQTKGNKXQajHZQ7KQZoNknjBKnErH9SVvadqr4nAEWY311kOZ7fzckNDI8TKsKISW/4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a25:6cd7:0:b0:e39:78c0:3da with SMTP id
 3f1490d57ef6-e54edf1b3c2mr36379276.2.1736627339423; Sat, 11 Jan 2025 12:28:59
 -0800 (PST)
Date: Sat, 11 Jan 2025 12:28:50 -0800
In-Reply-To: <20250111202851.1075338-1-irogers@google.com>
Message-Id: <20250111202851.1075338-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111202851.1075338-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 2/3] perf build: Remove libiberty support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	James Clark <james.clark@linaro.org>, "Steinar H. Gunderson" <sesse@google.com>, 
	Changbin Du <changbin.du@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

libiberty is license incompatible with perf and building requires the
BUILD_NONDISTRO=1 build flag. libiberty is used for
HAVE_CPLUS_DEMANGLE_SUPPORT. Remove the code to simplify the code base
as it can't be distributed. Remove the BUILD_NONDISTRO build flag and
test as they no longer enable/disable support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config       | 12 ------------
 tools/perf/Makefile.perf         | 11 ++++-------
 tools/perf/tests/make            |  2 --
 tools/perf/util/demangle-cxx.cpp | 13 +------------
 tools/perf/util/symbol-elf.c     | 13 -------------
 5 files changed, 5 insertions(+), 46 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0844a797d30a..3b827eba53c0 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -936,18 +936,6 @@ ifndef NO_DEMANGLE
     CXXFLAGS += -DHAVE_CXA_DEMANGLE_SUPPORT
     $(call detected,CONFIG_CXX_DEMANGLE)
   endif
-  ifdef BUILD_NONDISTRO
-    ifeq ($(filter -liberty,$(EXTLIBS)),)
-      $(call feature_check,cplus-demangle)
-      ifeq ($(feature-cplus-demangle), 1)
-        EXTLIBS += -liberty
-      endif
-    endif
-    ifneq ($(filter -liberty,$(EXTLIBS)),)
-      CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
-      CXXFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
-    endif
-  endif
 endif
 
 ifndef NO_LZMA
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a449d0015536..008cee9d637a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -123,9 +123,6 @@ include ../scripts/utilities.mak
 #
 # Set BUILD_BPF_SKEL to 0 to override BUILD_BPF_SKEL and not build BPF skeletons
 #
-# Define BUILD_NONDISTRO to enable building an linking against libbfd and
-# libiberty distribution license incompatible libraries.
-#
 # Define EXTRA_TESTS to enable building extra tests useful mainly to perf
 # developers, such as:
 #	x86 instruction decoder - new instructions test
@@ -294,10 +291,10 @@ LIBSYMBOL_DIR   = $(srctree)/tools/lib/symbol/
 LIBPERF_DIR     = $(srctree)/tools/lib/perf/
 DOC_DIR         = $(srctree)/tools/perf/Documentation/
 
-# Set FEATURE_TESTS to 'all' so all possible feature checkers are executed.
-# Without this setting the output feature dump file misses some features, for
-# example, liberty. Select all checkers so we won't get an incomplete feature
-# dump file.
+# Set FEATURE_TESTS to 'all' so all possible feature checkers are
+# executed.  Without this setting the output feature dump file misses
+# some features. Select all checkers so we won't get an incomplete
+# feature dump file.
 ifeq ($(config),1)
 ifdef MAKECMDGOALS
 ifeq ($(filter feature-dump,$(MAKECMDGOALS)),feature-dump)
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 0ee94caf9ec1..dfe968413782 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -68,7 +68,6 @@ python_perf_so := $(shell $(MAKE) python_perf_target|grep "Target is:"|awk '{pri
 make_clean_all      := clean all
 make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
-make_nondistro      := BUILD_NONDISTRO=1
 make_extra_tests    := EXTRA_TESTS=1
 make_jevents_all    := JEVENTS_ARCH=all
 make_no_bpf_skel    := BUILD_BPF_SKEL=0
@@ -138,7 +137,6 @@ MAKE_F := $(MAKE) -f $(MK)
 endif
 run += make_python_perf_so
 run += make_debug
-run += make_nondistro
 run += make_extra_tests
 run += make_jevents_all
 run += make_no_bpf_skel
diff --git a/tools/perf/util/demangle-cxx.cpp b/tools/perf/util/demangle-cxx.cpp
index bd657eb37efc..36801ea327a6 100644
--- a/tools/perf/util/demangle-cxx.cpp
+++ b/tools/perf/util/demangle-cxx.cpp
@@ -8,13 +8,6 @@
 #include <cxxabi.h>
 #endif
 
-#if defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
-#ifndef DMGL_PARAMS
-#define DMGL_PARAMS     (1 << 0)  /* Include function args */
-#define DMGL_ANSI       (1 << 1)  /* Include const, volatile, etc */
-#endif
-#endif
-
 /*
  * Demangle C++ function signature
  *
@@ -24,11 +17,7 @@ extern "C"
 char *cxx_demangle_sym(const char *str, bool params __maybe_unused,
                        bool modifiers __maybe_unused)
 {
-#if defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
-        int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
-
-        return cplus_demangle(str, flags);
-#elif defined(HAVE_CXA_DEMANGLE_SUPPORT)
+#if defined(HAVE_CXA_DEMANGLE_SUPPORT)
         char *output;
         int status;
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index abd788c805db..cac98fa5daf0 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -27,13 +27,6 @@
 #include <symbol/kallsyms.h>
 #include <internal/lib.h>
 
-#if defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
-#ifndef DMGL_PARAMS
-#define DMGL_PARAMS     (1 << 0)  /* Include function args */
-#define DMGL_ANSI       (1 << 1)  /* Include const, volatile, etc */
-#endif
-#endif
-
 #ifndef EM_AARCH64
 #define EM_AARCH64	183  /* ARM 64 bit */
 #endif
@@ -285,13 +278,7 @@ static bool want_demangle(bool is_kernel_sym)
 __weak char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unused,
 			      bool modifiers __maybe_unused)
 {
-#if defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
-	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
-
-	return cplus_demangle(str, flags);
-#else
 	return NULL;
-#endif
 }
 
 static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
-- 
2.47.1.613.gc27f4b7a9f-goog

