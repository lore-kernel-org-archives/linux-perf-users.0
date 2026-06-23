Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE16378D7F
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178097; cv=none; b=hu+UuvxikB0PEmV20WHzqMeRKz0H5rcMuVpSkCefdS/PGkWjelU+SPPojwlrjxaXMSNebRh3kzLuFFTLX+If/cmNQFOgXgFgYeAJkdJPHeMDAYlUfKwA2ug1xA3QR5Lj/I31ROKRQyvBRJV++J23wI9YuC3uK62RvYEi9fzavqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178097; c=relaxed/simple;
	bh=jTb3p1IMW7aryiOtj4nikRp+AlrknEyQ0MzydkC68/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ACstCWS4DbMzB3cEGhUy9Dzlg9Nvtm1xPlSxDPyMRAC82KzGE5lQB5X0VBgMLTNkOPv0kzQCttkqLnYIrw48F9UMYL2aCQuOowcOwZwKeGonV2B78QBfmwXvbW8lKgzi0reU+xzUuzGsI1D0sIn38jKU9TOosRVnX3Q8ohZBe9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbfJSl/y; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbfJSl/y"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-139553dd8acso21868362c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782178095; x=1782782895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=noKa1l0gTswSgBvrwJx+hXyFfqm9q8SD0C85Fez6Fzw=;
        b=kbfJSl/yirOdbeqMAlRsGH7K96fBEcFYAK41Q20L3x/vBQdGYjzql1zlnDS+9Ngeqb
         hKmOchAUppVpU3e8nnOCfhDTpidwIxYH6DxiP7yOpA6wwUv7VFRbGmqe+35lzRrIcaxL
         mJXrQhdaCKG9/mgIT9WdCNOI9FlbgEMFDNV/b+G37I028tva74pL8KWElqJmPAchQ3Id
         cUIEQmUMaf8VttcN0qsXrpkHYM7cOwckacJr7VlgPBGznvfPVZdABVHpfp1Yh9YH8jXG
         nsF8Z9JGh88KYgx/IbMN6hezZkARyRGR6Td9Fvq5aYjOBVfvjKo2OL8Z5sfRJISXC23V
         mWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782178095; x=1782782895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noKa1l0gTswSgBvrwJx+hXyFfqm9q8SD0C85Fez6Fzw=;
        b=htnQVz0Z9eHLBLeIczI7pROF+VHmb7x7NJOTo4u0VUczqURrz6Z/Ldq2Y9pPUxjpYs
         XicjBhPrV4ABJf8OU1BZoVPGrIWhQQnmACJUWRLKGU5Pwa7DJiwRnUl8UkycGcfXy2R9
         8BsEApNfQ4OJeqg7nw8i1K/PUbHbWuvqprg75s9KnWl9mA60LNbakaNzuCsXAFYo2mXf
         R1+7oOgzp+LHns2DLjdArfhZmKSpaYJg3Tyxy2RaLZTduW/umEWUS0XJ5bRNgjg/3d2A
         u2Fed2B6AKEDG/zc267CLeXuZor92U1KvMWXMYnbGXHEDXjGUCFZdjw2CpZTFSSxWpdR
         rfxw==
X-Forwarded-Encrypted: i=1; AFNElJ8wictoHtMflQFhKVK3mcTSWfBLIl+fF8FS7CG2w3UqiNrRpKC+GHeAaESkIP1WCiNk/wJRpptCiJkx1jiX6/ML@vger.kernel.org
X-Gm-Message-State: AOJu0Yy58pxW78U0pn+jG5Ax5pgnCdoWVyUwVNjrXbB0sUoRVPduFNi7
	Zgtodn2lVHKZebwTxGVeveLNbnA02N9Uj1XQ/qO3tTWfSSN/88HgPfRejCqROjRAPzn3Mopr2yk
	pr57fN0My7A==
X-Received: from dlbay39.prod.google.com ([2002:a05:7022:6627:b0:139:c523:65fd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3d18:b0:137:1ae1:bc19
 with SMTP id a92af1059eb24-139a34e4cfemr10341056c88.5.1782178094861; Mon, 22
 Jun 2026 18:28:14 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:27:51 -0700
In-Reply-To: <20260623012758.2291858-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616164819.370939-1-irogers@google.com> <20260623012758.2291858-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623012758.2291858-7-irogers@google.com>
Subject: [PATCH v4 06/13] perf tests: Fix Python JIT dump profiling test failure
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
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
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/jitdump-python.sh | 79 ++++++++++++++++--------
 1 file changed, 53 insertions(+), 26 deletions(-)

diff --git a/tools/perf/tests/shell/jitdump-python.sh b/tools/perf/tests/shell/jitdump-python.sh
index ae86203b14a2..05aaa3bd900b 100755
--- a/tools/perf/tests/shell/jitdump-python.sh
+++ b/tools/perf/tests/shell/jitdump-python.sh
@@ -16,11 +16,15 @@ if [ "${HAS_PERF_JIT}" != "True" ]; then
     exit 2
 fi
 
-PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXXX)
+PERF_DATA_DIR=$(mktemp -d /tmp/__perf_test.perf.data.dir.XXXXXX)
+PERF_DATA="${PERF_DATA_DIR}/perf.data"
 
 cleanup() {
     echo "Cleaning up files..."
-    rm -f ${PERF_DATA} ${PERF_DATA}.jit /tmp/jit-${PID}.dump /tmp/jitted-${PID}-*.so 2> /dev/null
+    rm -rf ${PERF_DATA_DIR} 2> /dev/null
+    for p in ${ALL_PIDS}; do
+        rm -f /tmp/jit-${p}.dump /tmp/jitted-${p}-*.so 2> /dev/null
+    done
 
     trap - EXIT TERM INT
 }
@@ -33,9 +37,16 @@ trap_cleanup() {
 
 trap trap_cleanup EXIT TERM INT
 
-echo "Run python with -Xperf_jit"
-cat <<EOF | perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}" \
-		 -- ${PYTHON} -Xperf_jit
+ALL_PIDS=""
+NUM=0
+for iterations in 1000000 10000000 50000000 100000000; do
+    echo "Running with $iterations iterations..."
+    rm -f "${PERF_DATA}.pid"
+    cat <<EOF | perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}" -- ${PYTHON} -Xperf_jit
+import os
+with open("${PERF_DATA}.pid", "w") as f:
+    f.write(str(os.getpid()))
+
 def foo(n):
     result = 0
     for _ in range(n):
@@ -49,29 +60,45 @@ def baz(n):
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
+    if [ -f "${PERF_DATA}.pid" ]; then
+        REAL_PID=$(cat "${PERF_DATA}.pid")
+        ALL_PIDS="${ALL_PIDS} ${REAL_PID}"
+    fi
+
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
2.55.0.rc0.786.g65d90a0328-goog

