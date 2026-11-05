Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902178;
	b=Q/KyTGF3hReF8qENiP8emNN/FQxMKfzMmgGpyitfOBgcnwlsZ1Vd3uuAVo0a4PYwJcKs
	 uERFMUzNBlkuu/iyDhm7iMNjhcoVq5LGIntBZfHpGmc6XsE8+WQtUrYjEOmGXx1nrHXKp
	 7ClxYHCIlNSPt3pptRJWobgLZOMaNYY3QfdSFyBiZ7Ct10vk7w2NBzxfOLGfke/XpLkaB
	 Xg5UeRU4sF2n0GKP4B/kfpI4FITsFPt/A1PKkxlsy/E+IAPqGQkCSs3HIqobIa9QjYwgZ
	 eehZz4U9Am2rkPknLKi7gu+BTJv4wNnPgP57uWUq4b9OPgKqx864cJQjUOHWlmcjySQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=OZSdhiz0YIgaye6PEufVa/B4L/Yc043iCY3f1YH9O9c=;
	b=jS3z0+Dnwtxk8atUyBEEZVCfNOY2psBps73j86oDBamb+jzT04xI6e9SHkyD6zEMpx0Z
	 +z49KGhjBbzfGG+bRnXco3Wql9Ph76lcl0t/o7TrvUvYiy7u7ooBI/yTc36QQAdyNKA6H
	 1ImsdBDRapGYVG7MyeHFyziq/Dg48UG7UX4gg9qKakZaHzLOoKJxrHpO0vkXa1b0N/KOY
	 pmgDWBehEREiXOunYrs1+Ug9fcR3gLPfma7ynIRi7HP25UvF18ViJvEt77LFLsUY6vjq3
	 InOSOlY/Mdg8ELxa3IMvMX8G6fHl8WzSqEF4SjLf+gchJ43jnfwO61PoQlumXOVWUtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fXMH1kJP;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9369606A332
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9369606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fXMH1kJP
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36d2d353a5aso991627eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 10:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793902177; x=1794506977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OZSdhiz0YIgaye6PEufVa/B4L/Yc043iCY3f1YH9O9c=;
        b=fXMH1kJPeod4lx1NsiA4kFAT7WFsD1Xrhza4bAG0daQ6vjy7acP+SiI+bO+7SHz9Z5
         9HSonhxLnsYXmMtntU+AprijeNNICUk3Rxh5mHkP1UMF5I5hTE2LfT59VYHYX+hI0FQl
         1RWKZy9ILOYy55K+4+ClC7whjMNBzy5haOeCEYU3qWyuwZ9dxPRE/EaIIwwtpURGH0Hq
         HmraW8LALqMJ3GmOpftIv+uItXXFtEjrFOW81Ko5XobvGgouSXJXV/KdxH+ueEt0b825
         8aGer5dCjAzIQIZa0n8TToa3gm9YlJXLpFKs+9pVbKmI5LcUMKKmcD9rrNKkz/y6UVwz
         sfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793902177; x=1794506977;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZSdhiz0YIgaye6PEufVa/B4L/Yc043iCY3f1YH9O9c=;
        b=Bvh5hENb66GE68jQ3of4jMX25i0DniMAzwY20PVsa6lJCNQWGlWdnQRk99qPRdBUkC
         ngA8aFIyXhgQ8YE+ZZlwKUnEGqGp8opezDS5yOqHOWlbmTr+AGa2LGLCVm83M+h+LaHD
         RPAZLwcDoIcV9ywlAGucByrDcsNcEdSTq9/FAb++VeQaJVPvdhCqkmZPIU6qf7BGAJra
         AYCVcjOgPbM+15Sejf+qEtYXL0Tk79CKxRlM6XJGjs8LOP5uXEK+oxO6IwVk+xMRmFiV
         AQrrIjD1/6PCciweS4U/GHNLOLrwvlWxqCCHTEYGuFn29/kBl3Ma8xlFS+NYDcNNGEQL
         IlUw==
X-Forwarded-Encrypted: i=1; AKwUvBwfz4eF+Bx9Kj1IfL3+0f59cj1wu8A7EOKyHPtrvdboDOugITv8SR2xDHVAO9G6VhQWgNetjyEZPElYtQZmv3vu@vger.kernel.org
X-Gm-Message-State: APuU4Z8RXOq4Y/9MvN0boKdm0K3qzz9Nmqoe9winn1RJjgqk7hxxBFtF
	Es6TyGmXW38TaFIkQ1rwZxkj/TjSnPQt4iuDQOPIB794awcqT0BGCoeGqA/HISalfFenNkMcQ11
	6OmGcP3AI1Q==
X-Received: from dyad10.prod.google.com ([2002:a05:693c:834a:b0:369:a832:e377])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:190c:b0:361:a195:c46e
 with SMTP id 5a478bee46e88-36de39af458mr4059907eec.1.1793902176409; Thu, 05
 Nov 2026 10:09:36 -0800 (PST)
Date: Thu,  5 Nov 2026 10:09:21 -0800
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
Message-ID: <20261105180923.3441359-2-irogers@google.com>
Subject: [RFC PATCH v3 1/3] tools build: Add Rust library build infrastructure
 and zlib-rs feature test
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
Content-Transfer-Encoding: quoted-printable

Add shared Rust library build and feature detection support across tools/
and implement the zlib-rs feature check:

- Add tools/build/Makefile.rust with rules to resolve Rust library C
  compiler and linker flags via %-cflags and %-libs targets.
- Support resolving zlib-rs via LIBZ_RS_DIR, pkg-config
  (libz-rs-sys-cdylib, zlib-rs, z_rs), or building libz_rs.a into
  $(OUTPUT)libz_rs/ from the system Cargo registry
  (/usr/share/cargo/registry) using offline Cargo (cargo metadata and
  cargo build --offline).
- Pass -Wl,--exclude-libs,libz_rs.a when linking libz_rs.a so symbols
  pulled into the executable are marked HIDDEN and not exported into
  .dynsym, preventing shared libraries linked against system libz.so.1
  (such as libelf.so, libdw.so, and libcurl.so) from partially binding
  some zlib calls to the executable's libz_rs.a and others to libz.so.1.
- Add tools/build/feature/test-zlib-rs.c verifying ZLIB_VER_SUBREVISION
  =3D=3D 15 (0xf) and linking against inflateInit().
- Add RUST_TARGET_FLAGS_<arch> cross-compilation triples and the
  feature_rust_lib helper macro to tools/scripts/Makefile.include.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature       |  12 ++-
 tools/build/Makefile.rust          | 166 +++++++++++++++++++++++++++++
 tools/build/feature/.gitignore     |   1 +
 tools/build/feature/Makefile       |  11 +-
 tools/build/feature/test-zlib-rs.c |  19 ++++
 tools/scripts/Makefile.include     |  25 +++++
 6 files changed, 231 insertions(+), 3 deletions(-)
 create mode 100644 tools/build/Makefile.rust
 create mode 100644 tools/build/feature/test-zlib-rs.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 4d37d11f674c..ecf27626d493 100644
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
T=3D"$(RUST_OUTPUT)" CC=3D"$(CC)" CXX=3D"$(CXX)" CARGO=3D"$(CARGO)" RUSTC=
=3D"$(RUSTC)" $(if $(PKG_CONFIG),PKG_CONFIG=3D"$(PKG_CONFIG)") CFLAGS=3D"$(=
CLANG_CROSS_FLAGS) $(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS=
=3D"$(CLANG_CROSS_FLAGS) $(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" =
RUST_FLAGS=3D"$(RUST_FLAGS)" LDFLAGS=3D"$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-=
$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/nu=
ll && echo 1 || echo 0)
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
@@ -216,6 +220,12 @@ ifeq ($(feature-all), 1)
   $(call feature_check,compile-x32)
   $(call feature_check,bionic)
   $(call feature_check,babeltrace2-ctf-writer)
+  ifneq ($(filter zlib-rs,$(FEATURE_TESTS)),)
+    $(call feature_check,zlib-rs)
+  endif
+  ifneq ($(filter rust,$(FEATURE_TESTS)),)
+    $(call feature_check,rust)
+  endif
   $(call feature_check,libunwind)
   $(call feature_check,libunwind-debug-frame)
   $(foreach arch,$(LIBUNWIND_ARCHS),$(call feature_check,libunwind-$(arch)=
))
diff --git a/tools/build/Makefile.rust b/tools/build/Makefile.rust
new file mode 100644
index 000000000000..952aac9fc4bf
--- /dev/null
+++ b/tools/build/Makefile.rust
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Shared rules and helpers for discovering and building Rust libraries
+# (either from pre-installed packages/pkg-config or from distro Cargo
+# registry sources via offline Cargo) for tools/ builds and feature detect=
ion.
+
+ifeq ($(pound),)
+include $(dir $(lastword $(MAKEFILE_LIST)))../scripts/Makefile.include
+endif
+
+ifneq ($(CROSS_COMPILE),)
+  ifeq ($(filter --target=3D%,$(RUST_FLAGS)),)
+    ifneq ($(RUST_TARGET_FLAGS_$(ARCH)),)
+      override RUST_FLAGS +=3D --target=3D$(RUST_TARGET_FLAGS_$(ARCH))
+    endif
+  endif
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
+    override PKG_CONFIG +=3D --static
+  endif
+endif
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
+RUST_OUTPUT ?=3D $(OUTPUT)
+LIBZ_RS_OUTPUT ?=3D $(RUST_OUTPUT)libz_rs/
+
+$(LIBZ_RS_OUTPUT):
+	$(Q)mkdir -p $@
+
+# Use the system Cargo registry (e.g. /usr/share/cargo/registry from
+# Debian/Ubuntu librust-*-dev or Fedora rust-*-devel packages) offline via
+# Cargo so Cargo resolves compatible crate versions, dependency graphs,
+# features, and build scripts without touching ~/.cargo or the network.
+#
+# Upstream /usr/bin/cargo only searches crates.io by default; distros do n=
ot
+# point /usr/bin/cargo at /usr/share/cargo/registry globally because Cargo=
's
+# directory source mechanism replaces crates.io entirely, which would brea=
k
+# normal user builds. Instead, distro package builders (such as Debian's
+# /usr/share/cargo/bin/cargo wrapper and Fedora's %cargo_prep macro) confi=
gure
+# source.crates-io.replace-with to point at /usr/share/cargo/registry. We =
pass
+# the same source replacement via --config and set CARGO_HOME to a tempora=
ry
+# directory so ~/.cargo is neither read nor modified.
+CARGO_REGISTRY_DIR ?=3D /usr/share/cargo/registry
+CARGO_OFFLINE_FLAGS =3D --offline \
+	--config 'source.crates-io.replace-with=3D"system-registry"' \
+	--config 'source.system-registry.directory=3D"$(CARGO_REGISTRY_DIR)"'
+
+# cargo build takes --target=3D<triple> as a CLI flag (which also places t=
he
+# output in target/<triple>/release/) and compiler flags via RUSTFLAGS.
+# Build with -C relocation-model=3Dpic so libz_rs.a can be linked into PIE
+# binaries.
+CARGO_TARGET :=3D $(patsubst --target=3D%,%,$(firstword $(filter --target=
=3D%,$(RUST_FLAGS))))
+CARGO_RUSTFLAGS :=3D $(filter-out --target=3D%,$(RUST_FLAGS)) -C relocatio=
n-model=3Dpic
+
+# Build libz_rs.a and stage its headers into $(LIBZ_RS_OUTPUT)include/:
+# - Cargo writes Cargo.lock next to Cargo.toml, so the synthetic manifest =
and
+#   lib.rs are generated inside the writable $(LIBZ_RS_OUTPUT) directory r=
ather
+#   than in $(srctree), and removed once the build finishes (any stale
+#   Cargo.lock from an interrupted build is also removed upfront so a dist=
ro
+#   package upgrade in $(CARGO_REGISTRY_DIR) is not blocked by an old lock=
file).
+# - Enable export-symbols (unprefixed zlib C ABI symbols), c-allocator, st=
d,
+#   and gz (gzopen/gzopen64/gzread/etc.) on libz-rs-sys.
+# - Query cargo metadata for the resolved libz-rs-sys crate path so we cop=
y
+#   the matching zlib.h and zconf.h headers that Cargo selected.
+$(LIBZ_RS_OUTPUT)libz_rs.a: $(wildcard $(CARGO_REGISTRY_DIR)) | $(LIBZ_RS_=
OUTPUT)
+	$(Q){ \
+		rm -f $(LIBZ_RS_OUTPUT)Cargo.lock && \
+		printf '[package]\nname =3D "z_rs"\nversion =3D "0.1.0"\nedition =3D "20=
21"\n\n[lib]\nname =3D "z_rs"\npath =3D "lib.rs"\ncrate-type =3D ["staticli=
b"]\n\n[dependencies]\nlibz-rs-sys =3D { version =3D "*", default-features =
=3D false, features =3D ["export-symbols", "c-allocator", "std", "gz"] }\n'=
 > $(LIBZ_RS_OUTPUT)Cargo.toml && \
+		printf 'pub use libz_rs_sys::*;\n' > $(LIBZ_RS_OUTPUT)lib.rs && \
+		inc_dir=3D$$(CARGO_HOME=3D"$(LIBZ_RS_OUTPUT)cargo_home" $(CARGO) metadat=
a $(CARGO_OFFLINE_FLAGS) --format-version 1 --manifest-path $(LIBZ_RS_OUTPU=
T)Cargo.toml | sed -n 's/.*"name":"libz_rs_sys","src_path":"\([^"]*\)\/src\=
/lib\.rs".*/\1/p') && \
+		test -n "$$inc_dir" && test -d "$$inc_dir/include" && \
+		mkdir -p $(LIBZ_RS_OUTPUT)include && \
+		cp -f "$$inc_dir"/include/*.h $(LIBZ_RS_OUTPUT)include/ && \
+		CARGO_HOME=3D"$(LIBZ_RS_OUTPUT)cargo_home" RUSTC=3D"$(RUSTC)" RUSTFLAGS=
=3D"$(CARGO_RUSTFLAGS)" \
+			$(CARGO) build $(CARGO_OFFLINE_FLAGS) --release \
+			--manifest-path $(LIBZ_RS_OUTPUT)Cargo.toml \
+			--target-dir $(LIBZ_RS_OUTPUT)target \
+			$(if $(CARGO_TARGET),--target=3D$(CARGO_TARGET)) && \
+		mv -f $(LIBZ_RS_OUTPUT)target/$(if $(CARGO_TARGET),$(CARGO_TARGET)/)rele=
ase/libz_rs.a $@ && \
+		rm -rf $(LIBZ_RS_OUTPUT)Cargo.toml $(LIBZ_RS_OUTPUT)Cargo.lock \
+			$(LIBZ_RS_OUTPUT)lib.rs $(LIBZ_RS_OUTPUT)target \
+			$(LIBZ_RS_OUTPUT)cargo_home; \
+	} > $(@:.a=3D.make.output) 2>&1 || { \
+		rm -rf $(LIBZ_RS_OUTPUT)Cargo.toml $(LIBZ_RS_OUTPUT)Cargo.lock \
+			$(LIBZ_RS_OUTPUT)lib.rs $(LIBZ_RS_OUTPUT)include \
+			$(LIBZ_RS_OUTPUT)target $(LIBZ_RS_OUTPUT)cargo_home $@; \
+		false; \
+	}
+
+# Only evaluate zlib-rs pkg-config / Cargo flags when building a zlib-rs t=
arget
+# (or 'all'), avoiding unnecessary shell calls during 'clean' or unrelated
+# feature tests in tools/build/feature/Makefile.
+# Note: GNU Make's $(filter ...) only supports a single '%' wildcard per
+# pattern, so $(findstring zlib-rs,...) is used to match targets like
+# $(OUTPUT)test-zlib-rs.bin, zlib-rs-cflags, and zlib-rs-libs.
+ifneq ($(if $(MAKECMDGOALS),$(or $(findstring zlib-rs,$(MAKECMDGOALS)),$(f=
ilter all %libz_rs.a,$(MAKECMDGOALS))),all),)
+  # Resolve zlib-rs flags and libraries in priority order:
+  #   1. Explicit LIBZ_RS_DIR=3D/path/to/prefix override
+  #   2. pkg-config (libz-rs-sys-cdylib when not linking -static since it =
only
+  #      provides a shared library, zlib-rs, or z_rs)
+  #   3. System Cargo registry built via Cargo into $(LIBZ_RS_OUTPUT)libz_=
rs.a
+  #      (linked with -lpthread -ldl -lm required by the embedded Rust lib=
std)
+  ifdef LIBZ_RS_DIR
+    FEATURE_CFLAGS-zlib-rs :=3D -I$(LIBZ_RS_DIR)/include
+    FEATURE_LIBS-zlib-rs :=3D -L$(LIBZ_RS_DIR)/lib -lz_rs
+  endif
+
+  ifeq ($(FEATURE_LIBS-zlib-rs),)
+    ZLIB_RS_PC :=3D $(shell ($(if $(findstring -static,${LDFLAGS}),false,$=
(PKG_CONFIG) --exists libz-rs-sys-cdylib 2>/dev/null && echo libz-rs-sys-cd=
ylib)) || \
+                          ($(PKG_CONFIG) --exists zlib-rs 2>/dev/null && e=
cho zlib-rs) || \
+                          ($(PKG_CONFIG) --exists z_rs 2>/dev/null && echo=
 z_rs))
+    ifneq ($(ZLIB_RS_PC),)
+      FEATURE_CFLAGS-zlib-rs :=3D $(shell $(PKG_CONFIG) --cflags $(ZLIB_RS=
_PC) 2>/dev/null)
+      FEATURE_LIBS-zlib-rs :=3D $(shell $(PKG_CONFIG) --libs $(ZLIB_RS_PC)=
 2>/dev/null)
+    endif
+  endif
+
+  ifeq ($(FEATURE_LIBS-zlib-rs),)
+    ifneq ($(wildcard $(CARGO_REGISTRY_DIR)),)
+      FEATURE_CFLAGS-zlib-rs :=3D -I$(LIBZ_RS_OUTPUT)include
+      FEATURE_STATIC-zlib-rs :=3D $(LIBZ_RS_OUTPUT)libz_rs.a
+      # Pass -Wl,--exclude-libs,libz_rs.a so symbols pulled into the execu=
table
+      # from libz_rs.a are marked HIDDEN and not exported into .dynsym. Th=
at
+      # prevents shared libraries linked against system libz.so.1 (e.g.
+      # libelf.so, libdw.so, libcurl.so) from partially binding some zlib
+      # calls to the executable's libz_rs.a and others to libz.so.1.
+      FEATURE_LIBS-zlib-rs :=3D $(FEATURE_STATIC-zlib-rs) \
+        -Wl,--exclude-libs,libz_rs.a -lpthread -ldl -lm
+    endif
+  endif
+endif
+
+zlib-rs-cflags: $(FEATURE_STATIC-zlib-rs)
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
index 10340a537224..0c728531fcdc 100644
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
@@ -100,7 +101,7 @@ else
 endif
=20
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  PKG_CONFIG +=3D --static
+  override PKG_CONFIG +=3D --static
 endif
=20
 all: $(FILES)
@@ -301,6 +302,11 @@ $(OUTPUT)test-compile-x32.bin:
 $(OUTPUT)test-zlib.bin:
 	$(BUILD) -lz
=20
+include ../Makefile.rust
+
+$(OUTPUT)test-zlib-rs.bin: $(FEATURE_STATIC-zlib-rs)
+	$(BUILD) $(FEATURE_CFLAGS-zlib-rs) $(FEATURE_LIBS-zlib-rs)
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
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.includ=
e
index 378387f62960..7089e9ce64c7 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -109,8 +109,33 @@ CC_NO_CLANG :=3D $(shell if command -v $(firstword $(C=
C)) >/dev/null 2>&1; then $(
 # Some tools require bpftool
 SYSTEM_BPFTOOL	?=3D bpftool
=20
+CARGO		?=3D cargo
 RUSTC		?=3D rustc
=20
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
+
+# Query tools/build/Makefile.rust for a Rust library feature's CFLAGS and =
LIBS
+# (building any required staticlib such as libz_rs.a under $(RUST_OUTPUT))=
, and
+# populate FEATURE_CFLAGS-<feat> and FEATURE_LIBS-<feat>.
+define feature_rust_lib_code
+  RUST_OUTPUT ?=3D $$(abspath $$(or $$(OUTPUT),$$(CURDIR)))/
+  FEATURE_CFLAGS-$(1) :=3D $$(shell $$(MAKE) -s --no-print-directory -f $$=
(srctree)/tools/build/Makefile.rust RUST_OUTPUT=3D"$$(RUST_OUTPUT)" $$(if $=
$(PKG_CONFIG),PKG_CONFIG=3D"$$(PKG_CONFIG)") CARGO=3D"$$(CARGO)" RUSTC=3D"$=
$(RUSTC)" RUST_FLAGS=3D"$$(RUST_FLAGS)" LDFLAGS=3D"$$(LDFLAGS)" $(1)-cflags=
)
+  FEATURE_LIBS-$(1) :=3D $$(shell $$(MAKE) -s --no-print-directory -f $$(s=
rctree)/tools/build/Makefile.rust RUST_OUTPUT=3D"$$(RUST_OUTPUT)" $$(if $$(=
PKG_CONFIG),PKG_CONFIG=3D"$$(PKG_CONFIG)") CARGO=3D"$$(CARGO)" RUSTC=3D"$$(=
RUSTC)" RUST_FLAGS=3D"$$(RUST_FLAGS)" LDFLAGS=3D"$$(LDFLAGS)" $(1)-libs)
+endef
+feature_rust_lib =3D $(eval $(feature_rust_lib_code))
+
 ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS +=3D -Wstrict-aliasing=3D3
=20
--=20
2.56.0.455.g6c5a503b38-goog

