Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BBB3DA7FD
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590463; cv=none; b=eqM2R3hnFYtgv8bAU9G9NVIba5SSRXJD+4yt1YpKissa0jp5knTCmK9Fw1ragNWxP2YRDV8OOGHVDw3keQyLkLSBCYPA6KBfGUFmnckey6fg1UOr4PfIEpcwJqoGEcpdFqdjmD1bY1p/G8t8AnT3NyiW5K1L8t+mBU+FAPlfPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590463; c=relaxed/simple;
	bh=9BweFq1KvCVjFPFhyxZ0Js+gp5CkTR3+nwesNYO39kg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tdRO2wEvQz+OfvXKaAdQw51X70j2bXpNv8WR35z3H0IPSU2QBJs+yiNd5v2LiCT6eqYnEKKL8JGQ41/IYOnnne4Y5l+2hTxKOqZOcLgjd0eWebh6YqxK2PSkKMzMofiyzglxMOodOCDYHbEKY5VCREJ90XanqMl8yK6Cru/CDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6O6qLXY; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6O6qLXY"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304dd917645so8625607eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781590459; x=1782195259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kMggAS0dt5mLYHR9g3sOSIWRf0FBsh4fAFmwHA30DE0=;
        b=o6O6qLXYPxMxCl3TP7UHcsW0UOwdUYQ4XKSZFSvoSpBzd/GrBtBYKWQrJPQuYfJzu+
         QgAz4DP3mM5MtwaR+y2lI78pfCRD7B7eZrTmD+ZRrYNtnjKKa/MH0jXEQ7sPLbmi8IFM
         xn/bth6ezeQK0Mcx2snm+vEofQT/XTrjk1GIau8sftTZP334oBDH7ZEZ4O3OJy+D9gC3
         QS4janZuVHSQNNGXwV53XItTqg5J5TER49bLJr1WBqqjpaNeedp7wZLxEEtLAJVHwsDq
         1CrZplErJB4wcVTcm7wRaEDmKWakTNz75vFUcProI5grwlm/yqXAileE5qJwpSpvZzl+
         r7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590459; x=1782195259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMggAS0dt5mLYHR9g3sOSIWRf0FBsh4fAFmwHA30DE0=;
        b=hOxQ2U4rsau0Z3FgtCrw60y7bx8uQ6i4seT6RP6b22izO32335FosaNxAEmkY1iqov
         rld4MbnNQ/Fel+VCcz20wbUDHRTXZLce54b6xnIFqhUqNGmiHjxhRADJl3+9Toj5iJSN
         gWzUrSm9nh0no/x/Ow80daw4wpCXaO7gYf3PPW1bpOEATwVBhqZE7ZtTWiJC42Ej02NQ
         qqKx5riJAta/vd4zQ/B46sILS8Mfcc2Qn8j/58owz/6ilEOQdQdHAzdE1JfiAG6WvszW
         pmFIWuAl7zp/zfHgsuXLVBXCUXl4RTIv4xJaGl4XOoJsPrSLCWip+0IDZpyP1jTFT3Yn
         xgkw==
X-Forwarded-Encrypted: i=1; AFNElJ9u+WUQffkZlZXVjLuzzN8xnvdK+9zQa4eaE5I0ZFvHhXRt8buKy4r90O2rTuVm82xe10sWmZ1jsKkiP+edVVPi@vger.kernel.org
X-Gm-Message-State: AOJu0YymiMvVNqWT5aJf/L4RKLTPCZr+04B2iSsrIkDSd5ZiUzvIly9h
	/jclUF4yKouwVsekRhAJ8RC/WT4TdoO/tiszzL3JkFzDTbShI0AlaZY6bzJAROa8yBpp1mlQiBW
	f1w9z8nBNnw==
X-Received: from dyab15.prod.google.com ([2002:a05:693c:830f:b0:2e6:52c7:6f4f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:42d3:b0:30b:8893:8788
 with SMTP id 5a478bee46e88-30b88938898mr2494460eec.13.1781590458316; Mon, 15
 Jun 2026 23:14:18 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:13:57 -0700
In-Reply-To: <20260616061404.41929-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com> <20260616061404.41929-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616061404.41929-6-irogers@google.com>
Subject: [PATCH v2 05/12] perf tests: Skip metrics validation if system-wide
 recording lacks permission
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The metrics value validation test requires system-wide recording (`-a`),
which can fail on systems without root permissions or where paranoid
levels restrict tracing. Add a check to skip the test if `-a` is not
supported.

Also fix false negatives during validation by updating parse error string
patterns and resolving issues in metric list generation.

Fixes: 3ad7092f5145 ("perf test: Add metric value validation test")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/lib/perf_metric_validation.py | 11 ++-
 tools/perf/tests/shell/stat_all_metrics.sh    | 75 ++++++++++++-------
 tools/perf/tests/shell/stat_metrics_values.sh |  7 ++
 3 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b/tools/perf/tests/shell/lib/perf_metric_validation.py
index dea8ef1977bf..3d52f94f22b9 100644
--- a/tools/perf/tests/shell/lib/perf_metric_validation.py
+++ b/tools/perf/tests/shell/lib/perf_metric_validation.py
@@ -383,10 +383,13 @@ class Validator:
         wl = workload.split()
         command.extend(wl)
         print(" ".join(command))
-        cmd = subprocess.run(command, stderr=subprocess.PIPE, encoding='utf-8')
-        data = [x+'}' for x in cmd.stderr.split('}\n') if x]
-        if data[0][0] != '{':
-            data[0] = data[0][data[0].find('{'):]
+        cmd = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='utf-8')
+        lines = cmd.stderr.splitlines() + cmd.stdout.splitlines()
+        data = []
+        for line in lines:
+            line = line.strip()
+            if line.startswith('{') and line.endswith('}'):
+                data.append(line)
         return data
 
     def collect_perf(self, workload: str):
diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index b582d23f28c9..feeb34c6fa6d 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -12,38 +12,65 @@ system_wide_flag="-a"
 if ParanoidAndNotRoot 0
 then
   system_wide_flag=""
-  test_prog="perf test -w noploop"
+  test_prog="perf test -w noploop 0.01"
 fi
 
+check_metric() {
+  local output="$1"
+  local status="$2"
+  local metric="$3"
+
+  if [[ $status -ne 0 || ! "$output" =~ ${metric:0:50} ]]; then
+    return 1
+  fi
+
+  if [[ "$output" =~ "<not counted>" || "$output" =~ "<not supported>" ]]; then
+    return 1
+  fi
+
+  return 0
+}
+
 skip=0
 err=3
 for m in $(perf list --raw-dump metrics); do
   echo "Testing $m"
   result=$(perf stat -M "$m" $system_wide_flag -- $test_prog 2>&1)
   result_err=$?
-  if [[ $result_err -eq 0 && "$result" =~ ${m:0:50} ]]
-  then
-    # No error result and metric shown.
+
+  if check_metric "$result" $result_err "$m"; then
     if [[ "$err" -ne 1 ]]
     then
       err=0
     fi
     continue
   fi
-  if [[ "$result" =~ "Cannot resolve IDs for" || "$result" =~ "No supported events found" ]]
+
+  if [[ "$result" =~ "Access to performance monitoring and observability operations is limited" || \
+        "$result" =~ "in per-thread mode, enable system wide" || \
+        "$result" =~ "<not supported>" || \
+        "$result" =~ "Cannot resolve IDs for" || \
+        "$result" =~ "No supported events found" || \
+        "$result" =~ "FP_ARITH" || \
+        "$result" =~ "AMX" || \
+        "$result" =~ "PMM" ]]
   then
-    if [[ $(perf list --raw-dump $m) == "Default"* ]]
-    then
-      echo "[Ignored $m] failed but as a Default metric this can be expected"
-      echo $result
+    true
+  else
+    result=$(perf stat -M "$m" $system_wide_flag -- perf test -w noploop 0.1 2>&1)
+    result_err=$?
+
+    if check_metric "$result" $result_err "$m"; then
+      if [[ "$err" -ne 1 ]]
+      then
+        err=0
+      fi
       continue
     fi
-    echo "[Failed $m] Metric contains missing events"
-    echo $result
-    err=1 # Fail
-    continue
-  elif [[ "$result" =~ \
-        "Access to performance monitoring and observability operations is limited" ]]
+  fi
+
+  # If retry also failed, determine if we skip, ignore, or fail
+  if [[ "$result" =~ "Access to performance monitoring and observability operations is limited" ]]
   then
     echo "[Skipped $m] Permission failure"
     echo $result
@@ -61,7 +88,9 @@ for m in $(perf list --raw-dump metrics); do
       skip=1
     fi
     continue
-  elif [[ "$result" =~ "<not supported>" ]]
+  elif [[ "$result" =~ "<not supported>" || \
+          "$result" =~ "Cannot resolve IDs for" || \
+          "$result" =~ "No supported events found" ]]
   then
     if [[ $(perf list --raw-dump $m) == "Default"* ]]
     then
@@ -105,19 +134,7 @@ for m in $(perf list --raw-dump metrics); do
     continue
   fi
 
-  # Failed, possibly the workload was too small so retry with something longer.
-  result=$(perf stat -M "$m" $system_wide_flag -- perf bench internals synthesize 2>&1)
-  result_err=$?
-  if [[ $result_err -eq 0 && "$result" =~ ${m:0:50} ]]
-  then
-    # No error result and metric shown.
-    if [[ "$err" -ne 1 ]]
-    then
-      err=0
-    fi
-    continue
-  fi
-  echo "[Failed $m] has non-zero error '$result_err' or not printed in:"
+  echo "[Failed $m] has non-zero error '$result_err' or not printed/counted in:"
   echo "$result"
   err=1
 done
diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf/tests/shell/stat_metrics_values.sh
index 30566f0b5427..76f1e99d1273 100755
--- a/tools/perf/tests/shell/stat_metrics_values.sh
+++ b/tools/perf/tests/shell/stat_metrics_values.sh
@@ -8,6 +8,13 @@ shelldir=$(dirname "$0")
 
 grep -q GenuineIntel /proc/cpuinfo || { echo Skipping non-Intel; exit 2; }
 
+# Skip if no permission to record system-wide events
+if ! perf stat -a -e instructions sleep 0.01 >/dev/null 2>&1; then
+  echo "Skipping: no permission to record system-wide events (-a)"
+  exit 2
+fi
+
+
 pythonvalidator=$(dirname $0)/lib/perf_metric_validation.py
 rulefile=$(dirname $0)/lib/perf_metric_validation_rules.json
 tmpdir=$(mktemp -d /tmp/__perf_test.program.XXXXX)
-- 
2.54.0.1136.gdb2ca164c4-goog

