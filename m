Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FEA38A725;
	Tue, 11 Aug 2026 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411784; cv=none; b=CM1xI7IehLd/sKp86beAgKm73r4KkVYOCFYyxOZNXE8apwf97MuMK4xWy5a8/LwRXrk9hiM/yScYl18ocmcffpfS+x0vFG6Vz7UbR+eVdBEsaN+SiT9/NXM72sKXSLsRGm+DsBFS87H6zXKxBD7zniAPceJDWEXtmUaAyJSwz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411784; c=relaxed/simple;
	bh=nOHcVDdtnj359JbXlQ1qsrXI4lFb43NSzv2RoFXdbeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGcOd5L50jV2jmryOpFl5TacAMcA+laCV5fO0awyCNcaKLiYBbo22RZR5An+j3Mx4TcTqvqjs2c3R/SEuKsvpdhHhpdbe1j2MsnmrQj0um1CuyNfsHpy8TX1NSg9ag/6kOn7GV82ohCfkV7BG973I5I32WNs/cntboc3gGHNa64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT9geG6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT9geG6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F65D1F000E9;
	Tue, 11 Aug 2026 01:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411782;
	bh=J8tlulIGCIs4BbEC4rrku7sV/MdqCrsHZMd6omoEUqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aT9geG6DbBhXJna6iYJZFVzNrJZw6A6SyDaAzCurSTJfqI5pHBkJkVYxDXWx1b17F
	 BJxKKS7q6FMXh8tptV+xSIVeTwwOdQ3rFJZQJH1zLEhIReT5uNyCnlyZosSGsHuuBZ
	 mtiFvmWB6pj2J28HoK3gEiFyaOWHsZ8yCekjZcAoIiRjmpWvwDd+qJx+jxIle8MB4L
	 j5enxkxN5jFsL6H+8msbGXAZhzsIidApFS3rO+cUUDTukC7RXKLAa/A46/Fz1CYEwv
	 gttPaGUm9CAoCtfXLMDM4pdIeeDdWXjI95ZeGot9VbD7lh2kiB7I/E/EQUmBHJVKqR
	 SYtF62Qvb+7SQ==
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
Subject: [PATCH 5/7] perf build: install-build-deps: add Debian devel package mapping
Date: Mon, 10 Aug 2026 22:29:03 -0300
Message-ID: <20260811012905.14742-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811012905.14742-1-acme@kernel.org>
References: <20260811012905.14742-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With the Fedora and Ubuntu mappings in place, this patch adds Debian
support: Debian installs the same devel packages, under the same
names, as the Ubuntu mapping, so it reuses debian_pkg_for() and
debian_base_pkgs as-is, with only auto-detection in detect_distro()
(and the shared apt-get install path) added, keeping the script's
per-distro dispatch ready for distros with their own package names.

Validated on a fresh Debian 13 (trixie) container so the host system
is not modified:

    distrobox create --image debian:trixie
    distrobox enter debian-trixie
    make -C tools/perf install-build-deps

which installed the 29 mapped packages; re-running the target is a
no-op (apt-get reports "0 newly installed").  A subsequent clean build
enabled the same feature set as Ubuntu: 'perf version --build-options'
shows every feature with an external dependency Debian has a package
for [on], including the BPF skeletons compiled with clang/llvm
(libLLVM), the python binding and the C++-based features, with only
the deliberately unmapped libbfd family, libperl, libunwind and the
CoreSight (libopencsd) packages [OFF].

RHEL, whose package mapping is largely similar to Fedora's, is the
remaining planned distro, to be enabled once that mapping is
validated on it.

Example of its --list:

  $ grep PRETTY_NAME /etc/os-release
  PRETTY_NAME="Fedora Linux 44 (Toolbx Container Image)"
  $ tools/perf/scripts/install-build-deps.sh --list --distro debian
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
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                 |  3 +-
 tools/perf/scripts/install-build-deps.sh | 37 +++++++++++++-----------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e1fc75b4621faed5..29cfd44c427f33ba 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -900,7 +900,8 @@ install: install-bin try-install-man
 
 # Install the development packages needed to build perf, derived from the
 # feature tests in tools/build/feature/.  Currently supported: the Fedora
-# (dnf) and Ubuntu (apt) package mappings, see the script.
+# (dnf), Ubuntu (apt) and Debian (apt, reusing the Ubuntu mapping)
+# package mappings, see the script.
 # INSTALL_BUILD_DEPS_ARGS, when set, is passed to the script, so
 # extra options like --list, --dry-run or --distro can be given from make.
 install-build-deps:
diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/scripts/install-build-deps.sh
index 6f2b80225f07d503..2f4285d436998ab1 100755
--- a/tools/perf/scripts/install-build-deps.sh
+++ b/tools/perf/scripts/install-build-deps.sh
@@ -26,12 +26,17 @@
 #           distrobox create --image ubuntu:26.04
 #           distrobox enter ubuntu-26-04
 #
+#   - Debian, on apt-get, reusing the Ubuntu mapping, validated on
+#     Debian 13 (trixie), in a distrobox container:
+#
+#           distrobox create --image debian:trixie
+#           distrobox enter debian-trixie
+#
 # Running inside a container keeps the host system unmodified.
 #
-# Debian, which shares the Ubuntu package mapping, is the next planned
-# distro to be enabled once that mapping is validated on a Debian
-# release (trixie), as is RHEL support, once its (largely similar to
-# Fedora) package mapping is validated there.
+# RHEL support, whose package mapping is largely similar to Fedora's,
+# is the next planned distro, to be enabled once that mapping is
+# validated there.
 #
 # Usage: install-build-deps.sh [OPTIONS]
 #
@@ -39,7 +44,7 @@
 #    --list       list the packages that would be installed, then exit
 #    --dry-run    show the install command that would be run, without
 #                 running it
-#    --distro ID  force a distro: fedora, ubuntu (default: auto-detect)
+#    --distro ID  force a distro: fedora, ubuntu, debian (default: auto-detect)
 #    -h, --help   print this help message
 #
 # Requires root (or passwordless sudo) to actually install packages.
@@ -61,12 +66,13 @@ it, so the corresponding feature gets enabled on a build.
 Options:
     --list      list the packages that would be installed, then exit
     --dry-run   show the install command that would be run, without running it
-    --distro ID force a distro: fedora, ubuntu
+    --distro ID force a distro: fedora, ubuntu, debian
     -h, --help  print this help message
 
 Distros supported: Fedora (dnf), validated in a toolbx container on
-Fedora 44, and Ubuntu (apt-get), validated in a distrobox container on
-Ubuntu 26.04.
+Fedora 44, Ubuntu (apt-get), validated in a distrobox container on
+Ubuntu 26.04, and Debian (apt-get), reusing the Ubuntu mapping,
+validated in a distrobox container on Debian 13 (trixie).
 EOF
 	exit 0
 }
@@ -173,8 +179,7 @@ fedora_pkg_for() {
 # Return the Debian/Ubuntu package(s) providing the devel requirements
 # of a feature test in tools/build/feature/.  This mapping is shared by
 # Debian and Ubuntu, whose package names for these devel packages match,
-# and is validated on Ubuntu 26.04; Debian (trixie) will be enabled
-# once the same mapping is validated on it.
+# and is validated on Ubuntu 26.04 and Debian 13 (trixie).
 # ---------------------------------------------------------------------
 debian_pkg_for() {
 	local feat="$1"
@@ -281,9 +286,7 @@ detect_distro() {
 	case "$id" in
 	fedora)			echo "fedora" ;;
 	ubuntu)			echo "ubuntu" ;;
-	# Debian shares the Ubuntu package mapping, but it is only validated
-	# on Ubuntu so far, so don't auto-detect it yet.
-	debian)			echo "" ;;
+	debian)			echo "debian" ;;
 	# RHEL and its derivatives share most Fedora package names, but the
 	# mapping is only validated on Fedora, so don't auto-detect them.
 	rhel|centos|rocky|alma|ol) echo "" ;;
@@ -315,7 +318,7 @@ package_set() {
 	local feat pkg pkgs
 	case "$distro" in
 	fedora)	pkgs="$fedora_base_pkgs" ;;
-	ubuntu)	pkgs="$debian_base_pkgs" ;;
+	ubuntu|debian)	pkgs="$debian_base_pkgs" ;;
 	esac
 
 	for feat in $(feature_tests "$srcdir"); do
@@ -345,7 +348,7 @@ install_cmd() {
 	fedora)
 		echo "dnf install -y $*"
 		;;
-	ubuntu)
+	ubuntu|debian)
 		# a fresh container has no package index, so update first.
 		echo "apt-get update && apt-get install -y $*"
 		;;
@@ -374,10 +377,10 @@ main() {
 	srcdir=$(cd "$(dirname "$0")/../../.." && pwd)
 	distro=$(detect_distro)
 	case "$distro" in
-	fedora|ubuntu) ;;
+	fedora|ubuntu|debian) ;;
 	*)
 		echo "error: unsupported distro (got '$distro'); the package mapping is not validated on other distros." >&2
-		echo "Supported and validated: Fedora 44 (toolbx container), Ubuntu 26.04 (distrobox container)." >&2
+		echo "Supported and validated: Fedora 44 (toolbx container), Ubuntu 26.04 and Debian 13 (distrobox containers)." >&2
 		exit 1
 		;;
 	esac
-- 
2.55.0

