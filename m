Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A415530C;
	Sun, 18 Aug 2024 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724016591; cv=none; b=T/R5GPEc9wLo23gxXWVmV7rEizN/cnwVhtibWtQ9KPG57DWkN+V/yXcLsqjC4rwRwTsYsn2F6rWI0Iu8qzVggaBnBYQSGjikvuWeeccqzDMVS/BITjTmb574WWZhPjqO8Y2jB5fl7qbyXsphTU/SPUnGWuvjUy3h+4u/p77vlPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724016591; c=relaxed/simple;
	bh=27mLaOsU4Neh+Lwony+6s7NMH1kp+GzumhgqSNic1ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4nvZnSHamlzP/QQztcHHVkBh8ZMt1owN7kay9HXGwzMj5ENX7Pt24gWnxNcDRfT3yw6wow48Bu87W0TuOFkSARgLKW5BFegNwqxpezuF8RDRh7sHzNpvjpWFQSlsa2+TYh0CViXCiuz1GuzOOvdOdfOmobr0v9FyBvl4aSFjHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiMij6Xq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiMij6Xq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9AEC4AF09;
	Sun, 18 Aug 2024 21:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724016590;
	bh=27mLaOsU4Neh+Lwony+6s7NMH1kp+GzumhgqSNic1ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GiMij6XqJvcLR2pyB66rGpPJEcFEUUQZ9zBgNZ2x9swXZ8IbD/gMNef3gYtWTXihd
	 4AJYPDt0G2chGwEPVakkJROnOvEIDC1SSYEMJtU5RkEyEPMLMSdfXAzjkiA3IK9J/Q
	 uMWJWwonyFIulZ8u//NPM1f38UC30uqpRVia0M1Q66ZgJgKCEp0BMRXumSYAjkAy15
	 ZstVWMPCc/qMJEg93Kc600StSh2/+bOrQ+ve2d4oJH9nVhYfFYc3TJmXG7dLjATZwR
	 L0jjOUYaZEszW7zFjaYCm25l+9cXQvdB57fZn0YNrwTViPU8W4W6v8Shxhr9PRLUZY
	 mkxy/RsGFY4ZA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf test: Add cgroup sampling test
Date: Sun, 18 Aug 2024 14:29:48 -0700
Message-ID: <20240818212948.2873156-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240818212948.2873156-1-namhyung@kernel.org>
References: <20240818212948.2873156-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add it to the record.sh shell test to verify if it tracks cgroup
information correctly.  It records with --all-cgroups option can check
if it has PERF_RECORD_CGROUP and the names are not "unknown".

  $ sudo ./perf test -vv 95
   95: perf record tests:
  --- start ---
  test child forked, pid 2871922
   169c90-169cd0 g test_loop
  perf does have symbol 'test_loop'
  Basic --per-thread mode test
  Basic --per-thread mode test [Success]
  Register capture test
  Register capture test [Success]
  Basic --system-wide mode test
  Basic --system-wide mode test [Success]
  Basic target workload test
  Basic target workload test [Success]
  Branch counter test
  branch counter feature not supported on all core PMUs (/sys/bus/event_source/devices/cpu) [Skipped]
  Cgroup sampling test
  Cgroup sampling test [Success]
  ---- end(0) ----
   95: perf record tests                                               : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 36883b03169f..048078ee2eca 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -206,6 +206,28 @@ test_branch_counter() {
   echo "Branch counter test [Success]"
 }
 
+test_cgroup() {
+  echo "Cgroup sampling test"
+  if ! perf record -aB --synth=cgroup --all-cgroups -o "${perfdata}" ${testprog} 2> /dev/null
+  then
+    echo "Cgroup sampling [Skipped not supported]"
+    return
+  fi
+  if ! perf report -i "${perfdata}" -D | grep -q "CGROUP"
+  then
+    echo "Cgroup sampling [Failed missing output]"
+    err=1
+    return
+  fi
+  if ! perf script -i "${perfdata}" -F cgroup | grep -q -v "unknown"
+  then
+    echo "Cgroup sampling [Failed cannot resolve cgroup names]"
+    err=1
+    return
+  fi
+  echo "Cgroup sampling test [Success]"
+}
+
 # raise the limit of file descriptors to minimum
 if [[ $default_fd_limit -lt $min_fd_limit ]]; then
        ulimit -Sn $min_fd_limit
@@ -216,6 +238,7 @@ test_register_capture
 test_system_wide
 test_workload
 test_branch_counter
+test_cgroup
 
 # restore the default value
 ulimit -Sn $default_fd_limit
-- 
2.46.0.184.g6999bdac58-goog

