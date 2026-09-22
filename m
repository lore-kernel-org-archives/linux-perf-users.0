Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969673EB0FB;
	Tue, 22 Sep 2026 04:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051187; cv=none; b=hQ2I6xfDidzGtS1hMDqEPn3xPA+j3WKbH9PuV4ppwD+eWitUa3r97SLOi6YEVV5prISnnag12kY1Ls+dHeFjgL0hCHP7dzD/itZYpugpnlSoWGaQNy9eBbPPEpDvEWv27lyNWbLsoa4ivP1FBrITtOdmsJ6TYF2wwEg6ujJB3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051187; c=relaxed/simple;
	bh=bjSx1jVjckK9liIZZkUj2MwoFMgx8zJqitZsCqi9xdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEjz1D40Me1aLcmaattfsi7Tr7Z9im7gGzBDC95G35pZ1V5ISCyCHxOS4bnwALUke2xeurj2Hq9lvUqYVjSjQoTIQKoi2p61hzKqtYtENT4dtxbsiseZ5D+PKNLpOvzVOGZH7o6m/RQNRBR1J4yGv3p//UwY1mx8yErk7GuITcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7a5xTOi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7a5xTOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B9D1F00893;
	Tue, 22 Sep 2026 04:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051185;
	bh=WneT79VUrBBDprz0zU1MRNHOGHbJ8XBndDJPjozOKt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b7a5xTOiRm27C/0oZkG2kyL8Px/zKMHPtQhHP4RQALCKlCpADwkFDBzCYtiKzwIOH
	 2T0ICsCciRISCy1pFqSg1KsziFg5UXxU1sgL6G1jiM6C7ZXKa2LWY1pBHgsKv8S8Sh
	 QlXV7a7rUm56eV1Bf+Hs5c1TBdR4VHyrv1qQU9E/vwFGHuYdLmfkH+1kpFA1MB6NYg
	 Z3PsKxggBVCJ35/pOVVK2jnRBxiK/tnJNR5RWXlQfZ6QP4ywF9qRyEqQb81uFObs75
	 Go6G7tgb8q9HIZPiZATGS+jPz/jUyTSTa6DAhWzarjm8PEQcMlhjMr/6Me9GJYpDNq
	 fU+tcLlyVYZRA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sean Christopherson <seanjc@google.com>
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
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH v17 08/13] selftests: tracing: Add a basic testcase for wprobe
Date: Tue, 22 Sep 2026 13:26:19 +0900
Message-ID: <179005117931.388919.6236117656921986202.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179005108298.388919.4535333252892590932.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
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

