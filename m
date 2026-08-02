Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAE3203B6;
	Sun,  2 Aug 2026 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785658815; cv=none; b=RJJTNdL8/p/wut7SI8LFdgw7ZzUZHuer2ompzrAEOZ2Tc9Q+LHu4ETID3rn5Bmr8CTqDH/hWvK2wpIpjwZ0jFUE3JkXI00Hc1NHEy0jrJmerQf46AnkikczvVTCkd05xLJ4h1kntcjlXPLu+2rIhKlv4B33hUYZcPVXqqEqP2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785658815; c=relaxed/simple;
	bh=ViOVyO8yDqguHkU+X02XP0Bs/msFq4/hK8uTCxWGmGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOQzQ/lxx1+4FjeDnYQnKeFC1SPh8wguwAsxeww0El6Hzsr5UNBk16yyF5UVgpSBPXJVoc3nObyqiiRE7KbkgP/9Iq60WqMMRt79/jRMFVpAvDhbDnIxdK8/S/OrcrMsX4WtGkiV4NYlq7MEj2G2LcliDF6VCBDi94G/1f5MJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb2cAbBl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb2cAbBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4B91F00AC4;
	Sun,  2 Aug 2026 08:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785658812;
	bh=JJ9Ut0yjyuZ90u+R8cbjLYmw1iskToab/1RjRS9W24Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fb2cAbBlXiRqIJed4RgHx2UlOh9J7Mp9TspFsomOUka0fCEQ9iJ8jJGFPFbHlfgND
	 bYaMI5lnGDykAM9ZzQIBcYsRFHIbBDlm+V+a2kFvmvaw8cwueQ7LLG39ufO+fxy7Vm
	 rrgiiJtzdxRDucwcNUer514YVs4889wpe/KbfID/z2nxfhRn7ZdAusbjLV3+hKXzEt
	 VooMpndTQlLFDrmHr4W8me4PxWRK/0BAsMRdFRv9Rfg4gOKwQX55+8x77aLDJL4Heu
	 4jhj6MSt25OskhBk653SUWeefUZ0b+ZqUkAOuOch4VThMZpMf4FcOfgRMw1kAO/0pq
	 pLvdgtd8B4d1g==
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
Subject: [PATCH v11 09/11] selftests: ftrace: Add wprobe trigger testcase
Date: Sun,  2 Aug 2026 17:20:07 +0900
Message-ID: <178565880692.714490.8439336315058403320.stgit@devnote2>
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

Add a testcase for checking wprobe trigger. This sets set_wprobe and
clear_wprobe triggers on fprobe event and static trace event to
monitor memory accesses within the trace-events-sample kernel module.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v11:
 - Update testcase to use trace-events-sample kernel module instead of
   VFS file operations.
---
 tools/testing/selftests/ftrace/config              |    1 
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |   85 ++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index d2f503722020..ecdee77f360f 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -28,3 +28,4 @@ CONFIG_TRACER_SNAPSHOT=y
 CONFIG_UPROBES=y
 CONFIG_UPROBE_EVENTS=y
 CONFIG_WPROBE_EVENTS=y
+CONFIG_WPROBE_TRIGGERS=y
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
new file mode 100644
index 000000000000..4071fe0c878b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
@@ -0,0 +1,85 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test wprobe trigger
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README events/sched/sched_process_fork/trigger
+
+rmmod trace-events-sample ||:
+if ! modprobe trace-events-sample ; then
+  echo "No trace-events sample module - please make CONFIG_SAMPLE_TRACE_EVENTS=m"
+  exit_unresolved
+fi
+
+cleanup_wprobe_triggers() {
+  if [ -f events/fprobes/testevent/trigger ]; then
+    reset_trigger_file events/fprobes/testevent/trigger || true
+  fi
+  if [ -f events/sample-trace/foo_bar_with_fn/trigger ]; then
+    reset_trigger_file events/sample-trace/foo_bar_with_fn/trigger || true
+  fi
+  echo 0 > events/enable 2>/dev/null || true
+  echo > dynamic_events 2>/dev/null || true
+  sleep 1
+  rmmod trace-events-sample 2>/dev/null || true
+  return 0
+}
+
+trap cleanup_wprobe_triggers EXIT
+
+echo 0 > tracing_on
+
+# we will skip this test if fprobe is not supported.
+if ! grep -Fq "f[:[<group>/][<event>]] <func-name>[%return] [<args>]" README; then
+    echo "UNRESOLVED: fprobe is not supported"
+    exit_unresolved
+fi
+
+# we will skip this test if the target function does not exist.
+if ! grep -wq "sample_timer_cb" /proc/kallsyms; then
+    echo "UNRESOLVED: sample_timer_cb not found"
+    exit_unresolved
+fi
+
+:;: "Add a wprobe event used by trigger" ;:
+echo 'w:watch rw@0:8 address=$addr value=$value' > dynamic_events
+
+:;: "Add events for triggering wprobe" ;:
+echo 'f:fprobes/testevent sample_timer_cb timer=t' >> dynamic_events
+
+:;: "Enable all events before setting triggers" ;:
+echo 1 > tracing_on
+echo 1 >> events/fprobes/testevent/enable
+echo 1 >> events/sample-trace/foo_bar_with_fn/enable
+
+:;: "Set set_wprobe trigger on testevent" ;:
+echo 'set_wprobe:watch:timer' >> events/fprobes/testevent/trigger
+cat events/fprobes/testevent/trigger | grep ^set_wprobe
+
+# Wait for sample_timer_cb to fire and set_wprobe trigger to activate
+sleep 2
+
+:;: "Check set_wprobe trigger activated the watchpoint" ;:
+cat trace | grep watch
+
+:;: "Set clear_wprobe trigger on foo_bar_with_fn" ;:
+echo 'clear_wprobe:watch' >> events/sample-trace/foo_bar_with_fn/trigger
+cat events/sample-trace/foo_bar_with_fn/trigger | grep ^clear_wprobe
+
+# Clear trace and wait to ensure no new watchpoint events are generated
+clear_trace
+sleep 1
+
+:;: "Ensure clear_wprobe trigger deactivated the watchpoint" ;:
+! grep -q watch trace
+
+:;: "Remove wprobe triggers" ;:
+echo '!set_wprobe:watch:timer' >> events/fprobes/testevent/trigger
+echo '!clear_wprobe:watch' >> events/sample-trace/foo_bar_with_fn/trigger
+! grep ^set_wprobe events/fprobes/testevent/trigger
+! grep ^clear_wprobe events/sample-trace/foo_bar_with_fn/trigger
+
+:;: "Disable events and remove dynamic events" ;:
+echo 0 > events/enable
+echo > dynamic_events
+clear_trace
+
+exit 0

