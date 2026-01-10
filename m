Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42850221FBD;
	Sat, 10 Jan 2026 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768007837; cv=none; b=rcLeBqSOYIJsaIR90eazg0Aadiw1+AuUpDLUoyGZq0znbWYn95thDPURblhkDxZ6vLX7H1ctJolsXsaOX6cQB7hcg8BxtYh3Y6YOfzNcBmxRgu5pmOx1EPAos7dg+VWlaScvZlXG9lyzn0WstoF1wTVDxtuj6UUlANBCXjl3Gf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768007837; c=relaxed/simple;
	bh=wpPu501TIlFuwDEnIKa/a0O60EEFNxAx/n9in0fcAx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWQrr7cyxOAIcq/AjV1+5ln1mGWtLT5D/dU7uKsLKJcfEyv2+WQNjAYKESBYtSW5I6MtDV9lnpcghs4y+ZRwpT7kqPw6Z1VVRC4jh9r/bVW7+XzxYlu0fJ4vdEV6+rFw9U4EjjsNzAMFbln538tVgzhl4ipE7fQnQR/IsvkIxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+oy1X62; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+oy1X62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E10C19424;
	Sat, 10 Jan 2026 01:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768007837;
	bh=wpPu501TIlFuwDEnIKa/a0O60EEFNxAx/n9in0fcAx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+oy1X628Ivx5fjfhYKE1XNQoGAJhf5ik/Q+RTFfG6u3iLsh3GzCp28jnLUOkWydK
	 edA7W/5zuG1aVgAyO8rTPgX7g+NC0X7CPpljLG600d/g0hNt652JvtYe2IMQcUvS3t
	 DBocGoKKqpmOxlc489TJm05RaL9HUQo0xlY7AMIt0CVd8/xZe3uElofTgc8TDRvdbC
	 vSa8GlFYw3L+vgOv6obuTJ/eiHwU2A2HhCLaSOg0QTF7SxOLODTtygiHS3iYwVoH7E
	 U1WW55soaUM9B6SiY+1n88M4TaVo6rcMWwy7xFay5aTespDwdYH1IojvJgKMZZxDrI
	 NW9Hap+TuZ1Vw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/2] perf test: Add DWARF callchain conversion test
Date: Fri,  9 Jan 2026 17:17:15 -0800
Message-ID: <20260110011715.1642869-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260110011715.1642869-1-namhyung@kernel.org>
References: <20260110011715.1642869-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  $ ./perf test -vv "DWARF callchain"
   87: perf inject to convert DWARF callchains to regular ones:
  --- start ---
  test child forked, pid 1560328
  recording data with DWARF callchain
  [ perf record: Woken up 4 times to write data ]
  [ perf record: Captured and wrote 0.908 MB /tmp/perf-test.nM3WoW (105 samples) ]
  convert DWARF callchain using perf inject
  compare the both result excluding inlined functions
  ---- end(0) ----
   87: perf inject to convert DWARF callchains to regular ones         : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/inject-callchain.sh | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 tools/perf/tests/shell/inject-callchain.sh

diff --git a/tools/perf/tests/shell/inject-callchain.sh b/tools/perf/tests/shell/inject-callchain.sh
new file mode 100755
index 0000000000000000..a1cba8010f954d21
--- /dev/null
+++ b/tools/perf/tests/shell/inject-callchain.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# perf inject to convert DWARF callchains to regular ones
+# SPDX-License-Identifier: GPL-2.0
+
+if ! perf check feature -q dwarf; then
+    echo "SKIP: DWARF support is not available"
+    exit 2
+fi
+
+TESTDATA=$(mktemp /tmp/perf-test.XXXXXX)
+
+err=0
+
+cleanup()
+{
+    trap - EXIT TERM INT
+    rm -f ${TESTDATA}*
+}
+
+trap_cleanup()
+{
+	cleanup
+	exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
+echo "recording data with DWARF callchain"
+perf record -F 999 --call-graph dwarf -o "${TESTDATA}" -- perf test -w noploop
+
+echo "convert DWARF callchain using perf inject"
+perf inject -i "${TESTDATA}" --convert-callchain -o "${TESTDATA}.new"
+
+perf report -i "${TESTDATA}" --no-children -q --percent-limit=1 > ${TESTDATA}.out
+perf report -i "${TESTDATA}.new" --no-children -q --percent-limit=1 > ${TESTDATA}.new.out
+
+echo "compare the both result excluding inlined functions"
+if diff -u "${TESTDATA}.out" "${TESTDATA}.new.out" | grep "^- " | grep -qv "(inlined)"; then
+    echo "Found some differences"
+    diff -u "${TESTDATA}.out" "${TESTDATA}.new.out"
+    err=1
+fi
+
+cleanup
+exit $err
-- 
2.52.0.457.g6b5491de43-goog

