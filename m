Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7738F255;
	Sat,  3 Oct 2026 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014010; cv=none; b=m3WonfzCsIORUE8OPN7YYzdFEZ4sZB7YYx4RYKXyrl8k5Yx09GpWtJMrvQx0fH/luWw9t44LViwLTDfiPbeFdSEy31H7vDGzjzjIyNXwUu6kKUqF5/FXXvndw+6at3WFjkVnwuZ8AIZ4spQreuf+uc6agaKpqHcMBeYyAZHLpn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014010; c=relaxed/simple;
	bh=pP+U2++aqKW5tN+1EO+4P1dvW5UUM8mR0Gb3UiODTG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfObDFEZTVBtbJwClC3ChC/k23dCaHvedzu1szdTA0tNG+UXGhWUHcZoUUafX4jyT6/y66ea+kxENXfDpYakk5Ei2yBJjjH9KeIQMMvrN3uI8vSjvUII7ptzBmv5qJMqOsLbtWRxzn846J6tsQ6G8VKk4adNy4OtF8VP4fJAyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2JUhp/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2JUhp/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0358A1F0089B;
	Sat,  3 Oct 2026 07:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014008;
	bh=CA7Joy0KZ1Fu9eHtsNDuDooFFk+bZMGGs03800zz0Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B2JUhp/1aZmK2X5C+F/URu8ubsI1jBQIExFDIyNOD+7eMMxXRxDRXrwBmL6GLxWPT
	 4+GKz8TPA6WeVSggs7nluuT8YZYwxBEj7Q8/ex/xsgCDGE1+AMOyRW0gv1GcaP8YH3
	 OXo5zW996BzGPmDebt5Awmea/xh4DRtEqUO0jFuSW29ULS2dXHlMMemEV/mmaeL4H9
	 r9jzOqLWIcWFNGhuixvQ+B6CYZkKknDx2/+NfQ/r54fRHP7uEeUCXmbfRR4iGGo+eZ
	 YpgYayztbsmHPEwj3NQ86ntkwKUZKrlfZBqg7X2na7ukyuqZOC78qUoIV8f4g+Kkru
	 q6cjK0VNadOPw==
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
Subject: [PATCH v19 06/11] selftests: tracing: Add a basic testcase for wprobe
Date: Sat,  3 Oct 2026 16:53:22 +0900
Message-ID: <179101400276.22872.8093489412579904892.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179101393469.22872.5895666191299551553.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2>
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
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   66 ++++++++++++++++++++
 2 files changed, 67 insertions(+)
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
index 000000000000..3c622fb07e7f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
@@ -0,0 +1,66 @@
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

