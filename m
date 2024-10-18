Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1231209687;
	Fri, 18 Oct 2024 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284188; cv=none; b=OuKLxJc7y8BfEpClh6rMeM7Bsh8d94+gnipg0zok6VgqVA31Xc1KWBjJ927lRvOS06TQY1xgCT0ymlYw5BBh8UT2qk9FEEYdHseKAanJTQJPX2anjEaaVWcI1nRUnGwixxfrkhyx9kdDSw2l2ePjyDYew9VNVsWHJlqJD3hZL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284188; c=relaxed/simple;
	bh=Wd2sRFIv6VgBTxpaUlOO+UeISbX+LtoMmnn1efqwEq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvUJv6igDe+5LUX0zz+BFVWLzOKxKDYQdMgZsxw6QBsG2mp9KCPe4lsvlZf+UHA7rXSR9reo0RDq6Mt47qKDCL74ldFdwUktE/C5N2U1K3g4MrCUotURCzxQC4EIlLkA4gslEvfGb2K9ZOFzB4QDF5+vbOpLM4VsOuhOt8gMx+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyI7rWZC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyI7rWZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A864C4CEC5;
	Fri, 18 Oct 2024 20:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729284187;
	bh=Wd2sRFIv6VgBTxpaUlOO+UeISbX+LtoMmnn1efqwEq8=;
	h=From:To:Cc:Subject:Date:From;
	b=NyI7rWZCWNva/Ew7YW8P0IerlkOVnbmsSb3nrMwd3ktiHocZtcOtxYE2eAA5Dn9qk
	 3zCdhgi3lEjGn1I0LuHxqlWipq4zPGZM45YP0Wtq8SxvV8zbyMeHmYJ1GHGu6XOEFV
	 92sW2oDQbEXDAvQOfoy+DtiE9PKNkJNUmtbXXhhvVWzOCE52EVRA50ioJZzq6TyhZs
	 DEdjzd6XuNH/3eLMaRqRfLaUGAePvdhs+9hNB1v9/RpZQLW+BbNEuPYgBa0d5eOfd5
	 upSHUYTiu0pcn4CmksV0nagHj6YhetGPA+WcGTnhSh//pkUi3PiOm9KrMj9vxpuF3T
	 LMGBkIRrZJMDg==
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
Subject: [PATCH] perf test: Update all metrics test like metricgroups test
Date: Fri, 18 Oct 2024 13:43:06 -0700
Message-ID: <20241018204306.741972-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like in the metricgroup tests, it should check the permission first and
then skip relevant failures accordingly.

Also it needs to try again with the system wide flag properly.  On the
second round, check if the result has the metric name because other
failure cases are checked in the first round already.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 87 ++++++++++++++++------
 1 file changed, 66 insertions(+), 21 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index 54774525e18a7b9a..73e9347e88a964bd 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -2,42 +2,87 @@
 # perf all metrics test
 # SPDX-License-Identifier: GPL-2.0
 
+ParanoidAndNotRoot()
+{
+  [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
+}
+
+system_wide_flag="-a"
+if ParanoidAndNotRoot 0
+then
+  system_wide_flag=""
+fi
+
 err=0
 for m in $(perf list --raw-dump metrics); do
   echo "Testing $m"
-  result=$(perf stat -M "$m" true 2>&1)
-  if [[ "$result" =~ ${m:0:50} ]] || [[ "$result" =~ "<not supported>" ]]
+  result=$(perf stat -M "$m" $system_wide_flag -- sleep 0.01 2>&1)
+  result_err=$?
+  if [[ $result_err -gt 0 ]]
   then
-    continue
+    if [[ "$result" =~ \
+          "Access to performance monitoring and observability operations is limited" ]]
+    then
+      echo "Permission failure"
+      echo $result
+      if [[ $err -eq 0 ]]
+      then
+        err=2 # Skip
+      fi
+      continue
+    elif [[ "$result" =~ "in per-thread mode, enable system wide" ]]
+    then
+      echo "Permissions - need system wide mode"
+      echo $result
+      if [[ $err -eq 0 ]]
+      then
+        err=2 # Skip
+      fi
+      continue
+    elif [[ "$result" =~ "<not supported>" ]]
+    then
+      echo "Not supported events"
+      echo $result
+      if [[ $err -eq 0 ]]
+      then
+        err=2 # Skip
+      fi
+      continue
+    elif [[ "$result" =~ "FP_ARITH" || "$result" =~ "AMX" ]]
+    then
+      echo "FP issues"
+      echo $result
+      if [[ $err -eq 0 ]]
+      then
+        err=2 # Skip
+      fi
+      continue
+    elif [[ "$result" =~ "PMM" ]]
+    then
+      echo "Optane memory issues"
+      echo $result
+      if [[ $err -eq 0 ]]
+      then
+        err=2 # Skip
+      fi
+      continue
+    fi
   fi
-  # Failed so try system wide.
-  result=$(perf stat -M "$m" -a sleep 0.01 2>&1)
+
   if [[ "$result" =~ ${m:0:50} ]]
   then
     continue
   fi
-  # Failed again, possibly the workload was too small so retry with something
-  # longer.
-  result=$(perf stat -M "$m" perf bench internals synthesize 2>&1)
+
+  # Failed, possibly the workload was too small so retry with something longer.
+  result=$(perf stat -M "$m" $system_wide_flag -- perf bench internals synthesize 2>&1)
   if [[ "$result" =~ ${m:0:50} ]]
   then
     continue
   fi
   echo "Metric '$m' not printed in:"
   echo "$result"
-  if [[ "$err" != "1" ]]
-  then
-    err=2
-    if [[ "$result" =~ "FP_ARITH" || "$result" =~ "AMX" ]]
-    then
-      echo "Skip, not fail, for FP issues"
-    elif [[ "$result" =~ "PMM" ]]
-    then
-      echo "Skip, not fail, for Optane memory issues"
-    else
-      err=1
-    fi
-  fi
+  err=1
 done
 
 exit "$err"
-- 
2.47.0.rc1.288.g06298d1525-goog

