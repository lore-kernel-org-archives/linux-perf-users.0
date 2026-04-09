Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150640DFBD
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775692944; cv=none; b=nBkvUsm7tlrqgefV/RLX0dtl7rxmu7l5+2XEguHwZ4GObib3xv2ojlB9bCXeI0QEHBCBvk4KfL1ZrjgASm/Bh6i8mWq5TdzZKYF1rIRd/BVWzbSFUktpE1G8gJS7PC5ScTvDNNxWwkc3TY5Y1lB+MKL57PsJU1LwWSZgEp6Aje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775692944; c=relaxed/simple;
	bh=xtZT6jWz/NdPjKHL5D/uPuJbnI/ZL806oDT2ganbFLc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dgkvYeiqnwSTrhxnASqa9eUi8HYvLSzE4EzhZoV1R6sVldYBxIDTNog5UlMOxQ8AcKkQfRhmlhlb+LuBUH7hPF7BJsYnh8WA4hcAw7PyngSUWArZQ9/di81DXn1absIR2cf//6RqVCEjcnPmvRMjiG4bh65Gi6W2yAPCTYrJoLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gpxdRKAa; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpxdRKAa"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82cf0130d17so325808b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 17:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775692942; x=1776297742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=spcypqH9luxeMnySjiMhFj/Ht5EwbIf6/33hdACP4b8=;
        b=gpxdRKAawW57dO54/BtDvT4/oETru2zZikqDLTvMBnoEUnLlrB6qfm3gVcQM3PEpcM
         O1gQGb5gEWp6MfZXf+LQVkp1lYLXNsPHfiSWhQxTwY+xPdEQSCS9wfBeSrERlJxXAEGX
         nVkHlk+4cao3o62pBv0/lomlj0wm9qAFfnSg08ZHGf2vFb5+6eIxT5uex0mLID/oSHOp
         g8z20qU7UNx+Tu4TBgOT8ph5tNdRRgCBWfSzuWsQIt+JTOWGXl4BuJUGOUnMjkGbiQ/b
         jr0qeqh2Jw3BYsIuwb7QhBiqOgW1XIFcdj5PY+2WZi1t7yIPo83Bik0zoaITDZGZyOt0
         0WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775692942; x=1776297742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spcypqH9luxeMnySjiMhFj/Ht5EwbIf6/33hdACP4b8=;
        b=aWUXz5qcmrV+ERGVy9OcXQoAWcTZbtkAn2VWjI/S9h3hAehbKsEmwlBqxNt4phJ3pj
         0cLUzSpzEh8zwzukYzY7X41/4XEDezTZSGxTNPngYuBuKpN3U3mNWILHBDpKS2cRgJN+
         G+9PSWCf9BXKhDKY6RBEXi6UKswo4mpIt9+WmCJLrnZDfW/QWIjNJCLYn1QxqYLkDyZI
         SN+tsJeAsg+rj3h7LKNN/JkwhAAl09KiYtDe8HuYKHpNDK9KnAtjRmmmYWtsFsLePpX+
         eY88v2ZbIrRtSite4X92Fl2Q+cThKKd+SqzFKSZJ1f7/DD2V3VANrudgok3EQT+QtPaB
         ARmw==
X-Forwarded-Encrypted: i=1; AJvYcCWQhEBppSyzisAsX2s93B6BaOIGM3CJRyDP7TzG/gZ2Pf3Mt4NOGvicdnU0BfLAlaxj3ZIwqXaNTs6tCgJ8+B+p@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5f4xOyrBChg8y3j1tRydqf3OzntVcaGvEaw/zGbzNp5STYUa8
	34oKuU4Oid/1Qa/Zm9aV+HAJinwsaPLGrLxdGpQA6y4fcxeAUipGqI16Zhfs/auuU51TIC/KMaV
	xTJz2pMYZEg==
X-Received: from pfbid9.prod.google.com ([2002:a05:6a00:8a89:b0:829:7bc1:d9bd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9509:b0:82c:e1a0:3453
 with SMTP id d2e1a72fcca58-82dd8a92047mr1596319b3a.26.1775692941945; Wed, 08
 Apr 2026 17:02:21 -0700 (PDT)
Date: Wed,  8 Apr 2026 17:02:16 -0700
In-Reply-To: <CAP-5=fUgSTa1+m6PXLm6JSxTcvEbZymwwDKqiV_X+OwcKXga9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fUgSTa1+m6PXLm6JSxTcvEbZymwwDKqiV_X+OwcKXga9A@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409000216.196083-1-irogers@google.com>
Subject: [PATCH v4] perf test: Fixes for check branch stack sampling
From: Ian Rogers <irogers@google.com>
To: james.clark@linaro.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, german.gomez@arm.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When filtering branch stack samples on user events they sample in user
land but may have come from the kernel. Aarch64 avoids leaking the
kernel address for kaslr reasons but other platforms, for now,
don't. Be more permissive in allowing kernel addresses in the source
of user branch stacks.

When filtering branch stack samples on kernel events they sample in
kernel land but may have come from user land. Avoid the target being a
user address but allow the source to be in user land. Aarch64 may not
leak the user land addresses (making them 0) but other platforms
do. As the kernel address sampling implies privelege, just allow this.

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
v4: Address feedback from James Clark.
v2,v3: Address Sashiko feedback.
---
 tools/perf/tests/shell/test_brstack.sh | 146 ++++++++++++++++---------
 1 file changed, 96 insertions(+), 50 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 85233d435be6..eb5837f82e39 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -38,9 +38,13 @@ is_arm64() {
 	[ "$(uname -m)" = "aarch64" ];
 }
 
+has_kaslr_bug() {
+	[ "$(uname -m)" != "aarch64" ];
+}
+
 check_branches() {
 	if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$1"; then
-		echo "Branches missing $1"
+		echo "ERROR: Branches missing $1"
 		err=1
 	fi
 }
@@ -48,6 +52,8 @@ check_branches() {
 test_user_branches() {
 	echo "Testing user branch stack sampling"
 
+	start_err=$err
+	err=0
 	perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u -- ${TESTPROG} > "$TMPDIR/record.txt" 2>&1
 	perf script -i "$TMPDIR/perf.data" --fields brstacksym > "$TMPDIR/perf.script"
 
@@ -73,59 +79,88 @@ test_user_branches() {
 	perf script -i "$TMPDIR/perf.data" --fields brstack | \
 		tr ' ' '\n' > "$TMPDIR/perf.script"
 
-	# There should be no kernel addresses with the u option, in either
-	# source or target addresses.
-	if grep -E -m1 "0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
-		echo "ERROR: Kernel address found in user mode"
+	# There should be no kernel addresses in the target with the u option.
+	local regex="0x[89a-f][0-9a-f]{15}"
+	if has_kaslr_bug; then
+		# If the system has a kaslr bug that may leak kernel addresses
+		# in the source of something like an ERET/SYSRET. Make the regex
+		# more specific and just check the target address is in user
+		# code.
+		regex="^0x[0-9a-f]{0,16}/0x[89a-f][0-9a-f]{15}/"
+	fi
+	if grep -q -E -m1 "$regex" $TMPDIR/perf.script; then
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
+	# address that must be in the kernel.
+
+	# Look for source addresses with top bit set
+	if ! grep -q -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
+		echo "Testing kernel branch sampling [Failed kernel branches missing]"
+		err=1
+	fi
+	# Look for no target addresses without top bit set
+	if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{1,15}/" $TMPDIR/perf.script; then
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
 
@@ -136,14 +171,15 @@ test_filter() {
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
@@ -154,26 +190,36 @@ test_filter() {
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

