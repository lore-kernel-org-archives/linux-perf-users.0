Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8C4825A7;
	Fri, 25 Sep 2026 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334753; cv=none; b=eSnyH8CFgdjX3OrQb2QS99s7YBUChhTPJBFsMfkBwF0RWb/WYK48lqkHL5Xsb+jFczPWZqDm7tagqbM2+41IEUPVEYOGZ8hWlbxGC5p4qcaGRgPSLxkY4hZEtx61Vh1uKmUnzDDx4ZI5Nd4xdrE2niJvk5RBxctDJMxx8cj9JIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334753; c=relaxed/simple;
	bh=bjSx1jVjckK9liIZZkUj2MwoFMgx8zJqitZsCqi9xdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0PB8stKPzuK2UPDlOcyc5Ljkq/rSToSywxJxXYizGfYkqP56EIHqIJeld4ivA3JdS+KjWcrmrTYMh2zCGlcoLPJEbto8GcsIGhnGBiOULA1vBWosYpUPvCAbRu3s6aByNWy2yv5j2zMT2LclFNS+OTFrzVhtX6sKkZOWuFLdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6Vc2ggq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6Vc2ggq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1791F1F000FF;
	Fri, 25 Sep 2026 11:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790334751;
	bh=WneT79VUrBBDprz0zU1MRNHOGHbJ8XBndDJPjozOKt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L6Vc2ggqFJBy194yVSi1tcXmVO6aLRtoyNViT/Y0NGBOGGwPmn7rdNnnh/W/OHVmy
	 e4unOeCfogNwV+CLlPGm5inrQRKQvSOtZXd2lAdD4WLd0bPPsAoENuhzIPxvz4wjaF
	 9MxBOGefY+kv/iVyjfXCU7seVEk4st9I+r/w9qEuF6kX2p2msN2ZY9P5pCAGr1/fPi
	 ZJ/AgWzXwI13B7PSyGwdzWaT40LX8Wn+PiaJI3xiIdLSlHoxWwz/wt7AUSB+qv8Bjn
	 S51TQ0YrvPfRKN93qoGKPIOS5hotbuM+9FlEUWJS/eKEnlC96uKv58cIz1EDRG8AZG
	 hwvp3ImQe6E3w==
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
Subject: [PATCH v18 06/11] selftests: tracing: Add a basic testcase for wprobe
Date: Fri, 25 Sep 2026 20:12:19 +0900
Message-ID: <179033473905.136630.10097669468834950988.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179033464327.136630.864883694296882051.stgit@devnote2>
References: <179033464327.136630.864883694296882051.stgit@devnote2>
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

