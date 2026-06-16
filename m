Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F043379EE7
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573163; cv=none; b=NOClUa4uQQQGAw7SVEbgVXmJJe8NDUss2TO2SK5aOwj7WzhTLIcIixixinjO/hpBJBHyom1vpJfNv1r7lfArK9qRTA5mcUf60L7zFIhKMv67mOZc3bb+PlNM9kU9YjduyucKh6V3QCmbmED2DsNrbMF3oxc587Cf6Mrah/B8gH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573163; c=relaxed/simple;
	bh=jaGUZa+3n4Hj6kL4s4C5AhVaazro4xHt2cu4tVcyJyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Eah33uiTeU1HwCXpxDjxwZKIdw03a0QqzTy1a/hN2EdDTvs6yNX37RdzQ+3QMKK/aV32gf/4ItRS/VTz52kNFc1wpXYT/eBXcMniAOwrDhczRohl3bWeYUdZFQy/0cub2uZsCjo9bl9F4XQ9r7HVVjzQr60r05lKhswoFOV6RCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IUW41RPa; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUW41RPa"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304ec73b015so1576240eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573154; x=1782177954; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ey3859c+dCCZhIYYYmcqI0MV2QtbNDTAgy9JyyB/qJM=;
        b=IUW41RPaLxz/sRyiaR90NbJGj1ltuj/ijTosKNrVIgpnwdSJMuca0NsZr6slaaPN/t
         hxPgDood+bQDYWyD8dPVru0Zx7o/YJlhisX2RyMIUILx/CYoGGGfG+eMKpbG+LbFE+w8
         Ke2Zxp23DrqBD93oGJn47jweYU/50c9bOAscWcxZoFj1hSNZBtZmx39dOUvNR5Y61hEr
         v7eq/VzMEAsryBidk6v1FjICsh655RxGF1luK3U+Izi2mij+udxM9JsCDhzxliTRmNW2
         kMv5St7ozTpFTalN2tfRUWBa5+rVSa7nZTJ5a487/ToKTLQdgG46lyKzWY5trPF6TAPS
         aWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573154; x=1782177954;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ey3859c+dCCZhIYYYmcqI0MV2QtbNDTAgy9JyyB/qJM=;
        b=g0nKGWhWCjE1BMzx7n8ORARRjZXrmjQmI5GbTMiloEwTgtfICfbEFdbCAKun4KU/ql
         YMhYeF/42OEjvVgnl057j4lHcEuqzrfA/Om0kUZJWwuHy7AHnXb5tQq7WnhgtyJLqe9k
         4hp/pU3EBauIECEGxnYB/a3Sfg/kPugA76Jk6VBSASHPOF1Yp+9ee1z6FgKGWc5BnoMD
         yH8+r+zCAmzR56pvV/Mt/N/KIRJ+Y+NLvNX0Dviny0dpdzUrC/dEu49EwKZ5/Um/MiWu
         CEaoa+Ds3RAP1h2uUNejhMacufa+6FNTFFb1qwPNy1STtx3tW5hhhbMxtLICsv1Cpmrk
         t82w==
X-Forwarded-Encrypted: i=1; AFNElJ/ecuhSU5TgdjqX3Flc7H4AO6Xi8r1BoW+As/DoCwCXHe62E3ZikWC140zZjvgO+VIV2Nm172wo1rsoq+g/MGgu@vger.kernel.org
X-Gm-Message-State: AOJu0YzUgccMilT7Lapsg7eipJagbWmmbGU82mXcuND3ODV5z0Mgdbha
	PO5ynK8GQzzj21fCHOTS0mIUdC99J5z42XIh1dmBZbvsvFxEZaSHIZH2U1+eXUG6HO+He/erqgR
	mRj/I2nLStw==
X-Received: from dybox23.prod.google.com ([2002:a05:7300:ec97:b0:2ee:9140:ff36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d10:b0:305:56a:c38f
 with SMTP id 5a478bee46e88-30ba5fe1d2amr983626eec.26.1781573153256; Mon, 15
 Jun 2026 18:25:53 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:25:17 -0700
In-Reply-To: <20260616012521.4045202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012521.4045202-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012521.4045202-9-irogers@google.com>
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
TAG=agy
CONV=7e7ee33a-e940-4a8a-8e64-878da6a68b59
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

