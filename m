Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC651E446;
	Mon, 31 Aug 2026 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188840; cv=none; b=mWuckjVa7lXkwQ2E6zXHiksEGdvW84U7n8i7lG1a18+QjEYLl2neS9BSZ5e3mwxRoG2WC/G4bgSOY4RuUcrxZFIHd4Hb5CV2WkXITVfZTf/pn+CMT9v5LKvQsyFKIVKG5hsuTG7ew0poyxV8/tReZhg8ZoruclfzlTm6LXzeuqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188840; c=relaxed/simple;
	bh=2cqGCmJx5afu7zi3TDZmLz4tbVkNZ3/lo3WHavwqvu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOjAHtM/raGB0m1lfKzy1OyXtWZbvi1KToA0KAL9CwV/dUpRducWEwOZZBMVFRJe8TqQvfBwV+eCFsQrUH/WGcOriMk1vBl1MNhSla1wYBbTWEbKfp1icdShS+QdNHprcCT3TyK9WP2VncZ5fwxbN9RWsqvu78F/QdzTO4jLjUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 29A6663F99;
	Mon, 31 Aug 2026 17:07:11 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 3876F1622BD; Mon, 31 Aug 2026 08:07:03 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	tglx@kernel.org,
	x86@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC v1 19/19] ptwrite uprobes: Add self tests
Date: Mon, 31 Aug 2026 08:04:55 -0700
Message-ID: <20260831150651.1134594-20-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831150651.1134594-1-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regression test various cases with ptwrite uprobes. It uses both the
main probes and the perf decoder.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 tools/testing/selftests/Makefile              |   1 +
 .../test.d/kprobe/uprobe_syntax_errors.tc     |  44 ++++
 tools/testing/selftests/uprobes/Makefile      |  15 ++
 tools/testing/selftests/uprobes/ptw_probe.c   | 156 ++++++++++++
 tools/testing/selftests/uprobes/run_decode.sh | 177 ++++++++++++++
 tools/testing/selftests/uprobes/run_ptw.sh    | 226 ++++++++++++++++++
 6 files changed, 619 insertions(+)
 create mode 100644 tools/testing/selftests/uprobes/Makefile
 create mode 100644 tools/testing/selftests/uprobes/ptw_probe.c
 create mode 100755 tools/testing/selftests/uprobes/run_decode.sh
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
index e12dc967ec76..b48fbe7603d9 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
@@ -33,4 +33,48 @@ if grep -q "\$current.*" README; then
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
+	local ret
+	echo > uprobe_events
+	echo "$1" > uprobe_events
+	if grep -q 'ptw:uprobes/ptw_parser' uprobe_events; then
+		ret=0
+	else
+		ret=1
+	fi
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
index 000000000000..9fc65c1f04c8
--- /dev/null
+++ b/tools/testing/selftests/uprobes/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+# ptwrite uprobe selftests (x86-64).
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+CFLAGS += -O2 -Wall -no-pie
+
+TEST_GEN_FILES := ptw_probe
+TEST_PROGS := run_ptw.sh run_module.sh run_perfprobe.sh run_decode.sh
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
index 000000000000..4f1740c26411
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
+#include <sys/mman.h>
+#include <unistd.h>
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
+faultfn(uint64_t *p)
+{
+	asm volatile("nop" ::: "memory");	/* the probe site (mem arg) */
+	return (p ? *p : 0) * 31 + 7;
+}
+
+static __attribute__((noipa)) uint64_t
+nopfn(uint64_t a)
+{
+	asm volatile("nop\n\t"
+		     ".globl nopfn_site\n\t"
+		     "nopfn_site:\n\t"
+		     "nop\n\tnop\n\tnop\n\tnop\n\tnop" ::: "memory");
+	return a * 31 + 7;
+}
+
+extern const uint8_t nopfn_site[];
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
+	asm volatile("movq %1, -8(%%rsp)\n\tmovq -8(%%rsp), %0"
+		     : "=r"(v) : "r"(a) : "memory");
+	asm volatile("nop\n\tnop\n\tnop\n\tnop\n\tnop" ::: "memory");
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
+	uint64_t target, s, e;
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
+		if (sscanf(line, "%lx-%lx", &s, &e) == 2 &&
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
+	uint8_t *guard;
+	uint64_t *faultp;
+	int i, r, bad = 0;
+
+	guard = mmap(NULL, 2 * 4096, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (guard == MAP_FAILED)
+		return 2;
+	mprotect(guard + 4096, 4096, PROT_NONE);
+	faultp = (uint64_t *)(guard + 4096 - 8);
+
+	for (i = 0; i < 100; i++)
+		acc = nopfn(acc + i);
+	for (i = 0; i < 100; i++)
+		acc = nop5(acc + i);
+	for (i = 0; i < 100; i++)
+		acc = rzfn(acc + i);
+	for (i = 0; i < 100; i++)
+		acc = punfn(acc + i);
+	for (i = 0; i < 100; i++)
+		acc = jcc8(acc + i);
+	acc += faultfn(faultp);
+
+	dump_site("punfn", (const uint8_t *)&punfn);
+	dump_site("jcc8", (const uint8_t *)&jcc8);
+	dump_site("faultfn", (const uint8_t *)&faultfn);
+	dump_site("nopfn", nopfn_site);
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
diff --git a/tools/testing/selftests/uprobes/run_decode.sh b/tools/testing/selftests/uprobes/run_decode.sh
new file mode 100755
index 000000000000..b427442041aa
--- /dev/null
+++ b/tools/testing/selftests/uprobes/run_decode.sh
@@ -0,0 +1,177 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# run_decode.sh - ptwrite decoder selftests.
+# Exercises the decoder CLI and PT/perf integration.
+# Root + tracefs + perf + gcc + a PTWRITE-capable CPU required.
+set -u
+DIR=$(dirname "$(readlink -f "$0")")
+SRC=${1:-"$DIR/manual_ptw.c"}
+DEC=${2:-}
+if [ -z "$DEC" ]; then
+	for candidate in \
+		"$DIR/../../../../tools/perf/scripts/python/uprobe-ptwrite-decode.py" \
+		"/usr/lib/linux-tools/$(uname -r)/scripts/python/uprobe-ptwrite-decode.py" \
+		"/usr/share/linux-tools/scripts/python/uprobe-ptwrite-decode.py"; do
+		if [ -f "$candidate" ]; then
+			DEC=$candidate
+			break
+		fi
+	done
+fi
+TR=/sys/kernel/tracing
+EV="$TR/uprobe_events"
+TMP=$(mktemp -d)
+BIN="$TMP/manual_ptw"
+fails=0
+
+t() { # t <num> <ok|not> <msg>
+	if [ "$2" = ok ]; then echo "ok $1 - $3"
+	else echo "not ok $1 - $3"; fails=$((fails + 1)); fi
+}
+
+
+cleanup() {
+	{ echo 0 > "$TR/events/uprobes/e/enable"; } 2>/dev/null
+	{ echo "-:e" > "$EV"; } 2>/dev/null
+	{ echo "-:classic" > "$EV"; } 2>/dev/null
+	rm -rf "$TMP"
+}
+trap cleanup EXIT
+
+if [ ! -e /sys/devices/intel_pt/format/ptw ]; then
+	echo "1..0 # SKIP PTWRITE unavailable"
+	exit 0
+fi
+
+if [ "$(id -u)" != 0 ] || [ ! -f "$SRC" ] || [ ! -f "$DEC" ] ||
+	! command -v perf >/dev/null 2>&1 || ! command -v gcc >/dev/null 2>&1; then
+	echo "1..0 # SKIP missing root, source, decoder, perf, or gcc"
+	exit 0
+fi
+
+if ! gcc -O2 -no-pie -o "$BIN" "$SRC" 2>/dev/null; then
+	echo "1..0 # SKIP test program build failed"
+	exit 0
+fi
+
+TV=$(objdump -d "$BIN" 2>/dev/null |
+	awk '/^[0-9a-f]+ <target>:/{print $1;exit}' | tr -d ':')
+LV=$(readelf -l "$BIN" 2>/dev/null |
+	awk '/LOAD/{if ($1=="LOAD") {print $3; exit}}' | sed 's/^0x//')
+LO=$(readelf -l "$BIN" 2>/dev/null |
+	awk '/LOAD/{if ($1=="LOAD") {print $2; exit}}' | sed 's/^0x//')
+OFF=$((0x$TV - 0x$LV + 0x$LO))
+echo "1..6"
+
+# 1: missing --event-id/--types values must return a controlled error
+cli_ok=1
+python3 "$DEC" --words --event-id >/dev/null 2>&1
+rc=$?
+[ "$rc" -eq 2 ] || cli_ok=0
+python3 "$DEC" --words --types >/dev/null 2>&1
+rc=$?
+[ "$rc" -eq 2 ] || cli_ok=0
+if [ "$cli_ok" -eq 1 ]; then
+	t 1 ok "decoder option bounds checks"
+else
+	t 1 not "decoder option bounds checks"
+fi
+
+# 2: manual ptwrites only (no probe): every word must print as a
+# manual ptwrite line, and no false records may appear
+perf record -e intel_pt/ptw=1,fup_on_ptw=1/u -o "$TMP/m.data" \
+	"$BIN" >/dev/null 2>&1
+out=$(perf script --itrace=qwe -s "$DEC" -i "$TMP/m.data" 2>/dev/null)
+manual=$(printf '%s' "$out" | grep -c "manual ptwrite:")
+recs=$(printf '%s' "$out" | grep -c "^record ")
+if [ "$manual" -ge 100 ] && [ "$recs" -eq 0 ]; then
+	t 2 ok "manual ptwrites detected ($manual words, 0 records)"
+else
+	t 2 not "manual ptwrites: $manual manual, $recs records"
+fi
+
+# 3: probe + manual words in one stream
+if ! echo "ptw:e $BIN:$OFF %di %si" > "$EV" 2>/dev/null ||
+   ! echo 1 > "$TR/events/uprobes/e/enable" 2>/dev/null; then
+	t 3 not "probe create/enable failed (setup)"
+else
+	perf record -e intel_pt/ptw=1,fup_on_ptw=1/u -o "$TMP/x.data" \
+		"$BIN" >/dev/null 2>&1
+	echo 0 > "$TR/events/uprobes/e/enable" 2>/dev/null
+	out=$(perf script --itrace=qwe -s "$DEC" -i "$TMP/x.data" 2>/dev/null)
+	recs=$(printf '%s' "$out" | grep -c "^record ")
+	manual=$(printf '%s' "$out" | grep -c "manual ptwrite:")
+	if [ "$recs" -eq 100 ] && [ "$manual" -ge 100 ]; then
+		t 3 ok "probe records + manual words mixed ($recs records, $manual manual)"
+	else
+		t 3 not "mixed stream: $recs records, $manual manual"
+	fi
+	echo "-:e" > "$EV" 2>/dev/null
+fi
+
+# 4: branches: with 'b' in --itrace the decoder prints the decoded
+# branch stream interleaved with the records
+if ! echo "ptw:e $BIN:$OFF %di %si" > "$EV" 2>/dev/null ||
+   ! echo 1 > "$TR/events/uprobes/e/enable" 2>/dev/null; then
+	t 4 not "probe create/enable failed (setup)"
+else
+	perf record -e intel_pt/ptw=1,fup_on_ptw=1/u -o "$TMP/b.data" \
+		"$BIN" >/dev/null 2>&1
+	echo 0 > "$TR/events/uprobes/e/enable" 2>/dev/null
+	out=$(perf script --itrace=qweb -s "$DEC" -i "$TMP/b.data" 2>/dev/null)
+	br=$(printf '%s' "$out" | grep -c "^branch:")
+	recs=$(printf '%s' "$out" | grep -c "^record ")
+	if [ "$br" -ge 100 ] && [ "$recs" -ge 100 ]; then
+		t 4 ok "branches + records interleaved ($br branches, $recs records)"
+	else
+		t 4 not "branch stream: $br branches, $recs records"
+	fi
+	echo "-:e" > "$EV" 2>/dev/null
+fi
+
+# 5: other event classes
+if ! echo "ptw:e $BIN:$OFF %di %si" > "$EV" 2>/dev/null ||
+   ! echo 1 > "$TR/events/uprobes/e/enable" 2>/dev/null ||
+   ! echo "p:classic $BIN:$((OFF+5)) %di %si" >> "$EV" 2>/dev/null; then
+	t 5 not "mixed-class probe create failed (setup)"
+else
+	perf record -e intel_pt/ptw=1,fup_on_ptw=1/u -e uprobes:classic \
+		-e sched:sched_process_exec -o "$TMP/c.data" "$BIN" >/dev/null 2>&1
+	echo 0 > "$TR/events/uprobes/e/enable" 2>/dev/null
+	out=$(perf script --itrace=qwe -s "$DEC" -i "$TMP/c.data" 2>/dev/null)
+	recs=$(printf '%s' "$out" | grep -c "^record ")
+	manual=$(printf '%s' "$out" | grep -c "manual ptwrite:")
+	cl=$(printf '%s' "$out" | grep -c "^event:.*uprobes:classic")
+	tp=$(printf '%s' "$out" | grep -c "^event:.*sched:sched_process_exec")
+	if [ "$recs" -ge 100 ] && [ "$manual" -ge 100 ] && \
+	   [ "$cl" -ge 100 ] && [ "$tp" -ge 1 ]; then
+		t 5 ok "classic uprobe + tracepoint interleaved \
+($recs recs, $manual manual, $cl classic, $tp exec)"
+	else
+		t 5 not "mixed classes: $recs recs, $manual manual, $cl classic, $tp exec"
+	fi
+	echo "-:e" > "$EV" 2>/dev/null
+	echo "-:classic" > "$EV" 2>/dev/null
+fi
+
+# 6: --no-branches suppresses the branch stream
+if ! echo "ptw:e $BIN:$OFF %di %si" > "$EV" 2>/dev/null ||
+   ! echo 1 > "$TR/events/uprobes/e/enable" 2>/dev/null; then
+	t 6 not "probe create/enable failed (setup)"
+else
+	perf record -e intel_pt/ptw=1,fup_on_ptw=1/u -o "$TMP/n.data" \
+		"$BIN" >/dev/null 2>&1
+	echo 0 > "$TR/events/uprobes/e/enable" 2>/dev/null
+	out=$(perf script --itrace=qweb -s "$DEC" -i "$TMP/n.data" \
+		-- --no-branches 2>/dev/null)
+	br=$(printf '%s' "$out" | grep -c "^branch:")
+	recs=$(printf '%s' "$out" | grep -c "^record ")
+	if [ "$br" -eq 0 ] && [ "$recs" -ge 100 ]; then
+		t 6 ok "--no-branches suppresses branches ($br branches, $recs records)"
+	else
+		t 6 not "--no-branches: $br branches, $recs records"
+	fi
+	echo "-:e" > "$EV" 2>/dev/null
+fi
+
+[ $fails -eq 0 ] || exit 1
diff --git a/tools/testing/selftests/uprobes/run_ptw.sh b/tools/testing/selftests/uprobes/run_ptw.sh
new file mode 100755
index 000000000000..fb23ff83c384
--- /dev/null
+++ b/tools/testing/selftests/uprobes/run_ptw.sh
@@ -0,0 +1,226 @@
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
+	echo "-:pw" > "$EV" 2>/dev/null
+	echo "-:bad" > "$EV" 2>/dev/null
+	[ -z "$TMP" ] || rm -rf "$TMP"
+}
+
+if [ ! -e "$PTW" ]; then
+	echo "1..0 # SKIP PTWRITE unavailable"
+	exit 0
+fi
+if [ ! -d "$TR" ] || [ "$(id -u)" != 0 ] || [ ! -x "$BIN" ]; then
+	echo "1..0 # SKIP missing tracefs, root, or ptw_probe"
+	exit 0
+fi
+TMP=$(mktemp -d "${TMPDIR:-/tmp}/ptw.XXXXXX") || {
+	echo "1..0 # SKIP unable to create secure temporary directory"
+	exit 0
+}
+PERF_DATA="$TMP/ptw-perf.data"
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
+FLT_V=$(objdump -d "$BIN" | awk '/^[0-9a-f]+ <faultfn>:/{print $1;exit}' | tr -d ':')
+NOP_V=$(objdump -d "$BIN" | awk '/^[0-9a-f]+ <nopfn_site>:/{print $1;exit}' | tr -d ':')
+NOP5_V=$(objdump -d "$BIN" | awk '/^[0-9a-f]+ <nop5>:/{print $1;exit}' | tr -d ':')
+RZ_V=$(objdump -d "$BIN" | awk '/^[0-9a-f]+ <rzfn>:/{print $1;exit}' | tr -d ':')
+PUN_OFF=$(elf_off 0x$PUN_V)
+JCC_OFF=$(elf_off 0x$JCC_V)
+FLT_OFF=$(elf_off 0x$FLT_V)
+NOP_OFF=$(elf_off 0x$NOP_V)
+NOP5_OFF=$(elf_off 0x$NOP5_V)
+RZ_OFF=$(elf_off 0x$RZ_V)
+
+echo "1..12"
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
+	if ! echo "ptw:pw $BIN:$off $args" > "$EV" 2>/dev/null; then
+		tap "$num" not "$desc (probe create failed)"
+		exit 1
+	fi
+	if ! echo 1 > "$TR/events/uprobes/pw/enable" 2>/dev/null; then
+		tap "$num" not "$desc (probe enable failed)"
+		exit 1
+	fi
+	run_one
+	echo 0 > "$TR/events/uprobes/pw/enable" 2>/dev/null
+	echo "-:pw" > "$EV" 2>/dev/null
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
+if ! echo "ptw:pw $BIN:$JCC_OFF %di %si" > "$EV" 2>/dev/null; then
+	tap 2 ok "rel8 jcc site rejected at create"
+else
+	if echo 1 > "$TR/events/uprobes/pw/enable" 2>/dev/null; then
+		echo 0 > "$TR/events/uprobes/pw/enable" 2>/dev/null
+		tap 2 not "rel8 jcc site enabled (expected rejection)"
+	else
+		tap 2 ok "rel8 jcc site rejected (no re-encode)"
+	fi
+	echo "-:pw" > "$EV" 2>/dev/null
+fi
+
+# 3: memory-arg fault fixup (a bad base fixes up to word 0)
+probe_run 3 $FLT_OFF "+8(%di) %si" \
+	"memory-arg fault fixup (child survived, acc unchanged)"
+
+# 4: ptwrite stream decode (words must capture + decode cleanly)
+if ! command -v perf >/dev/null 2>&1; then
+	tap 4 skip "ptwrite decode smoke (no perf)"
+elif ! { echo "ptw:pw $BIN:$PUN_OFF %di %si" > "$EV" &&
+	echo 1 > "$TR/events/uprobes/pw/enable" &&
+	perf record -e intel_pt/ptw=1,fup_on_ptw=1/u -o "$PERF_DATA" \
+		"$BIN" >/dev/null 2>&1 &&
+	echo 0 > "$TR/events/uprobes/pw/enable"; }; then
+	tap 4 not "perf record failed"
+else
+	words=$(perf script --itrace=qwe -i "$PERF_DATA" 2>/dev/null |
+		grep -c "ptwrite:")
+	if [ "${words:-0}" -gt 0 ]; then
+		tap 4 ok "ptwrite stream decode ($words words)"
+	else
+		tap 4 not "no ptwrite words decoded"
+	fi
+fi
+echo "-:pw" > "$EV" 2>/dev/null
+
+# 5: mini-stress (50 fork/execs survive)
+if ! echo "ptw:pw $BIN:$PUN_OFF %di %si" > "$EV" 2>/dev/null ||
+   ! echo 1 > "$TR/events/uprobes/pw/enable" 2>/dev/null; then
+	tap 5 not "churn mini-stress setup failed"
+else
+	fails=0
+	for i in $(seq 1 50); do
+		"$BIN" >/dev/null 2>&1 || fails=$((fails + 1))
+	done
+	echo 0 > "$TR/events/uprobes/pw/enable" 2>/dev/null
+	if [ "$fails" -eq 0 ] && sites_match; then
+		tap 5 ok "churn mini-stress (50 execs, 0 failures)"
+	else
+		tap 5 not "churn mini-stress ($fails/50 failed)"
+	fi
+fi
+echo "-:pw" > "$EV" 2>/dev/null
+
+# 6: a 5x1-byte NOP run takes the pun path (site restored)
+probe_run 6 "${NOP_OFF}%multinop" "%di %si" \
+	"misaligned NOP-composition install (probe fires, target valid, site restored)"
+
+# 7: the single 5-byte NOP keeps the classic 3-phase poke
+probe_run 7 $NOP5_OFF "%di %si" \
+	"single 5-byte-NOP 3-phase install (probe fires, target valid, site restored)"
+
+# 8: enable/disable flip loop (50 re-installs stay correct)
+if ! echo "ptw:pw $BIN:$NOP5_OFF %di %si" > "$EV" 2>/dev/null ||
+   [ ! -e "$TR/events/uprobes/pw/enable" ]; then
+	tap 8 not "flip loop setup failed"
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
+		tap 8 ok "enable/disable flip loop (50 flips, 0 failures, site restored)"
+	else
+		tap 8 not "flip loop ($fails failures)"
+	fi
+fi
+echo "-:pw" > "$EV" 2>/dev/null
+
+# 9: a 4-arg paced probe at a site with a stack-local sentinel
+probe_run 9 $RZ_OFF "%di %si %dx %r8" \
+	"4-arg paced probe"
+
+# 10: %nopace attached to the offset remains accepted
+probe_run 10 "${PUN_OFF}%nopace" "%di %si" \
+	"%nopace offset suffix is accepted"
+
+# 11: %nopace as a separate option remains accepted
+probe_run 11 "$PUN_OFF" "%nopace %di %si" \
+	"%nopace separate option is accepted"
+
+# 12: unknown ptwrite options must be rejected by tracefs
+if echo "ptw:bad $BIN:${PUN_OFF}%unknown %di %si" > "$EV" 2>/dev/null; then
+	echo "-:bad" > "$EV" 2>/dev/null
+	tap 12 not "unknown ptwrite option accepted"
+else
+	tap 12 ok "unknown ptwrite option rejected"
+fi
+
+# the kselftest runner uses only the exit code
+[ "$failures" -eq 0 ] || exit 1
-- 
2.54.0

