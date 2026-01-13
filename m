Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D01632E7;
	Tue, 13 Jan 2026 23:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346945; cv=none; b=O6bpf62RFmNqCXa+36XvIVp6/+myIoDPjjQIaBgUOYXww5QVHeTz0MNoHZ1FV+SI3ms8DvH3OssfcnrlIC5q9R6SaMkcNQeqpy8xE1lHrzVWH9oWSkHpOoy9ouNSX+9LKjh5Ip4KGK0cyIjxEFki95I8WFxod+21m3z3lfNC/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346945; c=relaxed/simple;
	bh=f/bw8TonxQh/a9sk3D9budIoPbcOJUPmduRyb0zNoOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FePURfA3rH6dGeyfIJbFTeRvEoQYL8cqUns0b3Obqnd0xO+Pf6O7Y2mq7YOZWvHrspqqWjY3J/uoI9u1lCehxMTVcdeqDTugzJ6qDTgkHjFLDYWC5qJ6AQEUQez13kGP2CAfkzjewnatNxN3liEuhomuTSiknx8+5PKbFHfTs7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnK77UyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnK77UyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3CBC4AF09;
	Tue, 13 Jan 2026 23:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768346945;
	bh=f/bw8TonxQh/a9sk3D9budIoPbcOJUPmduRyb0zNoOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnK77UyPt5osij2I4iHvF4ZbWYAjInOJrlnz92vikFy2t7qnmsVRsnNHo/A54yMnk
	 Utt38DN15tGyBJilJuW6juAi6pKsCla664JvP69GLNezTLYXixl3MfNFJLhhjGIDmr
	 uOuXl4flxfpei+7GDCklNeBRRBqpzl0wSjRlHl1SKLDgPqNrbyjf2yLT0c1Qto9NEh
	 NkfvIUsX8sGxC4k470e5yIfmyYUxoXoSopvkjdCjNcl5lM+owqA7JZO8otRxbOPIvs
	 PBPncMB6GOnJGXDPfGwkI2TdTetjf6Zg3v4NysQXalOE8tDEo33+ZATq7ZqXOl499p
	 3rQpeZDrtZDww==
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
Subject: [PATCH v3 2/2] perf test: Add DWARF callchain conversion test
Date: Tue, 13 Jan 2026 15:29:03 -0800
Message-ID: <20260113232903.55021-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260113232903.55021-1-namhyung@kernel.org>
References: <20260113232903.55021-1-namhyung@kernel.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
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

