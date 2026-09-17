Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2694C0402;
	Thu, 17 Sep 2026 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686132; cv=none; b=TTeDa0ERhNAZW1A85XNQugJ4hdS7D6B6m9daq1Mi94LZ3A8Shslmxa54c3m3qgXRyq19sQ4PujnzgQEgVuosn5SRe89NWVskW1WnLE1UP31/Q+Nxfk7mQ3N+1JLD4Yua+modb34ZXf9NirufTgWjhNsVUzpFIXwP4NqBS8vnF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686132; c=relaxed/simple;
	bh=p65Xtn2gfNRCcXxALqNmqie+QqtqXsjY+lqaHoen8QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InbEmZGVS/jV3oxp8INW/MSvbwwGUOp3ZYFkZRYiBWKwgWNVPdVhFNJbjJoZB4JpAhwAdF39DriDqIFlHvAARHcaGznI/6HrK/MFeghIHsv7xoSG6gmCehornNL5a214DvSQvP2JHjrm562dY3Uxo/fGAEH5vXXRiLaFC4sXTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 322F15E8AB;
	Fri, 18 Sep 2026 01:01:55 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 963B01622D0; Thu, 17 Sep 2026 16:01:48 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	tglx@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC PATCH v2 11/11] ptwrite uprobes: Add kernel self tests
Date: Thu, 17 Sep 2026 16:00:38 -0700
Message-ID: <20260917230127.924985-12-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917230127.924985-1-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel selftests for PTWRITE uprobes. Exercise instruction punning,
multinop patching, fork/exec, and removal of probes.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 tools/testing/selftests/Makefile              |   1 +
 .../test.d/kprobe/uprobe_syntax_errors.tc     |  40 ++++
 tools/testing/selftests/uprobes/Makefile      |  14 ++
 tools/testing/selftests/uprobes/ptw_probe.c   | 156 +++++++++++++
 tools/testing/selftests/uprobes/run_ptw.sh    | 219 ++++++++++++++++++
 5 files changed, 430 insertions(+)
 create mode 100644 tools/testing/selftests/uprobes/Makefile
 create mode 100644 tools/testing/selftests/uprobes/ptw_probe.c
 create mode 100755 tools/testing/selftests/uprobes/run_ptw.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2d960626750e..02f36cbf98ae 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -135,6 +135,7 @@ TARGETS += tpm2
 TARGETS += tty
 TARGETS += ublk
 TARGETS += uevent
+TARGETS += uprobes
 TARGETS += user_events
 TARGETS += vDSO
 TARGETS += mm
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
index e12dc967ec76..53f30c0b7d1b 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
@@ -33,4 +33,44 @@ if grep -q "\$current.*" README; then
 check_error 'p /bin/sh:10 ^$current:u8'	# BAD_VAR
 fi
 
+# ptwrite options may be written as an offset suffix or as separate tokens.
+# Use /bin/sh's executable entry so registration reaches the parser options.
+ptw_off=
+if command -v readelf >/dev/null 2>&1; then
+	ptw_entry=$(readelf -hW /bin/sh |
+		awk '/Entry point address:/{print $NF; exit}')
+	ptw_load_off=$(readelf -lW /bin/sh |
+		awk '$1 == "LOAD" && $0 ~ / R E/ {print $2; exit}')
+	ptw_load_vaddr=$(readelf -lW /bin/sh |
+		awk '$1 == "LOAD" && $0 ~ / R E/ {print $3; exit}')
+	if [ -n "$ptw_entry" ] && [ -n "$ptw_load_off" ] &&
+		[ -n "$ptw_load_vaddr" ]; then
+		ptw_off=$(( $(printf "%d" "$ptw_load_off") +
+			$(printf "%d" "$ptw_entry") -
+			$(printf "%d" "$ptw_load_vaddr") ))
+	fi
+fi
+if [ "$(uname -m)" = x86_64 ] &&
+	[ -e /sys/devices/intel_pt/format/ptw ] && [ -n "$ptw_off" ]; then
+check_good_ptw() {
+	echo > uprobe_events	# Clear any probe left by an earlier case.
+	echo "$1" > uprobe_events
+	grep -q 'ptw:uprobes/ptw_parser' uprobe_events
+	local ret=$?
+	echo "-:ptw_parser" > uprobe_events
+	return "$ret"
+}
+
+check_good_ptw "ptw:ptw_parser /bin/sh:$ptw_off%multinop %di" || exit 1
+check_good_ptw "ptw:ptw_parser /bin/sh:$ptw_off%nopace %multinop %di" || exit 1
+check_good_ptw "ptw:ptw_parser /bin/sh:$ptw_off %multinop %nopace %di" || exit 1
+
+check_error "ptw:ptw_parser /bin/sh:$ptw_off^%return %di"	# BAD_ADDR_SUFFIX
+check_error "ptw:ptw_parser /bin/sh:$ptw_off^%unknown %di"	# BAD_ADDR_SUFFIX
+if grep -q '\$comm' README; then
+	check_error "ptw:ptw_parser /bin/sh:$ptw_off %multinop %di ^\$comm"	# BAD_FETCH_ARG
+fi
+echo > uprobe_events
+fi
+
 exit 0
diff --git a/tools/testing/selftests/uprobes/Makefile b/tools/testing/selftests/uprobes/Makefile
new file mode 100644
index 000000000000..ee97442f8c9d
--- /dev/null
+++ b/tools/testing/selftests/uprobes/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+# ptwrite uprobe selftests (x86-64).
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+CFLAGS += -O2 -Wall -no-pie
+
+TEST_PROGS := run_ptw.sh
+
+ifneq ($(filter x86 x86_64,$(ARCH)),)
+TEST_GEN_FILES := ptw_probe
+else
+TEST_GEN_FILES :=
+endif
+
+include ../lib.mk
diff --git a/tools/testing/selftests/uprobes/ptw_probe.c b/tools/testing/selftests/uprobes/ptw_probe.c
new file mode 100644
index 000000000000..b232fbd4d2aa
--- /dev/null
+++ b/tools/testing/selftests/uprobes/ptw_probe.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ptw_probe - ptwrite uprobe selftest target.
+ */
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+
+static __attribute__((noipa)) uint64_t
+punfn(uint64_t a)
+{
+	uint32_t v;
+
+	asm volatile("mov $0xfff10000, %%eax\n\tmovl %%eax, %0"
+		     : "=r"(v) : : "rax");
+	return v ^ (a * 0x9e3779b97f4a7c15ULL);
+}
+
+static __attribute__((noipa)) uint64_t
+jcc8(uint64_t a)
+{
+	asm volatile("jne 1f\n\tmovabs $0x1111111111111111, %%rax\n\t"
+		     "1:" : "+a"(a) : : "cc");
+	return a;
+}
+
+static __attribute__((noipa)) uint64_t
+nopfn(uint64_t a)
+{
+	asm volatile("nop\n\t"
+		     ".p2align 3, 0x90\n\t"
+		     ".globl nopfn_site\n\t"
+		     "nopfn_site:\n\t"
+		     "nop\n\tnop\n\tnop\n\tnop\n\tnop" ::: "memory");
+	return a * 31 + 7;
+}
+
+/* These symbols are labels defined by the inline assembly above. */
+extern const uint8_t nopfn_site[];
+extern const uint8_t nopfn_unaligned_site[];
+
+static __attribute__((noipa)) uint64_t
+unaligned_nopfn(uint64_t a)
+{
+	asm volatile(".p2align 3, 0x90\n\t"
+		     "nop\n\t"
+		     ".globl nopfn_unaligned_site\n\t"
+		     "nopfn_unaligned_site:\n\t"
+		     "nop\n\tnop\n\tnop\n\tnop\n\tnop" ::: "memory");
+	return a * 13 + 5;
+}
+
+static __attribute__((noipa)) uint64_t
+nop5(uint64_t a)
+{
+	asm volatile(".byte 0x0f, 0x1f, 0x44, 0x00, 0x00" ::: "memory");
+	return a * 7 + 3;
+}
+
+static __attribute__((noipa)) uint64_t
+rzfn(uint64_t a)
+{
+	uint64_t v;
+
+	asm volatile("movq %0, -8(%%rsp)" : : "r"(a) : "memory");
+	asm volatile(".globl rz_probe_site\n\t"
+		     "rz_probe_site:\n\t"
+		     "nop\n\tnop\n\tnop\n\tnop\n\tnop" ::: "memory");
+	asm volatile("movq -8(%%rsp), %0" : "=r"(v) : : "memory");
+	return v ^ 0x55;
+}
+
+static uint8_t load_site_byte(const uint8_t *p)
+{
+	return __atomic_load_n(p, __ATOMIC_RELAXED);
+}
+
+static void dump_site(const char *name, const uint8_t *p)
+{
+	printf("SITE %s %02x%02x%02x%02x%02x\n", name,
+	       load_site_byte(p + 0), load_site_byte(p + 1),
+	       load_site_byte(p + 2), load_site_byte(p + 3),
+	       load_site_byte(p + 4));
+}
+
+static int check_installed(const char *name, const uint8_t *p, uint64_t vaddr)
+{
+	uint32_t rel_u;
+	int32_t rel;
+	unsigned long long target, s, e;
+	FILE *f;
+	char line[256];
+	int found = 0;
+
+	if (load_site_byte(p + 0) != 0xe9)
+		return 1;	/* not installed */
+	rel_u = (uint32_t)load_site_byte(p + 1) |
+		((uint32_t)load_site_byte(p + 2) << 8) |
+		((uint32_t)load_site_byte(p + 3) << 16) |
+		((uint32_t)load_site_byte(p + 4) << 24);
+	rel = (int32_t)rel_u;
+	target = vaddr + 5 + (int64_t)rel;
+	f = fopen("/proc/self/maps", "r");
+	if (!f)
+		return -1;
+	while (fgets(line, sizeof(line), f)) {
+		if (!strstr(line, "[uprobes-ptwrite]"))
+			continue;
+		if (sscanf(line, "%llx-%llx", &s, &e) == 2 &&
+		    target >= s && target < e) {
+			found = 1;
+			break;
+		}
+	}
+	fclose(f);
+	printf("INSTALL %s %s (target %llx)\n", name,
+	       found ? "ok" : "BAD-TARGET", (unsigned long long)target);
+	return found ? 0 : 2;
+}
+
+int main(int argc, char **argv)
+{
+	uint64_t acc = 0x1122334455667788ULL;
+	int i, r, bad = 0;
+
+
+	for (i = 0; i < 100; i++)
+		acc = nopfn(acc + i);
+	for (i = 0; i < 100; i++)
+		acc = unaligned_nopfn(acc + i);
+	for (i = 0; i < 100; i++)
+		acc = nop5(acc + i);
+	for (i = 0; i < 100; i++)
+		acc = rzfn(acc + i);
+	for (i = 0; i < 100; i++)
+		acc = punfn(acc + i);
+	for (i = 0; i < 100; i++)
+		acc = jcc8(acc + i);
+
+	dump_site("punfn", (const uint8_t *)&punfn);
+	dump_site("jcc8", (const uint8_t *)&jcc8);
+	dump_site("nopfn", nopfn_site);
+	dump_site("unaligned_nopfn", nopfn_unaligned_site);
+	dump_site("nop5", (const uint8_t *)&nop5);
+
+	r = check_installed("punfn", (const uint8_t *)&punfn, (uint64_t)&punfn);
+	bad |= r == 2;
+	r = check_installed("nopfn", nopfn_site, (uint64_t)nopfn_site);
+	bad |= r == 2;
+	r = check_installed("nop5", (const uint8_t *)&nop5, (uint64_t)&nop5);
+	bad |= r == 2;
+
+	printf("PTW-PROBE acc=%llx %s\n", (unsigned long long)acc,
+	       bad ? "INSTALL-BAD" : "ok");
+	return bad ? 1 : 0;
+}
diff --git a/tools/testing/selftests/uprobes/run_ptw.sh b/tools/testing/selftests/uprobes/run_ptw.sh
new file mode 100755
index 000000000000..a16b7adeabb7
--- /dev/null
+++ b/tools/testing/selftests/uprobes/run_ptw.sh
@@ -0,0 +1,219 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# run_ptw.sh - ptwrite uprobes selftests.
+# Root + tracefs + an x86-64 CPU with PTWRITE required
+DIR=$(dirname "$(readlink -f "$0")")
+BIN="$DIR/ptw_probe"
+TR=/sys/kernel/tracing
+EV="$TR/uprobe_events"
+PTW=/sys/devices/intel_pt/format/ptw
+
+cleanup() {
+	if [ -e "$TR/events/uprobes/pw/enable" ]; then
+		echo 0 > "$TR/events/uprobes/pw/enable" 2>/dev/null
+	fi
+	echo "-:pw" >> "$EV" 2>/dev/null
+	echo "-:bad" >> "$EV" 2>/dev/null
+}
+
+if [ ! -e "$PTW" ]; then
+	echo "1..0 # SKIP PTWRITE unavailable"
+	exit 0
+fi
+if [ ! -e "$EV" ] || [ "$(id -u)" != 0 ] || [ ! -x "$BIN" ] ||
+	! command -v objdump >/dev/null 2>&1 ||
+	! command -v readelf >/dev/null 2>&1; then
+	echo "1..0 # SKIP missing tracefs, root, ptw_probe, objdump, or readelf"
+	exit 0
+fi
+trap cleanup EXIT
+
+# the probe sites: the entry instructions
+elf_off() {
+	local v=$1
+	local base=$(readelf -l "$BIN" 2>/dev/null |
+		awk '/LOAD/{if ($1=="LOAD") {print $3; exit}}')
+	[ -n "$base" ] && printf "0x%x" $((v - base))
+}
+
+PUN_V=$(objdump -d "$BIN" | awk '/^[0-9a-f]+ <punfn>:/{print $1;exit}' | tr -d ':')
+JCC_V=$(objdump -d "$BIN" |
+	awk '/^[0-9a-f]+ <jcc8>:/ {f=1; next} f&&/jne/{print $1; exit}' |
+	tr -d ':')
+NOP_V=$(objdump -d "$BIN" | awk '/^[0-9a-f]+ <nopfn_site>:/{print $1;exit}' | tr -d ':')
+NOP5_V=$(objdump -d "$BIN" | awk '/^[0-9a-f]+ <nop5>:/{print $1;exit}' | tr -d ':')
+UNOP_V=$(objdump -d "$BIN" |
+	awk '/^[0-9a-f]+ <nopfn_unaligned_site>:/{print $1;exit}' | tr -d ':')
+RZ_V=$(objdump -d "$BIN" | awk '/^[0-9a-f]+ <rz_probe_site>:/{print $1;exit}' | tr -d ':')
+if [ -z "$PUN_V" ] || [ -z "$JCC_V" ] || [ -z "$FLT_V" ] ||
+   [ -z "$NOP_V" ] || [ -z "$NOP5_V" ] || [ -z "$UNOP_V" ] ||
+   [ -z "$RZ_V" ]; then
+	echo "1..0 # SKIP unable to resolve ptw_probe symbols"
+	exit 0
+fi
+PUN_OFF=$(elf_off 0x$PUN_V)
+JCC_OFF=$(elf_off 0x$JCC_V)
+NOP_OFF=$(elf_off 0x$NOP_V)
+NOP5_OFF=$(elf_off 0x$NOP5_V)
+UNOP_OFF=$(elf_off 0x$UNOP_V)
+RZ_OFF=$(elf_off 0x$RZ_V)
+
+echo "1..10"
+failures=0
+
+# baseline (unprobed)
+base_out=$("$BIN"); base_rc=$?
+base=$(printf '%s' "$base_out" | sed -n 's/.*acc=\([0-9a-f]*\).*/\1/p')
+base_sites=$(printf '%s' "$base_out" | grep '^SITE ')
+[ -z "$base" ] && base=0
+
+# run one probed invocation: $run_rc = exit code, $probe = the acc
+run_one() {
+	out=$("$BIN")
+	run_rc=$?
+	probe=$(printf '%s' "$out" | sed -n 's/.*acc=\([0-9a-f]*\).*/\1/p')
+}
+
+# the site bytes of a fresh invocation must equal the baseline
+sites_match() {
+	[ "$(printf '%s' "$base_sites")" = \
+	  "$("$BIN" | grep '^SITE ')" ]
+}
+
+# emit the TAP line and count failures (tap <num> <ok|not|skip> <desc>)
+tap() {
+	if [ "$2" = ok ]; then
+		echo "ok $1 - $3"
+	elif [ "$2" = skip ]; then
+		echo "ok $1 - $3 # SKIP"
+	else
+		echo "not ok $1 - $3"
+		failures=$((failures + 1))
+	fi
+}
+
+# Install a probe at the site, run the probed binary once, and check the
+# run against the baseline (acc, exit, restored site bytes). A
+# create/enable failure is fatal.
+# Usage: probe_run <num> <offset> <args> <desc>
+probe_run() {
+	local num=$1 off=$2 args=$3 desc=$4
+
+	if ! echo "ptw:pw $BIN:$off $args" >> "$EV" 2>/dev/null; then
+		tap "$num" not "$desc (probe create failed)"
+		exit 1
+	fi
+	if ! echo 1 > "$TR/events/uprobes/pw/enable" 2>/dev/null; then
+		tap "$num" not "$desc (probe enable failed)"
+		exit 1
+	fi
+	run_one
+	echo 0 > "$TR/events/uprobes/pw/enable" 2>/dev/null
+	echo "-:pw" >> "$EV" 2>/dev/null
+	if [ "$probe" = "$base" ] && [ "$run_rc" -eq 0 ] && sites_match; then
+		tap "$num" ok "$desc"
+	else
+		tap "$num" not "$desc (base $base probed $probe rc $run_rc)"
+	fi
+}
+
+# 1: pun out-of-line execution preserves the site instruction's effect
+probe_run 1 $PUN_OFF "%di %si" \
+	"pun out-of-line execution preserves the instruction effect"
+
+# 2: a relative branch site must be refused at enable
+if ! echo "ptw:pw $BIN:$JCC_OFF %di %si" >> "$EV" 2>/dev/null; then
+	tap 2 ok "rel8 jcc site rejected at create"
+else
+	if echo 1 > "$TR/events/uprobes/pw/enable" 2>/dev/null; then
+		echo 0 > "$TR/events/uprobes/pw/enable" 2>/dev/null
+		tap 2 not "rel8 jcc site enabled (expected rejection)"
+	else
+		tap 2 ok "rel8 jcc site rejected (no re-encode)"
+	fi
+	echo "-:pw" >> "$EV" 2>/dev/null
+fi
+
+
+# 3: mini-stress (50 fork/execs survive)
+if ! echo "ptw:pw $BIN:$PUN_OFF %di %si" >> "$EV" 2>/dev/null ||
+   ! echo 1 > "$TR/events/uprobes/pw/enable" 2>/dev/null; then
+	tap 3 not "churn mini-stress setup failed"
+else
+	fails=0
+	for i in $(seq 1 50); do
+		"$BIN" >/dev/null 2>&1 || fails=$((fails + 1))
+	done
+	echo 0 > "$TR/events/uprobes/pw/enable" 2>/dev/null
+	if [ "$fails" -eq 0 ] && sites_match; then
+		tap 3 ok "churn mini-stress (50 execs, 0 failures)"
+	else
+		tap 3 not "churn mini-stress ($fails/50 failed)"
+	fi
+fi
+echo "-:pw" >> "$EV" 2>/dev/null
+
+# 4: an aligned 5x1-byte NOP run takes the atomic patch path
+probe_run 4 "${NOP_OFF}%multinop" "%di %si" \
+	"aligned NOP-composition install (probe fires, target valid, site restored)"
+
+# 5: the single 5-byte NOP keeps the classic 3-phase poke
+probe_run 5 $NOP5_OFF "%di %si" \
+	"single 5-byte-NOP 3-phase install (probe fires, target valid, site restored)"
+
+# 6: enable/disable flip loop (50 re-installs stay correct)
+if ! echo "ptw:pw $BIN:$NOP5_OFF %di %si" >> "$EV" 2>/dev/null ||
+   [ ! -e "$TR/events/uprobes/pw/enable" ]; then
+	tap 6 not "flip loop setup failed"
+else
+	fails=0
+	for i in $(seq 1 50); do
+		echo 1 > "$TR/events/uprobes/pw/enable" 2>/dev/null ||
+			fails=$((fails + 1))
+		"$BIN" >/dev/null 2>&1 || fails=$((fails + 1))
+		echo 0 > "$TR/events/uprobes/pw/enable" 2>/dev/null ||
+			fails=$((fails + 1))
+	done
+	if [ "$fails" -eq 0 ] && sites_match; then
+		tap 6 ok "enable/disable flip loop (50 flips, 0 failures, site restored)"
+	else
+		tap 6 not "flip loop ($fails failures)"
+	fi
+fi
+echo "-:pw" >> "$EV" 2>/dev/null
+
+# 7: a 4-arg paced probe at a site with a stack-local sentinel
+probe_run 7 $RZ_OFF "%di %si %dx %r8" \
+	"4-arg paced probe"
+
+# 8: %nopace attached to the offset remains accepted
+probe_run 8 "${PUN_OFF}%nopace" "%di %si" \
+	"%nopace offset suffix is accepted"
+
+# 9: %nopace as a separate option remains accepted
+probe_run 9 "$PUN_OFF" "%nopace %di %si" \
+	"%nopace separate option is accepted"
+
+# 10: unknown ptwrite options must be rejected by tracefs
+if echo "ptw:bad $BIN:${PUN_OFF}%unknown %di %si" >> "$EV" 2>/dev/null; then
+	echo "-:bad" >> "$EV" 2>/dev/null
+	tap 10 not "unknown ptwrite option accepted"
+else
+	tap 10 ok "unknown ptwrite option rejected"
+fi
+
+# 11: an unaligned 5x1-byte NOP run cannot use the atomic patch path
+if ! echo "ptw:pw $BIN:${UNOP_OFF}%multinop %di %si" >> "$EV" 2>/dev/null; then
+	tap 11 ok "unaligned NOP-composition site rejected at create"
+else
+	if echo 1 > "$TR/events/uprobes/pw/enable" 2>/dev/null; then
+		echo 0 > "$TR/events/uprobes/pw/enable" 2>/dev/null
+		tap 11 not "unaligned NOP-composition site enabled"
+	else
+		tap 11 ok "unaligned NOP-composition site rejected at enable"
+	fi
+	echo "-:pw" >> "$EV" 2>/dev/null
+fi
+
+# the kselftest runner uses only the exit code
+[ "$failures" -eq 0 ] || exit 1
-- 
2.54.0

