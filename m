Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794806874;
	b=0AbehJ8Ru5iDQsnltwsOQsMGmX2SwpLvrLTt1rmrLiNnp9gHouoohAGmhaPZuGsW2yLS
	 hRB10JMNIyBwfNKu7bkyLoneNJG/a5cKRf42kIUwyUx5oLIGGHuScG7gO5mfQ8HxyHLQL
	 2G9OAPPUY/ysuwGvMmtO8h1QRgccotrwqlAthHGgT3FRIFr+n6OxCu3sy88lf+t00jzVI
	 jffp47aVYXCvrSeqo0O5v5emL/H4bkJsGk2V7ppv1wsTkTuriSDd31u1T/GPFxxwsUwIV
	 IU3LLg8tW8RWFcU7d+eP0dO1zfmbpSlWwBNNvCCx5Nx7xYMsRXonkfrV5B78QFHLS0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794806874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=O5NHkt7NnhngHzPzgF85NF8OYuuc5xB3hiYQ4yQmNmk=;
	b=gmwlUidGKyQDfNo+vunWKL1opddVkQxMed8FRAaaAVH79FhYMja9QNAxy4xnDkXJ8lY1
	 71Wh6JqUMzsuXTqtvj72HHbJ5JnGa6Crbb2FOehkOXg5Iif/BnWLFpPZ8XeuTvC0Oncce
	 dUMo6IRxe5ENzrp8d8vFh47iaMLdY7iRie/XkeePadGnpOE4TdmX6eBBy6XwyQ8RxQxNe
	 Mwfln4YyjquXJ1px9YcBwR/g7hhOP5Vo+O0lAy9GGVVFXUmdHY31iqfsU92zPBkpSvfi3
	 Rep9nrN1R1rdFjs4sEm5NfvRyLxJmvLc5y9kwwDn4KIWW+XcLKLNgYfVJOqPXE/00zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPRHNCel;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C64606A31C;
	Mon, 16 Nov 2026 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPRHNCel
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10B41F000C4;
	Mon, 16 Nov 2026 05:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794806874;
	bh=O5NHkt7NnhngHzPzgF85NF8OYuuc5xB3hiYQ4yQmNmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TPRHNCelxn+WmCyMMDl+XKOkjxyOUE5CDlfXWG3PWjeDwBygDomdjcwQD1JE+uZ1C
	 hjoA0CAR8viE03Qf25Tmia5z8TW4mLaaRLBUQ5PRX4/nBwGgZY4FvaMRHxM8aVOEVW
	 74wQBaAdC3SElUyDVrmzfgGov07qX+SDQgEnmqMkTqhHuWIsL18YwOzvXWt89KfBck
	 obXluKKLiUevIvtUU2imBqTsCRnp9KHHm4EysiHzX/gx+CAAPwEsKD8meX/9FV+A10
	 J1DvAelwAXBGet3+IsFcKsl1xhc5PT41ZewAO/mxrPP82rmHnfJ2c2sfDTmhASTLz4
	 ne3Ud+S9ojG5Q==
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
Subject: [PATCH v20 10/11] tracing/wprobe: Support BTF typecast in fetchargs
Date: Mon, 16 Nov 2026 14:27:48 +0900
Message-ID: <179480686808.38065.8907197983948637551.stgit@devnote2>
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

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v20:
 - Verify BTF typecast fields (counter= and expires=) in trace output in
   trigger-wprobe-btf-typecast.tc, and test direct (STRUCT)$addr->MEMBER
   and (STRUCT)$value->MEMBER typecasts.
 - Drop redundant fprobe README check in trigger-wprobe-btf-typecast.tc.
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
index e2813eed0db4..fe04bdbf31da 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -928,6 +928,16 @@ static int query_btf_struct(const char *sname, struct traceprobe_parse_context *
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
@@ -1003,7 +1013,8 @@ static int handle_typecast(char *arg, struct traceprobe_parse_context *ctx)
 
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
index 7e07088464b6..05654c1c4ffd 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -2,6 +2,7 @@ CONFIG_BOOT_CONFIG=y
 CONFIG_BOOTTIME_TRACING=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_DEBUG_INFO_BTF=y
+CONFIG_DEBUG_INFO_BTF_MODULES=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_EPROBE_EVENTS=y
 CONFIG_FPROBE=y
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc
new file mode 100644
index 000000000000..cee5d7b7528f
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
+# we will skip this test if the target function does not exist.
+if ! grep -wq "sample_timer_cb" /proc/kallsyms; then
+    echo "UNRESOLVED: sample_timer_cb not found"
+    exit_unresolved
+fi
+
+:;: "Add a wprobe event with BTF typecast fetchargs" ;:
+# (foo_timer_data,timer)$addr->counter reads counter from struct foo_timer_data via BTF typecast
+# (timer_list)$addr->expires reads expires directly from struct timer_list via BTF typecast
+echo 'w:watch rw@-1:8 address=$addr counter=(foo_timer_data,timer)$addr->counter expires=(timer_list)$addr->expires' >> dynamic_events
+echo 'w:watch_val rw@-1:8 val_exp=(timer_list)$value->expires' >> dynamic_events
+
+:;: "Check the wprobe event is registered with counter and expires fields" ;:
+if ! grep -q "counter=.*expires=" dynamic_events; then
+  fail "Failed to register BTF typecast fields in dynamic_events"
+fi
+echo '-:watch_val' >> dynamic_events
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
+:;: "Check set_wprobe trigger activated the watchpoint and logged BTF fields" ;:
+if ! grep -q "watch:.*counter=.*expires=" trace; then
+  fail "Failed to trigger watchpoint or log BTF typecast fields"
+fi
+
+:;: "Remove wprobe triggers" ;:
+echo '!set_wprobe:watch:timer' >> events/fprobes/testevent/trigger
+if grep -q ^set_wprobe events/fprobes/testevent/trigger; then
+  fail "Failed to remove set_wprobe trigger"
+fi
+if ! grep -q '^1$' events/wprobes/watch/enable; then
+  fail "Watchpoint did not stay enabled after removing set_wprobe trigger"
+fi
+
+:;: "Disable events and remove dynamic events" ;:
+echo 0 > events/enable
+echo > dynamic_events
+clear_trace
+
+exit 0

