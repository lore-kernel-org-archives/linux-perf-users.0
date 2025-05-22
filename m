Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7BE191484;
	Thu, 22 May 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933850; cv=none; b=G1eD2QM1K4ylVZ2F1hzzc/TMudDHS/U2guTL65zW4AiXK8qI/biJIxrA+Kprg3Rsn2Ktt+3qg5o5cwsYS+PUrNd5SKii65pqiUGeOmwi1WozfgNW/bB8GEy0i/BLNSdS8vvWUSMlD3ljL769YqCf+W6fnuDheXltb9W59q+0bvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933850; c=relaxed/simple;
	bh=z+fyZkrdZTOMZrboCG9T2VLWlXBRAa8ZR92oVx0ubCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otmVX2pFhmuYvywSAbWdh7BBxtDbgjDLmnkI0ekWXw/nJBsyx9R6m5ZfHmWX3w6Yu1o6gz5VjDD0wtPOPXz4uPV7uKvjeUi0leYsVsngGZBZ2+dk3KQVeFYknEu90HpWRn7mG2o5OcGdvDXo0A9vua719qInhH5dsJ/gnhBDd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNDTQ2Az; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNDTQ2Az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8121C4CEF6;
	Thu, 22 May 2025 17:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747933849;
	bh=z+fyZkrdZTOMZrboCG9T2VLWlXBRAa8ZR92oVx0ubCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNDTQ2AzQwH6vK5TQ8W0UJ8iHX+ApXApvTYsKKFJbYZZFpmVN6+Ww1tQraYiKHMZv
	 uh8UyL/5dA4pSmKzRqph83A+vLIKAUOHkwAZhe20/B5imxtPcGLgmeaiycIH4Z3qr0
	 BIJcLIzlQwtzYS3J7cr9cVCzGvzZ5gCr3LXNfXbZSMnRPTYpmtj/yxhzRMFcjpaaPr
	 t+B2cbsjg0Kt7H14iqloIiPAmUnEfFBnVa2e/dJAJCuTE0NQ653irSNBJdnm6DP1lI
	 4hL8XwjZKDBk94bt7+VAcOpuali+ulaGcBn6YnPyHvydUxL4I8Y34g9LAUoU0JhJ0t
	 M7cYSwik1pgLA==
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
Subject: [PATCH 3/3] perf test: Add AMD IBS sw filter test
Date: Thu, 22 May 2025 10:10:44 -0700
Message-ID: <20250522171044.1075583-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.1164.gab81da1b16-goog
In-Reply-To: <20250522171044.1075583-1-namhyung@kernel.org>
References: <20250522171044.1075583-1-namhyung@kernel.org>
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
  111: AMD IBS software filtering:
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
  111: AMD IBS software filtering                                      : Ok

Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/tests/Build               |  1 +
 .../arch/x86/tests/shell/amd-ibs-swfilt.sh    | 67 +++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100755 tools/perf/arch/x86/tests/shell/amd-ibs-swfilt.sh

diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 5e00cbfd2d569bb9..317602fbc744316a 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -14,6 +14,7 @@ perf-test-y += amd-ibs-period.o
 
 ifdef SHELLCHECK
   SHELL_TESTS := gen-insn-x86-dat.sh
+  SHELL_TESTS += $(shell find shell -executable -type f -name '*.sh')
   SHELL_TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
 else
   SHELL_TESTS :=
diff --git a/tools/perf/arch/x86/tests/shell/amd-ibs-swfilt.sh b/tools/perf/arch/x86/tests/shell/amd-ibs-swfilt.sh
new file mode 100755
index 0000000000000000..83937aa687ccd859
--- /dev/null
+++ b/tools/perf/arch/x86/tests/shell/amd-ibs-swfilt.sh
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
2.49.0.1164.gab81da1b16-goog

