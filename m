Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226CC47A0B2
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628519; cv=none; b=Wvn9gHL/BJmM4HBsxF9P5sdc9VvdFnIFy86Cyf4VQ/mvP/k+Re2SOoSe9FSHiYImc6a6yWMSDY6ayIzjp3ddWNB+BdABi+uNf8wcfk40UyPZ3ddN3qrjuQ4qa61IT5TCUZ79OzyPvxdWCkAtVHmJNvHhrG358OQcBoI9TeCTLgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628519; c=relaxed/simple;
	bh=wgJCM/bCdZsj0MmyUCa5TGtgOpUou6oBR1e+oYwTljs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QZ7eeLsICXSalmJdlpanJt4UvP9Wie3v8NuE6fXJsm58pVcTS1p/H9qtiAxh9E3daMrSiqWgeEjLC3Xl0NTkPul09DBxw9kmqdFSQr0RfCiarLq6Fo/qC6sNOpGolxMkANuQr2b8N8DjZcMu1gu8UNWN4kh2wFvZwrwEDP1gZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+uUF3Oe; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+uUF3Oe"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30bc5f826f2so409274eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628517; x=1782233317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JrA7gYA2WQs2Vx2X1W4DgwiJrh9ev2Ak+8/YtqoFNSw=;
        b=U+uUF3OequeVv8tPrBEeZYYO71+AwkD6LgPov4WHRTjzQyAVvXF8kLHJ79b7GEeYJ6
         MFADaEXL2drKxy/f+nnmk6zErUBs2mkjj5hZ7OT4MUYgpYgznMPOpyMQ2hAk61v02dJ8
         0hfxUO36m7NBWM3x2bYIDHkmnxtIOHGSQjERAN35/DF2fCWPmwgcWlQalldOXdphKCf4
         m854fGNirK3uXgDatt4svriwtILRK7pa9kkwrbqJTi1vFxtM8lJm5rKS7RO0p/OjgyIr
         BeSMSb0bNVT9n2yE+aMW4+93dnu1gA2zecKJUZBNFqEzi5iw07uwGy1mDFAW0kk3Zx7w
         6NHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628517; x=1782233317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrA7gYA2WQs2Vx2X1W4DgwiJrh9ev2Ak+8/YtqoFNSw=;
        b=lLS5a5050DVmv6HhZVOLVKHmpislkp8P6/+JccmGExYhqn1mjzET5vL42xPXhCh3qc
         x5QavRPWtfb91tC+Dz9xtBEn0OX/whFCkWhe301uzFq3MBFLt3+Sma2TP3IZ7o+GEFr7
         BQARSGqozD0ywg5JlC7qLQ88YSI2ftKgm45oYZPllZMkeV1raLG1a0CC0+nlh/5BTmJD
         2IGwpTxPADiOmZZEqyXIEVK230lRSooY937/oGzNiN2ErqAvHtgukp1sqo1Q7mYxfv1f
         ogXuwMNQinR1GQDHX7PFi15JwD5APba7A335sDBhpGkOphoCsdrZ+Ya3S6JfTK4h7g29
         sGbw==
X-Forwarded-Encrypted: i=1; AFNElJ9VbwjkeAKF/v7h7KXRsQDne7sg5Ohzy4Dxy3L7hJJfKXQiZ+Vw3c6ZokktUNqjT3YDQTjCayand5HqaRanC1Ok@vger.kernel.org
X-Gm-Message-State: AOJu0YygrjqztzwN6UaT/QSBrqkYXLD4+2FTYT9MgjwF7ld/SXjjvyMx
	fa4cT3muOK9hoHa/CVHPPvd3fFgYflZ+eY36GRDlGQIfVL+HYdwpTmI+Ne0nHgFwXtuoslweU3k
	7nIToId7FgA==
X-Received: from dycsb13.prod.google.com ([2002:a05:693c:300d:b0:2ee:2c3a:8aaf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:ea5:b0:2e2:4979:ec7
 with SMTP id 5a478bee46e88-30bca94976emr13666eec.10.1781628516910; Tue, 16
 Jun 2026 09:48:36 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:11 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-7-irogers@google.com>
Subject: [PATCH v3 06/13] perf tests: Fix Python JIT dump profiling test failure
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
2.54.0.1189.g8c84645362-goog

