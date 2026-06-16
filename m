Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408883D903A
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590471; cv=none; b=Tj6nTgOVYgtpnfU5Jvu6c8OU2692/Gjbk6xYEkLaZrYMiLb2bHlBqrAflL9CC8pekIcZESjwUgH6WyDmPaBvQXtvmKWjntqosVPDfObTGYCHl9E0XTiQPXXV+ZgaFo+IgnjdVcJmtt0v2wIzKpmykaShu/8OcGU6iXTq1kiJmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590471; c=relaxed/simple;
	bh=kLGmkyB1pBsMp6ifHn+49KVvWcjvKZrFfv68kgIdZoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fZE9dw3lsS7k98B6NPy3dQ7hDk/7nWDL6fZ6FoyjxL+z2ZJ3d+4tq0fwAA6scTDf6yA99mLxLt2u5NjzOOdTBiaAqK2MKirCFYGSrv33reYjZUKG6MI/TtYNu++Pf5aV5QD4kUSAjKGy5BiRLZkutTGCEOMtu4sQaJyf89+EdfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aqQXRE+1; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqQXRE+1"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3074d4102a9so11855188eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781590466; x=1782195266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVI6jvfk6d9EL/ENbwXNBwXF++3mwFN65akUydTqkcI=;
        b=aqQXRE+107FVpbPtQfD8Sae7gfF11koxOHCeDixCew+a1a4ple16U7znlYCMsgFbv8
         a87sVJgAda2Ct2hPxdmFxqcFyb4jo5t25jwq3qISlmt7mhR2BiHd3qXf/Mjj7mA//Q3p
         yZlhBOJdES5VeMSeYtlOtFJDW3BRb1duxo33mXvSzevbYR9+G7x+LRbLDy5v4BgF4DSk
         Jh9qbfUZvtLM1snzpIk4OQVOWku+xALdYZJbMegpiKrwe82yEbe4AjdVYfWqnniCmec8
         YHmVfOyYedmBpjmhphr/pERfVySqCR6BuvHuxiVKXa6chqDi6jo9SuARFvOojpQFvZhV
         h4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590466; x=1782195266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVI6jvfk6d9EL/ENbwXNBwXF++3mwFN65akUydTqkcI=;
        b=F1sJRMITBEs6EIupBi5K4LtE3bvgiR22Sx1yfIixZF2Euq+fF+d4wYd6A+ce0s/Hf0
         klK4tK4BGzoB35FotqRgBGJ6LrPCvooI3IN7PiVJ33upE7usx09aeOCzJs5rfB8H8rEJ
         VQadnVtsSY5g3XJ449F857N55YehMy9g4JbFAb5vsWhpqqi2cOx9u+p+P8QQL7j90fgi
         SSCxt0MCM+QSLWVBm7ws++bHP7RwtZ7BiDcJhuFJPPOEhoYOMORHMvZpgK2Qc3SN8nRX
         AJZA4qZl0CoN2LfZAQgypK/x6zZgS+5JZPM84zNLrAfX57ew9ttuaHDThB+87MlLhZ0t
         xBpA==
X-Forwarded-Encrypted: i=1; AFNElJ8PGN8f7Uxfhlm0GzV7Iq+9a/GwHYEos33eCManHmS+Rzk9ppWtEMlzwm4oxNzJQ/tJwc3dX+vZpQDZK64tqvKg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+W5L3DkMtZBiNzpRu3C1mz/y7DmovdLjpyeY5AUvjHUTUJ3S
	TksTgQvt8McGYREljPy42Z3Jhs8+vphxOxyV0piFdyC4+nOagVOVNCWnmAVilnBT/MeiORaQ6u0
	dHXwNeRclrw==
X-Received: from dybmw17.prod.google.com ([2002:a05:7300:cd91:b0:30b:96b8:80b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e7a5:b0:2ef:8b91:212
 with SMTP id 5a478bee46e88-3081ffb0498mr9929621eec.14.1781590466019; Mon, 15
 Jun 2026 23:14:26 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:14:01 -0700
In-Reply-To: <20260616061404.41929-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com> <20260616061404.41929-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616061404.41929-10-irogers@google.com>
Subject: [PATCH v2 09/12] perf tests: Fix flakiness in branch stack sampling tests
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The branch stack sampling test (test 130) runs short iteration-based
workloads to verify syscall, kernel, and trap branch stack sampling.
Specifically, `test_syscall()` and `test_kernel_branches()` run
`perf bench syscall basic` with loop counts of 8000 and 1000, and
`test_trap_eret_branches()` runs `traploop` with 1000 iterations.

Because these loop limits are extremely small, the total benchmark runtimes
last only a few milliseconds (or less). Under high load, virtualization,
or coarse sampling conditions, PMU cycle sampling fails to capture enough
samples inside the brief benchmark loops. This leads to false negatives
where the script output lacks the expected syscall, kernel, or trap branch
entries (e.g. "ERROR: Branches missing getppid[^ ]*/SYSCALL/").

Fix this by increasing the workload loop counts to 100,000 across all
three test sections. Running 100,000 loops still finishes virtually
instantaneously (less than 0.1 seconds), but generates enough iterations
to guarantee robust branch stack capture.

Fixes: b55878c90ab9 ("perf test: Add test for branch stack sampling")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_brstack.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index eb5837f82e39..be46a68daf76 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -112,7 +112,7 @@ test_trap_eret_branches() {
 	start_err=$err
 	err=0
 	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u,k -- \
-		perf test -w traploop 1000 > "$TMPDIR/record.txt" 2>&1
+		perf test -w traploop 100000 > "$TMPDIR/record.txt" 2>&1
 	perf script -i $TMPDIR/perf.data --fields brstacksym | \
 		tr ' ' '\n' > $TMPDIR/perf.script
 
@@ -137,7 +137,7 @@ test_kernel_branches() {
 	start_err=$err
 	err=0
 	perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
-		perf bench syscall basic --loop 1000 > "$TMPDIR/record.txt" 2>&1
+		perf bench syscall basic --loop 100000 > "$TMPDIR/record.txt" 2>&1
 	perf script -i $TMPDIR/perf.data --fields brstack | \
 		tr ' ' '\n' > $TMPDIR/perf.script
 
@@ -209,7 +209,7 @@ test_syscall() {
 	err=0
 	perf record -o $TMPDIR/perf.data --branch-filter \
 		any_call,save_type,u,k -c 10007 -- \
-		perf bench syscall basic --loop 8000  > "$TMPDIR/record.txt" 2>&1
+		perf bench syscall basic --loop 100000  > "$TMPDIR/record.txt" 2>&1
 	perf script -i $TMPDIR/perf.data --fields brstacksym | \
 		tr ' ' '\n' > $TMPDIR/perf.script
 
-- 
2.54.0.1136.gdb2ca164c4-goog

