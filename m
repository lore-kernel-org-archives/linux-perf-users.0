Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04322E2840;
	Tue, 11 Aug 2026 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786409246; cv=none; b=VXXY6IXBYsWf6Npejg9krY5pWKyeq5lKXJyg+0+IJWzWT9vuLqSABhtZJJ1CTxtUHSeJBsKVVmSTdvlJmdggiDynyYPGZx4S8AqtBu3E0U4YoaOj2zmX2R0ZarxZMrxWVcRRrsm1oepIQg8ZT+aq9Tz9msIZsmKIbiG+kykagNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786409246; c=relaxed/simple;
	bh=XOpgP8cUpoA9e2myfj8o+oDG2oxcdx5FGngV0CVfwz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4KQy73M6PFqdYgTvkmpcwR0A7diroF4Aw8e+T3nxyj9cG4WEg6g336l7wpYsrVd64J6ZtxDy+krOwWZ9PLvM+vwIMkDrhOZCi7IxlV8C/VH2BP6xDkWE+beink7iAPauvqLOqpF1Kqw05CtOsSUE81RKzJvPMYAbWWhUnYXbAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH5HkMOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH5HkMOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26651F00A3A;
	Tue, 11 Aug 2026 00:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786409244;
	bh=DYbNPimL5xAYm3VKkoZbAOPtQTNO9hj32x6Hkv/fEis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UH5HkMOPYCR3ix5vsM/+WKe1gbMnEIr203qSEXZVHWKklJ974KR5s30kV3StvUHLn
	 s9esHVuRDi3CNVI6eDKUw+tFTo4c81d7glBJ1n+YuiN2/DkouBFzr1391J9GWkwTok
	 dNltGlMxj/ZeiyqeQGgPGq9H2UniIo94kmTTxgvmRBMlu3/48YIbmjlHvmUg9Lzgre
	 h+HE+4q76wEvD+waNiIl9hv5QH9m/aKXbJ8ZmZHjpeCGz45Z9uWRngqprkang080rr
	 X9zpPhHetR0yIhxnJrKLy3zTHkRo3T9vJxVvsKxWggGs94PwOOJSiz+T3Ny+QL4SrU
	 7oWmvDxzjoTOA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/7] perf build: install-build-deps: add Fedora devel package mapping
Date: Mon, 10 Aug 2026 21:46:55 -0300
Message-ID: <20260811004659.6212-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811004659.6212-1-acme@kernel.org>
References: <20260811004659.6212-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With the framework from the previous commit in place, this patch adds
the per-feature mapping for Fedora/dnf: for each feature test in
tools/build/feature/, the Fedora devel package providing the headers
or library the test compiles against, kept explicit in the script
next to the test that requires it.

Special cases:

  - test-libdebuginfod.c includes <elfutils/debuginfod.h>, provided
    by elfutils-debuginfod-client-devel, not elfutils-devel;
  - the cxa-demangle test links against libstdc++'s builtin demangler,
    pulling in libstdc++-devel;
  - the BPF-oriented features (bpf, clang-bpf-co-re) get their headers
    from the base packages and clang-devel.

Tests with no Fedora equivalent (bionic, compile-32, compile-x32) and
the opt-in/deprecated ones (libbfd disassembler family, GTK2, LIBPERL,
LIBUNWIND, CoreSight, and the tests perf itself doesn't check, like
libcpupower) are deliberately not mapped.

Validated on a fresh Fedora 44 toolbx container, so the host OS is not
modified:

    toolbox create fedora:44
    toolbox enter fedora:44
    make -C tools/perf install-build-deps

which installed the 29 mapped packages; a subsequent clean O= build
enabled every feature with an external dependency Fedora provides
(feature tests went to 1, except bionic/compile-32/compile-x32, which
have no Fedora equivalent, and the libunwind-debug-frame tests, whose
symbols Fedora's libunwind does not export), linking libpfm,
libbabeltrace2-ctf-writer, libcapstone, libtraceevent, libslang and
libnuma, as well as building the BPF skeletons requiring clang/llvm.
Re-running the target is a no-op (dnf reports "Nothing to do").

RHEL and its derivatives share most Fedora package names but are
refused by the script until this mapping is validated on them.

Example of its --list option:

  $ grep PRETTY_NAME /etc/os-release
  PRETTY_NAME="Fedora Linux 44 (Toolbx Container Image)"
  $ tools/perf/scripts/install-build-deps.sh --list
  bison
  capstone-devel
  clang-devel
  elfutils-debuginfod-client-devel
  elfutils-devel
  elfutils-libelf-devel
  flex
  gcc
  gcc-c++
  glibc-devel
  java-latest-openjdk-devel
  kernel-headers
  libbabeltrace2-devel
  libbpf-devel
  libpfm-devel
  libstdc++-devel
  libtraceevent-devel
  libzstd-devel
  llvm-devel
  make
  numactl-devel
  openssl-devel
  python3-devel
  python3-setuptools
  rust
  slang-devel
  systemtap-sdt-devel
  xz-devel
  zlib-devel
  $

Assisted-by: opencode:deepseek-v4-flash-free
Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/install-build-deps.sh | 179 ++++++++++++++++++++---
 1 file changed, 156 insertions(+), 23 deletions(-)

diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/scripts/install-build-deps.sh
index 351fdd581e56dd7c..d09a5cdd4e7f5a63 100755
--- a/tools/perf/scripts/install-build-deps.sh
+++ b/tools/perf/scripts/install-build-deps.sh
@@ -13,10 +13,13 @@
 # that provides the headers/libraries it checks, so that a subsequent
 # 'make -C tools/perf' build enables the corresponding perf features.
 #
-# This initial version installs the base toolchain needed by any build;
-# the per-feature package mapping is added, per supported distro, by the
-# follow-up patches in this series, which also validate each mapping in a
-# fresh container, so the host system is not modified.
+# Supported distros, each mapping validated in a fresh container, so the
+# host system is not modified:
+#
+#   - Fedora, on dnf, validated on Fedora 44, in a toolbx container:
+#
+#           toolbox create fedora:44
+#           toolbox enter fedora:44
 #
 # Usage: install-build-deps.sh [OPTIONS]
 #
@@ -24,7 +27,7 @@
 #    --list       list the packages that would be installed, then exit
 #    --dry-run    show the install command that would be run, without
 #                 running it
-#    --distro ID  force a distro: fedora, ubuntu (default: auto-detect)
+#    --distro ID  force a distro: fedora (default: auto-detect)
 #    -h, --help   print this help message
 #
 # Requires root (or passwordless sudo) to actually install packages.
@@ -39,20 +42,121 @@ Usage: $(basename "$0") [--list] [--dry-run] [--distro ID] [-h|--help]
 
 Install the development packages needed to build tools/perf.
 
+The package set is derived from the feature tests in tools/build/feature/,
+mapping each one with an external dependency to the devel package providing
+it, so the corresponding feature gets enabled on a build.
+
 Options:
     --list      list the packages that would be installed, then exit
     --dry-run   show the install command that would be run, without running it
-    --distro ID force a distro: fedora, ubuntu
+    --distro ID force a distro: fedora
     -h, --help  print this help message
+
+Distro supported: Fedora (dnf), validated on a fresh Fedora 44 toolbx
+container.
 EOF
 	exit 0
 }
 
 # ---------------------------------------------------------------------
-# Distro detection.  The install command that follows only differs in
-# the package manager, which here is keyed off the distro ID; the
-# per-feature package mapping is added per distro by the follow-up
-# patches.
+# Return the Fedora package(s) providing the devel requirements of a
+# feature test in tools/build/feature/.  Multiple packages are separated
+# by spaces; an empty result means the test has no external devel
+# dependency (pure toolchain/glibc, or no equivalent Fedora package).
+#
+# The mapping was built by checking, for each feature test, which Fedora
+# devel package provides the headers the test compiles against.
+# ---------------------------------------------------------------------
+fedora_pkg_for() {
+	local feat="$1"
+	case "$feat" in
+	libelf|libelf-getphdrnum|libelf-gelf_getnote|libelf-getshdrstrndx)
+		echo "elfutils-libelf-devel"
+		;;
+	libelf-zstd)
+		echo "elfutils-libelf-devel libzstd-devel"
+		;;
+	libdw)
+		echo "elfutils-devel"
+		;;
+	# test-libdebuginfod.c includes <elfutils/debuginfod.h>, which is
+	# provided by elfutils-debuginfod-client-devel, not elfutils-devel.
+	libdebuginfod)
+		echo "elfutils-debuginfod-client-devel"
+		;;
+	libnuma|numa_num_possible_cpus)
+		echo "numactl-devel"
+		;;
+	libzstd)
+		echo "libzstd-devel"
+		;;
+	zlib)
+		echo "zlib-devel"
+		;;
+	lzma)
+		echo "xz-devel"
+		;;
+	libslang)
+		echo "slang-devel"
+		;;
+	libcapstone)
+		echo "capstone-devel"
+		;;
+	libpython)
+		echo "python3-devel"
+		;;
+	libtraceevent)
+		echo "libtraceevent-devel"
+		;;
+	cxa-demangle)
+		echo "libstdc++-devel"
+		;;
+	libbpf)
+		echo "libbpf-devel"
+		;;
+	babeltrace2-ctf-writer)
+		echo "libbabeltrace2-devel"
+		;;
+	libopenssl)
+		echo "openssl-devel"
+		;;
+	libpfm4)
+		echo "libpfm-devel"
+		;;
+	sdt)
+		echo "systemtap-sdt-devel"
+		;;
+	clang-bpf-co-re)
+		echo "clang-devel"
+		;;
+	llvm|llvm-perf)
+		echo "llvm-devel"
+		;;
+	jvmti|jvmti-cmlr)
+		echo "java-latest-openjdk-devel"
+		;;
+	esac
+	# Pure toolchain/libc features (backtrace, eventfd, fortify-source,
+	# gettid, glibc, hello, reallocarray, pthread-*, stackprotector-all,
+	# timerfd, scandirat, sched_getcpu, setns, file-handle,
+	# bionic...) need no external package: their
+	# requirements are covered by the base packages below.  Features that
+	# perf's own build does not check (libcap, libcheck, libcpupower,
+	# libtracefs, whose feature tests exist for rtla/bpftool/rv) and the
+	# opt-in features, which a default build does not enable: the libbfd
+	# disassembler family (libbfd, libbfd-threadsafe, libbfd-liberty,
+	# disassembler-*, cplus-demangle), only linked on BUILD_NONDISTRO
+	# builds and deprecated in favor of capstone, GTK2, LIBPERL and
+	# LIBUNWIND support (ifdef GTK2 / ifdef LIBPERL / LIBUNWIND=1),
+	# and CoreSight (ifdef CORESIGHT), are deliberately not mapped.
+	# libaio is not mapped either: its
+	# test uses the POSIX AIO API (aio.h, aio_*, -lrt), provided by
+	# glibc headers (pulled in by the glibc-devel base package), not
+	# the native libaio.h/io_submit API that libaio-devel provides.
+}
+
+# ---------------------------------------------------------------------
+# Distro detection
 # ---------------------------------------------------------------------
 detect_distro() {
 	if [ -n "$DISTRO" ]; then
@@ -71,30 +175,58 @@ detect_distro() {
 	esac
 }
 
-# Base packages needed by any perf build, regardless of feature tests:
+# ---------------------------------------------------------------------
+# Feature test enumeration: mirror of the tests checked during a build,
+# from the actual test-*.c / test-*.cpp sources in tools/build/feature/.
+# ---------------------------------------------------------------------
+feature_tests() {
+	local srcdir="$1"
+	local f
+	for f in "$srcdir"/tools/build/feature/test-*.c "$srcdir"/tools/build/feature/test-*.cpp; do
+		[ -e "$f" ] || continue
+		basename "$f" | sed -e 's/^test-//' -e 's/\.\(c\|cpp\)$//'
+	done
+}
+
+# Base packages needed by any build, regardless of feature tests:
 # compiler, libc headers, flex/bison for the parser, kernel headers
 # for UAPI headers with no in-tree copy, e.g. <linux/capability.h>, and
-# gcc-c++ (dnf) / g++ (apt) for the C++-based feature tests
-# (cxa-demangle, llvm, llvm-perf), compiled with $(CXX), and
-# pulls in libstdc++-devel / libstdc++-*-dev.
-# python3-setuptools is needed to build the python binding (perf's
-# util/setup.py uses it; without it binding is skipped with a warning).
-# rust is not a header-based feature test: test-rust.bin just checks
-# "$(RUSTC) --version" (tools/build/feature/Makefile), so it is mapped
-# here like the other toolchain packages.
+# gcc-c++ is needed by the C++-based feature tests (cxa-demangle, llvm,
+# llvm-perf), which are compiled with $(CXX), pulling in
+# libstdc++-devel.  python3-setuptools is needed to build the python
+# (perf's util/setup.py uses it); rust is checked by the rust feature
+# test (test-rust.bin just runs "$(RUSTC) --version").
+
 fedora_base_pkgs="gcc gcc-c++ make flex bison glibc-devel kernel-headers python3-setuptools rust"
 debian_base_pkgs="gcc g++ make flex bison libc6-dev linux-libc-dev python3-setuptools rustc"
 
 # ---------------------------------------------------------------------
-# Assemble the unique package list.  While the per-feature mapping is
-# being added per distro, only the base toolchain above is installed.
+# Assemble the unique package list: the base toolchain plus, for each
+# feature test the distro's package mapping knows about, its package(s).
+# Installing an already-present package is a no-op for both dnf and
+# apt-get, making this idempotent.
 # ---------------------------------------------------------------------
 package_set() {
 	local distro="$1" srcdir="$2"
+	local feat pkg pkgs
+
 	case "$distro" in
-	fedora)	echo "$fedora_base_pkgs" ;;
-	ubuntu)	echo "$debian_base_pkgs" ;;
+	fedora)	pkgs="$fedora_base_pkgs" ;;
+	ubuntu)	pkgs="$debian_base_pkgs" ;;
 	esac
+
+	if [ "$distro" = "fedora" ]; then
+		for feat in $(feature_tests "$srcdir"); do
+			pkg=$(fedora_pkg_for "$feat")
+			for pkg in $pkg; do
+				case " $pkgs " in
+				*" $pkg "*) ;;
+				*) pkgs="$pkgs $pkg" ;;
+				esac
+			done
+		done
+	fi
+	echo "$pkgs"
 }
 
 # ---------------------------------------------------------------------
@@ -139,6 +271,7 @@ main() {
 	fedora|ubuntu) ;;
 	*)
 		echo "error: unsupported distro (got '$distro'); the package mapping is not validated on other distros." >&2
+		echo "Supported and validated: Fedora 44 (fresh toolbx container)." >&2
 		exit 1
 		;;
 	esac
-- 
2.55.0

