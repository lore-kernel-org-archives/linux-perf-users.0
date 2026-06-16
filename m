Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6738E37C0FC
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573289; cv=none; b=rc/tgeHrZCCIqV3pMUzJy255g4UoRzkdAHLaCbKK0kDVEv964rS6kvSTn2b9b2+RvlazWwbd1lzgWrq+Wr3n76xK0ivLtXcedDjXo1lNpSWlEimsBzpOri2R26TNXEY9K+TWkyNbied7A1TFCWMIPGWgfZjOa6oq44qKZXg9jP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573289; c=relaxed/simple;
	bh=d1l9O0Ursk9irEjdNKSCcOl8mlqjfaRX/z6ly5Y6G2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VJpMf3/elF49NLwuuIw6F5cnKL5adG4CgkA33hVWVI4VLs97t4DIRjZqa8kD8bZ3zMHgfPH4qZ5GMRyttPd8Z+nvfHj70nAqwgGprBvnCwbtX7UrAea4ynIH/rZyoB5uiqm96rN92SgVnit74LDYSSD/C1HfEEVeEymFQIh17vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzgOc0yC; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzgOc0yC"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-307625ee07fso13987864eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573286; x=1782178086; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wlWTMBTGUUs0KMAWTHlPpE8gLWyfQrfVnfm0X/gpu54=;
        b=mzgOc0yCP2mqo8cU+mPNCvAXrZ4B1bQ8Dccsx0KiNFRtMXQiFtHhPiD1tSVJdRNSOH
         sBnIpEysxI2HGk8Li4l80+9dXkMRUAK967tN/Oq4C6PxtzPl9HqbgKWSpO71i1Onjnsl
         oglGCJ2ttuuCsoz3uHgFiMfOJBfmOxa2CnXM7YrYo+E+n1BaszlpyyOZZ3+GU4c97qW3
         +hjxRz+b/7iiMSYks0vX9vqETCcgxNNf1yTvQwXmIwlfqWBWqp7FHbplmTV3ZS9sXWSD
         U7ijl2dGvo90iVvJYoRRqGMm6Qx5aeMJ90NNrhozrJX7ayOOq+ly6lfTQosgcudNoAVN
         oe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573286; x=1782178086;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlWTMBTGUUs0KMAWTHlPpE8gLWyfQrfVnfm0X/gpu54=;
        b=pKljgM0gnIJY41+AE0a5zHli5yJf8AY7b/SNCantDRkjQwy0Iudl0MQ7BQqrqSbLpv
         ewDi/pKXgvpvYjAIvUvvSq23uui5cnx9pLK/IXx+mIqnZDOSh05FOOsYQWqj6IqoM3LU
         3ZlQrVlLAiGYXY7dNVk5AFMZ1ljf1JdLwbX7jfJmM8lqXliDJD3fZM0WK2u5x4+PU4sQ
         Fd9MmB/qMpOUyqwJ72TGVPwdkKImj5Qz1KUIqIpvX2cP3sjYjmGk4tCujakvKtNaD/jS
         iRUX2C4rFl5ofuTyapai/i1nTTLLN0b+ZeRAIGKuHwmfo2r9orE3HBWzyfNZ6JemmncO
         QSrw==
X-Forwarded-Encrypted: i=1; AFNElJ9On2iqtagbzzJQuul69tky2AQ643XmtIMvittLCdquhCVON6uLhHyp5vzvSNqBkImwbTGXiL13B1do8Bvo1Zsj@vger.kernel.org
X-Gm-Message-State: AOJu0YxOrhlbH717JBVzaYwD/HCKbO23vxn4LEejT5u3PsTqdx0zapcG
	IPaWXbLNDcXfrI/EooyManJ8yTXlsak4tgdUZgAk9DKtUGDBDffdSl84zxN/CcpxHp486xSBR+p
	Lkv9XcpSe+g==
X-Received: from dyjt21.prod.google.com ([2002:a05:7300:7b15:b0:304:ee5b:e1a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6ca5:b0:304:cefc:5fde
 with SMTP id 5a478bee46e88-308202087c5mr8867844eec.26.1781573285195; Mon, 15
 Jun 2026 18:28:05 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:27:40 -0700
In-Reply-To: <20260616012744.4049193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012744.4049193-9-irogers@google.com>
Subject: [PATCH v1 08/12] perf tests: Fix flakiness in BPF counters test on
 hybrid systems
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The `perf stat --bpf-counters test` fails intermittently on hybrid
architectures or systems with dynamic frequency scaling (DVFS). This happens
because the test workload (`sqrtloop`) runs for a fixed 1-second duration, and
the CPU frequency can scale dynamically between idle and maximum frequency.
As the first run runs on a cold CPU and the second run runs on a warmed-up CPU
(or vice versa), the number of instructions executed in 1 second differs by
up to 2.2x, violating the comparison tolerance.

Also, when running as root, BPF tracepoints and scheduling programs trigger
frequently. Since standard `perf stat -e instructions` measures both user and
kernel space instructions, it counts BPF helper and program execution overheads,
whereas the BPF counters themselves do not self-measure. This introduces a large
kernel-space instruction count discrepancy between standard and BPF counters.

Fix these issues by:
1. Switching the workload to a strictly deterministic, iteration-based
   workload: `awk 'BEGIN { for (i=0; i<10000000; i++) sum+=i }'`. We pin the
   workload to a single random allowed CPU using `taskset -c $CPU` via a bash array.
2. Restricting the counted event to user-space only (`instructions:u` or `/u`).
3. Tightening the comparison tolerance from 20% to 15%.

These modifications isolate the measurements to user-space instructions of the
deterministic loop, which executes a virtually identical number of instructions
on both runs (with less than 0.001% variation), eliminating Dynamic Frequency
Scaling (DVFS), kernel scheduling noise, and BPF helper self-measurement overheads.

Fixes: 2c0cb9f56020 ("perf test: Add a shell test for 'perf stat --bpf-counters' new option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 27 +++++++++++++--------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 35463358b273..2f01608c95e3 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -4,21 +4,25 @@
 
 set -e
 
-workload="perf test -w sqrtloop"
+CPU=0
+if command -v shuf >/dev/null 2>&1; then
+	CPU=$(shuf -i 0-$(($(nproc) - 1)) -n 1 2>/dev/null || echo 0)
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
+	upper=$(expr $first_num + $first_num \* 3 / 20 )
+	# lower bound is first_num * 85%
+	lower=$(expr $first_num - $first_num \* 3 / 20 )
 
 	if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
-		echo "The difference between $first_num and $second_num are greater than 20%."
+		echo "The difference between $first_num and $second_num are greater than 15%."
 		exit 1
 	fi
 }
@@ -41,11 +45,12 @@ check_counts()
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
@@ -57,7 +62,9 @@ test_bpf_counters()
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
2.54.0.1136.gdb2ca164c4-goog

