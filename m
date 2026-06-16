Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648F388390
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573289; cv=none; b=U6dOzC+dcBbfH1ygkjvjPHmlE462Kr3MRP8PtJwR4K3+yhA7ShTv/wRGFAANIbDmqXUpCUrSpVBAoUCs14gXjF2noFeuVfxZ0yPsqUy321L+C5DcrfNyy4ljSp0IymbR7Mwc2Xi7BTAIWN5Oil3+tdFzEEDOEtmHtMnmZVy+S6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573289; c=relaxed/simple;
	bh=kLGmkyB1pBsMp6ifHn+49KVvWcjvKZrFfv68kgIdZoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Xau5H/rnNiRKktjMNDr1yNvESnqOY9j3NAJBg5Igl1wBtLEXi64oY38b+XVa42xE6MwXVbdGTG126hDbmj1ENtIKwQyUm9Tsmxkk79HHAGu+V5Kk4ULrZ/URfAw42RsX4DQnFiG5sjhlilFtaaxD7dUIsbDHqx3Ak4qXVfs6+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TaI8VxdP; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TaI8VxdP"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1370417c0bfso2755051c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573288; x=1782178088; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVI6jvfk6d9EL/ENbwXNBwXF++3mwFN65akUydTqkcI=;
        b=TaI8VxdPe9e9131F9/E2Liv8jJYhNBrf0VBvsQ4jnvsx+L/BQqVbWScGoFzqyqYj+T
         MSL99RCkIHjprG0/QzM7aRMLJsXy/tUQl48KY+wytfC+7sfnM8rubOavDa1bwWzrFFHH
         qjS60ifai4XJTxuneiSCJPw5lWKkgbiEMtpvBmK0ZoYRmRXw2RMoMaQAZMLw0ZdgzSqO
         Odu8No/9H/TMSGY3GEw+VJsSytbauukaZ17SXQHKXfh+uOu5IN2bHjYJDR9OCq2LAJL6
         yWafA9H7Is0AKEKSkr/TptuLErNHymo4AUFFKg24zkMYY6sz2IC7rujKXwHpacwgOrcJ
         Y6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573288; x=1782178088;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVI6jvfk6d9EL/ENbwXNBwXF++3mwFN65akUydTqkcI=;
        b=fU/IbBIP9fkOkckrFBZVMXvxZeJdhXsVXS02cAJjOf/uV4p8JgU/q8fuoqUWFqoqmO
         +BMbUHB1dLS48QH/sirLDC8FRYyuX6uvkjhGXF2IQMG2o4SnIMQ4Xf9KQFUlf9fzVIab
         jOnh1tPqtqm93l+Lms5GhBEkoFh+5U5m6/KSe0xwNNNzVCGDqBYUzbZgiorPiT4dQM7+
         7fZP33myOqPDiymgkEhDbRfZk27Zlhkb8WaXd/h8Zwhw/bCMxXp1n0R3Lros1b6Crltc
         7faMwmhsig2fx73lZJIldqvHHrxBnWAf0Yt3kMmdrU3EU7NBEppUmIo6eDtIdW7pCINV
         /5gg==
X-Forwarded-Encrypted: i=1; AFNElJ/PEPzGQ73f0UJYlz1HD/6Hn+EJfPgsO7rSn+WbxHcCTHv7fxm6tplQi4KDepi0tmkPZqXx5TllsZpn6lyQjuEy@vger.kernel.org
X-Gm-Message-State: AOJu0YznXq2PY718QzY0Jf+v5eExgruI674OB1J4jlY5WXLJwC2HJBqo
	h2q0Gzqg/7zoPTFIhGnbzme3nXosEsVomsl7CKUSOxKwAfX/FekWlTFlv1FypFLYcyNuwqeD+9w
	4GVuWYS+aVA==
X-Received: from dlec7-n1.prod.google.com ([2002:a05:701b:4287:10b0:138:15e3:14ab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:78d:b0:12c:1288:ce63
 with SMTP id a92af1059eb24-139858024bamr795662c88.13.1781573287459; Mon, 15
 Jun 2026 18:28:07 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:27:41 -0700
In-Reply-To: <20260616012744.4049193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012744.4049193-10-irogers@google.com>
Subject: [PATCH v1 09/12] perf tests: Fix flakiness in branch stack sampling tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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

