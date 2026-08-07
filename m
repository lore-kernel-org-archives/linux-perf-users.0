Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C893806B0;
	Fri,  7 Aug 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116895; cv=none; b=mO+2ckRcjJfZvbkuYyWulj2ILIahKuOEtZy7w/hprkSRuZjBRjffIXqQlc9CF30PHm6t0Y/4yB6Or7307GgM8qjvBx6mnFcGY+Z5u/Bf4UF99aBQs3fHRND3UncZPg2EhzE/3yop1h8VA4xL6IjzH4U5zygRHM9Lm2iy/ghnVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116895; c=relaxed/simple;
	bh=opeQIh1uE+iQg53KwdgS1aBKhge/VuC4vgElmGMCbNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q326W6zR79fZQR3h2q9idlW33Qbzgpk2drnDQB9kayTPrYI+QWsxgeZnkUX0+XkjZFSzQkqd2uheqPiyITJ6kUvXY42AjdSP0BLAHhCxbuRsZl+tehSihCLDfj9nBnTe2mGBO1YKqEItuoj095umnCWajuqSihgNWjiV3FvMk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gL9BoKfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL9BoKfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2071F00A3A;
	Fri,  7 Aug 2026 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116893;
	bh=rxgIK6MHldUoHDijMQkF3cPjxkXkbvSPwqOJIarYumM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gL9BoKfGEe2mGUQUPqKOX5w7cHnsBhWxh1VJF4LIPIjPuXXgWZxzPmbKfTGLHbgqI
	 55GfKZ3TvYqrtUURJxQqeOSGtEPcrWQjUQ72mJ+xXWOT9GY16g8yAdNCQnQQCghohK
	 6LVNfadlrDxX4LvmWhE4c0TWu7yRXiBCuuOJwSh+4FXpAP0CfBIeA2FvtssqiXLpVZ
	 mgU552H/YRoiKejgMO1tgdlWSEJKq/JoPxeVp3c6smY7rWqWCNs7AgOqT/jfvEpHv7
	 zPSupBb9PNptwB5k8+u+WgCUsFlao2KN6jIHO+AFCt2Fc/Z8Y/LBQXlSMPRYoBORx7
	 cBcT/YmJnSOnA==
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
Subject: [PATCH v12 08/11] tracing/wprobe: Add set_wprobe and clear_wprobe event triggers
Date: Sat,  8 Aug 2026 00:34:47 +0900
Message-ID: <178611688737.237811.17143803996766057381.stgit@devnote2>
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

Add set_wprobe and clear_wprobe event triggers to dynamically attach
and detach hardware breakpoint address monitoring based on event field
contents.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v12:
 - Decrement trigger data->count only when watchpoint state is actually changed.
 - Remove dyn_event_ops_mutex to fix lockdep circular dependency deadlock.
 - Add event_trigger_init() call to prevent premature freeing of trigger_data.
 - Use WRITE_ONCE() when modifying tw->addr to pair with READ_ONCE().
 - Add missing braces to else-block in wprobe_trigger_print().
 - Initialize tw->addr only after trace_event_enable_disable() succeeds.
 - Counter counts only if the trigger is actually working.
Changes in v11:
 - Soft-enable (register) wprobe event on WPROBE_DEFAULT_CLEAR_ADDRESS.
 - Add work_pending check before updating tw->addr.
---
 Documentation/trace/wprobetrace.rst |   98 +++++++
 include/linux/trace_events.h        |    1 
 kernel/trace/Kconfig                |   10 +
 kernel/trace/trace.h                |    1 
 kernel/trace/trace_dynevent.h       |    1 
 kernel/trace/trace_events_trigger.c |    2 
 kernel/trace/trace_probe.c          |    2 
 kernel/trace/trace_probe.h          |    9 +
 kernel/trace/trace_wprobe.c         |  527 +++++++++++++++++++++++++++++++++++
 9 files changed, 648 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/wprobetrace.rst b/Documentation/trace/wprobetrace.rst
index ad5f089b5ef5..a579347735d2 100644
--- a/Documentation/trace/wprobetrace.rst
+++ b/Documentation/trace/wprobetrace.rst
@@ -68,3 +68,101 @@ Here is an example to add a wprobe event on a variable `jiffies`.
            <idle>-0       [000] d.Z1.  717.026373: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
 
 You can see the code which writes to `jiffies` is `tick_do_update_jiffies64()`.
+
+Combination with trigger action
+-------------------------------
+The event trigger action can extend the utilization of this wprobe.
+
+- set_wprobe:WPEVENT:FIELD[+|-ADJUST]
+- clear_wprobe:WPEVENT[:FIELD[+|-]ADJUST]
+
+Set these triggers to the target event, then the WPROBE event will be
+setup to trace the memory access at FIELD[+|-ADJUST] address.
+When clear_wprobe is hit, if FIELD is NOT specified, the WPEVENT is
+forcibly cleared. If FIELD[[+|-]ADJUST] is set, it clears WPEVENT only
+if its watching address is the same as the FIELD[[+|-]ADJUST] value.
+
+Notes:
+The set_wprobe trigger does not change the type and length, these
+must be set when creating a new wprobe.
+
+The WPROBE event must be disabled when setting the new trigger
+and it will be busy afterwards. Recommended usage is to add a new
+wprobe at NULL address and keep disabled.
+
+Wprobe triggers only support target addresses in kernel memory. If a
+set_wprobe trigger evaluates to a user-space memory address or NULL
+pointer, the trigger action ignores the update and skips setting the
+watchpoint.
+
+Wprobe triggers are not supported on kprobe_events, because kprobes
+themselves can use software breakpoints which conflicts with wprobe
+operation.
+
+
+For example, trace the first 8 bytes of the dentry data structure passed
+to do_truncate() until it is deleted by dentry_kill().
+(Note: all tracefs setup uses '>>' so that it does not kick do_truncate())
+::
+
+  # echo 'w:watch rw@0:8 address=$addr value=+0($addr)' >> dynamic_events
+  # echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
+  # echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
+  # echo 'f:dentry_kill dentry_kill dentry=$arg1' >> dynamic_events
+  # echo 'clear_wprobe:watch:dentry' >> events/fprobes/dentry_kill/trigger
+  # echo 1 >> events/fprobes/truncate/enable
+  # echo 1 >> events/fprobes/dentry_kill/enable
+
+  # echo aaa > /tmp/hoge
+  # echo bbb > /tmp/hoge
+  # echo ccc > /tmp/hoge
+  # rm /tmp/hoge
+
+Then, the trace data will show::
+
+ # tracer: nop
+ #
+ # entries-in-buffer/entries-written: 32/32   #P:8
+ #
+ #                                _-----=> irqs-off/BH-disabled
+ #                               / _----=> need-resched
+ #                              | / _---=> hardirq/softirq
+ #                              || / _--=> preempt-depth
+ #                              ||| / _-=> migrate-disable
+ #                              |||| /     delay
+ #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+ #              | |         |   |||||     |         |
+               sh-107     [004] ...1.     9.990418: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004ad6618
+               sh-107     [004] ...1.     9.990914: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004b3de78
+               sh-107     [004] ...1.     9.993175: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049ddd40
+               sh-107     [004] .....     9.995198: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880048083a8
+               sh-107     [004] ...1.     9.995389: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049db998
+               sh-107     [004] ..Zff     9.997503: watch: (lookup_fast+0xaa/0x150) address=0xffff8880048083a8 value=0x8200080
+               sh-107     [004] ..Zff     9.997509: watch: (path_openat+0x211/0xda0) address=0xffff8880048083a8 value=0x8200080
+               sh-107     [004] ..Zff     9.997514: watch: (path_openat+0xa56/0xda0) address=0xffff8880048083a8 value=0x8200080
+               sh-107     [004] ..Zff     9.997518: watch: (path_openat+0xae2/0xda0) address=0xffff8880048083a8 value=0x8200080
+               sh-107     [004] .....     9.997521: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880048083a8
+               sh-107     [004] ...1.     9.997582: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004808270
+               sh-107     [004] ...1.     9.999365: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049db728
+               sh-107     [004] ...1.     9.999388: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004b1c000
+               rm-113     [005] ..Zff    10.000965: watch: (lookup_fast+0xaa/0x150) address=0xffff8880048083a8 value=0x8200080
+               rm-113     [005] ..Zff    10.000971: watch: (path_lookupat+0x97/0x1e0) address=0xffff8880048083a8 value=0x8200080
+               rm-113     [005] ..Zff    10.000984: watch: (lookup_fast+0xaa/0x150) address=0xffff8880048083a8 value=0x8200080
+               rm-113     [005] ..Zff    10.000988: watch: (path_lookupat+0x97/0x1e0) address=0xffff8880048083a8 value=0x8200080
+               rm-113     [005] ..Zff    10.001010: watch: (lookup_one_qstr_excl+0x28/0x140) address=0xffff8880048083a8 value=0x8200080
+               rm-113     [005] ..Zff    10.001014: watch: (lookup_one_qstr_excl+0xd1/0x140) address=0xffff8880048083a8 value=0x8200080
+               rm-113     [005] ..Zff    10.001018: watch: (may_delete_dentry+0x1c/0x200) address=0xffff8880048083a8 value=0x8200080
+               rm-113     [005] ..Zff    10.001021: watch: (may_delete_dentry+0x195/0x200) address=0xffff8880048083a8 value=0x8200080
+               rm-113     [005] ..Zff    10.001031: watch: (vfs_unlink+0x5e/0x260) address=0xffff8880048083a8 value=0x8200080
+               rm-113     [005] d.Z..    10.001067: watch: (d_make_discardable+0x1b/0x40) address=0xffff8880048083a8 value=0x8200080
+               rm-113     [005] d.Z..    10.001071: watch: (d_make_discardable+0x29/0x40) address=0xffff8880048083a8 value=0x200080
+               rm-113     [005] ...1.    10.001072: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880048083a8
+               rm-113     [005] ...1.    10.001218: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880048083a8
+               sh-107     [004] ...1.    10.001416: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049db110
+               sh-107     [004] ...1.    10.001444: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049db248
+               sh-107     [004] ...1.    10.001500: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004ad6618
+               sh-107     [004] ...1.    10.002067: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004b41e78
+               sh-107     [004] ...1.    10.904920: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004b41e78
+               sh-107     [004] ...1.    10.905129: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004ad6618
+
+You can see the watch event is correctly configured on the dentry.
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 43ffd9a76d88..f81a5308c116 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -738,6 +738,7 @@ enum event_trigger_type {
 	ETT_EVENT_HIST		= (1 << 4),
 	ETT_HIST_ENABLE		= (1 << 5),
 	ETT_EVENT_EPROBE	= (1 << 6),
+	ETT_EVENT_WPROBE	= (1 << 7),
 };
 
 extern int filter_match_preds(struct event_filter *filter, void *rec);
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d9b6fa5c35d9..5fd8ed63c516 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -876,6 +876,16 @@ config WPROBE_EVENTS
 	  Those events can be inserted wherever hardware breakpoints can be
 	  set, and record accessed memory address and values.
 
+config WPROBE_TRIGGERS
+	depends on WPROBE_EVENTS
+	depends on HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
+	bool
+	default y
+	help
+	  This adds an event trigger which will set the wprobe on a specific
+	  field of an event. This allows user to trace the memory access of
+	  an address pointed by the event field.
+
 config BPF_EVENTS
 	depends on BPF_SYSCALL
 	depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 64851a8d021f..a789a722bc8b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1983,6 +1983,7 @@ trigger_data_alloc(struct event_command *cmd_ops, char *cmd, char *param,
 		   void *private_data);
 extern void trigger_data_free(struct event_trigger_data *data);
 extern int event_trigger_init(struct event_trigger_data *data);
+extern void event_trigger_free(struct event_trigger_data *data);
 extern int trace_event_trigger_enable_disable(struct trace_event_file *file,
 					      int trigger_enable);
 extern void update_cond_flag(struct trace_event_file *file);
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index beee3f8d7544..77c2c84dcdb5 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -64,6 +64,7 @@ struct dyn_event {
 };
 
 extern struct list_head dyn_event_list;
+extern struct mutex dyn_event_ops_mutex;
 
 static inline
 int dyn_event_init(struct dyn_event *ev, struct dyn_event_operations *ops)
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index ad83419cb420..fa409ebd73c2 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -589,7 +589,7 @@ int event_trigger_init(struct event_trigger_data *data)
  * Usually used directly as the @free method in event trigger
  * implementations.
  */
-static void
+void
 event_trigger_free(struct event_trigger_data *data)
 {
 	if (WARN_ON_ONCE(data->ref <= 0))
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 9f4cad18977a..36e07275a04d 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -20,7 +20,7 @@
 #undef C
 #define C(a, b)		b
 
-static const char *trace_probe_err_text[] = { ERRORS };
+const char *trace_probe_err_text[] = { ERRORS };
 
 static const char *reserved_field_names[] = {
 	"common_type",
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 6543d4c2cda5..e08f17c99138 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -634,7 +634,12 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(TYPECAST_SYM_OFFSET,	"@SYM+/-OFFSET with typecast needs parentheses"),	\
 	C(USED_ARG_NAME,	"This argument name is already used"),		\
 	C(WPROBE_NO_MAXACT,	"Watchpoint probe does not support maxactive"),	\
-	C(WPROBE_NO_SIBLING,	"Watchpoint probe does not support sibling probes"),
+	C(WPROBE_NO_SIBLING,	"Watchpoint probe does not support sibling probes"), \
+	C(WPROBE_ON_KPROBE,	"Wprobe trigger is not supported on kprobe event"), \
+	C(WPROBE_NOT_FOUND,	"Target wprobe event is not found"),		\
+	C(WPROBE_BUSY,		"Target wprobe event is already enabled"),	\
+	C(WPROBE_NEED_FIELD,	"Wprobe trigger requires a target field"),	\
+	C(WPROBE_BAD_FIELD,	"Target field must be pointer size"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a
@@ -658,6 +663,8 @@ void __trace_probe_log_err(int offset, int err);
 
 DEFINE_FREE(trace_probe_log_clear, const char *, if (_T) trace_probe_log_clear())
 
+extern const char *trace_probe_err_text[];
+
 #define trace_probe_log_err(offs, err)	\
 	__trace_probe_log_err(offs, TP_ERR_##err)
 
diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index df592d9280a4..c64bbdc90a40 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -6,7 +6,9 @@
  */
 #define pr_fmt(fmt)	"trace_wprobe: " fmt
 
+#include <linux/atomic.h>
 #include <linux/compiler.h>
+#include <linux/errno.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/kallsyms.h>
 #include <linux/list.h>
@@ -15,11 +17,16 @@
 #include <linux/perf_event.h>
 #include <linux/rculist.h>
 #include <linux/security.h>
+#include <linux/spinlock.h>
 #include <linux/tracepoint.h>
 #include <linux/uaccess.h>
+#include <linux/workqueue.h>
+#include <linux/irq_work.h>
+#include <linux/preempt.h>
 
 #include <asm/ptrace.h>
 
+#include "trace.h"
 #include "trace_dynevent.h"
 #include "trace_probe.h"
 #include "trace_probe_kernel.h"
@@ -50,6 +57,17 @@ struct trace_wprobe {
 	int			len;
 	int			type;
 	const char		*symbol;
+	raw_spinlock_t		lock;
+	struct irq_work		irq_work;
+	struct work_struct	work;
+	atomic_t		missed;
+	/*
+	 * work_pending is set to 1 before irq_work_queue() and cleared to 0
+	 * after wprobe_work_func() finishes on_each_cpu(). This prevents a
+	 * new trigger from overwriting tw->addr while the work is propagating
+	 * the old address to per-CPU debug registers via IPI.
+	 */
+	atomic_t		work_pending;
 	struct trace_probe	tp;
 };
 
@@ -198,14 +216,62 @@ static int __register_trace_wprobe(struct trace_wprobe *tw)
 static void __unregister_trace_wprobe(struct trace_wprobe *tw)
 {
 	if (tw->bp_event) {
+		irq_work_sync(&tw->irq_work);
+		cancel_work_sync(&tw->work);
 		unregister_wide_hw_breakpoint(tw->bp_event);
 		tw->bp_event = NULL;
 	}
 }
 
+static int trace_wprobe_update_local(struct trace_wprobe *tw, unsigned long addr)
+{
+	struct perf_event * __percpu *pevent;
+	struct perf_event *bp;
+
+	pevent = tw->bp_event;
+	if (!pevent)
+		return -EINVAL;
+
+	bp = *this_cpu_ptr(pevent);
+	if (!bp)
+		return -EINVAL;
+
+	return modify_local_hw_breakpoint_addr(bp, addr);
+}
+
+static void wprobe_smp_update_func(void *info)
+{
+	struct trace_wprobe *tw = info;
+	unsigned long addr = READ_ONCE(tw->addr);
+
+	trace_wprobe_update_local(tw, addr);
+}
+
+static void wprobe_work_func(struct work_struct *work)
+{
+	struct trace_wprobe *tw = container_of(work, struct trace_wprobe, work);
+
+	on_each_cpu(wprobe_smp_update_func, tw, true);
+	/*
+	 * Clear work_pending after all CPUs have updated their local debug
+	 * registers.  A new trigger may now update tw->addr and queue a new
+	 * irq_work.
+	 */
+	atomic_set(&tw->work_pending, 0);
+}
+
+static void wprobe_irq_work_func(struct irq_work *irq_work)
+{
+	struct trace_wprobe *tw = container_of(irq_work, struct trace_wprobe, irq_work);
+
+	schedule_work(&tw->work);
+}
+
 static void free_trace_wprobe(struct trace_wprobe *tw)
 {
 	if (tw) {
+		irq_work_sync(&tw->irq_work);
+		cancel_work_sync(&tw->work);
 		trace_probe_cleanup(&tw->tp);
 		kfree(tw->symbol);
 		kfree(tw);
@@ -237,6 +303,11 @@ static struct trace_wprobe *alloc_trace_wprobe(const char *group,
 	tw->addr = addr;
 	tw->len = len;
 	tw->type = type;
+	raw_spin_lock_init(&tw->lock);
+	init_irq_work(&tw->irq_work, wprobe_irq_work_func);
+	INIT_WORK(&tw->work, wprobe_work_func);
+	atomic_set(&tw->missed, 0);
+	atomic_set(&tw->work_pending, 0);
 
 	ret = trace_probe_init(&tw->tp, event, group, false, nargs);
 	if (ret < 0)
@@ -763,3 +834,459 @@ static __init int init_wprobe_trace(void)
 }
 fs_initcall(init_wprobe_trace);
 
+#ifdef CONFIG_WPROBE_TRIGGERS
+
+static int wprobe_trigger_global_enabled;
+
+#define SET_WPROBE_STR		"set_wprobe"
+#define CLEAR_WPROBE_STR	"clear_wprobe"
+#define WPROBE_DEFAULT_CLEAR_ADDRESS ((unsigned long)&wprobe_trigger_global_enabled)
+#define wprobe_trigger_log_err(file, glob, offs, err) \
+	tracing_log_err((file)->tr, "wprobe_trigger", glob, trace_probe_err_text, TP_ERR_##err, offs)
+
+struct wprobe_trigger_data {
+	struct rcu_head		rcu;
+	struct trace_event_file	*file;
+	struct trace_wprobe	*tw;
+	int			offset;
+	long			adjust;
+	const char		*field;
+	bool			clear;
+};
+
+static void wprobe_trigger(struct event_trigger_data *data,
+			   struct trace_buffer *buffer,  void *rec,
+			   struct ring_buffer_event *event)
+{
+	struct wprobe_trigger_data *wprobe_data = data->private_data;
+	struct trace_wprobe *tw = wprobe_data->tw;
+	unsigned long addr, flags;
+	bool changed = false;
+
+	if (in_nmi()) {
+		atomic_inc(&tw->missed);
+		return;
+	}
+
+	addr = *(unsigned long *)((char *)rec + wprobe_data->offset);
+	addr += wprobe_data->adjust;
+
+	raw_spin_lock_irqsave(&tw->lock, flags);
+
+	/* count < 0 means endless, 0 means trigger count exhausted */
+	if (!data->count)
+		goto out;
+
+	if (!wprobe_data->clear) {
+		if (addr < TASK_SIZE) {
+			atomic_inc(&tw->missed);
+			goto out;
+		}
+		if (tw->addr == WPROBE_DEFAULT_CLEAR_ADDRESS) {
+			/* Skip if a previous work is still propagating the address */
+			if (atomic_read(&tw->work_pending)) {
+				atomic_inc(&tw->missed);
+				goto out;
+			}
+			WRITE_ONCE(tw->addr, addr);
+			changed = true;
+			clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &wprobe_data->file->flags);
+		}
+	} else {
+		if (tw->addr != WPROBE_DEFAULT_CLEAR_ADDRESS) {
+			/* Skip if a previous work is still propagating the address */
+			if (atomic_read(&tw->work_pending)) {
+				atomic_inc(&tw->missed);
+				goto out;
+			}
+			if (!wprobe_data->field || tw->addr == addr) {
+				WRITE_ONCE(tw->addr, WPROBE_DEFAULT_CLEAR_ADDRESS);
+				changed = true;
+				set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &wprobe_data->file->flags);
+			}
+		}
+	}
+
+	if (changed) {
+		if (data->count > 0)
+			data->count--;
+
+		/*
+		 * Mark the work as pending before queuing irq_work so that
+		 * subsequent triggers skip updating tw->addr until the work
+		 * has finished propagating the address to all CPUs.
+		 */
+		atomic_set(&tw->work_pending, 1);
+		irq_work_queue(&tw->irq_work);
+	}
+
+out:
+	raw_spin_unlock_irqrestore(&tw->lock, flags);
+}
+
+static void free_wprobe_trigger_data(struct wprobe_trigger_data *wprobe_data)
+{
+	if (wprobe_data) {
+		kfree(wprobe_data->field);
+		kfree(wprobe_data);
+	}
+}
+DEFINE_FREE(free_wprobe_trigger_data, struct wprobe_trigger_data *, free_wprobe_trigger_data(_T));
+
+static void free_private_wprobe_trigger_data(struct event_trigger_data *data)
+{
+	free_wprobe_trigger_data(data->private_data);
+}
+
+static int wprobe_trigger_print(struct seq_file *m,
+			       struct event_trigger_data *data)
+{
+	struct wprobe_trigger_data *wprobe_data = data->private_data;
+
+	if (wprobe_data->clear) {
+		seq_printf(m, "%s:%s", CLEAR_WPROBE_STR,
+			   trace_event_name(wprobe_data->file->event_call));
+		if (wprobe_data->field) {
+			seq_printf(m, ":%s%+ld",
+				   wprobe_data->field, wprobe_data->adjust);
+		}
+	} else {
+		seq_printf(m, "%s:%s:%s%+ld", SET_WPROBE_STR,
+			   trace_event_name(wprobe_data->file->event_call),
+			   wprobe_data->field, wprobe_data->adjust);
+	}
+
+	if (data->count == -1)
+		seq_puts(m, ":unlimited");
+	else
+		seq_printf(m, ":count=%ld", data->count);
+
+	if (data->filter_str)
+		seq_printf(m, " if %s\n", data->filter_str);
+	else
+		seq_putc(m, '\n');
+
+	return 0;
+}
+
+static struct wprobe_trigger_data *
+wprobe_trigger_alloc(struct trace_wprobe *tw, struct trace_event_file *file,
+		     bool clear)
+{
+	struct wprobe_trigger_data *wprobe_data;
+
+	wprobe_data = kzalloc_obj(*wprobe_data);
+	if (!wprobe_data)
+		return NULL;
+
+	wprobe_data->tw = tw;
+	wprobe_data->clear = clear;
+	wprobe_data->file = file;
+
+	return wprobe_data;
+}
+
+static void wprobe_trigger_free(struct event_trigger_data *data)
+{
+	struct wprobe_trigger_data *wprobe_data = data->private_data;
+
+	if (WARN_ON_ONCE(data->ref <= 0))
+		return;
+
+	data->ref--;
+	if (!data->ref) {
+		/* Remove the SOFT_MODE flag */
+		trace_event_enable_disable(wprobe_data->file, 0, 1);
+		trace_event_put_ref(wprobe_data->file->event_call);
+		trigger_data_free(data);
+	}
+}
+
+static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
+				    struct trace_event_file *file,
+				    char *glob, char *cmd,
+				    char *param_and_filter)
+{
+	/*
+	 * set_wprobe:EVENT:FIELD[+OFFS]
+	 * clear_wprobe:EVENT[:FIELD[+OFFS]]
+	 */
+	struct wprobe_trigger_data *wprobe_data __free(free_wprobe_trigger_data) = NULL;
+	struct event_trigger_data *trigger_data __free(kfree) = NULL;
+	char *event_str, *field_str, *count_str, *comment;
+	struct trace_event_file *wprobe_file;
+	struct trace_array *tr = file->tr;
+	struct trace_event_call *event;
+	bool remove, clear = false;
+	struct trace_wprobe *tw;
+	char *param, *filter;
+	int ret;
+
+	remove = event_trigger_check_remove(glob);
+
+	if (!strcmp(cmd, CLEAR_WPROBE_STR))
+		clear = true;
+
+	if (param_and_filter) {
+		if (*(param_and_filter - 1) == '\0')
+			*(param_and_filter - 1) = ':';
+		comment = strchr(param_and_filter, '#');
+		if (comment)
+			*comment = '\0';
+	}
+
+	if (event_trigger_empty_param(param_and_filter)) {
+		wprobe_trigger_log_err(file, glob, strlen(cmd) + 1, WPROBE_NOT_FOUND);
+		return -EINVAL;
+	}
+
+	ret = event_trigger_separate_filter(param_and_filter, &param, &filter, true);
+	if (ret)
+		return ret;
+
+	if (file->event_call->flags & TRACE_EVENT_FL_KPROBE) {
+		wprobe_trigger_log_err(file, glob, 0, WPROBE_ON_KPROBE);
+		return -EOPNOTSUPP;
+	}
+
+	event_str = strsep(&param, ":");
+
+	/* Find target wprobe */
+	tw = find_trace_wprobe(event_str, WPROBE_EVENT_SYSTEM);
+	if (!tw) {
+		wprobe_trigger_log_err(file, glob, event_str - glob, WPROBE_NOT_FOUND);
+		return -ENOENT;
+	}
+	/* The target wprobe must not be used (unless clear) */
+	if (!remove && !clear && trace_probe_is_enabled(&tw->tp)) {
+		wprobe_trigger_log_err(file, glob, event_str - glob, WPROBE_BUSY);
+		return -EBUSY;
+	}
+
+	wprobe_file = find_event_file(tr, WPROBE_EVENT_SYSTEM, event_str);
+	if (!wprobe_file) {
+		wprobe_trigger_log_err(file, glob, event_str - glob, WPROBE_NOT_FOUND);
+		return -EINVAL;
+	}
+
+	wprobe_data = wprobe_trigger_alloc(tw, wprobe_file, clear);
+	if (!wprobe_data)
+		return -ENOMEM;
+
+	/* clear_wprobe does not need field. */
+	if (!clear) {
+		char *offs;
+
+		/* Find target field, which must be equivarent to "void *" */
+		field_str = strsep(&param, ":");
+		if (!field_str) {
+			wprobe_trigger_log_err(file, glob, strlen(glob), WPROBE_NEED_FIELD);
+			return -EINVAL;
+		}
+
+		offs = strpbrk(field_str, "+-");
+		if (offs) {
+			long val;
+
+			if (kstrtol(offs, 0, &val) < 0) {
+				wprobe_trigger_log_err(file, glob, offs - glob, BAD_DEREF_OFFS);
+				return -EINVAL;
+			}
+			wprobe_data->adjust = val;
+			*offs = '\0';
+		}
+
+		event = file->event_call;
+		field = trace_find_event_field(event, field_str);
+		if (!field) {
+			wprobe_trigger_log_err(file, glob, field_str - glob, NO_EVENT_FIELD);
+			return -ENOENT;
+		}
+
+		if (field->size != sizeof(void *)) {
+			wprobe_trigger_log_err(file, glob, field_str - glob, WPROBE_BAD_FIELD);
+			return -ENOEXEC;
+		}
+		wprobe_data->offset = field->offset;
+		wprobe_data->field = kstrdup(field_str, GFP_KERNEL);
+		if (!wprobe_data->field)
+			return -ENOMEM;
+	}
+
+	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, wprobe_data);
+	if (!trigger_data)
+		return -ENOMEM;
+
+	trigger_data->private_data_free = free_private_wprobe_trigger_data;
+
+	if (remove) {
+		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
+		return 0;
+	}
+
+	ret = event_trigger_parse_num(param, trigger_data);
+	if (ret) {
+		wprobe_trigger_log_err(file, glob, param - glob, BAD_IMM);
+		return ret;
+	}
+
+	ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
+	if (ret < 0)
+		return ret;
+
+	/* Soft-enable (register) wprobe event on WPROBE_DEFAULT_CLEAR_ADDRESS */
+	if (!trace_event_try_get_ref(wprobe_file->event_call)) {
+		event_trigger_reset_filter(cmd_ops, trigger_data);
+		return -ENODEV;
+	}
+
+	ret = trace_event_enable_disable(wprobe_file, 1, 1);
+	if (ret < 0) {
+		trace_event_put_ref(wprobe_file->event_call);
+		event_trigger_reset_filter(cmd_ops, trigger_data);
+		return ret;
+	}
+
+	if (!clear)
+		WRITE_ONCE(tw->addr, WPROBE_DEFAULT_CLEAR_ADDRESS);
+
+	event_trigger_init(trigger_data);
+
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret) {
+		event_trigger_reset_filter(cmd_ops, trigger_data);
+		trace_event_enable_disable(wprobe_file, 0, 1);
+		trace_event_put_ref(wprobe_file->event_call);
+		tracepoint_synchronize_unregister();
+		event_trigger_free(trigger_data);
+		return ret;
+	}
+	/* Make it NULL to avoid freeing trigger_data and wprobe_data by __free() */
+	wprobe_data = NULL;
+	event_trigger_free(trigger_data);
+	trigger_data = NULL;
+
+	return 0;
+}
+
+/* Return event_trigger_data if there is a trigger which points the same wprobe */
+static struct event_trigger_data *
+wprobe_trigger_find_same(struct event_trigger_data *test,
+			 struct trace_event_file *file)
+{
+	struct wprobe_trigger_data *test_wprobe_data = test->private_data;
+	struct wprobe_trigger_data *wprobe_data;
+	struct event_trigger_data *iter;
+
+	list_for_each_entry(iter, &file->triggers, list) {
+		wprobe_data = iter->private_data;
+		if (!wprobe_data ||
+		    iter->cmd_ops->trigger_type !=
+		    test->cmd_ops->trigger_type)
+			continue;
+		if (wprobe_data->tw == test_wprobe_data->tw &&
+		    wprobe_data->clear == test_wprobe_data->clear)
+			return iter;
+	}
+	return NULL;
+}
+
+static int wprobe_register_trigger(char *glob,
+				   struct event_trigger_data *data,
+				   struct trace_event_file *file)
+{
+	int ret = 0;
+
+	lockdep_assert_held(&event_mutex);
+
+	/* The same wprobe is not accept on the same file (event) */
+	if (wprobe_trigger_find_same(data, file))
+		return -EEXIST;
+
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
+		if (ret < 0)
+			return ret;
+	}
+
+	list_add_rcu(&data->list, &file->triggers);
+
+	update_cond_flag(file);
+	ret = trace_event_trigger_enable_disable(file, 1);
+	if (ret < 0) {
+		list_del_rcu(&data->list);
+		update_cond_flag(file);
+	}
+	return ret;
+}
+
+static void wprobe_unregister_trigger(char *glob,
+				      struct event_trigger_data *test,
+				      struct trace_event_file *file)
+{
+	struct event_trigger_data *data;
+
+	lockdep_assert_held(&event_mutex);
+
+	data = wprobe_trigger_find_same(test, file);
+	if (!data)
+		return;
+
+	list_del_rcu(&data->list);
+	trace_event_trigger_enable_disable(file, 0);
+	update_cond_flag(file);
+	tracepoint_synchronize_unregister();
+	if (data->cmd_ops->free)
+		data->cmd_ops->free(data);
+}
+
+static struct event_command trigger_wprobe_set_cmd = {
+	.name			= SET_WPROBE_STR,
+	.trigger_type		= ETT_EVENT_WPROBE,
+	/* This triggers after when the event is recorded. */
+	.flags			= EVENT_CMD_FL_NEEDS_REC,
+	.parse			= wprobe_trigger_cmd_parse,
+	.reg			= wprobe_register_trigger,
+	.unreg			= wprobe_unregister_trigger,
+	.set_filter		= set_trigger_filter,
+	.trigger		= wprobe_trigger,
+	.count_func		= event_trigger_count,
+	.print			= wprobe_trigger_print,
+	.init			= event_trigger_init,
+	.free			= wprobe_trigger_free,
+};
+
+static struct event_command trigger_wprobe_clear_cmd = {
+	.name			= CLEAR_WPROBE_STR,
+	.trigger_type		= ETT_EVENT_WPROBE,
+	/* This triggers after when the event is recorded. */
+	.flags			= EVENT_CMD_FL_NEEDS_REC,
+	.parse			= wprobe_trigger_cmd_parse,
+	.reg			= wprobe_register_trigger,
+	.unreg			= wprobe_unregister_trigger,
+	.set_filter		= set_trigger_filter,
+	.trigger		= wprobe_trigger,
+	.count_func		= event_trigger_count,
+	.print			= wprobe_trigger_print,
+	.init			= event_trigger_init,
+	.free			= wprobe_trigger_free,
+};
+
+static __init int init_trigger_wprobe_cmds(void)
+{
+	int ret;
+
+	ret = register_event_command(&trigger_wprobe_set_cmd);
+	if (WARN_ON(ret < 0))
+		return ret;
+	ret = register_event_command(&trigger_wprobe_clear_cmd);
+	if (WARN_ON(ret < 0))
+		unregister_event_command(&trigger_wprobe_set_cmd);
+
+	if (!ret)
+		wprobe_trigger_global_enabled = 1;
+
+	return ret;
+}
+fs_initcall(init_trigger_wprobe_cmds);
+#endif /* CONFIG_WPROBE_TRIGGERS */

