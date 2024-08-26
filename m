Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB019D8A3;
	Mon, 26 Aug 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710249; cv=none; b=J5Xe/yKV4533rW/v0Z/MTkUsdbBlqNfFdRWM/gse+qscBgH7NyZ68612swxrDXxcLlT2GA8NaOXhST+TeYMn316RRWe7p6a4Z9qjIoWPeZ24t614a4os+bbLeGF8YkC6pEJvMKwVrh1FhDHhMyML8NLST+Uy0E4jsTQKK6nioVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710249; c=relaxed/simple;
	bh=rwfzMfzWfmYK+czXS5HQ2sT2TdEzkFp6mwDTDw/WD+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k72Lca4vJi++3ZTmDX94aKZuUNA5uuHRgkw2tju94f448STYt36Z/TiYh0bgCPeo9yiqIA7w3wf4BoVxQl/ryKZYLwEVX1Ev3AyKOVDLN8DP64Ig2WnK+DDsb4vHdjM8hKqcye1ujq7zcrA3Xprd3yQVgqBCTCteY07H/EbrDXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBb8ilRM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBb8ilRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C53C8B7D9;
	Mon, 26 Aug 2024 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724710249;
	bh=rwfzMfzWfmYK+czXS5HQ2sT2TdEzkFp6mwDTDw/WD+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBb8ilRMeZUCvGKdipmXJtlNCM3JDj2kSsLP2YlUd+s8G+/LjZtWtkcVXL0I7qyfT
	 h1h9IBjURXh0ebQwBLhNfoW2d/W0uNwMwsv1kXKU5nsN+R1TcU9B+PKxCmDsV6Zkt6
	 ykLEepcp3jXwda1vi9YupsmA91RjrFIlD5N5lADBaHyrejL6e+yC9qWA9q3sRAUXEp
	 4pTcYOyS1yYzJttiM2myXI6x6qgXp5nHbHcIRwakS/0IguUYEubi8C2mA3FrfeWBer
	 sVK/22VQzEjQwmqJXjeDMoOEblhIhbeSsHyTxASi4M7EU4mdpfH2wfRsMwKaY9GPpx
	 Vy9cIVR4pgo1Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 4/4] perf test: Add perf record cgroup filtering test
Date: Mon, 26 Aug 2024 15:10:45 -0700
Message-ID: <20240826221045.1202305-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240826221045.1202305-1-namhyung@kernel.org>
References: <20240826221045.1202305-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  $ sudo ./perf test filtering -vv
   96: perf record sample filtering (by BPF) tests:
  --- start ---
  test child forked, pid 2966908
  Checking BPF-filter privilege
  Basic bpf-filter test
  Basic bpf-filter test [Success]
  Failing bpf-filter test
  Failing bpf-filter test [Success]
  Group bpf-filter test
  Group bpf-filter test [Success]
  Multiple bpf-filter test
  Multiple bpf-filter test [Success]
  Cgroup bpf-filter test
  Cgroup bpf-filter test [Success]
  ---- end(0) ----
   96: perf record sample filtering (by BPF) tests                     : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record_bpf_filter.sh | 39 +++++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
index 4df33c15bfa7..1b58ccc1fd88 100755
--- a/tools/perf/tests/shell/record_bpf_filter.sh
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -68,7 +68,7 @@ test_bpf_filter_fail() {
 
   # 'cpu' requires PERF_SAMPLE_CPU flag
   if ! perf record -e task-clock --filter 'cpu > 0' \
-	  -o /dev/null true 2>&1 | grep PERF_SAMPLE_CPU
+	  -o /dev/null true 2>&1 | grep -q PERF_SAMPLE_CPU
   then
     echo "Failing bpf-filter test [Failed forbidden CPU]"
     err=1
@@ -98,7 +98,7 @@ test_bpf_filter_group() {
   fi
 
   if ! perf record -e task-clock --filter 'cpu > 0 || ip > 0' \
-	  -o /dev/null true 2>&1 | grep PERF_SAMPLE_CPU
+	  -o /dev/null true 2>&1 | grep -q PERF_SAMPLE_CPU
   then
     echo "Group bpf-filter test [Failed forbidden CPU]"
     err=1
@@ -106,7 +106,7 @@ test_bpf_filter_group() {
   fi
 
   if ! perf record -e task-clock --filter 'period > 0 || code_pgsz > 4096' \
-	  -o /dev/null true 2>&1 | grep PERF_SAMPLE_CODE_PAGE_SIZE
+	  -o /dev/null true 2>&1 | grep -q PERF_SAMPLE_CODE_PAGE_SIZE
   then
     echo "Group bpf-filter test [Failed forbidden CODE_PAGE_SIZE]"
     err=1
@@ -147,6 +147,35 @@ test_bpf_filter_multi() {
   echo "Multiple bpf-filter test [Success]"
 }
 
+test_bpf_filter_cgroup() {
+  echo "Cgroup bpf-filter test"
+
+  if ! perf record -e task-clock --filter 'cgroup == /' \
+       -a --all-cgroups --synth=cgroup -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Cgroup bpf-filter test [Skipped cgroup not supported]"
+    return
+  fi
+
+  # 'cgroup' requires PERF_SAMPLE_CGROUP flag
+  if ! perf record -e task-clock --filter 'cgroup == /' \
+	  -o /dev/null true 2>&1 | grep -q PERF_SAMPLE_CGROUP
+  then
+    echo "Cgroup bpf-filter test [Failed CGROUP requires --all-cgroups]"
+    err=1
+    return
+  fi
+
+  if ! perf report -i "${perfdata}" -s cgroup -q | grep -q -F '100.00%'
+  then
+    echo "Cgroup bpf-filter test [Failed root cgroup does not have 100%]"
+    err=1
+    return
+  fi
+
+  echo "Cgroup bpf-filter test [Success]"
+}
+
 test_bpf_filter_priv
 
 if [ $err = 0 ]; then
@@ -165,5 +194,9 @@ if [ $err = 0 ]; then
   test_bpf_filter_multi
 fi
 
+if [ $err = 0 ]; then
+  test_bpf_filter_cgroup
+fi
+
 cleanup
 exit $err
-- 
2.46.0.295.g3b9ea8a38a-goog

