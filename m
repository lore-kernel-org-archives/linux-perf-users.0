Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373233;
	b=4Ksh1J9CgdOjxPQQT+WtsqPAocXf9HMZqpPTlGHPYH+oaFMBp3giJacdruYUW37ih1Nt
	 pG9YGk+zkqWXgsKeICcHt2p3mN1k8Emdi3HZTmPg2LvzdHZEixq3ztYghrfPcCsVXnMJV
	 1b3V4CFryEa7tOYi05mxh3uf4GG9W8bNQTGKerarb2qU8aQH+HoVlmQ/Z4mwUp27gROCh
	 R7NmsJJBRC7JmETJ+NsihH83NGjtzj3sQ4j1rTwqjy0ZpUUIQ4NFUGfWz3EPhpH5qCoR2
	 n6iz84Jq2yOT7xJ8Uqt1mYwMHXL5SMHFFDDgqjAoNjqmqQdE/Pm/P6YULPDSAmqCFmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373233;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=NRk5jNczxgmI1QEaUMIKG9MYVAuojhZMMTIHmDMCTZc=;
	b=A+qHPUPAkEz0pzY4WuFFmcqhrKmRLy87SaGNionCEXljAJqKtT+iYOGMuwc2r2e6IAId
	 1cNcCFr6HgyGI308pQUwbY4l3Vbztg7Eq6ASEfFh0YQJ6Wo0qYgxEXHNI77NDiSP74aQc
	 pqLBNb9h6TA4Sqe3Y/9eF9EtxLPTgYRBzkngyeBkJFktPyYJ8fmQv+gYXwbHU5htgqZn2
	 bBVYgrUABVXjqyk4QNqEm/nU0wGJlEyKP7r44akPkFzC1gzx4uegiP30ufsuOzVdP16y2
	 BnWR1fqsesAfGeUSi2v+3rP4KUOvOHiMH6L7ZYpXL7sZsoznWrXOQA2S3dPZ1A5FL7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=uGYRdVo7;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE806606A339;
	Fri, 30 Oct 2026 15:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE806606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=uGYRdVo7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C0C61BD0;
	Fri, 30 Oct 2026 08:13:49 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7A6F3F59E;
	Fri, 30 Oct 2026 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373232; bh=+QfVIRm628HJ+xtRhJ4yi1SWHZhwIrt7IDMl9mbGTyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uGYRdVo7OUd5+N8lxPlGxdkqgqBpNoM6XheYXShgS9RYfzL8ZgAmkkIbEKqza6r87
	 xCAtUeprQ31rEto58+Vz8zYopAeOojP9NHK6ymyhPUOqtcgQ5FSsKDqWmRwiSUwZXP
	 Xu/bKn+BAIhEZpp8Qrk+HjvZecpLwa0G2CgttuXQ=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 30 Oct 2026 15:13:18 +0000
Subject: [PATCH v3 11/14] perf tests: Check CoreSight IRQ entry and exit
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-11-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=10507;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=+QfVIRm628HJ+xtRhJ4yi1SWHZhwIrt7IDMl9mbGTyE=;
 b=TLsj9pKmxFMZrLqg9xJa26CulCNqtPj0E+PWzKD+RYMXSjmWSgNJcyyw9k405D/qm+0+40yea
 zla5q1Hfa2cCIjNlGDvSIlfk1wDgnZCTcSfAt/Mm2wg2G2yaMBW+XjQ
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add an AArch64 branch_not_taken_loop workload and a CoreSight shell test
checking IRQ entry and exit PCs. Use cpu-clock to generate timer
interrupts.

Retry at different timer frequencies and fail if no complete pair is
captured after all three attempts.

For example, an expected hw int/iret pair is:

  hw int           5cc928 => ffff800080010c80 insn: 63 04 00 f1
  ...
  iret   ffff800080012284 =>           5cc928 insn: e0 03 9f d6

The entry PC is the architectural resume address, here SUBS X3, X3, #1
at 0x5cc928. After the IRQ is handled, ERET returns to the same PC to
continue execution.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/builtin-test.c                    |   1 +
 tools/perf/tests/shell/coresight/irq_entry_exit.sh |  36 +++++
 tools/perf/tests/shell/lib/coresight_exception.sh  | 164 +++++++++++++++++++++
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/tests/workloads/Build                   |   2 +
 tools/perf/tests/workloads/branch_not_taken_loop.c |  33 +++++
 6 files changed, 237 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 8dd72cd97cdb2de0f80f108cd72b9264c073e2a0..24e095d4d20cee6a6aae7cfda364fb237ef74b30 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -191,6 +191,7 @@ static struct test_workload *workloads[] = {
 	&workload__datasym,
 	&workload__landlock,
 	&workload__traploop,
+	&workload__branch_not_taken_loop,
 	&workload__inlineloop,
 	&workload__jitdump,
 	&workload__context_switch_loop,
diff --git a/tools/perf/tests/shell/coresight/irq_entry_exit.sh b/tools/perf/tests/shell/coresight/irq_entry_exit.sh
new file mode 100755
index 0000000000000000000000000000000000000000..135483b8d3532b26610dcabe7fab91f025ee0cb5
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/irq_entry_exit.sh
@@ -0,0 +1,36 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# CoreSight IRQ entry and exit (exclusive)
+
+. "$(dirname "$0")/../lib/coresight_exception.sh"
+
+test_irq_entry_exit()
+{
+	# IRQs must return to the interrupted PC. Retry at different timer
+	# frequencies if trace gaps leave no complete entry/exit pair.
+	for freq in 1000 4000 10000; do
+		echo "Recording timer IRQs at $freq Hz"
+		if ! record_trace_with_cpu_clock "$freq" branch_not_taken_loop; then
+			cat "$tmpdir/record.log"
+			echo "Failed to record the IRQ workload"
+			return 1
+		fi
+
+		decode_trace || return 1
+
+		check_exception_pairs "hw int" "iret" 0
+		result=$?
+		case $result in
+		0) return 0 ;;
+		1) cat "$tmpdir/script.log"; return 1 ;;
+		2) echo "No complete IRQ pair in this recording" ;;
+		*) return "$result" ;;
+		esac
+	done
+
+	echo "FAIL: No complete IRQ pair after three recordings"
+	return 1
+}
+
+setup_exception_test || exit $?
+test_irq_entry_exit
diff --git a/tools/perf/tests/shell/lib/coresight_exception.sh b/tools/perf/tests/shell/lib/coresight_exception.sh
new file mode 100644
index 0000000000000000000000000000000000000000..2d5a24ce3b5494e69973f61f4372e432c803952e
--- /dev/null
+++ b/tools/perf/tests/shell/lib/coresight_exception.sh
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: GPL-2.0
+# Common helpers for CoreSight exception entry and return tests.
+
+cleanup()
+{
+	rm -rf "$tmpdir"
+}
+
+record_trace_with_cpu_clock()
+{
+	local cf="$tmpdir/ctl"
+	local af="$tmpdir/ack"
+	local clock_opts=()
+
+	record_freq=$1
+	shift
+
+	# A zero frequency omits the cpu-clock event.
+	if [ "$record_freq" -gt 0 ]; then
+		# Generate timer IRQs without delivering a signal to the workload.
+		clock_opts=(-e cpu-clock:u -F "$record_freq")
+	fi
+
+	# FIFO control bounds the trace to the workload.
+	# --kcore supplies the running kernel's instructions for decoding.
+	taskset -c "$cpu" perf record -B --no-bpf-event --per-thread --kcore \
+		-e cs_etm/timestamp=0/uk "${clock_opts[@]}" \
+		-m,4M -D -1 --control "fifo:$cf,$af" \
+		-o "$tmpdir/data" -- \
+		perf test --record-ctl "fifo:$cf,$af" -w "$@" \
+		> "$tmpdir/record.log" 2>&1
+}
+
+record_trace()
+{
+	record_trace_with_cpu_clock 0 "$@"
+}
+
+decode_trace()
+{
+	local sw_fields=()
+
+	# perf script rejects -F sw: when no software event was recorded.
+	if [ "$record_freq" -gt 0 ]; then
+		sw_fields=(-F sw:)
+	fi
+
+	if ! perf script -i "$tmpdir/data" --itrace=b \
+		-F hw:ip,addr,flags,insn "${sw_fields[@]}" \
+		> "$tmpdir/script" 2> "$tmpdir/script.log"; then
+		cat "$tmpdir/script.log"
+		echo "Failed to decode the exception trace"
+		return 1
+	fi
+}
+
+# Arguments: entry pattern, exit pattern, expected return PC - entry PC.
+# Return 2 if no complete pair survives the trace gaps.
+check_exception_pairs()
+{
+	local difference=$3 entry_pc resume_pc pairs=0
+
+	awk -v entry_pattern="$1" -v exit_pattern="$2" '
+	function address(pc) {
+		sub(/^0[xX]/, "", pc)
+		sub(/^0+/, "", pc)
+		return "0x" (pc == "" ? "0" : tolower(pc))
+	}
+	BEGIN {
+		entry_pattern = "^[[:space:]]*(" entry_pattern ")([[:space:]]|$)"
+		exit_pattern = "^[[:space:]]*(" exit_pattern ")([[:space:]]|$)"
+	}
+	NF {
+		# A trace boundary invalidates all pending entries, including nested ones.
+		if ($1 == "tr" && ($2 == "strt" || $2 == "end")) {
+			depth = 0
+			next
+		}
+
+		is_entry = ($1 == "hw" && $2 == "int") || $1 == "int" || $1 == "syscall"
+		is_exit = $1 == "iret" || $1 == "sysret"
+		if (!is_entry && !is_exit)
+			next
+
+		# Branch fields are: flags source => destination [insn: bytes].
+		arrow = 0
+		for (i = 1; i <= NF; i++) {
+			if ($i == "=>") {
+				arrow = i
+				break
+			}
+		}
+		if (arrow < 3 || arrow == NF) {
+			print "FAIL: Unexpected perf script output: " $0 > "/dev/stderr"
+			errors++
+			depth = 0
+			next
+		}
+
+		# Track every exception so an unrelated nested IRET cannot close
+		# a selected outer entry. Match the requested flags at each depth.
+		if (is_entry) {
+			entry_pc[++depth] = address($(arrow - 1))
+			selected[depth] = $0 ~ entry_pattern
+			next
+		}
+		if (!depth)
+			next
+
+		if (selected[depth] && $0 ~ exit_pattern)
+			print entry_pc[depth], address($(arrow + 1))
+		depth--
+	}
+	END {
+		if (errors)
+			exit 1
+	}' "$tmpdir/script" > "$tmpdir/exception_pairs" || return 1
+
+	# Bash uses integer arithmetic, preserving all bits of 64-bit PCs.
+	while read -r entry_pc resume_pc; do
+		if [ "$((resume_pc - entry_pc))" -ne "$difference" ]; then
+			printf "FAIL: Entry %s returns to %s, expected PC difference %d\n" \
+				"$entry_pc" "$resume_pc" "$difference"
+			return 1
+		fi
+		pairs=$((pairs + 1))
+	done < "$tmpdir/exception_pairs"
+
+	if [ "$pairs" -eq 0 ]; then
+		echo "No complete exception entry/exit pair"
+		return 2
+	fi
+	printf "Checked %d exception pairs with PC difference %d\n" "$pairs" "$difference"
+}
+
+setup_exception_test()
+{
+	[ "$(uname -m)" = aarch64 ] || return 2
+	perf check feature -q libopencsd || return 2
+	[ -d /sys/bus/event_source/devices/cs_etm ] || return 2
+
+	export LC_ALL=C
+	command -v taskset >/dev/null 2>&1 || return 2
+
+	tmpdir=$(mktemp -d /tmp/perf-cs-etm-exception.XXXXXX) || return 1
+	trap cleanup EXIT
+	trap 'exit 1' HUP INT TERM
+	mkfifo "$tmpdir/ctl" "$tmpdir/ack" || return 1
+
+	# Keep each exception entry and return in the same trace queue.
+	cpu=$(awk '/Cpus_allowed_list:/ {
+		split($2, cpus, /[-,]/)
+		print cpus[1]
+	}' /proc/self/status)
+
+	# Check permissions, FIFO control and the trace sink before testing.
+	if ! record_trace callchain; then
+		cat "$tmpdir/record.log"
+		echo "[Skip] Cannot record user/kernel CoreSight trace with --kcore"
+		return 2
+	fi
+
+	return 0
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 59b66fe34a71420715ca8e04bf5f0f181b2c9cf9..989208fcd417a676d03e2372e8a71ecf2059b9c6 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -264,6 +264,7 @@ DECLARE_WORKLOAD(brstack);
 DECLARE_WORKLOAD(datasym);
 DECLARE_WORKLOAD(landlock);
 DECLARE_WORKLOAD(traploop);
+DECLARE_WORKLOAD(branch_not_taken_loop);
 DECLARE_WORKLOAD(inlineloop);
 DECLARE_WORKLOAD(jitdump);
 DECLARE_WORKLOAD(context_switch_loop);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 18fceddccb56c01388383ee345d38df1acff8395..d3030bd9c0752a5bc8743a4539a0ac365d215719 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -9,6 +9,7 @@ perf-test-y += brstack.o
 perf-test-y += datasym.o
 perf-test-y += landlock.o
 perf-test-y += traploop.o
+perf-test-y += branch_not_taken_loop.o
 perf-test-y += inlineloop.o
 perf-test-y += jitdump.o
 perf-test-y += context_switch_loop.o
@@ -26,6 +27,7 @@ CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIF
 CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_branch_not_taken_loop.o = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_inlineloop.o       = -g -O2
 CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_named_threads.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/branch_not_taken_loop.c b/tools/perf/tests/workloads/branch_not_taken_loop.c
new file mode 100644
index 0000000000000000000000000000000000000000..d5e1d6119e143c5a89bff88861ff4d03e84750ec
--- /dev/null
+++ b/tools/perf/tests/workloads/branch_not_taken_loop.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include "../tests.h"
+
+#ifdef __aarch64__
+static void branch_not_taken(void)
+{
+	/* Keep x1 > x2 so B.LS is never taken. */
+	asm volatile(
+		"mov	x1, #2\n"
+		"mov	x2, #1\n"
+		"movz	x3, #0xffff\n"
+		"movk	x3, #0x0010, lsl #16\n"
+		"1: cmp	x1, x2\n"
+		".Ltest_branch:\n"
+		"b.ls	2f\n"
+		".Lfallthrough:\n"
+		"subs	x3, x3, #1\n"
+		"b.ne	1b\n"
+		"2:\n"
+		: : : "x1", "x2", "x3", "cc");
+}
+#else
+static void branch_not_taken(void) { }
+#endif
+
+static int branch_not_taken_loop(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	branch_not_taken();
+	return 0;
+}
+
+DEFINE_WORKLOAD(branch_not_taken_loop);

-- 
2.34.1

