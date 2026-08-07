Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC0476CD5;
	Fri,  7 Aug 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116906; cv=none; b=q4sJYIaVWokrCH4ijOv/ZI674tr9WXSwDsEQNsz0Rk561yRw3EWLp8UWDcnErNi6BaQwDQa9YfapPJq8f08d6Bg1Gbf328OZWtBwnnkGzG/nV5BAsfXuDyahaPn/ewn5oibDZFiTXgZO8Cd9oEuJdOGoOBwghfcYFTsoMdDma1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116906; c=relaxed/simple;
	bh=uFwYCq4dS9i1cDpfSsjYU/uwR7licDQdQGDTOVibNng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXtNhE/cCCrUewXO4H3Wb99GPPOgaqyuX3rz/lKxDjoFYJb7THGH0P6n5XLiqOyRbVzvGZlxUZTqEvUxIbJoWn1s4JlqMxsnF2gZiDtBrrH74LdYPd0B2HrXsQNaUWQlZNQvj6DKzj3oSVaMCYnAn70YQaPCfSwnjwDP5fVzllI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6zZAUIP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6zZAUIP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEA61F00A3A;
	Fri,  7 Aug 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116904;
	bh=rTZ2A2U9JeVrhrb9UGLIRtlTlSyk6IPrl/ICKF/43nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b6zZAUIP00Ik9n0Q+IoJ9TXJ/3OHBZLvmTiGdjvNeE8Pp1JgDs9RBk95vJYx4PIWo
	 y8mfLFVH3K1n63VjHvxTaff8NBTY3zuJyKWHPjYodBo5VqlAxEOZMTtKS5Mai2BdlP
	 QxQZk+jh4+f4ApAwH19VZeDJWsqr6dOC9j4YeEjUPlkGF/uGcwdE3PT5byjEhnApwx
	 sLsjRyI9N29tRvL66b/zLVh17gJBepROFRzg1J+oYQdibl5Cp/3RU1KkUv4bxmwZDt
	 wbl6R8da3BKUkmGKH+sQfPxmoCzmG00149DiYfD/uHI+40pEi5P8w1TRtwDRylWEiK
	 3tlRCKvBCw3VQ==
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
Subject: [PATCH v12 09/11] selftests: ftrace: Add wprobe trigger testcase
Date: Sat,  8 Aug 2026 00:34:58 +0900
Message-ID: <178611689884.237811.7547180621874073837.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178611679753.237811.10190793347982785419.stgit@devnote2>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
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
Also add a testcase for verifying wprobe trigger syntax error logging.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v12:
 - Add trigger-wprobe-syntax-errors.tc for verifying wprobe trigger syntax
   error logging.
 - Fix requires line in trigger-wprobe-syntax-errors.tc so test is not
   evaluated as unsupported prior to execution.
 - Define dfd=$arg1 fetcharg on testevent for trigger syntax checks.
Changes in v11:
 - Update testcase to use trace-events-sample kernel module instead of
   VFS file operations.
---
 tools/testing/selftests/ftrace/config              |    1 
 .../test.d/trigger/trigger-wprobe-syntax-errors.tc |   31 +++++++
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |   85 ++++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-syntax-errors.tc
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
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-syntax-errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-syntax-errors.tc
new file mode 100644
index 000000000000..7e02313cf1c7
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-syntax-errors.tc
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test wprobe trigger syntax errors
+# requires: dynamic_events error_log "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check "wprobe_trigger" "$1" "events/fprobes/testevent/trigger"
+}
+
+# Add a dummy fprobe event to attach triggers to
+echo 'f:fprobes/testevent do_sys_open dfd=$arg1' > dynamic_events
+
+# Add a target wprobe event
+echo 'w:watch rw@0:8' >> dynamic_events
+
+# Test errors on trigger syntax
+check_error 'set_wprobe:^non_exist_wprobe:dfd'	# WPROBE_NOT_FOUND
+check_error 'set_wprobe:^'				# WPROBE_NOT_FOUND
+check_error 'set_wprobe:watch^'				# WPROBE_NEED_FIELD
+check_error 'set_wprobe:watch:^non_exist_field'	# NO_EVENT_FIELD
+
+# Enable target wprobe event and test WPROBE_BUSY error
+echo 1 > events/wprobes/watch/enable
+check_error 'set_wprobe:^watch:dfd'			# WPROBE_BUSY
+echo 0 > events/wprobes/watch/enable
+
+# Cleanup
+echo '-:watch' >> dynamic_events
+echo '-:testevent' >> dynamic_events
+
+exit 0
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

