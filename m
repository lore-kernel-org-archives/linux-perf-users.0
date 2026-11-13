Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600540;
	b=pyrT8et1zWTsPj9drrUqrEAuRXLs0IEAo2bOOPj/IObpYDA+lDSGGKEuB1+L/86q7aro
	 luNMTVVpXlYMM9tGW6fU8p/p78rmfrLTu87xH1Co27e+yC3CDxFoTfOq/sSgRJgKrTmPK
	 zXT/6tajImoiXYFaO5gANhXGN9B7KeTgcRsSXXtCKxvG1rTXC9ro+DIiCm5utNmuw0A4b
	 N3v6JgZHZNW5/zkfas5/aDFxMFJaocnYztTwD8uQxW7+jAZPfJtqj0ZD5VtA1PpDMn60R
	 T7mTkRUj5Svwg3daUElCWptkj3w7VlaMUt9TnvLIHPplCQOvR/6UeK44r/8OSjEhiFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600540;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mzwDOznyxp+5CF05Ul4OUhwTrYJLzhVA6z9vI4CfvZg=;
	b=0Fp7T/8NHtQr4mNXFFDz7d1SX5FGd4YgcjVWIkqrPRIQi0sSBUDGH6dx0hFROrbUokm2
	 emTCOfUFvzka85oVIE2lrztng1tR7QdtV50pFwZ1SUiEBETKaSX53IUYD3rAgwoj+JNbS
	 lxywF5CwE+lo9qCFqJtRBIq3bJZ3GdXkvxGRFQCCON62Z/ayuCwoyTUHoZIJsv4i24bVD
	 1i3KkzLaoj/Oz5nfUo08S99UzAPyiAw6XWGjtDs+C9eWXzXymaGQw7dBPbpX/f0QQ6OA5
	 i3abLXFMAm5iFXdlcpGFLM9AMqxMiNAkM9hdBj7l4FSbKLDpigkbMutITOxJEkavPHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsawTenU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318D606A881;
	Fri, 13 Nov 2026 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsawTenU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036451F000C5;
	Fri, 13 Nov 2026 20:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600540;
	bh=mzwDOznyxp+5CF05Ul4OUhwTrYJLzhVA6z9vI4CfvZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bsawTenUlUFulYED4TfNy2JTFcEWLQeCgzwSZPZWovadTMPGgGWO+u5QwdzePOQHI
	 TckKEPaG7XpqQQn1GBEgGMRZhHv9YHukg95+NV8Ref2mg666EsZE6h6py1CuavJVDF
	 6G0h/a6+YIhC87hW5jcc8U/jIn8d4y4XUDCs+uglOmhMaXQ4nExPUE6sK5E8OCNHmv
	 tZ/gkkiRSNPGwxFOJvL2g180TUNU5gWhAw8ZtaHIOPS0VmiYQwDmx56GpW2tMcpJjI
	 j8gN3KY7muJzSYHj2NlsJMkWvBxXlKaL0BMBUlAmEnkvXX5bl7VPoJlvLZzMr7mqSN
	 E7GM4iehS4JXQ==
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
Subject: [PATCH v2 01/11] perf scripts: Add a coverage harness for perf
Date: Fri, 13 Nov 2026 17:08:39 -0300
Message-ID: <20261113200850.2803460-2-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113200850.2803460-1-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Build perf with clang source based coverage, run the complete perf test
suite, merge the raw profiles and report line and function coverage for
perf, optionally against a baseline.  This is pahole's
coverage/coverage.sh + coverage-diff.sh merged into one script, wired as
'make -C tools/perf coverage' and listed in 'make help'.

Without -f the report lists the files with the most uncovered lines,
which is where new tests should try to get more coverage; -t narrows
the tests, -f focuses on specific files, --html writes a browsable
report and --table/-T, also available as 'make -C tools/perf
coverage-table', prints the last run as an ASCII table with the
per-file line and function coverage, like pahole's coverage_table.py.

The build can be split from the test run: 'make -C tools/perf
coverage-prep' builds the instrumented perf and records the build
directory, and a later run as root, which needs no make, checks that
build, runs the tests and renders the report, or prints the table with
--table.  This is for running the tests that need root on the bare
metal host while the instrumented perf is built in the development
container.

It is a maintainer tool and it already paid for itself: the first run
found the clang DWARF 5 data type test failing (the DW_OP_addrx gap,
fixed by the next patch), and the uncovered line list is what drove the
tests in the rest of the series.

  $ scripts/coverage.sh
  ...
  Total: 67436 of 201128 lines covered (33.53%)

    largest uncovered files (>= 100 lines)
    file                                            lines     cover    missed  fn-cover
    builtin-trace.c                                  3657     4.24%      3502     0.51%
    util/intel-pt.c                                  3237     0.00%      3237     0.00%
    util/intel-pt-decoder/intel-pt-decoder.c         3208     0.00%      3208     0.00%
    builtin-sched.c                                  3737    19.72%      3000    11.35%
    ui/browsers/hists.c                              2730     0.00%      2730     0.00%
    util/probe-event.c                               2765     5.39%      2616    10.68%
    builtin-script.c                                 3212    29.98%      2249    33.06%
    ...
  Report:  /tmp/build/perf-coverage/cov/report.txt

The run above was unprivileged, so tests that need root are skipped or
fail; the report still points at the gaps.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/.gitignore          |   1 +
 tools/perf/Makefile            |  11 +-
 tools/perf/Makefile.perf       |   4 +
 tools/perf/scripts/coverage.sh | 722 +++++++++++++++++++++++++++++++++
 4 files changed, 737 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/scripts/coverage.sh

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 3b968c5158b822ce..9052f25597ac9489 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -27,6 +27,7 @@ stats-*.csv
 cscope*
 config.mak
 config.mak.autogen
+.coverage-build-dir
 *-bison.*
 *-flex.*
 *.pyc
diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 00baf90e5bda7123..8df8e9ed37f0a8f5 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -140,6 +140,15 @@ check-headers:
 sync-headers:
 	@./scripts/sync-headers.sh $(SYNC_HEADERS_ARGS)
 
+coverage-prep:
+	@./scripts/coverage.sh --prep $(if $(FULL_O),--build-dir=$(FULL_O)) $(COVERAGE_ARGS)
+
+coverage:
+	@./scripts/coverage.sh $(if $(FULL_O),--build-dir=$(FULL_O)) $(COVERAGE_ARGS)
+
+coverage-table:
+	@./scripts/coverage.sh --table $(if $(FULL_O),--build-dir=$(FULL_O)) $(COVERAGE_ARGS)
+
 #
 # All other targets get passed through:
 #
@@ -147,4 +156,4 @@ sync-headers:
 	$(print_msg)
 	$(make)
 
-.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball check-headers sync-headers
+.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball check-headers sync-headers coverage coverage-prep coverage-table
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b74b534e1153ffcb..782929b0ba10d8f3 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -873,6 +873,10 @@ help:
 	@echo '  check-headers		- check which header copies are out of sync with the kernel'
 	@echo '  sync-headers		- sync those header copies with the kernel, creating commits'
 	@echo '			  (SYNC_HEADERS_ARGS="..." passes options to the script)'
+	@echo '  coverage-prep		- build perf with clang coverage, ready for a root test run'
+	@echo '  coverage		- build perf with clang coverage, run the tests and report'
+	@echo '  coverage-table	- print an ASCII table of the last coverage run'
+	@echo '			  (COVERAGE_ARGS="..." passes options to the script)'
 
 
 DOC_TARGETS := doc man html info pdf
diff --git a/tools/perf/scripts/coverage.sh b/tools/perf/scripts/coverage.sh
new file mode 100755
index 0000000000000000..2f248d61a733938a
--- /dev/null
+++ b/tools/perf/scripts/coverage.sh
@@ -0,0 +1,722 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2026, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#
+# LLVM source-based coverage for perf: build with clang instrumentation,
+# run the complete perf test suite and report line/function coverage for
+# perf, optionally comparing it against a previously saved report.  -t
+# narrows the tests and -f adds files to the per-file table; without -f
+# the report lists the files with the most uncovered lines, which is
+# where new tests are needed.  --table prints the last run as an ASCII
+# coverage table, like pahole's coverage_table.py.  The build can be
+# split from the test run: --prep builds the instrumented perf and
+# records the build directory, and a later run as root uses that build,
+# skips the build and goes straight to the tests.  The sampling based
+# tests move the percentages by a percent or two between identical runs.
+
+set -euo pipefail
+
+# awk prints dots and printf/sort parse them: keep the numeric locale fixed
+# so --table doesn't abort where the decimal separator is a comma.
+export LC_ALL=C
+
+PERF_DIR=$(cd "$(dirname "$0")/.." && pwd)
+
+DEFAULT_BUILD_DIR=/tmp/build/perf-coverage
+BUILD_DIR=${BUILD_DIR:-}
+COV_DIR=${COV_DIR:-}
+BUILD_DIR_SET=0
+COV_DIR_SET=0
+[ -n "$BUILD_DIR" ] && BUILD_DIR_SET=1
+[ -n "$COV_DIR" ] && COV_DIR_SET=1
+JOBS=${JOBS:-$(nproc 2>/dev/null || echo 1)}
+LLVM_PROFDATA=${LLVM_PROFDATA:-llvm-profdata}
+LLVM_COV=${LLVM_COV:-llvm-cov}
+
+DEBUG_BUILD=1
+SKIP_BUILD=0
+REPORT_ONLY=0
+PREP=0
+TABLE=0
+HTML=0
+USE_BASELINE=1
+BASELINE=
+UNCOVERED=${UNCOVERED:-20}
+TOP=${TOP:-20}
+MIN_LINES=${MIN_LINES:-100}
+DWARF_VERSION=${DWARF_VERSION:-4}
+TESTS=()
+
+FOCUS=()
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
+Builds perf with clang source-based coverage, runs the complete perf
+test suite and reports coverage for perf.  Use -t to run a subset and
+-f to focus the per-file table.
+
+Options:
+  -b, --build-dir DIR    perf build directory (default: $DEFAULT_BUILD_DIR)
+  -c, --cov-dir DIR      profiles and reports (default: BUILD_DIR/cov)
+  -j, --jobs N           parallel build jobs (default: $JOBS)
+  -t, --tests "A;B"      test name fragments, ';' separated (default: all)
+  -f, --focus FILE       add a file to the per-file table (repeatable)
+      --top N            when no -f is given, show the N files with the
+                         most uncovered lines (default: $TOP, 0 to disable)
+      --baseline FILE    baseline report (default: COV_DIR/baseline.txt)
+      --no-baseline      do not compare against or update a baseline
+      --uncovered N      uncovered line numbers per focus file (default: $UNCOVERED)
+      --skip-build       reuse the existing build, just run the tests
+      --report-only      reuse build and profiles, just render the report
+      --prep             build the instrumented perf and stop; run the
+                         tests later as root with this script
+  -T, --table            print an ASCII table of the last run and exit,
+                         like pahole's coverage_table.py
+      --optimized        build with perf's default -O3 instead of -O0 -g
+      --dwarf-version N  DWARF version for the instrumented build (default: $DWARF_VERSION)
+      --html             also write an HTML report
+  -h, --help             show this help
+
+Environment:
+  BUILD_DIR, COV_DIR, JOBS, LLVM_COV, LLVM_PROFDATA, UNCOVERED, TOP,
+  MIN_LINES, DWARF_VERSION
+
+As root, without --prep, the script skips the build, checks the perf
+prepared by 'make coverage-prep', runs the tests and renders the
+report.  The prepared build is recorded in tools/perf/.coverage-build-dir.
+
+Through make:
+  make -C tools/perf coverage COVERAGE_ARGS="-t 'perf annotate'"
+  make -C tools/perf coverage-prep O=/tmp/build/perf-tools-next
+  make -C tools/perf coverage-table
+
+Examples:
+  scripts/coverage.sh                       # full suite, fresh build
+  scripts/coverage.sh --prep                # build only, test later as root
+  scripts/coverage.sh --report-only         # re-render the last run
+  scripts/coverage.sh --table               # ASCII table of the last run
+  scripts/coverage.sh -t "perf annotate"    # a single test fragment
+  scripts/coverage.sh -f util/evsel.c       # add a file to the table
+EOF
+}
+
+while [ $# -gt 0 ]; do
+	arg=$1
+	optval=
+	case "$arg" in
+	--*=*) optval=${arg#*=}; arg=${arg%%=*} ;;
+	esac
+
+	case "$arg" in
+	-b|--build-dir)   BUILD_DIR=${optval:-${2?missing value}}; BUILD_DIR_SET=1
+	                  [ -z "$optval" ] && shift ;;
+	-c|--cov-dir)     COV_DIR=${optval:-${2?missing value}}; COV_DIR_SET=1
+	                  [ -z "$optval" ] && shift ;;
+	-j|--jobs)        JOBS=${optval:-${2?missing value}}; [ -z "$optval" ] && shift ;;
+	-f|--focus)       FOCUS+=("${optval:-${2?missing value}}"); [ -z "$optval" ] && shift ;;
+	--baseline)       BASELINE=${optval:-${2?missing value}}; [ -z "$optval" ] && shift ;;
+	--uncovered)      UNCOVERED=${optval:-${2?missing value}}; [ -z "$optval" ] && shift ;;
+	--top)            TOP=${optval:-${2?missing value}}; [ -z "$optval" ] && shift ;;
+	--dwarf-version)  DWARF_VERSION=${optval:-${2?missing value}}; [ -z "$optval" ] && shift ;;
+	-t|--tests)       IFS=';' read -r -a _t <<< "${optval:-${2?missing value}}"
+	                  TESTS+=("${_t[@]}"); [ -z "$optval" ] && shift ;;
+	--no-baseline)    USE_BASELINE=0 ;;
+	--skip-build)     SKIP_BUILD=1 ;;
+	--report-only)    REPORT_ONLY=1; SKIP_BUILD=1 ;;
+	--prep)           PREP=1 ;;
+	-T|--table)       TABLE=1; REPORT_ONLY=1; SKIP_BUILD=1 ;;
+	--optimized)      DEBUG_BUILD=0 ;;
+	--html)           HTML=1 ;;
+	-h|--help)        usage; exit 0 ;;
+	-*)               die "unknown option: $arg (see --help)" ;;
+	*)                TESTS+=("$arg") ;;
+	esac
+	shift
+done
+
+#
+# The build directory is recorded by --prep (and by a full run) so a
+# later root run, which does not build, finds it without arguments.
+#
+if [ "$BUILD_DIR_SET" = 0 ] && [ -z "$BUILD_DIR" ] && [ "$PREP" = 0 ] &&
+   { [ "$ROOT" = 1 ] || [ "$SKIP_BUILD" = 1 ] ||
+     [ "$REPORT_ONLY" = 1 ] || [ "$TABLE" = 1 ]; } &&
+   [ -f "$PERF_DIR/.coverage-build-dir" ]; then
+	read -r BUILD_DIR < "$PERF_DIR/.coverage-build-dir"
+fi
+[ -n "$BUILD_DIR" ] || BUILD_DIR=$DEFAULT_BUILD_DIR
+
+if [ "$COV_DIR_SET" = 0 ] && [ -z "$COV_DIR" ] &&
+   [ -f "$BUILD_DIR/cov/state" ]; then
+	COV_DIR=$(awk -F= '$1 == "COV_DIR" { print $2; exit }' \
+		"$BUILD_DIR/cov/state")
+fi
+[ -n "$COV_DIR" ] || COV_DIR=$BUILD_DIR/cov
+
+# The tests run from the kernel tree root, so keep these absolute.
+abspath()
+{
+	case "$1" in
+	/*) printf '%s\n' "$1" ;;
+	*)  printf '%s/%s\n' "$PWD" "$1" ;;
+	esac
+}
+BUILD_DIR=$(abspath "$BUILD_DIR")
+COV_DIR=$(abspath "$COV_DIR")
+
+[ -n "$BASELINE" ] || BASELINE=$COV_DIR/baseline.txt
+[[ $TOP =~ ^[0-9]+$ ]] || die "--top wants a number, not '$TOP'"
+[[ $MIN_LINES =~ ^[0-9]+$ ]] || die "MIN_LINES wants a number, not '$MIN_LINES'"
+
+# Root does not build: use the perf prepared by coverage-prep.
+if [ "$ROOT" = 1 ] && [ "$PREP" = 0 ] && [ "$TABLE" = 0 ]; then
+	SKIP_BUILD=1
+	say "Running as root, using the coverage build in $BUILD_DIR"
+fi
+
+BUILD_LOG=$COV_DIR/build.log
+TEST_LOG=$COV_DIR/tests.log
+REPORT=$COV_DIR/report.txt
+PROFDATA=$COV_DIR/perf.profdata
+# Discovery point for a later root or --table run, so it stays under
+# BUILD_DIR even when --cov-dir points elsewhere.
+STATE_FILE=$BUILD_DIR/cov/state
+POINTER=$PERF_DIR/.coverage-build-dir
+
+#
+# Sanity checks
+#
+[ -d "$PERF_DIR" ] || die "$PERF_DIR not found"
+
+if [ "$TABLE" = 0 ]; then
+	if [ "$PREP" = 0 ]; then
+		command -v "$LLVM_COV" > /dev/null ||
+			die "$LLVM_COV not found (set LLVM_COV)"
+	fi
+	if [ "$SKIP_BUILD" = 0 ]; then
+		command -v clang > /dev/null ||
+			die "clang not found, it is the only compiler with -fcoverage-mapping"
+	fi
+	if [ "$PREP" = 0 ] && [ "$REPORT_ONLY" = 0 ]; then
+		command -v "$LLVM_PROFDATA" > /dev/null ||
+			die "$LLVM_PROFDATA not found (set LLVM_PROFDATA)"
+	fi
+	mkdir -p "$COV_DIR"
+fi
+
+#
+# Build: clang, DEBUG=1 gives -O0 -g like pahole's coverage build, which
+# keeps the line mapping honest at the cost of slower test runs.  DWARF 4
+# is the default; --dwarf-version 5 describes the workloads linked into
+# perf with DW_OP_addrx, the encoding clang uses for globals in DWARF 5.
+#
+check_coverage_build()
+{
+	[ -x "$BUILD_DIR/perf" ] ||
+		die "no $BUILD_DIR/perf, run 'make -C $PERF_DIR O=$BUILD_DIR coverage-prep' first"
+	if command -v nm > /dev/null; then
+		# No -q: grep reads all of nm's output, so pipefail does
+		# not see a SIGPIPE from an early exit.
+		nm "$BUILD_DIR/perf" 2>/dev/null |
+			grep '__llvm_profile' > /dev/null ||
+			die "$BUILD_DIR/perf was not built for coverage, run coverage-prep"
+	else
+		warn "nm not found, cannot verify that $BUILD_DIR/perf is instrumented"
+	fi
+}
+
+write_state()
+{
+	mkdir -p "$(dirname "$STATE_FILE")" ||
+		die "could not create $(dirname "$STATE_FILE")"
+	{
+		printf 'BUILD_DIR=%s\n' "$BUILD_DIR"
+		printf 'COV_DIR=%s\n' "$COV_DIR"
+		printf 'DEBUG_BUILD=%s\n' "$DEBUG_BUILD"
+		printf 'DWARF_VERSION=%s\n' "$DWARF_VERSION"
+	} > "$STATE_FILE" || die "could not write $STATE_FILE"
+
+	if ! printf '%s\n' "$BUILD_DIR" > "$POINTER" 2>/dev/null; then
+		warn "could not write $POINTER, root runs will need -b $BUILD_DIR"
+	fi
+}
+
+build_perf()
+{
+	if [ "$SKIP_BUILD" = 1 ]; then
+		check_coverage_build
+		return
+	fi
+
+	say "Building perf in $BUILD_DIR"
+	mkdir -p "$BUILD_DIR"
+	local debug=()
+	[ "$DEBUG_BUILD" = 1 ] && debug=(DEBUG=1)
+
+	if ! make -C "$PERF_DIR" O="$BUILD_DIR" CC=clang \
+		"${debug[@]+"${debug[@]}"}" \
+		EXTRA_CFLAGS="-fprofile-instr-generate -fcoverage-mapping -gdwarf-$DWARF_VERSION" \
+		-j"$JOBS" > "$BUILD_LOG" 2>&1; then
+		tail -20 "$BUILD_LOG" >&2
+		die "build failed, full log in $BUILD_LOG"
+	fi
+	tail -1 "$BUILD_LOG"
+	write_state
+}
+
+#
+# Run the selected tests with the instrumented perf in PATH: the shell
+# tests, the workloads and 'perf test' itself all come from there.
+#
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
+	# The shell tests only get discovered from the kernel tree root.
+	(cd "$PERF_DIR/../.." &&
+		PATH="$BUILD_DIR:$PATH" \
+		LLVM_PROFILE_FILE="$COV_DIR/raw/perf-%p-%m.profraw" \
+			"$BUILD_DIR/perf" test -v \
+				"${TESTS[@]+"${TESTS[@]}"}") 2>&1 | tee "$TEST_LOG"
+	test_status=${PIPESTATUS[0]}
+	set -e
+
+	# 'perf test' exits 0 even when tests fail, only the summary tells.
+	if [ "$test_status" = 0 ] && grep -qE '^Failed tests +: +[1-9]' "$TEST_LOG"; then
+		test_status=1
+	fi
+
+	grep -E '^(Passed|Skipped|Failed) .*:' "$TEST_LOG" || true
+	[ "$test_status" = 0 ] ||
+		warn "some tests failed or were skipped, coverage is still collected"
+	if [ "$test_status" != 0 ] && grep -q 'Access to performance monitoring' "$TEST_LOG"; then
+		warn "perf_event_paranoid=$(cat /proc/sys/kernel/perf_event_paranoid 2>/dev/null)" \
+		     "denied events to tests recording with callchains;" \
+		     "run as root or lower it for the full suite"
+	fi
+}
+
+#
+# Merge the per-process profiles and render the text report.
+#
+merge_profiles()
+{
+	local count size
+	count=$(find "$COV_DIR/raw" -name '*.profraw' | wc -l)
+	size=$(du -sh "$COV_DIR/raw" 2>/dev/null | cut -f1)
+	[ "$count" -gt 0 ] ||
+		die "no .profraw files, was perf rebuilt with -fprofile-instr-generate?"
+
+	say "Merging $count profile files ($size)"
+	"$LLVM_PROFDATA" merge -sparse "$COV_DIR"/raw/*.profraw -o "$PROFDATA" ||
+		die "llvm-profdata merge failed"
+}
+
+llvm_cov_objects()
+{
+	echo "$BUILD_DIR/perf"
+	local so
+	for so in perf.so libperf.so libperf-jvmti.so; do
+		[ -f "$BUILD_DIR/$so" ] && echo "--object=$BUILD_DIR/$so"
+	done
+	# The Python extension is named after the interpreter ABI and lives
+	# in its own directory.
+	for so in "$BUILD_DIR"/python/perf*.so; do
+		[ -f "$so" ] && echo "--object=$so"
+	done
+}
+
+render_report()
+{
+	local objects
+	mapfile -t objects < <(llvm_cov_objects)
+
+	say "Generating report"
+	"$LLVM_COV" report "${objects[@]}" --instr-profile="$PROFDATA" > "$REPORT"
+}
+
+#
+# Line coverage of a full report for one file: "lines missed cover fn%".
+# Report paths are relative to the build directory, so match the requested
+# path as a suffix: a build outside the source tree gives
+# ".../tools/perf/..." and one inside gives "tools/perf/...".
+#
+# -f takes the path as it shows in the report, or a tools/perf/ relative one.
+focus_path()
+{
+	case "$1" in
+	*tools/perf/*) printf '%s\n' "${1#*tools/perf/}" ;;
+	*) printf '%s\n' "$1" ;;
+	esac
+}
+
+file_cov()
+{
+	awk -v f="$2" '
+		function perf_relpath(p) {
+			if (p ~ /(^|\/)tools\/perf\//)
+				sub(/^.*tools\/perf\//, "", p)
+			return p
+		}
+		{
+			g = f
+			sub(/^.*tools\/perf\//, "", g)
+			rel = perf_relpath($1)
+			if (rel == f || rel == g || $1 == f) {
+				print $8, $9, $10, $7
+				exit
+			}
+		}' "$1"
+}
+
+total_cov()
+{
+	awk '$1 == "TOTAL" { print $8, $9, $10 }' "$1"
+}
+
+total_delta()
+{
+	local prev=$1 cur=$2 old cur_cov
+	[ -f "$prev" ] || return 0
+	old=$(total_cov "$prev" | awk '{print $3}')
+	cur_cov=$(total_cov "$cur" | awk '{print $3}')
+	[ -n "$old" ] && [ -n "$cur_cov" ] || return 0
+	awk -v cur="$cur_cov" -v old="$old" 'BEGIN {
+		sub(/%$/, "", cur); sub(/%$/, "", old)
+		printf "%+.2f%%", cur - old }'
+}
+
+report_delta()
+{
+	local prev=$1 cur=$2 label
+	local cur_cov old_cov delta
+	label=$(focus_path "$3")
+	cur_cov=$(file_cov "$cur" "$label" | awk '{print $3}')
+	[ -n "$cur_cov" ] || return 0
+
+	if [ -f "$prev" ]; then
+		old_cov=$(file_cov "$prev" "$label" | awk '{print $3}')
+		if [ -n "$old_cov" ]; then
+			delta=$(awk -v cur="$cur_cov" -v old="$old_cov" 'BEGIN {
+				sub(/%$/, "", cur); sub(/%$/, "", old)
+				printf "%+.2f%%", cur - old }')
+		else
+			delta="(new)"
+		fi
+	else
+		old_cov="-"
+		delta="-"
+	fi
+	printf "  %-36s %8s  %8s  %9s\n" "$label" "${old_cov:--}" "$cur_cov" "$delta"
+}
+
+#
+# With no -f, show where the uncovered lines are: the files with the most
+# missed lines are where new tests should try to get more coverage.
+#
+print_worst_files()
+{
+	[ "$TOP" -gt 0 ] || return 0
+	local rows missed lines cover fn path
+	rows=$(awk -v min="$MIN_LINES" '
+		$1 ~ /(^|\/)tools\/perf\// && $8 >= min && $9 > 0 {
+			path = $1
+			sub(/^.*tools\/perf\//, "", path)
+			printf "%s %s %s %s %s\n", $9, $8, $10, $7, path
+		}' "$REPORT" | sort -k1,1nr -k2,2nr | sed -n "1,${TOP}p")
+	[ -n "$rows" ] || return 0
+
+	printf "  largest uncovered files (>= %s lines)\n" "$MIN_LINES"
+	printf "  %-44s %8s  %8s  %8s  %8s\n" \
+		"file" "lines" "cover" "missed" "fn-cover"
+	while read -r missed lines cover fn path; do
+		printf "  %-44s %8s  %8s  %8s  %8s\n" \
+			"$path" "$lines" "$cover" "$missed" "$fn"
+	done <<< "$rows"
+}
+
+print_summary()
+{
+	local lines missed cover delta file cov
+	read -r lines missed cover < <(total_cov "$REPORT")
+	printf "\n\033[1mTotal:\033[0m %s of %s lines covered (%s)" \
+		"$((lines - missed))" "$lines" "$cover"
+	if [ "$USE_BASELINE" = 1 ] && [ -f "$BASELINE" ] &&
+	   ! cmp -s "$BASELINE" "$REPORT"; then
+		delta=$(total_delta "$BASELINE" "$REPORT")
+		[ -n "$delta" ] && printf "  (previous %s, %s)" \
+			"$(total_cov "$BASELINE" | awk '{print $3}')" "$delta"
+	fi
+	printf "\n\n"
+
+	if [ ${#FOCUS[@]} -eq 0 ]; then
+		print_worst_files
+		return
+	fi
+
+	printf "  \033[1m%-36s\033[0m %8s  %6s  %6s  %8s\n" \
+		"file" "lines" "cover" "missed" "fn-cover"
+	for file in "${FOCUS[@]}"; do
+		file=$(focus_path "$file")
+		cov=$(file_cov "$REPORT" "$file")
+		if [ -z "$cov" ]; then
+			printf "  %-36s %8s\n" "$file" "not covered"
+			continue
+		fi
+		printf "  %-36s %8s  %6s  %6s  %8s\n" "$file" \
+			"$(echo "$cov" | awk '{print $1}')" \
+			"$(echo "$cov" | awk '{print $3}')" \
+			"$(echo "$cov" | awk '{print $2}')" \
+			"$(echo "$cov" | awk '{print $4}')"
+	done
+
+	if [ "$USE_BASELINE" = 1 ] && [ -f "$BASELINE" ] &&
+	   ! cmp -s "$BASELINE" "$REPORT"; then
+		printf "\n  per file delta since %s\n" "$BASELINE"
+		printf "  %-36s %8s  %8s  %9s\n" "file" "previous" "current" "delta"
+		for file in "${FOCUS[@]}"; do
+			report_delta "$BASELINE" "$REPORT" "$file"
+		done
+	fi
+}
+
+#
+# --table: render the report of the last run as an ASCII table, like
+# pahole's coverage_table.py.  Without -f the rows are the TOP files with
+# the most uncovered lines, sorted by line coverage; --top 0 lists every
+# file with at least MIN_LINES lines and uncovered lines.  The total is
+# the whole report, which also counts the libraries perf links with.
+#
+bar()
+{
+	local pct=$1 width=$2 filled i out=
+	filled=$(awk -v p="$pct" -v w="$width" 'BEGIN { printf "%d", p * w / 100 }')
+	for ((i = 0; i < filled; i++)); do out+=█; done
+	for ((i = filled; i < width; i++)); do out+=░; done
+	printf '%s' "$out"
+}
+
+center()
+{
+	local left=$(( ($2 - ${#1}) / 2 ))
+	printf '%*s%s%*s' "$left" '' "$1" "$(( $2 - ${#1} - left ))" ''
+}
+
+dashes()
+{
+	local s
+	printf -v s '%*s' "$1" ''
+	printf '%s' "${s// /─}"
+}
+
+table_row()
+{
+	awk -v f="$2" '
+		function perf_relpath(p) {
+			if (p ~ /(^|\/)tools\/perf\//)
+				sub(/^.*tools\/perf\//, "", p)
+			return p
+		}
+		{
+			g = f
+			sub(/^.*tools\/perf\//, "", g)
+			path = perf_relpath($1)
+			if (path == f || path == g || $1 == f) {
+				printf "%s\t%s\t%d\t%d\t%.2f\t%s\t%d\t%s\n",
+				       path, $8, $8 - $9, $9, $10, $5, $5 - $6, $7
+				exit
+			}
+		}' "$1"
+}
+
+table_rows()
+{
+	if [ ${#FOCUS[@]} -gt 0 ]; then
+		local file
+		for file in "${FOCUS[@]}"; do
+			table_row "$REPORT" "$file"
+		done | sort -t$'\t' -k5,5gr
+		return
+	fi
+
+	awk -v min="$MIN_LINES" '
+		$1 ~ /(^|\/)tools\/perf\// && $8 >= min && $9 > 0 {
+			path = $1
+			sub(/^.*tools\/perf\//, "", path)
+			printf "%s\t%s\t%d\t%d\t%.2f\t%s\t%d\t%s\n",
+			       path, $8, $8 - $9, $9, $10, $5, $5 - $6, $7
+		}' "$REPORT" |
+		sort -t$'\t' -k4,4nr |
+		if [ "$TOP" -gt 0 ]; then sed -n "1,${TOP}p"; else cat; fi |
+		sort -t$'\t' -k5,5gr
+}
+
+print_table()
+{
+	local rows total path lines hit missed pct funcs funcs_hit func_cov
+	local row_fmt w d_file d29 d13 d10 d8
+
+	rows=$(table_rows)
+	[ -n "$rows" ] ||
+		die "no coverage data in $REPORT for the requested files"
+	total=$(awk '$1 == "TOTAL" {
+		printf "%s\t%d\t%d\t%.2f\t%s\t%d\t%s\n",
+		       $8, $8 - $9, $9, $10, $5, $5 - $6, $7
+	}' "$REPORT")
+
+	w=4
+	while IFS=$'\t' read -r path _; do
+		if [ ${#path} -gt "$w" ]; then
+			w=${#path}
+		fi
+	done <<< "$rows"
+
+	d8=$(dashes 8)
+	d10=$(dashes 10)
+	d13=$(dashes 13)
+	d29=$(dashes 29)
+	d_file=$(dashes $((w + 2)))
+
+	printf '┌%s┬%s┬%s┬%s┬%s┬%s┬%s┐\n' \
+		"$d_file" "$d8" "$d8" "$d8" "$d29" "$d13" "$d10"
+	printf '│ %-*s │ %6s │ %6s │ %6s │ %s │ %11s │ %8s │\n' \
+		"$w" "File" "Lines" "Hit" "Miss" \
+		"$(center 'Line Coverage' 27)" "Funcs" "FuncCov"
+	printf '├%s┼%s┼%s┼%s┼%s┼%s┼%s┤\n' \
+		"$d_file" "$d8" "$d8" "$d8" "$d29" "$d13" "$d10"
+
+	row_fmt=$(printf '│ %%-%ds │ %%6s │ %%6s │ %%6s │ %%s %%5.1f%%%%' "$w")
+	row_fmt+=' │ %5s/%-5s │ %8s │\n'
+
+	while IFS=$'\t' read -r path lines hit missed pct funcs funcs_hit func_cov; do
+		printf "$row_fmt" "$path" "$lines" "$hit" "$missed" \
+			"$(bar "$pct" 20)" "$pct" "$funcs_hit" "$funcs" "$func_cov"
+	done <<< "$rows"
+
+	printf '├%s┼%s┼%s┼%s┼%s┼%s┼%s┤\n' \
+		"$d_file" "$d8" "$d8" "$d8" "$d29" "$d13" "$d10"
+	while IFS=$'\t' read -r lines hit missed pct funcs funcs_hit func_cov; do
+		printf "$row_fmt" "TOTAL" "$lines" "$hit" "$missed" \
+			"$(bar "$pct" 20)" "$pct" "$funcs_hit" "$funcs" "$func_cov"
+	done <<< "$total"
+	printf '└%s┴%s┴%s┴%s┴%s┴%s┴%s┘\n' \
+		"$d_file" "$d8" "$d8" "$d8" "$d29" "$d13" "$d10"
+}
+
+print_uncovered()
+{
+	[ "$UNCOVERED" -gt 0 ] || return 0
+	[ ${#FOCUS[@]} -gt 0 ] || return 0
+	local objects file out lines header=0
+	mapfile -t objects < <(llvm_cov_objects)
+
+	for file in "${FOCUS[@]}"; do
+		file=$(focus_path "$file")
+		# No report row means the file was not built: print_summary()
+		# already said so, llvm-cov show would dump the whole profile.
+		[ -n "$(file_cov "$REPORT" "$file")" ] || continue
+		out=$("$LLVM_COV" show "${objects[@]}" --instr-profile="$PROFDATA" \
+			"$PERF_DIR/$file" 2>/dev/null |
+			awk -F'|' '$2 ~ /^[[:space:]]*0[[:space:]]*$/ {
+				gsub(/[[:space:]]/, "", $1); printf "%s ", $1 }')
+		lines=$(echo "$out" | wc -w)
+		[ "$lines" -gt 0 ] || continue
+		if [ "$header" = 0 ]; then
+			printf "\n  uncovered lines (first %s per file)\n" "$UNCOVERED"
+			header=1
+		fi
+		printf "  %-24s %4s lines: %s\n" "$file" "$lines" \
+			"$(echo "$out" | cut -d' ' -f1-"$UNCOVERED")"
+	done
+}
+
+save_html()
+{
+	[ "$HTML" = 1 ] || return 0
+	local objects
+	mapfile -t objects < <(llvm_cov_objects)
+	say "Writing HTML report to $COV_DIR/html"
+	"$LLVM_COV" show "${objects[@]}" --instr-profile="$PROFDATA" \
+		--format=html --output-dir="$COV_DIR/html" \
+		--show-line-counts-or-regions --show-branches=count
+}
+
+check_stale()
+{
+	[ "$REPORT_ONLY" = 1 ] || return 0
+	if [ ! -f "$PROFDATA" ]; then
+		[ "$TABLE" = 1 ] && return 0
+		die "no $PROFDATA, run without --report-only first"
+	fi
+	local newer
+	newer=$(find "$PERF_DIR" -name '*.c' -newer "$PROFDATA" -print -quit 2>/dev/null)
+	if [ -n "$newer" ]; then
+		warn "profiles are older than source changes (e.g. $newer), results may be stale"
+	fi
+}
+
+update_baseline()
+{
+	[ "$USE_BASELINE" = 1 ] || return 0
+	[ "$REPORT_ONLY" = 1 ] && return 0
+	[ -f "$BASELINE" ] && mv "$BASELINE" "$BASELINE.prev"
+	cp "$REPORT" "$BASELINE"
+	printf "\nBaseline saved: %s\n" "$BASELINE"
+}
+
+test_status=0
+
+if [ "$TABLE" = 1 ]; then
+	[ -f "$REPORT" ] || die "no $REPORT, run coverage first"
+	check_stale
+	print_table
+	exit 0
+fi
+
+if [ "$PREP" = 1 ]; then
+	build_perf
+	write_state
+	say "Coverage build ready: $BUILD_DIR/perf"
+	printf "As root: %s/scripts/coverage.sh\n" "$PERF_DIR"
+	exit 0
+fi
+
+if [ "$REPORT_ONLY" = 0 ]; then
+	build_perf
+	run_tests
+	merge_profiles
+else
+	check_coverage_build
+	check_stale
+fi
+
+[ -f "$PROFDATA" ] || die "no $PROFDATA, run without --report-only first"
+
+render_report
+print_summary
+print_uncovered
+save_html
+update_baseline
+
+printf "\nReport:  %s\n" "$REPORT"
+[ "$HTML" = 1 ] && printf "HTML:    %s\n" "$COV_DIR/html/index.html"
+
+exit "$test_status"
-- 
2.56.0

