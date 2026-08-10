Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F241D63C;
	Mon, 10 Aug 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376707; cv=none; b=qYZgYmGvfAg/3qRY+iI7PDK1KsoCF+ZW/zqlBN0YEWZrlM97110dYbeu21ray1Q31xTr3U086XalKlPlkgQnIFl7y8qj+R7n1SBuPBnuArhLA4NXMXGsJpG6Rh6t55sIgna7jjXWBrWrLZcEOY+s20RMOqZLsCOwkEDyPLH2f7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376707; c=relaxed/simple;
	bh=xfLt1HwOQG+8nUoyUBgTZ/S9PL1vL4k8QGCoxUuRHWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxunxK6rZ18Rrl2NGktUbQl0Cc9ik6uxA/sEU/kp7LNEWDbIyGYRF7zPGbF2qvp889fCc60XEwYgVD1FMtrVKnhu+rrFdcItwDOnSewRsKK7eQaaEVm1z79jxkCjekKuLlkUrXoIgg+y2DfxlEEmfSeyTbMGjtEpFtOX/S/deiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdY7I1dH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdY7I1dH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC221F000E9;
	Mon, 10 Aug 2026 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786376704;
	bh=eo9P2cQSR3YvJOioSA6GD8s539D0sYRy7AlV2PpGKpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TdY7I1dHUYFmW0Tu+hdYX3hTOJQpA6OPRjTjK8nJVvt5z+h2Ox3PYgAt3TfHsQ9WH
	 kmcJfhdyGOBEXwwK27gdF5HY4DFLzRcOe21794o7s6ZJcnGdhhfrpQfWAs1jjVFns0
	 jKpaxEc+0DR2oz3Zaqb9Z+QwR40ZcUm1sMaaCZzlVtiTVvvEZDjGvf/Hl7T8uESM8J
	 TSqueHvh+z7OqcbaIvzPB/sOoGPEC4QhSJsztpPg2zpDnE32x8xGRKN3Mr4bYdBEBE
	 21S2mnfALGFxUxnfRej3rmD+PLojthnSc5RljwJztaTCoGoxsCgQlmyHQCZSklZcVS
	 fivpRMXMn/AmQ==
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
Subject: [PATCH 4/7] perf build: install-build-deps: add Ubuntu devel package mapping
Date: Mon, 10 Aug 2026 12:44:34 -0300
Message-ID: <20260810154437.15946-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810154437.15946-1-acme@kernel.org>
References: <20260810154437.15946-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With the framework and Fedora mapping in place, this patch adds the
Ubuntu (apt) mapping: same feature-to-package correspondence as the
Fedora one, adapted to Debian packaging conventions (libfoo-dev), on
a per-distro dispatch so future distros can pick their own mapping or
reuse one of these (Debian shares the Ubuntu mapping).

Notable differences from Fedora:

  - base set: g++ (ships libstdc++-*-dev, covering cxa-demangle),
    pkg-config (installed implicitly by Fedora's default toolchain
    metapackage, but not by Ubuntu's), linux-libc-dev and libc6-dev
    instead of kernel-headers and glibc-devel, and rustc for rust;
  - cxa-demangle maps to nothing, covered by g++'s libstdc++;
  - the clang-bpf-co-re test needs the clang compiler binary (Fedora's
    clang-devel provides it transitively), and llvm-dev, which also
    brings llvm-config (deps on the llvm package), used by the
    llvm/llvm-perf tests;
  - libslang maps to libslang2-dev and jvmti to default-jdk;
  - the install command runs 'apt-get update' first since a fresh
    container has no package indexes, unlike dnf.

Validated on a fresh Ubuntu 26.04 distrobox container so the host
system is not modified:

    distrobox create --image ubuntu:26.04
    distrobox enter ubuntu-26-04
    make -C tools/perf install-build-deps

which installed the 29 mapped packages; a subsequent clean O= build
enabled every feature with an external dependency Ubuntu has a
package for: perf's build-options then showed all of them [on],
including the BPF skeletons requiring clang/llvm, the python binding
and the C++-based features, with only the deliberately unmapped
(deprecated) libbfd family, libperl and libunwind [OFF], and the
build linked libpfm, libbabeltrace2-ctf-writer, libcapstone,
libtraceevent, libslang, libnuma, libdw and libssl.  Re-running the
target is a no-op (apt-get reports "0 newly installed").

Debian (trixie) is the next planned distro: it shares this Ubuntu
mapping, so enabling it reuses it as-is, once it gets validated on a
Debian release.

Example of its --list:

  $ grep PRETTY_NAME /etc/os-release
  PRETTY_NAME="Fedora Linux 44 (Toolbx Container Image)"
  $ tools/perf/scripts/install-build-deps.sh --list --distro ubuntu
  bison
  clang
  default-jdk
  flex
  g++
  gcc
  libbabeltrace2-dev
  libbpf-dev
  libc6-dev
  libcapstone-dev
  libdebuginfod-dev
  libdw-dev
  libelf-dev
  liblzma-dev
  libnuma-dev
  libpfm4-dev
  libslang2-dev
  libssl-dev
  libtraceevent-dev
  libzstd-dev
  linux-libc-dev
  llvm-dev
  make
  pkg-config
  python3-dev
  python3-setuptools
  rustc
  systemtap-sdt-dev
  zlib1g-dev
  $

Assisted-by: opencode:deepseek-v4-flash-free
Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                 |   6 +-
 tools/perf/scripts/install-build-deps.sh | 178 ++++++++++++++++++-----
 2 files changed, 145 insertions(+), 39 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 49a58d714e42dded..e1fc75b4621faed5 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -899,9 +899,9 @@ install-bin: install-tools install-tests
 install: install-bin try-install-man
 
 # Install the development packages needed to build perf, derived from the
-# feature tests in tools/build/feature/.  This first installs just the
-# base toolchain; per-distro package mappings are added by the follow-up
-# commits.  INSTALL_BUILD_DEPS_ARGS, when set, is passed to the script, so
+# feature tests in tools/build/feature/.  Currently supported: the Fedora
+# (dnf) and Ubuntu (apt) package mappings, see the script.
+# INSTALL_BUILD_DEPS_ARGS, when set, is passed to the script, so
 # extra options like --list, --dry-run or --distro can be given from make.
 install-build-deps:
 	$(Q)$(SHELL) $(srctree)/tools/perf/scripts/install-build-deps.sh $(INSTALL_BUILD_DEPS_ARGS)
diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/scripts/install-build-deps.sh
index 73caf2934d961d57..d725621bd7d70e7f 100755
--- a/tools/perf/scripts/install-build-deps.sh
+++ b/tools/perf/scripts/install-build-deps.sh
@@ -13,21 +13,33 @@
 # that provides the headers/libraries it checks, so that a subsequent
 # 'make -C tools/perf' build enables the corresponding perf features.
 #
-# Supported distros, each mapping validated in a fresh container, so the
-# host system is not modified:
+# Currently supported distros, each validated in a fresh container:
 #
 #   - Fedora, on dnf, validated on Fedora 44, in a toolbx container:
 #
 #           toolbox create fedora:44
 #           toolbox enter fedora:44
 #
+#   - Ubuntu, on apt-get, validated on Ubuntu 26.04, in a distrobox
+#     container:
+#
+#           distrobox create --image ubuntu:26.04
+#           distrobox enter ubuntu-26-04
+#
+# Running inside a container keeps the host system unmodified.
+#
+# Debian, which shares the Ubuntu package mapping, is the next planned
+# distro to be enabled once that mapping is validated on a Debian
+# release (trixie), as is RHEL support, once its (largely similar to
+# Fedora) package mapping is validated there.
+#
 # Usage: install-build-deps.sh [OPTIONS]
 #
 # Options:
 #    --list       list the packages that would be installed, then exit
 #    --dry-run    show the install command that would be run, without
 #                 running it
-#    --distro ID  force a distro: fedora (default: auto-detect)
+#    --distro ID  force a distro: fedora, ubuntu (default: auto-detect)
 #    -h, --help   print this help message
 #
 # Requires root (or passwordless sudo) to actually install packages.
@@ -49,11 +61,12 @@ it, so the corresponding feature gets enabled on a build.
 Options:
     --list      list the packages that would be installed, then exit
     --dry-run   show the install command that would be run, without running it
-    --distro ID force a distro: fedora
+    --distro ID force a distro: fedora, ubuntu
     -h, --help  print this help message
 
-Distro supported: Fedora (dnf), validated on a fresh Fedora 44 toolbx
-container.
+Distros supported: Fedora (dnf), validated in a toolbx container on
+Fedora 44, and Ubuntu (apt-get), validated in a distrobox container on
+Ubuntu 26.04.
 EOF
 	exit 0
 }
@@ -151,10 +164,110 @@ fedora_pkg_for() {
 	# and CoreSight (ifdef CORESIGHT), are deliberately not mapped.
 	# libaio is not mapped either: its
 	# test uses the POSIX AIO API (aio.h, aio_*, -lrt), provided by
-	# glibc headers (pulled in by the glibc-devel base package), not
-	# the native libaio.h/io_submit API that libaio-devel provides.
+	# glibc headers (pulled in by the libc headers package) in the
+	# base set, not the native libaio.h/io_submit API that
+	# libaio-devel provides.
 }
 
+# ---------------------------------------------------------------------
+# Return the Debian/Ubuntu package(s) providing the devel requirements
+# of a feature test in tools/build/feature/.  This mapping is shared by
+# Debian and Ubuntu, whose package names for these devel packages match,
+# and is validated on Ubuntu 26.04; Debian (trixie) will be enabled
+# once the same mapping is validated on it.
+# ---------------------------------------------------------------------
+debian_pkg_for() {
+	local feat="$1"
+	case "$feat" in
+	libelf|libelf-getphdrnum|libelf-gelf_getnote|libelf-getshdrstrndx)
+		echo "libelf-dev"
+		;;
+	libelf-zstd)
+		echo "libelf-dev libzstd-dev"
+		;;
+	libdw)
+		echo "libdw-dev"
+		;;
+	libdebuginfod)
+		echo "libdebuginfod-dev"
+		;;
+	libnuma|numa_num_possible_cpus)
+		echo "libnuma-dev"
+		;;
+	libzstd)
+		echo "libzstd-dev"
+		;;
+	zlib)
+		echo "zlib1g-dev"
+		;;
+	lzma)
+		echo "liblzma-dev"
+		;;
+	libslang)
+		echo "libslang2-dev"
+		;;
+	libcapstone)
+		echo "libcapstone-dev"
+		;;
+	libpython)
+		echo "python3-dev"
+		;;
+	libtraceevent)
+		echo "libtraceevent-dev"
+		;;
+	# The cxa-demangle feature test links against libstdc++ builtin
+	# demangling, so on Debian-derived distros it is covered by the
+	# g++ base package below, which pulls in libstdc++-*-dev.
+	cxa-demangle)
+		;;
+	libbpf)
+		echo "libbpf-dev"
+		;;
+	babeltrace2-ctf-writer)
+		echo "libbabeltrace2-dev"
+		;;
+	libopenssl)
+		echo "libssl-dev"
+		;;
+	libpfm4)
+		echo "libpfm4-dev"
+		;;
+	sdt)
+		echo "systemtap-sdt-dev"
+		;;
+	# test-clang-bpf-co-re.c invokes the clang binary (not libclang-cpp),
+	# so clang suffices; llvm-dev brings llvm-config, needed by the
+	# llvm/llvm-perf tests below.
+	clang-bpf-co-re)
+		echo "clang llvm-dev"
+		;;
+	llvm|llvm-perf)
+		echo "llvm-dev"
+		;;
+	jvmti|jvmti-cmlr)
+		echo "default-jdk"
+		;;
+	esac
+	# Same rationale as in fedora_pkg_for() above for unmapped tests.
+}
+
+# Base packages needed by any perf build, regardless of feature tests:
+# compiler, libc headers, flex/bison for the parser, kernel headers
+# for UAPI headers with no in-tree copy, e.g. <linux/capability.h>, and
+# gcc-c++ (dnf) / g++ (apt) is needed by the C++-based feature tests
+# (cxa-demangle, llvm, llvm-perf), compiled with $(CXX), and
+# pulls in libstdc++-devel / libstdc++-*-dev.
+# python3-setuptools is needed to build the python binding (perf's
+# util/setup.py uses it; without it binding is skipped with a warning).
+# rust is not a header-based feature test: test-rust.bin just checks
+# "$(RUSTC) --version" (tools/build/feature/Makefile), so it is mapped
+# here like the other toolchain packages.
+fedora_base_pkgs="gcc gcc-c++ make flex bison glibc-devel kernel-headers python3-setuptools rust"
+# pkg-config mirrors the pkgconf-pkg-config package that Fedora
+# installs by default, needed by the babeltrace2 feature test and
+# libopenssl's pkg-config checks.
+debian_base_pkgs="gcc g++ make pkg-config flex bison libc6-dev linux-libc-dev python3-setuptools rustc"
+
 # ---------------------------------------------------------------------
 # Distro detection
 # ---------------------------------------------------------------------
@@ -168,6 +281,9 @@ detect_distro() {
 	case "$id" in
 	fedora)			echo "fedora" ;;
 	ubuntu)			echo "ubuntu" ;;
+	# Debian shares the Ubuntu package mapping, but it is only validated
+	# on Ubuntu so far, so don't auto-detect it yet.
+	debian)			echo "" ;;
 	# RHEL and its derivatives share most Fedora package names, but the
 	# mapping is only validated on Fedora, so don't auto-detect them.
 	rhel|centos|rocky|alma|ol) echo "" ;;
@@ -188,44 +304,34 @@ feature_tests() {
 	done
 }
 
-# Base packages needed by any build, regardless of feature tests:
-# compiler, libc headers, flex/bison for the parser, kernel headers
-# for UAPI headers with no in-tree copy, e.g. <linux/capability.h>, and
-# gcc-c++ is needed by the C++-based feature tests (cxa-demangle, llvm,
-# llvm-perf), which are compiled with $(CXX), pulling in
-# libstdc++-devel.  python3-setuptools is needed to build the python
-# (perf's util/setup.py uses it); rust is checked by the rust feature
-# test (test-rust.bin just runs "$(RUSTC) --version").
-
-fedora_base_pkgs="gcc gcc-c++ make flex bison glibc-devel kernel-headers python3-setuptools rust"
-debian_base_pkgs="gcc g++ make flex bison libc6-dev linux-libc-dev python3-setuptools rustc"
-
 # ---------------------------------------------------------------------
-# Assemble the unique package list: the base toolchain plus, for each
-# feature test the distro's package mapping knows about, its package(s).
-# Installing an already-present package is a no-op for both dnf and
-# apt-get, making this idempotent.
+# Assemble the unique package list.  Since the full feature set is mapped
+# unconditionally, this installs the complete devel environment; installing
+# an already-present package is a no-op for both dnf and apt-get, making
+# this idempotent.
 # ---------------------------------------------------------------------
 package_set() {
 	local distro="$1" srcdir="$2"
 	local feat pkg pkgs
-
 	case "$distro" in
 	fedora)	pkgs="$fedora_base_pkgs" ;;
 	ubuntu)	pkgs="$debian_base_pkgs" ;;
 	esac
 
-	if [ "$distro" = "fedora" ]; then
-		for feat in $(feature_tests "$srcdir"); do
+	for feat in $(feature_tests "$srcdir"); do
+		if [ "$distro" = "fedora" ]; then
 			pkg=$(fedora_pkg_for "$feat")
-			for pkg in $pkg; do
-				case " $pkgs " in
-				*" $pkg "*) ;;
-				*) pkgs="$pkgs $pkg" ;;
-				esac
-			done
+		else
+			pkg=$(debian_pkg_for "$feat")
+		fi
+		[ -n "$pkg" ] || continue
+		for pkg in $pkg; do
+			case " $pkgs " in
+			*" $pkg "*) ;;
+			*) pkgs="$pkgs $pkg" ;;
+			esac
 		done
-	fi
+	done
 	echo "$pkgs"
 }
 
@@ -271,7 +377,7 @@ main() {
 	fedora|ubuntu) ;;
 	*)
 		echo "error: unsupported distro (got '$distro'); the package mapping is not validated on other distros." >&2
-		echo "Supported and validated: Fedora 44 (fresh toolbx container)." >&2
+		echo "Supported and validated: Fedora 44 (toolbx container), Ubuntu 26.04 (distrobox container)." >&2
 		exit 1
 		;;
 	esac
@@ -303,4 +409,4 @@ main() {
 	}
 }
 
-main "$@"
\ No newline at end of file
+main "$@"
-- 
2.55.0

