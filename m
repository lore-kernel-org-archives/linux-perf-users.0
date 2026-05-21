Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5E399017
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348286; cv=none; b=R8JDcH1dJ80C3vOdw9SfmvIRAJbRDgebHMPGQGG1DDOGiIwS8cwa4Axzjl86dRCKSmdhE6ybtAjOeiHx94LCedPf0WtVbEdH1nvqpcMFN8rmfG/CNkmuxZF86dgwkn1DoRojLxaJZvZnyWiVfMDRqXYX0YvhXlhS127GPcpGqBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348286; c=relaxed/simple;
	bh=2tq54+G1DHd3j5mugKeaTTS/fpsXiXue33lWment8Pw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=o6xQAngu8hNEbFSFNELbhTtu7TO7yRyVxTk/PVzy2nEHjwIqhVkhDOEf5qHVJvfqrQb5Zqd7tdlKyfQQWXfdCYsiYdLbAfcvyvsw6xMLk5LoQMKM2VdzP8kKuvmeT6UGhg29oh2azqAeN7Wp3oYVfJx86tIuclNRCg+arnzWp/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukahJsZa; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukahJsZa"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-134cf343c58so10625623c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 00:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779348282; x=1779953082; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7gtESKLXiPD0tkvR99qaYWajcafSY5Lz8pSfIu9ikg=;
        b=ukahJsZaPp8zVXWoAcnxx/H/lLm5IERNFsZfV5qOC6CGAaEepUduwxHvH+w3r0/8c/
         Bop/DFRfZJHUE5mlRLokMST2KXwoV+Oj9NpOUyXNEg+GqgV/UEQecPtyKiLrkPord1Ma
         BuyGkxs/jBIFaVkj8bEAVMBzudpSNpi9MorMTeW1LLK8DEyqRVclCaZP7kABLnoiUXMA
         re2TMKmGvBBrJHuYvUto6FmcRULnW5ik1FfZ+icNq1a38ABTuGE68rhSwQUMDqTv6lm/
         tWVPJzdj3+KYM8gkLA021dgX2wU3BrpQietImwWpkN6Jao3wgLIymVEK/IfyRz/D+ysR
         afZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779348282; x=1779953082;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7gtESKLXiPD0tkvR99qaYWajcafSY5Lz8pSfIu9ikg=;
        b=AlAvEQNOWDkuXKPTtvfPRZnCpWm69599x1P3sm1VRscUepVqXComwcD5/B3BwmuY9Y
         m0A8MS+S2WM+XFnzmAp9x3FhLoHYuG5V4OOjeECDiD3LzKes1JNZNKBg7zxBlNiG7mt2
         0B8pdMUOqqt9N9ZwByxXYLhfgIRmxBIVN9Uq+BWtLLjHu8K7jcNnoW+nezaiur+w9mkr
         pGXe28WDgFoEhfPXg9wK90A5wMneq9eUwDyLkt0kDcPShTEslqNa5AoSTDUHkRkmcKWv
         rG5Noc/z7VgO72WH2M1psfqGjm4X4nMf2sQ2kNI6zaOjh/1RKKVARIiVC6m5vF2VcZFl
         rhyw==
X-Forwarded-Encrypted: i=1; AFNElJ88t3sTWDhQviV6UmhsOmgWfPJFpngtgN9kgOnHpBKTnDw3/iG1h3vP12BEO0OL+B+wydkh1J9iD0AF9Pco8l0K@vger.kernel.org
X-Gm-Message-State: AOJu0YxgxjGF1qjA4Nt3w6h7jQgdpcruiMqK8t4jww30VJ04x3Jh6vCC
	0bs9zxwmSY3OKjpcErCuCzP8PXpUsUyNngSwjk/Q5bUbG8H7cccezrUdm7pHsyZrHKxPakZg6Hq
	jmwroea9OyA==
X-Received: from dlbrh26.prod.google.com ([2002:a05:7022:f31a:b0:135:ebea:dc20])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4b:b0:130:ab68:2b5e
 with SMTP id a92af1059eb24-136326e9d5amr855125c88.4.1779348281773; Thu, 21
 May 2026 00:24:41 -0700 (PDT)
Date: Thu, 21 May 2026 00:24:27 -0700
In-Reply-To: <20260521072429.1283423-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521072429.1283423-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521072429.1283423-2-irogers@google.com>
Subject: [PATCH v1 1/3] perf build: Unconditionally set up libunwind feature
 build flags
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A "make feature-dump" build does not specify LIBUNWIND=1 because it is
run with the default configuration to detect system-wide capabilities.
This sets NO_LIBUNWIND := 1, causing Makefile.config to skip setting
LIBUNWIND_LIBS and FEATURE_CHECK_LDFLAGS-libunwind.

Consequently, when Makefile.feature is included and attempts to run
all feature checks (via FEATURE_TESTS := all), the local feature test
test-libunwind.bin compiles without the required architecture-specific
library flags (-lunwind-x86_64) and fails to link on x86_64. This
results in a corrupted cached BUILD_TEST_FEATURE_DUMP showing
feature-libunwind=0 even when the host supports it.

Subsequent test builds (like make_libunwind_O in the build-test suite)
which reuse the feature dump and specify LIBUNWIND=1 will fail to
compile due to a mismatch where CONFIG_LIBUNWIND is set (via remote
architecture checks which are self-contained) but HAVE_LIBUNWIND_SUPPORT
is disabled, causing compiler errors due to missing maps__e_machine
definitions in maps.h.

Fix this by unconditionally setting up the libunwind library lists
and feature check LDFLAGS in Makefile.config so they are always
populated and available to the feature detection engine regardless
of whether LIBUNWIND=1 is opted-in for the current run.

Fixes: 444508cd7c7b ("perf build: Be more programmatic when setting up libunwind variables")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 103 +++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 51 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b56fa8419f7d..c531b9315609 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -79,42 +79,43 @@ ifeq ($(ARCH),s390)
   CFLAGS += -fPIC
 endif
 
+# Unconditionally set up the libunwind feature build flags as a
+# feature-dump build doesn't specify LIBUNWIND=1. This means that
+# dumping the libunwind features will be broken that can impact later
+# builds that use the feature dump.
+ifeq ($(SRCARCH),arm)
+  LIBUNWIND_LIBS = -lunwind -lunwind-arm
+endif
+ifeq ($(SRCARCH),arm64)
+  LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
+endif
+ifeq ($(SRCARCH),loongarch)
+  LIBUNWIND_LIBS = -lunwind -lunwind-loongarch64
+endif
+ifeq ($(ARCH),mips)
+  LIBUNWIND_LIBS = -lunwind -lunwind-mips
+endif
+ifeq ($(SRCARCH),powerpc)
+  LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
+endif
+ifeq ($(SRCARCH),riscv)
+  LIBUNWIND_LIBS := -lunwind -lunwind-riscv
+endif
+ifeq ($(SRCARCH),s390)
+  LIBUNWIND_LIBS := -lunwind -lunwind-s390x
+endif
+ifeq ($(SRCARCH),x86)
+  ifeq (${IS_64_BIT}, 1)
+    LIBUNWIND_LIBS = -lunwind-x86_64 -lunwind -llzma
+  else
+    LIBUNWIND_LIBS = -lunwind-x86 -lunwind -llzma
+  endif
+endif
 ifneq ($(LIBUNWIND),1)
   NO_LIBUNWIND := 1
 endif
-
-ifndef NO_LIBUNWIND
-  ifeq ($(SRCARCH),arm)
-    LIBUNWIND_LIBS = -lunwind -lunwind-arm
-  endif
-  ifeq ($(SRCARCH),arm64)
-    LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
-  endif
-  ifeq ($(SRCARCH),loongarch)
-    LIBUNWIND_LIBS = -lunwind -lunwind-loongarch64
-  endif
-  ifeq ($(ARCH),mips)
-    LIBUNWIND_LIBS = -lunwind -lunwind-mips
-  endif
-  ifeq ($(SRCARCH),powerpc)
-    LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
-  endif
-  ifeq ($(SRCARCH),riscv)
-    LIBUNWIND_LIBS := -lunwind -lunwind-riscv
-  endif
-  ifeq ($(SRCARCH),s390)
-    LIBUNWIND_LIBS := -lunwind -lunwind-s390x
-  endif
-  ifeq ($(SRCARCH),x86)
-    ifeq (${IS_64_BIT}, 1)
-      LIBUNWIND_LIBS = -lunwind-x86_64 -lunwind -llzma
-    else
-      LIBUNWIND_LIBS = -lunwind-x86 -lunwind -llzma
-    endif
-  endif
-  ifeq ($(LIBUNWIND_LIBS),)
-    NO_LIBUNWIND := 1
-  endif
+ifeq ($(LIBUNWIND_LIBS),)
+  NO_LIBUNWIND := 1
 endif
 
 #
@@ -124,24 +125,24 @@ endif
 #
 LIBUNWIND_ARCHS:=aarch64 arm loongarch64 mips ppc32 ppc64 riscv s390x x86 x86_64
 
-ifndef NO_LIBUNWIND
-  FEATURE_CHECK_CFLAGS-libunwind = $(LIBUNWIND_CFLAGS)
-  FEATURE_CHECK_LDFLAGS-libunwind = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
-  FEATURE_CHECK_CFLAGS-libunwind-debug-frame = $(LIBUNWIND_CFLAGS)
-  FEATURE_CHECK_LDFLAGS-libunwind-debug-frame = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
-
-  ifdef LIBUNWIND_DIR
-    LIBUNWIND_CFLAGS  = -I$(LIBUNWIND_DIR)/include
-    LIBUNWIND_LDFLAGS = -L$(LIBUNWIND_DIR)/lib
-
-    define libunwind_arch_set_flags
-      FEATURE_CHECK_CFLAGS-libunwind-$(1)  = -I$(LIBUNWIND_DIR)/include
-      FEATURE_CHECK_LDFLAGS-libunwind-$(1) = -L$(LIBUNWIND_DIR)/lib -lunwind -lunwind-$(1)
-    endef
-    $(foreach arch,$(LIBUNWIND_ARCHS), \
-      $(eval $(call libunwind_arch_set_flags,$(arch))) \
-    )
-  endif
+# "Local" (no arch specified) feature test flags.
+FEATURE_CHECK_CFLAGS-libunwind = $(LIBUNWIND_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libunwind = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
+FEATURE_CHECK_CFLAGS-libunwind-debug-frame = $(LIBUNWIND_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libunwind-debug-frame = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
+
+# Add directory into the "remote" (build for a a specific arch) feature tests.
+ifdef LIBUNWIND_DIR
+  LIBUNWIND_CFLAGS  = -I$(LIBUNWIND_DIR)/include
+  LIBUNWIND_LDFLAGS = -L$(LIBUNWIND_DIR)/lib
+
+  define libunwind_arch_set_flags
+    FEATURE_CHECK_CFLAGS-libunwind-$(1)  = -I$(LIBUNWIND_DIR)/include
+    FEATURE_CHECK_LDFLAGS-libunwind-$(1) = -L$(LIBUNWIND_DIR)/lib -lunwind -lunwind-$(1)
+  endef
+  $(foreach arch,$(LIBUNWIND_ARCHS), \
+    $(eval $(call libunwind_arch_set_flags,$(arch))) \
+  )
 endif
 
 ifdef CSINCLUDES
-- 
2.54.0.746.g67dd491aae-goog

