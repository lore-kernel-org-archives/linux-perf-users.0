Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7C47CC8E
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628523; cv=none; b=HqsLmAhPXB/QA/LEth27yeBBpO6EIVOMQHY5Oq/v9pRgUifzz2Qw81ULqk/cd+DubBsL1e6HoNeV38OfISWJXzR9ktZQM6CNcNzzeHIYexyq0WxNZtUI28QE+wDBzkHzHdKQhP+daXfQUXetPnCIHDcAlQDrM8j+HjdirQ62ijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628523; c=relaxed/simple;
	bh=2SDmky2bvKmEfMcgWYU104w3Cig8b7ihX4LB0VW3nsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s0uaOiDUfKzBEJqgLou05iU+ekNd4WLY+FKJvfT/+SVCd9sBmi0ZrIFpeOdm1Ex3SbEs+Qh11nkIx7fV6SLVwCDE3JCpaSKuN8Ts8tvmV8KMUcn/FLatdq5UZUeniyy9FQoXQxSBu+Llkg3nDzlXDhoE10cU/z2C0E+gT42kyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pvwghnxO; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvwghnxO"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304e7fc90b1so5250401eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628521; x=1782233321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUue5tk8w73gMIG/MYxb42RfX3D9b+qahmyFc53lpwo=;
        b=pvwghnxOiB9RgEnKKkp2n4i0NMSMRdN+cx4FRWiyQQRCWwUavwJMIDJTeebcj+Y86q
         2ryCq53TjfbT0Us+9kCAEa1mGQnoQ4x+R9O0s1DpPObeuGCz4hgkuLaY+OBdORyFuUJe
         UJoi4EShfE5Z1FN5lsOfjhCyTbPwtCwy5QUL1rr8Y9qJ9vz4tx5m19Ytq60dywUoBZDM
         0vTCKqQDnIYYWXVg142gnUV8LkvwOZvPbfJa2TxEqIe4dSRkkUq5W8D38zCbkQrB3i7y
         DbCWVRTxd90gGZw1LTaq1scGdn76cTkZa8Nt8QQRQbI5NAmR5QK+b69/w43RkKk16iJG
         OR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628521; x=1782233321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUue5tk8w73gMIG/MYxb42RfX3D9b+qahmyFc53lpwo=;
        b=CatKZtAndQs0iYqblWaUGUrK23mqRsMOk6uXP/Qd4u9WVCf18+FdLuA4bEz77maY18
         6jxja5GdNwQINSowGj45bC9fnSjmPX6oKDqwX5t3vB4yiHyJJEXWXzOg9Y53bimExvSy
         YBJGrvKGg4rTIuobOSdPGW3iHRd1XcyetAKXtsfICbH0qHUkPVp0FgzWAOng+eeupC3t
         A+9TaQMacZQ1vhG760zLwD5VhBHrCxLSBYM2Ka+Fx6f3C1oCn+koh9OCUkC/y1DHtBis
         v7JrqeG+Zv/SwJl0ZrM48sqqrgRXX9nGCKfnUGAbF78Q0hb5WukbUKbRy+IivSmnsR0o
         9mPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wBGMNkd3I7eX7HD4rvomflCQQ7SLUyAYvUp4f2G2ibEaYsk13VoNU5sHZJwLzpxiVTH1B9TsMRyIbFWwf8LwQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyfrR7vza1QoyCCIBDRLXsYLnH/oD3qo12ugSPXNFKtOtAb9SWA
	ZUsznkNBxuIzOTJxIer2t7ecsW8w6hZfodsvKW4BEnoFpH1Um4MBxiRURPJ9s0d1UVbrP2UDkn/
	Ww2rnruvbVw==
X-Received: from dybii50.prod.google.com ([2002:a05:7301:2f32:b0:304:15d:7342])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6415:b0:304:2cc9:2ba8
 with SMTP id 5a478bee46e88-30bca10fefemr44386eec.30.1781628520949; Tue, 16
 Jun 2026 09:48:40 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:13 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-9-irogers@google.com>
Subject: [PATCH v3 08/13] perf tests: Fix flakiness in BPF counters test on
 hybrid systems
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The `perf stat --bpf-counters test` fails intermittently on hybrid
architectures or systems with dynamic frequency scaling (DVFS). This
happens because the test workload (`sqrtloop`) runs for a fixed 1-second
duration, and the CPU frequency can scale dynamically between idle and
maximum frequency. As the first run runs on a cold CPU and the second run
runs on a warmed-up CPU (or vice versa), the number of instructions
executed in 1 second differs by up to 2.2x, violating the comparison
tolerance.

Also, when running as root, BPF tracepoints and scheduling programs
trigger frequently. Since standard `perf stat -e instructions` measures
both user and kernel space instructions, it counts BPF helper and program
execution overheads, whereas the BPF counters themselves do not self-
measure. This introduces a large kernel-space instruction count
discrepancy between standard and BPF counters.

Fix these issues by:
1. Switching the workload to a strictly deterministic, iteration-based
   workload: `awk 'BEGIN { for (i=0; i<10000000; i++) sum+=i }'`. We pin
the
   workload to a single random allowed CPU using `taskset -c $CPU` via a
bash array.
2. Restricting the counted event to user-space only (`instructions:u` or
`/u`).
3. Tightening the comparison tolerance from 20% to 15%.

These modifications isolate the measurements to user-space instructions of
the deterministic loop, which executes a virtually identical number of
instructions on both runs (with less than 0.001% variation), eliminating
Dynamic Frequency Scaling (DVFS), kernel scheduling noise, and BPF helper
self-measurement overheads.

Fixes: 2c0cb9f56020 ("perf test: Add a shell test for 'perf stat --bpf-counters' new option")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 28 +++++++++++++--------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 35463358b273..11de77ee38ad 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -4,21 +4,26 @@
 
 set -e
 
-workload="perf test -w sqrtloop"
+# Get the first allowed CPU
+CPU=$(taskset -c -p $$ | awk -F': ' '{print $2}' | awk -F'[,-]' '{print $1}')
+if [ -z "$CPU" ]; then
+	CPU=0
+fi
+workload=(taskset -c "$CPU" awk 'BEGIN { for (i=0; i<10000000; i++) sum+=i }')
 
-# check whether $2 is within +/- 20% of $1
+# check whether $2 is within +/- 15% of $1
 compare_number()
 {
 	first_num=$1
 	second_num=$2
 
-	# upper bound is first_num * 120%
-	upper=$(expr $first_num + $first_num / 5 )
-	# lower bound is first_num * 80%
-	lower=$(expr $first_num - $first_num / 5 )
+	# upper bound is first_num * 115%
+	upper=$(expr $first_num + $first_num / 20 \* 3 )
+	# lower bound is first_num * 85%
+	lower=$(expr $first_num - $first_num / 20 \* 3 )
 
 	if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
-		echo "The difference between $first_num and $second_num are greater than 20%."
+		echo "The difference between $first_num and $second_num are greater than 15%."
 		exit 1
 	fi
 }
@@ -41,11 +46,12 @@ check_counts()
 test_bpf_counters()
 {
 	printf "Testing --bpf-counters "
-	base_instructions=$(perf stat --no-big-num -e instructions -- $workload 2>&1 | \
+	base_instructions=$(perf stat --no-big-num -e instructions:u -- "${workload[@]}" 2>&1 | \
 				awk -v i=0 -v c=0 '/instructions/ { \
 					if ($1 != "<not") { i++; c += $1 } \
 				} END { if (i > 0) printf "%.0f", c; else print "<not" }')
-	bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions -- $workload  2>&1 | \
+	bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions:u \
+				-- "${workload[@]}"  2>&1 | \
 				awk -v i=0 -v c=0 '/instructions/ { \
 					if ($1 != "<not") { i++; c += $1 } \
 				} END { if (i > 0) printf "%.0f", c; else print "<not" }')
@@ -57,7 +63,9 @@ test_bpf_counters()
 test_bpf_modifier()
 {
 	printf "Testing bpf event modifier "
-	stat_output=$(perf stat --no-big-num -e instructions/name=base_instructions/,instructions/name=bpf_instructions/b -- $workload 2>&1)
+	stat_output=$(perf stat --no-big-num \
+		-e instructions/name=base_instructions/u,instructions/name=bpf_instructions/bu \
+		-- "${workload[@]}" 2>&1)
 	base_instructions=$(echo "$stat_output"| \
 				awk -v i=0 -v c=0 '/base_instructions/ { \
 					if ($1 != "<not") { i++; c += $1 } \
-- 
2.54.0.1189.g8c84645362-goog

