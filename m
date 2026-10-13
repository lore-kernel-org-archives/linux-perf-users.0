Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89892563FAF
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933284; cv=none; b=JMcW5F+EvxGLXp93ML10kb6kCx0bACyFkV3Fxc09b3JabMt4aqRWxZtE0xX3SnYSTQYyYqFlEv1Sg4mdzAYOvqZa0WZt9Hwz0o/E4tsYR7r6zMwFp3AU3b3jv/R5NlcaT7MnqaD/0I0MvKzc4Rktm/FLKNTM1EdLAejlyHSsAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933284; c=relaxed/simple;
	bh=blhkNd7YPOHByM6jhZraZMpx6Hjvkwqjwud40X2q32M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bZKtykI/GtojH5EJmGXRhG+z2aPscNbmrQMaoz7Dk6Lar2gTTaQACbqGN7FVbPmfrWEsZZFQf26qTD1dpis2C6jXLPcN64HYhq+nBU9cwGiK6foUzY3VnYQLEg5fAhJH7UgQy+fx0rWkaFOOzIEkkunQr6CVlijlfPE7WeSIzds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TrdzdBIm; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrdzdBIm"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35c3c370b17so2487572eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 16:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791933281; x=1792538081; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYhrg7g0yJ8cu7vKkFE0QJOFgou8b+/PjQRDx5Q9dOk=;
        b=TrdzdBImLWxvuoJqlWZSFjhpuMu0XJlaGKTpVFT6k2B/dAjWbh/+WeJW+mhQ4EFbUV
         A/nFv4SryXT8OxfSe1KBLtx26uJFtVC54N1J2txY3O3JducxJhDKexz348ObfgJPQ8nP
         bOhyIjEZSHbqW/q/OITDzXvmHd3CaDu0GUfTdPT4UUKCjHSHttpDYm5AVI2kdNaqPB6O
         oSBPj9LdyG451Ueb6FWILNDo4dKQeFy49mwpJz2z2lOzoKNjuKtk0h8Hsad1eDXm+QQv
         uyghvYjm/iXMYvkeWCQsS5tytMlYecEj6MlF7ykAbUF9PXr+2MXPyDHMJ4whWabE1VNp
         UV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791933281; x=1792538081;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qYhrg7g0yJ8cu7vKkFE0QJOFgou8b+/PjQRDx5Q9dOk=;
        b=TgBZLDwjZtQAxjskfk8OfE/DcoXQqRQX2OGCUahTVUwkZBCyFCe/aB9G0YWM+L6GGE
         ySbm7XzPAGHjdrJsYQtOpMrDqFxvgYedkHd2ErE09LhRsRwwP5va7+uKBKfb7mH06WGk
         V8WRnalsYQl5ODEW7Tl5on9vpMIc4zd4wnmaHmGh0/vZU4sPFNbkVpLXgzIqljDtTkFN
         RZ5zPWbaNkwswKs/l5xhBGQ7X5crrS4uYGWt/2BfKgH7ghxr3EFnUhtC7AZnXp2rwXb9
         CqZJRHuqoAMJiFP8+E0AxovmndtyiWntNrORTq5cvct/1YhkZY6/F1vim7zMJO79KPMx
         jJuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvRSkQYpxFT+SOwnxr6WRZRlI0u7DthKN78iv54PJhlHBq4B7XHTDRRjmsTSD6hxm1XF0DG/P/ZShRPbotO50f@vger.kernel.org
X-Gm-Message-State: AFq9FYKFNLs5dXpLUmPqbL3zvGXJ/T1/gf9jKhSmqvI6jotuzEWWrI8Z
	9sqLLU8vi2+Vm8b4h3zpSZ156S4ODUyG4E+9p1qXXGXbMBts+3FYMvXVhC6sNDrY45osMTnhrXu
	8pCkCNt4cWw==
X-Received: from dyx5.prod.google.com ([2002:a05:693c:8205:b0:35c:bd2a:aeb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8103:b0:34a:fc46:35ba
 with SMTP id 5a478bee46e88-3537dfc6e87mr22274259eec.8.1791933280166; Tue, 13
 Oct 2026 16:14:40 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:14:29 -0700
In-Reply-To: <20261013231430.2163505-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013221643.1815686-1-irogers@google.com> <20261013231430.2163505-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013231430.2163505-2-irogers@google.com>
Subject: [PATCH v2 1/2] perf build: Support building BPF skeletons with bpf-gcc
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, cupertino.miranda@oracle.com, 
	jose.marchesi@oracle.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, andrii@kernel.org, eddyz87@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Support building perf BPF skeletons with bpf-gcc (>= 14.0.0) in addition
to clang (>= 12.0.1), similar to tools/testing/selftests/bpf/Makefile.

When building perf with GCC (CC_NO_CLANG=1), prefer bpf-gcc and fall
back to clang if bpf-gcc is unavailable or too old. When building with
Clang/LLVM (CC_NO_CLANG=0), prefer clang and fall back to bpf-gcc.
Explicit command-line overrides via BPF_GCC=... or CLANG=... are
respected, and setting BPF_GCC= or CLANG= to empty disables that
compiler.

In bpf_skel.mak, pass the bpf-gcc flags (-mcpu=v3, -fno-ident,
-DBPF_NO_PRESERVE_ACCESS_INDEX, -Wno-attributes,
-D__TARGET_ARCH_$(SRCARCH), and target endianness) and query system
include paths from $(CC).

Also update version-ge3 and version-lt3 in tools/scripts/utilities.mak
to split the two version arguments separately in awk so empty or
fewer-than-3-component version strings do not shift fields across
arguments.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config     | 83 +++++++++++++++++++++++++++-------
 tools/perf/Makefile.perf       |  8 +++-
 tools/perf/bpf_skel.mak        | 36 ++++++++++-----
 tools/scripts/Makefile.include |  1 +
 tools/scripts/utilities.mak    |  4 +-
 5 files changed, 101 insertions(+), 31 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index cafc7be79643..235872e65d8f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -662,27 +662,78 @@ ifeq ($(BUILD_BPF_SKEL),1)
   else ifeq ($(filter -DHAVE_LIBOPENSSL_SUPPORT, $(CFLAGS)),)
     $(warning Warning: Disabled BPF skeletons as libopenssl is required)
     BUILD_BPF_SKEL := 0
-  else ifeq ($(call get-executable,$(CLANG)),)
-    $(warning Warning: Disabled BPF skeletons as clang ($(CLANG)) is missing)
-    BUILD_BPF_SKEL := 0
-  else
-    CLANG_VERSION := $(shell $(CLANG) --version | head -1 | sed 's/.*clang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
-    ifeq ($(call version-lt3,$(CLANG_VERSION),12.0.1),1)
-      $(warning Warning: Disabled BPF skeletons as reliable BTF generation needs at least $(CLANG) version 12.0.1)
-      BUILD_BPF_SKEL := 0
-    endif
   endif
   ifeq ($(BUILD_BPF_SKEL),1)
-    $(call feature_check,clang-bpf-co-re)
-    ifeq ($(feature-clang-bpf-co-re), 0)
-      $(warning Warning: Disabled BPF skeletons as clang is too old)
+    # Prefer bpf-gcc when building with gcc (CC_NO_CLANG=1) and clang when
+    # building with clang, unless CLANG or BPF_GCC was explicitly specified on
+    # the command line. Fall back to whichever compiler is available.
+    prefer_bpf_gcc := $(CC_NO_CLANG)
+    ifeq ($(origin BPF_GCC),command line)
+      ifneq ($(BPF_GCC),)
+        prefer_bpf_gcc := 1
+      endif
+    else ifeq ($(origin CLANG),command line)
+      ifneq ($(CLANG),)
+        prefer_bpf_gcc := 0
+      endif
+    endif
+
+    have_bpf_gcc := 0
+    have_clang_bpf := 0
+
+    define check_bpf_gcc
+      ifneq ($$(call get-executable,$$(BPF_GCC)),)
+        BPF_GCC_VERSION := $$(shell $$(BPF_GCC) -dumpfullversion 2>/dev/null)
+        ifneq ($$(BPF_GCC_VERSION),)
+          ifneq ($$(call version-lt3,$$(BPF_GCC_VERSION),14.0.0),1)
+            have_bpf_gcc := 1
+          endif
+        endif
+      endif
+    endef
+
+    ifeq ($(prefer_bpf_gcc),1)
+      $(eval $(check_bpf_gcc))
+    endif
+
+    ifeq ($(have_bpf_gcc),0)
+      ifneq ($(call get-executable,$(CLANG)),)
+        CLANG_VERSION := $(shell $(CLANG) --version | head -1 | sed 's/.*clang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
+        ifneq ($(call version-lt3,$(CLANG_VERSION),12.0.1),1)
+          $(call feature_check,clang-bpf-co-re)
+          ifeq ($(feature-clang-bpf-co-re), 1)
+            have_clang_bpf := 1
+          endif
+        endif
+      endif
+    endif
+
+    ifeq ($(prefer_bpf_gcc)$(have_clang_bpf),00)
+      $(eval $(check_bpf_gcc))
+    endif
+
+    ifeq ($(have_bpf_gcc),1)
+      $(call detected,CONFIG_PERF_BPF_SKEL_BPF_GCC)
+      $(call detected,CONFIG_PERF_BPF_SKEL)
+      CFLAGS += -DHAVE_BPF_SKEL
+    else ifeq ($(have_clang_bpf),1)
+      $(call detected,CONFIG_PERF_BPF_SKEL)
+      CFLAGS += -DHAVE_BPF_SKEL
+    else
+      ifeq ($(call get-executable,$(CLANG))$(call get-executable,$(BPF_GCC)),)
+        $(warning Warning: Disabled BPF skeletons as clang ($(CLANG)) and bpf-gcc ($(BPF_GCC)) are missing)
+      else ifneq ($(call get-executable,$(CLANG)),)
+        ifeq ($(call version-lt3,$(CLANG_VERSION),12.0.1),1)
+          $(warning Warning: Disabled BPF skeletons as reliable BTF generation needs at least $(CLANG) version 12.0.1)
+        else
+          $(warning Warning: Disabled BPF skeletons as clang is too old)
+        endif
+      else
+        $(warning Warning: Disabled BPF skeletons as bpf-gcc ($(BPF_GCC)) needs at least version 14.0.0)
+      endif
       BUILD_BPF_SKEL := 0
     endif
   endif
-  ifeq ($(BUILD_BPF_SKEL),1)
-    $(call detected,CONFIG_PERF_BPF_SKEL)
-    CFLAGS += -DHAVE_BPF_SKEL
-  endif
 endif
 
 ifndef GEN_VMLINUX_H
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2d9379fea267..4061a79cae54 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -37,6 +37,9 @@ include ../scripts/utilities.mak
 # Define EXTRA_BPF_FLAGS="--sysroot=<path>" or other custom include paths for
 # cross-compiling BPF skeletons
 #
+# Define BPF_GCC to point to the bpf-gcc binary if the default `bpf-gcc' is not
+# correct, or set BPF_GCC= to disable using bpf-gcc for BPF skeletons.
+#
 # Define EXCLUDE_EXTLIBS=-lmylib to exclude libmylib from the auto-generated
 # EXTLIBS.
 #
@@ -208,6 +211,7 @@ FIND    = find
 INSTALL = install
 FLEX    ?= flex
 BISON   ?= bison
+BPF_GCC ?= bpf-gcc
 AWK     = awk
 
 # include Makefile.config by default and rule out
@@ -321,8 +325,8 @@ ifneq ($(force_fixdep),1)
   endif
 endif
 
-export srctree OUTPUT RM CC CXX RUSTC CLANG LD AR CFLAGS CXXFLAGS RUST_FLAGS V BISON FLEX AWK LIBBPF READELF
-export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT CONFIG_PERF_BPF_SKEL
+export srctree OUTPUT RM CC CXX RUSTC CLANG BPF_GCC LD AR CFLAGS CXXFLAGS RUST_FLAGS V BISON FLEX AWK LIBBPF READELF
+export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT CONFIG_PERF_BPF_SKEL CONFIG_PERF_BPF_SKEL_BPF_GCC
 
 include $(srctree)/tools/build/Makefile.include
 
diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
index f2559de39f96..7b7edf506509 100644
--- a/tools/perf/bpf_skel.mak
+++ b/tools/perf/bpf_skel.mak
@@ -22,21 +22,35 @@ bpf-skel-prepare: $(BPFTOOL) $(VMLINUX_H)
 define get_sys_includes
 $(shell $(1) $(2) -v -E - </dev/null 2>&1 \
        | sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
-$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
+$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}') \
+$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | awk '{printf("-D__BITS_PER_LONG=%d", $$3)}') \
+$(shell $(1) $(2) -dM -E - </dev/null | grep -E 'MIPS(EL|EB)|_MIPS_SZ(PTR|LONG) |_MIPS_SIM |_ABI(O32|N32|64) ' | awk '{printf("-D%s=%s ", $$2, $$3)}')
 endef
 
-ifneq ($(CROSS_COMPILE),)
-CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
+ifeq ($(CONFIG_PERF_BPF_SKEL_BPF_GCC),y)
+  BPF_CC := $(BPF_GCC)
+  QUIET_BPF_CC = $(QUIET_BPF_GCC)
+  IS_LITTLE_ENDIAN := $(shell $(CC) -dM -E - </dev/null | \
+			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
+  BPF_OPTIONS = -Wall -mcpu=v3 -fno-ident -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes \
+		-D__TARGET_ARCH_$(SRCARCH) $(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
+  BPF_SYS_INCLUDES = $(call get_sys_includes,$(CC),)
+else
+  BPF_CC := $(CLANG)
+  QUIET_BPF_CC = $(QUIET_CLANG)
+  ifneq ($(CROSS_COMPILE),)
+    CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
+  endif
+  BPF_OPTIONS = -Wall -mcpu=v3 -fno-stack-protector --target=bpf -Wno-microsoft-anon-tag
+  BPF_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 endif
 
-CLANG_OPTIONS = -Wall -mcpu=v3
-CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 LIBBPF_INCLUDE := $(abspath $(or $(OUTPUT),.))/libbpf/include
-BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(SKEL_TOOL_OUT) -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
+BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(SKEL_TOOL_OUT) -I$(LIBBPF_INCLUDE) $(BPF_SYS_INCLUDES)
 TOOLS_UAPI_INCLUDE := -I$(srctree)/tools/include/uapi
 
 ifneq ($(WERROR),0)
-  CLANG_OPTIONS += -Werror
+  BPF_OPTIONS += -Werror
 endif
 
 $(BPFTOOL):
@@ -83,11 +97,11 @@ endif
 # Consolidated Pattern rule for $(dir)/bpf_skel/
 $(SKEL_TMP_OUT)/%.bpf.o: $(srctree)/tools/perf/$(dir)/bpf_skel/%.bpf.c $(LIBBPF) $(VMLINUX_H) $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h
 	$(call rule_mkdir)
-	$(QUIET_CLANG)
-	$(Q)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
-	  $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
+	$(QUIET_BPF_CC)
+	$(Q)$(BPF_CC) -g -O2 \
+	  $(BPF_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
 	  -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h \
-	  -fms-extensions -Wno-microsoft-anon-tag \
+	  -fms-extensions \
 	  -c $< -o $@
 
 $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o $(BPFTOOL)
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 378387f62960..9967210b2928 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -217,6 +217,7 @@ ifneq ($(silent),1)
 	QUIET_CC       = @echo '  CC      '$@;
 	QUIET_CC_FPIC  = @echo '  CC FPIC '$@;
 	QUIET_CLANG    = @echo '  CLANG   '$@;
+	QUIET_BPF_GCC  = @echo '  BPF_GCC '$@;
 	QUIET_AR       = @echo '  AR      '$@;
 	QUIET_LINK     = @echo '  LINK    '$@;
 	QUIET_MKDIR    = @echo '  MKDIR   '$@;
diff --git a/tools/scripts/utilities.mak b/tools/scripts/utilities.mak
index d69d0345cc23..746aaf6e5145 100644
--- a/tools/scripts/utilities.mak
+++ b/tools/scripts/utilities.mak
@@ -186,7 +186,7 @@ _gea_err  = $(if $(1),$(error Please set '$(1)' appropriately))
 # was to check the flex version to see if we can use compiler warnings as
 # errors for one of the cases flex generates code C compilers complains about.
 
-version-ge3 = $(shell echo "$(1).$(2)" | awk -F'.' '{ printf("%d\n", (10000000 * $$1 + 10000 * $$2 + $$3) >= (10000000 * $$4 + 10000 * $$5 + $$6)) }')
+version-ge3 = $(shell awk -v v1="$(1)" -v v2="$(2)" 'BEGIN { split(v1, a, "."); split(v2, b, "."); printf("%d\n", (10000000 * a[1] + 10000 * a[2] + a[3]) >= (10000000 * b[1] + 10000 * b[2] + b[3])) }')
 
 # version-lt3
 #
@@ -196,4 +196,4 @@ version-ge3 = $(shell echo "$(1).$(2)" | awk -F'.' '{ printf("%d\n", (10000000 *
 # check the flex version to see if we can use compiler warnings as errors for
 # one of the cases flex generates code C compilers complains about.
 
-version-lt3 = $(shell echo "$(1).$(2)" | awk -F'.' '{ printf("%d\n", (10000000 * $$1 + 10000 * $$2 + $$3) < (10000000 * $$4 + 10000 * $$5 + $$6)) }')
+version-lt3 = $(shell awk -v v1="$(1)" -v v2="$(2)" 'BEGIN { split(v1, a, "."); split(v2, b, "."); printf("%d\n", (10000000 * a[1] + 10000 * a[2] + a[3]) < (10000000 * b[1] + 10000 * b[2] + b[3])) }')
-- 
2.56.0.385.gd3acb90ef8-goog

