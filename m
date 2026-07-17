Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A407542A14B;
	Fri, 17 Jul 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298094; cv=none; b=jbMFF87CRLPstXJPbypLvs+4CJR8pv22fwfKwD372ScRUyxuUBnTnSVDZFnxQzflhKNerYaumtUWlun+oZDSBzeD7+LEL9H2D91ki8fwh71awK0rZU+yY0L00Zb9H/Bpz9o4c7OMBL8nLOY5LSkMk/iMPL6b/hQFQzORNyml/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298094; c=relaxed/simple;
	bh=sR2y9qIC1RKJLRmHotwZZfScgtc+4IEyNJ36P0S8fQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxEpV04dvpjuyZAM4JxiQiqjGH7qFuhyC4POgRHovdMsBv4C0mMKn8lHRpS6H1MS7iav5rfwAS8gm58JGbpjYtAljxBa1wUvccKGlGJ5gA+KmeDnCL/rgIMOOilyvMf7XRwrAOVqWlpSHqYqYe+SPxOytNtrWvTa1UYLA3sHsks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLX/JxBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLX/JxBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4371F000E9;
	Fri, 17 Jul 2026 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298093;
	bh=m52Fw9GeEPA0ZBlojXrp/w4D3jkG1Tgk7/BsPis+h84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iLX/JxBhSqdn4g16JjHzsZ6tQGUuRS8Jvey1KmxqwabpvdrejjAJ8+o72bnScX3qI
	 fo+2AaSfwB4A8GjwN/DYmScvGeNNzIPKRTwW3BTpr0RyGaoYT0AiqUBoUMTHwd8NM9
	 kJbUwxk3HkKPlGekgw+7d0HxpbdRS3uPcv+E88w+nylJ2oncLZJv7ONkk0nIbkjHQL
	 vG7w7cfiwxv424Ls5HqMn8IGuII0urUJk1AvKAb7p1nO1OqUTBuHnFfsShduJSluss
	 n4EXWsdJPz8l92cT0jLQa95/ZLhxaXzUH3iQvX2vMT+Dyrq6HEpgtKZnDbKDYc50ud
	 PDdNdDaOrFQoA==
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
Subject: [PATCH v9 10/10] tracing/wprobe: Support BTF typecast in fetchargs
Date: Fri, 17 Jul 2026 23:21:27 +0900
Message-ID: <178429808731.157981.9671478928789148148.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178429796992.157981.3393977217853767915.stgit@devnote2>
References: <178429796992.157981.3393977217853767915.stgit@devnote2>
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

Wprobe events use  (the accessed address) and  (the value
at that address). By enabling BTF typecast, users can now cast these
to a concrete struct type and access its fields directly. For example:

  echo 'w:watch rw@0:8 dflag=(struct dentry)$addr->d_flags' >> dynamic_events

With a set_wprobe trigger pointing the watchpoint at a dentry address,
the resulting trace shows d_flags being accessed at that location.

Note that  and  are restricted to kernel-space memory,
which is consistent with the existing TPARG_FL_KERNEL flag used when
parsing wprobe fetchargs.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v9:
  - Newly added.
---
 kernel/trace/trace_probe.c                         |    3 +
 kernel/trace/trace_probe.h                         |    5 +
 .../test.d/trigger/trigger-wprobe-btf-typecast.tc  |   80 ++++++++++++++++++++
 3 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 5d5e9b477b86..8332ff1bb4ff 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -967,7 +967,8 @@ static int handle_typecast(char *arg, struct traceprobe_parse_context *ctx)
 
 	if (!(tparg_is_event_probe(ctx->flags) ||
 	      tparg_is_function_entry(ctx->flags) ||
-	      tparg_is_function_return(ctx->flags))) {
+	      tparg_is_function_return(ctx->flags) ||
+	      tparg_is_wprobe(ctx->flags))) {
 		trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
 		return -EOPNOTSUPP;
 	}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 7380502a85af..0a83b3fb6128 100644
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
 
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc
new file mode 100644
index 000000000000..8962c91d8428
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc
@@ -0,0 +1,80 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test wprobe trigger with BTF typecast fetchargs
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README events/sched/sched_process_fork/trigger "[(structname[,field])]<argname>[->field[->field|.field...]]":README
+
+echo 0 >> tracing_on
+
+rm -f $TMPDIR/hoge
+
+# we will skip this test if fprobe is not supported.
+if ! grep -Fq "f[:[<group>/][<event>]] <func-name>[%return] [<args>]" README; then
+    echo "UNRESOLVED: fprobe is not supported"
+    exit_unresolved
+fi
+
+# we will skip this test if the target function does not exist.
+if ! grep -wq "do_truncate" /proc/kallsyms; then
+    echo "UNRESOLVED: do_truncate not found"
+    exit_unresolved
+fi
+if ! grep -wq "dentry_kill" /proc/kallsyms; then
+    echo "UNRESOLVED: dentry_kill not found"
+    exit_unresolved
+fi
+
+:;: "Add a wprobe event with BTF typecast fetchargs" ;:
+# $addr is the address being accessed (= dentry pointer when watching dentry)
+# (dentry)$addr->d_flags reads d_flags from the dentry struct via BTF typecast
+# Note: BTF typecast uses (STRUCT) without the 'struct' keyword, matching
+# the fetcharg syntax used in fprobe/tprobe events.
+echo 'w:watch rw@0:8 address=$addr dflag=(dentry)$addr->d_flags' >> dynamic_events
+
+:;: "Check the wprobe event is registered with dflag field" ;:
+grep -q "dflag" dynamic_events
+
+:;: "Add events for triggering wprobe" ;:
+echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
+echo 'f:dentry_kill dentry_kill dentry=$arg1' >> dynamic_events
+
+:;: "Add wprobe triggers" ;:
+echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
+echo 'clear_wprobe:watch:dentry' >> events/fprobes/dentry_kill/trigger
+cat events/fprobes/truncate/trigger | grep ^set_wprobe
+cat events/fprobes/dentry_kill/trigger | grep ^clear_wprobe
+
+:;: "Ensure wprobe is still disabled" ;:
+cat events/wprobes/watch/enable | grep 0
+
+:;: "Enable events for triggers" ;:
+echo 1 >> events/fprobes/truncate/enable
+echo 1 >> events/fprobes/dentry_kill/enable
+
+:;: "Start test workload" ;:
+echo 1 >> tracing_on
+
+echo aaa > $TMPDIR/hoge
+sleep 1
+echo bbb > $TMPDIR/hoge
+sleep 1
+echo ccc > $TMPDIR/hoge
+sleep 1
+rm $TMPDIR/hoge
+
+:;: "Drop dentry caches (for dentry_kill)" ;:
+sync && echo 2 >> /proc/sys/vm/drop_caches
+
+:;: "Check trace results include BTF typecast field dflag" ;:
+cat trace > /tmp/test-trace-typecast.log
+cat trace | grep "watch.*dflag="
+
+:;: "Ensure wprobe becomes disabled again" ;:
+cat events/wprobes/watch/enable | grep 0
+
+:;: "Remove wprobe triggers" ;:
+echo '!set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
+echo '!clear_wprobe:watch' >> events/fprobes/dentry_kill/trigger
+! grep ^set_wprobe events/fprobes/truncate/trigger
+! grep ^clear_wprobe events/fprobes/dentry_kill/trigger
+
+exit 0

