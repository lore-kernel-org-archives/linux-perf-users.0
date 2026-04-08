Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5411335F5EF
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629258; cv=none; b=bMG/nIZVaMXo3zAkr9p9QUQ99JX9iP2NY/5E3dgHd6JLsmVyNYOtma1jb3CcUTiAODOB7sNCM3HgVs2jfq7MEFaMeVesxFrP8nkNAPCBH+ZfCaweDlnIMYjJzem0AOG+Wc1qYMl0jTJBV7+FtwukcAvj7S2UByjt2pgGlI7jnUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629258; c=relaxed/simple;
	bh=vtvR4Gr0eOWh8sh1i4cYGhf8f8/RqHqM+W8idwuYAfg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DnK+z1jFO3NNf132qVyaBQHgi6ST12jAfqewQd0JF70FX+7uvu7iSHdt35Y5Pm2wpHgSmLVfPiaSg458v5Bb2a12wRi7Da8Ao1hkh9oisAy4BMGZc0/OeDQbQFBj5TojxGH5j2OhCBuzWibOkvdGJbtmu5WH12QIomluSM4sdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUhcWUk/; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUhcWUk/"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c72849f648so26943412eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 23:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775629255; x=1776234055; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KayPBT6o8HXCAnyrKdx15QON80ISzX1OOr2KOi1LVXo=;
        b=iUhcWUk/vmaKjrpJz9AOlqqk+QBqYdG+UQATlvDNhs/iEnhjDo2KNGLac9IOE7EPxM
         3XMOqNKqo5hmK2tg4pAylm3zVSAMx9vex9GqAUZWRqlgA4yDt02DD7Hud7FZXeRCyAPa
         TgEbcQ9mW/y2fhIuzpEIKmiL6j6Bzi/hnlqYI3FiAQOL44jPVhmCHURgM7kDbd/ZwDUO
         4zPiCqoPvzuS+m9WMtjKjNt8ptMcjcTAqSJmLxNZ1zoB/0Djjsp9+gPtPkaHMsxPyLMa
         E7MW0TggwPAxZurkMZGlkQjLRRNcH8SN7QuJOQfqerHY4A+0sh+IPvz0OXSkMtKdgs2n
         JnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775629255; x=1776234055;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KayPBT6o8HXCAnyrKdx15QON80ISzX1OOr2KOi1LVXo=;
        b=VejfFPBiiKjzvB1qtH9tw35z5h2UYhQkaF9tRABItZBlH2MDXXZVz2WMZOFtxBqMsO
         VH875/3xMDDhNhj9RUzhsRvVZ1Dpnnn1jQzKQUtZ+IbE43ghvlMjGXw46z08oo1AaQH1
         sOcNojLVc+azMDyXas1uD63ccLP/fNZ8r8oyy4ybFfyEzMRh7vp26kLM8VTZtck3LWul
         Enz5yWRkhIfmC6tbCbi9rxM740Z2ZhN2kVEQ+RkKfIRsSZdKqWhmgx7JbyxobpSpg0zH
         zURD4ogpH+x7+yR3APp4CY1un4ofQd4GuE81LM7vJNi4UyXvZAfuplXkOrpvNOl88GtO
         jYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjfiwdeuYR+XIRgZho22uKfqD6Zm3a16F5PG00PHotOmuqJyQqZ//Z/dHvwTzgHMYWAVyRfkSfMo6tGvOyW7/z@vger.kernel.org
X-Gm-Message-State: AOJu0YzB6m6yG55WNR4iXjcKZgCpkun22cRQKXCajZAm/+uUrrkQkoyA
	kTloOIaCnc7YbKsYMmq/ivbe5+GFqUe9VVcyG7HyJKNpvg3yCayzMoozFGnZ5Mxl/+3Jmywc5m4
	ohufgaSb1Lg==
X-Received: from dyclx4.prod.google.com ([2002:a05:693c:2184:b0:2d1:f2ee:2849])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a483:b0:2d2:129a:1682
 with SMTP id 5a478bee46e88-2d2129a194amr2573263eec.16.1775629255186; Tue, 07
 Apr 2026 23:20:55 -0700 (PDT)
Date: Tue,  7 Apr 2026 23:20:48 -0700
In-Reply-To: <20260408061218.9FFAEC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408061218.9FFAEC19424@smtp.kernel.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408062048.61252-1-irogers@google.com>
Subject: [PATCH v2] perf test: Fixes for check branch stack sampling
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
 tools/perf/tests/shell/test_brstack.sh | 133 ++++++++++++++++---------
 1 file changed, 84 insertions(+), 49 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 85233d435be6..51cd1dcd1855 100755
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
+		echo "Testing that k option [Failed user branches found with kernel filter]"
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
@@ -154,26 +179,36 @@ test_filter() {
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

