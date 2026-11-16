Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794806828;
	b=1Fq0Oe/BAmSZlioM7BO9QTPLIvlBQw3IR0cODnDae+XP4sEJ01cFYcjWuNvJSQjSw18t
	 8LY6/n39h2NdAqFYufmP8QTsmdQsPpJRz10He2pAS0f8X0XT1SQ5Zsn2NC0UqLfCspfhg
	 DYY86cG5FY2olEA/zi4CopdBXklUYALg8PJ+fDMukvPIq5+KfaVomSP9YHGluSZQ1VOpe
	 gssKOWx4S73hmqJzcgny2sUIsYunm66u4e60Dptv+Km86QKD7wvQOcw5BexWT9LJb3W/U
	 tkchwFKPm5brmh8jChRmXO4391g+otiQKzUMj0p1yIT3hRRKdwzgLq97KIgv2nqEbQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794806828;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qU0BY80Af6d2aUzTDeT+Pj0ji5URWTqkq0aG2w9XCY4=;
	b=3qbSNirhF0EqE4l2rWcArB2ENhMPu6vBtnqWiDHfZ75Tydv6yoEZb/ES2o68E0kqi4cp
	 9r7UcXXg9BxWrtLl+Ru74zDVudFpmoX3NT1PnGvZkbdSbLG8E4lT5TsJfjLI9qT29mJN/
	 d5JHD7GDuA/Dv8kjndrE3fiw383IUvFfqSoHAGrjHVTOygLtGa5bc7EEq9DZavsodt5c7
	 f38LdNAC2jG7KXd7HR5NzIwJclx6FwFoLsH5KwdRgB0WV2bAf7XtD/7wVUiLrdb5QdRIK
	 lkRF3AIeKryEQLFVEoiStVx5FaZH5IMMIZjbQyXhUh48VNhih0O3bW5ElKi07L9rx+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lJu456/Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825E606A31C;
	Mon, 16 Nov 2026 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJu456/Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E421F000C4;
	Mon, 16 Nov 2026 05:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794806828;
	bh=qU0BY80Af6d2aUzTDeT+Pj0ji5URWTqkq0aG2w9XCY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lJu456/YMgNWMppov8pDkK/8JH3e0LzEmj9LtAZKF4ltUELESlSpMCwfbPmh/KxhE
	 KTGNTMDfkUsMt4cAbxYgvJxUOCSnvYltLu7BaI3scPw2gbgG2GxVeXWBebv/pnldss
	 qBuWzVhX1bkTMVFC7zfhE8gu53rANtqWW6loYKJ5PKE3rGMbLg2OZ52fRzUo0mw2Yo
	 5ndZFakP4i0lypxElqcb6sNjjV0AU59DI+UXxBO6TEsUZ7rrRKeEWO0YK4qK+gQ1Q4
	 05OeaqIqKucBLVqejBIi8vx521LcueyASNq+Nn78faGi0et2H8FJPnG1MQ/CHKKPkX
	 RuZm65FywP8SA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
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
	linux-perf-users@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v20 06/11] selftests: tracing: Add a basic testcase for wprobe
Date: Mon, 16 Nov 2026 14:27:01 +0900
Message-ID: <179480682179.38065.15797461233330303156.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179480675130.38065.3086970856119381693.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
tests adding and removing operations of the wprobe event.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v20:
 - Verify $addr and $value fetchargs in trace output.
 - Add test checks for access modes (r@, rw@), length specifiers,
   symbol offset, and spec-based event removal ('!w:...' and '-:...').
Changes in v17:
 - Catch failures when enabling wprobe and call exit_unresolved
   in case hardware watchpoints are exhausted.
Changes in v9:
 - Fix command check logic to prevent early exit under 'set -e'
   (errexit) when grep or test fails.
 - Simplify enable/disable status checks by removing cat pipes.
Changes in v8:
 - Fixed silently test failure path.
---
 tools/testing/selftests/ftrace/config              |    1 
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   81 ++++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index 29f05f7c6e2c..c2caea1ba1f5 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -33,3 +33,4 @@ CONFIG_SYNTH_EVENTS=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_UPROBES=y
 CONFIG_UPROBE_EVENTS=y
+CONFIG_WPROBE_EVENTS=y
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
new file mode 100644
index 000000000000..40c69c3f2ba5
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
@@ -0,0 +1,81 @@
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
+echo "w:my_wprobe w@$TARGET addr=\$addr val=\$value" >> dynamic_events
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
+if ! echo 1 > events/wprobes/my_wprobe/enable; then
+    echo "Failed to enable wprobe (hardware watchpoints may be exhausted)"
+    exit_unresolved
+fi
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
+# Check if we got any trace output with fetchargs
+if ! grep -q "my_wprobe:.*addr=.*val=" trace; then
+    echo "wprobe event was not triggered or missing fetchargs"
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
+# Test access modes, lengths, symbol offset, and spec-based removal
+echo "w:my_wprobe1 r@$TARGET:1" >> dynamic_events
+echo "w:my_wprobe2 rw@$TARGET+4:4 val=+0(\$addr)" >> dynamic_events
+echo "!w:wprobes/my_wprobe1 r@$TARGET:1" >> dynamic_events
+if grep -q my_wprobe1 dynamic_events; then
+    echo "Failed to remove my_wprobe1 with '!' syntax"
+    exit_fail
+fi
+
+echo "-:wprobes/my_wprobe2 rw@$TARGET+4:4 val=+0(\$addr)" >> dynamic_events
+if grep -q my_wprobe2 dynamic_events; then
+    echo "Failed to remove my_wprobe2 with full spec"
+    exit_fail
+fi
+
+clear_trace
+
+exit 0

