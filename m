Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383699;
	b=u+7DUdwyHOqjIvZpTPpf3/NdFEF/Sd++NN37Bnt46+Cgb8zbLoNuybj1nfRq06DvOLgk
	 8KVfFTsXrbsHBc3/FDRda2HQC4vUgpwER19pJaX1nkIkXBNmUZl7ZTQKx8Q+S8FryuZNN
	 jDmVOvoGYNbNXqOdURWChz0uFXRd//WJrmKcACr6AZXnUbkrK+7xJfA3Qw/jl2TnZSn42
	 KPMweRJC3MOwQf8tYCP1A+bPkZJdLl+xX2yoFO7/htw9uPweWNRRAX9kOHMlXzbzAWODC
	 UOricdva2Cdx3mAgXMzzUyDXG+HNzcLwIVPvZ9MZxKv3hm98XooE+Yw2AWxJyps6Ltw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383699;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XJxI7uHxt3dMSe0hA6z9TfOPeGi4XB0o2Vmr38733fo=;
	b=1b0S5rRNQnqEO2LbxA18QdG11pzQ7e3awqEnALLbLG++UJq3dV8DPV3QLv5DGFDm+2sA
	 ZiCaDqXsBJ3++DBQdWMJ1bS9tWXJ1Q/U/xQkzA5dkZm02+y+GaYC4FzfiKojTweqGyTJ9
	 MdfpnOhMGsJtTfXKPnpc4+NLRVL7TUKiF9e82gn7ar2g3PxsNgSPlVOjuVueJ2lL0p/sR
	 J6auOl51+WRyki8LdUxNLWycHXLeaV2nmTNb9LWl9wZcR3RMUHpnQekUPH7gWeC1vp927
	 vfcnSdb7K7fng2SUvp3ceLAI0yjGjDgjaAuZDHqFDV7IpDFy0ncRhhDHrVhRi9+uhlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKah7tlE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFC606A336;
	Sun, 22 Nov 2026 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKah7tlE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426D41F000C0;
	Sun, 22 Nov 2026 21:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383698;
	bh=XJxI7uHxt3dMSe0hA6z9TfOPeGi4XB0o2Vmr38733fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jKah7tlEgJL65T5oadkm21XAmhIBwqDVaKz2lKfMEvcC9F/xarEy5nZxnXFEEzl0Z
	 Vg3xOPXJsD+wSk8eh0uH2EmBia0G44SFCcnwKmRETJyGKQRN5GKDWCBj2Tzm5Fg64r
	 +SYMv0UunsRpDxfK+tLE7bAIqMVeAkWWytYuu3NN20H3X34wMuaepQLEcqDBlINrbJ
	 WLqFda4knCf2E+jMz0qtxG/G/lNk0PCZw8Fa31WQJBbp+iwurA5gKH2VXTGwcnyRWl
	 ZmnJOfJNs844SLwWksj0KwH1fdC+CeQml0yA4GW4TBDZke8cqiuJd49IGPfj+JjUWO
	 2WHeCViOGFo0w==
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
Subject: [PATCH v11 19/19] perf scripts: Add a coverage table
Date: Sun, 22 Nov 2026 18:40:25 -0300
Message-ID: <20261122214025.16769-20-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
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

Render the report of the last coverage run as a table of the files with
the most uncovered lines, biggest gap first; --all lists every file and
-f picks files explicitly, failing when a requested file has no coverage
data.  coverage.sh prints the table when a run finishes; it is also wired
as 'make -C tools/perf coverage-table', to print just the table.  It only
reads coverage.sh's report.txt, so the measurement and the table are
reviewed and changed separately.

For example, with --top 4 on a full test suite run:

    $ make -C tools/perf coverage-table O=/tmp/build/coverage \
          COVERAGE_ARGS="--top 4"
    tools/perf (no tests/ or bench/), 100+ executable lines:
    the 4 biggest uncovered gaps, start here when adding coverage tests.
    --all for every file: make -C tools/perf coverage-table O=/tmp/build/coverage COVERAGE_ARGS="--all"

    ┌──────────────────────────────────────────┬────────┬────────┬────────┬─────────────────────────────┬─────────────┬──────────┐
    │ File                                     │  Lines │    Hit │   Miss │        Line Coverage        │       Funcs │  FuncCov │
    ├──────────────────────────────────────────┼────────┼────────┼────────┼─────────────────────────────┼─────────────┼──────────┤
    │ util/intel-pt.c                          │   3237 │      0 │   3237 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/142   │    0.00% │
    │ util/intel-pt-decoder/intel-pt-decoder.c │   3208 │      0 │   3208 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/119   │    0.00% │
    │ ui/browsers/hists.c                      │   2742 │      0 │   2742 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/124   │    0.00% │
    │ builtin-sched.c                          │   3737 │   1543 │   2194 │ ████████░░░░░░░░░░░░  41.3% │    62/141   │   43.97% │
    ├──────────────────────────────────────────┼────────┼────────┼────────┼─────────────────────────────┼─────────────┼──────────┤
    │ TOTAL (perf)                             │ 174097 │  86374 │  87723 │ █████████░░░░░░░░░░░  49.6% │  5650/9358  │   60.38% │
    └──────────────────────────────────────────┴────────┴────────┴────────┴─────────────────────────────┴─────────────┴──────────┘

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile                  |   5 +-
 tools/perf/Makefile.perf             |   3 +-
 tools/perf/scripts/coverage-table.sh | 337 +++++++++++++++++++++++++++
 tools/perf/scripts/coverage.sh       |  14 +-
 4 files changed, 354 insertions(+), 5 deletions(-)
 create mode 100755 tools/perf/scripts/coverage-table.sh

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index d9ad8c0d796c2852..5da13faa1c18b510 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -150,6 +150,9 @@ coverage-prep:
 coverage:
 	@./scripts/coverage.sh $(coverage_o) $(COVERAGE_ARGS)
 
+coverage-table:
+	@./scripts/coverage-table.sh $(coverage_o) $(COVERAGE_ARGS)
+
 #
 # All other targets get passed through:
 #
@@ -157,4 +160,4 @@ coverage:
 	$(print_msg)
 	$(make)
 
-.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball check-headers sync-headers coverage coverage-prep
+.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball check-headers sync-headers coverage coverage-prep coverage-table
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 1b4efe6254fa0370..6427d3a012c465d1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -878,7 +878,8 @@ help:
 	@echo '  sync-headers		- sync those header copies with the kernel, creating commits'
 	@echo '			  (SYNC_HEADERS_ARGS="..." passes options to the script)'
 	@echo '  coverage-prep		- build perf with clang coverage, ready for a root test run'
-	@echo '  coverage		- build perf with clang coverage, run the tests and report'
+	@echo '  coverage		- build perf with clang coverage, run the tests, report and show the table'
+	@echo '  coverage-table	- print a text table of the last coverage run'
 	@echo '			  (O=DIR uses an existing build dir; COVERAGE_ARGS="..." passes options)'
 
 
diff --git a/tools/perf/scripts/coverage-table.sh b/tools/perf/scripts/coverage-table.sh
new file mode 100755
index 0000000000000000..31d23b33b8720c33
--- /dev/null
+++ b/tools/perf/scripts/coverage-table.sh
@@ -0,0 +1,337 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2026, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#
+# Render the report of the last coverage run as a text table, like pahole's
+# coverage_table.py.  Without -f the default is the tool's files, not its
+# tests and benches, with the most uncovered lines, biggest gap first;
+# --all lists every tools/perf file, most covered first.  The total is the
+# tools/perf subtotal, the run summary has the whole report.
+
+set -euo pipefail
+
+PERF_DIR=$(cd "$(dirname "$0")/.." && pwd -P)
+TOOLS_DIR=$(cd "$PERF_DIR/.." && pwd -P)
+
+BUILD_DIR=${BUILD_DIR:-}
+COV_DIR=${COV_DIR:-}
+TOP=${TOP:-20}
+MIN_LINES=${MIN_LINES:-100}
+TABLE_ALL=0
+FOCUS=()
+
+die()  { printf '\033[0;31merror:\033[0m %s\n' "$*" >&2; exit 1; }
+
+usage()
+{
+	cat <<EOF
+Usage: scripts/coverage-table.sh [options]
+
+Render the report of the last coverage run as a text table.  Run
+scripts/coverage.sh first to produce the report.
+
+Options:
+  -b, --build-dir DIR    build directory of the run (default: $PERF_DIR)
+  -c, --cov-dir DIR      directory with report.txt (default: BUILD_DIR/cov)
+  -f, --focus FILE       add a file to the table (repeatable)
+      --top N            default view: the N files with the most uncovered
+                         lines (default: $TOP, 0 to disable)
+      --all              list every tools/perf file, most covered first
+      --min-lines N      default view: only files with N+ executable
+                         lines (default: $MIN_LINES)
+  -h, --help             show this help
+
+Environment: BUILD_DIR, COV_DIR, TOP, MIN_LINES
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
+	--all|-h|--help)
+		[ -z "$optval" ] || die "$arg takes no value" ;;
+	esac
+
+	case "$arg" in
+	-b|--build-dir) BUILD_DIR=${optval:-${2:?$arg needs a value}}
+	                [ -z "$optval" ] && shift ;;
+	-c|--cov-dir)   COV_DIR=${optval:-${2:?$arg needs a value}}
+	                [ -z "$optval" ] && shift ;;
+	-f|--focus)     FOCUS+=("${optval:-${2:?$arg needs a value}}")
+	                [ -z "$optval" ] && shift ;;
+	--top)          TOP=${optval:-${2:?$arg needs a value}}
+	                [ -z "$optval" ] && shift ;;
+	--min-lines)    MIN_LINES=${optval:-${2:?$arg needs a value}}
+	                [ -z "$optval" ] && shift ;;
+	--all)          TABLE_ALL=1 ;;
+	-h|--help)      usage; exit 0 ;;
+	-*)             die "unknown option: $arg (see --help)" ;;
+	*)              die "unexpected argument: $arg (see --help)" ;;
+	esac
+	shift
+done
+
+[ -n "$BUILD_DIR" ] || BUILD_DIR=$PERF_DIR
+BUILD_DIR=$(realpath -m "$BUILD_DIR")
+[ -n "$COV_DIR" ] || COV_DIR=$BUILD_DIR/cov
+COV_DIR=$(realpath -m "$COV_DIR")
+REPORT=$COV_DIR/report.txt
+
+[ -f "$REPORT" ] || die "no $REPORT, run coverage first"
+[[ $TOP =~ ^[0-9]+$ ]] || die "--top wants a number, not '$TOP'"
+[[ $MIN_LINES =~ ^[0-9]+$ ]] ||
+	die "--min-lines wants a number, not '$MIN_LINES'"
+# awk reads 08 as eight, printf as an invalid octal number; use decimal.
+TOP=$((10#$TOP))
+MIN_LINES=$((10#$MIN_LINES))
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
+			if ($1 != "TOTAL" &&
+			    (path == f || path == g || $1 == f)) {
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
+		local row rows= missing=()
+
+		for file in "${FOCUS[@]}"; do
+			row=$(table_row "$REPORT" "$file")
+			if [ -z "$row" ]; then
+				missing+=("$file")
+				continue
+			fi
+			rows+=$row$'\n'
+		done
+		if [ ${#missing[@]} -gt 0 ]; then
+			printf 'error: no coverage data in %s for:\n' "$REPORT" >&2
+			printf '  %s\n' "${missing[@]}" >&2
+			exit 1
+		fi
+		printf '%s' "$rows" | sort -t$'\t' -k5,5gr
+		return
+	fi
+
+	if [ "$TABLE_ALL" = 1 ]; then
+		awk -v build="$BUILD_AWK_DIR" "$AWK_PERF"'
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
+	awk -v min="$MIN_LINES" -v build="$BUILD_AWK_DIR" "$AWK_PERF"'
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
+	awk -v build="$BUILD_AWK_DIR" "$AWK_PERF"'
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
+	local cmd='make -C tools/perf coverage-table'
+	local cov_args='--all'
+	[ "$BUILD_DIR" = "$PERF_DIR" ] || cmd+=" O=$BUILD_DIR"
+	[ "$COV_DIR" = "$BUILD_DIR/cov" ] ||
+		cov_args="--cov-dir $COV_DIR --all"
+	printf '%s %s COVERAGE_ARGS="%s"\n' '--all for every file:' "$cmd" "$cov_args"
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
+# The table code parses llvm-cov's decimal points; keep the numeric locale
+# fixed.
+export LC_ALL=C
+print_table
diff --git a/tools/perf/scripts/coverage.sh b/tools/perf/scripts/coverage.sh
index 90845f94ac930cca..9cbb368aae1795e5 100755
--- a/tools/perf/scripts/coverage.sh
+++ b/tools/perf/scripts/coverage.sh
@@ -3,8 +3,9 @@
 #
 # Copyright (C) 2026, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 #
-# Build perf with clang source based coverage, run the perf test suite and
-# report line coverage.
+# Build perf with clang source based coverage, run the perf test suite,
+# report line coverage and the table of the files with the most uncovered
+# lines.  coverage-table.sh renders that table from the last report alone.
 # The build goes into tools/perf and the profiles and report into
 # tools/perf/cov; -b and -c override them, following perf's O= layout.
 # --prep stops after the instrumented build, for running the tests later as
@@ -44,7 +45,9 @@ usage()
 Usage: scripts/coverage.sh [options] [test name fragment...]
 
 Builds perf with clang source based coverage, runs the complete perf test
-suite and reports line coverage.  Use -t to run a subset.
+suite, reports line coverage and the files with the most uncovered lines.
+Use -t to run a subset; scripts/coverage-table.sh renders the table again
+with other options.
 
 Options:
   -b, --build-dir DIR    existing perf build directory (default: $PERF_DIR)
@@ -64,6 +67,7 @@ Through make:
   make -C tools/perf coverage
   make -C tools/perf coverage-prep O=/tmp/build/perf-coverage
   sudo make -C tools/perf coverage O=/tmp/build/perf-coverage
+  make -C tools/perf coverage-table O=/tmp/build/perf-coverage
 EOF
 }
 
@@ -477,6 +481,10 @@ render_report
 print_summary
 update_baseline
 
+printf "\n"
+"$PERF_DIR/scripts/coverage-table.sh" --build-dir "$BUILD_DIR" \
+	--cov-dir "$COV_DIR" || warn "could not render the coverage table"
+
 printf "\nReport:  %s\n" "$REPORT"
 # The python extension rule can't see the compiler flags change, so drop
 # what this run built for the next build.
-- 
2.56.1

