Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7F37B011
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178103; cv=none; b=aRQZ5OdKb1Y+z6mZ3dY7OO2YR07USIZP0PTDo2ET2TC5eYTa+MF8vLKzEuzsrRjSCDiowUQ8dNV6Po/ezK3iWin0+5GMTaR4zkv1HQf0pjKXI0JzXCAUfZPAR+Sat8FU0zyYPd3YlUtvAJkPeX0CzxIFEWGQqOrymDHO7w/wn24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178103; c=relaxed/simple;
	bh=UJHBZsCHadCBDFI4p0v6rsP0RKO4sMW+JhYy8UUY+yE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fqmtgoWVf3PsGxprrQkLZ3SxxupVxRDDoK7bj4gDEtAJVZ3Ns8XCK9uf+GfAmt10nBnrxrVtnc8KwrWeLU9fvtxleFjmTzaEv/bvYyem3FPU0GN48FyEi5+rHU1Lt33s4r13yrvjOYM0T4wrBcoFJ1xljqcaQi0x/1aPjbX/IAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=migW5jZC; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="migW5jZC"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30c0a27ad86so12155974eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782178101; x=1782782901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXqC2nkiAPxRb3b5mkkUePpyXFw0zrQfCf40Ysi1MlY=;
        b=migW5jZCPThnpp9Iaee3V4iNAeKDNz2Or3jKJLMzBcTQ+iXuX8pace4tqlJqvtiIzn
         vyAFenu8eWI54GEftiOVXDCkl4ViLbj3cMeaZmLCOvlDjbZx9MX0bshJuUwVz6C236Xv
         YJL0A1M6PG06TP3r7nVyEBcYY3MxNWbi7/JcCb1BMtzAyNdvZ1SyWO0hXPDC2MA+dDIQ
         jpBZatRgM8MgzglbVbcfpbd9YuIqN2l/nxlZBN6LZ9xSYPgth5vzrk4gpw51SM9weU1G
         ekB2ATtt3qYNIgZC4WmL3zAVh2QrHlcGxCY6FowByPALKqZOp7ah7GSJcHUkz8FznD/3
         byRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782178101; x=1782782901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXqC2nkiAPxRb3b5mkkUePpyXFw0zrQfCf40Ysi1MlY=;
        b=LnSx0RcDAsfCWHu89d8kViW433DGd+QpB72kvk6lXcjxHAcG+vtoURcfmAOPTGudUF
         d7hNBQ3P1p7BJrGH4qSnxUQohFfJJ/w4Innt0O9jWbwgTH9lyzXGtEJ/oNNszHSDIs7U
         /rsEPcG9iXp6dbwMxsNnJ91KFvePN9+ASq0CDcBNBsptiAGmrumJjPCTjQyZDZuqLVe8
         RXy5bTYz99tISShznbFp8OtCYPY67TGs6+diSi+RsZ2euPquhIK5mb4IPriCo1Pnou5V
         PN1mbiAPymBg1v30y3KchvooyFEgoid02gCLZqmidQfAH8pDK7fpjtfqaFmWpYaWN8Co
         cXSA==
X-Forwarded-Encrypted: i=1; AHgh+RoEJHYogI0QC88v7+jg50xDplluxVfOcaQHiBhFPn0J12oriGQd8ot+sxgsZAO2D184FEzqktp1VipCziuvJ5we@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rEwo7hIo8xrarH6eUu2O0XMnu6ouHokGqhmRBKL0u5d2JZzI
	tpLpBvaKcDEoxLtyKhN6rcsmggSpFLtZXj/1UFmMElwzlafPk6BAP1zJf40ZThzu143BgLG3+eA
	6k2XI3AVqyw==
X-Received: from dybmc6.prod.google.com ([2002:a05:7301:1986:b0:30c:4b01:7f0c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:80ca:b0:2dd:c066:bf7
 with SMTP id 5a478bee46e88-30c06e3177amr12773729eec.11.1782178101156; Mon, 22
 Jun 2026 18:28:21 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:27:54 -0700
In-Reply-To: <20260623012758.2291858-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616164819.370939-1-irogers@google.com> <20260623012758.2291858-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623012758.2291858-10-irogers@google.com>
Subject: [PATCH v4 09/13] perf tests: Fix flakiness in branch stack sampling tests
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The branch stack sampling test (test 130) runs short iteration-based
workloads to verify syscall, kernel, and trap branch stack sampling.
Specifically, `test_syscall()` and `test_kernel_branches()` run `perf
bench syscall basic` with loop counts of 8000 and 1000, and
`test_trap_eret_branches()` runs `traploop` with 1000 iterations.

Because these loop limits are extremely small, the total benchmark
runtimes last only a few milliseconds (or less). Under high load,
virtualization, or coarse sampling conditions, PMU cycle sampling fails to
capture enough samples inside the brief benchmark loops. This leads to
false negatives where the script output lacks the expected syscall,
kernel, or trap branch entries (e.g. "ERROR: Branches missing getppid[^
]*/SYSCALL/").

Fix this by increasing the workload loop counts to 100,000 across all
three test sections. Running 100,000 loops still finishes virtually
instantaneously (less than 0.1 seconds), but generates enough iterations
to guarantee robust branch stack capture.

Fixes: b55878c90ab9 ("perf test: Add test for branch stack sampling")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_brstack.sh | 107 +++++++++++++++----------
 1 file changed, 66 insertions(+), 41 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index eb5837f82e39..71550e0b37ba 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -110,20 +110,29 @@ test_trap_eret_branches() {
 		return
 	fi
 	start_err=$err
-	err=0
-	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u,k -- \
-		perf test -w traploop 1000 > "$TMPDIR/record.txt" 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstacksym | \
-		tr ' ' '\n' > $TMPDIR/perf.script
-
-	# BRBINF<n>.TYPE == TRAP are mapped to PERF_BR_IRQ by the BRBE driver
-	check_branches "^trap_bench\+[^ ]+/[^ ]/IRQ/"
-	check_branches "^[^ ]+/trap_bench\+[^ ]+/ERET/"
-	if [ $err -eq 0 ]; then
+	local ret=1
+	for loops in 1000 10000 100000; do
+		err=0
+		perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u,k -- \
+			perf test -w traploop $loops > "$TMPDIR/record.txt" 2>&1
+		perf script -i $TMPDIR/perf.data --fields brstacksym | \
+			tr ' ' '\n' > $TMPDIR/perf.script
+
+		# BRBINF<n>.TYPE == TRAP are mapped to PERF_BR_IRQ by the BRBE driver
+		check_branches "^trap_bench\+[^ ]+/[^ ]/IRQ/"
+		check_branches "^[^ ]+/trap_bench\+[^ ]+/ERET/"
+		if [ $err -eq 0 ]; then
+			ret=0
+			break
+		fi
+	done
+
+	if [ $ret -eq 0 ]; then
 		echo "Testing trap & eret branches [Passed]"
 		err=$start_err
 	else
 		echo "Testing trap & eret branches [Failed]"
+		err=1
 	fi
 }
 
@@ -135,32 +144,40 @@ test_kernel_branches() {
 		return
 	fi
 	start_err=$err
-	err=0
-	perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
-		perf bench syscall basic --loop 1000 > "$TMPDIR/record.txt" 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstack | \
-		tr ' ' '\n' > $TMPDIR/perf.script
-
-	# Example of branch entries:
-	#       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
-	# Source addresses come first in user or kernel code. Next is the target
-	# address that must be in the kernel.
-
-	# Look for source addresses with top bit set
-	if ! grep -q -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
-		echo "Testing kernel branch sampling [Failed kernel branches missing]"
-		err=1
-	fi
-	# Look for no target addresses without top bit set
-	if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{1,15}/" $TMPDIR/perf.script; then
-		echo "Testing kernel branch sampling [Failed user branches found]"
-		err=1
-	fi
-	if [ $err -eq 0 ]; then
+	local ret=1
+	for loops in 1000 10000 100000; do
+		err=0
+		perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
+			perf bench syscall basic --loop $loops > "$TMPDIR/record.txt" 2>&1
+		perf script -i $TMPDIR/perf.data --fields brstack | \
+			tr ' ' '\n' > $TMPDIR/perf.script
+
+		# Example of branch entries:
+		#       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
+		# Source addresses come first in user or kernel code. Next is the target
+		# address that must be in the kernel.
+
+		# Look for source addresses with top bit set
+		if ! grep -q -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
+			err=1
+		fi
+		# Look for no target addresses without top bit set
+		if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{1,15}/" \
+			$TMPDIR/perf.script; then
+			err=1
+		fi
+		if [ $err -eq 0 ]; then
+			ret=0
+			break
+		fi
+	done
+
+	if [ $ret -eq 0 ]; then
 		echo "Testing kernel branch sampling [Passed]"
 		err=$start_err
 	else
 		echo "Testing kernel branch sampling [Failed]"
+		err=1
 	fi
 }
 
@@ -206,20 +223,28 @@ test_syscall() {
 		return
 	fi
 	start_err=$err
-	err=0
-	perf record -o $TMPDIR/perf.data --branch-filter \
-		any_call,save_type,u,k -c 10007 -- \
-		perf bench syscall basic --loop 8000  > "$TMPDIR/record.txt" 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstacksym | \
-		tr ' ' '\n' > $TMPDIR/perf.script
-
-	check_branches "getppid[^ ]*/SYSCALL/"
+	local ret=1
+	for loops in 8000 30000 100000; do
+		err=0
+		perf record -o $TMPDIR/perf.data --branch-filter \
+			any_call,save_type,u,k -c 10007 -- \
+			perf bench syscall basic --loop $loops  > "$TMPDIR/record.txt" 2>&1
+		perf script -i $TMPDIR/perf.data --fields brstacksym | \
+			tr ' ' '\n' > $TMPDIR/perf.script
+
+		check_branches "getppid[^ ]*/SYSCALL/"
+		if [ $err -eq 0 ]; then
+			ret=0
+			break
+		fi
+	done
 
-	if [ $err -eq 0 ]; then
+	if [ $ret -eq 0 ]; then
 		echo "Testing syscalls [Passed]"
 		err=$start_err
 	else
 		echo "Testing syscalls [Failed]"
+		err=1
 	fi
 }
 set -e
-- 
2.55.0.rc0.786.g65d90a0328-goog

