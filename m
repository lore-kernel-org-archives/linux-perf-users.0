Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622169;
	b=0e7rt6MZOVaMQvBPAMDYe5r0yrV4Uzd2wTJ81e7kd2hgTsBGJNZw9i/mVnInPHRYFpiV
	 E/vfoe51c31OMV7aO58Hjt6xvsdtvkODZ9hDgMz9GavUsq8S9I+0H6pNS9L9IG9Fm/bKm
	 yEiQkLXCuFm+DC8/urmJwochmGyncS3wBw7AxNS1bRSZJAhSqaereDi/3Jof6vVtEz/nl
	 90OKw3/Oc3OZ44/mcgXxrgf/Wy0kEtje18mLL/UrFyN/NL/owaype0Pqvfz0IogR7reu5
	 y81InKY3CjdYcfO7XQLN+44hqT60h4phOkbtg9qjOT+OJXCOdw8i1oIKuH72IQL2qPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622169;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NRokOLRb/5GtKS073zjoyj0kk7pPkP+9Z/0qos+TSPo=;
	b=hQhQjLVuYLObfagmk3GAM0lCHy28v9o3PQ+g0y8Rb4PYu+P+fsa02gCMs5O7UnP8mbOP
	 8N/ce8TjhxnPx8HJbyubXG+xZyfapt3GQucrrkcQo/D4MoD5nJ8wQuqQPskuX2ELWPcen
	 DBBKeSRWWCEN3+KHza9k58dch3pHEYdD1YWmGWu3wTRRDAiETI4sC1ucg80ETcxieek0h
	 pj061kQxCtSLhhF75Jr8Zt2l+Yp9jZsp2TRm0bXwj5Ikd2tBPYPuObCxfwZCSvQ83DXKf
	 yqlOkd+uCwKrv1EA/ZE9/zdFcy5ayXXSbsDvZqbifvVX9jyx2Q4B/GrU0vZ4sPkJPrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKIn2D4y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC8C606A31D
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKIn2D4y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEB31F000C2;
	Wed, 21 Oct 2026 22:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622168;
	bh=NRokOLRb/5GtKS073zjoyj0kk7pPkP+9Z/0qos+TSPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jKIn2D4yVotNfRFveS2c55l4atBW7sAeu6pnlI930DGTB/t0ib604Wof/OdNHCgIA
	 SEP95YGf4MJNR3tIEssdS6dAEMlFJoQN/fQq4VW3FlSd3X9ZEmqv7daB5bppi656nu
	 4i4LPzFUircz7y2KsobYKdnQlJTrDPU2VsACLNfaX3fSOUviVBmcwavA0X7U2CBj6/
	 ++QkI+Pgz4YVr5D2I8tfpts+npuzUzC8u2jdzwwsV5Sf/6dZ4NPNZ0tdYtJ0m3G1BE
	 avmeIw7a+8AgDbDwcBB66AAM3kmE5ZWILN2iZjmZyA/KK6bdPwBO5U2je8s5H/OA4K
	 5Q6VD4TybbADQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 01/12] perf tools: Add script and make target to sync the header copies with the kernel
Date: Wed, 21 Oct 2026 19:35:40 -0300
Message-ID: <20261021223555.28372-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021223555.28372-1-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
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

This is to be used by the perf maintainers to sync the header copies
with the kernel originals, see the description below for how it works.

  $ tools/perf/scripts/sync-headers.sh --help
  Usage: sync-headers.sh [OPTIONS]

  Sync tools/ header copies with the kernel sources and create commits.

  Options:
    -n, --dry-run       Show what would be done without making changes
    -N, --no-build      Skip the perf build verification step
    -C, --no-commit     Copy files but do not create git commits
    -f, --filter PAT    Only process headers matching PAT (substring match
                        against the kernel-side path)
    -o, --output DIR    Build output directory (default: /tmp/build/perf-tools-1000)
    -v, --verbose       Show more details
    -h, --help          Show this help

  Environment:
    SIGN_OFF_NAME       Override git user.name for Signed-off-by
    SIGN_OFF_EMAIL      Override git user.email for Signed-off-by
    OUTPUT_DIR          Build output directory

  Through make:
    SYNC_HEADERS_ARGS   Options to pass to this script, e.g.:
                        make -C tools/perf sync-headers SYNC_HEADERS_ARGS='-n'

  The script:
    1. Runs 'make -C tools/perf check-headers' to find stale copies.
    2. For each stale header, identifies the kernel commits that changed it.
    3. Copies the kernel header into the tools/ tree.
    4. For beauty headers, runs the relevant beauty script(s) before and
       after, showing new/changed string table entries.
    5. Builds perf and the other consumers of the header to verify nothing
       breaks.
    6. Creates a git commit per header (or group) with the standard commit
       message format.

  $

It is also available as:

  $ make -C tools/perf sync-headers
  ==> Running check-headers to detect stale copies...

  Stale headers found:
  tools/include/uapi/linux/if_addr.h include/uapi/linux/if_addr.h
  tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
  tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
  ...
  tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h

  ==> Processing: include/uapi/linux/if_addr.h

    Kernel commits since last sync:
    7cb8198761e6 ("net: ipv4: report multicast group user count")
  ==> Copied include/uapi/linux/if_addr.h -> tools/include/uapi/linux/if_addr.h
  ==> Build-testing consumers of if_addr.h:
      perf (tools/perf)
  ==> Build OK.
  ==> Committed: tools headers UAPI: Sync linux/if_addr.h with the kernel sources

  ==> Processing: include/uapi/linux/perf_event.h
  Warning: tools/include/uapi/linux/perf_event.h matches a previous tools/ state, leaving it alone

  ==> Processing: include/uapi/linux/rtnetlink.h

    Kernel commits since last sync:
    cc17e386f8a5 ("ipv6: add ip6_del_rt_reason()")
  ==> Copied include/uapi/linux/rtnetlink.h -> tools/include/uapi/linux/rtnetlink.h
  ==> Build-testing consumers of rtnetlink.h:
      libbpf (tools/lib/bpf)
      bpftool (tools/bpf/bpftool)
      perf (tools/perf)
  ==> Build OK.
  ==> Committed: tools headers UAPI: Sync linux/rtnetlink.h with the kernel sources
  ...
  ==> Processing: include/linux/socket.h

    Kernel commits since last sync:
    be3a5e06b962 ("net: add SO_PASSPIDFD_THREAD to get a thread-specific SCM_PIDFD")
    5bd369c05576 ("net: Add connect_socket() helper")
  ==> Copied include/linux/socket.h -> tools/perf/trace/beauty/include/linux/socket.h
  ==> Build-testing consumers of socket.h:
      perf (tools/perf)
  ==> Build OK.
  ==> Committed: perf beauty: Update copy of linux/socket.h with the kernel sources
  ...

  ==> Processing group: KVM headers (3 files)
  ...
  ==> Build-testing consumers of group KVM headers:
      perf (tools/perf)
  ==> Build OK.
  ...

  =========================================
   Summary
  =========================================
  ==> Synced successfully (13):
      tools/include/uapi/linux/if_addr.h
      tools/include/uapi/linux/rtnetlink.h
      tools/include/linux/gfp_types.h
      tools/arch/x86/include/asm/cpufeatures.h
      tools/arch/x86/include/asm/msr-index.h
      tools/perf/trace/beauty/include/linux/socket.h
      tools/perf/trace/beauty/include/uapi/linux/fcntl.h
      tools/perf/trace/beauty/include/uapi/linux/fs.h
      tools/perf/trace/beauty/include/uapi/linux/mount.h
      tools/perf/trace/beauty/include/uapi/sound/asound.h
      tools/include/uapi/linux/kvm.h
      tools/arch/powerpc/include/uapi/asm/kvm.h
      tools/arch/arm64/include/uapi/asm/kvm.h

  Warning: Headers still out of sync:
  tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
  tools/arch/x86/include/uapi/asm/perf_regs.h arch/x86/include/uapi/asm/perf_regs.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile                |    5 +-
 tools/perf/Makefile.perf           |    3 +
 tools/perf/scripts/sync-headers.sh | 1256 ++++++++++++++++++++++++++++
 3 files changed, 1263 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/scripts/sync-headers.sh

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index c1818bd5f2879ac9..00baf90e5bda7123 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -137,6 +137,9 @@ build-test-tarball:
 check-headers:
 	@./check-headers.sh
 
+sync-headers:
+	@./scripts/sync-headers.sh $(SYNC_HEADERS_ARGS)
+
 #
 # All other targets get passed through:
 #
@@ -144,4 +147,4 @@ check-headers:
 	$(print_msg)
 	$(make)
 
-.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball check-headers
+.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball check-headers sync-headers
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2d9379fea2672755..b74b534e1153ffcb 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -870,6 +870,9 @@ help:
 	@echo ''
 	@echo 'Perf maintainer targets:'
 	@echo '  clean			- clean all binary objects and build output'
+	@echo '  check-headers		- check which header copies are out of sync with the kernel'
+	@echo '  sync-headers		- sync those header copies with the kernel, creating commits'
+	@echo '			  (SYNC_HEADERS_ARGS="..." passes options to the script)'
 
 
 DOC_TARGETS := doc man html info pdf
diff --git a/tools/perf/scripts/sync-headers.sh b/tools/perf/scripts/sync-headers.sh
new file mode 100755
index 0000000000000000..9a35a3d2095a7342
--- /dev/null
+++ b/tools/perf/scripts/sync-headers.sh
@@ -0,0 +1,1256 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2026, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#
+# Sync tools/ header copies with the kernel sources, generate beauty
+# string table diffs, verify perf still builds, and create git commits.
+
+set -euo pipefail
+
+YELLOW='\033[0;33m'
+GREEN='\033[0;32m'
+RED='\033[0;31m'
+NC='\033[0m'
+
+PERF_DIR=$(cd "$(dirname "$0")/.." && pwd)
+KERNEL_DIR=$(cd "$PERF_DIR/../.." && pwd)
+DRY_RUN=0
+BUILD=1
+COMMIT=1
+OUTPUT_DIR="${OUTPUT_DIR:-${TMPDIR:-/tmp}/build/perf-tools-$(id -u)}"
+SIGN_OFF_NAME="${SIGN_OFF_NAME:-}"
+SIGN_OFF_EMAIL="${SIGN_OFF_EMAIL:-}"
+HEADER_FILTER=""
+VERBOSE=0
+
+# Track build successes and failures for end-of-run summary
+declare -a SYNCED_OK=()
+declare -a BUILD_FAILED=()
+declare -a COPY_FAILED=()
+declare -a COMMIT_FAILED=()
+
+info()  { echo -e "${GREEN}==>${NC} $*"; }
+warn()  { echo -e "${YELLOW}Warning:${NC} $*"; }
+err()   { echo -e "${RED}Error:${NC} $*" >&2; }
+detail(){ [[ $VERBOSE -eq 1 ]] && echo -e "    $*"; return 0; }
+
+usage() {
+	local status="${1:-0}"
+
+	cat <<EOF
+Usage: $(basename "$0") [OPTIONS]
+
+Sync tools/ header copies with the kernel sources and create commits.
+
+Options:
+  -n, --dry-run       Show what would be done without making changes
+  -N, --no-build      Skip the perf build verification step
+  -C, --no-commit     Copy files but do not create git commits
+  -f, --filter PAT    Only process headers matching PAT (substring match
+                      against the kernel-side path)
+  -o, --output DIR    Build output directory (default: $OUTPUT_DIR)
+  -v, --verbose       Show more details
+  -h, --help          Show this help
+
+Environment:
+  SIGN_OFF_NAME       Override git user.name for Signed-off-by
+  SIGN_OFF_EMAIL      Override git user.email for Signed-off-by
+  OUTPUT_DIR          Build output directory
+
+Through make:
+  SYNC_HEADERS_ARGS   Options to pass to this script, e.g.:
+                      make -C tools/perf sync-headers SYNC_HEADERS_ARGS='-n'
+
+The script:
+  1. Runs 'make -C tools/perf check-headers' to find stale copies.
+  2. For each stale header, identifies the kernel commits that changed it.
+  3. Copies the kernel header into the tools/ tree.
+  4. For beauty headers, runs the relevant beauty script(s) before and
+     after, showing new/changed string table entries.
+  5. Builds perf and the other consumers of the header to verify nothing
+     breaks.
+  6. Creates a git commit per header (or group) with the standard commit
+     message format.
+
+EOF
+	exit "$status"
+}
+
+while [[ $# -gt 0 ]]; do
+	case "$1" in
+	-n|--dry-run)   DRY_RUN=1; shift ;;
+	-N|--no-build)  BUILD=0; shift ;;
+	-C|--no-commit) COMMIT=0; shift ;;
+	-f|--filter)
+		[[ $# -ge 2 ]] || { err "$1 needs an argument"; exit 1; }
+		HEADER_FILTER="$2"; shift 2 ;;
+	-o|--output)
+		[[ $# -ge 2 ]] || { err "$1 needs an argument"; exit 1; }
+		OUTPUT_DIR="$2"; shift 2 ;;
+	-v|--verbose)   VERBOSE=1; shift ;;
+	-h|--help)      usage ;;
+	*) err "Unknown option: $1"; usage 1 ;;
+	esac
+done
+
+sign_off() {
+	local name="${SIGN_OFF_NAME:-$(git config user.name)}"
+	local email="${SIGN_OFF_EMAIL:-$(git config user.email)}"
+	echo "Signed-off-by: $name <$email>"
+}
+
+# --- Detect stale headers ------------------------------------------------
+
+detect_stale_headers() {
+	local tmpfile
+	tmpfile=$(mktemp)
+
+	# check-headers.sh must be run from tools/perf/ (it does cd ../.. internally)
+	(cd "$PERF_DIR" && bash check-headers.sh 2>/dev/null) | \
+		grep '^ *diff -u ' | \
+		sed 's/^ *diff -u //' > "$tmpfile"
+
+	if [[ ! -s "$tmpfile" ]]; then
+		rm -f "$tmpfile"
+		return 1
+	fi
+
+	cat "$tmpfile"
+	rm -f "$tmpfile"
+	return 0
+}
+
+# --- Classify a header ---------------------------------------------------
+#
+# Returns via globals:
+#   HDR_CLASS: "files" | "beauty"
+classify_header() {
+	local tools_path="$1"
+
+	if [[ "$tools_path" == tools/perf/trace/beauty/* ]]; then
+		HDR_CLASS="beauty"
+	else
+		HDR_CLASS="files"
+	fi
+}
+
+# --- Find kernel commits that changed a header since our copy ------------
+
+# The last commit that left the two copies equal, found by content: an
+# in-tree kernel commit can update the copy from a tree state that
+# already misses an earlier kernel change to the header (the
+# linux/gfp_types.h doc fix), so the last commit touching the copy can be
+# newer than the first commit still missing from it.  Falls back to the
+# last commit that touched the tools copy.
+#
+# The walk can run to the end of the history when no commit ever left the
+# two byte-identical (copies compared with -I patterns are rewritten on
+# purpose), so all the blob comparisons go through one
+# git cat-file --batch-check, no forks per commit.
+find_sync_point() {
+	local kernel_path="$1"
+	local tools_path="$2"
+	local -a candidates blobs
+	local i
+
+	mapfile -t candidates < <(git log --no-merges --format='%H' -- "$kernel_path" "$tools_path" 2>/dev/null)
+	mapfile -t blobs < <(
+		printf '%s\n' "${candidates[@]}" | \
+		awk -v k="$kernel_path" -v t="$tools_path" '{ print $1 ":" k ORS $1 ":" t }' | \
+		git cat-file --batch-check)
+
+	for ((i = 0; i < ${#candidates[@]}; i++)); do
+		# "<spec> missing" keeps the ':' of the spec as its first field,
+		# which no object id has.
+		if [[ "${blobs[2*i]%% *}" == "${blobs[2*i+1]%% *}" && \
+		      "${blobs[2*i]%% *}" != *:* ]]; then
+			echo "${candidates[i]}"
+			return
+		fi
+	done
+
+	git log --no-merges --format='%H' -1 -- "$tools_path" 2>/dev/null
+}
+
+# A kernel commit that changed both the header and the tools copy already
+# carried its change into tools/, so it has nothing left to pick up here.
+find_kernel_commits() {
+	local kernel_path="$1"
+	local tools_path="$2"
+	local sync_point="$3"
+	local copied sha
+
+	copied=$(git log --no-merges --format='%H' \
+		"${sync_point}..HEAD" -- "$tools_path" 2>/dev/null)
+	[[ -n "$copied" ]] && copied+=$'\n'
+
+	while IFS= read -r sha; do
+		[[ "$copied" == *"$sha"$'\n'* ]] && continue
+		echo "$sha"
+	done < <(git log --no-merges --format='%H' \
+		"${sync_point}..HEAD" -- "$kernel_path" 2>/dev/null)
+}
+
+# Render commit ids with FORMAT at the usual 12 chars, keeping their order.
+format_commits() {
+	local format="$1"
+	local ids="$2"
+
+	[[ -n "$ids" ]] || return 0
+	printf '%s\n' "$ids" | git log --no-walk=unsorted --abbrev=12 \
+		--format="$format" --stdin 2>/dev/null
+}
+
+# The kernel's current content can match a previous tools/ copy state when
+# the kernel reverted the header; there is nothing to pick up then.
+kernel_matches_previous_tools_state() {
+	local kernel_path="$1"
+	local tools_path="$2"
+	local kernel_blob
+
+	kernel_blob=$(git hash-object "$kernel_path" 2>/dev/null) || return 1
+	[[ -n "$(git log --format=%h -1 --find-object="$kernel_blob" -- "$tools_path" 2>/dev/null)" ]]
+}
+
+# --- Map a kernel header path to its beauty script(s) --------------------
+#
+# A beauty script is relevant if it reads from the directory containing
+# the header being updated.
+
+find_beauty_scripts() {
+	local kernel_path="$1"
+	local header_basename
+	header_basename=$(basename "$kernel_path")
+
+	local scripts=()
+
+	# Search all beauty .sh scripts (including subdirs) for references to this header
+	while IFS= read -r script; do
+		if grep -F -q -e "/$header_basename" -e "\"$header_basename\"" \
+			"$script" 2>/dev/null; then
+			scripts+=("$script")
+		fi
+	done < <(find "$PERF_DIR"/trace/beauty -name '*.sh')
+
+	printf '%s\n' "${scripts[@]}"
+}
+
+# --- Find buildable targets that consume a header -------------------------
+#
+# Given a tools/ header path, grep tools/ source files to find which
+# buildable directories include it, then return them as build commands.
+# This is discovered dynamically so new consumers are picked up automatically.
+
+# C sources include tools/ headers by their include-relative path, e.g.
+# <linux/socket.h> for tools/include/uapi/linux/socket.h.
+include_relative_path() {
+	local tools_path="$1"
+
+	case "$tools_path" in
+	tools/include/uapi/*)
+		echo "${tools_path#tools/include/uapi/}"
+		;;
+	tools/include/*)
+		echo "${tools_path#tools/include/}"
+		;;
+	tools/arch/*/include/uapi/*)
+		echo "${tools_path#tools/arch/*/include/uapi/}"
+		;;
+	tools/arch/*/include/*)
+		echo "${tools_path#tools/arch/*/include/}"
+		;;
+	*)
+		basename "$tools_path"
+		;;
+	esac
+}
+
+# Map from a source file path to its buildable target directory and make command.
+# Returns empty if the file doesn't belong to a known buildable target.
+buildable_target() {
+	local src="$1"
+	case "$src" in
+	tools/perf/*)
+		echo "perf:$PERF_DIR"
+		;;
+	tools/lib/bpf/*)
+		echo "libbpf:$KERNEL_DIR/tools/lib/bpf"
+		;;
+	tools/bpf/bpftool/*)
+		echo "bpftool:$KERNEL_DIR/tools/bpf/bpftool"
+		;;
+	tools/objtool/*)
+		echo "objtool:$KERNEL_DIR/tools/objtool"
+		;;
+	tools/lib/subcmd/*)
+		echo "libsubcmd:$KERNEL_DIR/tools/lib/subcmd"
+		;;
+	tools/lib/api/*)
+		echo "libapi:$KERNEL_DIR/tools/lib/api"
+		;;
+	tools/lib/perf/*)
+		echo "libperf:$KERNEL_DIR/tools/lib/perf"
+		;;
+	tools/lib/symbol/*)
+		echo "libsymbol:$KERNEL_DIR/tools/lib/symbol"
+		;;
+	tools/tracing/*)
+		echo "tracing:$KERNEL_DIR/tools/tracing"
+		;;
+	esac
+}
+
+find_build_targets() {
+	local tools_path="$1"
+	local header_class="$2"
+	local include_path
+	local targets=()
+	local seen=()
+
+	# Beauty copies are only on the include path of the beauty scripts.
+	if [[ "$header_class" == "beauty" ]]; then
+		echo "perf:$PERF_DIR"
+		return
+	fi
+
+	include_path=$(include_relative_path "$tools_path")
+
+	while IFS= read -r src; do
+		[[ -z "$src" ]] && continue
+		local target
+		target=$(buildable_target "$src")
+		[[ -z "$target" ]] && continue
+
+		# Deduplicate
+		local already=0
+		for s in "${seen[@]+"${seen[@]}"}"; do
+			if [[ "$s" == "$target" ]]; then
+				already=1
+				break
+			fi
+		done
+		if [[ $already -eq 0 ]]; then
+			seen+=("$target")
+			targets+=("$target")
+		fi
+	done < <(grep -rlF -e "<$include_path>" -e "\"$include_path\"" -e "/$include_path" \
+		--include='*.c' --include='*.h' --include='*.S' \
+		"$KERNEL_DIR/tools/" 2>/dev/null | \
+		sed "s|^$KERNEL_DIR/||" | grep -v '^tools/include/')
+
+	# Always include perf
+	local has_perf=0
+	for t in "${targets[@]+"${targets[@]}"}"; do
+		[[ "$t" == perf:* ]] && has_perf=1
+	done
+	if [[ $has_perf -eq 0 ]]; then
+		targets+=("perf:$PERF_DIR")
+	fi
+
+	printf '%s\n' "${targets[@]}"
+}
+
+# Print the consumers that will be built for a header or group.
+show_build_targets() {
+	local what="$1"
+	local target_list="$2"
+
+	info "Build-testing consumers of $what:"
+	while IFS=: read -r name dir; do
+		[[ -z "$name" ]] && continue
+		echo "    $name ($dir)"
+	done <<< "$target_list"
+}
+
+# Keep build output out of the source tree; perf, tracing and objtool take
+# O=, the libraries and bpftool take OUTPUT=.
+build_target() {
+	local name="$1"
+	local dir="$2"
+
+	case "$name" in
+	perf)
+		make -C "$dir" O="$OUTPUT_DIR" -j"$(nproc)"
+		;;
+	tracing|objtool)
+		(umask 077 && mkdir -p "$OUTPUT_DIR/$name")
+		make -C "$dir" O="$OUTPUT_DIR/$name" -j"$(nproc)"
+		;;
+	*)
+		(umask 077 && mkdir -p "$OUTPUT_DIR/$name")
+		make -C "$dir" OUTPUT="$OUTPUT_DIR/$name/" -j"$(nproc)"
+		;;
+	esac
+}
+
+# Run build tests for all targets that consume a header.
+# Returns 0 if all builds pass, 1 if any fail.
+build_test_targets() {
+	local tools_path="$1"
+	local header_class="$2"
+	local header_basename log_name
+	local target_list failed=0
+
+	header_basename=$(basename "$tools_path")
+	# Key the log by tools path, same-basename headers in different
+	# directories would otherwise share a log.
+	log_name="${tools_path//\//-}"
+	target_list=$(find_build_targets "$tools_path" "$header_class")
+	show_build_targets "$header_basename" "$target_list"
+
+	while IFS=: read -r name dir; do
+		[[ -z "$name" ]] && continue
+		local log="$OUTPUT_DIR/$name.$log_name.log"
+		if ! build_target "$name" "$dir" > "$log" 2>&1; then
+			err "  $name build failed, see $log"
+			failed=1
+		fi
+	done <<< "$target_list"
+
+	return $failed
+}
+
+# --- Run a beauty script capturing output --------------------------------
+#
+# The build invokes these scripts with the directories they read from
+# (tools/perf/trace/beauty/Build); run bare, arch_errno_names.sh misses
+# the header copies and the tables miss the changes.
+
+declare -A BEAUTY_SCRIPT_ARGS=()
+declare -A BEAUTY_MAKE_DIRS=()
+declare -A BEAUTY_MAKE_SCRIPTS=()
+
+# Read the beauty script arguments out of the same Build file the build
+# uses, so a new script or a changed directory needs no edit here.
+# The single quotes below hold literal make syntax from the Build
+# file, not shell expressions.
+# shellcheck disable=SC2016
+setup_beauty_args() {
+	local build="$PERF_DIR/trace/beauty/Build"
+	local -a rule_lines=()
+	local line var script args token value
+	local re_dir re_tbl srcarch
+
+	# _dir :=, _tbl := assignments, and the $(SHELL) rules using them.
+	re_dir='^([a-z0-9_]+_(dir|dirs))[[:space:]]*(:=|\?=)[[:space:]]*'
+	re_dir+='\$\(srctree\)/(.*)$'
+	re_tbl='^([a-z0-9_]+_tbl[s]?)[[:space:]]*(:=|\?=)[[:space:]]*'
+	re_tbl+='\$\(srctree\)/((.*\.sh))[[:space:]]*$'
+
+	srcarch=$(uname -m)
+	case "$srcarch" in
+	x86_64|i[3-6]86) srcarch=x86 ;;
+	aarch64|arm64)   srcarch=arm64 ;;
+	s390*)           srcarch=s390 ;;
+	riscv*)          srcarch=riscv ;;
+	loongarch*)      srcarch=loongarch ;;
+	ppc*)            srcarch=powerpc ;;
+	sparc*)          srcarch=sparc ;;
+	mips*)           srcarch=mips ;;
+	esac
+
+	[[ -r "$build" ]] || {
+		detail "No beauty Build file, running the scripts without arguments"
+		return 1
+	}
+
+	while IFS= read -r line; do
+		if [[ "$line" =~ $re_dir ]]; then
+			BEAUTY_MAKE_DIRS["${BASH_REMATCH[1]}"]="${BASH_REMATCH[4]}"
+			continue
+		fi
+		if [[ "$line" =~ $re_tbl ]]; then
+			BEAUTY_MAKE_SCRIPTS["${BASH_REMATCH[1]}"]="${BASH_REMATCH[4]}"
+			continue
+		fi
+		if [[ "$line" == *'$(SHELL)'* ]]; then
+			rule_lines+=("$line")
+		fi
+	done < "$build"
+
+	local rule
+	for rule in "${rule_lines[@]+"${rule_lines[@]}"}"; do
+		IFS="'" read -r _ var args <<< "$rule" || continue
+		[[ "$var" == '$('* ]] || continue
+		var="${var:2:${#var}-3}"
+		script="${BEAUTY_MAKE_SCRIPTS[$var]:-}"
+		[[ -n "$script" ]] || continue
+		script="${script##*/}"
+
+		# $(patsubst -%,,$(CC)) yields the compiler name
+		args=$(printf '%s\n' "$args" | sed 's/\$(patsubst -%,,\$(CC))/gcc/g')
+		args="${args//\'}"
+		args="${args%' > $@'}"
+		value=""
+		for token in $args; do
+			case "$token" in
+			'$@')
+				continue
+				;;
+			'$(srctree)'*)
+				token="${token//\$(srctree)/$KERNEL_DIR}"
+				;;
+			'$('*)
+				token="$KERNEL_DIR/${BEAUTY_MAKE_DIRS["${token:2:${#token}-3}"]:-}"
+				[[ "$token" == "$KERNEL_DIR/" ]] && { value=""; break; }
+				;;
+			*) ;;
+			esac
+			token=$(printf '%s' "$token" | sed "s/\$(SRCARCH)/$srcarch/g")
+			if [[ "$token" == *'$('* ]]; then
+				value=""
+				break
+			fi
+			value+="${value:+ }$token"
+		done
+		[[ -n "$value" ]] || continue
+		BEAUTY_SCRIPT_ARGS["$script"]="$value"
+	done
+}
+
+run_beauty_script() {
+	local script="$1"
+	local -a cmd=()
+
+	read -ra cmd <<< "${BEAUTY_SCRIPT_ARGS["${script##*/}"]:-}"
+	bash "$script" "${cmd[@]+"${cmd[@]}"}" 2>/dev/null || true
+}
+
+# Run one beauty script against the kernel content swapped into the tools
+# copy, capturing its output before and after; the saved copy restores the
+# tools copy, also when the script is interrupted.
+run_beauty_pass() {
+	local script="$1"
+	local kernel_path="$2"
+	local tools_path="$3"
+	local tmpdir="$4"
+	local idx="$5"
+	local before="$tmpdir/beauty.$idx.before"
+	local after="$tmpdir/beauty.$idx.after"
+	local saved="$tmpdir/beauty.$idx.saved"
+	local restore
+
+	if ! cp -p "$KERNEL_DIR/$tools_path" "$saved"; then
+		err "Failed to save $tools_path"
+		return 1
+	fi
+	restore=$(printf 'cp -p %q %q' "$saved" "$KERNEL_DIR/$tools_path")
+	# shellcheck disable=SC2064 # expand now, locals may be gone
+	trap "$restore" EXIT
+	# shellcheck disable=SC2064 # expand now, locals may be gone
+	trap "$restore; trap - EXIT; exit 130" INT
+	# shellcheck disable=SC2064 # expand now, locals may be gone
+	trap "$restore; trap - EXIT; exit 143" TERM
+	(cd "$KERNEL_DIR" && run_beauty_script "$script") > "$before"
+	if ! cp "$KERNEL_DIR/$kernel_path" "$KERNEL_DIR/$tools_path"; then
+		err "Failed to copy $kernel_path -> $tools_path"
+		cp -p "$saved" "$KERNEL_DIR/$tools_path" || \
+			err "Failed to restore $tools_path"
+		trap - INT TERM EXIT
+		return 1
+	fi
+	(cd "$KERNEL_DIR" && run_beauty_script "$script") > "$after"
+	if ! cp -p "$saved" "$KERNEL_DIR/$tools_path"; then
+		err "Failed to restore $tools_path"
+		trap - INT TERM EXIT
+		return 1
+	fi
+	trap - INT TERM EXIT
+}
+
+# The tools/perf/trace/beauty/ relative path of a beauty script, as shown
+# in the commit messages.
+beauty_script_relpath() {
+	echo "tools/perf/trace/beauty/${1##*/trace/beauty/}"
+}
+
+# The commit message fragment for a beauty script whose table changed:
+# the recipe the pre-pass ran and the difference between its two runs.
+beauty_body_fragment() {
+	local script="$1"
+	local kernel_path="$2"
+	local tools_path="$3"
+	local before="$4"
+	local after="$5"
+	local rel_script args
+
+	rel_script=$(beauty_script_relpath "$script")
+	# The runs are from the tree root, show the dirs relative to it.
+	args="${BEAUTY_SCRIPT_ARGS["${script##*/}"]:-}"
+	args="${args//"$KERNEL_DIR/"/}"
+
+	printf '\n'
+	printf '  $ %s%s > before.txt\n' "$rel_script" "${args:+ $args}"
+	printf '  $ cp %s %s\n' "$kernel_path" "$tools_path"
+	printf '  $ %s%s > after.txt\n' "$rel_script" "${args:+ $args}"
+	printf '  $ diff -u before.txt after.txt\n'
+	printf '\n'
+	diff -u "$before" "$after" | tail -n +3 | sed 's/^/  /'
+	printf '\n'
+}
+
+cleanup_tmpdir() {
+	[[ -n "$1" ]] || return 0
+	rm -rf "$1"
+}
+
+# --- Copy header and create commit ---------------------------------------
+
+process_header() {
+	local tools_path="$1"
+	local kernel_path="$2"
+
+	classify_header "$tools_path"
+
+	if [[ -n "$HEADER_FILTER" ]] && [[ "$kernel_path" != *"$HEADER_FILTER"* ]]; then
+		detail "Skipping $kernel_path (does not match filter)"
+		return
+	fi
+
+	info "Processing: $kernel_path"
+	detail "  Class: $HDR_CLASS"
+	detail "  Tools: $tools_path"
+	detail "  Kernel: $kernel_path"
+
+	if kernel_matches_previous_tools_state "$kernel_path" "$tools_path"; then
+		warn "$tools_path matches a previous tools/ state, leaving it alone"
+		return
+	fi
+
+	# Find kernel commits that changed this file
+	local sync_point pickup_commits=""
+	sync_point=$(find_sync_point "$kernel_path" "$tools_path")
+	if [[ -n "$sync_point" ]]; then
+		pickup_commits=$(find_kernel_commits "$kernel_path" \
+			"$tools_path" "$sync_point")
+	else
+		warn "No previous sync commit found for $tools_path"
+	fi
+
+	local kernel_commits=""
+	if [[ -n "$pickup_commits" ]]; then
+		kernel_commits=$(format_commits '  %h ("%s")' "$pickup_commits")
+		echo ""
+		echo "  Kernel commits since last sync:"
+		echo "$kernel_commits"
+	fi
+
+	# For beauty files, capture the string table changes and keep the
+	# before/after files for the commit message.
+	local beauty_changed=0
+	local beauty_tmpdir=""
+	local beauty_scripts
+	local -a beauty_script_list=()
+	beauty_scripts=$(find_beauty_scripts "$kernel_path")
+	while IFS= read -r script; do
+		[[ -z "$script" ]] && continue
+		beauty_script_list+=("$script")
+	done <<< "$beauty_scripts"
+	if [[ ${#beauty_script_list[@]} -gt 0 ]]; then
+		beauty_tmpdir=$(mktemp -d)
+
+		local idx=0
+		for script in "${beauty_script_list[@]}"; do
+			local script_name
+			script_name=$(basename "$script")
+			local before="$beauty_tmpdir/beauty.$idx.before"
+			local after="$beauty_tmpdir/beauty.$idx.after"
+
+			# The script reads the tools/ copy, so swap in the kernel one
+			# and restore the saved copy, also in a dry run.
+			if ! run_beauty_pass "$script" "$kernel_path" "$tools_path" \
+				"$beauty_tmpdir" "$idx"; then
+				COPY_FAILED+=("$tools_path")
+				cleanup_tmpdir "$beauty_tmpdir"
+				return 1
+			fi
+
+			if ! diff -q "$before" "$after" > /dev/null 2>&1; then
+				echo ""
+				info "Beauty string changes from $script_name:"
+				diff -u "$before" "$after" | head -60 || true
+				beauty_changed=1
+			fi
+			idx=$((idx + 1))
+		done
+	fi
+
+	if [[ $DRY_RUN -eq 1 ]]; then
+		cleanup_tmpdir "$beauty_tmpdir"
+		info "(dry run) Would copy $kernel_path -> $tools_path"
+		return
+	fi
+
+	# Do the actual copy
+	if ! cp "$KERNEL_DIR/$kernel_path" "$KERNEL_DIR/$tools_path"; then
+		err "Failed to copy $kernel_path -> $tools_path"
+		COPY_FAILED+=("$tools_path")
+		cleanup_tmpdir "$beauty_tmpdir"
+		return 1
+	fi
+	info "Copied $kernel_path -> $tools_path"
+
+	# Verify the consumers still build
+	if [[ $BUILD -eq 1 ]]; then
+		if ! build_test_targets "$tools_path" "$HDR_CLASS"; then
+			err "Build failed after copying $kernel_path — reverting."
+			git -C "$KERNEL_DIR" checkout -- "$tools_path" || \
+				err "Failed to revert $tools_path"
+			BUILD_FAILED+=("$tools_path")
+			cleanup_tmpdir "$beauty_tmpdir"
+			return 1
+		fi
+		info "Build OK."
+	fi
+
+	if [[ $COMMIT -eq 0 ]]; then
+		SYNCED_OK+=("$tools_path")
+		cleanup_tmpdir "$beauty_tmpdir"
+		return
+	fi
+
+	# Compose commit message
+	local header_short
+	header_short=$(basename "$kernel_path")
+	local header_dir
+	header_dir=$(dirname "$kernel_path" | sed 's|^include/uapi/||;s|^include/||;s|^arch/||')
+
+	# Determine the commit subject per header type
+	local subject
+	case "$kernel_path" in
+	arch/x86/include/asm/cpufeatures.h)
+		subject="tools headers x86 cpufeatures: Sync with the kernel sources"
+		;;
+	arch/x86/include/asm/msr-index.h)
+		subject="tools arch x86: Sync the msr-index.h copy with the kernel sources"
+		;;
+	arch/x86/include/asm/irq_vectors.h)
+		subject="perf beauty: Update the arch/x86/include/asm/irq_vectors.h copy with the kernel sources"
+		;;
+	arch/x86/include/uapi/asm/prctl.h)
+		subject="perf beauty: Sync x86 uapi/asm/prctl.h with the kernel sources"
+		;;
+	include/uapi/drm/*|include/uapi/sound/*)
+		subject="tools headers: Sync UAPI ${header_dir}/${header_short} with kernel sources"
+		;;
+	include/uapi/linux/perf_event.h)
+		subject="tools headers UAPI: Sync linux/perf_event.h with the kernel sources"
+		;;
+	include/uapi/linux/*)
+		if [[ "$HDR_CLASS" == "beauty" ]]; then
+			subject="tools headers: Sync UAPI linux/${header_short} with the kernel sources"
+		else
+			subject="tools headers UAPI: Sync linux/${header_short} with the kernel sources"
+		fi
+		;;
+	include/uapi/asm-generic/*)
+		subject="tools headers UAPI: Sync asm-generic/${header_short} with the kernel sources"
+		;;
+	include/uapi/*)
+		local uapi_subdir
+		uapi_subdir=$(echo "$kernel_path" | sed 's|^include/uapi/||;s|/[^/]*$||')
+		if [[ "$HDR_CLASS" == "beauty" ]]; then
+			subject="tools headers: Sync UAPI ${uapi_subdir}/${header_short} with kernel sources"
+		else
+			subject="tools headers UAPI: Sync ${uapi_subdir}/${header_short} with the kernel sources"
+		fi
+		;;
+	include/linux/socket.h)
+		subject="perf beauty: Update copy of linux/socket.h with the kernel sources"
+		;;
+	include/linux/*)
+		subject="tools headers: Sync linux/${header_short} with the kernel sources"
+		;;
+	include/vdso/*)
+		subject="tools headers: Sync vdso/${header_short} with the kernel sources"
+		;;
+	include/asm-generic/*)
+		subject="tools headers: Sync asm-generic/${header_short} with the kernel sources"
+		;;
+	arch/*/include/uapi/asm/perf_regs.h)
+		local arch
+		arch=$(echo "$kernel_path" | cut -d/ -f2)
+		subject="tools headers UAPI: Sync ${arch}/asm/perf_regs.h with the kernel sources"
+		;;
+	arch/*/include/uapi/*)
+		subject="tools headers UAPI: Sync ${header_short} with the kernel sources"
+		;;
+	arch/*)
+		local arch
+		arch=$(echo "$kernel_path" | cut -d/ -f2)
+		subject="tools arch ${arch}: Sync the ${header_short} copy with the kernel sources"
+		;;
+	scripts/*|lib/*)
+		subject="tools headers: Sync ${header_short} with the kernel sources"
+		;;
+	*)
+		subject="tools headers: Sync ${header_short} with the kernel sources"
+		;;
+	esac
+
+	# Build commit body
+	local body=""
+
+	if [[ -n "$kernel_commits" ]]; then
+		body+="To pick up the changes in:"
+		body+=$'\n'
+		body+=$'\n'
+		body+="$kernel_commits"
+		body+=$'\n'
+	fi
+
+	if [[ $beauty_changed -eq 1 ]]; then
+		# Show the beauty diff in the commit message.
+		body+=$'\n'
+		body+="That introduce these new entries in the string tables:"
+		body+=$'\n'
+
+		local idx=0
+		for script in "${beauty_script_list[@]}"; do
+			local before_msg="$beauty_tmpdir/beauty.$idx.before"
+			local after_msg="$beauty_tmpdir/beauty.$idx.after"
+
+			if ! diff -q "$before_msg" "$after_msg" > /dev/null 2>&1; then
+				body+=$(beauty_body_fragment "$script" "$kernel_path" \
+					"$tools_path" "$before_msg" "$after_msg")
+				body+=$'\n'
+			fi
+			idx=$((idx + 1))
+		done
+	elif [[ ${#beauty_script_list[@]} -gt 0 ]]; then
+		body+=$'\n'
+		body+="That don't result in changes to the string tables generated"
+		body+=" from this header."
+	else
+		body+=$'\n'
+		body+="That just rebuilds perf, silencing this build warning."
+	fi
+
+	body+=$'\n'
+	body+=$'\n'
+	body+="This addresses this perf build warning:"
+	body+=$'\n'
+	body+=$'\n'
+	body+="  Warning: Kernel ABI header differences:"
+	body+=$'\n'
+	body+="    diff -u $tools_path $kernel_path"
+	body+=$'\n'
+	body+=$'\n'
+	body+="Please see tools/include/uapi/README for further details."
+
+	# Add Cc for kernel commit authors
+	local cc_lines=""
+	if [[ -n "$pickup_commits" ]]; then
+		cc_lines=$(format_commits 'Cc: %an <%ae>' "$pickup_commits" | sort -u)
+	fi
+
+	body+=$'\n'
+	body+=$'\n'
+	if [[ -n "$cc_lines" ]]; then
+		body+="$cc_lines"$'\n'
+	fi
+	body+="$(sign_off)"
+
+	cleanup_tmpdir "$beauty_tmpdir"
+
+	if ! git -C "$KERNEL_DIR" add "$tools_path"; then
+		err "Failed to stage $tools_path"
+		COMMIT_FAILED+=("$tools_path")
+		return 1
+	fi
+	if ! git -C "$KERNEL_DIR" commit "$tools_path" \
+		-m "$(printf '%s\n\n%s\n' "$subject" "$body")"; then
+		err "Commit failed for $tools_path"
+		COMMIT_FAILED+=("$tools_path")
+		return 1
+	fi
+
+	SYNCED_OK+=("$tools_path")
+	info "Committed: $subject"
+	echo ""
+}
+
+# --- Group related headers -----------------------------------------------
+#
+# Some headers should be committed together (e.g. all KVM arch headers,
+# all syscall tables). This function processes groups.
+
+process_group() {
+	local group_name="$1"
+	shift
+	local pairs=("$@")
+
+	if [[ ${#pairs[@]} -eq 0 ]]; then
+		return
+	fi
+
+	local file_count
+	file_count=$((${#pairs[@]} / 2))
+	info "Processing group: $group_name ($file_count files)"
+
+	local group_slug="${group_name// /-}"
+
+	local all_kernel_commits=""
+	local all_cc_lines=""
+	local all_warnings=""
+	local group_beauty_tmpdir=""
+	local group_beauty_body=""
+	local group_beauty_scripts=0
+	local files_to_add=()
+
+	# Collect info for all files in the group
+	local i=0
+	while [[ $i -lt ${#pairs[@]} ]]; do
+		local tools_path="${pairs[$i]}"
+		local kernel_path="${pairs[$((i+1))]}"
+		local fidx=$i
+		i=$((i + 2))
+
+		if [[ -n "$HEADER_FILTER" ]] && [[ "$kernel_path" != *"$HEADER_FILTER"* ]]; then
+			continue
+		fi
+
+		if kernel_matches_previous_tools_state "$kernel_path" "$tools_path"; then
+			warn "$tools_path matches a previous tools/ state, leaving it alone"
+			continue
+		fi
+
+		local sync_point pickup_commits=""
+		sync_point=$(find_sync_point "$kernel_path" "$tools_path")
+		if [[ -n "$sync_point" ]]; then
+			pickup_commits=$(find_kernel_commits "$kernel_path" \
+				"$tools_path" "$sync_point")
+		else
+			warn "No previous sync commit found for $tools_path"
+		fi
+		if [[ -n "$pickup_commits" ]]; then
+			all_kernel_commits+=$(format_commits '  %h ("%s")' "$pickup_commits")
+			all_kernel_commits+=$'\n'
+
+			local ccs
+			ccs=$(format_commits 'Cc: %an <%ae>' "$pickup_commits")
+			if [[ -n "$ccs" ]]; then
+				all_cc_lines+="$ccs"$'\n'
+			fi
+		fi
+
+		all_warnings+="    diff -u $tools_path $kernel_path"$'\n'
+
+		# Beauty string tables; the script reads the tools/ copy, so this
+		# runs before the copy too, also in a dry run.
+		local -a group_script_list=()
+		while IFS= read -r script; do
+			[[ -z "$script" ]] && continue
+			group_script_list+=("$script")
+		done < <(find_beauty_scripts "$kernel_path")
+		if [[ ${#group_script_list[@]} -gt 0 ]]; then
+			group_beauty_scripts=1
+			[[ -z "$group_beauty_tmpdir" ]] && group_beauty_tmpdir=$(mktemp -d)
+			local sidx=0
+			for script in "${group_script_list[@]}"; do
+				local script_name
+				script_name=$(basename "$script")
+				local before="$group_beauty_tmpdir/beauty.$fidx.$sidx.before"
+				local after="$group_beauty_tmpdir/beauty.$fidx.$sidx.after"
+
+				if ! run_beauty_pass "$script" "$kernel_path" "$tools_path" \
+					"$group_beauty_tmpdir" "$fidx.$sidx"; then
+					COPY_FAILED+=("$tools_path")
+					for f in "${files_to_add[@]}"; do
+						git -C "$KERNEL_DIR" checkout -- "$f" || \
+							err "Failed to revert $f"
+					done
+					cleanup_tmpdir "$group_beauty_tmpdir"
+					return 1
+				fi
+
+				if ! diff -q "$before" "$after" > /dev/null 2>&1; then
+					echo ""
+					info "Beauty string changes from $script_name:"
+					diff -u "$before" "$after" | head -60 || true
+					group_beauty_body+=$(beauty_body_fragment "$script" \
+						"$kernel_path" "$tools_path" "$before" "$after")
+					group_beauty_body+=$'\n'
+				fi
+				sidx=$((sidx + 1))
+			done
+		fi
+
+		if [[ $DRY_RUN -eq 0 ]]; then
+			if ! cp "$KERNEL_DIR/$kernel_path" "$KERNEL_DIR/$tools_path"; then
+				err "Failed to copy $kernel_path -> $tools_path"
+				COPY_FAILED+=("$tools_path")
+				for f in "${files_to_add[@]}"; do
+					git -C "$KERNEL_DIR" checkout -- "$f" || \
+						err "Failed to revert $f"
+				done
+				cleanup_tmpdir "$group_beauty_tmpdir"
+				return 1
+			fi
+			files_to_add+=("$tools_path")
+			info "Copied $kernel_path -> $tools_path"
+		else
+			info "(dry run) Would copy $kernel_path -> $tools_path"
+		fi
+	done
+
+	# The beauty before/after files are captured into the fragments above.
+	cleanup_tmpdir "$group_beauty_tmpdir"
+
+	if [[ ${#files_to_add[@]} -eq 0 ]]; then
+		return
+	fi
+
+	if [[ $BUILD -eq 1 ]]; then
+		# Collect all unique build targets for the group
+		local group_targets=""
+		for f in "${files_to_add[@]}"; do
+			classify_header "$f"
+			group_targets+=$(find_build_targets "$f" "$HDR_CLASS")
+			group_targets+=$'\n'
+		done
+		group_targets=$(echo "$group_targets" | sort -u | grep -v '^$')
+
+		show_build_targets "group $group_name" "$group_targets"
+		local build_failed=0
+		while IFS=: read -r name dir; do
+			[[ -z "$name" ]] && continue
+			detail "  Build-testing $name ($dir)..."
+			local log="$OUTPUT_DIR/$name.$group_slug.log"
+			if ! build_target "$name" "$dir" > "$log" 2>&1; then
+				err "  $name build failed, see $log"
+				build_failed=1
+			fi
+		done <<< "$group_targets"
+
+		if [[ $build_failed -eq 1 ]]; then
+			err "Build failed after copying group $group_name — reverting."
+			for f in "${files_to_add[@]}"; do
+				git -C "$KERNEL_DIR" checkout -- "$f" || \
+					err "Failed to revert $f"
+				BUILD_FAILED+=("$f (group: $group_name)")
+			done
+			return 1
+		fi
+		info "Build OK."
+	fi
+
+	if [[ $DRY_RUN -eq 1 ]]; then
+		return
+	fi
+
+	if [[ $COMMIT -eq 0 ]]; then
+		for f in "${files_to_add[@]}"; do
+			SYNCED_OK+=("$f")
+		done
+		return
+	fi
+
+	# Deduplicate kernel commits and Cc lines; the commits keep the git log
+	# order they came in, the Cc lines stay sorted.
+	all_kernel_commits=$(printf '%s\n' "$all_kernel_commits" | \
+		awk 'NF && !seen[$0]++')
+	all_cc_lines=$(echo "$all_cc_lines" | sort -u | grep -v '^$' || true)
+
+	local subject="tools headers: Sync $group_name with the kernel sources"
+	local body=""
+
+	if [[ -n "$all_kernel_commits" ]]; then
+		body+="To pick up the changes in:"
+		body+=$'\n'
+		body+=$'\n'
+		body+="$all_kernel_commits"
+		body+=$'\n'
+	fi
+
+	if [[ -n "$group_beauty_body" ]]; then
+		body+=$'\n'
+		body+="That introduce these new entries in the string tables:"
+		body+=$'\n'
+		body+="$group_beauty_body"
+	elif [[ $group_beauty_scripts -eq 1 ]]; then
+		body+=$'\n'
+		body+="That don't result in changes to the string tables generated"
+		body+=" from these headers."
+	fi
+
+	body+=$'\n'
+	body+=$'\n'
+	body+="This addresses these perf build warnings:"
+	body+=$'\n'
+	body+=$'\n'
+	body+="  Warning: Kernel ABI header differences:"
+	body+=$'\n'
+	body+="$all_warnings"
+	body+=$'\n'
+	body+="Please see tools/include/uapi/README for further details."
+	body+=$'\n'
+	body+=$'\n'
+	if [[ -n "$all_cc_lines" ]]; then
+		body+="$all_cc_lines"$'\n'
+	fi
+	body+="$(sign_off)"
+
+	for f in "${files_to_add[@]}"; do
+		if ! git -C "$KERNEL_DIR" add "$f"; then
+			err "Failed to stage $f"
+			for g in "${files_to_add[@]}"; do
+				COMMIT_FAILED+=("$g")
+			done
+			return 1
+		fi
+	done
+
+	if ! git -C "$KERNEL_DIR" commit "${files_to_add[@]}" \
+		-m "$(printf '%s\n\n%s\n' "$subject" "$body")"; then
+		err "Commit failed for group $group_name"
+		for f in "${files_to_add[@]}"; do
+			COMMIT_FAILED+=("$f")
+		done
+		return 1
+	fi
+
+	for f in "${files_to_add[@]}"; do
+		SYNCED_OK+=("$f")
+	done
+
+	info "Committed: $subject"
+	echo ""
+}
+
+# --- Main -----------------------------------------------------------------
+
+main() {
+	cd "$KERNEL_DIR"
+
+	if [[ ! -d include/uapi ]]; then
+		err "Must be run from a kernel tree root (or tools/perf/)"
+		exit 1
+	fi
+
+	if [[ ! -d tools/perf ]]; then
+		err "Cannot find tools/perf/ in kernel tree"
+		exit 1
+	fi
+
+	setup_beauty_args || true
+
+	if [[ $BUILD -eq 1 ]]; then
+		# umask covers every level created, -m with -p only the last.
+		(umask 077 && mkdir -p "$OUTPUT_DIR")
+	fi
+
+	# Check for uncommitted changes in tools/
+	if ! git diff --quiet -- tools/include/ tools/perf/trace/beauty/ tools/perf/util/ tools/perf/arch/*/entry/syscalls/ tools/scripts/ tools/lib/ tools/arch/; then
+		warn "You have uncommitted changes in tools/. Commit or stash them first."
+		if [[ $DRY_RUN -eq 0 ]]; then
+			exit 1
+		fi
+	fi
+
+	info "Running check-headers to detect stale copies..."
+	echo ""
+
+	local stale
+	if ! stale=$(detect_stale_headers); then
+		info "All headers are up to date."
+		exit 0
+	fi
+
+	echo "Stale headers found:"
+	echo "$stale"
+	echo ""
+
+	# Parse the stale header pairs and group them
+	# Each line is: tools_path kernel_path
+	local kvm_group=()
+	local syscall_group=()
+	local singles=()
+
+	while IFS=' ' read -r tools_path kernel_path; do
+		case "$kernel_path" in
+		*kvm.h|*svm.h|*vmx.h|*sie.h)
+			kvm_group+=("$tools_path" "$kernel_path")
+			;;
+		*syscall*.tbl|*unistd.h)
+			syscall_group+=("$tools_path" "$kernel_path")
+			;;
+		*)
+			singles+=("$tools_path" "$kernel_path")
+			;;
+		esac
+	done <<< "$stale"
+
+	# Process individual headers first (beauty and simple copies).
+	# || true: continue on failure; failures are tracked in BUILD_FAILED[],
+	# COPY_FAILED[] and COMMIT_FAILED[] and reported in the summary.
+	local i=0
+	while [[ $i -lt ${#singles[@]} ]]; do
+		process_header "${singles[$i]}" "${singles[$((i+1))]}" || true
+		i=$((i + 2))
+	done
+
+	# Process grouped headers
+	if [[ ${#kvm_group[@]} -gt 0 ]]; then
+		process_group "KVM headers" "${kvm_group[@]}" || true
+	fi
+
+	if [[ ${#syscall_group[@]} -gt 0 ]]; then
+		process_group "syscall tables and unistd.h" "${syscall_group[@]}" || true
+	fi
+
+	# Summary
+	echo ""
+	echo "========================================="
+	echo " Summary"
+	echo "========================================="
+
+	if [[ ${#SYNCED_OK[@]} -gt 0 ]]; then
+		info "Synced successfully (${#SYNCED_OK[@]}):"
+		for f in "${SYNCED_OK[@]}"; do
+			echo "    $f"
+		done
+	fi
+
+	if [[ ${#BUILD_FAILED[@]} -gt 0 ]]; then
+		echo ""
+		err "Build failures (${#BUILD_FAILED[@]}) — reverted, need manual attention:"
+		for f in "${BUILD_FAILED[@]}"; do
+			echo "    $f"
+		done
+	fi
+
+	if [[ ${#COPY_FAILED[@]} -gt 0 ]]; then
+		echo ""
+		err "Copy failures (${#COPY_FAILED[@]}) — need manual attention:"
+		for f in "${COPY_FAILED[@]}"; do
+			echo "    $f"
+		done
+	fi
+
+	if [[ ${#COMMIT_FAILED[@]} -gt 0 ]]; then
+		echo ""
+		err "Commit failures (${#COMMIT_FAILED[@]}) — need manual attention:"
+		for f in "${COMMIT_FAILED[@]}"; do
+			echo "    $f"
+		done
+	fi
+
+	# Final check-headers run to see what's still out of sync
+	echo ""
+	local remaining
+	if remaining=$(detect_stale_headers); then
+		warn "Headers still out of sync:"
+		echo "$remaining"
+	else
+		info "All headers are now in sync."
+	fi
+
+	if [[ ${#BUILD_FAILED[@]} -gt 0 || ${#COPY_FAILED[@]} -gt 0 || \
+		${#COMMIT_FAILED[@]} -gt 0 ]]; then
+		exit 1
+	fi
+}
+
+main "$@"
-- 
2.56.0

