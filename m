Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE133382381;
	Sun,  2 Aug 2026 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785658780; cv=none; b=ivXAm87jMBIDZQ3TwsyYiS6KKt+wq1Iord/9LdewDmQpJqJk2kH75m9xwRmD3elrpVTq4tX9JisS4n2zNI8+fJCo8vZZuryOAnIgydeif4zeFb5VVNNkUfZEhf+TW26pAHaHItJhLigGlMILuISvfg+yKBwJqt6+Omw/p481hcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785658780; c=relaxed/simple;
	bh=7WwAsjXAm72C3N+aWoYKuzBUFcwI27R/LA/82emnZ6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z63wx1awkAzhbkpgkEC4oxOojBqsWpKOPkHXKJR/jEhqbFS5tBx/d8/EYiuUScL2ArkuKdokl62L9HKsbg57ghoLl6cnYz/QU05gbDiBFRVA/zWPHo+r0eVZF/g3lm9Fc79pLFZGEHn3RS+v0D7IdalkxF7AijUA1toYrDlY3H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH8FkjBd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH8FkjBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12A51F00AC4;
	Sun,  2 Aug 2026 08:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785658779;
	bh=lcnl1Kiyu2/Ws5GS/yrGcGPFrteWWVQg5IT2n1yE1q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EH8FkjBd+eXRJtATfwQUTcieP07M/6Q+u2mUF4MI5AxTmMoeX3JqxryA1LqL267wD
	 a27Y3GDa1N6Yl24MkqPkyPgcfwILLJmRDv7L4/knc7lOY2GL+lqB6c4UdvbFrp0Qu7
	 x21EScyjA8wBZdUkyZelsSp3q1XLFye4529SV10FQyN3fidIDycxVkFEoy7XtQLzuj
	 qnyFWggHdsJgoyUUIQJyupG48QaTuckzPu5MKYCrEaxnm1xTVHBBiqHRUXy/XiFuUG
	 UYW2QMkMOZ+RktzQWoEUotlvwjMbO+I0WWhaH6AACnJy8/K+/leD9EbZQ9RmSjNgKU
	 fgiakD7Q5bFoA==
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
Subject: [PATCH v11 06/11] selftests: tracing: Add a basic testcase for wprobe
Date: Sun,  2 Aug 2026 17:19:33 +0900
Message-ID: <178565877350.714490.11248347882853426879.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178565870538.714490.11309825813968306287.stgit@devnote2>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
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

