Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C153E2ABF;
	Tue,  2 Jun 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411465; cv=none; b=sKzsJckyPOKB0ORcoAN8ACRm0YpyEFDIEjpUPm61BK43iRdXpZjcqxWTjBKeB+N5v/0ApytfxjGlGx4N2RVh/wjeNFz95JSfjBKSCgDn0OqVBj/RppjhT1wKFHH4CxIuOurQo5uLmAPHdLZxqCm4ofNpdcTR+tnh5AcOCMnoPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411465; c=relaxed/simple;
	bh=RJCrBBCoyZk9ItWKXFzBfBNj6qLZCgM5gXRLbvh4BLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=goAOVpdXZyjkMIqxOFUWViOGoMy+RVRsVPHXEUSkD6Q6isG1AxTQDm0WbKSJ3MpR+OicFRxzSPXvQIt9oGep/3/h0//ZGmEdISsfjoCgABRqHvqKMjbMCs2hPzc3sufowh8bsKOgVEA38+2fXSQqF3WbnfaRZ9gc2eraDERgQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=R0QATQHb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="R0QATQHb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1C2F3583;
	Tue,  2 Jun 2026 07:44:18 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4A423F632;
	Tue,  2 Jun 2026 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411463; bh=RJCrBBCoyZk9ItWKXFzBfBNj6qLZCgM5gXRLbvh4BLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R0QATQHblGPPiy3kp6Q5tAPadpnFPjNlqMVkCAsG9P8rbyOuQlPa/ms/x3W0sTP4h
	 ZZn87mnp5fV5NvOjR+PRkan/Zp8sr2vNZDO1CCaWZLTbsJCvzbxpsAd95HzUb6gpun
	 O5UtzDblPfwyv6O6mrUy/clfu6Mu/N7GMjn1mayg=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:40:57 +0100
Subject: [PATCH v7 23/23] selftests: Include tools Makefile.include
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init-v7-23-631baf679fe7@arm.com>
References: <20260602-tools_build_fix_zero_init-v7-0-631baf679fe7@arm.com>
In-Reply-To: <20260602-tools_build_fix_zero_init-v7-0-631baf679fe7@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
 James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, 
 Quentin Monnet <qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 William Breathitt Gray <wbg@kernel.org>, Barry Song <baohua@kernel.org>, 
 Qinxin Xia <xiaqinxin@huawei.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Kent Gibson <warthog618@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Robert Moore <robert.moore@intel.com>, 
 Len Brown <lenb@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411244; l=2967;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=RJCrBBCoyZk9ItWKXFzBfBNj6qLZCgM5gXRLbvh4BLQ=;
 b=ZBsHnWtddM9EPK4vOZCFQnT2BRRbzqV/l20fZeNv0SKuhTgIRrjaYsk3WPUneNKIEsPClA2aE
 15d0fESm4uqAHtOd1IzTrYVI4Ump+K+IIyR9y+jji9gi0a1p8YBIIMb
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

selftests/lib.mk has its own compiler setup instead of using the common
tools build helpers. This duplicates part of the LLVM handling prepared
by tools/scripts/Makefile.include.

Include tools/scripts/Makefile.include from selftests/lib.mk so
selftests reuse the LLVM prefix/suffix validation and the provided
CLANG_CROSS_FLAGS. This improves Clang cross builds, especially when
CROSS_COMPILE is set it can derive --prefix, --sysroot and
--gcc-toolchain flags from the GCC cross toolchain.

Keep the $(CLANG_TARGET_FLAGS_$(ARCH)) target flag as a fallback when
CLANG_CROSS_FLAGS is empty, and append EXTRA_CFLAGS to the selftest.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/testing/selftests/lib.mk | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index f02cc8a2e4ae322d65a031178013270922611c42..e2e2d8aa57280ffd37bced18ecd43e7a5566abae 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -1,11 +1,17 @@
 # This mimics the top-level Makefile. We do it explicitly here so that this
 # Makefile can operate with or without the kbuild infrastructure.
-ifneq ($(LLVM),)
-ifneq ($(filter %/,$(LLVM)),)
-LLVM_PREFIX := $(LLVM)
-else ifneq ($(filter -%,$(LLVM)),)
-LLVM_SUFFIX := $(LLVM)
+ifeq (0,$(MAKELEVEL))
+    ifeq ($(OUTPUT),)
+	OUTPUT := $(shell pwd)
+	DEFAULT_INSTALL_HDR_PATH := 1
+    endif
 endif
+selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
+top_srcdir = $(selfdir)/../../..
+
+include $(top_srcdir)/tools/scripts/Makefile.include
+
+ifneq ($(LLVM),)
 
 CLANG := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
 
@@ -35,7 +41,8 @@ else
 CLANG_FLAGS     += --target=$(CLANG_TARGET_FLAGS)
 endif # CLANG_TARGET_FLAGS
 else
-CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
+# CLANG_CROSS_FLAGS comes from Makefile.include
+CLANG_FLAGS     += $(CLANG_CROSS_FLAGS)
 endif # CROSS_COMPILE
 
 # gcc defaults to silence (off) for the following warnings, but clang defaults
@@ -51,15 +58,6 @@ else
 CC := $(CROSS_COMPILE)gcc
 endif # LLVM
 
-ifeq (0,$(MAKELEVEL))
-    ifeq ($(OUTPUT),)
-	OUTPUT := $(shell pwd)
-	DEFAULT_INSTALL_HDR_PATH := 1
-    endif
-endif
-selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
-top_srcdir = $(selfdir)/../../..
-
 # msg: emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
 # $2 - optional "flavor" specifier; if provided, will be emitted as [flavor];
@@ -202,6 +200,8 @@ CFLAGS += -D_GNU_SOURCE=
 # Additional include paths needed by kselftest.h and local headers
 CFLAGS += -I${top_srcdir}/tools/testing/selftests
 
+CFLAGS += $(EXTRA_CFLAGS)
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)

-- 
2.34.1

