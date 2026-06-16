Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D6379C33
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573152; cv=none; b=NZslXdxn8BW6rmrV1zZsIsBsCO804/C1BQnExemgBhd6JZx2N3NK/l5op48Fqy5Mq/08KYhd9WkgbDevnttDTQ6ZE7xmhGJOciEJjmRaDhQh+UQio9gP6daneQZyyh9ogAwNLVnnsyWsRO+mJSh2J5E5aoBVpy+Sv57UrVPRASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573152; c=relaxed/simple;
	bh=BK64Kqwb/tIFvW5WoTtoKaE/AOp7Q5S3xeReynjE/HY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YjJbPO+DO/sgTPfQa7Y5mzO83UVmrBuN12p5BGibFV/BtcY2YdVuYDqHFChAaV1q/SBPS3GB8D3CBhkE1a1L7QVtgQf/IvdsVHtKW/eiszzlPSW6OxLltZ6p2mHL6e6DdunGMxxdeB/dSwsm6+TBB5Qhy/DLx4N3zT3hXoZ7Pu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKdjP9ZF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKdjP9ZF"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d985df4cfso4544732a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573150; x=1782177950; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHxjcNnCwoXY4g1FmMRexnnJWgocrcjaychGd24okEw=;
        b=VKdjP9ZFJQ4amB0fP/Uc/+neCLYc3wxLg+Td6myBdNA1TIaN6nhyMKXX/6797HBDx/
         L62yMASWxJlnrZcXvbPfV0qhXFLKg1Mkhnh8BxeyxBe50mrt/R4VUaf3YX82zVPjX0MM
         aVCqCRCvvVYszgfQOMtenZrNy76jXqS7bRd/p0ur13hIrhDihKVlHcJeZAltFc3jwdHa
         5cVgjt6oYagHIvNrHkkZt5UyHjILrTiN6+PLvSNUJ+dUOP2Nl4IVEFUUhnOwz44/7z44
         WH+bc6rMLE7kWhnPwC6tEx4/m66HM/CxI3rInDNXWiQVlFuThIuqflEY8eh/IVRD/xuw
         uk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573150; x=1782177950;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHxjcNnCwoXY4g1FmMRexnnJWgocrcjaychGd24okEw=;
        b=qoV7y3La8Zzj93S/C9J6taj5BGuJQDpJd65Bs0dUwqv4I4A+VRAmFFUyPPhIntwdPR
         g5JVt/eJH2mT/m3X3N5G/6mItGYk0Mj5giZ+iuVPhv5+UZXCLc5MwrKXZmgbABcbB33a
         4ONE0M48PRBJUSfvv7HQnakkC19dUkpWBNuj5J9/FjlUspbKyHPZIAkWeUH6azbT4iCe
         nrXEUcXkNgco3ertnrFMcHdPUVxDI13uoBAGlgMyxZ0/9X4yYmZcvi0n9qaHVd+YwjFU
         12ot3nOAYBoyALkrMz6aasQqbuDKJmzSKO05aNosAVdfaToD6/UKRLa23/dp9GnAU3U3
         2WZg==
X-Forwarded-Encrypted: i=1; AFNElJ92JjZUmCnW/FknbGj0h41frCa8OYovbv4DhjAL5ozMVNso7uVIKL+/Di1sC/rh3d+5JiZDtSdBJ9stetYvso99@vger.kernel.org
X-Gm-Message-State: AOJu0YzQSP2y4nnmFG8qbhk1dLYhJCv190hVxLfCO2w6/QvbslPVSQXQ
	Lc68Egf22M89WhsVOx6t5vsUie/nzeyYOQOP/h6K+x/+Ni7YmFNiuOcxoE1SjsjMfEdW170PoUc
	lCWfqMi8xFw==
X-Received: from pja11.prod.google.com ([2002:a17:90b:548b:b0:36a:8c96:fb54])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a87:b0:36d:dd4a:1e59
 with SMTP id 98e67ed59e1d1-37c52924a77mr1491893a91.23.1781573149446; Mon, 15
 Jun 2026 18:25:49 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:25:15 -0700
In-Reply-To: <20260616012521.4045202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012521.4045202-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012521.4045202-7-irogers@google.com>
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
TAG=agy
CONV=7e7ee33a-e940-4a8a-8e64-878da6a68b59
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

