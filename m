Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782236DA19
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631527; cv=none; b=q8rBPME4/jor1Csor/HhXlfKDISae1yby4p/XaizKL0T2kIvRBxIHq274or9LF5pP1Aw4CxBhYynGdGDK8gwcy94drPd4u71yW7p4m3c3J9vpLhYWfNjxPlj3DXWQAEpsqMxCZvQr6JXR8ijAdhUlNBtaw+VIc6jki8wZ37PUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631527; c=relaxed/simple;
	bh=Nn0miRX6O32JQOtPVCr92wiRbgVDw32950L1rvjPbWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=C1FL7NgT3we8vODolRysSyzM1Du49AqPF62yijYcLBQU5+1FM2ZjwhxVMkyNv/Z9ZGq9QJuOIgur0BQd0JSoDaTbT3xnmBZWDUDVE7/nbE/O/5QKPeTu5k49e0c0L8V6wgv6suDVNEZ1oU8RVxFgJNzmZxe6SFPpELqDOBJxkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYupg3A7; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYupg3A7"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1270dcd11c1so9950354c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 23:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775631525; x=1776236325; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLtFtC/oi2eHemCIy4gg+BvRUETIN+tHfDnRPBDklJg=;
        b=nYupg3A7BU8YpZRdiaSdNmnFExr0ZOct+A4DlzmguRQ+Bi2Aa5GMpgEyKkz23V5SPk
         Bg23/wFlF71NW17bx253BiIvs0xYeeIvQEGKviu1k7QfjFCp02WweNh3j58ey79Wvu7j
         SugNrX3Y8mEm36yl/mRdrdKPFR3lYiGRjfiEMalW1BpwVdXLUeW3pHO14jNoFtTffn29
         rj59UNCZjm49tuXxT0M4o5u1aVnV03sNadeD+O390NpOGhaa8p/830DhBRBHtCNpwuKN
         Q8vpAIN2l6ThfYfkv+2+1OaigBJyOdkJDcGOy5VFhW5Cpw+0PUMiRNEEebkvOTplpfaG
         d7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775631525; x=1776236325;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLtFtC/oi2eHemCIy4gg+BvRUETIN+tHfDnRPBDklJg=;
        b=egoWOa5ADOaSKVSVbUX7hm50INpOpk7gRd2puDpsGOWojI6B4ws/wIgGq/7cLN50YC
         wMkwU4pBVaztbE1waA9QytQ87Npy/X+NvvYRLw6GTXd1LrGeUb2OSkCScix+Wt8Wx1AJ
         PQX/HSrTfhB92oHYIP7jmEdk+Rj+E6Np+E6egMA3lHyqReQs/yrXsT/AmE1LR5hz9wjI
         prxC1dPemsX2yfehm5uMIwcCoZIiyh/5Rr41R+yo7d9YWeR2eBrK54dTb4y5b18g5GMx
         G7DFXBdKYU7AUBwKkx893Yq1eYVBBnfZI7MrRdYSb9i4COMd1v0f5qygJAEF49Qu46ux
         XSSg==
X-Forwarded-Encrypted: i=1; AJvYcCWqHOuD53kIGu9FWBbmU1gl5mLOe0HId3gpcXKrFiz2fV3vVkqCnsgbcpyefsKrUBjA9dVpERzQu70DiXe5yYYV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3D4G9DcHaLI+G3qaY+uchKwsRBZdDIIseNjzZyxyMcRLsTdZE
	gN0w5b9kGyJTCSxgxqSs0OEsPErvbVagwNcQal7khi55iASemx0VIrBy0yoCltlguRaOraD6KVj
	NXcxd/UBSgw==
X-Received: from dlbvg4.prod.google.com ([2002:a05:7022:7f04:b0:12c:18c1:703c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec17:b0:12b:ebb8:e518
 with SMTP id a92af1059eb24-12bfb779d53mr9218106c88.35.1775631524823; Tue, 07
 Apr 2026 23:58:44 -0700 (PDT)
Date: Tue,  7 Apr 2026 23:58:41 -0700
In-Reply-To: <20260408062048.61252-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408062048.61252-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408065841.165393-1-irogers@google.com>
Subject: [PATCH v3] perf test: Fixes for check branch stack sampling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, German Gomez <german.gomez@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When filtering branch stack samples on user events they sample in user
land but may have come from the kernel. Avoid the target address being
a kernel address but allow the source to be the kernel.

When filtering branch stack samples on kernel events they sample in
kernel land but may have come from user land. Avoid the target being a
user address but allow the source to be in user land.

Increase the duration of the system call sampling test to make the
likelihood of sampling a system call higher (increased from 1000 to
8000 loops - a number found through experimentation on an Intel
Tigerlake laptop), also make the period of the event a prime number.

Put unneeded perf record output into a temporary file so that the test
output isn't cluttered. More clearly state which test is running and
the pass, fail or skipped result of the test.

These changes make the test on an Intel tigerlake laptop reliably pass
rather than reliably fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_brstack.sh | 134 ++++++++++++++++---------
 1 file changed, 84 insertions(+), 50 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 85233d435be6..025ed9d3d110 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -40,7 +40,7 @@ is_arm64() {
 
 check_branches() {
 	if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$1"; then
-		echo "Branches missing $1"
+		echo "ERROR: Branches missing $1"
 		err=1
 	fi
 }
@@ -48,6 +48,8 @@ check_branches() {
 test_user_branches() {
 	echo "Testing user branch stack sampling"
 
+	start_err=$err
+	err=0
 	perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u -- ${TESTPROG} > "$TMPDIR/record.txt" 2>&1
 	perf script -i "$TMPDIR/perf.data" --fields brstacksym > "$TMPDIR/perf.script"
 
@@ -73,59 +75,80 @@ test_user_branches() {
 	perf script -i "$TMPDIR/perf.data" --fields brstack | \
 		tr ' ' '\n' > "$TMPDIR/perf.script"
 
-	# There should be no kernel addresses with the u option, in either
-	# source or target addresses.
-	if grep -E -m1 "0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
-		echo "ERROR: Kernel address found in user mode"
+	# There should be no kernel addresses in the target with the u option.
+	if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[89a-f][0-9a-f]{15}/" $TMPDIR/perf.script; then
+		echo "Testing user branch stack sampling [Failed kernel address found in user mode]"
 		err=1
 	fi
 	# some branch types are still not being tested:
 	# IND COND_CALL COND_RET SYSRET SERROR NO_TX
+	if [ $err -eq 0 ]; then
+		echo "Testing user branch stack sampling [Passed]"
+		err=$start_err
+	else
+		echo "Testing user branch stack sampling [Failed]"
+	fi
 }
 
 test_trap_eret_branches() {
 	echo "Testing trap & eret branches"
+
 	if ! is_arm64; then
-		echo "skip: not arm64"
+		echo "Testing trap & eret branches [Skipped not arm64]"
+		return
+	fi
+	start_err=$err
+	err=0
+	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u,k -- \
+		perf test -w traploop 1000 > "$TMPDIR/record.txt" 2>&1
+	perf script -i $TMPDIR/perf.data --fields brstacksym | \
+		tr ' ' '\n' > $TMPDIR/perf.script
+
+	# BRBINF<n>.TYPE == TRAP are mapped to PERF_BR_IRQ by the BRBE driver
+	check_branches "^trap_bench\+[^ ]+/[^ ]/IRQ/"
+	check_branches "^[^ ]+/trap_bench\+[^ ]+/ERET/"
+	if [ $err -eq 0 ]; then
+		echo "Testing trap & eret branches [Passed]"
+		err=$start_err
 	else
-		perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u,k -- \
-			perf test -w traploop 1000
-		perf script -i $TMPDIR/perf.data --fields brstacksym | \
-			tr ' ' '\n' > $TMPDIR/perf.script
-
-		# BRBINF<n>.TYPE == TRAP are mapped to PERF_BR_IRQ by the BRBE driver
-		check_branches "^trap_bench\+[^ ]+/[^ ]/IRQ/"
-		check_branches "^[^ ]+/trap_bench\+[^ ]+/ERET/"
+		echo "Testing trap & eret branches [Failed]"
 	fi
 }
 
 test_kernel_branches() {
-	echo "Testing that k option only includes kernel source addresses"
+	echo "Testing kernel branch sampling"
 
-	if ! perf record --branch-filter any,k -o- -- true > /dev/null; then
-		echo "skip: not enough privileges"
+	if ! perf record --branch-filter any,k -o- -- true > "$TMPDIR/record.txt" 2>&1; then
+		echo "Testing that k option [Skipped not enough privileges]"
+		return
+	fi
+	start_err=$err
+	err=0
+	perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
+		perf bench syscall basic --loop 1000 > "$TMPDIR/record.txt" 2>&1
+	perf script -i $TMPDIR/perf.data --fields brstack | \
+		tr ' ' '\n' > $TMPDIR/perf.script
+
+	# Example of branch entries:
+	#       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
+	# Source addresses come first in user or kernel code. Next is the target
+        # address that must be in the kernel.
+
+	# Look for source addresses with top bit set
+	if ! grep -q -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
+		echo "Testing kernel branch sampling [Failed kernel branches missing]"
+		err=1
+	fi
+	# Look for no target addresses without top bit set
+	if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{0,15}/" $TMPDIR/perf.script; then
+		echo "Testing kernel branch sampling [Failed user branches found]"
+		err=1
+	fi
+	if [ $err -eq 0 ]; then
+		echo "Testing kernel branch sampling [Passed]"
+		err=$start_err
 	else
-		perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
-			perf bench syscall basic --loop 1000
-		perf script -i $TMPDIR/perf.data --fields brstack | \
-			tr ' ' '\n' > $TMPDIR/perf.script
-
-		# Example of branch entries:
-		#       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
-		# Source addresses come first and target address can be either
-		# userspace or kernel even with k option, as long as the source
-		# is in kernel.
-
-		#Look for source addresses with top bit set
-		if ! grep -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
-			echo "ERROR: Kernel branches missing"
-			err=1
-		fi
-		# Look for no source addresses without top bit set
-		if grep -E -m1 "^0x[0-7][0-9a-f]{0,15}" $TMPDIR/perf.script; then
-			echo "ERROR: User branches found with kernel filter"
-			err=1
-		fi
+		echo "Testing kernel branch sampling [Failed]"
 	fi
 }
 
@@ -136,14 +159,15 @@ test_filter() {
 	test_filter_expect=$2
 
 	echo "Testing branch stack filtering permutation ($test_filter_filter,$test_filter_expect)"
-	perf record -o "$TMPDIR/perf.data" --branch-filter "$test_filter_filter,save_type,u" -- ${TESTPROG}  > "$TMPDIR/record.txt" 2>&1
+	perf record -o "$TMPDIR/perf.data" --branch-filter "$test_filter_filter,save_type,u" -- \
+		${TESTPROG}  > "$TMPDIR/record.txt" 2>&1
 	perf script -i "$TMPDIR/perf.data" --fields brstack > "$TMPDIR/perf.script"
 
 	# fail if we find any branch type that doesn't match any of the expected ones
 	# also consider UNKNOWN branch types (-)
 	if [ ! -s "$TMPDIR/perf.script" ]
 	then
-		echo "Empty script output"
+		echo "Testing branch stack filtering [Failed empty script output]"
 		err=1
 		return
 	fi
@@ -154,26 +178,36 @@ test_filter() {
 	  > "$TMPDIR/perf.script-filtered" || true
 	if [ -s "$TMPDIR/perf.script-filtered" ]
 	then
-		echo "Unexpected branch filter in script output"
+		echo "Testing branch stack filtering [Failed unexpected branch filter]"
 		cat "$TMPDIR/perf.script"
 		err=1
 		return
 	fi
+	echo "Testing branch stack filtering [Passed]"
 }
 
 test_syscall() {
 	echo "Testing syscalls"
 	# skip if perf doesn't have enough privileges
-	if ! perf record --branch-filter any,k -o- -- true > /dev/null; then
-		echo "skip: not enough privileges"
+	if ! perf record --branch-filter any,k -o- -- true > "$TMPDIR/record.txt" 2>&1; then
+		echo "Testing syscalls [Skipped: not enough privileges]"
+		return
+	fi
+	start_err=$err
+	err=0
+	perf record -o $TMPDIR/perf.data --branch-filter \
+		any_call,save_type,u,k -c 10007 -- \
+		perf bench syscall basic --loop 8000  > "$TMPDIR/record.txt" 2>&1
+	perf script -i $TMPDIR/perf.data --fields brstacksym | \
+		tr ' ' '\n' > $TMPDIR/perf.script
+
+	check_branches "getppid[^ ]*/SYSCALL/"
+
+	if [ $err -eq 0 ]; then
+		echo "Testing syscalls [Passed]"
+		err=$start_err
 	else
-		perf record -o $TMPDIR/perf.data --branch-filter \
-			any_call,save_type,u,k -c 10000 -- \
-			perf bench syscall basic --loop 1000
-		perf script -i $TMPDIR/perf.data --fields brstacksym | \
-			tr ' ' '\n' > $TMPDIR/perf.script
-
-		check_branches "getppid[^ ]*/SYSCALL/"
+		echo "Testing syscalls [Failed]"
 	fi
 }
 set -e
-- 
2.53.0.1213.gd9a14994de-goog

