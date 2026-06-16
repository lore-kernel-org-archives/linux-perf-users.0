Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E837B409
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573281; cv=none; b=rO/0AhnGeH45+GdqjeIZ8al4Glgdh9Egb9ZkgaBrSN2rk1h/q2e/U/n2EKEfgH8QY/Rdid9DUTCZaXiXiUQzK+AiYCMhdgEi5ONTHnNEPVusdb1qt2eaHB0cf6IBhRbTuNBrNs8bEay7JzFcSKqlVjZFZzax2LG3s0gc4cvcpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573281; c=relaxed/simple;
	bh=ieNSnk8InNx0eWkFhAIk4BmhDq8DzOe82rkgBbh3CqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LOg0f3Q8lFRJbFE/ILZjm7dhdLOLGfkACw0794Xn/m2N1klexRy1D0angDikwhz5z019Mnzl85mei8HQGqiQReomGQvC1UabeHIkDQChoGkRG7g/WDTtXYJFzwuzwNuwYn/3JBIeUk6ckvGdGhmTVeKc9mVnLEOxVeK5OcVeYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNCqlJHE; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNCqlJHE"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1382674ba2eso3734852c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573279; x=1782178079; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4hsL47I5zaiVnaLTQoCJyQZIinwq4aJZJZDWkCjxwRI=;
        b=jNCqlJHEcOlbSgtOAFN5sfZqwrXaoEjVlG7GdPuhkwlO2lMcXVU07Brr4JnRzm0aBd
         EChRiV0iH17NR49UK1npkRBTc7rA6t3XWPUO3Y5IuCgzLVjjt7c5Y3JVGgMTLLzH6Nve
         4suW9dWQItqZF9klsEzJ6Ih846rC8fYHHaOhUKPK+OqyImInvkkUH863skQREiuG95bM
         XlFuV4m2f1WDIn6q1VaOqkRxJvTMfR4tJ8BF/YPp2U2IQyPwGDuKlgGdrSAxr7W9aQrV
         UcBgnB05dj7nV2/a5hOWlDhxuUv7hgt79hBvOAfIVpf9JwAjh+3RrxOelHAO+lOCABwS
         +I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573279; x=1782178079;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hsL47I5zaiVnaLTQoCJyQZIinwq4aJZJZDWkCjxwRI=;
        b=JhbCcSjiAn+MASA9cVQUB0OpdePAkZVZCyOK/9qLhr8sZhKWr1wvo3ZsSueNqMrAuk
         yyyykMWKQStzHashhw6K8hZ+n3aZtOm5seRt2nw8+IO9dC/Jy9LZSp1n4WeI4A1Ffnmq
         WysJ4T4qXJkifi7PCXONphLa0VMFruSuEAZJzfFNV6Fw749X566Af1okLq9Qs3phCKVp
         JO2ptaDPxU1G17cwaOJqbEHAlPQiIb2YTJ0Xx+MGYMXK015s/GRLTf8ey011vEI2PrYq
         1Czqrb/KN4fjMLwCw0GZbu87nmChmO97alH918C2v5oUl4P0KBoR7nfr29AeeoSs8JI5
         UlGg==
X-Forwarded-Encrypted: i=1; AFNElJ/99ARmc2KeC9OtXVOxGxmazIlQqzivA8wwZ7RCslIaAIDgl+6aZS5UvJ16OikWjkEEz/dGBZuNw8GEMvf4u9cD@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJ/i5a/pqI21cN1UYbZT4H3di5XR1vYi0EfnlppDkVAEZZktR
	3I09dp67ptbSx6walfazaL2NYPOvRgndpyh5dJDx7vqF1KtJpQ15G0fhQOetXgDFiH0C3XuWUC2
	SEjqCNaHbUQ==
X-Received: from dled15-n2.prod.google.com ([2002:a05:701b:42cf:20b0:137:fb16:a9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fd08:b0:137:fe07:8a2c
 with SMTP id a92af1059eb24-1384bb698femr7071024c88.22.1781573279036; Mon, 15
 Jun 2026 18:27:59 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:27:37 -0700
In-Reply-To: <20260616012744.4049193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012744.4049193-6-irogers@google.com>
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

