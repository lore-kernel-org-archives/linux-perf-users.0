Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B823603E9;
	Wed, 18 Mar 2026 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818107; cv=none; b=ULnvDmnrq2X6KzyXR1gsOshZMBnK/9BZKh5QrLJzUzyuIOr8bTogo5B4+iCOLE9tSnj6wLvzcO6zeNCnMLnC1vfqn8psSn/T2HQIEWjIkApMnXHZ6pF66BumzCDeBS1JEME62HAxsbuk5mQ3GRN34BWzlQcQIs4pQgK0RL8jjFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818107; c=relaxed/simple;
	bh=Vp1eIjcQdu7nh+wlHqRJaseJqZre+Q2B4i3duBiBEaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XYqlCBSCpdKMCyFRVjLpdbdEVd7YeEW5H3CEuxXlAzG7sSlRrwdPM2s6+1xmwFfITrmJoXiRx57eb9c2o7rkC5CiYvmkLNvatcBp+dyAW2fclItne40RnuskE9dgIgAykF07Nqvn7ewZzFj0ZGunTT53YhXpSsIvTih+qaAvCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTHTb+Ax; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTHTb+Ax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E674C2BC9E;
	Wed, 18 Mar 2026 07:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773818107;
	bh=Vp1eIjcQdu7nh+wlHqRJaseJqZre+Q2B4i3duBiBEaU=;
	h=From:To:Cc:Subject:Date:From;
	b=GTHTb+AxdnfJezG0Dcwg23PRAq4v3630BZQTAc8ilDZRe/YnqJdJGNJLVgO+0iAkE
	 TNi3RD72YHYZP0HyXt2pwXuTWAZ9/cIudq+4uO21/u882qLUWWsHNwfMwKbNxhbJLy
	 W4hpdh+vCW9VhoddvOyA/O36wGmx+xOBdIMXCmq78tyjFv9f7XdSK7P/Ega+KNcsja
	 ZgmfEYJJsbB83qbsqMVNbI0yYBH+K16DBKzVqXJnEcmE6TpVSfs3MUG/+pI/KRhjqi
	 TDdpAlSgClgd8Us0fOZrXtl+B41Uq90G0Ur1HOTN+tD8wTfb5mtIPcP4TS44Bm7Bor
	 wZYi/M3oGLzLg==
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
Subject: [PATCH v2] perf test: Fix perf stat --bpf-counters on hybrid machines
Date: Wed, 18 Mar 2026 00:15:01 -0700
Message-ID: <20260318071501.17339-1-namhyung@kernel.org>
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

         910,856,421      cpu_atom/instructions/                                                  (28.05%)
      14,852,865,997      cpu_core/instructions/                                                  (96.79%)

         1.014313341 seconds time elapsed

         1.004114000 seconds user
         0.008174000 seconds sys

Let's modify the awk script to add the values for each line and print
the total.  The variable 'i' has a number of input lines that have valid
output and variable 'c' has the sum of actual counter values.  That way
it should work on any platforms.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) handle '<not counted>' and '<not supported>'.

 tools/perf/tests/shell/stat_bpf_counters.sh | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index f43e28a136d3c9bc..8b42585f45025d5c 100755
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
+				} END { if (i > 0) print c; else print "<not" }')
+	bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions -- $workload  2>&1 | \
+				awk -v i=0 -v c=0 '/instructions/ { \
+					if ($1 != "<not") { i++; c += $1 } \
+				} END { if (i > 0) print c; else print "<not" }')
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
+				} END { if (i > 0) print c; else print "<not" }')
+	bpf_instructions=$(echo "$stat_output"| \
+				awk -v i=0 -v c=0 '/bpf_instructions/ { \
+					if ($1 != "<not") { i++; c += $1 } \
+				} END { if (i > 0) print c; else print "<not" }')
 	check_counts $base_instructions $bpf_instructions
 	compare_number $base_instructions $bpf_instructions
 	echo "[Success]"
-- 
2.53.0

