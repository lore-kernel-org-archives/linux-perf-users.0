Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8AE2F3C01;
	Mon,  1 Sep 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737925; cv=none; b=EaEbcY+VrMlKgnnbHuYfJuwMtpoBpkCGdb+MZuhQCibceahDxW3mlRkSbcw3Ao9hN/CXL4VsbKFyb6Ghjd0ZMp+NUQ97MkanbiBVTuLdcgTnY5X3WJz5jSCd9dOWEr/fCtzfQmoEV+FcYQi8VrBrVQEqzdCnK4CvUfmE/3fFZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737925; c=relaxed/simple;
	bh=LoJG8nz0zNgEcQHKrTjGS5ckrC3RDAUe+mWEA5UPsQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIitW8+xzZ1uW4M/YfFMOmJ7G+JZib06RhJ03ltFCfaGggmW22PsPXV+7+StP33tPK0nnakJdCWSGRQCyeFnGY3QBRZGdmZRRh8CfZ0Mhfc8ZwD0vzJmPce70CCQ8rJQtaRVTDuWqkGyookI0wYTrKfGGZY4lXiRKWFBbUAJb4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubyeRu/B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubyeRu/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE355C4CEF0;
	Mon,  1 Sep 2025 14:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737924;
	bh=LoJG8nz0zNgEcQHKrTjGS5ckrC3RDAUe+mWEA5UPsQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubyeRu/BS9a6UGLzGGpzPoy17R+ojgvjr0bVqASObXsfF1qTysrSF3W9TYlSS2kkE
	 zVV+umYLSdaZBIGlAihlclLGe5BO7n2sk2791MzSLnFIN4Juw6VzZD0447AxL/EzXo
	 VtUSzoeViFLww+Co8La9YCDwQ0SOTEoUl74qUlrqDLLRs1FesT8gIvqiLRoVvVFXiq
	 uCJZyXCtkPz4I3M4nVWhCZzRtZikLjhLHinItSTZHMLGIEslfAM52nVa/pYB7Qs4Ld
	 O6/Q7ImYBXxEvv/1tPSB18FVgTjCiF8P4iZsnUp57hfQqiXvIct1l2QqQBC9Srp2Z4
	 hem0QlFIi0MVA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: [RFC PATCH 4/6] tracing: wprobe: Add wprobe event trigger
Date: Mon,  1 Sep 2025 23:45:19 +0900
Message-ID: <175673791934.478080.13510585438052558733.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175673787502.478080.3342912952394010967.stgit@devnote2>
References: <175673787502.478080.3342912952394010967.stgit@devnote2>
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

The trigger syntax is below;

  set_wprobe:WPROBE:FIELD[+offset] [if FILTER]
  clear_wprobe:WPROBE

As you can see, this only sets the address of wprobe, not changing
type and length. That should be set when a new wprobe is created.
Also, the WPROBE event must be disabled when setting the new trigger
and it will be busy afterwards. Recommended usage is to add a new
wprobe at NULL address and keep disabled.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/wprobetrace.rst |   60 +++++
 include/linux/trace_events.h        |    1 
 kernel/trace/Kconfig                |   10 +
 kernel/trace/trace_wprobe.c         |  426 +++++++++++++++++++++++++++++++++++
 4 files changed, 497 insertions(+)

diff --git a/Documentation/trace/wprobetrace.rst b/Documentation/trace/wprobetrace.rst
index 9774f57e2947..67dbf2566289 100644
--- a/Documentation/trace/wprobetrace.rst
+++ b/Documentation/trace/wprobetrace.rst
@@ -67,3 +67,63 @@ Here is an example to add a wprobe event on a variable `jiffies`.
            <idle>-0       [000] d.Z1.  717.026373: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
 
 You can see the code which writes to `jiffies` is `do_timer()`.
+
+Combination with trigger action
+-------------------------------
+The event trigger action can extend the utilization of this wprobe.
+
+- set_wprobe:WPEVENT:FIELD[+|-ADJUST]
+- clear_wprobe:WPEVENT
+
+Set these triggers to the target event, then the WPROBE event will be
+setup to trace the memory access at FIELD[+|-ADJUST] address.
+
+For example, trace the first 8 byte of the dentry data structure passed
+to do_truncate() until it is deleted by __dentry_kill().
+(Note: all tracefs setup uses '>>' so that it does not kick do_truncate())
+
+  # echo 'w:watch rw@0:8 address=$addr value=+0($addr)' > dynamic_events
+
+  # echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
+  # echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
+
+  # echo 'f:dentry_kill __dentry_kill dentry=$arg1' >> dynamic_events
+  # echo 'clear_wprobe:watch' >> events/fprobes/dentry_kill/trigger
+
+  # echo 1 >> events/fprobes/truncate/enable
+  # echo 1 >> events/fprobes/dentry_kill/enable
+
+  # echo aaa > /tmp/hoge
+  # echo bbb > /tmp/hoge
+  # echo ccc > /tmp/hoge
+  # rm /tmp/hoge
+
+Then, the trace data will show;
+
+# tracer: nop
+#
+# entries-in-buffer/entries-written: 16/16   #P:8
+#
+#                                _-----=> irqs-off/BH-disabled
+#                               / _----=> need-resched
+#                              | / _---=> hardirq/softirq
+#                              || / _--=> preempt-depth
+#                              ||| / _-=> migrate-disable
+#                              |||| /     delay
+#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+#    [    7.026136] sh (113) used greatest stack depth: 12912 bytes left
+          | |         |   |||||     |         |
+              sh-113     [002] .....     7.024402: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880069194b8
+              sh-113     [002] ..Zff     7.024822: watch: (lookup_fast+0xaa/0x150) address=0xffff8880069194b8 value=0x200008
+              sh-113     [002] ..Zff     7.024830: watch: (step_into+0x82/0x360) address=0xffff8880069194b8 value=0x200008
+              sh-113     [002] ..Zff     7.024834: watch: (step_into+0x9f/0x360) address=0xffff8880069194b8 value=0x200008
+              sh-113     [002] ..Zff     7.024839: watch: (path_openat+0xb3a/0xe70) address=0xffff8880069194b8 value=0x200008
+              sh-113     [002] ..Zff     7.024843: watch: (path_openat+0xb9a/0xe70) address=0xffff8880069194b8 value=0x200008
+              sh-113     [002] .....     7.024847: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880069194b8
+              sh-113     [002] ...1.     7.025364: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff888006919380
+              sh-113     [002] ...1.     7.025511: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880069195f0
+              rm-118     [003] ...1.     7.027543: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880069194b8
+              sh-113     [002] ...2.     7.027825: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880044429c0
+              sh-113     [002] ...2.     7.027833: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff888004442270
+
+You can see the watch event is correctly configured on the dentry.
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 7c65f2f73ff4..6517c5d7e03e 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -720,6 +720,7 @@ enum event_trigger_type {
 	ETT_EVENT_HIST		= (1 << 4),
 	ETT_HIST_ENABLE		= (1 << 5),
 	ETT_EVENT_EPROBE	= (1 << 6),
+	ETT_EVENT_WPROBE	= (1 << 7),
 };
 
 extern int filter_match_preds(struct event_filter *filter, void *rec);
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index dd8919386425..7396191ccb4d 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -821,6 +821,16 @@ config WPROBE_EVENTS
 	  Those events can be inserted wherever hardware breakpoints can be
 	  set, and record various register and memory values.
 
+config WPROBE_TRIGGERS
+	bool "Enable an event trigger for wprobe"
+	depends on WPROBE_EVENTS
+	depends on HAVE_REINSTALL_HW_BREAKPOINT
+	default y
+	help
+	  This adds an event trigger which will set the wprobe on a specific
+	  field of an event. This allows user to trace the memory access of
+	  an address pointed by the event field.
+
 config BPF_EVENTS
 	depends on BPF_SYSCALL
 	depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index 4b00a8e917c1..a758032429f3 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -6,6 +6,8 @@
  */
 #define pr_fmt(fmt)	"trace_wprobe: " fmt
 
+#include <linux/atomic.h>
+#include <linux/errno.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/kallsyms.h>
 #include <linux/list.h>
@@ -14,11 +16,14 @@
 #include <linux/perf_event.h>
 #include <linux/rculist.h>
 #include <linux/security.h>
+#include <linux/spinlock.h>
 #include <linux/tracepoint.h>
 #include <linux/uaccess.h>
+#include <linux/workqueue.h>
 
 #include <asm/ptrace.h>
 
+#include "trace.h"
 #include "trace_dynevent.h"
 #include "trace_probe.h"
 #include "trace_probe_kernel.h"
@@ -51,6 +56,12 @@ struct trace_wprobe {
 	struct trace_probe	tp;
 };
 
+/* This must be called under cpu locked (e.g. preempt off, irq off) */
+static struct perf_event *trace_wprobe_local_perf(struct trace_wprobe *tw)
+{
+	return *this_cpu_ptr(tw->bp_event);
+}
+
 static bool is_trace_wprobe(struct dyn_event *ev)
 {
 	return ev->ops == &trace_wprobe_ops;
@@ -683,3 +694,418 @@ static __init int init_wprobe_trace(void)
 }
 fs_initcall(init_wprobe_trace);
 
+
+#ifdef CONFIG_WPROBE_TRIGGERS
+
+static int wprobe_trigger_global_enabled;
+
+#define SET_WPROBE_STR		"set_wprobe"
+#define CLEAR_WPROBE_STR	"clear_wprobe"
+#define WPROBE_DEFAULT_CLEAR_ADDRESS ((unsigned long)&wprobe_trigger_global_enabled)
+
+struct wprobe_trigger_data {
+	struct trace_event_file *file;
+	struct trace_wprobe *tw;
+
+	struct perf_event_attr	attr;
+	raw_spinlock_t		lock;	/* lock protects attr */
+	struct work_struct	work;// TBD: use work + IPI or use sched/raw_syscall event?
+	unsigned int		offset;
+	long			adjust;
+	const char		*field;
+	// size must be unsigned long because it should be an address.
+	bool			clear;
+};
+
+static int trace_wprobe_update_local(struct trace_wprobe *tw,
+				     struct perf_event_attr *attr)
+{
+	struct perf_event *bp = trace_wprobe_local_perf(tw);
+
+	return modify_wide_hw_breakpoint_local(bp, attr);
+}
+
+static void wprobe_smp_update_func(void *data)
+{
+	struct wprobe_trigger_data *trigger_data = data;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&trigger_data->lock, flags);
+	trace_wprobe_update_local(trigger_data->tw, &trigger_data->attr);
+	raw_spin_unlock_irqrestore(&trigger_data->lock, flags);
+}
+
+static void wprobe_work_func(struct work_struct *work)
+{
+	struct wprobe_trigger_data *data = container_of(work, struct wprobe_trigger_data, work);
+
+	on_each_cpu(wprobe_smp_update_func, data, false);
+}
+
+static void wprobe_trigger(struct event_trigger_data *data,
+			   struct trace_buffer *buffer,  void *rec,
+			   struct ring_buffer_event *event)
+{
+	struct wprobe_trigger_data *wprobe_data = data->private_data;
+	struct perf_event_attr *attr = &wprobe_data->attr;
+	struct trace_wprobe *tw = wprobe_data->tw;
+	unsigned long addr, flags;
+	int ret = -EBUSY;
+
+	addr = *(unsigned long *)(rec + wprobe_data->offset);
+	addr += wprobe_data->adjust;
+
+	raw_spin_lock_irqsave(&wprobe_data->lock, flags);
+
+	if (!wprobe_data->clear) {
+		if (tw->addr != WPROBE_DEFAULT_CLEAR_ADDRESS)
+			goto unlock;
+
+		tw->addr = attr->bp_addr = addr;
+		ret = trace_wprobe_update_local(tw, attr);
+		if (WARN_ON_ONCE(ret))
+			goto unlock;
+		clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &wprobe_data->file->flags);
+	} else {
+		if (tw->addr == WPROBE_DEFAULT_CLEAR_ADDRESS)
+			goto unlock;
+
+		tw->addr = attr->bp_addr = WPROBE_DEFAULT_CLEAR_ADDRESS;
+		ret = trace_wprobe_update_local(tw, attr);
+		if (WARN_ON_ONCE(ret))
+			goto unlock;
+		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &wprobe_data->file->flags);
+	}
+	schedule_work(&wprobe_data->work);
+unlock:
+	raw_spin_unlock_irqrestore(&wprobe_data->lock, flags);
+}
+
+static void free_wprobe_trigger_data(struct wprobe_trigger_data *wprobe_data)
+{
+	if (wprobe_data)
+		kfree(wprobe_data->field);
+	kfree(wprobe_data);
+}
+
+DEFINE_FREE(free_wprobe_trigger_data, struct wprobe_trigger_data *, free_wprobe_trigger_data(_T));
+
+static int wprobe_trigger_print(struct seq_file *m,
+			       struct event_trigger_data *data)
+{
+	struct wprobe_trigger_data *wprobe_data = data->private_data;
+
+	if (wprobe_data->clear)
+		seq_printf(m, "%s:%s", CLEAR_WPROBE_STR,
+			   trace_event_name(wprobe_data->file->event_call));
+	else
+		seq_printf(m, "%s:%s:%s%+ld", SET_WPROBE_STR,
+			   trace_event_name(wprobe_data->file->event_call),
+			   wprobe_data->field, wprobe_data->adjust);
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
+	struct perf_event_attr *attr;
+
+	wprobe_data = kzalloc(sizeof(*wprobe_data), GFP_KERNEL);
+	if (!wprobe_data)
+		return NULL;
+
+	wprobe_data->tw = tw;
+	wprobe_data->clear = clear;
+	wprobe_data->file = file;
+
+	attr = &wprobe_data->attr;
+	hw_breakpoint_init(attr);
+	attr->bp_type = tw->type;
+	attr->bp_addr = WPROBE_DEFAULT_CLEAR_ADDRESS;
+	attr->bp_len = tw->len;
+
+	raw_spin_lock_init(&wprobe_data->lock);
+	INIT_WORK(&wprobe_data->work, wprobe_work_func);
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
+		free_wprobe_trigger_data(wprobe_data);
+	}
+}
+
+static const struct event_trigger_ops set_wprobe_trigger_ops = {
+	.trigger		= wprobe_trigger,
+	.print			= wprobe_trigger_print,
+	.init			= event_trigger_init,
+	.free			= wprobe_trigger_free,
+};
+
+static const struct event_trigger_ops clear_wprobe_trigger_ops = {
+	.trigger		= wprobe_trigger,
+	.print			= wprobe_trigger_print,
+	.init			= event_trigger_init,
+	.free			= wprobe_trigger_free,
+};
+
+static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
+				    struct trace_event_file *file,
+				    char *glob, char *cmd,
+				    char *param_and_filter)
+{
+	/*
+	 * set_wp:EVENT:FIELD[+OFFS]
+	 * clear_wp:EVENT
+	 */
+	struct wprobe_trigger_data *wprobe_data __free(free_wprobe_trigger_data) = NULL;
+	struct event_trigger_data *trigger_data __free(kfree) = NULL;
+	struct ftrace_event_field *field = NULL;
+	struct trace_event_file *wprobe_file;
+	struct trace_array *tr = file->tr;
+	struct trace_event_call *event;
+	struct perf_event_attr *attr;
+	char *event_str, *field_str;
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
+	attr = &wprobe_data->attr;
+
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
+	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, wprobe_data);
+	if (!trigger_data)
+		return -ENOMEM;
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
+	tw->addr = attr->bp_addr = WPROBE_DEFAULT_CLEAR_ADDRESS;
+	ret = trace_event_enable_disable(wprobe_file, 1, 1);
+	if (ret < 0) {
+		event_trigger_reset_filter(cmd_ops, trigger_data);
+		return ret;
+	}
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret) {
+		event_trigger_reset_filter(cmd_ops, trigger_data);
+		trace_event_enable_disable(wprobe_file, 0, 1);
+		return ret;
+	}
+	/* Make it NULL to avoid freeing trigger_data and wprobe_data by __free() */
+	trigger_data = NULL;
+	wprobe_data = NULL;
+
+	return 0;
+}
+
+/* Return true if there is a trigger which points the same wprobe */
+static bool wprobe_trigger_exist_same(struct event_trigger_data *test,
+				      struct trace_event_file *file)
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
+		if (wprobe_data->tw == test_wprobe_data->tw)
+			return true;
+	}
+	return false;
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
+	if (wprobe_trigger_exist_same(data, file))
+		return -EEXIST;
+
+	if (data->ops->init) {
+		ret = data->ops->init(data);
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
+				      struct event_trigger_data *data,
+				      struct trace_event_file *file)
+{
+	lockdep_assert_held(&event_mutex);
+
+	if (wprobe_trigger_exist_same(data, file)) {
+		list_del_rcu(&data->list);
+		trace_event_trigger_enable_disable(file, 0);
+		update_cond_flag(file);
+	}
+
+	if (data && data->ops->free)
+		data->ops->free(data);
+}
+
+static const struct event_trigger_ops *
+wprobe_get_trigger_ops(char *cmd, char *param)
+{
+	if (!strcmp(cmd, SET_WPROBE_STR))
+		return &set_wprobe_trigger_ops;
+
+	return &clear_wprobe_trigger_ops;
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
+	.get_trigger_ops	= wprobe_get_trigger_ops,
+	.set_filter		= set_trigger_filter,
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
+	.get_trigger_ops	= wprobe_get_trigger_ops,
+	.set_filter		= set_trigger_filter,
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
\ No newline at end of file

