Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B4386425
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 04:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786249008; cv=none; b=HBMcsIKjdmRQd7cHez+U4CZfL7xqvtqomPLQKEDqzup586JJ1XEAGcQ0SJFyYvNSG4Pti4NwZfuxI5OUXAp/6kkZ87u9KUP1WcuTb1Ty3Hk8NFVYD4UslOT4nWU/Czkuq+AFQ7tUR8Wk4PuCgxutR1uCQZDtw0QYYSffYGq+3Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786249008; c=relaxed/simple;
	bh=Nn0miRX6O32JQOtPVCr92wiRbgVDw32950L1rvjPbWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I1zYqTzj6zbodv8qS3as9svpiq2cVV2AMJtDMAAYxySa5X1Be9UmZgIqEqeEM+ib0pSb4VrNtVp9t0uk7wH5oKtRe2o3618KUu4aXthdjURANqlJLjpAYwNxnzPTF9kdnrWh0Qcl8v5+MWZO0Cra817wwkObKuYWPCEMXBjiDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+hGkN6p; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+hGkN6p"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cca3673560so18580055ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Aug 2026 21:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786249005; x=1786853805; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fLtFtC/oi2eHemCIy4gg+BvRUETIN+tHfDnRPBDklJg=;
        b=K+hGkN6pNfA4r7zjktVNCLQZdnx25fqYlcxz9V6jYm+21+HCT1LK8mWM7WnrZlQxwV
         XsWUAB9g/6G7129Pyrch6ziQt+AiUMXZ1X8O81bwkcBzRJC/ZP50PQsg8qvsTDEEE1mF
         ACunME8tMhdFDJNyZRQj09hT3QJfFuFwLNu0lMiXVjfttkLq5oYqhvw6kvzpMDAaeiTU
         QIgpFcY0UHcoAYQzTPa2XCRCbI1qKTwPq0KP1aby1qqhzwE+nOFBHiDU04IGs1Is8K3+
         Lt+1Ui6WMh7/wqe1QVi+327yv1D+ugvL4R3b8Pi+G3kc0pJKHFo/kD2eeaHDkIivgRty
         EGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786249005; x=1786853805;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fLtFtC/oi2eHemCIy4gg+BvRUETIN+tHfDnRPBDklJg=;
        b=NZPJnf6N23sw2YbpBhRQOIJokso3ACCUXqmYmGNKUkEN3Am2rcK8hj6Z7Ratq5KgQN
         rK4NKnST0UTqlatd0WVVV5cgv+bwWalvNBl6zm8fwS2chwK61dcg/XRFQRNm8lFyQe90
         fFW5eQHTr3GwJnlnk1rt720d2P0Z2/BlGuop+vOLoQi7Y+PltCG3qOMqS8ZJBQIKFdjt
         fbQnT2AXhbRXc6uHZ8TH/O4RLweKkFu3DjT2W2H/i1aak+Xa8X283UAbIxZMmGz/ExzL
         xnIDY4SO0soCSlnxNLKSp2CAgCyYTvUgs4OTiG1JsnB+7WexoqGi5yFOVv/WPm3jSLlO
         sXyw==
X-Forwarded-Encrypted: i=1; AHgh+Rqfl4LmYHo9TYXrpOW6fVuZbcuklJZIsP3fTHhoFCVPa4N601qN5/d/YHGusrZp+08zv3DKPsfHJ5PEO6Ojbkf/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ql+1BkTaiYTfjYJ49smnIBK25zSlaYo9o59Aa+7+4bi1CR5l
	JSFMoN4xtiqL08z7z8pBBtRUEjq770OpEeT7mHbw4l/2vU7YVCN9jASk+khP/6ltoBQdEpBixBF
	Y4WN7ffCmOA==
X-Received: from dyah27-n2.prod.google.com ([2002:a05:693c:83db:20b0:30f:3f53:35d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea01:b0:2c9:bf82:dd11
 with SMTP id d9443c01a7336-2d0ca71b505mr359738125ad.7.1786249004857; Sat, 08
 Aug 2026 21:16:44 -0700 (PDT)
Date: Sat,  8 Aug 2026 21:16:33 -0700
In-Reply-To: <20260809041638.2402705-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808065743.2328212-1-irogers@google.com> <20260809041638.2402705-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260809041638.2402705-3-irogers@google.com>
Subject: [PATCH v3] perf test: Fixes for check branch stack sampling
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, jolsa@kernel.org, laixintaoo@gmail.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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

