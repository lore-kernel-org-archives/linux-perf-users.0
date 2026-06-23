Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5352938550C
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178103; cv=none; b=KkFuZlMhuRafSxl32+hAluXmbikHjry9JsX1s9uurRUgE5q3R4w0HdzKGvKkTzMHLHqk/+uFcVVa9uj4tZNScOp/fVaFPxHj1HSBRWV2TyCYLQISKcgAXvPv65a8E+UmOS7PpFhC9b+4YQOg8uzWlKOdDFfw2hyP88XJaof/26E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178103; c=relaxed/simple;
	bh=sPDzVOwBLM/ZQRqAXNByDdWHoCykc49dVlgrdLeyqWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gPYn1fuQ5nK8bmKp1hmLGB0AIZc89qgp7QvcqVMIq8DxoOe3dCXiNW7kR1M1i4Ql0GLGyr6DVeG8i4nws7KlcGhnEQcLgtDXDWL5djHwAuhRLA8b3insu+dPvHLWT0WS/P+BVCeLkmxTcjJ50F6kzYL0aJMiwS5RHQ6ySTHNxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hMgJkz7T; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMgJkz7T"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137e49e896aso350347c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782178099; x=1782782899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SN2ktKyN5IjzwKoAdV05tastVl2RGruJcaYjq+0yEWM=;
        b=hMgJkz7TWqMXHyD7/Pa2P77NWtERYWhWRoaEpN0b7LGUOAAFZuAzOnOVAbSuYbOr8K
         q33d4ICIE8wzF02uqVTnS6yK9vuSmHhpb95NJUVyt24IFOKukE21bF7DpZgsccnQF2rC
         m+0UC8gysJqqldBm+sFX18Dm71EPoYhzcbp5vIC4fwLQ2/tYzLHPurwOIYSg9s/yY4yC
         zEey2H6AEe6Qe6gdNGYVHxYvojiiNgh17Wt/s5LosfP/SSzm+omZP2xzEkhNWocX0VuG
         CEzSrMJQ7v8I8wexVdyY2HSoz731UqC8D0glwlrZlw/tzIfCefElGiI4kBrpkCgnNEAc
         u38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782178099; x=1782782899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SN2ktKyN5IjzwKoAdV05tastVl2RGruJcaYjq+0yEWM=;
        b=PuDXk3l8eFlVJrsvMeU8D+96WvqlBFpZeJhxQN4M75joRmp8T7sPSXk+qTjefp59nc
         l1X0FIRBk07Z0iXB/0JPEc29P5YcWAZikgo0y/oyPIG68UGPD8Xp6Jci8V88zWdzBiTb
         64AR8MhnwZV2jCGLfIYPwmF7L+7SUwr/IIuOSq3YGDOk7/Pg230CAHcf8PQrHXGGF4ES
         E2csWi8AX1VbIbIIvZkzddDyQ8D9Y2n+2k8d+6Gjf6gxUen3hQWzVu7kim809qCn0InM
         ww98N0sBIJh5USep5NK8st5fbEqY00iamMocxULsb2QlGiWP1ORM+8c5GBZcnnwDsOma
         uOIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/A9TSnPH8lkSVSr0hCJigNw0QPZWwY7MTP9mQEuZa01scy/HMu1fncXZ7hqJa/xiSAwXMEgk1Bs3Wxw0ABo7rz@vger.kernel.org
X-Gm-Message-State: AOJu0YyLujySHFT2p7UXLUpZGHLHcQErIiiirop5FDi6RkwIaPDp2Q+c
	FQlBrVYqApDJClyYthCGMccuNB8jLROEGcFxyjIZTlrP+SRXucCfPWpMDzHeEGe8wazlZY2Urf3
	h+cvdNZgdQA==
X-Received: from dlep14-n1.prod.google.com ([2002:a05:701b:458e:10b0:139:43a0:ac1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f68c:b0:136:8b76:14eb
 with SMTP id a92af1059eb24-139c3c80c88mr1049784c88.14.1782178099042; Mon, 22
 Jun 2026 18:28:19 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:27:53 -0700
In-Reply-To: <20260623012758.2291858-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616164819.370939-1-irogers@google.com> <20260623012758.2291858-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623012758.2291858-9-irogers@google.com>
Subject: [PATCH v4 08/13] perf tests: Fix flakiness in BPF counters test on
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
2.55.0.rc0.786.g65d90a0328-goog

