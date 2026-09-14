Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B869947884B;
	Mon, 14 Sep 2026 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390316; cv=none; b=d1POvXe7tVdxe5+nprKZDOAnRcD5/tTUsQwYLIIEoR8q32+XUuVe7mCd68HN27BuBQKzDO5w73ceEdRTVvmTiFY3amCL+PDk+9ltllSEbrzvDBw42XnB9eByjynsdqTbN5HZDOFkZV08zagJx6BDlcyu5dn830lf19LjvLIg0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390316; c=relaxed/simple;
	bh=3UxOv/ycQHsZl/Xf8GT2532YY+fEmWQHV0lU07wBTqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oa6Oo/4CFZNNItPad0vsrb/UQS8AH4+z/haJFDAhn6oCVGoVV6+aBWrpt7pm1B03psS8qXJcoL8Ma5qWqlb9NVEgomrPGOhBK8MbprEg0n8Y6VFTIDgqXlExJs3O6HahmRf9NxyZv5/8csmjRvrcrYE/isQOYoqzDq6H76D9WmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMOX7pdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMOX7pdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F361F000FF;
	Mon, 14 Sep 2026 12:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390314;
	bh=qR/ooNokY/JXh3TIAOrz0u1poJXQf9kNVv8StlU1sWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oMOX7pdDSwpDXq8d8xsJrApP7pmt9f19i3v3p6URCnN2EzvUU7Xnp6CYl7SbNxdLy
	 svLxG0JjELceskAD8g8T9/7mPkQSJaFUGPicYoLnQ52cATN35rpH1Xlxn63KJOBkgT
	 WklSqe0ZCGNTLDgVvdBNwykV2yzg7WTi6rT7IDPiO4hhgZ5KmHlYdaunzXDyH6Ngk8
	 oAKwR/RoH5gQaT1dA0lFP6YH5JHc961irX12ZFvEBCWeXrm60Rcty+pxp8z9D19uks
	 jbQYJ8fFti4GyyS3DsArLSjY2o7jTmo9U2ECAtChZnt0+JjyzNBZQYL/IU3wM4xppA
	 YnDbBPHehOBeg==
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
	linux-perf-users@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH v16 11/13] selftests: tracing: Add wprobe trigger testcase
Date: Mon, 14 Sep 2026 21:51:47 +0900
Message-ID: <178939030777.94750.5923936292118351595.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178939017565.94750.9431053336761330458.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
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

Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v15:
 - Add explicit failure checks with fail helper in trigger-wprobe.tc.
 - Declare fprobe README requirement in trigger-wprobe.tc.
 - Add trigger file check to trigger-wprobe-syntax-errors.tc requires line.
 - Fix subject tag to tracing.
Changes in v14:
 - Update dummy wprobe event definition to use '-1' instead of '0'.
 - Add BTF argument dependency requirement in trigger-wprobe.tc.
 - Add delay before clear_trace in trigger-wprobe.tc to avoid race with
   clear_wprobe trigger execution.
Changes in v13:
 - Look up target function dynamically in trigger-wprobe-syntax-errors.tc.
 - Disable set_wprobe trigger before verifying clear_wprobe in
   trigger-wprobe.tc to avoid race condition with sample_timer_cb.
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
 .../test.d/trigger/trigger-wprobe-syntax-errors.tc |   37 +++++++
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |  107 ++++++++++++++++++++
 3 files changed, 145 insertions(+)
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
index 000000000000..dd1ce4baa62b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-syntax-errors.tc
@@ -0,0 +1,37 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test wprobe trigger syntax errors
+# requires: dynamic_events error_log "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README events/sched/sched_process_fork/trigger
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check "wprobe_trigger" "$1" "events/fprobes/testevent/trigger"
+}
+
+TARGET_FUNC=$(grep -m 1 -E -w "[tT] (vfs_read|do_sys_openat2|do_sys_open)" /proc/kallsyms | awk '{print $3}')
+if [ -z "$TARGET_FUNC" ]; then
+    echo "UNRESOLVED: target function not found"
+    exit_unresolved
+fi
+
+# Add a dummy fprobe event to attach triggers to
+echo "f:fprobes/testevent $TARGET_FUNC dfd=\$arg1" > dynamic_events
+
+# Add a target wprobe event
+echo 'w:watch rw@-1:8' >> dynamic_events
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
index 000000000000..043e1c915ccf
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
@@ -0,0 +1,107 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test wprobe trigger
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README events/sched/sched_process_fork/trigger "[(structname[,field])]<argname>[->field[->field|.field...]]":README
+
+fail() { #msg
+  echo "$1"
+  exit_fail
+}
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
+echo 'w:watch rw@-1:8 address=$addr value=$value' > dynamic_events
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
+if ! grep -q ^set_wprobe events/fprobes/testevent/trigger; then
+  fail "Failed to set set_wprobe trigger"
+fi
+
+# Wait for sample_timer_cb to fire and set_wprobe trigger to activate
+sleep 2
+
+:;: "Check set_wprobe trigger activated the watchpoint" ;:
+if ! grep -q watch trace; then
+  fail "Failed to trigger watchpoint"
+fi
+
+:;: "Set clear_wprobe trigger on foo_bar_with_fn" ;:
+echo 'clear_wprobe:watch' >> events/sample-trace/foo_bar_with_fn/trigger
+if ! grep -q ^clear_wprobe events/sample-trace/foo_bar_with_fn/trigger; then
+  fail "Failed to set clear_wprobe trigger"
+fi
+
+# Disable set_wprobe to prevent sample_timer_cb from re-arming the watchpoint
+echo '!set_wprobe:watch:timer' >> events/fprobes/testevent/trigger
+
+# Wait for foo_bar_with_fn to fire and clear_wprobe trigger to deactivate watchpoint
+sleep 2
+
+# Clear trace and wait to ensure no new watchpoint events are generated
+clear_trace
+sleep 1
+
+:;: "Ensure clear_wprobe trigger deactivated the watchpoint" ;:
+if grep -q watch trace; then
+  fail "Failed to clear watchpoint"
+fi
+
+:;: "Remove wprobe triggers" ;:
+echo '!clear_wprobe:watch' >> events/sample-trace/foo_bar_with_fn/trigger
+if grep -q ^set_wprobe events/fprobes/testevent/trigger; then
+  fail "Failed to remove set_wprobe trigger"
+fi
+if grep -q ^clear_wprobe events/sample-trace/foo_bar_with_fn/trigger; then
+  fail "Failed to remove clear_wprobe trigger"
+fi
+
+:;: "Disable events and remove dynamic events" ;:
+echo 0 > events/enable
+echo > dynamic_events
+clear_trace
+
+exit 0

