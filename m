Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2793C00;
	Sat, 24 May 2025 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748046476; cv=none; b=rUIgVa2uuN3+UHVEy3ANnn3JVA+Xl+eCVqY7vXaK6iBR9UZwpv5Mhd2d4TNMaOq1XbOUK+85YS8L3IPtTUCeodu8M0d4/Ie87A/jieQqXr4sA1xA0riweO6K8GDmkdlzaTzj/ezPTUtyJsnTJ64xUb+URKatX5XtKBB+sBMnjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748046476; c=relaxed/simple;
	bh=xZ/ZxzGPjEtN2ZjLqUb6bOGqc1DvuT7nPvawxdSXWSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BZnBZDOqJK8/1J0O5XeeOiZWHLe6qjCpBnrlY+gK14i3vSLunfN4kypwDtU11Sy/UJ6u0kJ1kse0wucxiY8W2Y+mr617wXtA85iisrnsC3iFW2qhNYyVozGSllCtI4JKZgYCzkbSs+AUPDAkNAq08aESOyKYUDE4cwi9OZJSYXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmLVf26H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmLVf26H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18CFC4CEE9;
	Sat, 24 May 2025 00:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748046476;
	bh=xZ/ZxzGPjEtN2ZjLqUb6bOGqc1DvuT7nPvawxdSXWSI=;
	h=From:To:Cc:Subject:Date:From;
	b=TmLVf26HhZ7doSFz7hdO/hyoM9Dy87qb+SR3/5ukWZ2epsLbd3DUwEQxHvLfW3iU6
	 0/mL9XfeecgH6fV/BgraSxP7ThFzfNO9t7VFOqplNpusx6Tx8vzeg70gjlehUxJa44
	 I8h8SGr7zMagGwD/0fWa3+ZcJqcsMBlyLBR8cDKOZ78gFaIel7ssc7s0CwZfnL7tTr
	 IuCgfUj5weayUv0svNqTG2DuUFuRyWM+FW1mbhjQ0Adc4bD29vO4DI5SH7r0y2Zjyw
	 ZTa2TZc9GBsLpBFjBNuNMUd9fpRfkn8NV8u+xmR+jGbcY+tQxg1FbrF++XtDeLncgj
	 cNFc+UYQeI0vg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH v2] perf test: Add AMD IBS sw filter test
Date: Fri, 23 May 2025 17:27:54 -0700
Message-ID: <20250524002754.1266681-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel v6.14 added 'swfilt' to support privilege filtering in
software so that IBS can be used by regular users.  Add a test case in
x86 to verify the behavior.

  $ sudo perf test -vv 'IBS software filter'
  113: AMD IBS software filtering:
  --- start ---
  test child forked, pid 178826
  check availability of IBS swfilt
  run perf record with modifier and swfilt
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  check number of samples with swfilt
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.037 MB - ]
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.041 MB - ]
  ---- end(0) ----
  113: AMD IBS software filtering                                      : Ok

Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/amd-ibs-swfilt.sh | 67 ++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100755 tools/perf/tests/shell/amd-ibs-swfilt.sh

diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
new file mode 100755
index 0000000000000000..83937aa687ccd859
--- /dev/null
+++ b/tools/perf/tests/shell/amd-ibs-swfilt.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# AMD IBS software filtering
+
+echo "check availability of IBS swfilt"
+
+# check if IBS PMU is available
+if [ ! -d /sys/bus/event_source/devices/ibs_op ]; then
+    echo "[SKIP] IBS PMU does not exist"
+    exit 2
+fi
+
+# check if IBS PMU has swfilt format
+if [ ! -f /sys/bus/event_source/devices/ibs_op/format/swfilt ]; then
+    echo "[SKIP] IBS PMU does not have swfilt"
+    exit 2
+fi
+
+echo "run perf record with modifier and swfilt"
+
+# setting any modifiers should fail
+perf record -B -e ibs_op//u -o /dev/null true 2> /dev/null
+if [ $? -eq 0 ]; then
+    echo "[FAIL] IBS PMU should not accept exclude_kernel"
+    exit 1
+fi
+
+# setting it with swfilt should be fine
+perf record -B -e ibs_op/swfilt/u -o /dev/null true
+if [ $? -ne 0 ]; then
+    echo "[FAIL] IBS op PMU cannot handle swfilt for exclude_kernel"
+    exit 1
+fi
+
+# setting it with swfilt=1 should be fine
+perf record -B -e ibs_op/swfilt=1/k -o /dev/null true
+if [ $? -ne 0 ]; then
+    echo "[FAIL] IBS op PMU cannot handle swfilt for exclude_user"
+    exit 1
+fi
+
+# check ibs_fetch PMU as well
+perf record -B -e ibs_fetch/swfilt/u -o /dev/null true
+if [ $? -ne 0 ]; then
+    echo "[FAIL] IBS fetch PMU cannot handle swfilt for exclude_kernel"
+    exit 1
+fi
+
+# check system wide recording
+perf record -aB --synth=no -e ibs_op/swfilt/k -o /dev/null true
+if [ $? -ne 0 ]; then
+    echo "[FAIL] IBS op PMU cannot handle swfilt in system-wide mode"
+    exit 1
+fi
+
+echo "check number of samples with swfilt"
+
+kernel_sample=$(perf record -e ibs_op/swfilt/u -o- true | perf script -i- -F misc | grep -c ^K)
+if [ ${kernel_sample} -ne 0 ]; then
+    echo "[FAIL] unexpected kernel samples: " ${kernel_sample}
+    exit 1
+fi
+
+user_sample=$(perf record -e ibs_fetch/swfilt/k -o- true | perf script -i- -F misc | grep -c ^U)
+if [ ${user_sample} -ne 0 ]; then
+    echo "[FAIL] unexpected user samples: " ${user_sample}
+    exit 1
+fi
-- 
2.49.0.1151.ga128411c76-goog

