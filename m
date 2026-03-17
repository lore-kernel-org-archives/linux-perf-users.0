Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0D22A80D;
	Tue, 17 Mar 2026 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730838; cv=none; b=hYzSKaavQ5bbKi6FNHfkjQGaznVL6PiTfJ9NiK9ZJOFcCAv54LM+D/MdvA7+rhQcYPCKFA6KPbsqf2A8gBz4ua3heSKzdMneiygAYn8kirCoaLEz4RyVJqCAIwswB2ExmUzzpWUwUIuIoYXPOXUvrO6TXDHg2XctrHkkiCaFhrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730838; c=relaxed/simple;
	bh=UgYDSh/T7OTYVT5d05Oq68sK6MVez60xW0HwRSnFA1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIIizegUFJs9csoV6KvHBf9ygfXuSlMYsO8MyUSw/fxQdAHU4Pvu0NqThhCR8vcuTRgWNx7hspm1a0DJ+kkxiBzp9ExkEQfYMbwVyfxXfxXXG+LkIp05KXP4Z/D65vksRhi0Lto+hkcq/awwVKVUvZ/i4Z7k6nKV1VRGv1Z75s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUU4qY6n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUU4qY6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348A6C4CEF7;
	Tue, 17 Mar 2026 07:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773730838;
	bh=UgYDSh/T7OTYVT5d05Oq68sK6MVez60xW0HwRSnFA1I=;
	h=From:To:Cc:Subject:Date:From;
	b=GUU4qY6nC/0lmXYLmDQ4uT03viTeKaD91PwTnL2peKmxDTnDKfsZFi8X6xjyXUGst
	 fy3vR4SI8pT8dY6ZWTejb75qr9HNji6WWynsIe6a0vU4WicpMELONgQODhA3eE15Jq
	 HFobLTTRmid+3b10yg/qxlKCE9c/xG4JJVpBMoLZbXMtdIgXRiTDEl0PAoZ8NrH6wY
	 cKy2Ht8zPegey4E9RfSM1z2nMwjVoQhpeSnPWhb/gk65gK0/qbJa8nNYcH5j71zID3
	 1Zfo+DBXeSBkbTChmwrBj7IWQiiOJVxAz6S/gfAZCHOq6uZ/5Iyc1m4/n+ClDR2UQF
	 El+YW2sgjHxtw==
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
Subject: [PATCH] perf test: Fix perf stat --bpf-counters on hybrid machines
Date: Tue, 17 Mar 2026 00:00:32 -0700
Message-ID: <20260317070032.41934-1-namhyung@kernel.org>
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
the total.  That way it should work on any platforms.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index f43e28a136d3c9bc..e04808ed871e3f08 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -41,8 +41,10 @@ check_counts()
 test_bpf_counters()
 {
 	printf "Testing --bpf-counters "
-	base_instructions=$(perf stat --no-big-num -e instructions -- $workload 2>&1 | awk '/instructions/ {print $1}')
-	bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions -- $workload  2>&1 | awk '/instructions/ {print $1}')
+	base_instructions=$(perf stat --no-big-num -e instructions -- $workload 2>&1 | \
+				awk -v i=0 '/instructions/ {i += $1} END {print i}')
+	bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions -- $workload  2>&1 | \
+			       awk -v i=0 '/instructions/ {i += $1} END {print i}')
 	check_counts $base_instructions $bpf_instructions
 	compare_number $base_instructions $bpf_instructions
 	echo "[Success]"
@@ -52,8 +54,8 @@ test_bpf_modifier()
 {
 	printf "Testing bpf event modifier "
 	stat_output=$(perf stat --no-big-num -e instructions/name=base_instructions/,instructions/name=bpf_instructions/b -- $workload 2>&1)
-	base_instructions=$(echo "$stat_output"| awk '/base_instructions/ {print $1}')
-	bpf_instructions=$(echo "$stat_output"| awk '/bpf_instructions/ {print $1}')
+	base_instructions=$(echo "$stat_output"| awk -v i=0 '/base_instructions/ {i += $1} END {print i}')
+	bpf_instructions=$(echo "$stat_output"| awk -v i=0 '/bpf_instructions/ {i += $1} END {print i}')
 	check_counts $base_instructions $bpf_instructions
 	compare_number $base_instructions $bpf_instructions
 	echo "[Success]"
-- 
2.53.0

