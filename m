Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5842224B04
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189492; cv=none; b=N20kG4FZHdoAbGaUQc/X7+P/3Da+2Qvz1c//baRywC0gBD7DtNO0uuplSKcai+pzypSrACw+GFQHopr7oT/QVD+IqFZ/S4n4SiDW3wojU5PYm2HCwHS9B4UjOLeBulHBMd1ydvTLA/DjJGWbAFTnC9aDvU5qlEOYc927R2+suNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189492; c=relaxed/simple;
	bh=fIesXeCH7m3UbmK/pgDEBP262Vmz9dnY+v+NjvyuXN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c/zf4gn9gvcgpHVO0Wbs15YoM2QWiyWJ88vLcW36cjFf4eYb2hZJDgYnRf56HlOfbXovhe/5+01Nc+RPEowqxEqjNiF0+1gQi66UBlOmPRY+1d182zwly3+fjIVnlFcVt0NXLIseagt+JD4xBAzbUwbJ6JCMlWb4zG58uxrfOws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Nt7R2jZA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Nt7R2jZA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C47025E2;
	Thu, 11 Jun 2026 07:51:25 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CC5E3FBB1;
	Thu, 11 Jun 2026 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781189490; bh=fIesXeCH7m3UbmK/pgDEBP262Vmz9dnY+v+NjvyuXN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nt7R2jZAPFrpmc/5m9/m50CVaz43og4dCjzOgCvHn7FioSMLwYPQCU8gXDnzy9Z4h
	 pfO0tTisLLKF0iRfsgzDMIjQohiih7bK9DYxZAS+62ypCytVd85HCrfPnUMae33gR/
	 fNXRC5Mi5hsN+RByUus/Ty4RHC4mYNguX/rvsoa0=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 11 Jun 2026 15:50:54 +0100
Subject: [PATCH v8 8/8] perf test: Add Arm CoreSight callchain test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-arm_cs_callchain_support_v1-v8-8-737948584fea@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v8-0-737948584fea@arm.com>
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v8-0-737948584fea@arm.com>
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
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781189463; l=10348;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=fIesXeCH7m3UbmK/pgDEBP262Vmz9dnY+v+NjvyuXN8=;
 b=vykQW1JPIXCEBvUzdXThWizOdzym8AKESqduBaYmcl1uxxRK9MTCjwTJkXCv9bb6JlgCRk4Ia
 2qV4Bu16EJvAc+KQNwys8LEfL78/dCArfr63qV73zIJp5vqNJeoJavX
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add a CoreSight shell test for synthesized callchains.

The test uses the new callchain workload to generate trace and decodes
it with synthesis callchain. It then verifies that the instruction
samples show the expected callchain push and pop.

Use control FIFOs so tracing starts only around the workload, which
keeps the trace data small. The test is limited to with the cs_etm
event available and root permission.

After:

  perf test 138 -vvv
  138: CoreSight synthesized callchain:
  ---- start ----
  test child forked, pid 35581
  Callchain flow matched:
    l1=4642868 l2=4642880 l3=4642895 l4=4642919 l5=4670494 l6=4670500 l7=4670520
  ---- end(0) ----
  138: CoreSight synthesized callchain                                                                           : Ok

Assisted-by: Codex:GPT-5.5
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/perf-test.txt        |   6 +-
 tools/perf/tests/builtin-test.c               |   1 +
 tools/perf/tests/shell/coresight/callchain.sh | 172 ++++++++++++++++++++++++++
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/tests/workloads/Build              |   2 +
 tools/perf/tests/workloads/callchain.c        |  33 +++++
 6 files changed, 213 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 81c8525f594680d814f80e6f88bcce8d867bb350..859df74e62efc4b1e80da13ae8e053356f68ae54 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -57,7 +57,8 @@ OPTIONS
 --workload=::
 	Run a built-in workload, to list them use '--list-workloads', current
 	ones include: noploop, thloop, leafloop, sqrtloop, brstack, datasym,
-	context_switch_loop, deterministic, named_threads and landlock.
+	context_switch_loop, deterministic, named_threads, landlock and
+	callchain.
 
 	Used with the shell script regression tests.
 
@@ -69,7 +70,8 @@ OPTIONS
 	'named_threads' accepts the number of threads and the number of loops to
 	do in each thread.
 
-	The datasym, landlock and deterministic workloads don't accept any.
+	The datasym, landlock, deterministic and callchain workloads don't accept
+	any.
 
 --list-workloads::
 	List the available workloads to use with -w/--workload.
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index afc06cec49546d29d86b94840c7021c5bf5c88e3..8994488cc206863ba77f7e7e5803e62f18e151ba 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -166,6 +166,7 @@ static struct test_workload *workloads[] = {
 	&workload__jitdump,
 	&workload__context_switch_loop,
 	&workload__deterministic,
+	&workload__callchain,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/shell/coresight/callchain.sh b/tools/perf/tests/shell/coresight/callchain.sh
new file mode 100755
index 0000000000000000000000000000000000000000..13cca7dc11184002e3ddc058c0d0ffa1c458c483
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/callchain.sh
@@ -0,0 +1,172 @@
+#!/bin/bash
+# CoreSight synthesized callchain (exclusive)
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
+	perf list | grep -Pzq 'cs_etm//' || {
+		echo "[Skip] cs_etm event is not available" >&2
+		return 2
+	}
+
+	# Requires root for trace in kernel
+	[ "$(id -u)" = 0 ] || {
+		echo "[Skip] No root permission" >&2
+		return 2
+	}
+
+	return 0
+}
+
+record_trace()
+{
+	local data=$1
+	local script=$2
+
+	local cf="$tmpdir/ctl"
+	local af="$tmpdir/ack"
+
+	mkfifo "$cf" "$af"
+
+	perf record -o "$data" -e cs_etm// --per-thread -D -1 --control fifo:"$cf","$af" -- \
+		perf test --record-ctl fifo:"$cf","$af" -w callchain >/dev/null 2>&1 &&
+
+	# It is safe to use 'i3i' with a three-instruction interval, since the
+	# workload is compiled with -O0.
+	perf script --itrace=g16i3il64 -i "$data" > "$script"
+}
+
+callchain_regex_1()
+{
+	printf '%s' \
+'perf[[:space:]]+[0-9]+[[:space:]]+\[[0-9]+\][[:space:]]+([0-9.]+:[[:space:]]+)?[0-9]+ instructions:[[:space:]]*\n'\
+'[[:space:]]+[[:xdigit:]]+ callchain_foo\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
+'[[:space:]]+[[:xdigit:]]+ callchain\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
+'([[:space:]]+[[:xdigit:]]+ .*\n)*'
+}
+
+callchain_regex_2()
+{
+	printf '%s' \
+'perf[[:space:]]+[0-9]+[[:space:]]+\[[0-9]+\][[:space:]]+([0-9.]+:[[:space:]]+)?[0-9]+ instructions:[[:space:]]*\n'\
+'[[:space:]]+[[:xdigit:]]+ callchain_do_syscall\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
+'[[:space:]]+[[:xdigit:]]+ callchain_foo\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
+'[[:space:]]+[[:xdigit:]]+ callchain\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
+'([[:space:]]+[[:xdigit:]]+ .*\n)*'
+}
+
+callchain_regex_3()
+{
+	printf '%s' \
+'perf[[:space:]]+[0-9]+[[:space:]]+\[[0-9]+\][[:space:]]+([0-9.]+:[[:space:]]+)?[0-9]+ instructions:[[:space:]]*\n'\
+'[[:space:]]+[[:xdigit:]]+ syscall(@plt)?\+0x[[:xdigit:]]+ \(.*\)\n'\
+'[[:space:]]+[[:xdigit:]]+ callchain_do_syscall\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
+'[[:space:]]+[[:xdigit:]]+ callchain_foo\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
+'[[:space:]]+[[:xdigit:]]+ callchain\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
+'([[:space:]]+[[:xdigit:]]+ .*\n)*'
+}
+
+callchain_regex_4()
+{
+	printf '%s' \
+'perf[[:space:]]+[0-9]+[[:space:]]+\[[0-9]+\][[:space:]]+([0-9.]+:[[:space:]]+)?[0-9]+ instructions:[[:space:]]*\n'\
+'[[:space:]]+[[:xdigit:]]+ .*\+0x[[:xdigit:]]+ \(\[kernel\.kallsyms\]\)\n'\
+'[[:space:]]+[[:xdigit:]]+ syscall(@plt)?\+0x[[:xdigit:]]+ \(.*\)\n'\
+'[[:space:]]+[[:xdigit:]]+ callchain_do_syscall\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
+'[[:space:]]+[[:xdigit:]]+ callchain_foo\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
+'[[:space:]]+[[:xdigit:]]+ callchain\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
+'([[:space:]]+[[:xdigit:]]+ .*\n)*'
+}
+
+find_after_line()
+{
+	local regex="$1"
+	local file="$2"
+	local start="$3"
+	local offset
+	local line
+
+	# Search in byte offset
+	offset=$(
+		tail -n +"$start" "$file" |
+		grep -Pzob -m1 "$regex" |
+		tr '\0' '\n' |
+		sed -n 's/^\([0-9][0-9]*\):.*/\1/p;q'
+	)
+
+	if [ -z "$offset" ]; then
+		echo "Failed to match regex after line $start" >&2
+		echo "Regex:" >&2
+		printf '%s\n' "$regex" >&2
+		echo "Context from line $start:" >&2
+		sed -n "${start},$((start + 100))p" "$file" >&2
+		return 1
+	fi
+
+	# Convert from offset to line
+	line=$(
+		tail -n +"$start" "$file" |
+		head -c "$offset" |
+		wc -l
+	)
+
+	echo "$((start + line))"
+}
+
+check_callchain_flow()
+{
+	local file="$1"
+	local l1 l2 l3 l4 l5 l6 l7
+
+	# Callchain push
+	l1=$(find_after_line "$(callchain_regex_1)" "$file" 1) || return 1
+	l2=$(find_after_line "$(callchain_regex_2)" "$file" "$((l1 + 1))") || return 1
+	l3=$(find_after_line "$(callchain_regex_3)" "$file" "$((l2 + 1))") || return 1
+	l4=$(find_after_line "$(callchain_regex_4)" "$file" "$((l3 + 1))") || return 1
+
+	# Callchain pop
+	l5=$(find_after_line "$(callchain_regex_3)" "$file" "$((l4 + 1))") || return 1
+	l6=$(find_after_line "$(callchain_regex_2)" "$file" "$((l5 + 1))") || return 1
+	l7=$(find_after_line "$(callchain_regex_1)" "$file" "$((l6 + 1))") || return 1
+
+	echo "Callchain flow matched:"
+	echo "  l1=$l1 l2=$l2 l3=$l3 l4=$l4 l5=$l5 l6=$l6 l7=$l7"
+
+	return 0
+}
+
+run_test()
+{
+	local data=$tmpdir/perf.data
+	local script=$tmpdir/perf.script
+
+	if ! record_trace "$data" "$script"; then
+		echo "perf record/script failed"
+		return
+	fi
+
+	check_callchain_flow "$script" || return
+
+	glb_err=0
+}
+
+skip_if_system_is_not_ready || exit 2
+
+run_test
+
+exit $glb_err
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 7cedf05be544ad79a99e86d30dfa4f7b01ca0837..cee9e6b62dcc838c864bbe76efe3b638ed75b134 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -248,6 +248,7 @@ DECLARE_WORKLOAD(inlineloop);
 DECLARE_WORKLOAD(jitdump);
 DECLARE_WORKLOAD(context_switch_loop);
 DECLARE_WORKLOAD(deterministic);
+DECLARE_WORKLOAD(callchain);
 
 #ifdef HAVE_RUST_SUPPORT
 DECLARE_WORKLOAD(code_with_type);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 75b377934a0e62b9ac1fec245520ea0978ac957e..dfdf9a2720b22f67a3d7b53d0ed14e0654059c8f 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -13,6 +13,7 @@ perf-test-y += inlineloop.o
 perf-test-y += jitdump.o
 perf-test-y += context_switch_loop.o
 perf-test-y += deterministic.o
+perf-test-y += callchain.o
 
 ifeq ($(CONFIG_RUST_SUPPORT),y)
     perf-test-y += code_with_type.o
@@ -26,3 +27,4 @@ CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_inlineloop.o       = -g -O2
 CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_callchain.o        = -g -O0 -fno-inline -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/callchain.c b/tools/perf/tests/workloads/callchain.c
new file mode 100644
index 0000000000000000000000000000000000000000..3951423d8115e9efb49af8ba2586001fc6f02761
--- /dev/null
+++ b/tools/perf/tests/workloads/callchain.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include "../tests.h"
+
+/*
+ * Mark as noinline to establish the call chain, and avoid the static
+ * annotation to prevent LTO from renaming the functions.
+ */
+noinline void callchain_do_syscall(void);
+noinline void callchain_foo(void);
+noinline int callchain(int argc, const char **argv);
+
+noinline void callchain_do_syscall(void)
+{
+	syscall(SYS_getpid);
+}
+
+noinline void callchain_foo(void)
+{
+	callchain_do_syscall();
+}
+
+noinline int callchain(int argc __maybe_unused,
+		       const char **argv __maybe_unused)
+{
+	callchain_foo();
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(callchain);

-- 
2.34.1

