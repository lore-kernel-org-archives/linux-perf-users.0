Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E63EF0BD;
	Mon,  7 Sep 2026 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788752864; cv=none; b=jyMQa1MnX+PXoSVOpWVkDwNeMaU1oIltdCG/gpPtYaZfx3WAc9EjkEUQWOBvhQtmwEOvfEYcIFEO/RWACwQ4vVGN93nJR2xubQAyABOEYcwSx8wxOwDyDfCWMv/eD483UOyc1aycBQrIxcZHJV2ZRuiVk7fVJHwsA4oT/OJodkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788752864; c=relaxed/simple;
	bh=7WwAsjXAm72C3N+aWoYKuzBUFcwI27R/LA/82emnZ6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jW/Ep2bsAJA3aewLvNcQxkEiKLc6kvjVXXjM3GSxMV4iKyWLhuK5fso5AmPCqdhsFsIBrfGAQHrBAtfGlNwbWcXXm3GJF3GDkcNp0/B2DaPAQ5FOzPw8+50+RUhwak0ZqXM722gMtEPcnnQdil9009BlYx7356qN7lJA4I0wfvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6BKsBis; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6BKsBis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869781F00A3A;
	Mon,  7 Sep 2026 03:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788752863;
	bh=lcnl1Kiyu2/Ws5GS/yrGcGPFrteWWVQg5IT2n1yE1q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n6BKsBisbhdDWolCiv5TCiUdnRYIzFvalc+0u986T4NmKRJ5iddgpUeLCMTsoqXTx
	 wg2s3CsO+5FI19KdLYIWW/B4lstUsX3SbpEawIJV/QKg4yHUbp5Lz8rjmj0sBD5D4P
	 tKHfSGSkRjd4qnGAzhs1JTc3/pvUJv5pDlHLrmxxvE2VTYgsu8KSRRQa1aTgHPvZMO
	 DFqEr8VkQFGCSaoIFmDKIQMkABT21isEJT0hNVX6vtLIG0kF20V3qGa63ZETUGm9Lf
	 trbVuRYhuRnxZNe8GqDUk3ZQ983UUvjUpYh8Dd2wCXP1CDsmbpL/LoumqRerm1RslS
	 YZ1fasdm2yQsw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v15 07/12] selftests: tracing: Add a basic testcase for wprobe
Date: Mon,  7 Sep 2026 12:47:37 +0900
Message-ID: <178875285732.93794.2953704844412327111.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178875277830.93794.14247844688761142429.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
tests adding and removing operations of the wprobe event.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v9:
  - Fix command check logic to prevent early exit under 'set -e'
    (errexit) when grep or test fails.
  - Simplify enable/disable status checks by removing cat pipes.
 Changes in v8:
  - Fixed silently test failure path.
---
 tools/testing/selftests/ftrace/config              |    1 
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   63 ++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index 544de0db5f58..d2f503722020 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -27,3 +27,4 @@ CONFIG_STACK_TRACER=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_UPROBES=y
 CONFIG_UPROBE_EVENTS=y
+CONFIG_WPROBE_EVENTS=y
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
new file mode 100644
index 000000000000..647c37d5e4c8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
@@ -0,0 +1,63 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove wprobe events
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README
+
+echo 0 > events/enable
+echo > dynamic_events
+
+# Use jiffies as a variable that is frequently written to.
+TARGET=jiffies
+
+echo "w:my_wprobe w@$TARGET" >> dynamic_events
+
+if ! grep -q my_wprobe dynamic_events; then
+    echo "Failed to create wprobe event"
+    exit_fail
+fi
+
+if [ ! -d events/wprobes/my_wprobe ]; then
+    echo "Failed to create wprobe event directory"
+    exit_fail
+fi
+
+echo 1 > events/wprobes/my_wprobe/enable
+
+# Check if the event is enabled
+if ! grep -q 1 events/wprobes/my_wprobe/enable; then
+    echo "Failed to enable wprobe event"
+    exit_fail
+fi
+
+# Let some time pass to trigger the breakpoint
+sleep 1
+
+# Check if we got any trace output
+if ! grep -q my_wprobe trace; then
+    echo "wprobe event was not triggered"
+    exit_fail
+fi
+
+echo 0 > events/wprobes/my_wprobe/enable
+
+# Check if the event is disabled
+if ! grep -q 0 events/wprobes/my_wprobe/enable; then
+    echo "Failed to disable wprobe event"
+    exit_fail
+fi
+
+echo "-:my_wprobe" >> dynamic_events
+
+if grep -q my_wprobe dynamic_events; then
+    echo "Failed to remove wprobe event"
+    exit_fail
+fi
+
+if [ -d events/wprobes/my_wprobe ]; then
+    echo "Failed to remove wprobe event directory"
+    exit_fail
+fi
+
+clear_trace
+
+exit 0

