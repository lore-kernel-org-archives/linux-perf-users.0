Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA73A873B;
	Sun, 30 Aug 2026 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100162; cv=none; b=KCXlsjiG2nJffFu98C9wKAxUze/OixdPimwq9uEmfRLF1lDBzBH3TIRsBAAsljin5Idi8X1nBXUXwI0xHGJbb/S1QWrH+Gl2cLH6GEa0MtS8LYi7aQeOZ5mwcsuH3zXF1qCSKJixKy1BguMpdpwZqDs5LzzcWm+pU8p8CB8PH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100162; c=relaxed/simple;
	bh=psJzHdnetuwWw0HQ6jkhXPAQQ9jFRZl59cTiR26d52Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNnW+fH6cxpV5DWrBnUtbPTc5s6mjECS5YYhcR2k5IHtTIc/EjwnDHUz9RPXtHKauYHCpSeR0FVLT5fLCcOlGkYZbu9+5t3rG7l68gVaw8cMspaYOTiSCwrVITrycq68TkOs2zqBwLAZoUWGfvGP1SaJDbSE+uq2/MeaxU01Ls0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWHkwnZp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWHkwnZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3F51F00A3D;
	Sun, 30 Aug 2026 14:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100160;
	bh=b4gIgmLYxGm8keY4xejCvrDvHFn0rPzXaCgBU06lh7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UWHkwnZppLXtD8H9illXh+6P1ixgAxPN9EvNE6Mr2bp1dEzpwG8BzCavXKbnMAVKz
	 Lqw8OnkrCgoERhEJxqtAhZeEVtFymXwHJ3nfnqEcrRowenkfTn2bgSOG08z276ulBH
	 lg+81hkwYwW8babFPPINoTT8SBYeDnXM5RnlmjSNpImBTNSP6P8URLikIMMXwj1n0u
	 SyqqFDDeLe1ik67wS82sLfEV4PYwb0MT62P6f0MqB62ylicNa9+sxAXycZtkz9PYfw
	 BecFhuDSmqxrDLYWDNuiEwmYULsnhONV5KQbRR8+sRV7AnJ4674yivZAbaEikUmyUo
	 hqIu+dZmPQFkQ==
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
Subject: [PATCH v14 13/14] tracing/wprobe: Support BTF typecast in fetchargs
Date: Sun, 30 Aug 2026 23:29:14 +0900
Message-ID: <178810015473.64882.1080115688388623008.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178810001186.64882.2161016469449127450.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
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

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v14:
 - Update dummy wprobe event definition to use '-1' instead of '0'.
Changes in v11:
 - Update trigger-wprobe-btf-typecast.tc to use trace-events-sample
   kernel module.
 - Fix commit comment.
Changes in v9:
 - Newly added.
---
 kernel/trace/trace_probe.c                         |   13 +++-
 kernel/trace/trace_probe.h                         |    5 +
 tools/testing/selftests/ftrace/config              |    1 
 .../test.d/trigger/trigger-wprobe-btf-typecast.tc  |   72 ++++++++++++++++++++
 4 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 5033fffd71c5..97d8ca747fd1 100644
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
index e08f17c99138..8c495097acf2 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -437,6 +437,11 @@ static inline bool tparg_is_event_probe(unsigned int flags)
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
index 000000000000..2b0c64a40701
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc
@@ -0,0 +1,72 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test wprobe trigger with BTF typecast fetchargs
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README events/sched/sched_process_fork/trigger "[(structname[,field])]<argname>[->field[->field|.field...]]":README
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
+grep -q "counter" dynamic_events
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
+cat events/fprobes/testevent/trigger | grep ^set_wprobe
+
+# Wait for sample_timer_cb to fire and set_wprobe trigger to activate
+sleep 3
+
+:;: "Check set_wprobe trigger activated the watchpoint" ;:
+cat trace | grep watch
+
+:;: "Remove wprobe triggers" ;:
+echo '!set_wprobe:watch:timer' >> events/fprobes/testevent/trigger
+! grep ^set_wprobe events/fprobes/testevent/trigger
+
+:;: "Disable events and remove dynamic events" ;:
+echo 0 > events/enable
+echo > dynamic_events
+clear_trace
+
+exit 0

