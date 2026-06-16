Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34F37D107
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573283; cv=none; b=DHuivsJaH5vSgfmrx9TeoHdHZz3Y4g5kVDQcyljzUwrngReI9QjBQUiY8CR5Q6WbSP3a+aigNK9mYv/5E2oPKzZN2JSjYrXV0e6WCBvqn+9Z+DNxjKEP+JAD5dY47MkXOH1yNFGEIqd40op/6WUHAxnrGzyjkQPGKkeLKtbcZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573283; c=relaxed/simple;
	bh=N84R/GNyF73og9fH6qgDolhwDPgl2tM5sIiTaWNlP8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=T3L7ENnsaQYjAAFotqiTgKlU8tRKdkxnaX+9T4fZ+qZdbWfoIdjY+iXEErFlIchYCAufN7jml7tXUPc47O0HsWmAu8Vyf32ZuHWv2yT02EYOgRx9+3pf2Wga6xOPo9hbNAA3pOEI29PJzureYpT2IXGnIqg/Q4VNDXolNjkadJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RcGUCaFY; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RcGUCaFY"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1361d52b3a0so4782697c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573281; x=1782178081; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZN7oaZiYetKkM4funzugfk4Rmu6NQMJeZAG5RjuOFo=;
        b=RcGUCaFYVjhyPRoXkm7JNyyG7lBqMULIIKHI8iFuzd2f05vsylI+BLEkpkvDB1UYJt
         PAO2XSQx1rXcsI1J7wRHnFlKSo+PYv6CACArGpzCAjbMm6VzmVjaSnDqs7iOSi2YBeQ/
         RaxlWc8I6uJpcXLcxzwmy9VT6vryaQpmoEmmhOeT8+wg7SVbc28k7fnZhuRuMZfUOmVx
         5tUtu5r2MYNEWnV/7XTqDKAdGnNFaiJ+mLGLz8m/HkEE7KdCHZXbNRzNlp4kOxY77Vy8
         RpYk2FHbZZcPEp0Pnry+m9K9y5PHre8isB3hjxFIjlerOcHymLN+9HmDC7W5irqTJxe/
         x5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573281; x=1782178081;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZN7oaZiYetKkM4funzugfk4Rmu6NQMJeZAG5RjuOFo=;
        b=g0Jr3pZgZiUP+xSZw96oKp171KpD4hlHMsedE7IwKUA73A0ofTEzjsLaaTViE1tKJo
         EzYZT5a4TjGgWaOZjPqf9Ew83wEm9e9ouqMTyfr1o4IYcpPOde1KqObh8LfQ2YFCOfkA
         HcdOScdsflrit3QEX/rSwzP8owIX2DoRYg3iIb2fF7YgOb/6LY8rRB9PTH1K5JFzWBKB
         9FF4K4sXKqMtihssPYaW4/V66ceW0LPjAYFXHsrCsAwQ/xoxUPhvqckBOS3As7GF0MT6
         fbuKf/CrqtsgQLrGoTIYUoQXS/2/njWFSO0UvnbDctz7asRYQh/VTYd5kc6WPJHSkybP
         qHFA==
X-Forwarded-Encrypted: i=1; AFNElJ+4FMIhUJukN7dlFoOcbbrWFi3bUpL09jOxA5QxcA4A98nWa2ZboO4TtoXCaApTUK/MN4suJP9Vkr8tuF/DnS66@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8fV2jlfH1BnISlEDZ/O/ldOpHFRtKhnx3P51hF654qJhPOvS
	hln7+X4jq1mmOziIqOFN6vbEgoU5WVaywKq74jfEjL35EKWQysu3PlOnXA8MqxltbRZmZoOzL6R
	4X2qgoDZvUQ==
X-Received: from dlbcj30.prod.google.com ([2002:a05:7022:699e:b0:135:b432:37dc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4504:20b0:139:879c:dba1
 with SMTP id a92af1059eb24-139879cdcc8mr151546c88.5.1781573280886; Mon, 15
 Jun 2026 18:28:00 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:27:38 -0700
In-Reply-To: <20260616012744.4049193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012744.4049193-7-irogers@google.com>
Subject: [PATCH v1 06/12] perf tests: Fix Python JIT dump profiling test failure
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The `python profiling with jitdump` test failed due to:
1. Target PID extraction resolving to duplicate space-separated values,
   which broke the buildid-cache loops.
2. The default workload duration being too short to capture JIT stack
   trampoline samples, resulting in 0 matching JIT symbols.

Fix the PID parsing by sorting and retrieving a unique single-line value.
Implement a robust retry loop starting at 1M python loop iterations and
scaling up to 100M iterations until JIT symbols are successfully captured
and verified.

Fixes: c9cd0c7e529e ("perf test: Add python JIT dump test")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/jitdump-python.sh | 66 +++++++++++++++---------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/tools/perf/tests/shell/jitdump-python.sh b/tools/perf/tests/shell/jitdump-python.sh
index ae86203b14a2..6f3d1edd6f04 100755
--- a/tools/perf/tests/shell/jitdump-python.sh
+++ b/tools/perf/tests/shell/jitdump-python.sh
@@ -20,7 +20,10 @@ PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXXX)
 
 cleanup() {
     echo "Cleaning up files..."
-    rm -f ${PERF_DATA} ${PERF_DATA}.jit /tmp/jit-${PID}.dump /tmp/jitted-${PID}-*.so 2> /dev/null
+    rm -f ${PERF_DATA} ${PERF_DATA}.jit 2> /dev/null
+    for p in ${ALL_PIDS}; do
+        rm -f /tmp/jit-${p}.dump /tmp/jitted-${p}-*.so 2> /dev/null
+    done
 
     trap - EXIT TERM INT
 }
@@ -33,9 +36,11 @@ trap_cleanup() {
 
 trap trap_cleanup EXIT TERM INT
 
-echo "Run python with -Xperf_jit"
-cat <<EOF | perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}" \
-		 -- ${PYTHON} -Xperf_jit
+ALL_PIDS=""
+NUM=0
+for iterations in 1000000 10000000 50000000 100000000; do
+    echo "Running with $iterations iterations..."
+    cat <<EOF | perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}" -- ${PYTHON} -Xperf_jit
 def foo(n):
     result = 0
     for _ in range(n):
@@ -49,29 +54,40 @@ def baz(n):
     bar(n)
 
 if __name__ == "__main__":
-    baz(1000000)
+    baz($iterations)
 EOF
 
-# extract PID of the target process from the data
-_PID=$(perf report -i "${PERF_DATA}" -F pid -q -g none | cut -d: -f1 -s)
-PID=$(echo -n $_PID)  # remove newlines
-
-echo "Generate JIT-ed DSOs using perf inject"
-DEBUGINFOD_URLS='' perf inject -i "${PERF_DATA}" -j -o "${PERF_DATA}.jit"
-
-echo "Add JIT-ed DSOs to the build-ID cache"
-for F in /tmp/jitted-${PID}-*.so; do
-  perf buildid-cache -a "${F}"
-done
-
-echo "Check the symbol containing the function/module name"
-NUM=$(perf report -i "${PERF_DATA}.jit" -s sym | grep -cE 'py::(foo|bar|baz):<stdin>')
-
-echo "Found ${NUM} matching lines"
-
-echo "Remove JIT-ed DSOs from the build-ID cache"
-for F in /tmp/jitted-${PID}-*.so; do
-  perf buildid-cache -r "${F}"
+    # extract PID of the target process from the data
+    PID=$(perf report -i "${PERF_DATA}" --stdio -F pid -q -g none | \
+          cut -d: -f1 -s | sort -u | head -n 1 | tr -d ' ')
+    if [ -z "${PID}" ]; then
+        echo "Failed to get PID, retrying..."
+        continue
+    fi
+    ALL_PIDS="${ALL_PIDS} ${PID}"
+
+    echo "Generate JIT-ed DSOs using perf inject"
+    DEBUGINFOD_URLS='' perf inject -i "${PERF_DATA}" -j -o "${PERF_DATA}.jit"
+
+    echo "Add JIT-ed DSOs to the build-ID cache"
+    for F in /tmp/jitted-${PID}-*.so; do
+        perf buildid-cache -a "${F}"
+    done
+
+    echo "Check the symbol containing the function/module name"
+    NUM=$(perf report -i "${PERF_DATA}.jit" -s sym --stdio | grep -cE 'py::(foo|bar|baz):<stdin>')
+
+    echo "Remove JIT-ed DSOs from the build-ID cache"
+    for F in /tmp/jitted-${PID}-*.so; do
+        perf buildid-cache -r "${F}"
+    done
+    rm -f /tmp/jitted-${PID}-*.so /tmp/jit-${PID}.dump 2>/dev/null
+
+    if [ "${NUM}" -gt 0 ]; then
+        echo "Success: found ${NUM} matching lines"
+        break
+    fi
+    echo "No matching lines found, retrying with more iterations..."
 done
 
 cleanup
-- 
2.54.0.1136.gdb2ca164c4-goog

