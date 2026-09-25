Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519C48C3E5;
	Fri, 25 Sep 2026 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334819; cv=none; b=csWqDySKruh1Pwzy822vRI4Kln/Xr3Lbbhi/eN6hF0KcJvzLADCKcEltgxMFUnKfGllU3505g0f31IDL8rqPMxVyVZ9Uqn9s1YPyEqib+ZqoeUO9DpWKszNIQhYRh5+fXTr4ilU7YzqzYeTi0gV3KWwxI2F4j/HOszvhc4Trsrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334819; c=relaxed/simple;
	bh=wfWfPJrO1rlQippEaT546EtCa+NRxG61mZqPd0xQCJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cu5tJVE5/T7StaQpJdVZ3TTyNf5MmvsJEAWpqUlSKGK3b/vYG0rr+LXqauPv0wBpTREnkQOhy9QdUfHOXl8F9qAnwgxQYzDY96zAO7E0k/PgiY/a7oYKFuAyNHJ9T3cQyAXDMhv4dWJ/UpJJHvL11NxhVzZOa9moqRxlvUSB/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA5qgrkx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA5qgrkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD36C1F000FF;
	Fri, 25 Sep 2026 11:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790334817;
	bh=Xg0pQB5vrg//NSWWNY4CewJmQIQ9MFmWqLfOlMC9hBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YA5qgrkxA3NLg95bwCUbFDPbY8KPojKcXbpr7ocr69MYdq8zhsKTgxhH1mh9gsEjF
	 hMKixfIA5J4p9xO/lJlg5tA/YVq3KKe6xk23mA6W+KRkacaY2vEqyWxPBYqbOvubpW
	 FMGj7cSO9vd/sC3IcEUpaYOINGuBz8UZ0cJHjHPc4aPwYaK6qyDLwYCNWIeiTiEr57
	 /MkA0iGRrb4ITzuZ2Trmg8A7NGGpddyL6y19n6dRIS5tf6dcabq+9xNkERag5hEwoZ
	 myzuhvt126rwOwaXTQkpN7M9hyacZf+pLyOScdoebo/Rb4hkUNsDgJ0d/lETGSM2Eu
	 Gzrh2KKlqTLrA==
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
Subject: [PATCH v18 10/11] tracing/wprobe: Support BTF typecast in fetchargs
Date: Fri, 25 Sep 2026 20:13:26 +0900
Message-ID: <179033480641.136630.15712972020806310384.stgit@devnote2>
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

Allow BTF typecast syntax (STRUCT)FETCHARG->MEMBER in wprobe event
fetchargs. Previously, handle_typecast() rejected any probe context
that was not a function entry/return or tracepoint event probe.

Wprobe events use $addr (the accessed address) and $value (the value
at that address). By enabling BTF typecast, users can now cast these
to a concrete struct type and access its fields directly. For example:

  echo 'w:watch rw@-1:8 dflag=(dentry)$addr->d_flags' >> dynamic_events

With a set_wprobe trigger pointing the watchpoint at a dentry address,
the resulting trace shows d_flags being accessed at that location.

Note that $addr and $value are restricted to kernel-space memory,
which is consistent with the existing TPARG_FL_KERNEL flag used when
parsing wprobe fetchargs.

Assisted-by: LLM
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v18:
 - Add "set_wprobe:<wprobe-event>":README to requires line in
   trigger-wprobe-btf-typecast.tc so the test is skipped if
   CONFIG_WPROBE_TRIGGERS is disabled.
Changes in v15:
 - Document BTF typecast syntax for wprobe fetchargs in wprobetrace.rst.
 - Add explicit failure checks with fail helper in
   trigger-wprobe-btf-typecast.tc.
 - Declare fprobe README requirement in trigger-wprobe-btf-typecast.tc.
Changes in v14:
 - Update dummy wprobe event definition to use '-1' instead of '0'.
Changes in v11:
 - Update trigger-wprobe-btf-typecast.tc to use trace-events-sample
   kernel module.
 - Fix commit comment.
Changes in v9:
 - Newly added.
---
 Documentation/trace/wprobetrace.rst                |    8 ++
 kernel/trace/trace_probe.c                         |   13 +++
 kernel/trace/trace_probe.h                         |    5 +
 tools/testing/selftests/ftrace/config              |    1 
 .../test.d/trigger/trigger-wprobe-btf-typecast.tc  |   85 ++++++++++++++++++++
 5 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc

diff --git a/Documentation/trace/wprobetrace.rst b/Documentation/trace/wprobetrace.rst
index df8985283312..20a11443c6db 100644
--- a/Documentation/trace/wprobetrace.rst
+++ b/Documentation/trace/wprobetrace.rst
@@ -47,6 +47,14 @@ Synopsis of wprobe-events
                   (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
                   (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
                   and bitfield are supported.
+   (STRUCT[,ASGN])FETCHARG->MEMBER[->MEMBER] : If BTF is supported, typecast
+                  FETCHARG to a pointer to STRUCT and then dereference the
+                  pointer defined by ->MEMBER. ASGN can be specified optionally.
+                  If ASGN is specified, FETCHARG will be cast to the same offset
+                  position as the ASGN member, rather than to the beginning of
+                  the STRUCT.
+   (STRUCT[,ASGN])(FETCHARG)->MEMBER[->MEMBER] : typecast can nest, so the above
+                  can also be used with another FETCHARG.
 
    (\*1) This is useful for fetching a field of data structures.
    (\*2) "u" means user-space dereference.
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 77266e042418..ccf489635ad7 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -890,6 +890,16 @@ static int query_btf_struct(const char *sname, struct traceprobe_parse_context *
 		ctx->struct_btf = NULL;
 	}
 
+	if (ctx->btf) {
+		id = btf_find_by_name_kind(ctx->btf, sname, BTF_KIND_STRUCT);
+		if (id > 0) {
+			btf_get(ctx->btf);
+			ctx->struct_btf = ctx->btf;
+			ctx->last_struct = btf_type_by_id(ctx->struct_btf, id);
+			return 0;
+		}
+	}
+
 	id = bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
 	if (id < 0)
 		return id;
@@ -965,7 +975,8 @@ static int handle_typecast(char *arg, struct traceprobe_parse_context *ctx)
 
 	if (!(tparg_is_event_probe(ctx->flags) ||
 	      tparg_is_function_entry(ctx->flags) ||
-	      tparg_is_function_return(ctx->flags))) {
+	      tparg_is_function_return(ctx->flags) ||
+	      tparg_is_wprobe(ctx->flags))) {
 		trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
 		return -EOPNOTSUPP;
 	}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 1e11077ead67..c54c554b1949 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -439,6 +439,11 @@ static inline bool tparg_is_event_probe(unsigned int flags)
 	return !!(flags & TPARG_FL_TEVENT);
 }
 
+static inline bool tparg_is_wprobe(unsigned int flags)
+{
+	return !!(flags & TPARG_FL_WPROBE);
+}
+
 /* Each typecast consumes nested level. So the max number of typecast is 8. */
 #define TRACEPROBE_MAX_NESTED_LEVEL 8
 
diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index ecdee77f360f..f067874902ed 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -1,5 +1,6 @@
 CONFIG_BPF_SYSCALL=y
 CONFIG_DEBUG_INFO_BTF=y
+CONFIG_DEBUG_INFO_BTF_MODULES=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_EPROBE_EVENTS=y
 CONFIG_FPROBE=y
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc
new file mode 100644
index 000000000000..94831706238a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc
@@ -0,0 +1,85 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test wprobe trigger with BTF typecast fetchargs
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README events/sched/sched_process_fork/trigger "[(structname[,field])]<argname>[->field[->field|.field...]]":README "set_wprobe:<wprobe-event>":README
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
+:;: "Add a wprobe event with BTF typecast fetchargs" ;:
+# (foo_timer_data,timer)$addr->counter reads counter from struct foo_timer_data via BTF typecast
+echo 'w:watch rw@-1:8 address=$addr counter=(foo_timer_data,timer)$addr->counter' >> dynamic_events
+
+:;: "Check the wprobe event is registered with counter field" ;:
+if ! grep -q "counter" dynamic_events; then
+  fail "Failed to register counter field in dynamic_events"
+fi
+
+:;: "Add fprobe event for sample_timer_cb" ;:
+echo 'f:fprobes/testevent sample_timer_cb timer=t' >> dynamic_events
+
+:;: "Enable all events before setting triggers" ;:
+echo 1 > tracing_on
+echo 1 >> events/fprobes/testevent/enable
+
+:;: "Set set_wprobe trigger on testevent" ;:
+echo 'set_wprobe:watch:timer' >> events/fprobes/testevent/trigger
+if ! grep -q ^set_wprobe events/fprobes/testevent/trigger; then
+  fail "Failed to set set_wprobe trigger"
+fi
+
+# Wait for sample_timer_cb to fire and set_wprobe trigger to activate
+sleep 3
+
+:;: "Check set_wprobe trigger activated the watchpoint" ;:
+if ! grep -q watch trace; then
+  fail "Failed to trigger watchpoint"
+fi
+
+:;: "Remove wprobe triggers" ;:
+echo '!set_wprobe:watch:timer' >> events/fprobes/testevent/trigger
+if grep -q ^set_wprobe events/fprobes/testevent/trigger; then
+  fail "Failed to remove set_wprobe trigger"
+fi
+
+:;: "Disable events and remove dynamic events" ;:
+echo 0 > events/enable
+echo > dynamic_events
+clear_trace
+
+exit 0

