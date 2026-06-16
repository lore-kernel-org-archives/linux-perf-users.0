Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274F147DD42
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628525; cv=none; b=jKNVDMgg7LN7g75lleS/9nOplaTu3AElP64x+/iSXmUh/xToCH08lnYSCOl0D+jlItFJVIlpgxx2Lq+mcwZEixhQjzTLkC74ujjUllSw2M+1jEV6ds++pxpcYM/8OwLE4z/NlCebHr78GqgcIKDtwcMFbbCts2/Mp5rmqlKEQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628525; c=relaxed/simple;
	bh=o1QiBwlMoOJ+D0OZyg2GsT/aCUWIxyinsqtQwOs4T5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GyCg4EZl1Nj6DdSahBLiFlaUJuIpPpZsyjZek62rH8AtFT6I7NeHVQ//bunNryaVdmA0CJOhX/Z3BOiohas8Dyh56u69fGAdqy99gW6dJevT16vEHatuqZhhYlHojYU/E6ZGGtoDNNYDYke3+W13Wx/49PtJtwzbOPmcGutgv0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=niKavywJ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niKavywJ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30762d67a64so6706950eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628523; x=1782233323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RLJjHtUUt0gbLusfGxX5B13oug/zb1BSk3JD/nBjjxk=;
        b=niKavywJNIPmWC8cuoW7A64ZL3gT/o2i9tlhoe68w/mjLr/MaXSoAZPvzWXQI+Zw2c
         ry3crIU6H/DfQNhFxvk3OBxyPrzP63Ji2Mp8ozFivaoYXQTQygcs/3h1iNUfjVLqdJg7
         df9jMxdojJ4VI0kwEL0yByP2Q45o3n0H3rretIKfp42+k7ibUnzI2Kf7oOMzy+FE1JQp
         SfI2wl2k/ADuDrrK6/5lQGHC5YS2klfXLbn9y9GnJ7jirmiE85Qk7BxbHDw8nH3mcqUD
         53dhKNCgzqNRWZFiuquguImtI0cblTP01xdSJ4wxjhx3P8L8NtJsf00/S5ox6Wi2VG7m
         CyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628523; x=1782233323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLJjHtUUt0gbLusfGxX5B13oug/zb1BSk3JD/nBjjxk=;
        b=nhfB+lP3chySV7jLBwqEzPcVRy2VJlH6oRHcv57AfjSQDQNiURv9TipQnczSiZyROj
         pkEwXz8de+4rpwUf9Aob/D/U87LuNGRpMQiWp4F2+EEBqVYUtCeOY2K5Re2ScU2C6tHH
         llXitJKU6fk3Xwxyn84T9w2BZ4NbJTLp94KP8389ZyAs+34NggAh1BpXUZjNPWJ6LI+R
         4U+5qzBu4n5i/bIeLvRv0puRI89mi2dp5tzte0BxD6+Jr6lx8ohrITmBr3FGBxUUPukh
         yKyqiB3eggsbaBkG/T0z3Z2ptYcggzB+DAJHeGAp2etum2K7FiLVPXk6VEik0APPLJBE
         7hRw==
X-Forwarded-Encrypted: i=1; AFNElJ/Otw6TuOUR1uKC3nyq4uhkAEdffg7ivatS6ahsiHo7DVA1a4PCOBxKCphwPVkMWt0TunSrBm6nQN1WHLNL981p@vger.kernel.org
X-Gm-Message-State: AOJu0YzM9aOpvGVZEehXWKwbT1d3LF/cVeS2CsbBybANWhbOUKRD4Dfr
	1BrKmLVoF1xHrabOx/84cm4rz6uPZ6kHrQAU05BI76D/2brAnepkGZQlXrqsn8yl08li1o2jzR4
	BrX4JDGCh1Q==
X-Received: from dyek34.prod.google.com ([2002:a05:7300:6422:b0:2f7:767f:edc3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6115:b0:304:6448:dfd7
 with SMTP id 5a478bee46e88-30bca07767amr55316eec.18.1781628523148; Tue, 16
 Jun 2026 09:48:43 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:14 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-10-irogers@google.com>
Subject: [PATCH v3 09/13] perf tests: Fix flakiness in branch stack sampling tests
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
2.54.0.1189.g8c84645362-goog

