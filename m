Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22442D6619;
	Tue, 25 Nov 2025 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764058070; cv=none; b=lSUO7IsKjJJ/SXEy0gEI/je1mSge+iRf/cDL7nfi8BeYRS64BqYcMRWg6XehQs4TonSS+vTJUhLXufEuXpNKglUof4i5zG5yTVd74WXusAB1DrYCLa+Cfa9ASR139zIStvXt5FdNXtPxww7rkT6T9F1mYPVYILNBZIQLE48yuTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764058070; c=relaxed/simple;
	bh=C42mtGso90o4KVPb1YHqzWm9PZ+3ey0qCaJdlerJnOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcMHH7DNIPw+ma08gMhsKUM9hjHzg/uPU1idgKt+2xwYCcobZ6rDjVeC6f0LnIGuS3gk9WsUJGn+f0NV31V8MRyo3lpmIfsYlQEUlfrcu0DCc+3e+vNn69W8/r+pX9XJUdCm4IaHpRVFEa9R9u6ocwbdesn3ZsuH+swcMjWo24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrZuqA/D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrZuqA/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFB3C16AAE;
	Tue, 25 Nov 2025 08:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764058069;
	bh=C42mtGso90o4KVPb1YHqzWm9PZ+3ey0qCaJdlerJnOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NrZuqA/DfAJFRuPV0/+ZroVRXsWPmOiQ3wm4OcEGuiZV2cKoOKJJKX4zBUwb38/KJ
	 fVBtlW01FvoGZiE+b/UWjuCFaIuDO1hdOE7JRVPkIjpGEO5Qv1DKaypJkmSGV4SP6Q
	 vMynzO2gaWPf++ubv96Wbvkg8KrZDyvk6qpXSZDV3OTaOo/pa7yjE/cjSKwM0dKNPv
	 HARgayajb6C4hz2gFyNu+b5cS65+N2/o7lpN2NYWavUU5HVvxaRcl/JmqPzgXlu5L4
	 Ka3lLOZWKNhEbh32SRMj6eLce083nlGG8Ymi2i1y0j3Hh1Xk8m5XM1J9Dv2gUG+Pwb
	 yc3hCstp1XnZg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Pablo Galindo <pablogsal@gmail.com>
Subject: [PATCH v2 2/2] perf test: Add python JIT dump test
Date: Tue, 25 Nov 2025 00:07:47 -0800
Message-ID: <20251125080748.461014-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251125080748.461014-1-namhyung@kernel.org>
References: <20251125080748.461014-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case for the python interpreter like below so that we can
make sure it won't break again.  To validate the effect of build-ID
generation, it adds and removes the JIT'ed DSOs to/from the build-ID
cache for the test.

  $ perf test -vv jitdump
   84: python profiling with jitdump:
  --- start ---
  test child forked, pid 214316
  Run python with -Xperf_jit
  [ perf record: Woken up 5 times to write data ]
  [ perf record: Captured and wrote 1.180 MB /tmp/__perf_test.perf.data.XbqZNm (140 samples) ]
  Generate JIT-ed DSOs using perf inject
  Add JIT-ed DSOs to the build-ID cache
  Check the symbol containing the script name
  Found 108 matching lines
  Remove JIT-ed DSOs from the build-ID cache
  ---- end(0) ----
   84: python profiling with jitdump                                   : Ok

Cc: Pablo Galindo <pablogsal@gmail.com>
Link: https://docs.python.org/3/howto/perf_profiling.html#how-to-work-without-frame-pointers
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2 changes)
* check availability of -Xperf_jit properly  (Pablo)
* use setup_python.sh  (Ian)
* do not use a separate script file  (Ian)
* add cleanup function  (Ian)

 tools/perf/tests/shell/jitdump-python.sh | 81 ++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100755 tools/perf/tests/shell/jitdump-python.sh

diff --git a/tools/perf/tests/shell/jitdump-python.sh b/tools/perf/tests/shell/jitdump-python.sh
new file mode 100755
index 0000000000000000..ae86203b14a22b4e
--- /dev/null
+++ b/tools/perf/tests/shell/jitdump-python.sh
@@ -0,0 +1,81 @@
+#!/bin/bash
+# python profiling with jitdump
+# SPDX-License-Identifier: GPL-2.0
+
+SHELLDIR=$(dirname $0)
+# shellcheck source=lib/setup_python.sh
+. "${SHELLDIR}"/lib/setup_python.sh
+
+OUTPUT=$(${PYTHON} -Xperf_jit -c 'import os, sys; print(os.getpid(), sys.is_stack_trampoline_active())' 2> /dev/null)
+PID=${OUTPUT% *}
+HAS_PERF_JIT=${OUTPUT#* }
+
+rm -f /tmp/jit-${PID}.dump 2> /dev/null
+if [ "${HAS_PERF_JIT}" != "True" ]; then
+    echo "SKIP: python JIT dump is not available"
+    exit 2
+fi
+
+PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXXX)
+
+cleanup() {
+    echo "Cleaning up files..."
+    rm -f ${PERF_DATA} ${PERF_DATA}.jit /tmp/jit-${PID}.dump /tmp/jitted-${PID}-*.so 2> /dev/null
+
+    trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+    echo "Unexpected termination"
+    cleanup
+    exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
+echo "Run python with -Xperf_jit"
+cat <<EOF | perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}" \
+		 -- ${PYTHON} -Xperf_jit
+def foo(n):
+    result = 0
+    for _ in range(n):
+        result += 1
+    return result
+
+def bar(n):
+    foo(n)
+
+def baz(n):
+    bar(n)
+
+if __name__ == "__main__":
+    baz(1000000)
+EOF
+
+# extract PID of the target process from the data
+_PID=$(perf report -i "${PERF_DATA}" -F pid -q -g none | cut -d: -f1 -s)
+PID=$(echo -n $_PID)  # remove newlines
+
+echo "Generate JIT-ed DSOs using perf inject"
+DEBUGINFOD_URLS='' perf inject -i "${PERF_DATA}" -j -o "${PERF_DATA}.jit"
+
+echo "Add JIT-ed DSOs to the build-ID cache"
+for F in /tmp/jitted-${PID}-*.so; do
+  perf buildid-cache -a "${F}"
+done
+
+echo "Check the symbol containing the function/module name"
+NUM=$(perf report -i "${PERF_DATA}.jit" -s sym | grep -cE 'py::(foo|bar|baz):<stdin>')
+
+echo "Found ${NUM} matching lines"
+
+echo "Remove JIT-ed DSOs from the build-ID cache"
+for F in /tmp/jitted-${PID}-*.so; do
+  perf buildid-cache -r "${F}"
+done
+
+cleanup
+
+if [ "${NUM}" -eq 0 ]; then
+    exit 1
+fi
-- 
2.52.0.460.gd25c4c69ec-goog

