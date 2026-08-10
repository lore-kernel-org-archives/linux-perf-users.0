Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFB418A30;
	Mon, 10 Aug 2026 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376719; cv=none; b=U+HH1mWWOx7GeLv/DVUu6kQ8PDZRI/0hWTWOReAtmfWBAXfkIiFTPIJ5fpuh8UZIGUoWLJqxJ/3FiRXnv8rt/A7z8ATJD2AHCegC7Nl5MSedTnK72Mx4QciSuYsx8TmSGnaROUNbRE84ejgd6JKpZzBeZRosAIbGfkyuK9zPFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376719; c=relaxed/simple;
	bh=Tj9nDePwuERXPF1kd/m97yBrj6h6iwybflYHPVzjPSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQhharO11645GRzZNv2AYRNsLmcS1H78eOnuU1TDQjGKBeyE3vOuBgvWC9SwN8zFj+NrkiIrkBZ5duVJY0NmyaQyZwQXI2dtFIzNxs0vrMI4LiSaW942oHMJe3cQUGNWxRzMPRO9aQ+hzlNeJU4Pu9ktrbLfvKEDVGhKhEi0AMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnN7pT7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnN7pT7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191C11F00A3A;
	Mon, 10 Aug 2026 15:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786376716;
	bh=fvfxxJBfqsRYn08WNhlFcFUVxPQbp00RIXvvtvHDyQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cnN7pT7YBkXBd2VuqVgUVIDbFjlDgb5NKIJOoU18it+zD/artFKDOu3AvNvP8mGe7
	 4rWgrzOSeiUofKiGjtmc5DByPDnXpcpLvnyzpbL+UtpwcdRKs5hZLImDY7FRVrSLGI
	 BVB1L7bZp6IRG4s7+Nb/AaFL9QRiuBM6zEQDF3q1S6i07p3IVPHyH93vYWE2kmEJYz
	 x1NiPQeIYMyGEr4//CKFa1w+qQN2uRe91Pp0oPr1efi/j0JLm9kG5r5okexK4DDh3I
	 e82WESWwjsaqpJ+I18nelVGZp76uFAt3bCzxdUYe7+4bpTQpZrQ08mdlLQTRh4FzyM
	 YBSb1pA/aXhPg==
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
	sashiko-bot <sashiko-bot@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 7/7] perf build: install-build-deps: add RHEL family devel package mapping
Date: Mon, 10 Aug 2026 12:44:37 -0300
Message-ID: <20260810154437.15946-8-acme@kernel.org>
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

With the Fedora mapping in place, this patch extends it to the RHEL
family (RHEL, CentOS Stream, Rocky Linux, AlmaLinux, Oracle Linux),
which shares most Fedora package names and runs dnf (RHEL 8 and
later).  The names that differ are handled by probing the enabled
repos:

  - zlib.h comes from zlib-ng-compat-devel on the RHEL 10 family,
    zlib-devel on RHEL 9 and earlier;
  - there is no java-latest-openjdk-devel: the JDK devel package is
    versioned per release, java-21-openjdk-devel on the RHEL 10
    family, java-17-openjdk-devel on RHEL 9, java-11-openjdk-devel
    on RHEL 8;
  - libbpf-devel and capstone-devel live in the CRB repo on RHEL and
    CentOS Stream 10, in EPEL on RHEL 9 and earlier;
  - libbabeltrace2-devel is not packaged on the RHEL 10 family.

Packages not available on the enabled repos are skipped instead of
aborting the dnf transaction, and are listed at the end of the run, with
the repo that provides them pointed out in the header comment and help
text: a distro with CRB/EPEL enabled gets the full set, one without them
still installs what it can.

This also holds for the base set: e.g.  'rust' exists only as the
rust-toolset AppStream module on RHEL 8 and 9, where it is not
installable as a plain package, so it is skipped and noted there instead
of failing the whole dnf transaction.

The base set lists pkgconf-pkg-config instead of pkgconfig: both
families have been on pkgconf since Fedora 26 / RHEL 8, where
'pkgconfig' lives only as a virtual Provides of that subpackage, and
a minimal RHEL-family container may not have it preinstalled.

Validated on a fresh CentOS Stream 10 distrobox container, with the
CRB repo enabled, so the host system is not modified:

    distrobox create --image quay.io/centos/centos:stream10
    distrobox enter centos-stream10
    dnf config-manager --set-enabled crb
    make -C tools/perf install-build-deps

which installed the 28 available mapped packages; libbabeltrace2-devel, the
only mapped package with no RHEL 10 package, is reported at the end
of the run.

A subsequent 'make -C tools/perf feature-dump' enabled every feature
with an external dependency the RHEL 10 family provides, including
libbpf and libcapstone from the CRB repo, with only
babeltrace2-ctf-writer left out along with the deliberately unmapped
opt-in features.

Re-running the target is a no-op (dnf reports "Nothing to do"); with the
CRB repo disabled, the skipped packages are instead listed in the
end-of-run note, whose header comment and help text point out which repo
provides them.

Members of the family without dnf (RHEL 7 and earlier, e.g. Oracle
Linux 7, a yum-only distro) are rejected with an explicit error while
the dnf-based members get the full mapping.

Example of its --list:

  $ grep PRETTY_NAME /etc/os-release
  PRETTY_NAME="Fedora Linux 44 (Toolbx Container Image)"
  $ tools/perf/scripts/install-build-deps.sh --list --distro rhel
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
  pkgconf-pkg-config
  python3-devel
  python3-setuptools
  rust
  slang-devel
  systemtap-sdt-devel
  xz-devel
  zlib-ng-compat-devel
  $

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Assisted-by: opencode:deepseek-v4-flash-free
Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/install-build-deps.sh | 208 ++++++++++++++++++++---
 1 file changed, 185 insertions(+), 23 deletions(-)

diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/scripts/install-build-deps.sh
index 4a6f4bda49094696..caf6d8d1e56d15f0 100755
--- a/tools/perf/scripts/install-build-deps.sh
+++ b/tools/perf/scripts/install-build-deps.sh
@@ -32,11 +32,33 @@
 #           distrobox create --image debian:trixie
 #           distrobox enter debian-trixie
 #
-# Running inside a container keeps the host system unmodified.
+#   - RHEL and its variants (RHEL, CentOS Stream, Rocky Linux, AlmaLinux,
+#     Oracle Linux), on dnf (RHEL 8 and later), validated on CentOS
+#     Stream 10, in a distrobox container:
+#
+#           distrobox create --image quay.io/centos/centos:stream10
+#           distrobox enter centos-stream10
+#
+#     The RHEL family reuses most Fedora package names, with these
+#     differences, handled by probing the enabled repos:
 #
-# RHEL support, whose package mapping is largely similar to Fedora's,
-# is the next planned distro, to be enabled once that mapping is
-# validated there.
+#       - zlib.h comes from zlib-ng-compat-devel on the RHEL 10 family,
+#         zlib-devel on RHEL 9 and earlier;
+#       - the JDK devel package is versioned, there is no
+#         java-latest-openjdk-devel: java-21-openjdk-devel on the RHEL
+#         10 family, java-17-openjdk-devel on RHEL 9, java-11-openjdk-
+#         devel on RHEL 8;
+#       - libbpf-devel and capstone-devel are in the CRB repo on RHEL
+#         and CentOS Stream 10 ('dnf config-manager --set-enabled crb')
+#         and in EPEL on RHEL 9 and earlier;
+#       - libbabeltrace2-devel is not packaged on the RHEL 10 family.
+#
+#     On the RHEL family, packages not available on the enabled repos
+#     are skipped and listed at the end of the run, so that a distro
+#     with CRB/EPEL enabled gets the full set, and a distro without
+#     them still installs what it can.
+#
+# Running inside a container keeps the host system unmodified.
 #
 # Usage: install-build-deps.sh [OPTIONS]
 #
@@ -44,7 +66,8 @@
 #    --list       list the packages that would be installed, then exit
 #    --dry-run    show the install command that would be run, without
 #                 running it
-#    --distro ID  force a distro: fedora, ubuntu, debian (default: auto-detect)
+#    --distro ID  force a distro: fedora, rhel, ubuntu, debian
+#                 (default: auto-detect)
 #    -h, --help   print this help message
 #
 # Requires root (or passwordless sudo) to actually install packages.
@@ -66,13 +89,19 @@ it, so the corresponding feature gets enabled on a build.
 Options:
     --list      list the packages that would be installed, then exit
     --dry-run   show the install command that would be run, without running it
-    --distro ID force a distro: fedora, ubuntu, debian
+    --distro ID force a distro: fedora, rhel, ubuntu, debian
     -h, --help  print this help message
 
 Distros supported: Fedora (dnf), validated in a toolbx container on
 Fedora 44, Ubuntu (apt-get), validated in a distrobox container on
-Ubuntu 26.04, and Debian (apt-get), reusing the Ubuntu mapping,
-validated in a distrobox container on Debian 13 (trixie).
+Ubuntu 26.04, Debian (apt-get), reusing the Ubuntu mapping, validated
+in a distrobox container on Debian 13 (trixie), and the RHEL family
+(dnf, RHEL 8 and later), validated on CentOS Stream 10 in a distrobox
+container.  On the RHEL family, packages not available on the enabled
+repos are skipped and listed at the end; some there, e.g.
+libbpf-devel and capstone-devel, come from the CRB repo on RHEL and
+CentOS Stream 10 ('dnf config-manager --set-enabled crb') and from
+EPEL on RHEL 9 and earlier.
 EOF
 	exit 0
 }
@@ -175,6 +204,72 @@ fedora_pkg_for() {
 	# libaio-devel provides.
 }
 
+# ---------------------------------------------------------------------
+# Check whether the first argument is provided by the enabled repos, or
+# is already installed, returning 0 if so and printing nothing.
+#
+# dnf repoquery exits 0 even when the pattern does not match anything,
+# so availability is judged by the output being non-empty, not by the
+# exit code.
+# ---------------------------------------------------------------------
+pkg_available() {
+	local p out
+	for p in "$@"; do
+		out=$(dnf repoquery --quiet --available "$p" 2>/dev/null)
+		[ -n "$out" ] || out=$(dnf repoquery --quiet --installed "$p" 2>/dev/null)
+		[ -n "$out" ] && return 0
+	done
+	return 1
+}
+
+# ---------------------------------------------------------------------
+# Return the first of its arguments that pkg_available() accepts.
+# ---------------------------------------------------------------------
+pick_available() {
+	local p
+	for p in "$@"; do
+		if pkg_available "$p"; then
+			echo "$p"
+			return 0
+		fi
+	done
+	return 1
+}
+
+# ---------------------------------------------------------------------
+# Return the RHEL-family package(s) providing the devel requirements of
+# a feature test.  This family reuses the Fedora mapping, whose names
+# apply to it as well, except for the features whose Fedora package
+# does not exist there, kept in the case below.
+#
+# Whether the resulting package is actually installable is checked in
+# package_set(), as some of these names live in the CRB or EPEL repos,
+# which may not be enabled: on the RHEL 10 family libbpf-devel and
+# capstone-devel come from CRB, and libbabeltrace2-devel is not
+# packaged at all.
+# ---------------------------------------------------------------------
+rhel_pkg_for() {
+	local feat="$1"
+	case "$feat" in
+	zlib)
+		# zlib-ng-compat-devel on the RHEL 10 family, zlib-devel on
+		# RHEL 9 and earlier.  If neither is on the enabled repos,
+		# fall back to the first candidate so that package_set()
+		# reports it as missing instead of silently dropping the
+		# feature from the end-of-run note.
+		pick_available zlib-devel zlib-ng-compat-devel || echo "zlib-devel"
+		;;
+	jvmti|jvmti-cmlr)
+		# No java-latest-openjdk-devel on the RHEL family: the JDK
+		# devel package is versioned per release.
+		pick_available java-latest-openjdk-devel java-21-openjdk-devel java-17-openjdk-devel java-11-openjdk-devel || echo "java-latest-openjdk-devel"
+		;;
+	*)
+		fedora_pkg_for "$feat"
+		;;
+	esac
+}
+
 # ---------------------------------------------------------------------
 # Return the Debian/Ubuntu package(s) providing the devel requirements
 # of a feature test in tools/build/feature/.  This mapping is shared by
@@ -272,6 +367,11 @@ fedora_base_pkgs="gcc gcc-c++ make flex bison glibc-devel kernel-headers python3
 # installs by default, needed by the babeltrace2 feature test and
 # libopenssl's pkg-config checks.
 debian_base_pkgs="gcc g++ make pkg-config flex bison libc6-dev linux-libc-dev python3-setuptools rustc"
+# pkg-config: like Fedora, on pkgconf since Fedora 26 / RHEL 8, with
+# 'pkgconfig' live only as a virtual Provides of the pkgconf-pkg-config
+# subpackage.  List it explicitly because, unlike Fedora, a minimal
+# RHEL-family container may not have it preinstalled.
+rhel_base_pkgs="gcc gcc-c++ make flex bison glibc-devel kernel-headers pkgconf-pkg-config python3-setuptools rust"
 
 # ---------------------------------------------------------------------
 # Distro detection
@@ -285,11 +385,12 @@ detect_distro() {
 	id=$( . /etc/os-release && echo "${ID:-}" )
 	case "$id" in
 	fedora)			echo "fedora" ;;
+	rhel|centos|rocky|almalinux|ol)
+		# All share the Fedora package names (with the exceptions
+		# handled by rhel_pkg_for()) and dnf.
+		echo "rhel" ;;
 	ubuntu)			echo "ubuntu" ;;
 	debian)			echo "debian" ;;
-	# RHEL and its derivatives share most Fedora package names, but the
-	# mapping is only validated on Fedora, so don't auto-detect them.
-	rhel|centos|rocky|alma|ol) echo "" ;;
 	*)			echo "" ;;
 	esac
 }
@@ -311,33 +412,73 @@ feature_tests() {
 # Assemble the unique package list.  Since the full feature set is mapped
 # unconditionally, this installs the complete devel environment; installing
 # an already-present package is a no-op for both dnf and apt-get, making
-# this idempotent.
+# this idempotent.  On the RHEL family, packages not available on the
+# enabled repos are skipped and echoed on stderr, reported at the end of
+# the run by the caller (package_set() runs in a subshell, so a variable
+# would not survive it).
 # ---------------------------------------------------------------------
 package_set() {
 	local distro="$1" srcdir="$2"
-	local feat pkg pkgs
+	local feat pkg pkgs base_pkgs missing_pkgs=""
 	case "$distro" in
 	fedora)	pkgs="$fedora_base_pkgs" ;;
+	rhel)	pkgs="$rhel_base_pkgs" ;;
 	ubuntu|debian)	pkgs="$debian_base_pkgs" ;;
 	esac
 
+	# The base set must be checked against the enabled repos as well:
+	# e.g. 'rust' is only shipped as the rust-toolset AppStream module
+	# on RHEL 8 and 9, where dnf would abort the whole transaction
+	# with "No match for argument: rust" instead of skipping it, so
+	# unavailable base packages are skipped and noted like the mapped
+	# ones below.
+	if [ "$distro" = "rhel" ]; then
+		base_pkgs="$pkgs"
+		pkgs=""
+		for pkg in $base_pkgs; do
+			if pkg_available "$pkg"; then
+				pkgs="$pkgs $pkg"
+			else
+				missing_pkgs="$missing_pkgs $pkg"
+			fi
+		done
+	fi
+
 	for feat in $(feature_tests "$srcdir"); do
-		if [ "$distro" = "fedora" ]; then
-			pkg=$(fedora_pkg_for "$feat")
-		else
-			pkg=$(debian_pkg_for "$feat")
-		fi
+		case "$distro" in
+		fedora)		pkg=$(fedora_pkg_for "$feat") ;;
+		rhel)		pkg=$(rhel_pkg_for "$feat") ;;
+		*)		pkg=$(debian_pkg_for "$feat") ;;
+		esac
 		[ -n "$pkg" ] || continue
 		for pkg in $pkg; do
+			if [ "$distro" = "rhel" ] && ! pkg_available "$pkg"; then
+				missing_pkgs="$missing_pkgs $pkg"
+				continue
+			fi
 			case " $pkgs " in
 			*" $pkg "*) ;;
 			*) pkgs="$pkgs $pkg" ;;
 			esac
 		done
 	done
+	[ -n "$missing_pkgs" ] && echo "$missing_pkgs" >&2
 	echo "$pkgs"
 }
 
+# ---------------------------------------------------------------------
+# Report the RHEL-family packages that were skipped because the enabled
+# repos do not provide them.
+# ---------------------------------------------------------------------
+note_missing() {
+	[ -n "$1" ] || return 0
+	echo "Note: these packages are not available on the enabled repos" >&2
+	echo "and were not installed, so the features they enable will stay" >&2
+	echo "off in a perf build:" >&2
+	echo "$1" | tr ' ' '\n' | grep -v '^$' | sort -u | sed 's/^/  /' >&2
+	echo >&2
+}
+
 # ---------------------------------------------------------------------
 # The install command proper for each supported package manager, plus
 # the command massaged for --dry-run.
@@ -345,7 +486,7 @@ package_set() {
 install_cmd() {
 	local distro="$1"; shift
 	case "$distro" in
-	fedora)
+	fedora|rhel)
 		echo "dnf install -y $*"
 		;;
 	ubuntu|debian)
@@ -357,7 +498,7 @@ install_cmd() {
 
 main() {
 	local action="install"
-	local srcdir distro pkgs pkg cmd
+	local srcdir distro pkgs pkg cmd missing_file missing_pkgs
 
 	while [ $# -gt 0 ]; do
 		case "$1" in
@@ -377,23 +518,43 @@ main() {
 	srcdir=$(cd "$(dirname "$0")/../../.." && pwd)
 	distro=$(detect_distro)
 	case "$distro" in
-	fedora|ubuntu|debian) ;;
+	fedora|rhel|ubuntu|debian) ;;
 	*)
 		echo "error: unsupported distro (got '$distro'); the package mapping is not validated on other distros." >&2
-		echo "Supported and validated: Fedora 44 (toolbx container), Ubuntu 26.04 and Debian 13 (distrobox containers)." >&2
+		echo "Supported and validated: Fedora 44 (toolbx container), Ubuntu 26.04 and Debian 13 (distrobox containers), and CentOS Stream 10 (distrobox container)." >&2
 		exit 1
 		;;
 	esac
 
-	pkgs=$(package_set "$distro" "$srcdir")
+	# The RHEL family mapping probes the enabled repos with dnf
+	# repoquery and installs with dnf, so reject the yum-only members of
+	# the family (RHEL 7 and earlier, e.g. Oracle Linux 7) with a clear
+	# error instead of silently judging every package as unavailable.
+	if [ "$distro" = "rhel" ] && ! command -v dnf >/dev/null 2>&1; then
+		echo "error: dnf not found, the RHEL family package mapping requires dnf (RHEL 8 and later)." >&2
+		exit 1
+	fi
+
+	missing_file=$(mktemp) || {
+		echo "error: cannot create a temporary file (mktemp failed)" >&2
+		exit 1
+	}
+	# package_set() runs in a subshell, doing dnf repoquery loops that
+	# may be interrupted, so also trap the temp file then.
+	trap 'rm -f "$missing_file"' EXIT INT TERM
+	pkgs=$(package_set "$distro" "$srcdir" 2>"$missing_file")
+	missing_pkgs=$(cat "$missing_file")
+	rm -f "$missing_file"
 
 	case "$action" in
 	list)
 		echo "$pkgs" | tr ' ' '\n' | grep -v '^$' | sort
+		note_missing "$missing_pkgs"
 		exit 0
 		;;
 	dry-run)
 		install_cmd "$distro" $pkgs
+		note_missing "$missing_pkgs"
 		exit 0
 		;;
 	esac
@@ -410,6 +571,7 @@ main() {
 		echo "error: the install command failed, see the output above" >&2
 		exit 1
 	}
+	note_missing "$missing_pkgs"
 }
 
 main "$@"
-- 
2.55.0

