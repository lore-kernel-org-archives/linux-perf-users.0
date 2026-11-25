Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634661;
	b=zwun1CYYulcYsf5Rs/Cvogu9mmvb/G+qoC3MsN5V+Jl9ZjG6QKpIFWDtDQnnR29dD0iW
	 e9/PDsqSwqiDxKrhjzLq1s5DwlLKabChetDfh0yghBFjduUyHcgX6P+SJR+SMH0nCsniR
	 XtJ2p/AtyNl6G6sdXJXnB+a/JshjI3t7XEYBhVD7U12T+cDZAapTH6lf3p8toZFJOKpkt
	 dbaTQtfEqBSGaPjuXuGp4LLlftzsFY73nuEt2fL7HR21g1vUq5P+FjyAYPSIy53XDbD9R
	 d/vcUWBF/w4JiUIF5ywIrWmVNCKW7h4R9aM0yA8Ubn5ae0hvBCdCXRbdtQn43Lm1G3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634661;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/SyCbfKWp/zQ9Io6eDaSQnODKI6Nsw3B363EDeWdg+M=;
	b=gw4XGWoI8KYsU9gSd8r9dq9dsrRO5nuu/iVBWuanQO7sy0wN4Efi9cH11rSYrpEsTkVK
	 YQVtrcVnrZOVtF4Eys9xKGTA8DmWXIBAgfcZ65oeUoYI5uPjnh57d0g5Kxs6xY1tKZx7O
	 sDKjgcMMBIIfK4eUGTr4J5CU6do8PVjW56ghQBafm+sdhIB4gHK6WgQXkvKG2Ov9Qsv/Q
	 9ZA2KqG+DQKr7TinCb6S7AEPeh2BeDZsmuk4L42nLKMuo8s93SSU9vPo2mHZmi5Iw4Ees
	 OKd14GcJnPCb2nyQ2tKhwV7BerO25HqeouNe4mht6w+WNclKw0dF12E4ry6fdMAvsww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1tC0zIt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD860A260F;
	Wed, 25 Nov 2026 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1tC0zIt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4318B1F000D3;
	Wed, 25 Nov 2026 19:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634661;
	bh=/SyCbfKWp/zQ9Io6eDaSQnODKI6Nsw3B363EDeWdg+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c1tC0zItx+28q5IqfEU7ek5F9Eekd+5GelqpZxa8eDsSvzS9gIXelR/jcJ0gq/jWq
	 QEdXLTAY3tqp+0VlXzAo18gRk3sAy4NDm5FMJ5vixXxlqFZfpQV0uO0cbGTqkzWabl
	 uzBG8j1C7tEk0QP5kBbqUZ3J+55SLrpVes1M5P1s3XgAV52LVJny4g5pRl0XUZcQ6K
	 B9SKCetIdlIGrFdiplsYSa/nU/c3fz+lxpl5/jHTYvcnGIZxmSLH8LAaCVa9Tsw80G
	 FnXkTAPCLC+7yzBLa/+Q09mysSZfHs+e+LuUwdTGx/PgG1gfADnyfa/BzZjr7YPR3k
	 2WLvMI8O43S+g==
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
Subject: [PATCH v13 18/19] perf scripts: Add a coverage harness for perf
Date: Wed, 25 Nov 2026 16:23:11 -0300
Message-ID: <20261125192312.34134-19-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125192312.34134-1-acme@kernel.org>
References: <20261125192312.34134-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Build perf with clang source based coverage, run the complete perf test
suite, merge the raw profiles and report line and function coverage,
optionally against a baseline.  Wired as 'make -C tools/perf coverage'
and 'coverage-prep'; coverage-prep builds the instrumented perf apart
from the test run, for the root tests on the bare metal host while
building in the development container.

The report covers every instrumented C and C++ source, not only the paths
the tests walk; the Rust workload is built and exercised, but rustc does
not get coverage flags.  The static libbpf build inherits EXTRA_CFLAGS,
the C++ sources get the same coverage flags through EXTRA_CXXFLAGS
without dropping a CXXFLAGS from the environment, and the dlopened UI,
jvmti, Python and dlfilter libraries are passed to llvm-cov as separate
objects.  The host tools are built with clang too, so the build does
not need gcc.  The test suite runs in parallel by default; --sequential
runs one test at a time, and --timeout SECS raises the per-test timeout,
for machines with few CPUs or slow storage.  'perf test' exits 0 even
when tests fail and when the test filter matches nothing, so the status
comes from its "Failed tests :" and "Timed out tests :" lines and a run
with every count zero is an error.  The dlfilter objects and shared
libraries are rebuilt on each perf build, the python extension is
dropped before a build and its setuptools object cache after it, as
that cache keys on timestamps only.  The built extension then stays in
the build dir, so a second root run of the prepared build keeps passing
the python tests.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/.gitignore          |   1 +
 tools/perf/Makefile            |  12 +-
 tools/perf/Makefile.config     |   1 +
 tools/perf/Makefile.perf       |   9 +-
 tools/perf/scripts/coverage.sh | 486 +++++++++++++++++++++++++++++++++
 5 files changed, 505 insertions(+), 4 deletions(-)
 create mode 100755 tools/perf/scripts/coverage.sh

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 3b968c5158b822ce..d263877366ca1440 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -27,6 +27,7 @@ stats-*.csv
 cscope*
 config.mak
 config.mak.autogen
+/cov/
 *-bison.*
 *-flex.*
 *.pyc
diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 00baf90e5bda7123..d9ad8c0d796c2852 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -140,6 +140,16 @@ check-headers:
 sync-headers:
 	@./scripts/sync-headers.sh $(SYNC_HEADERS_ARGS)
 
+coverage_o = $(if $(O),\
+$(if $(shell cd $(PWD); test -d $(O) || echo $(O)),\
+$(error O=$(O) does not exist),--build-dir=$(FULL_O)))
+
+coverage-prep:
+	@./scripts/coverage.sh --prep $(coverage_o) $(COVERAGE_ARGS)
+
+coverage:
+	@./scripts/coverage.sh $(coverage_o) $(COVERAGE_ARGS)
+
 #
 # All other targets get passed through:
 #
@@ -147,4 +157,4 @@ sync-headers:
 	$(print_msg)
 	$(make)
 
-.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball check-headers sync-headers
+.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball check-headers sync-headers coverage coverage-prep
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 88b8bc13a578a24f..11043520675d2c6a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -19,6 +19,7 @@ detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
 detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 
 CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
+CXXFLAGS := $(CXXFLAGS) $(EXTRA_CXXFLAGS)
 HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 
 # This is required because the kernel is built with this and some of the code
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d4b641925ab296db..1b4efe6254fa0370 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -779,13 +779,13 @@ $(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-map.c
 	$(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
 endif
 
-$(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h
+$(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h FORCE
 	$(Q)$(MKDIR) -p $(OUTPUT)dlfilters
 	$(QUIET_CC)$(CC) -c -Iinclude $(EXTRA_CFLAGS) -o $@ -fpic $<
 
 .SECONDARY: $(DLFILTERS:.so=.o)
 
-$(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
+$(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o FORCE
 	$(QUIET_LINK)$(CC) $(filter-out -static,$(LDFLAGS)) $(EXTRA_CFLAGS) -shared -o $@ $<
 
 ifndef NO_JVMTI
@@ -812,7 +812,7 @@ $(LIBAPI)-clean:
 $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
 		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= subdir= \
-		EXTRA_CFLAGS="-fPIC" $@ install_headers
+		EXTRA_CFLAGS="-fPIC $(EXTRA_CFLAGS)" $@ install_headers
 
 $(LIBBPF)-clean:
 	$(call QUIET_CLEAN, libbpf)
@@ -877,6 +877,9 @@ help:
 	@echo '  check-headers		- check which header copies are out of sync with the kernel'
 	@echo '  sync-headers		- sync those header copies with the kernel, creating commits'
 	@echo '			  (SYNC_HEADERS_ARGS="..." passes options to the script)'
+	@echo '  coverage-prep		- build perf with clang coverage, ready for a root test run'
+	@echo '  coverage		- build perf with clang coverage, run the tests and report'
+	@echo '			  (O=DIR uses an existing build dir; COVERAGE_ARGS="..." passes options)'
 
 
 DOC_TARGETS := doc man html info pdf
diff --git a/tools/perf/scripts/coverage.sh b/tools/perf/scripts/coverage.sh
new file mode 100755
index 0000000000000000..e9a4cf807850e1c7
--- /dev/null
+++ b/tools/perf/scripts/coverage.sh
@@ -0,0 +1,486 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2026, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#
+# Build perf with clang source based coverage, run the perf test suite and
+# report line coverage.
+# The build goes into tools/perf and the profiles and report into
+# tools/perf/cov; -b and -c override them, following perf's O= layout.
+# --prep stops after the instrumented build, for running the tests later as
+# root with the same build directory.
+
+set -euo pipefail
+
+PERF_DIR=$(cd "$(dirname "$0")/.." && pwd -P)
+TOOLS_DIR=$(cd "$PERF_DIR/.." && pwd -P)
+SRC_DIR=$(cd "$TOOLS_DIR/.." && pwd -P)
+
+BUILD_DIR=${BUILD_DIR:-}
+COV_DIR=${COV_DIR:-}
+JOBS=${JOBS:-$(nproc 2>/dev/null || echo 1)}
+LLVM_PROFDATA=${LLVM_PROFDATA:-llvm-profdata}
+LLVM_COV=${LLVM_COV:-llvm-cov}
+DWARF_VERSION=${DWARF_VERSION:-4}
+COVERAGE_CFLAGS="-fprofile-instr-generate -fcoverage-mapping -gdwarf-$DWARF_VERSION"
+
+PREP=0
+SKIP_BUILD=0
+SEQUENTIAL=0
+TEST_TIMEOUT=
+USE_BASELINE=1
+TESTS=()
+
+ROOT=0
+[ "$(id -u)" = 0 ] && ROOT=1
+
+say()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
+warn() { printf '\033[0;33mwarning:\033[0m %s\n' "$*" >&2; }
+die()  { printf '\033[0;31merror:\033[0m %s\n' "$*" >&2; exit 1; }
+
+usage()
+{
+	cat <<EOF
+Usage: scripts/coverage.sh [options] [test name fragment...]
+
+Builds perf with clang source based coverage, runs the complete perf test
+suite and reports line coverage.  Use -t to run a subset.
+
+Options:
+  -b, --build-dir DIR    existing perf build directory (default: $PERF_DIR)
+  -c, --cov-dir DIR      profiles and report (default: BUILD_DIR/cov)
+  -j, --jobs N           parallel build jobs (default: $JOBS)
+  -t, --tests "A;B"      test name fragments, ';' separated (default: all)
+      --no-baseline      do not compare against or update the baseline
+      --prep             build the instrumented perf and stop
+      --sequential       run the tests one at a time, not in parallel
+      --timeout SECS     timeout per test in seconds (default: 120)
+  -h, --help             show this help
+
+Environment: BUILD_DIR, COV_DIR, JOBS, LLVM_COV, LLVM_PROFDATA,
+DWARF_VERSION
+
+Through make:
+  make -C tools/perf coverage
+  make -C tools/perf coverage-prep O=/tmp/build/perf-coverage
+  sudo make -C tools/perf coverage O=/tmp/build/perf-coverage
+EOF
+}
+
+add_tests()
+{
+	local -a parts=()
+	local test
+
+	[ -n "$1" ] || die "--tests needs a test name"
+	IFS=';' read -r -a parts <<< "$1"
+	for test in "${parts[@]}"; do
+		# Keep spaces within names, not around the separators.
+		test="${test#"${test%%[![:space:]]*}"}"
+		test="${test%"${test##*[![:space:]]}"}"
+		[ -n "$test" ] || die "--tests needs a test name"
+		TESTS+=("$test")
+	done
+}
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+	--build-dir=*) BUILD_DIR=${1#*=} ;;
+	--cov-dir=*)   COV_DIR=${1#*=} ;;
+	--jobs=*)      JOBS=${1#*=} ;;
+	--tests=*)     add_tests "${1#*=}" ;;
+	-b|--build-dir) BUILD_DIR=${2:?$1 needs a value}; shift ;;
+	-c|--cov-dir)   COV_DIR=${2:?$1 needs a value}; shift ;;
+	-j|--jobs)      JOBS=${2:?$1 needs a value}; shift ;;
+	-t|--tests)     add_tests "${2:?$1 needs a value}"; shift ;;
+	--no-baseline)  USE_BASELINE=0 ;;
+	--prep)         PREP=1 ;;
+	--sequential)   SEQUENTIAL=1 ;;
+	--timeout=*)    TEST_TIMEOUT=${1#*=} ;;
+	--timeout)      TEST_TIMEOUT=${2:?$1 needs a value}; shift ;;
+	-h|--help)      usage; exit 0 ;;
+	-*)             die "unknown option: $1 (see --help)" ;;
+	*)              TESTS+=("$1") ;;
+	esac
+	shift
+done
+
+[ -n "$BUILD_DIR" ] || BUILD_DIR=$PERF_DIR
+BUILD_DIR=$(realpath -m "$BUILD_DIR")
+[ -d "$BUILD_DIR" ] ||
+	die "$BUILD_DIR does not exist; create it first, as with 'make O=DIR'"
+
+[ -n "$COV_DIR" ] || COV_DIR=$BUILD_DIR/cov
+COV_DIR=$(realpath -m "$COV_DIR")
+
+# An in-tree build has the sources below BUILD_DIR, so only a separate
+# build directory can tell generated files apart from the tree's sources.
+# llvm-cov strips the prefix the reported files have in common: strip the
+# one BUILD_DIR shares with the sources, as a suffix match would also
+# catch sources when BUILD_DIR ends in perf, as with O=~/build/perf.
+BUILD_AWK_DIR=
+if [ "$BUILD_DIR" != "$PERF_DIR" ]; then
+	BUILD_AWK_DIR=$(awk -v b="$BUILD_DIR" -v t="$TOOLS_DIR" 'BEGIN {
+		nb = split(b, B, "/")
+		nt = split(t, T, "/")
+		i = 1
+		while (i <= nb && i <= nt && B[i] == T[i])
+			i++
+		for (; i <= nb; i++)
+			out = out (out == "" ? "" : "/") B[i]
+		print out
+	}')
+fi
+
+[[ $JOBS =~ ^[0-9]+$ ]] || die "--jobs wants a number, not '$JOBS'"
+[[ $DWARF_VERSION =~ ^[0-9]+$ ]] ||
+	die "DWARF_VERSION wants a number, not '$DWARF_VERSION'"
+[ -z "$TEST_TIMEOUT" ] || [[ $TEST_TIMEOUT =~ ^[0-9]+$ ]] ||
+	die "--timeout wants a number, not '$TEST_TIMEOUT'"
+
+#
+# The tests execute $BUILD_DIR/perf, root included: refuse a directory
+# owned by somebody else or writable by another user.
+#
+TRUST_UID=$(id -u)
+if [ "$ROOT" = 1 ]; then
+	if [ -n "${SUDO_UID:-}" ]; then
+		TRUST_UID=$SUDO_UID
+	else
+		TRUST_UID=$(stat -c %u "$PERF_DIR" 2>/dev/null) ||
+			die "could not stat $PERF_DIR"
+	fi
+fi
+TRUST_GID=$(id -g "$TRUST_UID") ||
+	die "could not find the group of uid $TRUST_UID"
+
+check_owner()
+{
+	local path=$1 uid gid mode
+
+	[ -e "$path" ] || return 0
+	read -r uid gid mode < <(stat -c '%u %g %a' "$path" 2>/dev/null) ||
+		die "could not stat $path"
+	[ "$uid" = 0 ] || [ "$uid" = "$TRUST_UID" ] ||
+		die "$path is owned by uid $uid, not by root or uid $TRUST_UID"
+	[ $(( 8#$mode & 8#002 )) = 0 ] ||
+		die "$path is writable by another user"
+	# User private groups are the norm: umask 002 gives 775, where
+	# only the developer's own group can write.
+	if [ $(( 8#$mode & 8#020 )) != 0 ] &&
+	   [ "$gid" != "$TRUST_GID" ]; then
+		die "$path is writable by group $gid"
+	fi
+}
+
+check_owner "$BUILD_DIR"
+check_owner "$BUILD_DIR/perf"
+
+(umask 077 && mkdir -p "$COV_DIR") || die "could not create $COV_DIR"
+check_owner "$COV_DIR"
+
+# A sudo run leaves the profiles and report owned by root; give them back
+# to the developer so the next run can replace them.
+if [ "$ROOT" = 1 ] && [ -n "${SUDO_UID:-}" ]; then
+	trap 'chown -R "$SUDO_UID:${SUDO_GID:-$SUDO_UID}" "$COV_DIR" 2>/dev/null || true' EXIT
+fi
+
+BUILD_LOG=$COV_DIR/build.log
+TEST_LOG=$COV_DIR/tests.log
+REPORT=$COV_DIR/report.txt
+PROFDATA=$COV_DIR/perf.profdata
+BASELINE=$COV_DIR/baseline.txt
+
+#
+# Build: clang, DEBUG=1 gives -O0 -g, which keeps the line mapping honest
+# at the cost of slower test runs.
+#
+build_perf()
+{
+	local make_args=()
+
+	if [ "$SKIP_BUILD" = 1 ]; then
+		[ -x "$BUILD_DIR/perf" ] ||
+			die "no $BUILD_DIR/perf, run coverage-prep first"
+		if command -v nm > /dev/null; then
+			# No -q: grep reads all of nm's output, so pipefail
+			# does not see a SIGPIPE from an early exit.
+			nm "$BUILD_DIR/perf" 2>/dev/null |
+				grep '__llvm_profile' > /dev/null ||
+				die "$BUILD_DIR/perf was not built for coverage," \
+				    "run coverage-prep first"
+		else
+			warn "nm not found, cannot verify that $BUILD_DIR/perf is instrumented"
+		fi
+		return
+	fi
+
+	say "Building perf in $BUILD_DIR"
+	# The dlfilter and GTK link rules don't track compiler flags, and
+	# setuptools caches util/python.c by timestamp only, so a previous
+	# non-coverage build would leave them out of the profile.
+	rm -f "$BUILD_DIR"/dlfilters/*.o "$BUILD_DIR"/dlfilters/*.so \
+	      "$BUILD_DIR"/libperf-gtk.so "$BUILD_DIR"/python/perf*.so
+	rm -rf "$BUILD_DIR"/python_ext_build
+	[ "$BUILD_DIR" = "$PERF_DIR" ] || make_args+=(O="$BUILD_DIR")
+	if ! make -C "$PERF_DIR" "${make_args[@]+"${make_args[@]}"}" \
+		CC=clang CXX=clang++ HOSTCC=clang DEBUG=1 \
+		EXTRA_CFLAGS="$COVERAGE_CFLAGS" \
+		EXTRA_CXXFLAGS="$COVERAGE_CFLAGS" \
+		-j"$JOBS" > "$BUILD_LOG" 2>&1; then
+		tail -20 "$BUILD_LOG" >&2
+		die "build failed, full log in $BUILD_LOG"
+	fi
+	tail -1 "$BUILD_LOG"
+	# The extension just built is instrumented and stays in BUILD_DIR
+	# for the root runs on a prepared build; the setuptools object
+	# cache is dropped, as it keys on timestamps only and the next
+	# build, coverage or not, would reuse util/python.o as built here.
+	rm -rf "$BUILD_DIR"/python_ext_build
+}
+
+run_tests()
+{
+	if [ ${#TESTS[@]} -eq 0 ]; then
+		say "Running the complete perf test suite"
+	else
+		say "Running perf tests: ${TESTS[*]}"
+	fi
+	rm -rf "$COV_DIR/raw"
+	mkdir -p "$COV_DIR/raw"
+
+	local test_args=(-v)
+	[ "$SEQUENTIAL" = 0 ] || test_args+=(-S)
+	[ -z "$TEST_TIMEOUT" ] || test_args+=(-t "$TEST_TIMEOUT")
+
+	set +e
+	# The shell tests are found from the kernel tree root.
+	(cd "$SRC_DIR" &&
+		PATH="$BUILD_DIR:$PATH" \
+		LLVM_PROFILE_FILE="$COV_DIR/raw/perf-%p-%m.profraw" \
+			"$BUILD_DIR/perf" test "${test_args[@]}" \
+				"${TESTS[@]+"${TESTS[@]}"}") 2>&1 | tee "$TEST_LOG"
+	pipe_status=("${PIPESTATUS[@]}")
+	set -e
+	test_status=${pipe_status[0]}
+	[ "${pipe_status[1]}" = 0 ] ||
+		die "could not write $TEST_LOG"
+
+	# 'perf test' exits 0 even when tests fail or time out, only the
+	# summary tells.
+	if [ "$test_status" = 0 ] &&
+	   grep -qE '^(Failed|Timed out) tests +: +[1-9]' "$TEST_LOG"; then
+		test_status=1
+	fi
+
+	# It also exits 0 when the filter matches no test: every summary
+	# count is zero then.
+	if ! grep -qE '^(Passed main tests|Passed subtests|Skipped tests|Failed tests|Timed out tests) +: +[1-9]' "$TEST_LOG"; then
+		grep -E '^(Passed|Skipped|Failed|Timed out) .*:' "$TEST_LOG" || true
+		die "no perf test ran, check the test filter"
+	fi
+
+	grep -E '^(Passed|Skipped|Failed|Timed out) .*:' "$TEST_LOG" || true
+	[ "$test_status" = 0 ] ||
+		warn "some tests failed, coverage is still collected"
+}
+
+merge_profiles()
+{
+	local count size
+
+	# llvm-profdata reads the list from a file: a full run leaves
+	# thousands of profiles, too many for the command line.
+	find "$COV_DIR/raw" -name '*.profraw' | sort > "$COV_DIR/profiles.txt"
+	count=$(wc -l < "$COV_DIR/profiles.txt")
+	size=$(du -sh "$COV_DIR/raw" 2>/dev/null | cut -f1)
+	[ "$count" -gt 0 ] ||
+		die "no .profraw files, was perf rebuilt with -fprofile-instr-generate?"
+
+	say "Merging $count profile files ($size)"
+	if ! "$LLVM_PROFDATA" merge -sparse \
+			--input-files="$COV_DIR/profiles.txt" \
+			-o "$PROFDATA" 2> "$COV_DIR/merge.log"; then
+		# A profile left half written, by a perf killed at exit or by
+		# a full tmpfs, makes llvm-profdata drop the whole merge:
+		# retry without the invalid ones.
+		warn "some profile files are unusable, merging the rest"
+		"$LLVM_PROFDATA" merge -sparse --failure-mode=all \
+			--input-files="$COV_DIR/profiles.txt" -o "$PROFDATA" \
+			2> "$COV_DIR/merge.log" ||
+			die "llvm-profdata merge failed, see $COV_DIR/merge.log"
+	fi
+}
+
+llvm_cov_objects()
+{
+	echo "$BUILD_DIR/perf"
+	local so
+
+	# These are dlopened by perf and have to be profiled separately;
+	# libperf is linked into perf as a static library.
+	for so in libperf-gtk.so libperf-jvmti.so; do
+		[ -f "$BUILD_DIR/$so" ] && echo "--object=$BUILD_DIR/$so"
+	done
+	for so in "$BUILD_DIR"/dlfilters/*.so; do
+		[ -f "$so" ] && echo "--object=$so"
+	done
+	for so in "$BUILD_DIR"/python/perf*.so; do
+		[ -f "$so" ] && echo "--object=$so"
+	done
+}
+
+render_report()
+{
+	local objects
+
+	mapfile -t objects < <(llvm_cov_objects)
+	say "Generating report"
+	"$LLVM_COV" report "${objects[@]}" --instr-profile="$PROFDATA" \
+		> "$REPORT" || die "llvm-cov report failed"
+}
+
+# llvm-cov strips the prefix every reported file has in common, so a
+# tools/perf source can read as perf/util/evsel.c.
+AWK_PERF='
+function perf_relpath(p) {
+	sub(/^.*tools\/perf\//, "", p)
+	sub(/^perf\//, "", p)
+	return p
+}
+function under_build(p,    n) {
+	if (build == "")
+		return 0
+	n = length(build)
+	return substr(p, 1, n + 1) == build "/" ||
+	       substr(p, 1, n + 2) == "/" build "/"
+}
+function generated(p,    r) {
+	r = perf_relpath(p)
+	if (under_build(p))
+		return 1
+	return r ~ /^(lib(api|bpf|perf|subcmd|symbol)|trace\/beauty\/generated)\// ||
+	       r ~ /^arch\/[^\/]+\/include\/generated\// ||
+	       r ~ /^pmu-events\/(pmu-events(-string)?|test-empty-pmu-events)\.c$/ ||
+	       r ~ /^util\/(intel-pt-decoder\/inat-tables\.c|.*-(bison|flex)\.[ch])$/ ||
+	       r ~ /^util\/bpf_skel\/(\.tmp\/|vmlinux\.h$)/ ||
+	       r ~ /\.skel\.h$/ ||
+	       r == "common-cmds.h"
+}
+'
+
+total_cov()
+{
+	awk '$1 == "TOTAL" { print $8, $9, $10 }' "$1"
+}
+
+total_cov_perf()
+{
+	awk -v build="$BUILD_AWK_DIR" "$AWK_PERF"'
+		generated($1) { next }
+		$1 != "TOTAL" &&
+		($1 ~ /(^|\/)tools\/perf\// || $1 ~ /^perf\//) {
+			lines += $8
+			missed += $9
+		}
+		END {
+			if (lines)
+				printf "%d %d %.2f%%\n", lines, missed,
+					100 * (lines - missed) / lines
+		}' "$1"
+}
+
+since_baseline()
+{
+	local old cur
+
+	[ "$USE_BASELINE" = 1 ] && [ -f "$BASELINE" ] &&
+		! cmp -s "$BASELINE" "$REPORT" || return 0
+	old=$(awk '$1 == "TOTAL" { print $10 }' "$BASELINE")
+	cur=$(awk '$1 == "TOTAL" { print $10 }' "$REPORT")
+	[ -n "$old" ] && [ -n "$cur" ] || return 0
+	awk -v old="$old" -v cur="$cur" 'BEGIN {
+		sub(/%$/, "", cur)
+		printf "  (previous %s, %+.2f%%)", old, cur - old }'
+}
+
+print_summary()
+{
+	local lines missed cover p_lines p_missed p_cover
+
+	read -r lines missed cover < <(total_cov "$REPORT") ||
+		die "no TOTAL row in $REPORT"
+	printf "\n\033[1mTotal:\033[0m %s of %s lines covered (%s)" \
+		"$((lines - missed))" "$lines" "$cover"
+	since_baseline
+	printf "\n"
+
+	read -r p_lines p_missed p_cover < <(total_cov_perf "$REPORT") || true
+	if [ -n "$p_lines" ]; then
+		printf "  perf: %s of %s lines covered (%s)\n" \
+			"$((p_lines - p_missed))" "$p_lines" "$p_cover"
+	fi
+}
+
+update_baseline()
+{
+	[ "$USE_BASELINE" = 1 ] || return 0
+	# A -t run covers a subset, saving it would poison the next run.
+	if [ ${#TESTS[@]} -gt 0 ]; then
+		printf "\nBaseline not updated, this was a subset run\n"
+		return 0
+	fi
+	[ -f "$BASELINE" ] && mv "$BASELINE" "$BASELINE.prev"
+	cp "$REPORT" "$BASELINE"
+	printf "\nBaseline saved: %s\n" "$BASELINE"
+}
+
+if [ "$PREP" = 0 ]; then
+	command -v "$LLVM_COV" > /dev/null ||
+		die "$LLVM_COV not found (set LLVM_COV)"
+	command -v "$LLVM_PROFDATA" > /dev/null ||
+		die "$LLVM_PROFDATA not found (set LLVM_PROFDATA)"
+fi
+
+# Root does not rebuild a prepared build: use the perf already in
+# BUILD_DIR, or build when there is none.
+if [ "$ROOT" = 1 ] && [ "$PREP" = 0 ]; then
+	if [ -x "$BUILD_DIR/perf" ]; then
+		SKIP_BUILD=1
+		say "Running as root, using the coverage build in $BUILD_DIR"
+	else
+		say "Running as root, building perf in $BUILD_DIR"
+	fi
+fi
+
+if [ "$SKIP_BUILD" = 0 ]; then
+	command -v clang > /dev/null ||
+		die "clang not found, it is the only compiler with -fcoverage-mapping"
+	command -v clang++ > /dev/null ||
+		die "clang++ not found, it instruments the C++ sources"
+fi
+
+test_status=0
+
+if [ "$PREP" = 1 ]; then
+	build_perf
+	say "Coverage build ready: $BUILD_DIR/perf"
+	make_hint="make -C $PERF_DIR coverage"
+	[ "$BUILD_DIR" = "$PERF_DIR" ] || make_hint+=" O=$BUILD_DIR"
+	printf "As root: %s\n" "$make_hint"
+	exit 0
+fi
+
+build_perf
+run_tests
+merge_profiles
+
+[ -f "$PROFDATA" ] || die "no $PROFDATA, the merge did not run"
+
+export LC_ALL=C
+render_report
+print_summary
+update_baseline
+
+printf "\nReport:  %s\n" "$REPORT"
+exit "$test_status"
-- 
2.56.0

