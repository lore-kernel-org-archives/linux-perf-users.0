Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446129;
	b=gdX0lsmciXvDTjcIlarOvTzOIZVEcnAOwqWo6vrizrqEa6t/AmBB5qMK3U8XH1QkmIIL
	 UOLPpWBF0KQ4Le8eoNnfHoEi/Tq01SrwJN5qUBM3/kyT/VbG581kHLxVik+Nd9+4wpPe3
	 tJ5iIVGuSaNSWcEcf6YhAqOZgl5xsHQP9VU0j6wFQL5MyzzR2XX3ziDhWHhA2h1t+4w+w
	 rxGfHhC3+SawkqSk5PVJwvspNhi49ZyaTCH2xuDRuUW545wRla61xfDqLqXNxpcYEg2r6
	 FBXmvxHKZ8r4jg/aa36qxWOjPFOvz4cKQ5fQG/d1YYfctNdiObRETgkhKnMP5KBB5dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7PhFcaDeAtGCbRdibMYuOaU5CfzISCNubzN8pUXfkYA=;
	b=A7WicLkcZi/l4PrRRIEN5Dxu8/o1rLKCqCcZsYyIpmHF7QheSqKF0fAYbLYqzXBPjAKR
	 zWYOAunBAk+MQcpa/XyFFGGS7zifOEfYV//Mgf021mU69TZx6F431QOa/VYN5C1NOR0ZI
	 rO1siKbkWVa6dHf8NKTejujYjCyues3RD080qunw0FprPUK13zF1+7ipNVZfZBWkiUx4P
	 p6lvDmTLPT9H3B9R+RwUpBYx3aZBFvjErj43XxH7DITBCrPqugNZmzMnAur7wrW0fAwdP
	 47omcWhl39BDwFl2FqVnhV6c1uakWWeCK3+3Ma2uInaR1P5kA3eDS3lRoj+qTU9nJTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lDnhZn9V;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D1606A339
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 01:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 687D1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lDnhZn9V
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-37628596fc9so1275833eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794446129; x=1795050929; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PhFcaDeAtGCbRdibMYuOaU5CfzISCNubzN8pUXfkYA=;
        b=lDnhZn9VCPL3MTcTxK5EUY775VQnM9P0MUl+aPMOesR2pW9TzmSaCyEdlsmi3PdkX4
         6Vbi8c+pxon+cld7NShaINqVRCgvfzWBxKYyftHdxfjmqlkltI2yD/QIlcGp1Od+fhWi
         ibJWua0Ce1YiBEBX3LlkwSNw34Jl0E7MU4HfRuLHV4NOnbksa3SO1HQKp2667jvcBV2w
         qrWm4/9tISdJ3nI0p/f5oKEdmDu6fVOfpiXKp2l8gLRQPz274UL9ewRT0T/z9W5vKJwV
         Y75Jf75ORqxSQ8L/i9/s01p2SW8Qku/FfNwOrvLHPLa8wkffPaEOHPxzNSxLnq7IXVqg
         Pp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794446129; x=1795050929;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7PhFcaDeAtGCbRdibMYuOaU5CfzISCNubzN8pUXfkYA=;
        b=2HXs1l6BWmY7I1NeevMlXSGkZo3z/VxjU5C2/M175nL98zXwZEVZ8QsMq9X9F02n+j
         oLlrZobmx80hGYkH5X75eRnKeaZUy3GUXY83Jq51myMCVRsPXNgJzcxaOICy+EHaUB4x
         xfVf4GWqaY0LRchYNNOYXq8GLJPswk/cW7D5Wjr4c9SwZ4nLA6ZecvbnuSjszC31kPhv
         L4hH4dIcBaMqxi2eV0pMF4RXaCTtt48g3zg2wacMQQv4HzEy0hcjlp/SltxwW4Zfrq9d
         AsPIq71AMpfrS/ryEoPcj9V3BMbw7hJQQd6O7YwszUx2pm5UFY52XGZ1fUmTvuODNBeW
         tZ5g==
X-Forwarded-Encrypted: i=1; AL+hErFm3wt9hxEh0yPm5qKqT4eEsK4xK2ZH/9ycgUClN27lw+6CHXir0Fi450VvEFDglRTedZIGQ/F2P+TlO3zdkc98@vger.kernel.org
X-Gm-Message-State: APuU4Z8QOEp/OmIWb1/vZmxlJ7vgwgzp1gtCuovlLgqCHh/WEhWMFflw
	FgAPTALyufXnxKtWJlTgM2aP6FGniOdvyne3xjERvQlilW0bTSV0pOBNRgQ/V3NzKCXpVa/0ICN
	W+c+sAEEKmA==
X-Received: from dyboe15.prod.google.com ([2002:a05:7301:3d0f:b0:36a:184b:374c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:41da:20b0:36a:79e7:2fd
 with SMTP id 5a478bee46e88-3768721410bmr4610659eec.40.1794446128092; Wed, 11
 Nov 2026 17:15:28 -0800 (PST)
Date: Wed, 11 Nov 2026 17:15:12 -0800
In-Reply-To: <20261112011514.4032822-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022204627.1813821-1-irogers@google.com> <20261112011514.4032822-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112011514.4032822-4-irogers@google.com>
Subject: [PATCH v4 3/5] perf build: Support building BPF skeletons with bpf-gcc
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, andrii@kernel.org, cupertino.miranda@oracle.com, 
	eddyz87@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	jose.marchesi@oracle.com, linux-kernel@vger.kernel.org, 
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config     | 83 +++++++++++++++++++++++++++-------
 tools/perf/Makefile.perf       |  8 +++-
 tools/perf/bpf_skel.mak        | 32 +++++++++----
 tools/scripts/Makefile.include |  1 +
 4 files changed, 96 insertions(+), 28 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b4764f69f47f..456b6a06080c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -666,27 +666,78 @@ ifeq ($(BUILD_BPF_SKEL),1)
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
+          ifneq ($(feature-clang-bpf-co-re), 0)
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
index b74b534e1153..bb80ff8f8a61 100644
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
index 60d104ec573d..7b7edf506509 100644
--- a/tools/perf/bpf_skel.mak
+++ b/tools/perf/bpf_skel.mak
@@ -27,18 +27,30 @@ $(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | awk '{printf
 $(shell $(1) $(2) -dM -E - </dev/null | grep -E 'MIPS(EL|EB)|_MIPS_SZ(PTR|LONG) |_MIPS_SIM |_ABI(O32|N32|64) ' | awk '{printf("-D%s=%s ", $$2, $$3)}')
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
@@ -85,11 +97,11 @@ endif
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
-- 
2.56.0.567.gdb80ae8cd5-goog

