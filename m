Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420122D4FA
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931305; cv=none; b=e6Xiu84coFqS0b716BcSwu/EPiyhTdCTFvrcwVxQRCa1eb0fJZtPpa6VDZtGLsnuQ5g5eEbzjzyjmfsAc7fMGjdXw8L9APaMNMT1zTkkUo/pIHhrW2ZSknZF9hTMyiWqI7hO6V74Cnmp3momVd4ixY9wrKMGT9yPXHb/QlXA5J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931305; c=relaxed/simple;
	bh=WlrESCObcpLxlvArnGyAQPVRYZZxf1CeQ6rfvuHIhQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ColbxKD8J8h15z4J/xZlAqce6AodA0p3WnmriEvOELh1VU02faBOOJBCjtydWjWKdSLkTj1lDjjE+LKU4tnxsGL2XVIyF4dDVTS0+CHsTG/r4ZEkW/KX7E+31cW1aA7YAMzZHxyX82zc8QVzeN56Voz9mMuJppAehe0qNhih3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkQ3pIAD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkQ3pIAD"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-227ea16b03dso16703585ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 16:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931303; x=1745536103; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5IiGvkesbLwU2LRHglyxF2fGjepXBF/Pg+PTt606Ww=;
        b=CkQ3pIADn3jWQu7qkm9wU0o1PKJ0c0ztlV0p6bspOGprrFb/04SWyl2xIzPLzdZFyd
         2nm6w9v/kovw7ePwrdlLWY32fFFabqtNY2HV07WXWVKwlcKhlrEd7HsUtuq0cOMnvWVP
         lDUd3Q9ECOSkfQqfwxCRzS4zb5cvJvKm78eBeTvAwYgtOMMbJju7EBcOkKp70pDTe3Do
         /z2LZaKRv/ANFeINMm7Dynr3FMTwOJxIKz58Ds5dGuJm5CQH0Ht1N1arYfZQHyDOjLNy
         l3OtZCweTwZ4bsTc3Hlqwt+ZPd6PqNx72VTssgN7f1WvKQGIiUVP/KY6FAuo+aC0dx45
         1yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931303; x=1745536103;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5IiGvkesbLwU2LRHglyxF2fGjepXBF/Pg+PTt606Ww=;
        b=uKh/UhLgL/clIvWPN6bTQpH6oTWXetMRZCa5khHVZ86fEDxHOoleEyTuUAZpM4w6ck
         es/9DPt5z570KjK5HhtdYa3SPleAHBgF7mNEVMsb+/bXclX9tVGpY5eWX1MeTuxlUlUX
         yGTrymnljm3D3/6BLCzrZqCyPc3mIg55R1laQPg8aVu+MXWRWjwrttz/GJv0iAjJOuIb
         lgxAMAZpZA2V1O9M7PPKyCtmgi85v/KRV9/rCg5XMWNwAaToWG01NGvZSyf3I+0Jazhq
         8qInTb6lBiJH1wQ/g3rzV1p46RYPbNtt63YXU7N3i752yPS7OBEvHhQZlebF6hz+Vl5b
         qamQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkHxpzFl9clpWnR7Pzquc/XhshPaT1U6hj1UVigE7DNJqSR+qFIXwsdqeBXorcJvuRS6NmQ3LI0bacaUI5H4yM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+J0wQ2NxJxBfhWAmDBvDtmIpD9T+WpOew9uEjQXXIizq1tX1k
	Fn63Ayd9vGCPydfE6CM6miSSfyQZE9ffqoy7TxZEcmn8Mw3ylMgPb3D7Wy0UZ2EPb1ksiLvuoPv
	4gZnT3w==
X-Google-Smtp-Source: AGHT+IG5F2LOaTgg/mX1XvwpFVLktCGd2m3MhUHdYc74oU2szNJdxzhC36EWYALgHq+zFbkNF9kxs7APIa5a
X-Received: from plhn17.prod.google.com ([2002:a17:903:1111:b0:21f:3ef1:c029])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a6b:b0:223:f408:c3e2
 with SMTP id d9443c01a7336-22c5357f39cmr10467445ad.14.1744931303485; Thu, 17
 Apr 2025 16:08:23 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:35 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-15-irogers@google.com>
Subject: [PATCH v4 14/19] perf build: Remove libiberty support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
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
index 870451929771..3ed047ffb4f5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -954,18 +954,6 @@ ifndef NO_DEMANGLE
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
index fc65537d5821..58982d8d1014 100644
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
@@ -298,10 +295,10 @@ LIBSYMBOL_DIR   = $(srctree)/tools/lib/symbol/
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
index 44d76eacce49..4a1ed20bff7e 100644
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
@@ -139,7 +138,6 @@ MAKE_F := $(MAKE) -f $(MK)
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
index 856819bbba59..6e0cf3d2aec5 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -28,13 +28,6 @@
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
@@ -287,13 +280,7 @@ static bool want_demangle(bool is_kernel_sym)
 char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unused,
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
 #endif /* !HAVE_CXA_DEMANGLE_SUPPORT */
 
-- 
2.49.0.805.g082f7c87e0-goog

