Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B63203B6;
	Sun,  2 Aug 2026 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785658804; cv=none; b=GCKPOeQR9drmkdZIc455GQw1XXauL6gB7tzTSHZlmT5mLr8Cnk4xTnmsErooc9SI/2P7sT6OvF/KdD8Dp4dgD+PWZTgAA+SCzitu/mpM4+pe+KDkQ+T7mk9NzSEuAkDPvKc6nCugZFbbH+K5ZGZbIY/jnVIvruYocFzD19Ru+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785658804; c=relaxed/simple;
	bh=jTb4ZVxZrzgKa11Sj2ntETCQotRNfhsQ2VtYwi6iTNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmDa+KZdolB3akFco/5w2LNnf1q/vfNUI8jkQCj3mjlMq3YNv6vxfEHdAliOqtVwoZLFQMfVXzMqQl1JiozrN3QaY0VIorvEF78ALcxN36sn/iGhda4SAjC9wDRIx7n/LYXv38Y5Cuo4UtwL5VzyVZpTDYhi2/8GIy4Fa+ClqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlijOR1d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlijOR1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D917E1F00AC4;
	Sun,  2 Aug 2026 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785658801;
	bh=RiKu/cWzEa8NvvHK1skoFJ/R6aS3SVhGnz/H83P1xRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JlijOR1d5GtHvriQ1Y0R5wP7f7EMmjulJqIRvEIIWur2JL6mMkibr1lm4BIatbKtR
	 xh1UQFZxioAuXkM1sXqD/n4LTo2P8i4JiXPbxF3X0Gq3wZo6tESukLE2wTjPwQYsaN
	 08jClfZ94PzoVYfBKYvXnomy1KHOAQitNbcWsfopz4MA3nlUlxPyOQubUfhyseHOQ8
	 rW+nPYaZi5sW3DwZP1yoqn+s8BgT2qTvbx2ZRlcjUfsg8lw1jxQxn+uumAtTEFIuau
	 EW1CLRB82Kx6nXrIAc2vqi20kFcgUIZ+LVI1i1rFo+0Pr7+Y0lUd26FSvuMCwXXe15
	 ILRFZwN3rTxOA==
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
Subject: [PATCH v11 08/11] tracing: wprobe: Add wprobe event trigger
Date: Sun,  2 Aug 2026 17:19:55 +0900
Message-ID: <178565879572.714490.13763586507727190682.stgit@devnote2>
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

Add wprobe event trigger to set and clear the watch event dynamically.
This allows us to set an watchpoint on a given local variables and
a slab object instead of static objects.

The trigger syntax is below:

  - set_wprobe:WPROBE:FIELD[+OFFSET][:COUNT] [if FILTER]
  - clear_wprobe:WPROBE[:FIELD[+OFFSET]][:COUNT] [if FILTER]

set_wprobe sets the address pointed by FIELD[+offset] to the WPROBE
event. The FIELD is the field name of trigger event.
clear_wprobe clears the watch address of WPROBE event. If the FIELD
option is specified, it clears only if the current watch address is
same as the given FIELD[+OFFSET] value.
COUNT is the max number of activating trigger.

The set_wprobe trigger does not change the type and length, these
must be set when creating a new wprobe.

Also, the WPROBE event must be disabled when setting the new trigger
and it will be busy afterwards. Recommended usage is to add a new
wprobe at NULL address and keep disabled.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v11:
  - Use new modify_local_hw_breakpoint_addr() API.
  - Add tracepoint_synchronize_unregister() in wprobe_unregister_trigger()
    and parse error path.
  - Safely check tw->bp_event for NULL in trace_wprobe_update_local() to
    prevent race conditions.
  - Use event_trigger_data::private_data_free.
  - Add count option support.
  - Fix trigger address calculation. (cast rec to char *)
  - Add work_pending flag to avoid update conflict with other CPU.
  - Fix to check wprobe_data->clear flag in wprobe_trigger_find_same().
 Changes in v9:
  - Make event_trigger_free() non-static to solve build dependency.
  - Sync irq_work and work inside __unregister_trace_wprobe() before
    clearing tw->bp_event to prevent concurrent NULL pointer dereference.
  - Introduce private_free destructor in struct event_trigger_data to
    safely release wprobe_trigger_data after tracepoint readers exit.
  - Fix filter memory leak in wprobe_trigger_cmd_parse() on the error
    handling path of trace_event_try_get_ref() failure.
  - Avoid overwriting tw->addr on clear_wprobe trigger registration to
    prevent active watchpoint corruption and hardware breakpoint leak.
 Changes in v8:
  - Redesign wprobe_trigger() to be safe in NMI/hardirq contexts by
    deferring register updates to a workqueue via irq_work.
  - Skip trigger execution and increment an atomic missed count
    (tw->missed) if the tracepoint runs in NMI context to prevent
    recursive spinlock deadlocks. (this is currently hidden counter)
  - Prohibit attaching wprobe triggers to kprobe_events by checking
    TRACE_EVENT_FL_KPROBE in wprobe_trigger_cmd_parse().
  - Use call_rcu() in trigger deactivation path and add
    synchronize_rcu() in parse failure path to ensure safe RCU
    lifetime cleanup.
  - Acquire the target tracepoint's module reference via
   trace_event_try_get_ref() to prevent module refcount underflows.
  - Fix event_trigger_data memory leak by properly freeing the
    initial refcount in wprobe_trigger_cmd_parse() on success.
  - Call on_each_cpu() with wait=true in wprobe_work_func() to
    prevent use-after-free during trigger unregistration.
  - Synchronize concurrent wprobe triggers on the same event by
    using a shared raw spinlock (tw->lock).
  - Drop the support of kprobe events (that should be done later).
 Changes in v7:
  - Use kzalloc_obj().
  - Update sample code in document.
 Changes in v6:
  - Update according to the latest change of trigger ops.
 Changes in v5:
  - Following the suggestions, the documentation was revised to suit rst.
 Changes in v3:
  - Add FIELD option support for clear_wprobe and update document.
  - Fix to unregister/free event_trigger_data on file correctly.
  - Fix syntax comments.
 Changes in v2:
  - Getting local cpu perf_event from trace_wprobe directly.
  - Remove trace_wprobe_local_perf() because it is conditionally unused.
  - Make CONFIG_WPROBE_TRIGGERS a hidden config.
---
 Documentation/trace/wprobetrace.rst |   93 ++++++
 include/linux/trace_events.h        |    1 
 kernel/trace/Kconfig                |   10 +
 kernel/trace/trace.h                |    1 
 kernel/trace/trace_events_trigger.c |    2 
 kernel/trace/trace_wprobe.c         |  505 +++++++++++++++++++++++++++++++++++
 6 files changed, 611 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/wprobetrace.rst b/Documentation/trace/wprobetrace.rst
index eb4f10607530..a4c0f0e676fd 100644
--- a/Documentation/trace/wprobetrace.rst
+++ b/Documentation/trace/wprobetrace.rst
@@ -68,3 +68,96 @@ Here is an example to add a wprobe event on a variable `jiffies`.
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
diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index df5e434fffb4..5a034dce0845 100644
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
 
@@ -198,14 +216,61 @@ static int __register_trace_wprobe(struct trace_wprobe *tw)
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
+	struct perf_event **pevent, *bp;
+
+	pevent = READ_ONCE(tw->bp_event);
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
@@ -237,6 +302,11 @@ static struct trace_wprobe *alloc_trace_wprobe(const char *group,
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
@@ -744,3 +814,438 @@ static __init int init_wprobe_trace(void)
 }
 fs_initcall(init_wprobe_trace);
 
+#ifdef CONFIG_WPROBE_TRIGGERS
+
+static int wprobe_trigger_global_enabled;
+
+#define SET_WPROBE_STR		"set_wprobe"
+#define CLEAR_WPROBE_STR	"clear_wprobe"
+#define WPROBE_DEFAULT_CLEAR_ADDRESS ((unsigned long)&wprobe_trigger_global_enabled)
+
+struct wprobe_trigger_data {
+	struct rcu_head		rcu;
+	struct trace_event_file	*file;
+	struct trace_wprobe	*tw;
+	int			offset;
+	long			adjust;
+	const char		*field;
+	bool			clear;
+	long			count;
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
+	addr = *(unsigned long *)((char *)rec + wprobe_data->offset);
+	addr += wprobe_data->adjust;
+
+	if (in_nmi()) {
+		atomic_inc(&tw->missed);
+		return;
+	}
+
+	raw_spin_lock_irqsave(&tw->lock, flags);
+
+	/* count < 0 means endless, i.e. always clear or always set */
+	if (wprobe_data->count > 0)
+		wprobe_data->count--;
+	else if (!wprobe_data->count)
+		goto out;
+
+	if (!wprobe_data->clear) {
+		if (tw->addr == WPROBE_DEFAULT_CLEAR_ADDRESS) {
+			/* Skip if a previous work is still propagating the address */
+			if (atomic_read(&tw->work_pending)) {
+				atomic_inc(&tw->missed);
+				goto out;
+			}
+			tw->addr = addr;
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
+				tw->addr = WPROBE_DEFAULT_CLEAR_ADDRESS;
+				changed = true;
+				set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &wprobe_data->file->flags);
+			}
+		}
+	}
+
+	if (changed) {
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
+	} else
+		seq_printf(m, "%s:%s:%s%+ld", SET_WPROBE_STR,
+			   trace_event_name(wprobe_data->file->event_call),
+			   wprobe_data->field, wprobe_data->adjust);
+
+	if (wprobe_data->count == -1)
+		seq_puts(m, ":unlimited");
+	else
+		seq_printf(m, ":count=%ld", wprobe_data->count);
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
+	wprobe_data->count = -1;
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
+	char *event_str, *field_str, *count_str;
+	struct ftrace_event_field *field = NULL;
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
+	if (event_trigger_empty_param(param_and_filter))
+		return -EINVAL;
+
+	ret = event_trigger_separate_filter(param_and_filter, &param, &filter, true);
+	if (ret)
+		return ret;
+
+	if (file->event_call->flags & TRACE_EVENT_FL_KPROBE)
+		return -EOPNOTSUPP;
+
+	event_str = strsep(&param, ":");
+
+	/* Find target wprobe */
+	tw = find_trace_wprobe(event_str, WPROBE_EVENT_SYSTEM);
+	if (!tw)
+		return -ENOENT;
+	/* The target wprobe must not be used (unless clear) */
+	if (!remove && !clear && trace_probe_is_enabled(&tw->tp))
+		return -EBUSY;
+
+	wprobe_file = find_event_file(tr, WPROBE_EVENT_SYSTEM, event_str);
+	if (!wprobe_file)
+		return -EINVAL;
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
+		if (!field_str)
+			return -EINVAL;
+
+		offs = strpbrk(field_str, "+-");
+		if (offs) {
+			long val;
+
+			if (kstrtol(offs, 0, &val) < 0)
+				return -EINVAL;
+			wprobe_data->adjust = val;
+			*offs = '\0';
+		}
+
+		event = file->event_call;
+		field = trace_find_event_field(event, field_str);
+		if (!field)
+			return -ENOENT;
+
+		if (field->size != sizeof(void *))
+			return -ENOEXEC;
+		wprobe_data->offset = field->offset;
+		wprobe_data->field = kstrdup(field_str, GFP_KERNEL);
+		if (!wprobe_data->field)
+			return -ENOMEM;
+	}
+
+	/* count is optional, "unlimited" by default */
+	count_str = strsep(&param, ":");
+	if (count_str) {
+		long val;
+
+		if (strcmp(count_str, "unlimited")) {
+			if (str_has_prefix(count_str, "count="))
+				count_str += 6;
+			if (kstrtol(count_str, 0, &val) < 0)
+				return -EINVAL;
+			wprobe_data->count = val;
+		}
+	}
+
+	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, wprobe_data);
+	if (!trigger_data)
+		return -ENOMEM;
+
+	trigger_data->private_data_free = free_private_wprobe_trigger_data;
+
+	/* Up the trigger_data count to make sure nothing frees it on failure */
+	event_trigger_init(trigger_data);
+
+	if (remove) {
+		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
+		return 0;
+	}
+
+	ret = event_trigger_parse_num(param, trigger_data);
+	if (ret)
+		return ret;
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
+	if (!clear)
+		WRITE_ONCE(tw->addr, WPROBE_DEFAULT_CLEAR_ADDRESS);
+	ret = trace_event_enable_disable(wprobe_file, 1, 1);
+	if (ret < 0) {
+		trace_event_put_ref(wprobe_file->event_call);
+		event_trigger_reset_filter(cmd_ops, trigger_data);
+		return ret;
+	}
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret) {
+		event_trigger_reset_filter(cmd_ops, trigger_data);
+		trace_event_enable_disable(wprobe_file, 0, 1);
+		trace_event_put_ref(wprobe_file->event_call);
+		tracepoint_synchronize_unregister();
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

