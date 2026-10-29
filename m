Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291411;
	b=XsbaSzvQHwrmQ4O+hkhE7T81BopUhKsU3wOrVbzRTI13s8AQTB50q6etSjiI9a1Nz/Fm
	 VRsGL0ML3kQosVDgKAd+Sp2lr/ZHlM1wlKKRAv7V/eGbnSQsTyXhWf6zPGi+SbfkdantJ
	 Nxa2ZGseHCeRkMwHR62bVAPsJfP5Jw+k3qe0/aRly7xAI03qKnvyXFVVDWXOJbY00Wofp
	 8tXPI+d5TpTIZaq3pu4uJveav3b5/9yjnaejCizvGHI7YguIE5407pGMDPI1ZZLCEGijC
	 WwBoQsIyTcSOTTgGVxuqD5ujO019R6cswCeTTpBQ4wZgcXMwWCVD4RIG41fSFp7PVxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=qE1WPTi5bEFrUCOlj2WSbD3YVij6pGJEfq5m52PopnQ=;
	b=FHd60W4cxL0fd7o6B7vS8deHh00I3CQOTdyDb3hcTz4peaIiWwK8tY2ae2l2LZYxyLJE
	 tQ3flpij5RLVoBVu65iNPAKVAmGJ2+0YJAogdHMjU4Q5gmYte1sHIrZnzzoZzve/8n+pQ
	 eXMpsq78aBNRaBzr4z0uyyj829hbDSQhM5R2ixGf7kY8Wq3XhQW5kqzTWn44GTbbh3p3X
	 BG3bJ7n8eB94JX44w4QEDsZislWB5n8i08Whu/6IpQII4cBWZAnnGHPvQmuiI6Y0wjrN4
	 iaTuv8lfdIfwoJZMagddb4d2E9GdvWqw2sk7bf3lg7HQYkGO8GZgUpfAltMpSmxiF1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TbsVrI6w;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8460A2607
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 16:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75D8460A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TbsVrI6w
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14373747468so2504063c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793291409; x=1793896209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qE1WPTi5bEFrUCOlj2WSbD3YVij6pGJEfq5m52PopnQ=;
        b=TbsVrI6wPs7TVPmC4bQFLuHVaSilgtltUUUhPOfYTd5VcHaZRATC9sA7YsdyjLBIEI
         pHmPO/Vd+u7fLZV5pJhazC61Lw61GbGyy4+ZcmQK1gRxMZcezSPDzt5vK7HoOBWJgxq8
         6vDapGW3xEUbrq+Ib6bGOh+kIDuHGtGvBcSK0nWGuJqxKiTPybbMpxYH4kCM7tmv1hIq
         mmhrS58wOzAzgHhVJQYCtBrbaLXrBZxHMolERwHuxFm932bM6SPCbJAb3Ohy0NzUxZUI
         4G2VHhP8EOPwocGeY8W6gp2A8OcTMv7m8Xuu9SqWH6GjjSGDJcbBgeq1Pot4ZvChvGK8
         gNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291409; x=1793896209;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qE1WPTi5bEFrUCOlj2WSbD3YVij6pGJEfq5m52PopnQ=;
        b=uuU73Q9RtaPnQP0J8h0s1G7XckstaAo8NME0DMQPRjSXJ1TocNnItzSF9tHkBBfDGr
         9IABbjQteMD+sRnaKxPQ42p08cOZpsaiPszqNIEgXbZpVWiXP2HEj+F1rL5Mn1je5GGR
         l0yzJJ3/HHUVVRmJ09M7ICftiq7SB8LcUi/S4csl+xqMGzLU9rt/1i6J+HXOlsag7Jw5
         yhyfdVGTXml1MSW3EsbKy9DSFyq8bJK/sR1vOW5FQspZXLq84jUaeLOqzfBlpGbJiawx
         EeFUm627vJxV1CRqpcOLlUA46BkbAedASp1L0/D5cq5EL/BmfRL/zQ31O4wrRpzS0t+P
         tgCQ==
X-Gm-Message-State: AFq9FYKcqWufIvXvbWZkFroJAUak0cqekEVuTamGAhmciSBLcoA8JO5d
	fEKRnXac+NVsCtZQ22B1SwkpMWVyKNNUeY/6VVoYpZguw5lspOb9++GC/PG1WU7348QOtEqluo1
	9DeNBW3fbGw==
X-Received: from dldyr25-n1.prod.google.com ([2002:a05:701b:4519:10b0:1a7:76f5:9d46])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:298:b0:19a:20d3:a3d6
 with SMTP id a92af1059eb24-1a6c85d1368mr6923933c88.1.1793291409117; Thu, 29
 Oct 2026 09:30:09 -0700 (PDT)
Date: Thu, 29 Oct 2026 09:29:56 -0700
In-Reply-To: <20261029162958.3224280-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029162958.3224280-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029162958.3224280-2-irogers@google.com>
Subject: [RFC PATCH v1 1/3] tools build: Add Rust library build infrastructure
 and zlib-rs feature test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Quentin Monnet <qmo@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add shared Rust library build and feature detection support across tools/
and implement the zlib-rs feature check:

- Add tools/build/Makefile.rust with helpers to locate Cargo crate
  sources in distro (/usr/share/cargo/registry) or user Cargo registries,
  compile .rlib and .a targets with rustc, and resolve C compiler/linker
  flags via %-cflags and %-libs targets.
- Support resolving zlib-rs via LIBZ_RS_DIR, pkg-config
  (libz-rs-sys-cdylib, zlib-rs, z_rs), or building libz_rs.a (along with
  libzlib_rs.rlib and liblibc.rlib) into $(OUTPUT)libz_rs/.
- Add tools/build/feature/test-zlib-rs.c verifying ZLIB_VER_SUBREVISION
  =3D=3D 15 (0xf) and linking against inflateInit().
- Extend tools/build/Build.include and tools/build/Makefile.build with
  cfgs-to-flags, rlibs-to-externs, per-target RUST_FLAGS/RUST_ENVS, and
  $(OUTPUT)lib%.rlib: %.rs pattern rules.
- Add RUST_TARGET_FLAGS_<arch> cross-compilation triples to
  tools/scripts/Makefile.arch and the feature_rust_lib helper macro to
  tools/scripts/Makefile.include.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Build.include          |  14 ++-
 tools/build/Makefile.build         |  13 ++-
 tools/build/Makefile.feature       |   9 +-
 tools/build/Makefile.rust          | 149 +++++++++++++++++++++++++++++
 tools/build/feature/.gitignore     |   1 +
 tools/build/feature/Makefile       |   9 +-
 tools/build/feature/test-zlib-rs.c |  19 ++++
 tools/scripts/Makefile.arch        |  14 +++
 tools/scripts/Makefile.include     |  10 ++
 9 files changed, 229 insertions(+), 9 deletions(-)
 create mode 100644 tools/build/Makefile.rust
 create mode 100644 tools/build/feature/test-zlib-rs.c

diff --git a/tools/build/Build.include b/tools/build/Build.include
index cd0baa7a168d..45b61c31fd4c 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -100,12 +100,18 @@ cxx_flags =3D -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAG=
S) -D"BUILD_STR(s)=3D\#s" $(CXX
=20
 ###
 # Rust flags to be used on rule definition, includes:
+# - cfgs-to-flags helper to turn cfg tokens into --cfg=3D'...' flags
+# - rlibs-to-externs helper to map .rlib prerequisites to --extern <crate>=
=3D<path>
 # - global $(RUST_FLAGS)
-# - per target Rust flags
-# - per object Rust flags
-rust_flags_1 =3D $(RUST_FLAGS) $(RUST_FLAGS_$(basetarget).o) $(RUST_FLAGS_=
$(obj))
-rust_flags_2 =3D $(filter-out $(RUST_FLAGS_REMOVE_$(basetarget).o), $(rust=
_flags_1))
+# - per target Rust flags ($(RUST_FLAGS_<target>)) and envs ($(RUST_ENVS_<=
target>))
+# - per object Rust flags ($(RUST_FLAGS_<obj>)) and envs ($(RUST_ENVS_<obj=
>))
+cfgs-to-flags =3D $(patsubst %,--cfg=3D'%',$1)
+rlibs-to-externs =3D $(foreach rlib,$(filter %.rlib,$1),--extern $(patsubs=
t lib%.rlib,%,$(notdir $(rlib)))=3D$(rlib))
+
+rust_flags_1 =3D $(RUST_FLAGS) $(RUST_FLAGS_$(basetarget).o) $(RUST_FLAGS_=
$(notdir $@)) $(RUST_FLAGS_$(obj))
+rust_flags_2 =3D $(filter-out $(RUST_FLAGS_REMOVE_$(basetarget).o) $(RUST_=
FLAGS_REMOVE_$(notdir $@)), $(rust_flags_1))
 rust_flags   =3D $(filter-out $(RUST_FLAGS_REMOVE_$(obj)), $(rust_flags_2)=
)
+rust_envs    =3D $(RUST_ENVS_$(notdir $@)) $(RUST_ENVS_$(obj))
=20
 ###
 ## HOSTCC C flags
diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index ad69efdd4e85..50c3eb57d34b 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -79,12 +79,15 @@ quiet_cmd_host_ld_multi =3D HOSTLD  $@
                           xargs $(HOSTLD) -r -o $@,rm -f $@; $(HOSTAR) rcs=
 $@)
=20
 rust_common_cmd =3D \
-	$(RUSTC) $(rust_flags) \
-	--crate-type staticlib -L $(objtree)/rust/ \
+	$(rust_envs) $(RUSTC) $(rust_flags) \
+	-L $(objtree)/rust/ $(call rlibs-to-externs,$^) \
 	--emit=3Ddep-info=3D$(depfile),link
=20
+quiet_cmd_rustc_rlib_rs =3D $(RUSTC) $(quiet_modtag) $@
+      cmd_rustc_rlib_rs =3D $(rust_common_cmd) --crate-type rlib --crate-n=
ame $(patsubst lib%.rlib,%,$(notdir $@)) -o $@ $<
+
 quiet_cmd_rustc_a_rs =3D $(RUSTC) $(quiet_modtag) $@
-      cmd_rustc_a_rs =3D $(rust_common_cmd) -o $@ -g $< $(cmd_objtool)
+      cmd_rustc_a_rs =3D $(rust_common_cmd) --crate-type staticlib -o $@ -=
g $< $(cmd_objtool)
=20
 ifneq ($(filter $(obj),$(hostprogs)),)
   host =3D host_
@@ -117,6 +120,10 @@ $(OUTPUT)%.s: %.c FORCE
=20
 # it's recommended to build a static rust library, when a foreight (to rus=
t)
 # linker is used.
+$(OUTPUT)lib%.rlib: %.rs FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,rustc_rlib_rs)
+
 $(OUTPUT)%.a: %.rs FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,rustc_a_rs)
diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 4d37d11f674c..c372600ae9e4 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -5,10 +5,11 @@ ifneq ($(OUTPUT),)
   OUTPUT_FEATURES =3D $(OUTPUT)feature/
   $(shell mkdir -p $(OUTPUT_FEATURES))
 endif
+RUST_OUTPUT ?=3D $(abspath $(or $(OUTPUT),$(CURDIR)))/
=20
 feature_check =3D $(eval $(feature_check_code))
 define feature_check_code
-  feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D"$(CC=
)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" C=
XXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=3D"$(L=
DFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)=
test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
+  feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) RUST_OUTPU=
T=3D"$(RUST_OUTPUT)" CC=3D"$(CC)" CXX=3D"$(CXX)" RUSTC=3D"$(RUSTC)" $(if $(=
PKG_CONFIG),PKG_CONFIG=3D"$(PKG_CONFIG)") CFLAGS=3D"$(CLANG_CROSS_FLAGS) $(=
EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS=3D"$(CLANG_CROSS_FLAGS=
) $(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" RUST_FLAGS=3D"$(RUST_FL=
AGS)" LDFLAGS=3D"$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir=
) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
 endef
=20
 feature_set =3D $(eval $(feature_set_code))
@@ -128,6 +129,8 @@ FEATURE_TESTS_EXTRA :=3D                  \
          libdebuginfod			\
          clang-bpf-co-re		\
          bpftool-skeletons		\
+         zlib-rs			\
+         rust				\
          libunwind			\
          libunwind-debug-frame		\
          $(foreach arch,$(LIBUNWIND_ARCHS),libunwind-$(arch) libunwind-deb=
ug-frame-$(arch))
@@ -149,6 +152,7 @@ FEATURE_DISPLAY ?=3D              \
          libcapstone            \
          llvm-perf              \
          zlib                   \
+         zlib-rs                \
          lzma                   \
          bpf			\
          libaio			\
@@ -216,6 +220,9 @@ ifeq ($(feature-all), 1)
   $(call feature_check,compile-x32)
   $(call feature_check,bionic)
   $(call feature_check,babeltrace2-ctf-writer)
+  ifneq ($(filter zlib-rs,$(FEATURE_TESTS)),)
+    $(call feature_check,zlib-rs)
+  endif
   $(call feature_check,libunwind)
   $(call feature_check,libunwind-debug-frame)
   $(foreach arch,$(LIBUNWIND_ARCHS),$(call feature_check,libunwind-$(arch)=
))
diff --git a/tools/build/Makefile.rust b/tools/build/Makefile.rust
new file mode 100644
index 000000000000..cd9e0915b929
--- /dev/null
+++ b/tools/build/Makefile.rust
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Shared rules and helpers for discovering and building Rust libraries
+# (either from pre-installed packages/pkg-config or from local Cargo crate
+# sources) for tools/ builds and feature detection.
+
+ifeq ($(pound),)
+include $(dir $(lastword $(MAKEFILE_LIST)))../scripts/Makefile.include
+endif
+
+ifeq ($(PKG_CONFIG),)
+  ifneq (, $(shell which $(CROSS_COMPILE)pkg-config 2>/dev/null))
+    PKG_CONFIG :=3D $(CROSS_COMPILE)pkg-config
+  else
+    PKG_CONFIG :=3D pkg-config
+
+    ifdef CROSS_COMPILE
+      ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH)$(PKG_CONFIG_SYSROOT_DIR=
),)
+        CROSS_ARCH =3D $(notdir $(CROSS_COMPILE:%-=3D%))
+        PKG_CONFIG_LIBDIR :=3D /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
+        PKG_CONFIG_LIBDIR :=3D $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS=
_ARCH)/pkgconfig/
+        PKG_CONFIG_LIBDIR :=3D $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)=
/pkgconfig/
+        PKG_CONFIG_LIBDIR :=3D $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgco=
nfig/
+        PKG_CONFIG_LIBDIR :=3D $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
+        export PKG_CONFIG_LIBDIR
+      endif
+    endif
+  endif
+endif
+
+ifeq ($(findstring -static,${LDFLAGS}),-static)
+  ifeq ($(findstring --static,$(PKG_CONFIG)),)
+    PKG_CONFIG +=3D --static
+  endif
+endif
+
+# Search both distro-packaged Cargo registries (e.g. Debian/Ubuntu
+# /usr/share/cargo/registry from librust-*-dev packages) and user Cargo
+# registries ($CARGO_HOME/registry/src/* or ~/.cargo/registry/src/*).
+# Require a digit after "<crate>-" so prefixes like "libc-" do not match
+# unrelated crates such as "libc-print-*", and use version sorting (sort -=
V)
+# on the "<crate>-<version>" directory basename when multiple versions exi=
st.
+CARGO_REGISTRY_DIR ?=3D /usr/share/cargo/registry $(wildcard $(or $(CARGO_=
HOME),$(HOME)/.cargo)/registry/src/*)
+cargo_crate_dirs =3D $(strip $(foreach dir,$(CARGO_REGISTRY_DIR),$(wildcar=
d $(dir)/$(1)-[0-9]*)))
+cargo_crate_dir =3D $(if $(word 2,$(call cargo_crate_dirs,$(1))),$(shell p=
rintf '%s\n' $(call cargo_crate_dirs,$(1)) | awk -F/ '{print $$NF, $$0}' | =
sort -k1,1V | tail -n1 | cut -d' ' -f2-),$(call cargo_crate_dirs,$(1)))
+
+# Extract CARGO_PKG_VERSION* environment variables expected by crates usin=
g
+# env!("CARGO_PKG_VERSION*") from the "<crate>-<version>" directory name.
+define cargo_pkg_envs
+CARGO_PKG_VERSION=3D$(patsubst $(1)-%,%,$(notdir $(2))) \
+CARGO_PKG_VERSION_MAJOR=3D$(word 1,$(subst ., ,$(patsubst $(1)-%,%,$(notdi=
r $(2))))) \
+CARGO_PKG_VERSION_MINOR=3D$(word 2,$(subst ., ,$(patsubst $(1)-%,%,$(notdi=
r $(2)))))
+endef
+
+# Convert a whitespace-separated list of cfg tokens into --cfg=3D'...' fla=
gs.
+cfgs-to-flags =3D $(patsubst %,--cfg=3D'%',$1)
+
+# Map .rlib prerequisites to explicit --extern <crate>=3D<path.rlib> flags=
.
+# Passing explicit paths avoids -L ambiguity with sysroot crates (e.g. E04=
64
+# when both sysroot and local liblibc.rlib exist).
+rlibs-to-externs =3D $(foreach rlib,$(filter %.rlib,$1),--extern $(patsubs=
t lib%.rlib,%,$(notdir $(rlib)))=3D$(rlib))
+rustc_common_flags :=3D -C opt-level=3D3 -C relocation-model=3Dpic
+
+cmd_rustc_rlib =3D \
+	$(rustc_target_envs) $(RUSTC) $(RUST_FLAGS) $(rustc_common_flags) $(rustc=
_target_flags) \
+	$(call rlibs-to-externs,$^) --crate-type rlib --crate-name $(patsubst lib=
%.rlib,%,$(notdir $@)) \
+	-o $@ $(filter %.rs,$^) > $(@:.rlib=3D.make.output) 2>&1
+
+cmd_rustc_staticlib =3D \
+	$(rustc_target_envs) $(RUSTC) $(RUST_FLAGS) $(rustc_common_flags) $(rustc=
_target_flags) \
+	$(call rlibs-to-externs,$^) --crate-type staticlib --crate-name $(patsubs=
t lib%.a,%,$(notdir $@)) \
+	-o $@ $(filter %.rs,$^) > $(@:.a=3D.make.output) 2>&1
+
+# Helper targets invoked by $(call feature_rust_lib,<name>) to query the
+# resolved compiler and linker flags for a Rust library feature.
+%-cflags:
+	@echo $(FEATURE_CFLAGS-$*)
+
+%-libs:
+	@echo $(FEATURE_LIBS-$*)
+
+# Place compiled Rust library artifacts in their own subdirectory under th=
e
+# build output root (e.g. $(OUTPUT)libz_rs/, alongside libapi/, libbpf/, e=
tc.)
+# rather than inside $(OUTPUT)feature/.
+RUST_OUTPUT ?=3D $(patsubst %/feature/,%/,$(OUTPUT))
+LIBZ_RS_OUTPUT ?=3D $(RUST_OUTPUT)libz_rs/
+
+$(LIBZ_RS_OUTPUT):
+	$(Q)mkdir -p $@
+
+# Build chain for libz_rs.a from Cargo crate sources:
+#   libc (liblibc.rlib) -> zlib-rs (libzlib_rs.rlib) -> libz-rs-sys (libz_=
rs.a)
+LIBC_RS_DIR ?=3D $(call cargo_crate_dir,libc)
+libc-cfgs :=3D feature=3D"default" feature=3D"std"
+libc-flags :=3D --edition=3D2021 $(call cfgs-to-flags,$(libc-cfgs))
+
+$(LIBZ_RS_OUTPUT)liblibc.rlib: private rustc_target_flags =3D $(libc-flags=
)
+$(LIBZ_RS_OUTPUT)liblibc.rlib: $(wildcard $(LIBC_RS_DIR)/src/lib.rs) | $(L=
IBZ_RS_OUTPUT)
+	@$(if $<,$(cmd_rustc_rlib),false)
+
+ZLIB_RS_DIR ?=3D $(call cargo_crate_dir,zlib-rs)
+zlib_rs-cfgs :=3D feature=3D"__internal-api" feature=3D"c-allocator" featu=
re=3D"rust-allocator" feature=3D"std"
+zlib_rs-flags :=3D --edition=3D2021 $(call cfgs-to-flags,$(zlib_rs-cfgs))
+
+$(LIBZ_RS_OUTPUT)libzlib_rs.rlib: private rustc_target_flags =3D $(zlib_rs=
-flags)
+$(LIBZ_RS_OUTPUT)libzlib_rs.rlib: $(wildcard $(ZLIB_RS_DIR)/src/lib.rs) | =
$(LIBZ_RS_OUTPUT)
+	@$(if $<,$(cmd_rustc_rlib),false)
+
+# Enable export-symbols, c-allocator, std, and gz so libz_rs.a exports the
+# full standard zlib C ABI (inflate*, deflate*, gz*, etc.) without symbol
+# prefixing.
+LIBZ_RS_SYS_DIR ?=3D $(call cargo_crate_dir,libz-rs-sys)
+libz_rs_sys-cfgs :=3D feature=3D"export-symbols" feature=3D"c-allocator" f=
eature=3D"std" feature=3D"gz"
+libz_rs_sys-flags :=3D --edition=3D2021 $(call cfgs-to-flags,$(libz_rs_sys=
-cfgs))
+libz_rs_sys-envs :=3D $(call cargo_pkg_envs,libz-rs-sys,$(LIBZ_RS_SYS_DIR)=
)
+
+$(LIBZ_RS_OUTPUT)libz_rs.a: private rustc_target_envs =3D $(libz_rs_sys-en=
vs)
+$(LIBZ_RS_OUTPUT)libz_rs.a: private rustc_target_flags =3D $(libz_rs_sys-f=
lags)
+$(LIBZ_RS_OUTPUT)libz_rs.a: $(wildcard $(LIBZ_RS_SYS_DIR)/src/lib.rs) $(LI=
BZ_RS_OUTPUT)libzlib_rs.rlib $(LIBZ_RS_OUTPUT)liblibc.rlib | $(LIBZ_RS_OUTP=
UT)
+	@$(if $(filter %.rs,$^),$(cmd_rustc_staticlib),false)
+
+# Resolve zlib-rs flags and libraries in priority order:
+#   1. Explicit LIBZ_RS_DIR=3D/path/to/prefix override
+#   2. pkg-config (libz-rs-sys-cdylib, zlib-rs, or z_rs)
+#   3. Local Cargo crate sources built into $(LIBZ_RS_OUTPUT)libz_rs.a
+ifdef LIBZ_RS_DIR
+  FEATURE_CFLAGS-zlib-rs :=3D -I$(LIBZ_RS_DIR)/include
+  FEATURE_LIBS-zlib-rs :=3D -L$(LIBZ_RS_DIR)/lib -lz_rs
+endif
+
+ifeq ($(FEATURE_LIBS-zlib-rs),)
+  ZLIB_RS_PC :=3D $(shell $(PKG_CONFIG) --exists libz-rs-sys-cdylib 2>/dev=
/null && echo libz-rs-sys-cdylib || \
+                        ($(PKG_CONFIG) --exists zlib-rs 2>/dev/null && ech=
o zlib-rs) || \
+                        ($(PKG_CONFIG) --exists z_rs 2>/dev/null && echo z=
_rs))
+  ifneq ($(ZLIB_RS_PC),)
+    FEATURE_CFLAGS-zlib-rs :=3D $(shell $(PKG_CONFIG) --cflags $(ZLIB_RS_P=
C) 2>/dev/null)
+    FEATURE_LIBS-zlib-rs :=3D $(shell $(PKG_CONFIG) --libs $(ZLIB_RS_PC) 2=
>/dev/null)
+  endif
+endif
+
+ifeq ($(FEATURE_LIBS-zlib-rs),)
+  ifneq ($(and $(ZLIB_RS_DIR),$(LIBZ_RS_SYS_DIR),$(LIBC_RS_DIR)),)
+    FEATURE_CFLAGS-zlib-rs :=3D -I$(LIBZ_RS_SYS_DIR)/include
+    FEATURE_STATIC-zlib-rs :=3D $(LIBZ_RS_OUTPUT)libz_rs.a
+    FEATURE_LIBS-zlib-rs :=3D $(FEATURE_STATIC-zlib-rs)
+  endif
+endif
+
+zlib-rs-libs: $(FEATURE_STATIC-zlib-rs)
diff --git a/tools/build/feature/.gitignore b/tools/build/feature/.gitignor=
e
index 15fcd34acdb9..2fb933f84bd0 100644
--- a/tools/build/feature/.gitignore
+++ b/tools/build/feature/.gitignore
@@ -2,3 +2,4 @@
 *.d
 *.bin
 *.output
+libz_rs/
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 10340a537224..ff41e3d3569a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -50,6 +50,7 @@ FILES=3D                                          \
          test-compile-32.bin                    \
          test-compile-x32.bin                   \
          test-zlib.bin                          \
+         test-zlib-rs.bin                       \
          test-lzma.bin                          \
          test-bpf.bin                           \
          test-libbpf.bin                        \
@@ -301,6 +302,11 @@ $(OUTPUT)test-compile-x32.bin:
 $(OUTPUT)test-zlib.bin:
 	$(BUILD) -lz
=20
+include ../Makefile.rust
+
+$(OUTPUT)test-zlib-rs.bin: $(FEATURE_STATIC-zlib-rs)
+	$(BUILD) $(FEATURE_CFLAGS-zlib-rs) $(FEATURE_LIBS-zlib-rs) -lpthread -ldl=
 -lm
+
 $(OUTPUT)test-lzma.bin:
 	$(BUILD) -llzma
=20
@@ -374,4 +380,5 @@ $(OUTPUT)test-rust.bin:
 ###############################
=20
 clean:
-	rm -f $(FILES) $(OUTPUT)*.d $(FILES:.bin=3D.make.output)
+	rm -f $(FILES) $(OUTPUT)*.d $(OUTPUT)*.make.output
+	rm -rf $(LIBZ_RS_OUTPUT)
diff --git a/tools/build/feature/test-zlib-rs.c b/tools/build/feature/test-=
zlib-rs.c
new file mode 100644
index 000000000000..b8729c5135bb
--- /dev/null
+++ b/tools/build/feature/test-zlib-rs.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <zlib.h>
+
+/*
+ * libz-rs-sys's bundled zlib.h defines ZLIB_VER_SUBREVISION to 15 (0xf) t=
o
+ * distinguish itself from standard C zlib (which defines it to 0). Verify
+ * we are including the zlib-rs header and can link against its zlib C ABI=
.
+ */
+#if !defined(ZLIB_VER_SUBREVISION) || ZLIB_VER_SUBREVISION !=3D 15
+#error "Not zlib-rs header"
+#endif
+
+int main(void)
+{
+	z_stream zs;
+
+	inflateInit(&zs);
+	return 0;
+}
diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
index ed5f008d400e..d5f25f3be555 100644
--- a/tools/scripts/Makefile.arch
+++ b/tools/scripts/Makefile.arch
@@ -50,3 +50,17 @@ ifeq ($(LP64), 1)
 else
   IS_64_BIT :=3D 0
 endif
+
+# Map kernel ARCH to rustc --target triples when cross-compiling tools/.
+ifneq ($(CROSS_COMPILE),)
+  RUST_TARGET_FLAGS_arm		:=3D arm-unknown-linux-gnueabi
+  RUST_TARGET_FLAGS_arm64	:=3D aarch64-unknown-linux-gnu
+  RUST_TARGET_FLAGS_loongarch	:=3D loongarch64-unknown-linux-gnu
+  RUST_TARGET_FLAGS_m68k	:=3D m68k-unknown-linux-gnu
+  RUST_TARGET_FLAGS_mips	:=3D mipsel-unknown-linux-gnu
+  RUST_TARGET_FLAGS_powerpc	:=3D powerpc64le-unknown-linux-gnu
+  RUST_TARGET_FLAGS_riscv	:=3D riscv64gc-unknown-linux-gnu
+  RUST_TARGET_FLAGS_s390	:=3D s390x-unknown-linux-gnu
+  RUST_TARGET_FLAGS_x86		:=3D x86_64-unknown-linux-gnu
+  RUST_TARGET_FLAGS_x86_64	:=3D x86_64-unknown-linux-gnu
+endif
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.includ=
e
index 378387f62960..72394d245d5d 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -111,6 +111,16 @@ SYSTEM_BPFTOOL	?=3D bpftool
=20
 RUSTC		?=3D rustc
=20
+# Query tools/build/Makefile.rust for a Rust library feature's CFLAGS and =
LIBS
+# (building any required staticlib such as libz_rs.a under $(RUST_OUTPUT))=
, and
+# populate FEATURE_CFLAGS-<feat> and FEATURE_LIBS-<feat>.
+define feature_rust_lib_code
+  FEATURE_RUST_OUTPUT :=3D $$(if $$(RUST_OUTPUT),$$(RUST_OUTPUT),$$(abspat=
h $$(or $$(OUTPUT),$$(CURDIR)))/)
+  FEATURE_CFLAGS-$(1) :=3D $$(shell $$(MAKE) -s --no-print-directory -f $$=
(srctree)/tools/build/Makefile.rust $$(if $$(PKG_CONFIG),PKG_CONFIG=3D"$$(P=
KG_CONFIG)") LDFLAGS=3D"$$(LDFLAGS)" $(1)-cflags)
+  FEATURE_LIBS-$(1) :=3D $$(shell $$(MAKE) -s --no-print-directory -f $$(s=
rctree)/tools/build/Makefile.rust RUST_OUTPUT=3D"$$(FEATURE_RUST_OUTPUT)" $=
$(if $$(PKG_CONFIG),PKG_CONFIG=3D"$$(PKG_CONFIG)") RUSTC=3D"$$(RUSTC)" RUST=
_FLAGS=3D"$$(RUST_FLAGS)" LDFLAGS=3D"$$(LDFLAGS)" $(1)-libs)
+endef
+feature_rust_lib =3D $(eval $(feature_rust_lib_code))
+
 ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS +=3D -Wstrict-aliasing=3D3
=20
--=20
2.56.0.313.g2479322e68-goog

