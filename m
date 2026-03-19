Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951972AD00;
	Thu, 19 Mar 2026 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773902720; cv=none; b=sBHnBUtivdoea3VXPmM6+aDqomEQduGiOaK/1IIKmDXxdw2NvK4X+WYBJoBFA4XRjC4Ifz2iV1GW+q+xc4Hxan+9dIrqhgI1OXf7iXCGv/wrd0t6Wwo2LIjQQNQ1hJHamW3/pFa8+mHkVDcr0bVb/bfORKF5oS5UXzW0157xxpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773902720; c=relaxed/simple;
	bh=RO7NoPU4+ZLWfW23sC74S2Nf+j3IvxaY8TA3tzKbEbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIRSoYuTLiFe64NEHOHeBapgYND7YMiVORKJdL5ACZr7Awuu1zQfZrOM1GN6gUZJmeOVLBCKmCSU7Mnq08O07+gUa67KZa4Cv7733jEZYAOj0hiCd0t8clkdMzqmOJT0oee1t94aKBw4jQJ2PTt9kKGyFw5OMqoTUfZiYBF0nBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfObOWEt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfObOWEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18A4C19424;
	Thu, 19 Mar 2026 06:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773902720;
	bh=RO7NoPU4+ZLWfW23sC74S2Nf+j3IvxaY8TA3tzKbEbo=;
	h=From:To:Cc:Subject:Date:From;
	b=hfObOWEtO2DxuqlGGqtm1YsDVl7M/DdgSioLVK5QCnkr3l+oZYPZuN4+ll6iGRX4X
	 iIPH9RqtOHZmkfgVioqdGyABgJQp+9QsAR3bwV9nrQo4KNhvbu1D5rf2+0e1L8yLoh
	 P83U4+XnDfrK7ZwxQk/tzzBf9Kz1xykZEM7UL71Fi9+kPmhhkywZMDobN/PkdXCIZs
	 CE9nS85FXhQ6d5rwRh27/sbPFePncWA+hhHYtx8ipC5hpR6fZNh5vMGWfwXqZ+0sxr
	 MCWVbSEjIWOeAsL2FkaoBMxFnwJri9PMGRSm82x0zhLffFzF7mqFHPtri1aRVukuMN
	 USiLOl+xsJvhw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3] perf test: Fix perf stat --bpf-counters on hybrid machines
Date: Wed, 18 Mar 2026 23:45:13 -0700
Message-ID: <20260319064513.9269-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test constantly fails on my Intel hybrid machine.  The issue was it
has two events in the output even if I only gave it one event.

  $ perf stat -e instructions -- perf test -w sqrtloop

   Performance counter stats for 'perf test -w sqrtloop':

         910,856,421      cpu_atom/instructions/                (28.05%)
      14,852,865,997      cpu_core/instructions/                (96.79%)

         1.014313341 seconds time elapsed

         1.004114000 seconds user
         0.008174000 seconds sys

Let's modify the awk script to add the values for each line and print
the total.  The variable 'i' has a number of input lines that have valid
output and variable 'c' has the sum of actual counter values.  That way
it should work on any platforms.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v3) make sure to print numbers w/o thousand separators.
v2) handle '<not counted>' and '<not supported>'.

 tools/perf/tests/shell/stat_bpf_counters.sh | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index f43e28a136d3c9bc..35463358b273ce1c 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -41,8 +41,14 @@ check_counts()
 test_bpf_counters()
 {
 	printf "Testing --bpf-counters "
-	base_instructions=$(perf stat --no-big-num -e instructions -- $workload 2>&1 | awk '/instructions/ {print $1}')
-	bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions -- $workload  2>&1 | awk '/instructions/ {print $1}')
+	base_instructions=$(perf stat --no-big-num -e instructions -- $workload 2>&1 | \
+				awk -v i=0 -v c=0 '/instructions/ { \
+					if ($1 != "<not") { i++; c += $1 } \
+				} END { if (i > 0) printf "%.0f", c; else print "<not" }')
+	bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions -- $workload  2>&1 | \
+				awk -v i=0 -v c=0 '/instructions/ { \
+					if ($1 != "<not") { i++; c += $1 } \
+				} END { if (i > 0) printf "%.0f", c; else print "<not" }')
 	check_counts $base_instructions $bpf_instructions
 	compare_number $base_instructions $bpf_instructions
 	echo "[Success]"
@@ -52,8 +58,14 @@ test_bpf_modifier()
 {
 	printf "Testing bpf event modifier "
 	stat_output=$(perf stat --no-big-num -e instructions/name=base_instructions/,instructions/name=bpf_instructions/b -- $workload 2>&1)
-	base_instructions=$(echo "$stat_output"| awk '/base_instructions/ {print $1}')
-	bpf_instructions=$(echo "$stat_output"| awk '/bpf_instructions/ {print $1}')
+	base_instructions=$(echo "$stat_output"| \
+				awk -v i=0 -v c=0 '/base_instructions/ { \
+					if ($1 != "<not") { i++; c += $1 } \
+				} END { if (i > 0) printf "%.0f", c; else print "<not" }')
+	bpf_instructions=$(echo "$stat_output"| \
+				awk -v i=0 -v c=0 '/bpf_instructions/ { \
+					if ($1 != "<not") { i++; c += $1 } \
+				} END { if (i > 0) printf "%.0f", c; else print "<not" }')
 	check_counts $base_instructions $bpf_instructions
 	compare_number $base_instructions $bpf_instructions
 	echo "[Success]"
-- 
2.53.0

