Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CC34028DA
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814849; cv=none; b=K6vhj7mzioR3WXUNzwgHFqt0SDoLj5NjM8vCyq0S0obSd8LZYZ9xjjeTC5aGhjUAM9D55OXNZnJqduf3SQuKuBBM/V0i3hhWNsudnbthLdURJiWGUYdcP0pROJurqQk+FiXw/s457MuDsyo2T6PKsRcgXEy1hp2st8TF4+WBZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814849; c=relaxed/simple;
	bh=7WlkOoaE/RMqjgbj6G1MbXEsmIn23jDaiZiX8j542bI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WccgSg3sFCTbL1IKIqcn94V0BJ9r1nCh78dI/Pnu9fmArBgAvYrqqZlxl8wsdOzFDGG83M9g6OsacnMw5Ux7EbTLbO/5EIFrH4FAF4lFmYsj3RJft/IAfmmSUDwYoy4DwokYiAohK8kGu5I3C5SntzFq//K2M7nJTxDO5tJwYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pzwO60gd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pzwO60gd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 706CF2944;
	Tue, 26 May 2026 10:00:42 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2089E3F7B4;
	Tue, 26 May 2026 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779814847; bh=7WlkOoaE/RMqjgbj6G1MbXEsmIn23jDaiZiX8j542bI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pzwO60gd4diW64UcQ5crqbNRahVnOLgAtjSFb/rh1KHRUvObLGdeftOaX8ZygvssS
	 QlALxi07BPipfInujbnGOE4w2vwzc/uGvvpYNzAhFOlK4REMc9UDwKUaILt1o7wUCM
	 gvRfFNBGNT0Du6jjfScdNvF3ewZz0Sbv/nELAH2o=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 26 May 2026 17:59:44 +0100
Subject: [PATCH v6 8/8] perf test: Add Arm CoreSight callchain test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-arm_cs_callchain_support_v1-v6-8-f9f49f53c9dd@arm.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>, 
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779814822; l=6359;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=7WlkOoaE/RMqjgbj6G1MbXEsmIn23jDaiZiX8j542bI=;
 b=YIbR2VfgZ7s5gODkXaxRPPzhT9ryH1uDOX8j/3Ysscp8o3Yvt/mudI7IlYHcedGnbATow3UjY
 VVCq6HaAqx/BlwP4170dTfUb79F0uF+WikErwnLZ6RhYY1U3FqiM0OG
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add a shell test for synthesized callchains from Arm CoreSight trace.
The test runs only on arm64 systems with cs_etm event and gcc available.

Build a small test program for syscall, record them with CoreSight trace
data, and decode with itrace callchain synthesis enabled. Verify that
the push and pop callchain.

After:

  perf test 150 -vvv

  150: Check Arm CoreSight synthesized callchain:
  --- start ---
  test child forked, pid 13528
  Test callchain push: PASS
  Test callchain pop: PASS
  ---- end(0) ----
  150: Check Arm CoreSight synthesized callchain                       : Ok

Assisted-by: Codex:GPT-5.5
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../tests/shell/test_arm_coresight_callchain.sh    | 235 +++++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/tools/perf/tests/shell/test_arm_coresight_callchain.sh b/tools/perf/tests/shell/test_arm_coresight_callchain.sh
new file mode 100755
index 0000000000000000000000000000000000000000..0e5a5d1129ae7d34f8e0c5942fb62d27db3e862d
--- /dev/null
+++ b/tools/perf/tests/shell/test_arm_coresight_callchain.sh
@@ -0,0 +1,235 @@
+#!/bin/bash
+# Check Arm CoreSight synthesized callchain (exclusive)
+# SPDX-License-Identifier: GPL-2.0
+
+glb_err=1
+
+if ! tmpdir=$(mktemp -d /tmp/perf-cs-callchain-test.XXXXXX); then
+	echo "mktemp failed"
+	exit 1
+fi
+
+cleanup_files()
+{
+	rm -rf "$tmpdir"
+}
+
+trap cleanup_files EXIT
+trap 'cleanup_files; exit $glb_err' TERM INT
+
+skip_if_system_is_not_ready()
+{
+	[ "$(uname -m)" = "aarch64" ] || {
+		echo "Skip: arm64 only test" >&2
+		return 2
+	}
+
+	perf list | grep -q 'cs_etm//' || {
+		echo "Skip: cs_etm event is not available" >&2
+		return 2
+	}
+
+	command -v gcc >/dev/null 2>&1 || {
+		echo "Skip: gcc is not available" >&2
+		return 2
+	}
+
+	return 0
+}
+
+build_test_program()
+{
+	local src=$1
+	local bin=$2
+
+	gcc -g -O0 -o "$bin" "$src"
+}
+
+record_trace()
+{
+	local bin=$1
+	local data=$2
+	local script=$3
+
+	perf record -m ,32M -o "$data" --per-thread -e cs_etm// -- "$bin" >/dev/null 2>&1 &&
+	perf script --itrace=g16i10il64 -i "$data" > "$script"
+}
+
+check_regex()
+{
+	local name=$1
+	local regex=$2
+	local script=$3
+
+	if grep -Pzo "$regex" "$script" >/dev/null; then
+		echo "Test $name: PASS"
+		return 0
+	else
+		echo "Test $name: FAIL"
+		return 1
+	fi
+}
+
+run_test()
+{
+	local name=$1
+	local src=$tmpdir/$name.S
+	local bin=$tmpdir/$name
+	local data=$tmpdir/perf.$name.data
+	local script=$tmpdir/perf.$name.script
+	local regex
+
+	"${name}_src" "$src"
+
+	if ! build_test_program "$src" "$bin"; then
+		echo "$name: build failed"
+		return
+	fi
+
+	if ! record_trace "$bin" "$data" "$script"; then
+		echo "$name: perf record/script failed"
+		return
+	fi
+
+	regex=$("${name}_push_regex")
+	check_regex "${name} push" "$regex" "$script" || return
+
+	regex=$("${name}_pop_regex")
+	check_regex "${name} pop" "$regex" "$script" || return
+
+	glb_err=0
+}
+
+callchain_src()
+{
+	cat > "$1" <<'EOF'
+/* callchain.S */
+	.text
+
+	.global do_svc
+	.type do_svc, %function
+do_svc:
+	stp	x29, x30, [sp, #-16]!
+	mov	x29, sp
+
+	mov	x0, #1
+	adr	x1, msg
+	mov	x2, #23
+	mov	x8, #64
+
+	nop
+	nop	// Pad nops for 9 insns before svc
+
+	b	1f
+1:
+	svc	#0
+
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop	// Pad nops for 10 insns after svc
+
+	ldp	x29, x30, [sp], #16
+	ret
+	.size do_svc, .-do_svc
+
+	.global foo
+	.type foo, %function
+foo:
+	stp	x29, x30, [sp, #-16]!
+	mov	x29, sp
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop	// Pad nops for 9 insns before call
+
+	bl	do_svc
+
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop	// Pad nops for 10 insns after call
+
+	ldp	x29, x30, [sp], #16
+	ret
+	.size foo, .-foo
+
+	.global main
+	.type main, %function
+main:
+	stp	x29, x30, [sp, #-16]!
+	mov	x29, sp
+
+	bl	foo
+
+	mov	w0, #0
+	ldp	x29, x30, [sp], #16
+	.size main, .-main
+	ret
+
+	.section .rodata
+msg:
+	.asciz	"hello from svc syscall\n"
+EOF
+}
+
+callchain_push_regex()
+{
+	printf '%s' \
+'callchain[[:space:]]+[0-9]+ \[[0-9]+\][[:space:]]+10 instructions:[[:space:]]*\n'\
+'[[:space:]]+[[:xdigit:]]+ foo\+0x[[:xdigit:]]+ \(.*/callchain\)\n'\
+'[[:space:]]+[[:xdigit:]]+ main\+0xc \(.*/callchain\)\n'\
+'([[:space:]]+[[:xdigit:]]+ .*\n)*'\
+'\n'\
+'callchain[[:space:]]+[0-9]+ \[[0-9]+\][[:space:]]+10 instructions:[[:space:]]*\n'\
+'[[:space:]]+[[:xdigit:]]+ do_svc\+0x[[:xdigit:]]+ \(.*/callchain\)\n'\
+'[[:space:]]+[[:xdigit:]]+ foo\+0x28 \(.*/callchain\)\n'\
+'[[:space:]]+[[:xdigit:]]+ main\+0xc \(.*/callchain\)\n'\
+'([[:space:]]+[[:xdigit:]]+ .*\n)*'\
+'\n'\
+'callchain[[:space:]]+[0-9]+ \[[0-9]+\][[:space:]]+10 instructions:[[:space:]]*\n'\
+'[[:space:]]+[[:xdigit:]]+ (vectors|el.*_64_sync|tramp_vectors)\+0x[[:xdigit:]]+ \(\[kernel\.kallsyms\]\)\n'\
+'[[:space:]]+[[:xdigit:]]+ do_svc\+0x28 \(.*/callchain\)\n'\
+'[[:space:]]+[[:xdigit:]]+ foo\+0x28 \(.*/callchain\)\n'\
+'[[:space:]]+[[:xdigit:]]+ main\+0xc \(.*/callchain\)\n'\
+'([[:space:]]+[[:xdigit:]]+ .*\n)*'
+}
+
+callchain_pop_regex()
+{
+	printf '%s' \
+'callchain[[:space:]]+[0-9]+ \[[0-9]+\][[:space:]]+10 instructions:[[:space:]]*\n'\
+'[[:space:]]+[[:xdigit:]]+ (ret_to_user|tramp_exit)\+0x[[:xdigit:]]+ \(\[kernel\.kallsyms\]\)\n'\
+'[[:space:]]+[[:xdigit:]]+ do_svc\+0x28 \(.*/callchain\)\n'\
+'[[:space:]]+[[:xdigit:]]+ foo\+0x28 \(.*/callchain\)\n'\
+'[[:space:]]+[[:xdigit:]]+ main\+0xc \(.*/callchain\)\n'\
+'([[:space:]]+[[:xdigit:]]+ .*\n)*'\
+'\n'\
+'callchain[[:space:]]+[0-9]+ \[[0-9]+\][[:space:]]+10 instructions:[[:space:]]*\n'\
+'[[:space:]]+[[:xdigit:]]+ do_svc\+0x[[:xdigit:]]+ \(.*/callchain\)\n'\
+'[[:space:]]+[[:xdigit:]]+ foo\+0x28 \(.*/callchain\)\n'\
+'[[:space:]]+[[:xdigit:]]+ main\+0xc \(.*/callchain\)\n' \
+'([[:space:]]+[[:xdigit:]]+ .*\n)*'\
+'\n'\
+'callchain[[:space:]]+[0-9]+ \[[0-9]+\][[:space:]]+10 instructions:[[:space:]]*\n'\
+'[[:space:]]+[[:xdigit:]]+ foo\+0x[[:xdigit:]]+ \(.*/callchain\)\n'\
+'[[:space:]]+[[:xdigit:]]+ main\+0xc \(.*/callchain\)\n'\
+'([[:space:]]+[[:xdigit:]]+ .*\n)*'
+}
+
+skip_if_system_is_not_ready || exit 2
+
+run_test "callchain"
+
+exit $glb_err

-- 
2.34.1

