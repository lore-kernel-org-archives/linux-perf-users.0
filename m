Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231308;
	b=hgLOsp3JEZfjBY5p0iPW2KksFj5MY+zRWs9Zy2dULv1kEXLYUYAqxJ7NcqUmS39FFRad
	 m8xB+oVsJCeMdRhWVlK45HdmK6323odKPgFooqOb8lt4VY+omAAMseJBL5JIiE7ck6y+P
	 EPu39Ie9/0KwR5upKnu/YeOCztSgWug11cvEImZH83JZa2iCOeHETAxBlGeDFH4jkZjQs
	 sQQcGdEKdOZru71i8R1+APKaDlbZ/Gx5l5K+oMiNXQ7rJfgIuUduizhtsnV6WB1ERdoZv
	 fm4CuvkfwiiuBFvXR/s9VNjS6AOgzOVEou2355Ma1myyQNreh2grjYlHSKjBPt+c6Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231308;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=njnvtRg+Kot7Mto74ish0mhJm/kH+oLgUK/Xx+KPkwc=;
	b=Ck3m1IBPE/cfIL0foSsXuPpw1pT3vndCMEsjfullQjy4m2+I7hpruGgj6CEgu4kGrndV
	 JuqpdoXM1iqRQaUWiUdgvkYyXOJXk8kykj5zlELrkoy3usQYi1TF7iCOqQFC8798KSkca
	 wyo9wgOj48740VuT8dh0W8Qr2kOWaUeVZVEAv2ntM5KJlxY1VKwN6/iSoIwUukrRKSMpP
	 sB1A6j4wG9gGt3FnQN0Xh/MXYXGsl90oZGzaig+/kTen9BziNXm1I9PjSIjiOo+8Fje0V
	 9dIj/22JpSuXCcrOFOFcigntGSh9VXpKivBBo0tgScK9WzfFd11Eo1GLQ5Xsp3YRyew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3QHPF5G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42A9606A692;
	Sat, 21 Nov 2026 03:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3QHPF5G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE291F000C4;
	Sat, 21 Nov 2026 03:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231308;
	bh=njnvtRg+Kot7Mto74ish0mhJm/kH+oLgUK/Xx+KPkwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l3QHPF5GvCuu4p1L7XDP6pOoInwJOCRbeq8aMR+65OJTnr2f/5+BDyNpwg3wh6+Y2
	 MJ2mBLwUQQl466iSbQlwpEmc2+qNszOsqkyrF3Ge+1pJCx7VyO/nErGhv8etppaTIw
	 JsLeummmPaVkU9Z2lnwN/UPCSlKSmJHYm56sHje8E+Cu6JX973PGYy3M4mgxKngl3t
	 mn3VC2WSBQHwpuzBEaHO2gGGro3i0FTdJ4ntWwWM6KifjDwqCUgam6cCE94I9E+UUc
	 3OCTawICI2KGbxHw4vPKM/tzN+5Cv4GFJlwifvlc8wKtaPmfav7wij7tB1slOBf9Pi
	 WM0Kpsp8LErAQ==
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
Subject: [PATCH v10 15/16] perf scripts: Add a coverage harness for perf
Date: Sat, 21 Nov 2026 00:20:51 -0300
Message-ID: <20261121032052.1392234-16-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121032052.1392234-1-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
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

The report covers the whole tree, not only the paths the tests walk.
The static libbpf build inherits EXTRA_CFLAGS, and the dlopened UI,
jvmti, Python and dlfilter libraries are passed to llvm-cov as separate
objects.  'perf test' exits 0 even when tests fail, so the status comes
from its "Failed tests :" and "Timed out tests :" lines.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/.gitignore          |   1 +
 tools/perf/Makefile            |  12 +-
 tools/perf/Makefile.perf       |   5 +-
 tools/perf/scripts/coverage.sh | 434 +++++++++++++++++++++++++++++++++
 4 files changed, 450 insertions(+), 2 deletions(-)
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
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d4b641925ab296db..f32c96be3f464ed2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
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
index 0000000000000000..1d49b09258818762
--- /dev/null
+++ b/tools/perf/scripts/coverage.sh
@@ -0,0 +1,434 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2026, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#
+# Build perf with clang source based coverage, run the perf test suite and
+# report line coverage.  coverage-table.sh renders the last report as a
+# table of the files with the most uncovered lines.
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
+# perf links objects from these directories, so a change in any of them
+# makes the build stale.
+PERF_SOURCES=("$PERF_DIR" "$TOOLS_DIR/lib/perf" "$TOOLS_DIR/lib/api"
+	      "$TOOLS_DIR/lib/subcmd" "$TOOLS_DIR/lib/bpf"
+	      "$TOOLS_DIR/lib/symbol" "$TOOLS_DIR/include"
+	      "$TOOLS_DIR/arch")
+
+BUILD_DIR=${BUILD_DIR:-}
+COV_DIR=${COV_DIR:-}
+JOBS=${JOBS:-$(nproc 2>/dev/null || echo 1)}
+LLVM_PROFDATA=${LLVM_PROFDATA:-llvm-profdata}
+LLVM_COV=${LLVM_COV:-llvm-cov}
+DWARF_VERSION=${DWARF_VERSION:-4}
+
+PREP=0
+SKIP_BUILD=0
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
+suite and reports line coverage.  Use -t to run a subset and
+scripts/coverage-table.sh to render the last report as a table.
+
+Options:
+  -b, --build-dir DIR    existing perf build directory (default: $PERF_DIR)
+  -c, --cov-dir DIR      profiles and report (default: BUILD_DIR/cov)
+  -j, --jobs N           parallel build jobs (default: $JOBS)
+  -t, --tests "A;B"      test name fragments, ';' separated (default: all)
+      --no-baseline      do not compare against or update the baseline
+      --prep             build the instrumented perf and stop
+  -h, --help             show this help
+
+Environment: BUILD_DIR, COV_DIR, JOBS, LLVM_COV, LLVM_PROFDATA,
+DWARF_VERSION
+
+Through make:
+  make -C tools/perf coverage
+  make -C tools/perf coverage-prep O=/tmp/build/perf-coverage
+  sudo make -C tools/perf coverage O=/tmp/build/perf-coverage
+  make -C tools/perf coverage-table O=/tmp/build/perf-coverage
+EOF
+}
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+	--build-dir=*) BUILD_DIR=${1#*=} ;;
+	--cov-dir=*)   COV_DIR=${1#*=} ;;
+	--jobs=*)      JOBS=${1#*=} ;;
+	--tests=*)     IFS=';' read -r -a _t <<< "${1#*=}"
+		       TESTS+=("${_t[@]}") ;;
+	-b|--build-dir) BUILD_DIR=${2:?$1 needs a value}; shift ;;
+	-c|--cov-dir)   COV_DIR=${2:?$1 needs a value}; shift ;;
+	-j|--jobs)      JOBS=${2:?$1 needs a value}; shift ;;
+	-t|--tests)     IFS=';' read -r -a _t <<< "${2:?$1 needs a value}"
+			TESTS+=("${_t[@]}"); shift ;;
+	--no-baseline)  USE_BASELINE=0 ;;
+	--prep)         PREP=1 ;;
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
+BUILD_AWK_DIR=$BUILD_DIR
+[ "$BUILD_DIR" = "$PERF_DIR" ] && BUILD_AWK_DIR=
+
+[[ $JOBS =~ ^[0-9]+$ ]] || die "--jobs wants a number, not '$JOBS'"
+[[ $DWARF_VERSION =~ ^[0-9]+$ ]] ||
+	die "DWARF_VERSION wants a number, not '$DWARF_VERSION'"
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
+	[ $(( 8#$mode & 8#022 )) = 0 ] ||
+		die "$path is writable by another user"
+}
+
+check_owner "$BUILD_DIR"
+check_owner "$BUILD_DIR/perf"
+
+mkdir -p "$COV_DIR" || die "could not create $COV_DIR"
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
+	[ "$BUILD_DIR" = "$PERF_DIR" ] || make_args+=(O="$BUILD_DIR")
+	if ! make -C "$PERF_DIR" "${make_args[@]+"${make_args[@]}"}" \
+		CC=clang DEBUG=1 \
+		EXTRA_CFLAGS="-fprofile-instr-generate -fcoverage-mapping -gdwarf-$DWARF_VERSION" \
+		-j"$JOBS" > "$BUILD_LOG" 2>&1; then
+		tail -20 "$BUILD_LOG" >&2
+		die "build failed, full log in $BUILD_LOG"
+	fi
+	tail -1 "$BUILD_LOG"
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
+	set +e
+	# The shell tests are found from the kernel tree root.
+	(cd "$SRC_DIR" &&
+		PATH="$BUILD_DIR:$PATH" \
+		LLVM_PROFILE_FILE="$COV_DIR/raw/perf-%p-%m.profraw" \
+			"$BUILD_DIR/perf" test -v \
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
+function under_build(p,    b, n) {
+	if (build == "")
+		return 0
+	b = build
+	while (1) {
+		n = length(b)
+		if (substr(p, 1, n + 1) == b "/")
+			return 1
+		if (index(b, "/") == 0)
+			return 0
+		sub(/^[^\/]*\//, "", b)
+		if (b == "")
+			return 0
+	}
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
+if [ "$SKIP_BUILD" = 0 ]; then
+	command -v clang > /dev/null ||
+		die "clang not found, it is the only compiler with -fcoverage-mapping"
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
+printf "Table:   %s/scripts/coverage-table.sh\n" "$PERF_DIR"
+exit "$test_status"
-- 
2.56.0

