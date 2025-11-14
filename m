Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF92B661;
	Fri, 14 Nov 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112557; cv=none; b=FVPeZ2KhCwpmHAkWYYEoG8WAnFM6Sc6yLBDjXQeWNjkUelgo/hdx57H/m1K3ke50O/ghCWSfYWYGUfrUINAhoStmYxLDXQH5LW24Fcvl6kgnsBm+aBmDn34K0xnJuakl21MWyF2gAMCVmUgJE+maENGzcekd5pHttdLmHWwC4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112557; c=relaxed/simple;
	bh=DYUK+U7VGS5kFckeTD5pV+fpOuuiwjPb3luYW4k0xv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iB2SzC2CB3ae3kWnEWgP5KEnnqtn0sKQwwcZetMY89lT3C0esCSBoEsfNwZvhAxgeeoC+/7fMXt1kM2ejyeqB0s56WE1i9pgyTCwmpmbthALfgLYNAPOaEifQaUsn62+9pmgIZbBhd6CPNhn1g4e9YA4DnNPEjkMvEFKIATiu40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw7a6fDu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw7a6fDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA0AC16AAE;
	Fri, 14 Nov 2025 09:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763112556;
	bh=DYUK+U7VGS5kFckeTD5pV+fpOuuiwjPb3luYW4k0xv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dw7a6fDugox4PSfrsfz6LCv91E+nwXjMaGpYKwW/Y3KgG+JYaEPbw9oTXJhrsLGMA
	 aC3+ZypMTWBaTmsrw8t59io8jr5U/DTa71/22XYd1Z1EUsGTN0o4mDsuXhryJwh9BL
	 VySN23y85YrHCpa1BV9hGfCoBsKiW5FEraI7GJAz9tm49aDJE0IX0jv2D35xWiq5EP
	 nGx49Boc/eQSkT+jzSFSxV4b+yV/GYZGljalB/rxtM4VzIVBeyg7Er7tUxknc8Tsg5
	 Yj+r3Vst70v4rvt+fGSV1zNc+PrQ3hrBGThcfr5sb/ZdFbverpgXPgZCHSaoLzHTEM
	 C4NsPhsPVn97Q==
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
Subject: [PATCH 2/2] perf test: Add python JIT dump test
Date: Fri, 14 Nov 2025 01:29:14 -0800
Message-ID: <20251114092914.217533-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114092914.217533-1-namhyung@kernel.org>
References: <20251114092914.217533-1-namhyung@kernel.org>
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
 tools/perf/tests/shell/jitdump-python.sh | 41 ++++++++++++++++++++++++
 tools/perf/tests/shell/jitdump-test.py   | 14 ++++++++
 2 files changed, 55 insertions(+)
 create mode 100755 tools/perf/tests/shell/jitdump-python.sh
 create mode 100644 tools/perf/tests/shell/jitdump-test.py

diff --git a/tools/perf/tests/shell/jitdump-python.sh b/tools/perf/tests/shell/jitdump-python.sh
new file mode 100755
index 0000000000000000..101c15e65da1a0c0
--- /dev/null
+++ b/tools/perf/tests/shell/jitdump-python.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+# python profiling with jitdump
+# SPDX-License-Identifier: GPL-2.0
+
+if ! command -v python > /dev/null; then
+    echo "Skip: no python found"
+    exit 2
+fi
+
+SHELLDIR=$(dirname $0)
+PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXXX)
+
+echo "Run python with -Xperf_jit"
+perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}" -- python -Xperf_jit ${SHELLDIR}/jitdump-test.py
+
+_PID=$(perf report -i "${PERF_DATA}" -F pid -q -g none | cut -d: -f1 -s)
+PID=$(echo -n $_PID)  # remove newlines
+
+echo "Generate JIT-ed DSOs using perf inject"
+perf inject -i "${PERF_DATA}" -j -o "${PERF_DATA}.jit"
+
+echo "Add JIT-ed DSOs to the build-ID cache"
+for F in /tmp/jitted-${PID}-*.so; do
+  perf buildid-cache -a "${F}"
+done
+
+echo "Check the symbol containing the script name"
+NUM=$(perf report -i "${PERF_DATA}.jit" -s sym | grep -c jitdump-test.py)
+
+echo "Found ${NUM} matching lines"
+
+echo "Remove JIT-ed DSOs from the build-ID cache"
+for F in /tmp/jitted-${PID}-*.so; do
+  perf buildid-cache -r "${F}"
+done
+
+rm -f ${PERF_DATA} ${PERF_DATA}.jit /tmp/jit-${PID}.dump /tmp/jitted-${PID}-*.so
+
+if [ "${NUM}" -eq 0 ]; then
+    exit 1
+fi
diff --git a/tools/perf/tests/shell/jitdump-test.py b/tools/perf/tests/shell/jitdump-test.py
new file mode 100644
index 0000000000000000..b427363ae4956db6
--- /dev/null
+++ b/tools/perf/tests/shell/jitdump-test.py
@@ -0,0 +1,14 @@
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
-- 
2.52.0.rc1.455.g30608eb744-goog

