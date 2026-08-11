Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F46637DEA1;
	Tue, 11 Aug 2026 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786472961; cv=none; b=Ul+Xo0HVQx3gEIfRFJsZbb/ZwOHbG8ffAPnDWZi6CdXj4J9CygNjejfTsU2iK3qXNJvbyVQrvsd1YKVEGX9rKGJJKxCHqFgDrx/4GFLpIgHIl5DDKraEh/A/5KMjCJug1ve85Pjn4LsZ3K0qjM3ukUl7264c+RTdkd7fktPQgHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786472961; c=relaxed/simple;
	bh=cVztOs2uMIratdU9wIDk+3gEJqvY66z10g704Q5TGp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0S5V7Gz0WFJJStpE53a+aUVA+tQi+qMVLn49m9yHxiH6+JBCkDb6d9uC9HZRBjegbZRvmQrA1+ULRH0JtmRBybFq/HdB8oP8lrf+i+xAUd6IWHhGaqR2vohIygyEo6DesQa0eV9NcGeMiGY239j83YNW72L7my8dOS/Y2KrgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPN8eHBR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPN8eHBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9E01F000E9;
	Tue, 11 Aug 2026 18:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786472959;
	bh=iy4HTc6c4mJ99MFrZeUThnyT7uVU0GQ8QkuNGFhEfGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UPN8eHBRivv7b4OBPXBGp7HKLUGdCRLXJeQPzcm/TG6AlxgCL50nQUdUc9rGOya3l
	 +G6Scij2QfZEqFfdMnR6Xd9Uzojfi9tPcAm0/MEYIoXeOoAxhIKeVKA+m4wFzTtmzY
	 d9qnJZzDRqy9jdIOM95jbhTy9Ux3tSE2N4D66RZfUkd4pfBmn1zQ5Nez1a7l3lduf3
	 GXLKyK/jLe6NaAB46Y9AVRQLarm+/lY3tRTqlEyGTvTx2vwE8HX4eiPnMpAusfRH8D
	 V7yACWr/izVbF41DyBKCxoO3Fft6QJAft+b59yquKecPa/zJHnDG2y7iAiCrrN0V9O
	 ysxKpTMR+hB0Q==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/7] perf build: Add install-build-deps framework to install devel packages
Date: Tue, 11 Aug 2026 15:28:55 -0300
Message-ID: <20260811182900.27063-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811182900.27063-1-acme@kernel.org>
References: <20260811182900.27063-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Installing the development packages needed to build perf is
error-prone on a fresh distro install: the packages are scattered
across the feature tests in tools/build/feature/, each checking for a
specific header/library, and the build only tells you what's missing
after failing a check.

This series adds a 'make -C tools/perf install-build-deps' target to
install them in one go, deriving the package list from the feature tests
themselves.

This commit adds the framework, on top of the parse-time compiler
probe guard from the previous commit:

- the install-build-deps target in tools/perf/Makefile.perf, exempted
  from the config/feature detection pass, since it must run in a fresh
  container, before gcc or pkg-config exist, to install them;
- the install-build-deps.sh script, with --list, --dry-run and
  --distro options, distro detection (Fedora and Ubuntu), dnf and
  apt-get drivers, root/passwordless-sudo handling, and the base
  packages common to any build: compiler, C++ compiler, make, flex,
  bison, libc and kernel headers, python3-setuptools (needed by the
  python binding) and rust (checked by the rust feature test);
- the parse-time probes for optional tools, like pkg-config, use
  'command -v' with stderr discarded, so a fresh container without
  them gets no 'which: no pkg-config in (...)' spew from make;
- the script does not rely on 'set -e': its error paths are explicit,
  since the make target runs it via $(SHELL), where a shebang option
  would be ignored anyway, so direct and make-driven runs behave the
  same.

The per-feature mappings, from each feature test to the devel package
providing its headers on a given distro, are added by the follow-up
patches, one per distro, together with the validation of each mapping
in a fresh container: until then the target installs just the base
toolchain.

Assisted-by: opencode:deepseek-v4-flash-free
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                 |  20 ++-
 tools/perf/scripts/install-build-deps.sh | 173 +++++++++++++++++++++++
 2 files changed, 190 insertions(+), 3 deletions(-)
 create mode 100755 tools/perf/scripts/install-build-deps.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index acc6309a84a1eeb1..49a58d714e42dded 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -177,7 +177,7 @@ LD += $(EXTRA_LDFLAGS)
 # Some distros provide the command $(CROSS_COMPILE)pkg-config for
 # searching packges installed with Multiarch. Use it for cross
 # compilation if it is existed.
-ifneq (, $(shell which $(CROSS_COMPILE)pkg-config))
+ifneq (, $(shell command -v $(CROSS_COMPILE)pkg-config 2>/dev/null))
   PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 else
   PKG_CONFIG ?= pkg-config
@@ -214,7 +214,12 @@ AWK     = awk
 # non-config cases
 config := 1
 
-NON_CONFIG_TARGETS := clean python-clean TAGS tags cscope help
+# install-build-deps runs the install-build-deps.sh script, which
+# derives the package list from the feature test sources in
+# tools/build/feature/, so it needs neither the fixdep build nor a
+# config/feature detection pass: in a fresh container without gcc or
+# pkg-config those would fail before the script could install them.
+NON_CONFIG_TARGETS := clean python-clean TAGS tags cscope help install-build-deps
 
 ifdef MAKECMDGOALS
 ifeq ($(filter-out $(NON_CONFIG_TARGETS),$(MAKECMDGOALS)),)
@@ -748,6 +753,7 @@ help:
 	@echo '  HINT: use "prefix" or "DESTDIR" to install to a particular'
 	@echo '        path like "make prefix=/usr/local install install-doc"'
 	@echo '  install	- install compiled binaries'
+	@echo '  install-build-deps - install the development packages needed to build'
 	@echo '  install-doc	- install *all* documentation'
 	@echo '  install-man	- install manpage documentation'
 	@echo '  install-html	- install html documentation'
@@ -892,6 +898,14 @@ install-bin: install-tools install-tests
 
 install: install-bin try-install-man
 
+# Install the development packages needed to build perf, derived from the
+# feature tests in tools/build/feature/.  This first installs just the
+# base toolchain; per-distro package mappings are added by the follow-up
+# commits.  INSTALL_BUILD_DEPS_ARGS, when set, is passed to the script, so
+# extra options like --list, --dry-run or --distro can be given from make.
+install-build-deps:
+	$(Q)$(SHELL) $(srctree)/tools/perf/scripts/install-build-deps.sh $(INSTALL_BUILD_DEPS_ARGS)
+
 install-python_ext:
 	$(PYTHON_WORD) util/setup.py $(python_setup_quiet) install --root='/$(DESTDIR_SQ)'
 
@@ -960,7 +974,7 @@ endif
 
 FORCE:
 
-.PHONY: all install clean config-clean strip install-gtk
+.PHONY: all install install-build-deps clean config-clean strip install-gtk
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare bpf-skel-prepare
 .PHONY: python_perf_target
diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/scripts/install-build-deps.sh
new file mode 100755
index 0000000000000000..351fdd581e56dd7c
--- /dev/null
+++ b/tools/perf/scripts/install-build-deps.sh
@@ -0,0 +1,173 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# No 'set -e': the script uses explicit checks for its error paths, and
+# is also run via '$(SHELL) .../install-build-deps.sh' from the make
+# target in tools/perf/Makefile.perf, where a shebang option would be
+# ignored anyway, so direct and make-driven runs behave the same.
+#
+# Install the development packages needed to build tools/perf.
+#
+# The package set is derived from the feature tests in tools/build/feature/:
+# each feature test that perf may compile is mapped to the devel package
+# that provides the headers/libraries it checks, so that a subsequent
+# 'make -C tools/perf' build enables the corresponding perf features.
+#
+# This initial version installs the base toolchain needed by any build;
+# the per-feature package mapping is added, per supported distro, by the
+# follow-up patches in this series, which also validate each mapping in a
+# fresh container, so the host system is not modified.
+#
+# Usage: install-build-deps.sh [OPTIONS]
+#
+# Options:
+#    --list       list the packages that would be installed, then exit
+#    --dry-run    show the install command that would be run, without
+#                 running it
+#    --distro ID  force a distro: fedora, ubuntu (default: auto-detect)
+#    -h, --help   print this help message
+#
+# Requires root (or passwordless sudo) to actually install packages.
+
+set -u
+
+DISTRO=""
+
+help() {
+	cat <<EOF
+Usage: $(basename "$0") [--list] [--dry-run] [--distro ID] [-h|--help]
+
+Install the development packages needed to build tools/perf.
+
+Options:
+    --list      list the packages that would be installed, then exit
+    --dry-run   show the install command that would be run, without running it
+    --distro ID force a distro: fedora, ubuntu
+    -h, --help  print this help message
+EOF
+	exit 0
+}
+
+# ---------------------------------------------------------------------
+# Distro detection.  The install command that follows only differs in
+# the package manager, which here is keyed off the distro ID; the
+# per-feature package mapping is added per distro by the follow-up
+# patches.
+# ---------------------------------------------------------------------
+detect_distro() {
+	if [ -n "$DISTRO" ]; then
+		echo "$DISTRO"
+		return
+	fi
+	local id
+	id=$( . /etc/os-release 2>/dev/null && echo "${ID:-}" )
+	case "$id" in
+	fedora)			echo "fedora" ;;
+	ubuntu)			echo "ubuntu" ;;
+	# RHEL and its derivatives share most Fedora package names, but the
+	# mapping is only validated on Fedora, so don't auto-detect them.
+	rhel|centos|rocky|alma|ol) echo "" ;;
+	*)			echo "" ;;
+	esac
+}
+
+# Base packages needed by any perf build, regardless of feature tests:
+# compiler, libc headers, flex/bison for the parser, kernel headers
+# for UAPI headers with no in-tree copy, e.g. <linux/capability.h>, and
+# gcc-c++ (dnf) / g++ (apt) for the C++-based feature tests
+# (cxa-demangle, llvm, llvm-perf), compiled with $(CXX), and
+# pulls in libstdc++-devel / libstdc++-*-dev.
+# python3-setuptools is needed to build the python binding (perf's
+# util/setup.py uses it; without it binding is skipped with a warning).
+# rust is not a header-based feature test: test-rust.bin just checks
+# "$(RUSTC) --version" (tools/build/feature/Makefile), so it is mapped
+# here like the other toolchain packages.
+fedora_base_pkgs="gcc gcc-c++ make flex bison glibc-devel kernel-headers python3-setuptools rust"
+debian_base_pkgs="gcc g++ make flex bison libc6-dev linux-libc-dev python3-setuptools rustc"
+
+# ---------------------------------------------------------------------
+# Assemble the unique package list.  While the per-feature mapping is
+# being added per distro, only the base toolchain above is installed.
+# ---------------------------------------------------------------------
+package_set() {
+	local distro="$1" srcdir="$2"
+	case "$distro" in
+	fedora)	echo "$fedora_base_pkgs" ;;
+	ubuntu)	echo "$debian_base_pkgs" ;;
+	esac
+}
+
+# ---------------------------------------------------------------------
+# The install command proper for each supported package manager, plus
+# the command massaged for --dry-run.
+# ---------------------------------------------------------------------
+install_cmd() {
+	local distro="$1"; shift
+	case "$distro" in
+	fedora)
+		echo "dnf install -y $*"
+		;;
+	ubuntu)
+		# a fresh container has no package index, so update first.
+		echo "apt-get update && apt-get install -y $*"
+		;;
+	esac
+}
+
+main() {
+	local action="install"
+	local srcdir distro pkgs cmd
+
+	while [ $# -gt 0 ]; do
+		case "$1" in
+		--list)		action="list"; shift ;;
+		--dry-run)	action="dry-run"; shift ;;
+		--distro)
+			[ $# -ge 2 ] || {
+				echo "error: --distro requires an argument (fedora, rhel, ubuntu, debian)" >&2
+				exit 1
+			}
+			DISTRO="$2"; shift 2 ;;
+		-h|--help)	help ;;
+		*)		echo "error: unknown argument: $1" >&2; exit 1 ;;
+		esac
+	done
+
+	srcdir=$(cd "$(dirname "$0")/../../.." && pwd)
+	distro=$(detect_distro)
+	case "$distro" in
+	fedora|ubuntu) ;;
+	*)
+		echo "error: unsupported distro (got '$distro'); the package mapping is not validated on other distros." >&2
+		exit 1
+		;;
+	esac
+
+	pkgs=$(package_set "$distro" "$srcdir")
+
+	case "$action" in
+	list)
+		echo "$pkgs" | tr ' ' '\n' | grep -v '^$' | sort
+		exit 0
+		;;
+	dry-run)
+		install_cmd "$distro" $pkgs
+		exit 0
+		;;
+	esac
+
+	echo "The following packages will be installed to enable perf features:"
+	echo "$pkgs" | tr ' ' '\n' | grep -v '^$' | sort | sed 's/^/  /'
+	echo
+	cmd=$(install_cmd "$distro" $pkgs)
+	if [ "$(id -u)" -eq 0 ]; then
+		sh -c "$cmd"
+	else
+		sudo sh -c "$cmd"
+	fi || {
+		echo "error: the install command failed, see the output above" >&2
+		exit 1
+	}
+}
+
+main "$@"
\ No newline at end of file
-- 
2.55.0

