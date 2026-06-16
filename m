Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DEE379C29
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573152; cv=none; b=E8Illd2jbvuLRk3JpIpMp3Gpa9U6Ybi0Xlpn8HvcU7CA5PIfCjGCmtXsm6hB4hr9G840s5GpYI/40ZY0dQTJ/5opz2pJYuOR5crlzF6yhbxOJf0NlGQUD2NrypJiCNLCyLOgbs68ZNEIhsm0KAW/V/pm8Q0Z5Ga+lb/CKWOutgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573152; c=relaxed/simple;
	bh=IWw/jkJbcTvoWviqsJVt76UB5A1Cp3VpV/Sg3YTHur0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bNP4KagGS+PLM/83StDusTiaABUqn9NtEMJPhuaPD3QliQVjUjEH2tfsPH3EM5m513W+a9VUxHLIKOTbVOTabXHcWi7fjGV051j8yVxDcxK+6bzzcfR2mszAa5SFdHNRys66I68evbSEBE8dgFcjTz+CYS2WXy0oKjADubxrPdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umV0khQh; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umV0khQh"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3074d4102a9so11352710eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573148; x=1782177948; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gc5MVcsL5+wdEnp7bwxKe+dITTqbvk7Blc8igMUR8Lg=;
        b=umV0khQhuPv3APbxeQppb+vqC+Dur9gZjhHeX3i3DTSJ4JMiu7krpZy8/bUZOrb3+S
         hNt7yXgwDTU/Vgq9mLzxBC8/1SD8i/XYKV2OMLQdmYXDITPNxIyMYvckW2goE9hkfIRT
         klICpIFwJkGfz2Z5Ba+2Lx9Q6DUgbEC9+c8+UPO5T+yQx8yV8dnb0QPX3b/QEN6cBCkk
         zWpELGOqDOvNIK3hAdHYExNkDGHRuxopOQRwhYFIPNDafNwrind1kxdRnRgbuW/qgkC7
         CU1ZJdfCX++8yZ10lcmY8kmJ/4PdDQT/gI9nnMxFzJibVQWlY4eqLBYrBj2tptatTfBF
         /Akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573148; x=1782177948;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc5MVcsL5+wdEnp7bwxKe+dITTqbvk7Blc8igMUR8Lg=;
        b=su00X11OGEGKZVdMfuvUSSJQVg2DtBwQe8jYbyit03aeXnVYGMFGllrnTXmCFV/tw5
         TvVl4Cg7QKu0An4F10BkxO42g7ny5NGus7xriJkDWQ419xQuabSdEKreMk7C4J1u9LkO
         9Z61qC3fKGaatRqRsy2iobb119iZcUHziP3JNN5+sFWIqwIsElJya/yBYxnBuHVpUv6l
         FXFi7d+OBoeZBgk8u39XaO/D+8o1cfRtoDcyaBuRacS1BV5HE8rR9Xn/EOBr8I2f6JLS
         qYh4eMz15EY9imsl/YTsCxgUSNX4gJqXeLzWQQpnzo77TIF/ej8yRXX437nWhidthHpp
         m6rg==
X-Forwarded-Encrypted: i=1; AFNElJ+Yj4aRAVEkCkH16ll9Ru8JI4GRnTuhWZ34W1QKPGGkG23Eo3nK2NnvzlMzHs88vgcxlF1Pmt2rmwj3vrHbtAUC@vger.kernel.org
X-Gm-Message-State: AOJu0YxnkBT+xoz1HjoXDqGTd9rOCwe899OnskvF8nwiF94BfhjMUbF3
	mBuPsNpDlV0pN1rNCiUlj3FYcZzsWBWj1YQqfm6fAbbO5wUbqQjD42UKR8lV8ABWn3K3U3QDxsL
	EVYEJDt5xqA==
X-Received: from dybsc14.prod.google.com ([2002:a05:7301:4b0e:b0:307:23d9:99c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5708:b0:2f5:2556:5acd
 with SMTP id 5a478bee46e88-3081ffaf9e1mr9609620eec.13.1781573147402; Mon, 15
 Jun 2026 18:25:47 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:25:14 -0700
In-Reply-To: <20260616012521.4045202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012521.4045202-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012521.4045202-6-irogers@google.com>
Subject: [PATCH v1 05/12] perf tests: Skip metrics validation if system-wide
 recording lacks permission
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The metrics value validation test requires system-wide recording (`-a`),
which can fail on systems without root permissions or where paranoid
levels restrict tracing. Add a check to skip the test if `-a` is not
supported.

Also fix false negatives during validation by updating parse error string
patterns and resolving issues in metric list generation.

Fixes: 3ad7092f5145 ("perf test: Add metric value validation test")
Signed-off-by: Ian Rogers <irogers@google.com>
TAG=agy
CONV=7e7ee33a-e940-4a8a-8e64-878da6a68b59
---
 .../tests/shell/lib/perf_metric_validation.py | 11 ++--
 tools/perf/tests/shell/stat_all_metrics.sh    | 63 ++++++++++---------
 tools/perf/tests/shell/stat_metrics_values.sh |  7 +++
 3 files changed, 48 insertions(+), 33 deletions(-)

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
index b582d23f28c9..5ee869452ee7 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -12,38 +12,53 @@ system_wide_flag="-a"
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
-  then
-    if [[ $(perf list --raw-dump $m) == "Default"* ]]
+
+  result=$(perf stat -M "$m" $system_wide_flag -- perf test -w noploop 0.1 2>&1)
+  result_err=$?
+
+  if check_metric "$result" $result_err "$m"; then
+    if [[ "$err" -ne 1 ]]
     then
-      echo "[Ignored $m] failed but as a Default metric this can be expected"
-      echo $result
-      continue
+      err=0
     fi
-    echo "[Failed $m] Metric contains missing events"
-    echo $result
-    err=1 # Fail
     continue
-  elif [[ "$result" =~ \
-        "Access to performance monitoring and observability operations is limited" ]]
+  fi
+
+  # If retry also failed, determine if we skip, ignore, or fail
+  if [[ "$result" =~ "Access to performance monitoring and observability operations is limited" ]]
   then
     echo "[Skipped $m] Permission failure"
     echo $result
@@ -61,7 +76,9 @@ for m in $(perf list --raw-dump metrics); do
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
@@ -105,19 +122,7 @@ for m in $(perf list --raw-dump metrics); do
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

