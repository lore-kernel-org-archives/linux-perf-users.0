Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039050;
	b=4Q7mbGH2BKGnkPmnRGMllPtoF56IosIEz8+QgiOSOfmM7HkJHecWaZvdpisag1pbYFtd
	 39tuzUNbBRDArQ3oXMcSloq5IoD/b73BJt9wOnYBcmuglpehdTzgIvWXkuNW5OgVIjH5f
	 L2/h+ST3YfQw0i/yOl0P1AYkHqgAgtthyK+QN/sIEIsHrBORYdVQ5s0YfT6N6Zs7b9iMp
	 pNICqisPmttqJpOz27BYdDFN2xbKLUCal4oKbxvOyxjHqi/XfJx+PIhQbxrPC3NhCMIIP
	 lfBRUGLZRw9eWSdLLO11mZhlEVl6GV3ti+LULutw1hmeVarE5scrizqbwjMUqpzGB1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039050;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PwcJUjQnUSpoJTZQZ1p/1Gvwr7MaxtHDv5Kg9ExRGzI=;
	b=rIsmfWbAUr/xhpSgHrJ0qgTzCURToHaS1lwQMG6oufR5YuKrNMiq6szKPxq7NrP14cQU
	 aOw+6NVPxUw99EpdaTNXeOuCla8NzvYJX5uiiMZJlYu+X803ShZkanRWgPY342UnOh/oF
	 rn7btpCybRBGEr7/2FmMhy2yB/3gUtT7jODFb10zlB3SmTPE3tz1iwTfr+Z5NC+BVKqYp
	 DrPJe3hiNBh9tGS4wS56KezZ5DAB4K/rQJ2Y/UIBCgWJai3y0RkQldrNvBAE+t6Ko/F+f
	 O4bFmXOotSauJkPAYPrCM74ES8Tg1btuoiubJUdwn3krI1ZIG04tj3ei3/YRr4PVNkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bUmQw/Nm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA6606A338;
	Wed, 18 Nov 2026 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUmQw/Nm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D201F000C4;
	Wed, 18 Nov 2026 21:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039050;
	bh=PwcJUjQnUSpoJTZQZ1p/1Gvwr7MaxtHDv5Kg9ExRGzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bUmQw/NmQoAmm02NazilZWGUYy5ILhVn6QqQ5TmehjsZjOL1ZySTLZ/LMQpR7bUnR
	 fMTojGn9SijTJCDOMrdBKZ0eexCsTUtyA6zb3vp/GdD5Z4W84WnGTfyA7D6KqfH007
	 7Z6BwhgPelcLnwZ0cL+Zv2i4/6Lz5OH/Kuz2VPVJxkA71lYSktVvTP9EAexYRsKS8D
	 sGTij7sx8MzpllRtNg3wZ9nKQk9oB9djDuO3Wszh0f5MYz5XmKxZUSsdC2DIxn4Jco
	 65I7m1kWV6PLQVmIrGQcGBtMQvZusaQt7wwOWifsQ9p8NuFvo48cQBTgpQPX1nZklb
	 nimn4Gd1s5ifw==
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
Subject: [PATCH v7 02/13] perf scripts: Add a coverage harness for perf
Date: Wed, 18 Nov 2026 18:57:04 -0300
Message-ID: <20261118215716.114868-3-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118215716.114868-1-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
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
suite, merge the raw profiles and report line and function coverage,
optionally against a baseline.  This is pahole's coverage/coverage.sh +
coverage-diff.sh merged into one script, wired as
'make -C tools/perf coverage' and listed in 'make help'.

Without -f the report lists the tool's files with the most uncovered
lines, tests and benches left out, which is where new tests should try
to get more coverage; -t narrows the tests, -f focuses on specific
files, --html writes a browsable report and --table/-T, also available
as 'make -C tools/perf coverage-table', prints the last run as a text
table with the per-file line and function coverage, like pahole's
coverage_table.py.

The table defaults to the same view, biggest gap first: covering
everything is not the goal, this is the list to work from.  --all lists
every tools/perf file, most covered first, and the table total is the
tools/perf subtotal, matching the rows; the whole-report total,
generated files included, stays in the run summary.

The build can be split from the test run: 'make -C tools/perf
coverage-prep' builds the instrumented perf and records the build
directory, and a later run as root, which needs no make, checks that
build, runs the tests and renders the report, or prints the table with
--table.  This is for running the tests that need root on the bare
metal host while the instrumented perf is built in the development
container.

The report covers the whole tree, not only the paths the tests walk, so
the per-file table is a map of what the suite does not reach in a given
run.  The uncovered line list and the failures the runs exposed are what
drove the rest of this series.

  $ sudo scripts/coverage.sh
  ...
  Total: 105466 of 205823 lines covered (51.24%)
    perf: 86344 of 173257 lines covered (49.84%)

The total also counts the tools/ libraries and headers linked into
perf, the perf line is the tools/perf/ files alone.  The numbers above
are from the split run: coverage-prep built the instrumented perf as the
developer, the tests and the report ran as root.  This machine has no
Intel PT, so the PT tests skip and leave intel-pt.c and
intel-pt-decoder.c at 0.00%; the TUI browser is in the uncovered list
because the suite does not drive it.

'perf test' exits 0 even when tests fail or time out, so the script
takes its status from the "Failed tests :" line that perf test prints
since commit 33f20342ba525ef7 ("perf test: Add summary reporting") and
the "Timed out tests :" one from commit bcb9de7e1d9bd5f8 ("perf test:
Add per-test timeout support").

168 tests passed, 28 skipped and one failed (20.2, the known POLL_HUP
regression), in code this series does not change.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/.gitignore          |    1 +
 tools/perf/Makefile            |   11 +-
 tools/perf/Makefile.perf       |    4 +
 tools/perf/scripts/coverage.sh | 1114 ++++++++++++++++++++++++++++++++
 4 files changed, 1129 insertions(+), 1 deletion(-)
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
index e730f1a209cb44a4..d33fe8b160ededdd 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -873,6 +873,10 @@ help:
 	@echo '  check-headers		- check which header copies are out of sync with the kernel'
 	@echo '  sync-headers		- sync those header copies with the kernel, creating commits'
 	@echo '			  (SYNC_HEADERS_ARGS="..." passes options to the script)'
+	@echo '  coverage-prep		- build perf with clang coverage, ready for a root test run'
+	@echo '  coverage		- build perf with clang coverage, run the tests and report'
+	@echo '  coverage-table	- print a text table of the last coverage run'
+	@echo '			  (COVERAGE_ARGS="..." passes options to the script)'
 
 
 DOC_TARGETS := doc man html info pdf
diff --git a/tools/perf/scripts/coverage.sh b/tools/perf/scripts/coverage.sh
new file mode 100755
index 0000000000000000..9c77644e77f9146e
--- /dev/null
+++ b/tools/perf/scripts/coverage.sh
@@ -0,0 +1,1114 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2026, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#
+# LLVM source-based coverage for perf: build with clang instrumentation,
+# run the complete perf test suite and report line/function coverage for
+# perf, optionally comparing it against a previously saved report.  -t
+# narrows the tests and -f adds files to the per-file table; without -f
+# the report lists the tool's files with the most uncovered lines, which
+# is where new tests are needed.  --table prints the last run as a text
+# coverage table with the same view, biggest gap first, and --all lists
+# every tools/perf file, like pahole's coverage_table.py.  The build can
+# be split from the test run: --prep builds the instrumented perf and
+# records the build directory, and a later run as root uses that build,
+# skips the build and goes straight to the tests, unless --build is
+# given.  The sampling based tests move the percentages by a percent or
+# two between identical runs.
+
+set -euo pipefail
+
+PERF_DIR=$(cd "$(dirname "$0")/.." && pwd -P)
+TOOLS_DIR=$(cd "$PERF_DIR/.." && pwd -P)
+SRC_DIR=$(cd "$TOOLS_DIR/.." && pwd -P)
+
+# perf links objects from these directories, so a change in any of them
+# makes a build and a profile stale.
+PERF_SOURCES=("$PERF_DIR" "$TOOLS_DIR/lib/perf" "$TOOLS_DIR/lib/api"
+	      "$TOOLS_DIR/lib/subcmd" "$TOOLS_DIR/lib/bpf"
+	      "$TOOLS_DIR/include")
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
+FORCE_BUILD=0
+REPORT_ONLY=0
+PREP=0
+TABLE=0
+TABLE_ALL=0
+HTML=0
+USE_BASELINE=1
+BASELINE=
+BASELINE_SET=0
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
+  -t, --tests "A;B"      test name fragments, ';' separated (default: all);
+                         a subset run does not update the baseline
+  -f, --focus FILE       add a file to the per-file table (repeatable)
+      --top N            when no -f is given, show the N tool files (no
+                         tests or benches) with the most uncovered lines
+                         (default: $TOP, 0 to disable)
+      --all              with --table, list every tools/perf file, tests
+                         and benches included, most covered first
+      --baseline FILE    compare against FILE, keeping it read-only
+                         (default: COV_DIR/baseline.txt, which a full run
+                         saves for the next one)
+      --no-baseline      do not compare against or update a baseline
+      --uncovered N      uncovered line numbers per focus file (default: $UNCOVERED)
+      --skip-build       reuse the existing build, just run the tests
+      --build            build as root even when a prepared build exists
+      --report-only      reuse build and profiles, just render the report
+      --prep             build the instrumented perf and stop; run the
+                         tests later as root with this script
+  -T, --table            print a text table of the last run and exit,
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
+As root, without --prep or --build, the script uses the build prepared
+by 'make coverage-prep' when there is one, and builds otherwise.  The
+prepared build is recorded in tools/perf/.coverage-build-dir.  llvm-cov
+and llvm-profdata are needed for the report, the tests do not use them.
+
+Through make:
+  make -C tools/perf coverage COVERAGE_ARGS="-t 'perf annotate'"
+  make -C tools/perf coverage-prep O=/tmp/build/perf-tools-next
+  make -C tools/perf coverage-table
+  make -C tools/perf coverage-table COVERAGE_ARGS="--all"
+
+Examples:
+  scripts/coverage.sh                       # full suite, fresh build
+  scripts/coverage.sh --prep                # build only, test later as root
+  scripts/coverage.sh --report-only         # re-render the last run
+  scripts/coverage.sh --table               # text table of the last run
+  scripts/coverage.sh -t "perf annotate"    # a single test fragment
+  scripts/coverage.sh -f util/evsel.c       # add a file to the table
+EOF
+}
+
+while [ $# -gt 0 ]; do
+	arg=$1
+	optval=
+	case "$arg" in
+	--*=*) optval=${arg#*=}; arg=${arg%%=*}
+	       [ -n "$optval" ] || die "$arg needs a value" ;;
+	esac
+
+	case "$arg" in
+	--no-baseline|--skip-build|--build|--report-only|--prep|-T|--table|--optimized|--html|-h|--help)
+		[ -z "$optval" ] || die "$arg takes no value" ;;
+	esac
+
+	case "$arg" in
+	-b|--build-dir)   BUILD_DIR=${optval:-${2:?$arg needs a value}}; BUILD_DIR_SET=1
+	                  [ -z "$optval" ] && shift ;;
+	-c|--cov-dir)     COV_DIR=${optval:-${2:?$arg needs a value}}; COV_DIR_SET=1
+	                  [ -z "$optval" ] && shift ;;
+	-j|--jobs)        JOBS=${optval:-${2:?$arg needs a value}}; [ -z "$optval" ] && shift ;;
+	-f|--focus)       FOCUS+=("${optval:-${2:?$arg needs a value}}"); [ -z "$optval" ] && shift ;;
+	--baseline)       BASELINE=${optval:-${2:?$arg needs a value}}; BASELINE_SET=1
+	                  [ -z "$optval" ] && shift ;;
+	--uncovered)      UNCOVERED=${optval:-${2:?$arg needs a value}}; [ -z "$optval" ] && shift ;;
+	--top)            TOP=${optval:-${2:?$arg needs a value}}; [ -z "$optval" ] && shift ;;
+	--dwarf-version)  DWARF_VERSION=${optval:-${2:?$arg needs a value}}; [ -z "$optval" ] && shift ;;
+	-t|--tests)       IFS=';' read -r -a _t <<< "${optval:-${2:?$arg needs a value}}"
+	                  TESTS+=("${_t[@]}"); [ -z "$optval" ] && shift ;;
+	--no-baseline)    USE_BASELINE=0 ;;
+	--skip-build)     SKIP_BUILD=1 ;;
+	--build)          FORCE_BUILD=1; SKIP_BUILD=0 ;;
+	--report-only)    REPORT_ONLY=1; SKIP_BUILD=1 ;;
+	--prep)           PREP=1 ;;
+	-T|--table)       TABLE=1; REPORT_ONLY=1; SKIP_BUILD=1 ;;
+	--all)            TABLE_ALL=1
+	                  [ -z "$optval" ] || die "--all takes no value" ;;
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
+if [ "$BUILD_DIR_SET" = 0 ] && [ "$PREP" = 0 ] &&
+   { [ "$ROOT" = 1 ] || [ "$SKIP_BUILD" = 1 ] ||
+     [ "$REPORT_ONLY" = 1 ] || [ "$TABLE" = 1 ]; } &&
+   [ -f "$PERF_DIR/.coverage-build-dir" ]; then
+	read -r BUILD_DIR < "$PERF_DIR/.coverage-build-dir" ||
+		[ -n "$BUILD_DIR" ] ||
+		die "$PERF_DIR/.coverage-build-dir is empty"
+fi
+[ -n "$BUILD_DIR" ] || BUILD_DIR=$DEFAULT_BUILD_DIR
+
+# The tests run from the kernel tree root, so keep these absolute.  The
+# Makefile passes FULL_O resolved with readlink -f; resolve here too so an
+# in-tree build directory compares equal to the physical PERF_DIR below.
+abspath()
+{
+	realpath -m "$1"
+}
+BUILD_DIR=$(abspath "$BUILD_DIR")
+
+#
+# Root executes the perf in the build directory and deletes and rewrites
+# its cov/ directory, and that directory comes from a file the invoking
+# user wrote or is the default under /tmp, so refuse one owned by somebody
+# else or writable by another group or by others.  Every parent is checked
+# too: a directory another user can write lets them swap an entry between
+# this check and the run.  The trusted user is the one behind sudo, or the
+# owner of the kernel tree when root runs the script directly, as in a
+# container with the tree mounted from the host.
+#
+TRUST_UID=0
+TRUST_GID=0
+if [ "$ROOT" = 1 ]; then
+	if [ -n "${SUDO_UID:-}" ]; then
+		TRUST_UID=$SUDO_UID
+		TRUST_GID=${SUDO_GID:-$SUDO_UID}
+	else
+		read -r TRUST_UID TRUST_GID < \
+			<(stat -c '%u %g' "$PERF_DIR" 2>/dev/null) ||
+			die "could not stat $PERF_DIR"
+	fi
+fi
+
+check_root_path()
+{
+	local path=$1 uid gid mode owners=root
+	[ "$ROOT" = 1 ] || return 0
+	[ "$TRUST_UID" = 0 ] || owners="root or uid $TRUST_UID"
+	# abspath() resolves links such as /home -> /var/home on Silverblue
+	# and CoreOS, so the walk below checks their targets.  A path not
+	# resolved that way, like $BUILD_DIR/perf, must not be a link.
+	[ -L "$path" ] && die "$path is a symbolic link, use its target"
+	while :; do
+		if [ -e "$path" ]; then
+			if ! read -r uid gid mode < \
+				<(stat -c '%u %g %a' "$path" 2>/dev/null); then
+				die "could not stat $path"
+			fi
+			# A sticky directory owned by root, like /tmp, lets
+			# anybody create entries but not replace one that
+			# belongs to somebody else.  Anyone can set the sticky
+			# bit on what they own, so nothing else is exempt.
+			if ! { [ -d "$path" ] && [ "$uid" = 0 ] &&
+			       [ $(( 8#$mode & 8#1000 )) != 0 ]; }; then
+				[ "$uid" = 0 ] || [ "$uid" = "$TRUST_UID" ] ||
+					die "$path is owned by uid $uid, not by $owners"
+				# With user private groups, which most
+				# distributions set up, umask 002 gives
+				# 775 and only the developer's own group
+				# may write here.
+				[ $(( 8#$mode & 8#002 )) = 0 ] ||
+					die "$path is writable by others"
+				if [ $(( 8#$mode & 8#020 )) != 0 ] &&
+				   [ "$gid" != "$TRUST_GID" ]; then
+					die "$path is writable by group $gid"
+				fi
+			fi
+		fi
+		[ "$path" = / ] && return 0
+		path=$(dirname "$path")
+	done
+}
+
+# The state file is read below, so check BUILD_DIR before opening it: a
+# directory another user can write lets them replace state with a fifo
+# and hang root.
+check_root_path "$BUILD_DIR"
+
+if [ "$COV_DIR_SET" = 0 ] && [ -f "$BUILD_DIR/cov/state" ]; then
+	COV_DIR=$(awk -F= '$1 == "COV_DIR" { print $2; exit }' \
+		"$BUILD_DIR/cov/state")
+fi
+[ -n "$COV_DIR" ] || COV_DIR=$BUILD_DIR/cov
+COV_DIR=$(abspath "$COV_DIR")
+
+# llvm-cov strips the prefix all reported files share.  A build inside
+# tools/perf makes the rows read perf/<build>/..., so BUILD_REL lets the
+# report leave those generated files out; it is empty for any other layout.
+BUILD_REL=
+case "$BUILD_DIR" in
+"$PERF_DIR"/*) BUILD_REL=${BUILD_DIR#"$PERF_DIR"/} ;;
+esac
+
+[ -n "$BASELINE" ] || BASELINE=$COV_DIR/baseline.txt
+[[ $TOP =~ ^[0-9]+$ ]] || die "--top wants a number, not '$TOP'"
+[[ $MIN_LINES =~ ^[0-9]+$ ]] || die "MIN_LINES wants a number, not '$MIN_LINES'"
+[[ $UNCOVERED =~ ^[0-9]+$ ]] ||
+	die "--uncovered wants a number, not '$UNCOVERED'"
+[[ $DWARF_VERSION =~ ^[0-9]+$ ]] ||
+	die "--dwarf-version wants a number, not '$DWARF_VERSION'"
+[[ $JOBS =~ ^[0-9]+$ ]] || die "--jobs wants a number, not '$JOBS'"
+
+# Root does not rebuild a prepared build unless asked: use the perf
+# prepared by coverage-prep, or build when there is none.
+if [ "$ROOT" = 1 ] && [ "$PREP" = 0 ] && [ "$TABLE" = 0 ]; then
+	if [ "$REPORT_ONLY" = 0 ] && [ "$SKIP_BUILD" = 0 ] &&
+	   { [ "$FORCE_BUILD" = 1 ] ||
+	     { [ ! -f "$PERF_DIR/.coverage-build-dir" ] &&
+	       [ ! -x "$BUILD_DIR/perf" ]; }; }; then
+		say "Running as root, building perf in $BUILD_DIR"
+	else
+		SKIP_BUILD=1
+		say "Running as root, using the coverage build in $BUILD_DIR"
+	fi
+fi
+
+check_root_path "$BUILD_DIR/perf"
+check_root_path "$COV_DIR"
+
+# mkdir -p takes a directory somebody else created meanwhile and leaves
+# every missing parent owned by root, so create the missing directories
+# one at a time, remember the ones this run made and check the result
+# again; fix_ownership() gives the parents back too.
+MKDIR_CREATED=()
+
+mkdir_checked()
+{
+	local path=$1 parent missing=()
+	while [ ! -d "$path" ]; do
+		missing=("$path" "${missing[@]}")
+		parent=$(dirname "$path")
+		[ "$parent" = "$path" ] && break
+		path=$parent
+	done
+	for path in "${missing[@]+"${missing[@]}"}"; do
+		if mkdir "$path" 2>/dev/null; then
+			MKDIR_CREATED+=("$path")
+		elif [ ! -d "$path" ]; then
+			die "could not create $path"
+		fi
+	done
+	check_root_path "$1"
+}
+
+#
+# A root run leaves the files it writes owned by root; give them back to the
+# developer, or the next non-root run cannot clean raw/ or move the baseline.
+# Only the directories this run created are chowned recursively, including
+# the parents missing above them: a mistyped --cov-dir or --build-dir must
+# not hand a shared or system tree to the developer.  -h: chown changes a
+# symbolic link itself, not its target.
+#
+COV_WRITES=(raw html build.log tests.log report.txt perf.profdata profiles.txt
+	    merge.log baseline.txt baseline.txt.prev)
+
+fix_ownership()
+{
+	local uid=$TRUST_UID gid=$TRUST_GID path top=
+
+	[ "$ROOT" = 1 ] && [ "$uid" != 0 ] || return 0
+
+	for path in "${COV_WRITES[@]}"; do
+		[ -e "$COV_DIR/$path" ] || continue
+		chown -Rh "$uid:$gid" "$COV_DIR/$path" ||
+			warn "could not give $COV_DIR/$path back to uid $uid"
+	done
+	# The directories this run created, in creation order: chowning one
+	# covers everything below it, so skip those.
+	for path in "${MKDIR_CREATED[@]+"${MKDIR_CREATED[@]}"}"; do
+		if [ -n "$top" ]; then
+			case "$path" in "$top"/*) continue ;; esac
+		fi
+		chown -Rh "$uid:$gid" "$path" ||
+			warn "could not give $path back to uid $uid"
+		top=$path
+	done
+	if [ -n "$BUILD_STAMP" ] && [ -f "$BUILD_STAMP" ]; then
+		find "$BUILD_DIR" -user 0 -newer "$BUILD_STAMP" \
+			-exec chown -h "$uid:$gid" {} + ||
+			warn "could not give the files root built in $BUILD_DIR back to uid $uid"
+		rm -f "$BUILD_STAMP" || true
+	fi
+	if [ -f "$STATE_FILE" ]; then
+		chown -h "$uid:$gid" "$STATE_FILE" ||
+			warn "could not give $STATE_FILE back to uid $uid"
+	fi
+	if [ -f "$POINTER" ]; then
+		chown -h "$uid:$gid" "$POINTER" ||
+			warn "could not give $POINTER back to uid $uid"
+	fi
+}
+
+BUILD_LOG=$COV_DIR/build.log
+TEST_LOG=$COV_DIR/tests.log
+REPORT=$COV_DIR/report.txt
+PROFDATA=$COV_DIR/perf.profdata
+# Discovery point for a later root or --table run, so it stays under
+# BUILD_DIR even when --cov-dir points elsewhere.
+STATE_FILE=$BUILD_DIR/cov/state
+STATE_DIR=$(dirname "$STATE_FILE")
+POINTER=$PERF_DIR/.coverage-build-dir
+
+# What exists before this run writes anything: fix_ownership() chowns a
+# shared BUILD_DIR only when root created it.
+BUILD_CREATED=0
+[ -d "$BUILD_DIR" ] || BUILD_CREATED=1
+# An existing build directory is not chowned as a whole: a stamp taken
+# when the build starts marks the files a root build writes.
+BUILD_STAMP=
+
+#
+# Sanity checks
+#
+for src in "${PERF_SOURCES[@]}"; do
+	[ -d "$src" ] || die "$src not found"
+done
+case "$BUILD_DIR" in
+"$PERF_DIR"|"$TOOLS_DIR"|"$SRC_DIR")
+	die "$BUILD_DIR would mix generated files with the sources, use -b DIR" ;;
+esac
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
+	mkdir_checked "$COV_DIR"
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
+		die "no $BUILD_DIR/perf, run 'make -C $PERF_DIR O=$BUILD_DIR" \
+		    "coverage-prep' first, or pass --build"
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
+	mkdir_checked "$STATE_DIR"
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
+#
+# A source file newer than $1, if any, skipping the build directory.
+#
+newer_sources()
+{
+	find "${PERF_SOURCES[@]}" -path "$BUILD_DIR" -prune -o \
+		-name '*.[ch]' -newer "$1" -print -quit 2>/dev/null || true
+}
+
+check_build_freshness()
+{
+	local newer
+	[ -x "$BUILD_DIR/perf" ] || return 0
+	newer=$(newer_sources "$BUILD_DIR/perf")
+	[ -z "$newer" ] ||
+		warn "build is older than source changes" \
+		     "(e.g. ${newer#"$SRC_DIR"/}), rerun coverage-prep"
+}
+
+build_perf()
+{
+	if [ "$SKIP_BUILD" = 1 ]; then
+		check_coverage_build
+		check_build_freshness
+		return
+	fi
+
+	say "Building perf in $BUILD_DIR"
+	mkdir_checked "$BUILD_DIR"
+	if [ "$ROOT" = 1 ] && [ "$BUILD_CREATED" = 0 ]; then
+		BUILD_STAMP=$BUILD_DIR/.coverage-stamp
+		: > "$BUILD_STAMP" 2>/dev/null ||
+			{ warn "could not write $BUILD_STAMP"; BUILD_STAMP=; }
+	fi
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
+	# The shell tests are found from the tree root or from tools/perf.
+	(cd "$SRC_DIR" &&
+		PATH="$BUILD_DIR:$PATH" \
+		LLVM_PROFILE_FILE="$COV_DIR/raw/perf-%p-%m.profraw" \
+			"$BUILD_DIR/perf" test -v \
+				"${TESTS[@]+"${TESTS[@]}"}") 2>&1 | tee "$TEST_LOG"
+	test_status=${PIPESTATUS[0]}
+	set -e
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
+	local count size unusable=0 list=$COV_DIR/profiles.txt
+	# A full run leaves thousands of profiles: llvm-profdata reads the
+	# list from a file so they do not have to fit on the command line.
+	find "$COV_DIR/raw" -name '*.profraw' | sort > "$list"
+	count=$(wc -l < "$list")
+	size=$(du -sh "$COV_DIR/raw" 2>/dev/null | cut -f1)
+	[ "$count" -gt 0 ] ||
+		die "no .profraw files, was perf rebuilt with -fprofile-instr-generate?"
+
+	say "Merging $count profile files ($size)"
+	if ! "$LLVM_PROFDATA" merge -sparse --input-files="$list" \
+			-o "$PROFDATA" 2> "$COV_DIR/merge.log"; then
+		# A file left half written, by a perf killed at exit or by a
+		# full tmpfs, makes llvm-profdata drop the whole merge: retry
+		# with the invalid profiles excluded, the die below catches
+		# the case where every profile is bad.
+		warn "some profile files are unusable, merging the rest"
+		"$LLVM_PROFDATA" merge -sparse --failure-mode=all \
+			--input-files="$list" -o "$PROFDATA" \
+			2> "$COV_DIR/merge.log" ||
+			die "llvm-profdata merge failed, see $COV_DIR/merge.log"
+		# Count only warnings naming a profile: the merge also warns
+		# about counter and hash mismatches.
+		unusable=$(sed -n 's/^warning: \(.*\.profraw\):.*/\1/p' \
+			"$COV_DIR/merge.log" | sort -u | wc -l)
+		[ "$unusable" -lt "$count" ] ||
+			die "no usable profile among $count, see $COV_DIR/merge.log"
+		warn "merged $((count - unusable)) profile files, ignored $unusable unusable"
+	fi
+}
+
+llvm_cov_objects()
+{
+	echo "$BUILD_DIR/perf"
+	local so
+	# These are dlopened by perf and have to be profiled separately;
+	# libperf is linked into perf as a static library.
+	for so in libperf-gtk.so libperf-jvmti.so; do
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
+# The report parsers share these: llvm-cov strips the prefix every
+# reported file has in common, so a tools/perf source can read as
+# perf/util/evsel.c; perf_relpath() gives the path -f takes, generated()
+# spots a build directory row.
+AWK_PERF='
+function perf_relpath(p) {
+	sub(/^.*tools\/perf\//, "", p)
+	sub(/^perf\//, "", p)
+	return p
+}
+function generated(p) {
+	return build != "" && index(perf_relpath(p), build "/") == 1
+}
+'
+
+# Line coverage of a full report for one file: "lines missed cover fn%".
+# Match the requested path as a suffix: a build outside the source tree
+# gives ".../tools/perf/...", one inside it "tools/perf/...", and one
+# inside tools/ makes llvm-cov strip the "<srctree>/tools/" prefix shared
+# by every reported file, giving "perf/...".
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
+	awk -v f="$2" "$AWK_PERF"'
+		{
+			g = perf_relpath(f)
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
+total_cov_perf()
+{
+	# Generated files under an in-tree build directory read as
+	# perf/<build>/...; leave them out so an in and an out of tree
+	# build count the same files.
+	awk -v build="$BUILD_REL" "$AWK_PERF"'
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
+# Delta between the totals the $3 helper (total_cov or total_cov_perf)
+# prints for $prev and $cur.
+total_delta()
+{
+	local prev=$1 cur=$2 total=$3 old cur_cov
+	[ -f "$prev" ] || return 0
+	old=$("$total" "$prev" | awk '{print $3}')
+	cur_cov=$("$total" "$cur" | awk '{print $3}')
+	[ -n "$old" ] && [ -n "$cur_cov" ] || return 0
+	awk -v cur="$cur_cov" -v old="$old" 'BEGIN {
+		sub(/%$/, "", cur); sub(/%$/, "", old)
+		printf "%+.2f%%", cur - old }'
+}
+
+#
+# "  (previous X, +Y)": the same total in $BASELINE and its delta, when
+# there is a baseline from an earlier run.
+#
+since_baseline()
+{
+	local prev delta
+	[ "$USE_BASELINE" = 1 ] && [ -f "$BASELINE" ] &&
+		! cmp -s "$BASELINE" "$REPORT" || return 0
+	prev=$("$1" "$BASELINE" | awk '{print $3}')
+	delta=$(total_delta "$BASELINE" "$REPORT" "$1")
+	[ -n "$prev" ] && [ -n "$delta" ] || return 0
+	printf "  (previous %s, %s)" "$prev" "$delta"
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
+	rows=$(awk -v min="$MIN_LINES" -v build="$BUILD_REL" "$AWK_PERF"'
+		($1 ~ /(^|\/)tools\/perf\// || $1 ~ /^perf\//) &&
+		!generated($1) && $8 >= min && $9 > 0 &&
+		perf_relpath($1) !~ /^(tests|bench)\// {
+			printf "%s %s %s %s %s\n", $9, $8, $10, $7,
+				perf_relpath($1)
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
+	local lines missed cover p_lines p_missed p_cover file cov
+	read -r lines missed cover < <(total_cov "$REPORT") ||
+		die "no TOTAL row in $REPORT"
+	printf "\n\033[1mTotal:\033[0m %s of %s lines covered (%s)" \
+		"$((lines - missed))" "$lines" "$cover"
+	since_baseline total_cov
+	printf "\n"
+	read -r p_lines p_missed p_cover < <(total_cov_perf "$REPORT") || true
+	if [ -n "$p_lines" ]; then
+		printf "  perf: %s of %s lines covered (%s)" \
+			"$((p_lines - p_missed))" "$p_lines" "$p_cover"
+		since_baseline total_cov_perf
+		printf "\n"
+	fi
+	printf "\n"
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
+# --table: render the report of the last run as a text table, like
+# pahole's coverage_table.py.  Without -f the default is what is worth
+# covering next: the tool's files, not its tests and benches, with the
+# most uncovered lines, biggest gap first.  --all lists every tools/perf
+# file, most covered first, and -f picks files explicitly.  The total is
+# the tools/perf subtotal, the run summary has the whole report.
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
+	awk -v f="$2" "$AWK_PERF"'
+		{
+			g = perf_relpath(f)
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
+	local file
+
+	if [ ${#FOCUS[@]} -gt 0 ]; then
+		for file in "${FOCUS[@]}"; do
+			table_row "$REPORT" "$file"
+		done | sort -t$'\t' -k5,5gr
+		return
+	fi
+
+	if [ "$TABLE_ALL" = 1 ]; then
+		awk -v build="$BUILD_REL" "$AWK_PERF"'
+			($1 ~ /(^|\/)tools\/perf\// || $1 ~ /^perf\//) &&
+			!generated($1) && $8 > 0 {
+				printf "%s\t%s\t%d\t%d\t%.2f\t%s\t%d\t%s\n",
+				       perf_relpath($1), $8, $8 - $9, $9, $10,
+				       $5, $5 - $6, $7
+			}' "$REPORT" |
+			sort -t$'\t' -k5,5gr
+		return
+	fi
+
+	awk -v min="$MIN_LINES" -v build="$BUILD_REL" "$AWK_PERF"'
+		($1 ~ /(^|\/)tools\/perf\// || $1 ~ /^perf\//) &&
+		!generated($1) && $8 >= min && $9 > 0 &&
+		perf_relpath($1) !~ /^(tests|bench)\// {
+			printf "%s\t%s\t%d\t%d\t%.2f\t%s\t%d\t%s\n",
+			       perf_relpath($1), $8, $8 - $9, $9, $10,
+			       $5, $5 - $6, $7
+		}' "$REPORT" |
+		sort -t$'\t' -k4,4nr |
+		if [ "$TOP" -gt 0 ]; then
+			sed -n "1,${TOP}p"
+		else
+			cat
+		fi
+}
+
+# The table is about tools/perf, so its total is the tools/perf subtotal;
+# the run summary prints the whole report, generated files included.
+table_total()
+{
+	awk -v build="$BUILD_REL" "$AWK_PERF"'
+		$1 != "TOTAL" && !generated($1) &&
+		($1 ~ /(^|\/)tools\/perf\// || $1 ~ /^perf\//) {
+			lines += $8
+			missed += $9
+			funcs += $5
+			funcs_missed += $6
+		}
+		END {
+			printf "%d\t%d\t%d\t%.2f\t%d\t%d\t%.2f%%\n",
+			       lines, lines - missed, missed,
+			       lines ? 100 * (lines - missed) / lines : 0,
+			       funcs, funcs - funcs_missed,
+			       funcs ? 100 * (funcs - funcs_missed) / funcs : 0
+		}' "$REPORT"
+}
+
+# At most three lines: what the table shows and how to see every file.
+table_caption()
+{
+	if [ ${#FOCUS[@]} -gt 0 ]; then
+		echo "files requested with -f."
+	elif [ "$TABLE_ALL" = 1 ]; then
+		echo "every tools/perf file, tests and benches included, most covered first."
+		return
+	elif [ "$TOP" -gt 0 ] && [ "$MIN_LINES" -gt 0 ]; then
+		printf "tools/perf (no tests/ or bench/), %d+ executable lines:\n" "$MIN_LINES"
+		echo "the $TOP biggest uncovered gaps, start here when adding coverage tests."
+	elif [ "$TOP" -gt 0 ]; then
+		printf "tools/perf (no tests/ or bench/): the %d files with the\n" "$TOP"
+		echo "biggest uncovered gaps, start here when adding coverage tests."
+	elif [ "$MIN_LINES" -gt 0 ]; then
+		printf "tools/perf (no tests/ or bench/), %d+ executable lines:\n" "$MIN_LINES"
+		echo "start here when adding coverage tests, biggest gaps first."
+	else
+		echo "tools/perf (no tests/ or bench/), biggest gaps first."
+	fi
+	printf '%s %s\n' '--all for every file:' \
+		'make -C tools/perf coverage-table COVERAGE_ARGS="--all"'
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
+	total=$(table_total)
+	[ -n "$total" ] || die "no coverage data in $REPORT"
+
+	table_caption
+	printf '\n'
+
+	w=12	# "TOTAL (perf)"
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
+		printf "$row_fmt" "TOTAL (perf)" "$lines" "$hit" "$missed" \
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
+		# A report from a tree at another path has the row but no file
+		# here, and llvm-cov show dumps the whole profile for a missing
+		# source file.
+		if [ ! -f "$PERF_DIR/$file" ]; then
+			warn "$PERF_DIR/$file not found, no uncovered lines"
+			continue
+		fi
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
+	newer=$(newer_sources "$PROFDATA")
+	if [ -n "$newer" ]; then
+		warn "profiles are older than source changes" \
+		     "(e.g. ${newer#"$SRC_DIR"/}), results may be stale"
+	fi
+}
+
+update_baseline()
+{
+	[ "$USE_BASELINE" = 1 ] || return 0
+	[ "$REPORT_ONLY" = 1 ] && return 0
+	# A --baseline file is only read, the default one rolls forward.
+	[ "$BASELINE_SET" = 0 ] || return 0
+	# A -t run covers a subset, saving it would poison the next full run.
+	if [ ${#TESTS[@]} -gt 0 ]; then
+		printf "\nBaseline not updated, this was a subset run\n"
+		return 0
+	fi
+	[ -f "$BASELINE" ] && mv "$BASELINE" "$BASELINE.prev"
+	cp "$REPORT" "$BASELINE"
+	printf "\nBaseline saved: %s\n" "$BASELINE"
+}
+
+test_status=0
+
+if [ "$TABLE" = 1 ]; then
+	[ -f "$REPORT" ] || die "no $REPORT, run coverage first"
+	# The table code parses llvm-cov's decimal points; keep the numeric
+	# locale fixed here only, the tests must run with their normal one.
+	export LC_ALL=C
+	check_stale
+	print_table
+	exit 0
+fi
+
+if [ "$ROOT" = 1 ]; then
+	trap fix_ownership EXIT
+fi
+
+if [ "$PREP" = 1 ]; then
+	build_perf
+	# build_perf() records the build unless it only checked it.
+	if [ "$SKIP_BUILD" = 1 ]; then
+		write_state
+	fi
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
+export LC_ALL=C
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
2.56.1

