Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C757274641
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 06:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775628190; cv=none; b=GUQNEhNdyc6XYctw0FVlqXdghURQi9wcFBGWUoWNXMZwxljrlvbLrb1b08gTpK5Y18vvHmOa7u/vezCmKcOu68lmZV1z4BOiVs5Npa2JKtw/XXAx4tpJPyTLbfAjUQW7m6nka0spfsUc1lj7UMh93ZWe/LIb1IGhVjgR0SQOw3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775628190; c=relaxed/simple;
	bh=SqUkCtssHZjtchenMmI9MGEG7Qjfea2+lCP+ptgqA5U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=nEIBYYE9R2J1HZwSzosBYlzIPtblwFi7PCYSRZgbRHqutTKrDMhyJEwdduL9oqJXdtNIHTf6awXiuGn8C5gPxcB+Q+icFu5i8MuxU/cONXjoHQQwaaAjqAsqGU1j7Y0SPxV/HvvA2ynqPhAJ8V6P2hK56udEGyZyR3V+EYeewQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJleSMka; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJleSMka"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128ba70cc99so6455289c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 23:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775628187; x=1776232987; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jCCEcPHnXw3tpU3CVkAF4Y3JSMJwwYfcpaRRv7MH8gM=;
        b=hJleSMkanoHNjPDcQSA+r27MSSv+g8BPoQNNMruuPe7UQ1whpA93FTBnjwinIezFtP
         O7Bu4lVGygjbyk3ChNW3nykGcTlInFlFKQ8zVl+ebNUecnPYkEIB9cCxojUP/B0qt1QH
         8aDkCV88F6cDNGQAQA2tWC6SSSJ8+bscLl5gdDOKte4NtCpXobzoHtaE3ap0CBH+rWja
         NHt12af6Qbi4LlOPiItXjJnrG+HdgO0KQj8Y/sj/JHt2nryyO0CS+BVc/+o16zh4v+Lv
         F74buSqmtZ+v8EIYr+kI2NMvWU+SfbfJjDj2ZEPeu/mbgRDYdNcrQWy5d0f+3Cr71Y2Z
         Dt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775628187; x=1776232987;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCCEcPHnXw3tpU3CVkAF4Y3JSMJwwYfcpaRRv7MH8gM=;
        b=diNHcivWg7Zg3k21bt/+4cZ+V4CbJLzDITFInYHSIvN/yM2SNCWUTieig8oM+U42g8
         iU/RVZMeMcMdJ8Iaa/KT2YkGmG5Hq4Tz0bnO1h/sVqIEowRREBGmPqNZKB7eu7ga4AFX
         t+LxRlb+idImaFIqucUb17QSMtpZvngfltUJ0cQp43QM93+amcjXR2/+UiiQnGOe+dnI
         ETZ+8ubSll1bFH8Ma0ahuoHAi4qBVmR8lAQKLbpANHVHEN52BR7n8GVx8K4jcDSfbEi8
         JMNPQKDunFrV8v+lsauUozdaDnDQd2LwJOxxOiO9BwVq19mad6JVxHhEKKznLR2F+GjQ
         xbHA==
X-Forwarded-Encrypted: i=1; AJvYcCV22iz1BY1z7q8ssuxTPgatPAGma7BlBeJ7/2ziZisvwa0C134eKDJX+MFFVmlkTlHfvYJ0khNySMyAzU+4C92k@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzrMk/vq8VSHTaUVnvDOI/TCL1dGxZ+kMibjJUR6MOLGLj9tk
	aMjoroTrO2zQd2Imja++18M7VDSZo2B7cguSHLte46/4grJX5ifpqCuGh8IAbYDOy4vJHmvEJ1/
	nTgJmWA+YcA==
X-Received: from dlbvt4.prod.google.com ([2002:a05:7022:3f84:b0:12a:8225:c504])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:52b:b0:12b:ee7b:51ec
 with SMTP id a92af1059eb24-12bfb6ed64amr10533193c88.1.1775628186984; Tue, 07
 Apr 2026 23:03:06 -0700 (PDT)
Date: Tue,  7 Apr 2026 23:03:03 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408060303.51231-1-irogers@google.com>
Subject: [PATCH v1] perf test: Fixes for check branch stack sampling
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
 tools/perf/tests/shell/test_brstack.sh | 122 ++++++++++++++++---------
 1 file changed, 78 insertions(+), 44 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 85233d435be6..d317ed0e063e 100755
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
 
@@ -73,59 +75,81 @@ test_user_branches() {
 	perf script -i "$TMPDIR/perf.data" --fields brstack | \
 		tr ' ' '\n' > "$TMPDIR/perf.script"
 
-	# There should be no kernel addresses with the u option, in either
-	# source or target addresses.
-	if grep -E -m1 "0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
-		echo "ERROR: Kernel address found in user mode"
+	# There should be no kernel addresses in the target with the u option.
+	if grep -q -E -m1 "^0x[0-9a-f]{16}/[89a-f][0-9a-f]{15}/" $TMPDIR/perf.script; then
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
+		perf test -w traploop 1000
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
 	echo "Testing that k option only includes kernel source addresses"
 
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
+	# Source addresses come first and target address can be either
+	# userspace or kernel even with k option, as long as the source
+	# is in kernel.
+
+	# Look for source addresses with top bit set
+	if ! grep -q -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
+		echo "Testing that k option [Failed kernel branches missing]"
+		err=1
+	fi
+	# Look for no target addresses without top bit set
+	if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{0,15}/" $TMPDIR/perf.script; then
+		echo "Testing that k option [Failed user branches found with kernel filter"
+		err=1
+	fi
+	if [ $err -eq 0 ]; then
+		echo "Testing that k option [Passed]"
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
+		echo "Testing that k option [Failed]"
 	fi
 }
 
@@ -136,14 +160,15 @@ test_filter() {
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
@@ -154,27 +179,36 @@ test_filter() {
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
+	start_err=$err
+	err=0
 	# skip if perf doesn't have enough privileges
-	if ! perf record --branch-filter any,k -o- -- true > /dev/null; then
-		echo "skip: not enough privileges"
+	if ! perf record --branch-filter any,k -o- -- true > "$TMPDIR/record.txt" 2>&1; then
+		echo "Testing syscalls [Skipped: not enough privileges]"
 	else
 		perf record -o $TMPDIR/perf.data --branch-filter \
-			any_call,save_type,u,k -c 10000 -- \
-			perf bench syscall basic --loop 1000
+			any_call,save_type,u,k -c 10007 -- \
+			perf bench syscall basic --loop 8000  > "$TMPDIR/record.txt" 2>&1
 		perf script -i $TMPDIR/perf.data --fields brstacksym | \
 			tr ' ' '\n' > $TMPDIR/perf.script
 
 		check_branches "getppid[^ ]*/SYSCALL/"
 	fi
+	if [ $err -eq 0 ]; then
+		echo "Testing syscalls [Passed]"
+		err=$start_err
+	else
+		echo "Testing syscalls [Failed]"
+	fi
 }
 set -e
 
-- 
2.53.0.1213.gd9a14994de-goog

