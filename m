Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E73B893C;
	Sun, 30 Aug 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100142; cv=none; b=TQrgoopReIBe2lZp1wFFIaKkZp3B/zwRKlIIZQTugMo9q5PNkNjqq2o4DtOw+38Vk8AK9a+ZrwscwjdevbGBevEWDOR49xMh7YbnZ4/C+6Pc7VRIlge7ETDRGXA4ZpnAjMgdOVng1MXh0rnFs0++x3k4pNEVbKzmqs7sQnrzdjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100142; c=relaxed/simple;
	bh=rcxZyN87wljqktT0p9cvAt+cAxJ15IP0qcXLJ+CO1KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuQLKWPRc9c8Zb7Y+cB0yLneKLRriMLL069We4AYXpWYVxQlxOJsIBwn2UdmYsYnyzn1Q50j3wp9GTZn2ikZ/AdL7ws9646bTUwoZNCdAWu2ENUeOIedvlLqCSzhEsUyX5vpFnLN4g7yFmltabxymom1q1Yf07tHnH8JoPSOW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVj25iwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVj25iwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78E81F00A3D;
	Sun, 30 Aug 2026 14:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100137;
	bh=o4wQZDoG6mQnHxypLFl9edUEZUoCMzarA0Nb2nXK+dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QVj25iwHaV/FLE1nbaLDmwjzgsLfuX29bqNR+kwmeMl/BPY7fBOXDYifO3z78LAAT
	 ESzii8Z0PBXlDt1VuXoeg2GE2gBnyuOVUW8wiGvwjBhS7mGYmvmgOYVzi0BX2FGnuA
	 V7zc7zQ3e0477exX3jHCPC9AxsOD2SSNfQq9d03G8RwgHIho4nRdCWtjwF0ufbmxC4
	 80iekRDe9+fRDLpMB0GK5/1meNA2jk08hJEJVrs+rot/Yb2WEaaRc1hodlkU+XXE8I
	 6+aie2FU/ekGN68qM44dRyVHIZhqnQQgkG1qKpi6yv9BLyVyTC9YsYQ3OieAxYfGqa
	 V+KOV2PNwm9rQ==
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
Subject: [PATCH v14 11/14] tracing/wprobe: Add set_wprobe and clear_wprobe event triggers
Date: Sun, 30 Aug 2026 23:28:52 +0900
Message-ID: <178810013249.64882.3483637605217266271.stgit@devnote2>
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

Add set_wprobe and clear_wprobe event triggers to dynamically attach
and detach hardware breakpoint address monitoring based on event field
contents.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v14:
 - Allow '-1' as a dummy address in parse_address_spec() to set initial
   address to WPROBE_DEFAULT_CLEAR_ADDRESS for trigger-only wprobes.
 - In trace_wprobe_show(), format WPROBE_DEFAULT_CLEAR_ADDRESS as '-1'.
 - Update documentation and examples to use '-1' instead of '0'.
 - Skip field parsing in clear_wprobe if parameter is a count keyword.
 - Set tw->addr to WPROBE_DEFAULT_CLEAR_ADDRESS before soft-enabling event
   and roll back on failure.
 - Fix memory and refcount leak of trigger_data/wprobe_data on error path.
Changes in v13:
 - Align WPROBE_DEFAULT_CLEAR_ADDRESS to 8 bytes using dedicated u64.
 - Remove manual count decrement to rely on core event_trigger_count().
 - Parse optional FIELD argument in clear_wprobe command.
 - Fix trigger reference count leak and error cleanup in command parsing.
 - Update document to add [:COUNT] to trigger syntax and fix adjust forms.
 - Add notes about the exclusive trigger setting behavior.
 - Remove unused dyn_event_ops_mutex.
Changes in v12:
 - Decrement trigger data->count only when watchpoint state is actually changed.
 - Remove dyn_event_ops_mutex to fix lockdep circular dependency deadlock.
 - Add event_trigger_init() call to prevent premature freeing of trigger_data.
---
 Documentation/trace/wprobetrace.rst |  107 ++++++
 include/linux/trace_events.h        |    1 
 kernel/trace/Kconfig                |   10 +
 kernel/trace/trace.h                |    1 
 kernel/trace/trace_events_trigger.c |    2 
 kernel/trace/trace_probe.c          |    2 
 kernel/trace/trace_probe.h          |    9 -
 kernel/trace/trace_wprobe.c         |  594 +++++++++++++++++++++++++++++++++++
 8 files changed, 723 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/wprobetrace.rst b/Documentation/trace/wprobetrace.rst
index 31cc68b464e9..df8985283312 100644
--- a/Documentation/trace/wprobetrace.rst
+++ b/Documentation/trace/wprobetrace.rst
@@ -76,3 +76,110 @@ Wprobe event does not disable itself even if the module is unloaded.
 For example, if you add a wprobe event on a module variable, and then
 unload the module, the wprobe event will still be enabled. This is for
 watching the address is used unexpectedly after the module is unloaded.
+
+Combination with trigger action
+-------------------------------
+The event trigger action can extend the utilization of this wprobe.
+
+- set_wprobe:WPEVENT:FIELD[+|-ADJUST][:COUNT]
+- clear_wprobe:WPEVENT[:FIELD[+|-ADJUST][:COUNT]]
+
+Set these triggers to the target event, then the WPROBE event will be
+setup to trace the memory access at FIELD[+|-ADJUST] address.
+When clear_wprobe is hit, if FIELD is NOT specified, the WPEVENT is
+forcibly cleared. If FIELD[+|-ADJUST] is set, it clears WPEVENT only
+if its watching address is the same as the FIELD[+|-ADJUST] value.
+If COUNT is specified, it will set/clear WPEVENT only if it hits COUNT
+times.
+
+Notes:
+- set_wprobe only works on the wprobe which is NOT set a valid address yet,
+  and it must be enabled after the trigger is set.
+- clear_wprobe only works on the wprobe which is set a valid address, and it
+  will be soft-disabled after the trigger is cleared.
+- Therefore, if a trigger sets/clears a wprobe, other/same trigger events
+  will not work (on the same event) while the wprobe is set.
+
+The set_wprobe trigger does not change the type and length, these
+must be set when creating a new wprobe.
+
+The WPROBE event must be disabled when setting the new trigger
+and it will be busy afterwards. Recommended usage is to add a new
+wprobe at invalid dummy address (-1) and keep disabled.
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
+  # echo 'w:watch rw@-1:8 address=$addr value=+0($addr)' >> dynamic_events
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
index 18588c550a98..a61f840b18bd 100644
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
index 149300cc5e8a..120e6ec634b7 100644
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
index 9c7ebe326b76..5033fffd71c5 100644
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
index 6a11c55e7537..29eae708ae7b 100644
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
@@ -51,6 +58,17 @@ struct trace_wprobe {
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
 
@@ -199,14 +217,62 @@ static int __register_trace_wprobe(struct trace_wprobe *tw)
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
@@ -240,6 +306,11 @@ static struct trace_wprobe *alloc_trace_wprobe(const char *group,
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
@@ -498,6 +569,11 @@ static int wprobe_register(struct trace_event_call *event,
 	return 0;
 }
 
+#ifdef CONFIG_WPROBE_TRIGGERS
+static u64 wprobe_trigger_clear_target __aligned(8);
+#define WPROBE_DEFAULT_CLEAR_ADDRESS ((unsigned long)&wprobe_trigger_clear_target)
+#endif
+
 static int parse_address_spec(const char *spec, unsigned long *addr, int *type,
 			      int *len, char **symbol, int *offset)
 {
@@ -561,7 +637,13 @@ static int parse_address_spec(const char *spec, unsigned long *addr, int *type,
 		}
 	}
 
+#ifdef CONFIG_WPROBE_TRIGGERS
+	if (strcmp(at + 1, "-1") == 0) {
+		_addr = WPROBE_DEFAULT_CLEAR_ADDRESS;
+	} else if (kstrtoul(at + 1, 0, &_addr) != 0) {
+#else
 	if (kstrtoul(at + 1, 0, &_addr) != 0) {
+#endif
 		char *off_str = strpbrk(at + 1, "+-");
 
 		if (off_str) {
@@ -748,6 +830,10 @@ static int trace_wprobe_show(struct seq_file *m, struct dyn_event *ev)
 				   tw->offset, len);
 		else
 			seq_printf(m, " %s@%s:%d", type_str, tw->symbol, len);
+#ifdef CONFIG_WPROBE_TRIGGERS
+	} else if (tw->addr == WPROBE_DEFAULT_CLEAR_ADDRESS) {
+		seq_printf(m, " %s@-1:%d", type_str, len);
+#endif
 	} else {
 		seq_printf(m, " %s@0x%lx:%d", type_str, tw->addr, len);
 	}
@@ -765,3 +851,511 @@ static __init int init_wprobe_trace(void)
 }
 fs_initcall(init_wprobe_trace);
 
+#ifdef CONFIG_WPROBE_TRIGGERS
+
+#define SET_WPROBE_STR		"set_wprobe"
+#define CLEAR_WPROBE_STR	"clear_wprobe"
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
+	unsigned long addr = 0, flags;
+	bool changed = false;
+
+	if (in_nmi()) {
+		atomic_inc(&tw->missed);
+		return;
+	}
+
+	if (wprobe_data->field) {
+		addr = *(unsigned long *)((char *)rec + wprobe_data->offset);
+		addr += wprobe_data->adjust;
+	}
+
+	raw_spin_lock_irqsave(&tw->lock, flags);
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
+	struct wprobe_trigger_data *wprobe_data = NULL;
+	struct event_trigger_data *trigger_data = NULL;
+	struct trace_event_file *wprobe_file;
+	struct trace_array *tr = file->tr;
+	char *event_str, *field_str, *comment;
+	struct ftrace_event_field *field;
+	struct trace_event_call *event;
+	bool remove, clear = false;
+	unsigned long orig_addr = 0;
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
+		/* Recover original trigger string to show the error log correctly. */
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
+	/* clear_wprobe does not need field, but can have optional field. */
+	if (!clear) {
+		char *offs;
+
+		/* Find target field, which must be equivalent to "void *" */
+		field_str = strsep(&param, ":");
+		if (!field_str) {
+			wprobe_trigger_log_err(file, glob, strlen(glob), WPROBE_NEED_FIELD);
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		offs = strpbrk(field_str, "+-");
+		if (offs) {
+			long val;
+
+			if (kstrtol(offs, 0, &val) < 0) {
+				wprobe_trigger_log_err(file, glob, offs - glob, BAD_DEREF_OFFS);
+				ret = -EINVAL;
+				goto out_free;
+			}
+			wprobe_data->adjust = val;
+			*offs = '\0';
+		}
+
+		event = file->event_call;
+		field = trace_find_event_field(event, field_str);
+		if (!field) {
+			wprobe_trigger_log_err(file, glob, field_str - glob, NO_EVENT_FIELD);
+			ret = -ENOENT;
+			goto out_free;
+		}
+
+		if (field->size != sizeof(void *)) {
+			wprobe_trigger_log_err(file, glob, field_str - glob, WPROBE_BAD_FIELD);
+			ret = -ENOEXEC;
+			goto out_free;
+		}
+		wprobe_data->offset = field->offset;
+		wprobe_data->field = kstrdup(field_str, GFP_KERNEL);
+		if (!wprobe_data->field) {
+			ret = -ENOMEM;
+			goto out_free;
+		}
+	} else if (param && (isalpha(param[0]) || param[0] == '_')) {
+		if (strncmp(param, "count=", 6) != 0 &&
+		    strncmp(param, "unlimited", 9) != 0) {
+			char *offs;
+
+			field_str = strsep(&param, ":");
+			offs = strpbrk(field_str, "+-");
+			if (offs) {
+				long val;
+
+				if (kstrtol(offs, 0, &val) < 0) {
+					wprobe_trigger_log_err(file, glob, offs - glob, BAD_DEREF_OFFS);
+					ret = -EINVAL;
+					goto out_free;
+				}
+				wprobe_data->adjust = val;
+				*offs = '\0';
+			}
+
+			event = file->event_call;
+			field = trace_find_event_field(event, field_str);
+			if (!field) {
+				wprobe_trigger_log_err(file, glob, field_str - glob, NO_EVENT_FIELD);
+				ret = -ENOENT;
+				goto out_free;
+			}
+
+			if (field->size != sizeof(void *)) {
+				wprobe_trigger_log_err(file, glob, field_str - glob, WPROBE_BAD_FIELD);
+				ret = -ENOEXEC;
+				goto out_free;
+			}
+			wprobe_data->offset = field->offset;
+			wprobe_data->field = kstrdup(field_str, GFP_KERNEL);
+			if (!wprobe_data->field) {
+				ret = -ENOMEM;
+				goto out_free;
+			}
+		}
+	}
+
+	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, wprobe_data);
+	if (!trigger_data) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	trigger_data->private_data_free = free_private_wprobe_trigger_data;
+
+	if (remove) {
+		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
+		trigger_data_free(trigger_data);
+		return 0;
+	}
+
+	/* Up the trigger_data count to make sure nothing frees it on failure */
+	event_trigger_init(trigger_data);
+
+	ret = event_trigger_parse_num(param, trigger_data);
+	if (ret) {
+		wprobe_trigger_log_err(file, glob, param - glob, BAD_IMM);
+		goto out_free_trigger;
+	}
+
+	ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
+	if (ret < 0)
+		goto out_free_trigger;
+
+	/* Soft-enable (register) wprobe event on WPROBE_DEFAULT_CLEAR_ADDRESS */
+	if (!trace_event_try_get_ref(wprobe_file->event_call)) {
+		ret = -ENODEV;
+		goto out_free_trigger;
+	}
+
+	if (!clear) {
+		orig_addr = tw->addr;
+		WRITE_ONCE(tw->addr, WPROBE_DEFAULT_CLEAR_ADDRESS);
+	}
+
+	ret = trace_event_enable_disable(wprobe_file, 1, 1);
+	if (ret < 0) {
+		if (!clear)
+			WRITE_ONCE(tw->addr, orig_addr);
+		goto out_put;
+	}
+
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret)
+		goto out_disable;
+
+	/* Balance the event_trigger_init() at registration start */
+	event_trigger_free(trigger_data);
+	return 0;
+
+out_disable:
+	if (!clear)
+		WRITE_ONCE(tw->addr, orig_addr);
+	trace_event_enable_disable(wprobe_file, 0, 1);
+out_put:
+	trace_event_put_ref(wprobe_file->event_call);
+out_free_trigger:
+	event_trigger_reset_filter(cmd_ops, trigger_data);
+	trigger_data_free(trigger_data);
+	return ret;
+
+out_free:
+	free_wprobe_trigger_data(wprobe_data);
+	return ret;
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
+		if (data->cmd_ops->free)
+			data->cmd_ops->free(data);
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
+	return ret;
+}
+fs_initcall(init_trigger_wprobe_cmds);
+#endif /* CONFIG_WPROBE_TRIGGERS */

