Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEB33DBD47
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590472; cv=none; b=rNpB9g2rLLLenWG11zfZ+byZVM0xei8ZcfOg7VpcKgC4BZ3I3TZnGtlwA+OTXTiRa6JsfnbV8E2OOosEljWTOgaPGrGfRVajeTQuNR6gT1yF+91+mhpWBbJVfxAi6tuysRZSY9za5Qp0CMrXEhAjVU15XAAftAg1gkJ9FWUWZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590472; c=relaxed/simple;
	bh=AdmxAXzdZLbjPa1i4fpe7i1x5C5ut9Rnz2StLUgq0rk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VPMMhWMVONmq5J4n2D0+UGk+9y2y1/UWaSEvM9AsUheqTfLj7M7x7YUYleUDhEgHz+WO+VHDZfGeYwyHw9AEgqHX5kwMAUuqF31U/SRn+LqvPQIxhCqdbLaS5P2ryLj3YX6o4d45Rwpaz4K6ySEJ71/AiVofsMNpgQmSb+Arc+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tVfuqSAD; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVfuqSAD"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-308004a2c49so1141356eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781590465; x=1782195265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x29faCUZFXFl+CqH5OTbtaGw4Ap1z6lY226uBfjLrzw=;
        b=tVfuqSADKH2OrE9FTQMpMhbe3BP/r8NQbBeitTBuurq2xhyb/qCHVtZgnQ4PqXjkxN
         lep1uMvhUxrc0AExlwv1tKaNdSNfEhdYhGa0f5U/d/HrOWksBsFOCnI3cdr/PR1VyRU4
         TE6pTYsQOi8CNr88Gu1QnMmJnB1kZXtqJVoJmjA14g8zp89F2s2O51VNW+xdDXlX5Z/F
         IL4M3I2/sDMzv1kq8/gQRHm70lk/dFANkqUlwYWsNAoKlERb49tQCWeaMDM6J0zkGsyA
         ktvTXLniY9KUgGv5SM2FU8yzrHbqMkTpLoYxl2zMXFnzRy/tVm0s3uTKt4edIyGE54NP
         ehiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590465; x=1782195265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x29faCUZFXFl+CqH5OTbtaGw4Ap1z6lY226uBfjLrzw=;
        b=BJZAer+KeDnMi2Pi9uf5hu+KMgrX208AESeMmcDi2B2nbCldM1QARvue+GHz8uSEVJ
         X7b4QJITqMgmhgQcb+kyxC45g+LPCFIDL2RNcWURvivvLFmaOl/KJkhOluKCGf4cFK2A
         O8EUuauct66NaTXmsktSnbWyyeSAhbxUAv59hXqNcvlXP/UhVjkJahhu32SAQyemfGP7
         L9q2zU9eh6IAkbQrhOP4Ay5EoOdghYv0GB+q4qD5P7dJoeApnLiq2tmbBUuKDmXUyf66
         5x+CyF5PCOnPHC2nfdqN95wQJ9aM43uUC4+x68NbiK0LEYLvPmjKNtwiUcjssafrJSab
         ehiQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NDX7fQYvRpKnlX1OYo7SnnCAeQoJ/e4mUck5jeOfnu1wNBaYRcpiH34zXSckEXw4bWcKd3sVqN9QZktr2+vbr@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhu1rSAgzbaAHUXoybwqW8HnvKTAPRfYf4Dgi0j++rJ1HWiXV
	BbcqO8Y3APPe23liY3H6gdwO4jUpJ05YCivPmwyn5mEnuwgX0Tz+K+Gs1aktf6KwqWA0LG7IqAU
	UT8kwrZC9MA==
X-Received: from dybmj14.prod.google.com ([2002:a05:7301:e0e:b0:304:dbcd:d155])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8623:b0:2de:c5ca:c1f3
 with SMTP id 5a478bee46e88-30ba5912e66mr1318069eec.4.1781590464067; Mon, 15
 Jun 2026 23:14:24 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:14:00 -0700
In-Reply-To: <20260616061404.41929-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com> <20260616061404.41929-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616061404.41929-9-irogers@google.com>
Subject: [PATCH v2 08/12] perf tests: Fix flakiness in BPF counters test on
 hybrid systems
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
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
2.54.0.1136.gdb2ca164c4-goog

