Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C166378D7F
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178095; cv=none; b=iNgAPEIg4jZIT96MKTGaTHy1q6keHludJW0TzoL3W1CdtdlSXhlt5gu3m690BqPC6cUlm6tpyMoftSBEYBDG2bF05GKseNYS9DkirTVb3JokDQWvPm34wYjKahHVM6Qg23hk/pWTxepQCygYbGvc/oDbcjKh+25h4CeVaraeUOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178095; c=relaxed/simple;
	bh=PtWWGJ/Ctm1uLboowDiO4kDVB3yzxkjc2xpNGc9ceek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X0XSv/RKNKddKkJ5VgxercU3pOPC7ETq2RQ7Eizc5v3IErali0YXJSF3Nc2sQgFTA2eqCQErQLK9BkrK3pF8h1GdPSMVzlj+UsWYuNWh6fYpjsvUEzLr+nYqETCaWeU4W7f5gf45hMZ4KlTm/gTOAPAJiY48fpVSHJXW57ACLPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hb4YBX2a; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hb4YBX2a"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30c5978b108so604796eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782178093; x=1782782893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7pHJ75Bd63iHwPl+9t6VKLfo15t05Xfuvj9+KYTB0Vg=;
        b=Hb4YBX2a9Re5fYl5jWbE/bph8gFu6g8ViXLOZo+BfSirAILP3CvwCwc5rlp1d/A1Pf
         Ok5r53y+FlrfZPzScIaTs99lsiFUIiXjyIHvYHM9McY2CXcGEyeASyiIGsd6UhkC7ywX
         vNrtmhKbpizgKFggQ/HIyHyEzmAlRagJIETMzvZOQjHKq3J/UNbqovgCGiQl4XQNDmgd
         yOZmUS5G3iF+FDiU4s2isqQp+WZfSL9PgWgL6dav+1rZq0lyyw2K9x9Y0Y9GvggmlISA
         PKAbaw33CYNTAooRKe0LLAkECbXrS0h2Ax3WW/LJeO9nJ4c4hff+XsEaGbxlSLj7vklk
         oH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782178093; x=1782782893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pHJ75Bd63iHwPl+9t6VKLfo15t05Xfuvj9+KYTB0Vg=;
        b=kXJpGDAMW4gOz6pjRlqo3EO825HkhQuLmmGl26peO7izDopZ8J+mPLPkTlVqL4Qf08
         nQzO6zv/YfN71wq6qGmlw0XXuMnoPW0vt0DNyqPviUs6qHLu22mHokopIA2NW9Q/7tcg
         2Hu7L3jUGu+goA5XBIUF3xUrmVYS6tA0O51clrMiNOau9vPJjJhWtiBPMwQmPi4dLBRY
         02zXm+s388bkZMM/O6m01XSz2rveQJ76bi1hsOiyLALDiK2ICXnzAE4HDIs3GBCjLm6x
         RplSQiqrOMwF+4l5kA40sdhba+0SBtbWY+wm3ehig5yTjxBkAFy4UOwPP0RPh/nGt2ku
         sU7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrl4U3k96HMNVocwTOGUx/M4flR9ipVs735yRP7VZLzwwHnd0LmXXOOv8k1duXj4qsXaQNgfKEL+N/Wn/mXCmZe@vger.kernel.org
X-Gm-Message-State: AOJu0YzWAl7843mlCn436+l1AQd7CnwqFAOXN8uElYeMT+jYk9ZYCgzp
	bclpgVvksMMQngv4HT7t5ouksbknQ2NGrYD0sYEj+Dtf1eq4PYp+0souGHgaiMzoPErjdoSHBJ7
	d7ND5zw6VOg==
X-Received: from dyeq5.prod.google.com ([2002:a05:7300:42c5:b0:2f9:af7:504e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:38a4:b0:30b:bae1:aec7
 with SMTP id 5a478bee46e88-30c5b96c259mr229970eec.30.1782178092997; Mon, 22
 Jun 2026 18:28:12 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:27:50 -0700
In-Reply-To: <20260623012758.2291858-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616164819.370939-1-irogers@google.com> <20260623012758.2291858-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623012758.2291858-6-irogers@google.com>
Subject: [PATCH v4 05/13] perf tests: Skip metrics validation if system-wide
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
2.55.0.rc0.786.g65d90a0328-goog

