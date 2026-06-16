Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8BE3DA7F7
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590463; cv=none; b=o0Aqa92we2bnMy4gEWY1ad3vaaL/M6D/cgkecDmShF28/ZGHlrkFIMi52LrI2IV8cAOQQfDeQPOM0n86nyKeE+SJAsCyfckmVfZ8wtaBRbYNv4Lk1hMS4/UdkE+99h1fvzpx/RsgEEm9adHy1CScb9vyAtzOZ8F4A3WoSikIM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590463; c=relaxed/simple;
	bh=vl09NUTIgR4I2sPT+ijXo/wqoJPFK+xq+7nrGGfHlPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ATt+DF3Lver5+4qCvu79pDkyDSyg6MEDlzrEdyH6XvvjJJfK9eJ13HUAcqxjXrHjos8k0ud4Df1AtIFtWfOe9IKO7emjZfCOrSC86tTPo0dgdwYcoGRGd+diPGuvkcfBd5+RGP8XBnnoJnpEedfy8HzItuwtdY7kQXyZaMMHIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NYPslBmg; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYPslBmg"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d8613efbso4939622eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781590461; x=1782195261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=duN/u/LwjhNpessNfRzsayi44Fg+em3V06as4NgzcfM=;
        b=NYPslBmgfxL6gIfNCRdU4Vg/TpFETkfY0M4DnuIHVlQlWfqLAz+9c+HDHDCdx9Sh38
         2UZWUuWZlwN1V4gEfJiu18wHuVUlxfcm6KNllpPxTikViNv/bokBSn+XHmFy11aG5WLm
         bL6VKlIF4heHKSqypaufvb9XyaXhW8kR3sZ/7TU4Ne5deUIGckiuuxjM1/T4ZW7jMzQi
         M+M6cZqEkyQfR86N2TCq3dtrjGVaRqQ0ENwNKL6KfrNETXSxGCi8jaepAqszfzCD4huC
         eiIeD9R/8iZZWve3XRdbBdxKrgHOKazIfrcjYsDImzau+Hwnc1AA7L9KGvpProgAftnW
         gZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590461; x=1782195261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duN/u/LwjhNpessNfRzsayi44Fg+em3V06as4NgzcfM=;
        b=Ikgbq4YWk5qjWEXJDtlEPylzsIVAD8ULE76vue4/E47EgvX7ebK1EC/O5Bo8PoZLJ3
         nhegL1rnYmEf2SvGgEhW6Cx/yZhJbxe04Kw60gqBndBR4nR7wJDBLy16iIhUaSxAMwzr
         55HbcCksSyHavRHA5gzQIOULFMICkmqKAYJHM7Zmz+LJau73W4/4SexFu9auATq7ida4
         vDTgT23BdhhF7fjgDpDeP5/UybeTEgkYB21knCw2shdmg98EGaXwaRMhq4+CKtCcxly+
         AQeR8yTFV4O/sIhY+sNTH1vHx1HTYe+h78kLEWIfIfRr6TlN1AgKvy6rca2ZvcMKpfrj
         SlYA==
X-Forwarded-Encrypted: i=1; AFNElJ9rgbdf73646So7Xp7rF1KpaYLk9fjx3vRYHU+3P99DCAUKQ2LnbDAwA2szo2NTqFqYnuWrOQPQSOwamdSGwVwr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+WJYoP20f3vPyHKU68VDARsdHo6PT7IKKtqxeeySmLM+ZAsH
	NirrC6Db8rIV2zz4jPZCryg4FRYcDFB5TUc0djLGIZDX4UyTh++HESPz/6VoEnQnfUhDji/R9Rk
	kpZDH1AuRqg==
X-Received: from dyaa8.prod.google.com ([2002:a05:693c:40c8:b0:30b:b82c:20e6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1827:b0:2dd:8ac2:9f7a
 with SMTP id 5a478bee46e88-30ba59d3517mr1511522eec.11.1781590460579; Mon, 15
 Jun 2026 23:14:20 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:13:58 -0700
In-Reply-To: <20260616061404.41929-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com> <20260616061404.41929-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616061404.41929-7-irogers@google.com>
Subject: [PATCH v2 06/12] perf tests: Fix Python JIT dump profiling test failure
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
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/jitdump-python.sh | 76 ++++++++++++++++--------
 1 file changed, 51 insertions(+), 25 deletions(-)

diff --git a/tools/perf/tests/shell/jitdump-python.sh b/tools/perf/tests/shell/jitdump-python.sh
index ae86203b14a2..dd4a401cd245 100755
--- a/tools/perf/tests/shell/jitdump-python.sh
+++ b/tools/perf/tests/shell/jitdump-python.sh
@@ -20,7 +20,10 @@ PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXXX)
 
 cleanup() {
     echo "Cleaning up files..."
-    rm -f ${PERF_DATA} ${PERF_DATA}.jit /tmp/jit-${PID}.dump /tmp/jitted-${PID}-*.so 2> /dev/null
+    rm -f ${PERF_DATA} ${PERF_DATA}.jit ${PERF_DATA}.pid 2> /dev/null
+    for p in ${ALL_PIDS}; do
+        rm -f /tmp/jit-${p}.dump /tmp/jitted-${p}-*.so 2> /dev/null
+    done
 
     trap - EXIT TERM INT
 }
@@ -33,9 +36,16 @@ trap_cleanup() {
 
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
@@ -49,29 +59,45 @@ def baz(n):
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
2.54.0.1136.gdb2ca164c4-goog

