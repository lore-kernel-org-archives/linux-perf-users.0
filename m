Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902181;
	b=4bZPsQrSr3eSt99sLSPtInRQD0RkuCfXKgJdUJql4KwhnFdxwP7OruomzqIq31jhGgsl
	 HeC+PZfs8dkuHAWdsb2YELSWAACggrylCrzZui9O4/KN4co/4rGG727KiFLBPbpTj5l2d
	 bSFxfsRBd/9NOv1h31LsNQCHb8TAoS518l6hC3VYEesImk+6Lm+hKkPSdlvPGKwDhfSlC
	 xYyzhhOg9kziwtmTOqooTdoW7V2Wu1YPf4RdlrT0kwfnM4XG9xOI377eQwVLpLn9I3yXp
	 LQySLbixOqgL8VjSkDfmQlwGQTNXHO83rsGHxPTmnJDGSP3gS+KROZGZlr3BUV97VpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kF8SevhVCQWHNZC9drCBA7xTfiDAAX0qaL0O6Q4z388=;
	b=V7PmGuyCrM9OzYZ9GBGsMR6isppa3S94DcNtQU2M6u9q6KoGnr4cYYdFCMhSe4h3ZCNK
	 kLlHXX/tmnEtwpy1NukCaD1LcLxwLUb7kKLJrgVP+OyLhOEfdkWswaMKe/Hd3y6om8LZG
	 tCICNWxNt99Y4ve2a/HjqwIx6TsmoprUZVD2poviIGzey9dmJn4IWSBtZab04W3Fj0wH0
	 cM9zFBzmVGgNOCbFZCZKrun9oTeWe9Ib+OgxD5gItljxMclMzW7wdcIE0Z2I+P4vticv3
	 tdZviZw69c6KcfV7xSqqNMKMSziomN1bSxJZ+B5GDassW6H31iecw3Wnvnu7kMj5iBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KhjCu0Rt;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F3606A33D
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A3F3606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KhjCu0Rt
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-359b81ad4e8so2645272eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 10:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793902179; x=1794506979; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kF8SevhVCQWHNZC9drCBA7xTfiDAAX0qaL0O6Q4z388=;
        b=KhjCu0RtE1fjxQyH7jLjWc9APASw+c47Lvtb4g5NfieZ95xtD1auD152/nba4XQH47
         fn1F8xfQTlX6mgObvK/ep7Y4sk27aHAj+N/5JE9jnm0VxMcKnmOSPn/yLgRzZQcd0pA4
         C5wlHv2t3fOx54Jjaa8yvUICvuEaL2YPcfob4PaubLDOPfdMa7rbZa+AYV/Gpw6+arcY
         s4CMljob8LoxT+VxAeAJUMCCxX+QEcPy/bthKQpVKF8gznBkEbdDsJIePHXuQvrIz2vb
         q052YIb38Q1RgbLpgehqUI6bl3QVVVm1uCrSresESH2sAXgAJb0jG/byAqPi/Ivw8xce
         UWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793902179; x=1794506979;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kF8SevhVCQWHNZC9drCBA7xTfiDAAX0qaL0O6Q4z388=;
        b=f6RgX/aSsi/aZOdcrgfWqDuKqjrP0Kc4LFBoH5B9OFogxBlqRnZqUYIfIPTxxQIayA
         WqBtPyK+1LGKZbMBVjLZDKBGIMC0S0vL0ixZFc+NLriT4K9lutBQ7CDqeGnNskP37jU7
         i89NAG0Rq9itkYzMnDVjFi4QhvAwnL+59UB0J2QBHztAeBDCsskAQpNbnYOpfB2faalS
         7BsJWL1UgW0HR3mTsF6/kvCNMwrRW3MouwerBjkLg4mKMHC/T2b3RBFtd08bnq+F92yr
         OOGwvkkCkgZyse/2AAAU7NzOS8qExEbmTyLh+6GSei2D88EvWXNo/X36dz4bpOf2pjyg
         SXYA==
X-Forwarded-Encrypted: i=1; AKwUvBw+JjUQ4QW+yQapxJMTr/pogrbxrTDS/VMgbcglbyKjNw3jBK5504djAif+fjhzqDqeaa25oFblJh7j16f/tTDX@vger.kernel.org
X-Gm-Message-State: APuU4Z+Yj0ieU0yXo6o5mUKlunLbQU9jHRELBICJBzjnt+2gftc7QfjA
	vpu0CiV/7oliQyEBNdJkayMM0d7Xm/7brq5BU9ssXBsFnPOLvYM/AU0lFx6oSYqUyLWY9rv+asP
	mmjYaQor8Yg==
X-Received: from dybfe17.prod.google.com ([2002:a05:7300:bf91:b0:369:dee2:2b37])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:144b:b0:36a:1c46:2765
 with SMTP id 5a478bee46e88-36a42218429mr27162461eec.4.1793902179165; Thu, 05
 Nov 2026 10:09:39 -0800 (PST)
Date: Thu,  5 Nov 2026 10:09:22 -0800
In-Reply-To: <20261105180923.3441359-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105180923.3441359-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261105180923.3441359-3-irogers@google.com>
Subject: [RFC PATCH v3 2/3] perf build: Prefer zlib-rs over zlib when available
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Quentin Monnet <qmo@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Detect and prefer zlib-rs over C zlib in the perf build unless disabled
with NO_ZLIB_RS=1 (or NO_ZLIB=1 / NO_RUST=1):

- Move Rust compiler detection ahead of zlib detection in
  tools/perf/Makefile.config and use feature_check + feature_rust_lib for
  zlib-rs, setting both HAVE_ZLIB_SUPPORT and HAVE_ZLIB_RS_SUPPORT when
  zlib-rs is used and falling back to C zlib (-lz) otherwise.
- Replace -lz with $(ZLIB_LIBS) in DWARFLIBS and llvm-config
  --system-libs so static libdw/libelf and libLLVM configurations use
  the selected zlib implementation.
- Build and clean libz_rs.a in $(OUTPUT)libz_rs/, pass ZLIB_CFLAGS when
  building static libbpf, and share RUST_OUTPUT with the host bootstrap
  bpftool build in tools/perf/bpf_skel.mak.
- Expose 'zlib-rs' in 'perf check feature' / 'perf version --build-options'
  and document it in perf-check.txt.
- Add zlib-rs package mappings to tools/perf/scripts/install-build-deps.sh
  and NO_ZLIB / NO_ZLIB_RS build tests to tools/perf/tests/make.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore                    |  1 +
 tools/perf/Documentation/perf-check.txt  |  1 +
 tools/perf/Makefile.config               | 92 ++++++++++++++----------
 tools/perf/Makefile.perf                 | 32 +++++++--
 tools/perf/bpf_skel.mak                  |  8 ++-
 tools/perf/builtin-check.c               |  1 +
 tools/perf/scripts/install-build-deps.sh |  6 ++
 tools/perf/tests/make                    |  9 +++
 8 files changed, 107 insertions(+), 43 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 3b968c5158b8..8a5df9c9e8ae 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -55,6 +55,7 @@ libbpf/
 libperf/
 libsubcmd/
 libsymbol/
+libz_rs/
 fixdep
 Documentation/doc.dep
 python_ext_build/
diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index 1406a41c5d09..dda75b1d9cbd 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -66,6 +66,7 @@ feature::
                 numa_num_possible_cpus  /  HAVE_LIBNUMA_SUPPORT
                 python-module           /  HAVE_PYTHON_MODULE_SUPPORT
                 zlib                    /  HAVE_ZLIB_SUPPORT
+                zlib-rs                 /  HAVE_ZLIB_RS_SUPPORT
                 zstd                    /  HAVE_ZSTD_SUPPORT
 
 OPTIONS
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b4764f69f47f..81b56cbc8658 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -69,6 +69,12 @@ endif
 
 include $(srctree)/tools/scripts/Makefile.arch
 
+ifneq ($(CROSS_COMPILE),)
+  ifneq ($(RUST_TARGET_FLAGS_$(ARCH)),)
+    RUST_FLAGS += --target=$(RUST_TARGET_FLAGS_$(ARCH))
+  endif
+endif
+
 $(call detected_var,SRCARCH)
 
 CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
@@ -532,13 +538,54 @@ ifdef CORESIGHT
   endif
 endif
 
+ifndef NO_RUST
+  $(call feature_check,rust)
+  ifneq ($(feature-rust), 1)
+    $(warning Rust is not found. Test workloads with rust are disabled.)
+    NO_RUST := 1
+  else
+    NO_RUST := 0
+    CFLAGS += -DHAVE_RUST_SUPPORT
+    $(call detected,CONFIG_RUST_SUPPORT)
+  endif
+
+  ifneq ($(CROSS_COMPILE),)
+    ifeq ($(RUST_TARGET_FLAGS_$(ARCH)),)
+      $(error Unknown rust cross compilation architecture $(ARCH))
+    endif
+  endif
+endif
+
+# Building zlib-rs from Cargo crate sources requires a working rustc.
+ifneq ($(NO_RUST), 0)
+  NO_ZLIB_RS := 1
+endif
+
+# Prefer zlib-rs over C zlib when available, unless disabled via NO_ZLIB=1 or
+# NO_ZLIB_RS=1. Both provide the standard zlib C API (HAVE_ZLIB_SUPPORT), while
+# HAVE_ZLIB_RS_SUPPORT records that zlib-rs is the implementation in use.
 ifndef NO_ZLIB
-  ifeq ($(feature-zlib), 1)
+  ifndef NO_ZLIB_RS
+    $(call feature_check,zlib-rs)
+    ifeq ($(feature-zlib-rs), 1)
+      $(call feature_rust_lib,zlib-rs)
+      ZLIB_CFLAGS := $(FEATURE_CFLAGS-zlib-rs)
+      ZLIB_LIBS := $(FEATURE_LIBS-zlib-rs)
+      CFLAGS += -DHAVE_ZLIB_RS_SUPPORT $(ZLIB_CFLAGS)
+      $(call detected,CONFIG_ZLIB_RS)
+    endif
+  endif
+  ifeq ($(ZLIB_LIBS),)
+    ifeq ($(feature-zlib), 1)
+      ZLIB_LIBS := -lz
+    else
+      NO_ZLIB := 1
+    endif
+  endif
+  ifneq ($(ZLIB_LIBS),)
     CFLAGS += -DHAVE_ZLIB_SUPPORT
-    EXTLIBS += -lz
+    EXTLIBS += $(ZLIB_LIBS)
     $(call detected,CONFIG_ZLIB)
-  else
-    NO_ZLIB := 1
   endif
 endif
 
@@ -580,7 +627,7 @@ ifndef NO_LIBELF
   ifndef NO_LIBDW
     CFLAGS += -DHAVE_LIBDW_SUPPORT $(LIBDW_CFLAGS)
     LDFLAGS += $(LIBDW_LDFLAGS)
-    EXTLIBS += ${DWARFLIBS}
+    EXTLIBS += $(patsubst -lz,$(or $(ZLIB_LIBS),-lz),${DWARFLIBS})
     $(call detected,CONFIG_LIBDW)
   endif # NO_LIBDW
 
@@ -908,7 +955,7 @@ ifdef BUILD_NONDISTRO
   else ifeq ($(feature-libbfd-liberty), 1)
     EXTLIBS += -lbfd -lopcodes -liberty
   else ifeq ($(feature-libbfd-liberty-z), 1)
-    EXTLIBS += -lbfd -lopcodes -liberty -lz
+    EXTLIBS += -lbfd -lopcodes -liberty $(or $(ZLIB_LIBS),-lz)
   endif
 
   CFLAGS += -DHAVE_LIBBFD_SUPPORT
@@ -930,7 +977,7 @@ ifndef NO_LIBLLVM
     CFLAGS += -DHAVE_LIBLLVM_SUPPORT
     LLVM_CFLAGS := $(shell $(LLVM_CONFIG) --cflags 2>/dev/null)
     LLVM_CXXFLAGS := $(shell $(LLVM_CONFIG) --cxxflags 2>/dev/null)
-    LLVM_LIBLLVM := $(shell $(LLVM_CONFIG) --libs all 2>/dev/null) $(shell $(LLVM_CONFIG) --system-libs 2>/dev/null)
+    LLVM_LIBLLVM := $(shell $(LLVM_CONFIG) --libs all 2>/dev/null) $(patsubst -lz,$(or $(ZLIB_LIBS),-lz),$(shell $(LLVM_CONFIG) --system-libs 2>/dev/null))
     LLVM_LIBDIR := $(shell $(LLVM_CONFIG) --libdir 2>/dev/null)
     CFLAGS += $(LLVM_CFLAGS)
     CXXFLAGS += -DHAVE_LIBLLVM_SUPPORT $(LLVM_CXXFLAGS)
@@ -1132,37 +1179,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
   endif
 endif
 
-ifndef NO_RUST
-  $(call feature_check,rust)
-  ifneq ($(feature-rust), 1)
-    $(warning Rust is not found. Test workloads with rust are disabled.)
-    NO_RUST := 1
-  else
-    NO_RUST := 0
-    CFLAGS += -DHAVE_RUST_SUPPORT
-    $(call detected,CONFIG_RUST_SUPPORT)
-  endif
-
-  ifneq ($(CROSS_COMPILE),)
-    RUST_TARGET_FLAGS_arm	:= arm-unknown-linux-gnueabi
-    RUST_TARGET_FLAGS_arm64	:= aarch64-unknown-linux-gnu
-    RUST_TARGET_FLAGS_loongarch	:= loongarch64-unknown-linux-gnu
-    RUST_TARGET_FLAGS_m68k	:= m68k-unknown-linux-gnu
-    RUST_TARGET_FLAGS_mips	:= mipsel-unknown-linux-gnu
-    RUST_TARGET_FLAGS_powerpc	:= powerpc64le-unknown-linux-gnu
-    RUST_TARGET_FLAGS_riscv	:= riscv64gc-unknown-linux-gnu
-    RUST_TARGET_FLAGS_s390	:= s390x-unknown-linux-gnu
-    RUST_TARGET_FLAGS_x86	:= x86_64-unknown-linux-gnu
-    RUST_TARGET_FLAGS_x86_64	:= x86_64-unknown-linux-gnu
-
-    ifeq ($(RUST_TARGET_FLAGS_$(ARCH)),)
-      $(error Unknown rust cross compilation architecture $(ARCH))
-    endif
-
-    RUST_FLAGS += --target=$(RUST_TARGET_FLAGS_$(ARCH))
-  endif
-endif
-
 # Among the variables below, these:
 #   perfexecdir
 #   libbpf_include_dir
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b74b534e1153..0c24b13e9e0c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -75,6 +75,8 @@ include ../scripts/utilities.mak
 #
 # Define NO_ZLIB if you do not want to support compressed kernel modules
 #
+# Define NO_ZLIB_RS if you do not want to use zlib-rs for zlib support
+#
 # Define NO_BABELTRACE2 if you do not want babeltrace2-ctf-writer support
 # for CTF data format.
 #
@@ -417,6 +419,13 @@ ifdef LIBBPF_STATIC
   CFLAGS += -I$(LIBBPF_OUTPUT)/include
 endif
 
+ifneq ($(OUTPUT),)
+  LIBZ_RS_OUTPUT = $(abspath $(OUTPUT))/libz_rs
+else
+  LIBZ_RS_OUTPUT = $(CURDIR)/libz_rs
+endif
+LIBZ_RS = $(filter %/libz_rs.a,$(ZLIB_LIBS))
+
 ifneq ($(OUTPUT),)
   LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
 else
@@ -741,6 +750,11 @@ ifdef LIBBPF_STATIC
 prepare: $(LIBBPF)
 endif
 
+ifneq ($(LIBZ_RS),)
+prepare: $(LIBZ_RS)
+bpf-skel-prepare: $(LIBZ_RS)
+endif
+
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
 
@@ -805,15 +819,25 @@ $(LIBAPI)-clean:
 	$(call QUIET_CLEAN, libapi)
 	$(Q)$(RM) -r -- $(LIBAPI_OUTPUT)
 
-$(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
+$(LIBBPF): FORCE $(LIBZ_RS) | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
 		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= subdir= \
-		EXTRA_CFLAGS="-fPIC" $@ install_headers
+		EXTRA_CFLAGS="-fPIC $(ZLIB_CFLAGS)" $@ install_headers
 
 $(LIBBPF)-clean:
 	$(call QUIET_CLEAN, libbpf)
 	$(Q)$(RM) -r -- $(LIBBPF_OUTPUT)
 
+ifneq ($(LIBZ_RS),)
+$(LIBZ_RS): | $(LIBZ_RS_OUTPUT)
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.rust LIBZ_RS_OUTPUT=$(LIBZ_RS_OUTPUT)/ \
+		CARGO="$(CARGO)" RUSTC="$(RUSTC)" RUST_FLAGS="$(RUST_FLAGS)" $@
+endif
+
+libz-rs-clean:
+	$(call QUIET_CLEAN, libz_rs)
+	$(Q)$(RM) -r -- $(LIBZ_RS_OUTPUT)
+
 $(LIBPERF): FORCE | $(LIBPERF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(LIBPERF_OUTPUT) \
 		DESTDIR=$(LIBPERF_DESTDIR) prefix= subdir= \
@@ -1026,7 +1050,7 @@ python-clean:
 		$(RM) $(OUTPUT)python/perf.pyi; \
 	fi
 
-$(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
+$(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT) $(LIBZ_RS_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
 bpf-skel-clean:
@@ -1050,7 +1074,7 @@ else # When an OUTPUT directory is present, clean up the copied pmu-events/arch
 endif
 
 clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean \
-		arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean \
+		libz-rs-clean arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean \
 		pmu-events-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive \
 		$(OUTPUT)perf-iostat $(LANG_BINDINGS)
diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
index f2559de39f96..d2ac4c4a7402 100644
--- a/tools/perf/bpf_skel.mak
+++ b/tools/perf/bpf_skel.mak
@@ -39,9 +39,15 @@ ifneq ($(WERROR),0)
   CLANG_OPTIONS += -Werror
 endif
 
+# When not cross-compiling, share the top-level $(OUTPUT)libz_rs/ directory
+# with the host bootstrap bpftool build so libz_rs.a is not compiled twice.
+ifeq ($(CROSS_COMPILE),)
+BPFTOOL_RUST_OUTPUT := RUST_OUTPUT=$(abspath $(or $(OUTPUT),.))/
+endif
+
 $(BPFTOOL):
 	$(Q)mkdir -p $(SKEL_TOOL_TMP_OUT)
-	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool OUTPUT=$(SKEL_TOOL_TMP_OUT)/ bootstrap
+	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool OUTPUT=$(SKEL_TOOL_TMP_OUT)/ $(BPFTOOL_RUST_OUTPUT) bootstrap
 
 # Paths to search for a kernel to generate vmlinux.h from.
 VMLINUX_BTF_ELF_PATHS ?= $(if $(O),$(O)/vmlinux)			\
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 1e43e097e7a7..fe1fc40561a9 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -59,6 +59,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
 	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
+	FEATURE_STATUS("zlib-rs", HAVE_ZLIB_RS_SUPPORT),
 	FEATURE_STATUS("zstd", HAVE_ZSTD_SUPPORT),
 	FEATURE_STATUS("rust", HAVE_RUST_SUPPORT),
 
diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/scripts/install-build-deps.sh
index 3e53c7bf0f85..7c405f1a4c83 100755
--- a/tools/perf/scripts/install-build-deps.sh
+++ b/tools/perf/scripts/install-build-deps.sh
@@ -146,6 +146,9 @@ fedora_pkg_for() {
 	zlib)
 		echo "zlib-devel"
 		;;
+	zlib-rs)
+		echo "cargo rust-libz-rs-sys-devel"
+		;;
 	lzma)
 		echo "xz-devel"
 		;;
@@ -305,6 +308,9 @@ debian_pkg_for() {
 	zlib)
 		echo "zlib1g-dev"
 		;;
+	zlib-rs)
+		echo "cargo librust-libz-rs-sys-dev"
+		;;
 	lzma)
 		echo "liblzma-dev"
 		;;
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 7524de522802..96567d9ea2a4 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -99,6 +99,8 @@ make_no_babeltrace2 := NO_BABELTRACE2=1
 make_with_coresight := CORESIGHT=1
 make_no_sdt	    := NO_SDT=1
 make_no_libpfm4     := NO_LIBPFM4=1
+make_no_zlib        := NO_ZLIB=1
+make_no_zlib_rs     := NO_ZLIB_RS=1
 make_with_gtk4      := GTK4=1
 make_refcnt_check   := EXTRA_CFLAGS="-DREFCNT_CHECKING=1"
 make_tags           := tags
@@ -193,6 +195,8 @@ run += make_no_sdt
 run += make_no_babeltrace2
 run += make_with_coresight
 run += make_no_libpfm4
+run += make_no_zlib
+run += make_no_zlib_rs
 run += make_refcnt_check
 run += make_help
 run += make_doc
@@ -302,6 +306,11 @@ test_make_install_pdf_O  := $(test_ok)
 test_make_libbpf_dynamic :=   ldd $(PERF_O)/perf | grep -q libbpf
 test_make_libbpf_dynamic_O := ldd $$TMP_O/perf | grep -q libbpf
 
+test_make_no_zlib             := test -x $(PERF_O)/perf && ! $(PERF_O)/perf check -q feature zlib && ! $(PERF_O)/perf check -q feature zlib-rs
+test_make_no_zlib_O           := test -x $$TMP_O/perf && ! $$TMP_O/perf check -q feature zlib && ! $$TMP_O/perf check -q feature zlib-rs
+test_make_no_zlib_rs          := test -x $(PERF_O)/perf && ! $(PERF_O)/perf check -q feature zlib-rs
+test_make_no_zlib_rs_O        := test -x $$TMP_O/perf && ! $$TMP_O/perf check -q feature zlib-rs
+
 # Feature tests are allowed to fail, so a broken C++ compiler command line
 # doesn't fail the build, it just quietly turns off everything that needs a
 # C++ compiler. Check a feature that does, otherwise these tests would pass
-- 
2.56.0.455.g6c5a503b38-goog

