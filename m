Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902175;
	b=okVXtof5VXZwT4m4jWktAU37aM3nb8w7I++P02VspxHqHx7KJc5bICXOgwdsJ5A7xHmS
	 s2ulHmu5H0k/WW6vJ0hc1LViliF8WM/6L9YmIWL6SgCfNzhQiLHxgF35ivQtLeXgWDkw2
	 rkWbLrgJ6YMdMwJ4n7wzzHVfjaQtDWhWmYhNhmwWDQLRv+4a3QjA3rbw7lODh6dSCswH2
	 EnjoLCktZXxhRKNmUPNRaHJ+lDzNXik8RHl1xdAGnTx0RaoRNsQCTfTegmH03bcmd2nIV
	 sJrtc11dvqi6mEJIRX+4pOcS7ofzr6Vd40MZTEU0swm+TlH4RrwCWeVfKlycvwMdbAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=hyEMTXGlXQpHKX5Ty3jrfbcgGJw6svasXSAdGSCcGeQ=;
	b=HPQpbEqAUkl8ZXRwUqDMbi+IVkUGxnrJhcyNleyjmifJDdJaf/63djv1YzDM77mYOfEB
	 rmTPhJDFy9NGGHlNq9ZUJ2+RJBdbDMyqQi8mbtMPY8eydXk1CLGX5bWf0560Vhai/e+3y
	 GosoO1YkR+pzMyiRrPDtAgJNjlmsDHvAuQBUiH5wSYkkHmyGea3EqWlYSbE6W+FsyjBcH
	 Bg0H0VKk2DRb13g5xb3w1IjhlMOpiKZ/+iG+j5TLb+nRStwON6O5nO0OT9goX1+mJVmuj
	 6SE3/VzSSFChc/dtO9WzZ5UZfZRsf5NFdLG783qrgVqBy5xXpWOgb+m1g8jY/TjqevA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Faim47kD;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2782B606A333
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2782B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Faim47kD
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-547ae874949so3044968b6e.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 10:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793902174; x=1794506974; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hyEMTXGlXQpHKX5Ty3jrfbcgGJw6svasXSAdGSCcGeQ=;
        b=Faim47kD2ako1mZSfGUeBWrcbr5L7ZI+etyanYgpEpjc8fNJjxlOnJtg5tUcndOItw
         xxVPTSR6de1Xum0j+QDOq/AywjrEpYgDL8Te0C3rwTJT3o8lp24oXl5PxNSimFCHK6tc
         f/CrRqcPGSlR6tT3ehJJziiMrNTEnLDYNbS8xuerVd55mJDqROhpmh0uwcNKgH2l03Sx
         jkkUOfDzJ7xuAnKKRUWrP5RPE/x2weFaTXkJVMCLaw0+hx/mu3C6DwtOdWv4mQuG1cQv
         L/wfv+jD9beRPGEoTXy+iHErS5SzyHgYBMq2kObwIuEsdaJN9OByHujBc957fYVJai6M
         YDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793902174; x=1794506974;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hyEMTXGlXQpHKX5Ty3jrfbcgGJw6svasXSAdGSCcGeQ=;
        b=CClLswV0/nNr+9wiyNloQ+FrOVAVSVJ7n65XnPzZZB2amJPLPUCAerbZfHagBlF1Re
         XeZUrtC7irn849gcch8j/zvvDL5h1HasJIs/ZRflP5AiDWJQWqF91pS87udH3eIUn6B2
         GoKbq0OTM6iuReLI/wBFEEzN4qRvtJ7TgW5tH9izAqQqKgMUpN13dHbRgZJnhEF5S9xf
         +xFkhYMW16yqTq7HVvAQI5rPKkMkgQOqQ6+IUG1vbrLXQ0HKCiZ275jw2fCh0qHea2vp
         tL/v5R28W+E2r+y/YKTWabnqmoFEWPrc4ovDrRMucp++Mnx8LYbxM2VKKH0ZbSVyyFyI
         WrSw==
X-Forwarded-Encrypted: i=1; AKwUvBxHE1f53Q4XFCpqhFqlceDdlJn2QwE4aHOUee9i+V9P4W/qdCWRV9QMFNQUxadn1mmBrDpHT+1PC4I/f34wNBef@vger.kernel.org
X-Gm-Message-State: APuU4Z/2jdOsD1pODLQoXnHQV0fKFUdOZksm4tPm+drjIHyzEjrX3kdR
	INDHlp+3unumNXQIE+tqF4aqkgJTrmtzO9Tyn1zYHjGN8OzrwdRhn6dtcxzWoCMNjPlM7vItpSW
	OeupLIIe36g==
X-Received: from oaqy28-n1.prod.google.com ([2002:a05:6871:2dc:10b0:49e:13a7:3e26])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:1997:b0:4f5:d3bf:edf3
 with SMTP id 5614622812f47-5640e035525mr15913367b6e.59.1793902173705; Thu, 05
 Nov 2026 10:09:33 -0800 (PST)
Date: Thu,  5 Nov 2026 10:09:20 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261105180923.3441359-1-irogers@google.com>
Subject: [RFC PATCH v3 0/3] tools: Add Rust library build infrastructure and
 prefer zlib-rs
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

The zlib-rs project (https://github.com/trifectatechfoundation/zlib-rs)
provides a memory-safe, high-performance Rust implementation of the zlib
compression specification along with a C ABI layer (libz-rs-sys) that is a
drop-in replacement for the standard C zlib library. Transitioning
decompression of kernel configuration files (/proc/config.gz), compressed
ELF/BTF sections, and perf data from C zlib to zlib-rs improves both memory
safety and decompression performance.

On many Linux distributions (such as Debian, Ubuntu, and Fedora), Rust
crates like zlib-rs and libz-rs-sys are packaged as Cargo registry sources
under /usr/share/cargo/registry/ (e.g. librust-libz-rs-sys-dev or
rust-libz-rs-sys-devel) rather than as prebuilt C shared libraries, while
other environments may install prebuilt libz_rs libraries via pkg-config or
a custom prefix (LIBZ_RS_DIR).

This RFC series lays the groundwork for building and linking Rust crate
libraries in tools/ offline from the system Cargo registry and integrates
zlib-rs support into perf and bpftool, preferring zlib-rs over C zlib when
available:

1. **tools build: Add Rust library build infrastructure and zlib-rs feature test**:
   - Adds `tools/build/Makefile.rust` with helpers to resolve C compiler and
     linker flags for Rust libraries via `%-cflags` and `%-libs` targets.
   - Resolves `zlib-rs` compiler and linker flags via `LIBZ_RS_DIR`,
     `pkg-config` (`libz-rs-sys-cdylib`, `zlib-rs`, `z_rs`), or building
     `libz_rs.a` (with the `export-symbols`, `c-allocator`, `std`, and `gz`
     features) into `$(OUTPUT)libz_rs/` from `/usr/share/cargo/registry`
     using offline Cargo (`cargo metadata --offline` and
     `cargo build --offline`).
   - Passes `-Wl,--exclude-libs,libz_rs.a` when linking `libz_rs.a` so
     symbols pulled into the executable are marked `HIDDEN` and not exported
     into `.dynsym`, preventing shared libraries linked against system
     `libz.so.1` (`libelf.so`, `libdw.so`, `libcurl.so`, etc.) from
     partially binding some `zlib` calls to the executable's `libz_rs.a` and
     others to `libz.so.1`.
   - Adds `tools/build/feature/test-zlib-rs.c` checking
     `ZLIB_VER_SUBREVISION == 15` (`0xf`, which distinguishes
     `libz-rs-sys`'s `zlib.h` from standard C `zlib.h`) and linking against
     `inflateInit()`.
   - Extends `tools/scripts/Makefile.include` with cross-compilation target
     triples (`RUST_TARGET_FLAGS_<arch>`) and the `feature_rust_lib` macro.

2. **perf build: Prefer zlib-rs over zlib when available**:
   - Moves Rust detection ahead of zlib detection in
     `tools/perf/Makefile.config` and prefers `zlib-rs` over C `zlib` unless
     `NO_ZLIB_RS=1` (or `NO_ZLIB=1` / `NO_RUST=1`) is set.
   - Replaces `-lz` with `$(or $(ZLIB_LIBS),-lz)` in `DWARFLIBS`,
     `libbfd-liberty-z`, and `llvm-config --system-libs` so static
     `libdw`/`libelf`, `libbfd`, and `libLLVM` builds use the selected
     `zlib` implementation while falling back to `-lz` if `NO_ZLIB=1`
     disables `perf`'s direct zlib support.
   - Defines both `HAVE_ZLIB_SUPPORT` and `HAVE_ZLIB_RS_SUPPORT` when
     `zlib-rs` is used so existing zlib call sites in `perf` work unchanged
     while `perf version --build-options` and `perf check feature zlib-rs`
     report whether `zlib-rs` is active.
   - Shares `$(OUTPUT)libz_rs/` with the host bootstrap `bpftool` build in
     `tools/perf/bpf_skel.mak` and adds `NO_ZLIB` / `NO_ZLIB_RS` tests to
     `tools/perf/tests/make`.

3. **bpftool: Prefer zlib-rs over zlib when available**:
   - Adds `zlib-rs` and `zlib` to `FEATURE_TESTS` and `FEATURE_DISPLAY` in
     `tools/bpf/bpftool/Makefile`, configures `ZLIB_CFLAGS` and
     `ZLIB_LIBS` via `feature_rust_lib` when `zlib-rs` is detected, and
     replaces `-lz` with `$(ZLIB_LIBS)` in static `llvm-config --system-libs`.

Changes in v3:
- Pass `-Wl,--exclude-libs,libz_rs.a` in `FEATURE_LIBS-zlib-rs` so symbols
  pulled into the executable from `libz_rs.a` are given `HIDDEN` visibility
  and excluded from `.dynsym`, preventing shared libraries linked against
  system `libz.so.1` from partially binding some `zlib` symbols to the
  executable's `libz_rs.a` and others to `libz.so.1` (Quentin Monnet).
- Replace `-lz` with `$(or $(ZLIB_LIBS),-lz)` / `$(ZLIB_LIBS)` in
  `DWARFLIBS`, `libbfd-liberty-z`, and `$(LLVM_CONFIG) --system-libs` in
  `tools/perf/Makefile.config` and `tools/bpf/bpftool/Makefile` so static
  `libLLVM` and `libdw`/`libelf`/`libbfd` builds do not link `-lz` alongside
  `zlib-rs` while preserving `-lz` for dependent libraries under `NO_ZLIB=1`
  (Quentin Monnet, Sashiko).
- Expand comments in `tools/build/Makefile.rust` explaining why
  `CARGO_REGISTRY_DIR` (`source.crates-io.replace-with`) and removing stale
  `Cargo.lock` before `cargo metadata --offline` are required.
- Rebase onto `perf-tools-next` (`v7.4-rc1`).

Changes in v2:
- Use offline Cargo (`cargo metadata --offline` and `cargo build --offline`
  configured against `CARGO_REGISTRY_DIR` = `/usr/share/cargo/registry` and
  isolated from `~/.cargo`) to resolve crate versions, dependency graphs,
  features, and build scripts instead of manually globbing crate directory
  names and invoking `rustc` on hardcoded `.rlib` edges (Miguel Ojeda).
- Avoid including `../../scripts/Makefile.arch` in `tools/bpf/bpftool/Makefile`
  (to keep the standalone bpftool mirror self-contained) by placing
  `RUST_TARGET_FLAGS_<arch>` in `tools/scripts/Makefile.include`, and expand
  the bpftool commit message on the security and performance motivation for
  preferring `zlib-rs` (Quentin Monnet).
- Drop unused `.rlib` pattern rules and helpers from `tools/build/Build.include`
  and `tools/build/Makefile.build` (Sashiko).
- Address Sashiko review feedback on `PKG_CONFIG` handling when unset or with
  `-static`, `test-all.bin` re-checking `zlib-rs` and `rust`, preserving
  `EXTRA_CFLAGS` optimization defaults when building `libbpf.a`, and
  honoring `NO_ZLIB_RS=1` in `bpftool` when `FEATURES_DUMP` is used.

AI Assistance Disclosure (per Documentation/process/coding-assistants.rst
and Documentation/process/generated-content.rst):
- Tools used: Antigravity coding assistant and Sashiko automated patch
  review using Gemini 4 LLMs.
- Summary of prompts and assistance: Interactive pair-programming session to
  identify distro packaging for zlib-rs/libz-rs-sys, implement the zlib-rs
  feature test and offline Cargo build rules in Makefile.rust, integrate
  zlib-rs detection into perf and bpftool, isolate `libz_rs.a` symbols with
  `-Wl,--exclude-libs,libz_rs.a` and ensure static library flag consistency,
  and address reviewer and automated Sashiko feedback.
- Testing performed: Built and tested perf and bpftool with zlib-rs
  (default), NO_ZLIB_RS=1 (fallback to C zlib), NO_ZLIB=1, and MINIMAL=1;
  verified with `readelf --dyn-syms` and `LD_BIND_NOW=1 LD_DEBUG=bindings`
  that `libz_rs.a` symbols are not exported in `.dynsym`; verified
  `perf version --build-options`, `perf check feature`, and the
  `make_no_zlib` / `make_no_zlib_rs` tests in `tools/perf/tests/make`; and
  checked all commits with `scripts/checkpatch.pl`.

Ian Rogers (3):
  tools build: Add Rust library build infrastructure and zlib-rs feature
    test
  perf build: Prefer zlib-rs over zlib when available
  bpftool: Prefer zlib-rs over zlib when available

 tools/bpf/bpftool/.gitignore             |   1 +
 tools/bpf/bpftool/Makefile               |  59 +++++++-
 tools/build/Makefile.feature             |  12 +-
 tools/build/Makefile.rust                | 166 +++++++++++++++++++++++
 tools/build/feature/.gitignore           |   1 +
 tools/build/feature/Makefile             |  11 +-
 tools/build/feature/test-zlib-rs.c       |  19 +++
 tools/perf/.gitignore                    |   1 +
 tools/perf/Documentation/perf-check.txt  |   1 +
 tools/perf/Makefile.config               |  92 +++++++------
 tools/perf/Makefile.perf                 |  32 ++++-
 tools/perf/bpf_skel.mak                  |   8 +-
 tools/perf/builtin-check.c               |   1 +
 tools/perf/scripts/install-build-deps.sh |   6 +
 tools/perf/tests/make                    |   9 ++
 tools/scripts/Makefile.include           |  25 ++++
 16 files changed, 391 insertions(+), 53 deletions(-)
 create mode 100644 tools/build/Makefile.rust
 create mode 100644 tools/build/feature/test-zlib-rs.c

-- 
2.56.0.455.g6c5a503b38-goog

