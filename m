Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314B01FFC45;
	Thu,  3 Jul 2025 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507387; cv=none; b=RjT/8hDV6xPbksmxstfcprWG9OKWRB2bv0RlA97M3ENH2RxCXtUnGxi08b8Gv874puE3iKk9GyEimyud6u0YzHfTchvnpSpJV6sg8+rC6n3UHwo+kg2D8270Rd8HWh7FL/MsVrY52cg//emu5nDpCsotM+DxsrCf9O256IMjgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507387; c=relaxed/simple;
	bh=QKC9dVoT8uAMP6ybmq2ZbGaAcXGjdbm+RC6KFdw5CG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ny2MNE9aWovWImZCn2r1Abp6OZ7TyTTtk4DAqsEiWodkN4G2/5zpYJwFI+3k0Y+rxyWOTWNBbqES7x7Gc3XiyfSbhVGY20TJHOarw+r90BX1uc/BDMnIfhkkFy+e62fUDZ3gBor2I2IGZuPV1E11vTnvH31IWHQ7ib4P0P2UvFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPtIEDsC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPtIEDsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65EAC4CEF2;
	Thu,  3 Jul 2025 01:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751507387;
	bh=QKC9dVoT8uAMP6ybmq2ZbGaAcXGjdbm+RC6KFdw5CG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPtIEDsCST3nRSV5dMnSmkrcEJpctsGxDwiiK3odAchbvjzJUbWJvaOTSw6iosOn2
	 j25ZwKCX9XYW2VG61Sn7ciPGCk8+Qhfgzoxz/fAem2IVRX3LGMh21psFFjpelVPIGr
	 ItN584ldrRyKo5mw66PxtFDScUkYLMnVtvNtFwgTH3+tB9xnhMRArEF3Vb3IDInEkj
	 AyHT0Dgp/bh+BQnsSXlnZLY8BJwahVMLXjgQ7I2y1sAt463OidsdSWbrzNkr9qQbsr
	 l/4YU8HojLqCE0cAUlMDWJxkbxQ6m82f1GHa8gOR4TyD9PTUwFkpPtBXneHI1HLcKs
	 xFYs3JpM2JhjA==
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
Subject: [PATCH 8/8] perf test: Add more test cases to sched test
Date: Wed,  2 Jul 2025 18:49:42 -0700
Message-ID: <20250703014942.1369397-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250703014942.1369397-1-namhyung@kernel.org>
References: <20250703014942.1369397-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  $ sudo ./perf test -vv 92
   92: perf sched tests:
  --- start ---
  test child forked, pid 1360101
  Sched record
  pid 1360105's current affinity list: 0-3
  pid 1360105's new affinity list: 0
  pid 1360107's current affinity list: 0-3
  pid 1360107's new affinity list: 0
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 4.330 MB /tmp/__perf_test_sched.perf.data.b3319 (12246 samples) ]
  Sched latency
  Sched script
  Sched map
  Sched timehist
  Samples of sched_switch event do not have callchains.
  ---- end(0) ----
   92: perf sched tests                                                : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/sched.sh | 39 ++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/shell/sched.sh b/tools/perf/tests/shell/sched.sh
index c030126d1a0c918d..b9b81eaf856e6555 100755
--- a/tools/perf/tests/shell/sched.sh
+++ b/tools/perf/tests/shell/sched.sh
@@ -56,38 +56,61 @@ cleanup_noploops() {
   kill "$PID1" "$PID2"
 }
 
-test_sched_latency() {
-  echo "Sched latency"
+test_sched_record() {
+  echo "Sched record"
 
   start_noploops
 
   perf sched record --no-inherit -o "${perfdata}" sleep 1
+
+  cleanup_noploops
+}
+
+test_sched_latency() {
+  echo "Sched latency"
+
   if ! perf sched latency -i "${perfdata}" | grep -q perf-noploop
   then
     echo "Sched latency [Failed missing output]"
     err=1
   fi
-
-  cleanup_noploops
 }
 
 test_sched_script() {
   echo "Sched script"
 
-  start_noploops
-
-  perf sched record --no-inherit -o "${perfdata}" sleep 1
   if ! perf sched script -i "${perfdata}" | grep -q perf-noploop
   then
     echo "Sched script [Failed missing output]"
     err=1
   fi
+}
 
-  cleanup_noploops
+test_sched_map() {
+  echo "Sched map"
+
+  if ! perf sched map -i "${perfdata}" | grep -q perf-noploop
+  then
+    echo "Sched map [Failed missing output]"
+    err=1
+  fi
+}
+
+test_sched_timehist() {
+  echo "Sched timehist"
+
+  if ! perf sched timehist -i "${perfdata}" | grep -q perf-noploop
+  then
+    echo "Sched timehist [Failed missing output]"
+    err=1
+  fi
 }
 
+test_sched_record
 test_sched_latency
 test_sched_script
+test_sched_map
+test_sched_timehist
 
 cleanup
 exit $err
-- 
2.50.0.727.gbf7dc18ff4-goog

