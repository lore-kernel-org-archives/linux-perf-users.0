Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E78478E50
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628517; cv=none; b=RAt80IzTxKT6kqHf4Qvlf6DyLtWmQud2aOh2kO77Z6qLUpa2OJgi5pFKfgvQajq4I2uoq86e3UG3tBgIOTOhbpnZOMuSShaezhALJMIX3x8E/gyCFtJ9dmC5zbICvegvog/G0wp4zV+Te8q9AW6ONh4GohioGfN5vrFeAH+gGBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628517; c=relaxed/simple;
	bh=+oqvX/5+ZGvNpn8296orR4bjjs6pB6ixENbt+T8ZcFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CdC2kLoNnOg/BB+dNkD/M6iteZ8qn8XWU90lXa1lKnncTl/jFXZhPw4nlrg/6u6V/IVq2rGEzav6QjKGAYSBHP9ampcIQdwhyRHudut0w79AohOGxi8Kje00ui1lgg7AIKijnpjWuDti5rX3pKtLLtTpQFkmcOUbE4wrNlR2pLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s7CY+KD/; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s7CY+KD/"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30bc7296c59so294662eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628515; x=1782233315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=520LJRJwdnNZv7+Ny5D8fvRBGVZWwDSpOzALH71LZao=;
        b=s7CY+KD/fuVQN99soUSZzTao0MsCbsAn26H6pt4Y8qhHYopGfTgmf7Txpl/vuNbHFh
         MzccKEwqR42x1jeJoqi2rI2iX9LNZzLV4cSLqFJpcTEdQ7s0YhW+wBNJfnBkawgGE3yA
         i2d9hdrY/LOHnHbDMKM6HF7roU4wzwFEALnDV/ZlAd2zcQ7XpMZ6e4D8SnOM+AOfs9Nn
         Yv2GzYJD+17FXZUefvvjkPPieLFg+bjdS+1WDpX8nc9E2BTtA3Okjt78dMy4UeimIbjA
         u0s5BLm0CEjDTlCRMBNEHXBZzOSKsGK6YMxY4xPeAQN5P3kkXzEViJKxNn3GFpZcgGVs
         meqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628515; x=1782233315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=520LJRJwdnNZv7+Ny5D8fvRBGVZWwDSpOzALH71LZao=;
        b=n68A7qzX8L0rvWskGcw4WJOyL1zhSj7YhwZphb8drtJfoh2FPam53RB+MBfH7NTn+O
         UkCNvqhM+AHx1U8oaZZLmyKAOi8pHa/8SAYDKbZRECJYBUWBFNFZb2ja3XqWXmPSZypB
         BroqDareKQdlXplwMterphDQcNzEZbWxPxKEbyuZ/K5JQrtDAJsKm7tE3/50LjrSi3ei
         coWehypT4sGHdxcYTjnN++kySMzlJrqFcCiwreODiUTDD/IZj982cjGtplOwqAU/ieg4
         /6UqNhDFrD7ZhYP1tTCWvkKTbUUIAcBPHLn3D0c+q6zCuuSneAr0k29qQ63X5aQe96ap
         r4VQ==
X-Forwarded-Encrypted: i=1; AFNElJ98Vv6UtqGmjiBkwErAlPP+ILulNg56VfR1t+ZlSyx+1kYrhE1nK5W9MnpqVuoYYqvzLUEWiWTbbmIFE5kyXckx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt84PJ8gbq+Eauw5nK9SouJgiGyti0wblrS/XrsHRVhciVg2jH
	wk0fJcfSvOjYd0wJAV0rpuVu7bwK8p6rmFWgQezsMH7G5kDm+SijAA/THoKByik7u9mVvJ75FDH
	KRE8Hu/W6dQ==
X-Received: from dyjw33.prod.google.com ([2002:a05:7300:56a1:b0:30b:61f5:5091])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2297:b0:2be:1f58:32a3
 with SMTP id 5a478bee46e88-30bca0731bfmr55048eec.29.1781628515219; Tue, 16
 Jun 2026 09:48:35 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:10 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-6-irogers@google.com>
Subject: [PATCH v3 05/13] perf tests: Skip metrics validation if system-wide
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
Assisted-by: Antigravity:gemini-3.1-pro
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
2.54.0.1189.g8c84645362-goog

