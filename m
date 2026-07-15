Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC537DE83;
	Wed, 15 Jul 2026 01:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079860; cv=none; b=agYuY7ZNdxRryegizghBvIEA/Jbn9CMy2zlC8nkPL+uxLPe40c04YCVJplWWL7HtWja9k8WtqFP6cL+MK/BYOaI1IYYf8/yizuBHR1zjjRDonPJ9pRZYQQ8d+qRLuYLkTRFLKq4xOJDhkj2jhudQBbZ2cDjQLc92KnYmYjFpBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079860; c=relaxed/simple;
	bh=MaR9KiSC78lZOfaQwjiO/9u9syCBCovGIHZ3oXpgwXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYxJvJJmbeP+AEZXXpfi8ndhTyG4hpUlxnkG2S4NdxnJ0pazbJ091Eieo6KnQe3zIXdHC8z+vUQBwQo+GBeIpNtgbeVcr4GswkmVmIK4KaFBwDoSOtExIyZncrEMiTsSwBVgR5h610pj4jsKWxCYqihFeUnQwyTL52yel0RiG1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahFTwRme; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahFTwRme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56961F000E9;
	Wed, 15 Jul 2026 01:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784079856;
	bh=QPHVdr+TAWj3Xsv53QrIaD1N7WTqZcX6qeA+4IvDMUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ahFTwRmerJI/VMQ27oMG44ZUfZPGKfpT75ZfU+jJFZfG2lUMpatWhciLRT29665Cr
	 ho1x4jBuSLCEIqqlZnQiBywQ3AE1gB4nQ4N4Wfs4Ws2qC7LpAsfrq7LuQWQ3DmkmM7
	 HNc5hiiTbvrTqvq2az680r1seEh4Lo/MbPi7yxZd7HhrCNHgGL5nDieKMM9zbsrK4c
	 Gw7dhiNJRpk2yePU7HWWw3FjiagU0qpzJfLGmUg5W0AHZfiMLN6FLzIhbZLoEIRQC7
	 9QqcY5DAODn92K7y/JBTbzZGWGTrUoyn5BHWvxUOXdA/WHrDMHK7LUGdavIc3G1SVz
	 PcOPZHzE9aq5w==
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
Subject: [PATCH v7 01/10] tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
Date: Wed, 15 Jul 2026 10:44:10 +0900
Message-ID: <178407985042.95826.15157571843735900142.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178407983818.95826.12714571928538799781.stgit@devnote2>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
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

Add a new probe event for the hardware breakpoint called wprobe-event.
This wprobe allows user to trace (watch) the memory access at the
specified memory address.
The new syntax is;

 w[:[GROUP/]EVENT] [r|w|rw]@[ADDR|SYM][:SIZE] [FETCH_ARGs]

User also can use $addr to fetch the accessed address. But no other
variables are supported. To record updated value, use '+0($addr)'.

For example, tracing updates of the jiffies;

 /sys/kernel/tracing # echo 'w:my_jiffies w@jiffies' >> dynamic_events
 /sys/kernel/tracing # cat dynamic_events
 w:wprobes/my_jiffies w@jiffies:4
 /sys/kernel/tracing # echo 1 > events/wprobes/my_jiffies/enable
 /sys/kernel/tracing # head -n 20 trace | tail -n 5
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
          <idle>-0       [000] d.Z1.   206.547317: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
          <idle>-0       [000] d.Z1.   206.548341: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
          <idle>-0       [000] d.Z1.   206.549346: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)


Link: https://lore.kernel.org/all/175859021100.374439.8723137923620348816.stgit@devnote2/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v7:
  - Include IS_ERR_PCPU fix.
  - use seq_print_ip_sym_offset().
  - fix checkpatch warning on DEFINE_FREE()
  - Use bp->attr.bp_addr instead of tw->addr because it can be updated from another CPU.
---
 Documentation/trace/index.rst       |    1 
 Documentation/trace/wprobetrace.rst |   69 +++
 include/linux/trace_events.h        |    2 
 kernel/trace/Kconfig                |   13 +
 kernel/trace/Makefile               |    1 
 kernel/trace/trace.c                |    9 
 kernel/trace/trace.h                |    5 
 kernel/trace/trace_probe.c          |   22 +
 kernel/trace/trace_probe.h          |    8 
 kernel/trace/trace_wprobe.c         |  692 +++++++++++++++++++++++++++++++++++
 10 files changed, 819 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/trace/wprobetrace.rst
 create mode 100644 kernel/trace/trace_wprobe.c

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 5d9bf4694d5d..2f04f32001ed 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -36,6 +36,7 @@ the Linux kernel.
    kprobes
    kprobetrace
    fprobetrace
+   wprobetrace
    eprobetrace
    fprobe
    ring-buffer-design
diff --git a/Documentation/trace/wprobetrace.rst b/Documentation/trace/wprobetrace.rst
new file mode 100644
index 000000000000..025b4c39b809
--- /dev/null
+++ b/Documentation/trace/wprobetrace.rst
@@ -0,0 +1,69 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Watchpoint probe (wprobe) Event Tracing
+=======================================
+
+.. Author: Masami Hiramatsu <mhiramat@kernel.org>
+
+Overview
+--------
+
+Wprobe event is a dynamic event based on the hardware breakpoint, which is
+similar to other probe events, but it is for watching data access. It allows
+you to trace which code accesses a specified data.
+
+As same as other dynamic events, wprobe events are defined via
+`dynamic_events` interface file on tracefs.
+
+Synopsis of wprobe-events
+-------------------------
+::
+
+  w:[GRP/][EVENT] SPEC [FETCHARGS]                       : Probe on data access
+
+ GRP            : Group name for wprobe. If omitted, use "wprobes" for it.
+ EVENT          : Event name for wprobe. If omitted, an event name is
+                  generated based on the address or symbol.
+ SPEC           : Breakpoint specification.
+                  [r|w|rw]@<ADDRESS|SYMBOL[+|-OFFS]>[:LENGTH]
+
+   r|w|rw       : Access type, r for read, w for write, and rw for both.
+                  Default is rw if omitted.
+   ADDRESS      : Address to trace (hexadecimal).
+   SYMBOL       : Symbol name to trace.
+   LENGTH       : Length of the data to trace in bytes. (1, 2, 4, or 8)
+
+ FETCHARGS      : Arguments. Each probe can have up to 128 args.
+  $addr         : Fetch the accessing address.
+  @ADDR         : Fetch memory at ADDR (ADDR should be in kernel)
+  @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)
+  +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*1)(\*2)
+  \IMM          : Store an immediate value to the argument.
+  NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
+  FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
+                  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
+                  (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
+                  and bitfield are supported.
+
+  (\*1) this is useful for fetching a field of data structures.
+  (\*2) "u" means user-space dereference.
+
+For the details of TYPE, see :ref:`kprobetrace documentation <kprobetrace_types>`.
+
+Usage examples
+--------------
+Here is an example to add a wprobe event on a variable `jiffies`.
+::
+
+  # echo 'w:my_jiffies w@jiffies' >> dynamic_events
+  # cat dynamic_events
+  w:wprobes/my_jiffies w@jiffies
+  # echo 1 > events/wprobes/enable
+  # cat trace | head
+  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+  #              | |         |   |||||     |         |
+           <idle>-0       [000] d.Z1.  717.026259: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
+           <idle>-0       [000] d.Z1.  717.026373: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
+
+You can see the code which writes to `jiffies` is `tick_do_update_jiffies64()`.
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 308c76b57d13..d1e5ab71d928 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -328,6 +328,7 @@ enum {
 	TRACE_EVENT_FL_UPROBE_BIT,
 	TRACE_EVENT_FL_EPROBE_BIT,
 	TRACE_EVENT_FL_FPROBE_BIT,
+	TRACE_EVENT_FL_WPROBE_BIT,
 	TRACE_EVENT_FL_CUSTOM_BIT,
 	TRACE_EVENT_FL_TEST_STR_BIT,
 };
@@ -358,6 +359,7 @@ enum {
 	TRACE_EVENT_FL_UPROBE		= (1 << TRACE_EVENT_FL_UPROBE_BIT),
 	TRACE_EVENT_FL_EPROBE		= (1 << TRACE_EVENT_FL_EPROBE_BIT),
 	TRACE_EVENT_FL_FPROBE		= (1 << TRACE_EVENT_FL_FPROBE_BIT),
+	TRACE_EVENT_FL_WPROBE		= (1 << TRACE_EVENT_FL_WPROBE_BIT),
 	TRACE_EVENT_FL_CUSTOM		= (1 << TRACE_EVENT_FL_CUSTOM_BIT),
 	TRACE_EVENT_FL_TEST_STR		= (1 << TRACE_EVENT_FL_TEST_STR_BIT),
 };
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 0ab5916575a9..b58c2565024f 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -862,6 +862,19 @@ config EPROBE_EVENTS
 	  convert the type of an event field. For example, turn an
 	  address into a string.
 
+config WPROBE_EVENTS
+	bool "Enable wprobe-based dynamic events"
+	depends on TRACING
+	depends on HAVE_HW_BREAKPOINT
+	select PROBE_EVENTS
+	select DYNAMIC_EVENTS
+	help
+	  This allows the user to add watchpoint tracing events based on
+	  hardware breakpoints on the fly via the ftrace interface.
+
+	  Those events can be inserted wherever hardware breakpoints can be
+	  set, and record accessed memory address and values.
+
 config BPF_EVENTS
 	depends on BPF_SYSCALL
 	depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f934ff586bd4..141c8323de20 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
 obj-$(CONFIG_FPROBE) += fprobe.o
 obj-$(CONFIG_RETHOOK) += rethook.o
 obj-$(CONFIG_FPROBE_EVENTS) += trace_fprobe.o
+obj-$(CONFIG_WPROBE_EVENTS) += trace_wprobe.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 obj-$(CONFIG_RV) += rv/
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c9e182d40059..1bc27c0ad029 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4294,8 +4294,12 @@ static const char readme_msg[] =
 	"  uprobe_events\t\t- Create/append/remove/show the userspace dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
 #endif
+#ifdef CONFIG_WPROBE_EVENTS
+	"  wprobe_events\t\t- Create/append/remove/show the hardware breakpoint dynamic events\n"
+	"\t\t\t  Write into this file to define/undefine new trace events.\n"
+#endif
 #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS) || \
-    defined(CONFIG_FPROBE_EVENTS)
+    defined(CONFIG_FPROBE_EVENTS) || defined(CONFIG_WPROBE_EVENTS)
 	"\t  accepts: event-definitions (one definition per line)\n"
 #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
 	"\t   Format: p[:[<group>/][<event>]] <place> [<args>]\n"
@@ -4305,6 +4309,9 @@ static const char readme_msg[] =
 	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
 	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
 #endif
+#ifdef CONFIG_WPROBE_EVENTS
+	"\t           w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]\n"
+#endif
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t           s:[synthetic/]<event> <field> [<field>]\n"
 #endif
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..2f07c5c4ffc8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -179,6 +179,11 @@ struct fexit_trace_entry_head {
 	unsigned long		ret_ip;
 };
 
+struct wprobe_trace_entry_head {
+	struct trace_entry	ent;
+	unsigned long		ip;
+};
+
 #define TRACE_BUF_SIZE		1024
 
 struct trace_array;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 18c212122344..2600d9699bd8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1344,6 +1344,24 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
 		return 0;
 	}
 
+	/* wprobe only support "$addr" and "$value" variable */
+	if (ctx->flags & TPARG_FL_WPROBE) {
+		if (!strcmp(arg, "addr")) {
+			code->op = FETCH_OP_BADDR;
+			return 0;
+		}
+		if (!strcmp(arg, "value")) {
+			code->op = FETCH_OP_BADDR;
+			code++;
+			code->op = FETCH_OP_DEREF;
+			code->offset = 0;
+			*pcode = code;
+			return 0;
+		}
+		err = TP_ERR_BAD_VAR;
+		goto inval;
+	}
+
 	if (str_has_prefix(arg, "retval")) {
 		if (!(ctx->flags & TPARG_FL_RETURN)) {
 			err = TP_ERR_RETVAL_ON_PROBE;
@@ -1491,8 +1509,9 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		ret = parse_probe_vars(arg, type, pcode, end, ctx);
 		break;
 
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	case '%':	/* named register */
-		if (ctx->flags & (TPARG_FL_TEVENT | TPARG_FL_FPROBE)) {
+		if (ctx->flags & (TPARG_FL_TEVENT | TPARG_FL_FPROBE | TPARG_FL_WPROBE)) {
 			/* eprobe and fprobe do not handle registers */
 			trace_probe_log_err(ctx->offset, BAD_VAR);
 			break;
@@ -1505,6 +1524,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		} else
 			trace_probe_log_err(ctx->offset, BAD_REG_NAME);
 		break;
+#endif
 
 	case '@':	/* memory, file-offset or symbol */
 		if (isdigit(arg[1])) {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index e6268a8dc378..64c5fe9bdfc9 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -90,6 +90,7 @@ typedef int (*print_type_func_t)(struct trace_seq *, void *, void *);
 	FETCH_OP(STACK, param),		/* Stack: .param = index */	\
 	FETCH_OP(STACKP, none),		/* Stack pointer */		\
 	FETCH_OP(RETVAL, none),		/* Return value */		\
+	FETCH_OP(BADDR, none),		/* Break address */		\
 	FETCH_OP(IMM, imm),		/* Immediate: .immediate */	\
 	FETCH_OP(COMM, none),		/* Current comm */		\
 	FETCH_OP(CURRENT, none),	/* Current task_struct address */\
@@ -419,6 +420,7 @@ static inline int traceprobe_get_entry_data_size(struct trace_probe *tp)
 #define TPARG_FL_USER   BIT(4)
 #define TPARG_FL_FPROBE BIT(5)
 #define TPARG_FL_TPOINT BIT(6)
+#define TPARG_FL_WPROBE BIT(7)
 #define TPARG_FL_LOC_MASK	GENMASK(4, 0)
 
 static inline bool tparg_is_function_entry(unsigned int flags)
@@ -600,7 +602,11 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(TYPECAST_SYM_OFFSET,	"@SYM+/-OFFSET with typecast needs parentheses"), \
 	C(TYPECAST_NOT_ALIGNED,	"Typecast field option is not byte-aligned"), \
 	C(TYPECAST_BAD_ARROW,	"Typecast field option does not support -> operator"), \
-	C(NOSUP_PERCPU,		"Per-cpu variable access is only for kernel probes"),
+	C(NOSUP_PERCPU,		"Per-cpu variable access is only for kernel probes"), \
+	C(BAD_ACCESS_FMT,	"Access memory address requires @"),	\
+	C(BAD_ACCESS_TYPE,	"Bad memory access type"),	\
+	C(BAD_ACCESS_LEN,	"This memory access length is not supported"), \
+	C(BAD_ACCESS_ADDR,	"Invalid access memory address"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a
diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
new file mode 100644
index 000000000000..b52f3eac719f
--- /dev/null
+++ b/kernel/trace/trace_wprobe.c
@@ -0,0 +1,692 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hardware-breakpoint-based tracing events
+ *
+ * Copyright (C) 2023, Masami Hiramatsu <mhiramat@kernel.org>
+ */
+#define pr_fmt(fmt)	"trace_wprobe: " fmt
+
+#include <linux/hw_breakpoint.h>
+#include <linux/kallsyms.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/perf_event.h>
+#include <linux/rculist.h>
+#include <linux/security.h>
+#include <linux/tracepoint.h>
+#include <linux/uaccess.h>
+
+#include <asm/ptrace.h>
+
+#include "trace_dynevent.h"
+#include "trace_probe.h"
+#include "trace_probe_kernel.h"
+#include "trace_probe_tmpl.h"
+
+#define WPROBE_EVENT_SYSTEM "wprobes"
+
+static int trace_wprobe_create(const char *raw_command);
+static int trace_wprobe_show(struct seq_file *m, struct dyn_event *ev);
+static int trace_wprobe_release(struct dyn_event *ev);
+static bool trace_wprobe_is_busy(struct dyn_event *ev);
+static bool trace_wprobe_match(const char *system, const char *event,
+			       int argc, const char **argv, struct dyn_event *ev);
+
+static struct dyn_event_operations trace_wprobe_ops = {
+	.create = trace_wprobe_create,
+	.show = trace_wprobe_show,
+	.is_busy = trace_wprobe_is_busy,
+	.free = trace_wprobe_release,
+	.match = trace_wprobe_match,
+};
+
+struct trace_wprobe {
+	struct dyn_event	devent;
+	struct perf_event * __percpu *bp_event;
+	unsigned long		addr;
+	int			len;
+	int			type;
+	const char		*symbol;
+	struct trace_probe	tp;
+};
+
+static bool is_trace_wprobe(struct dyn_event *ev)
+{
+	return ev->ops == &trace_wprobe_ops;
+}
+
+static struct trace_wprobe *to_trace_wprobe(struct dyn_event *ev)
+{
+	return container_of(ev, struct trace_wprobe, devent);
+}
+
+#define for_each_trace_wprobe(pos, dpos)			\
+	for_each_dyn_event(dpos)				\
+		if (is_trace_wprobe(dpos) && (pos = to_trace_wprobe(dpos)))
+
+static bool trace_wprobe_is_busy(struct dyn_event *ev)
+{
+	struct trace_wprobe *tw = to_trace_wprobe(ev);
+
+	return trace_probe_is_enabled(&tw->tp);
+}
+
+static bool trace_wprobe_match(const char *system, const char *event,
+			       int argc, const char **argv, struct dyn_event *ev)
+{
+	struct trace_wprobe *tw = to_trace_wprobe(ev);
+
+	if (event[0] != '\0' && strcmp(trace_probe_name(&tw->tp), event))
+		return false;
+
+	if (system && strcmp(trace_probe_group_name(&tw->tp), system))
+		return false;
+
+	/* TODO: match arguments */
+	return true;
+}
+
+/*
+ * Note that we don't verify the fetch_insn code, since it does not come
+ * from user space.
+ */
+static int
+process_fetch_insn(struct fetch_insn *code, void *rec, void *edata,
+		   void *dest, void *base)
+{
+	void *baddr = rec;
+	unsigned long val;
+	int ret;
+
+retry:
+	/* 1st stage: get value from context */
+	switch (code->op) {
+	case FETCH_OP_BADDR:
+		val = (unsigned long)baddr;
+		break;
+	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
+		code++;
+		goto retry;
+	default:
+		ret = process_common_fetch_insn(code, &val);
+		if (ret < 0)
+			return ret;
+	}
+	code++;
+
+	return process_fetch_insn_bottom(code, val, dest, base);
+}
+NOKPROBE_SYMBOL(process_fetch_insn)
+
+static void wprobe_trace_handler(struct trace_wprobe *tw,
+				 unsigned long addr,
+				 struct pt_regs *regs,
+				 struct trace_event_file *trace_file)
+{
+	struct wprobe_trace_entry_head *entry;
+	struct trace_event_call *call = trace_probe_event_call(&tw->tp);
+	struct trace_event_buffer fbuffer;
+	int dsize;
+
+	if (WARN_ON_ONCE(call != trace_file->event_call))
+		return;
+
+	if (trace_trigger_soft_disabled(trace_file))
+		return;
+
+	if (tw->addr != addr)
+		return;
+
+	dsize = __get_data_size(&tw->tp, (void *)addr, NULL);
+
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
+					   sizeof(*entry) + tw->tp.size + dsize);
+	if (!entry)
+		return;
+
+	entry->ip = instruction_pointer(regs);
+	store_trace_args(&entry[1], &tw->tp, (void *)addr, NULL, sizeof(*entry), dsize);
+
+	fbuffer.regs = regs;
+	trace_event_buffer_commit(&fbuffer);
+}
+
+static void wprobe_perf_handler(struct perf_event *bp,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs)
+{
+	struct trace_wprobe *tw = bp->overflow_handler_context;
+	struct event_file_link *link;
+	unsigned long addr = bp->attr.bp_addr;
+
+	trace_probe_for_each_link_rcu(link, &tw->tp)
+		wprobe_trace_handler(tw, addr, regs, link->file);
+}
+
+static int __register_trace_wprobe(struct trace_wprobe *tw)
+{
+	struct perf_event_attr attr;
+
+	if (tw->bp_event)
+		return -EINVAL;
+
+	hw_breakpoint_init(&attr);
+	attr.bp_addr = tw->addr;
+	attr.bp_len = tw->len;
+	attr.bp_type = tw->type;
+
+	tw->bp_event = register_wide_hw_breakpoint(&attr, wprobe_perf_handler, tw);
+	if (IS_ERR_PCPU(tw->bp_event)) {
+		int ret = PTR_ERR_PCPU(tw->bp_event);
+
+		tw->bp_event = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __unregister_trace_wprobe(struct trace_wprobe *tw)
+{
+	if (tw->bp_event) {
+		unregister_wide_hw_breakpoint(tw->bp_event);
+		tw->bp_event = NULL;
+	}
+}
+
+static void free_trace_wprobe(struct trace_wprobe *tw)
+{
+	if (tw) {
+		trace_probe_cleanup(&tw->tp);
+		kfree(tw->symbol);
+		kfree(tw);
+	}
+}
+DEFINE_FREE(free_trace_wprobe, struct trace_wprobe *,
+	if (!IS_ERR_OR_NULL(_T))
+		free_trace_wprobe(_T))
+
+
+static struct trace_wprobe *alloc_trace_wprobe(const char *group,
+					       const char *event,
+					       const char *symbol,
+					       unsigned long addr,
+					       int len, int type, int nargs)
+{
+	struct trace_wprobe *tw __free(free_trace_wprobe) = NULL;
+	int ret;
+
+	tw = kzalloc(struct_size(tw, tp.args, nargs), GFP_KERNEL);
+	if (!tw)
+		return ERR_PTR(-ENOMEM);
+
+	if (symbol) {
+		tw->symbol = kstrdup(symbol, GFP_KERNEL);
+		if (!tw->symbol)
+			return ERR_PTR(-ENOMEM);
+	}
+	tw->addr = addr;
+	tw->len = len;
+	tw->type = type;
+
+	ret = trace_probe_init(&tw->tp, event, group, false, nargs);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	dyn_event_init(&tw->devent, &trace_wprobe_ops);
+	return_ptr(tw);
+}
+
+static struct trace_wprobe *find_trace_wprobe(const char *event,
+					      const char *group)
+{
+	struct dyn_event *pos;
+	struct trace_wprobe *tw;
+
+	for_each_trace_wprobe(tw, pos)
+		if (strcmp(trace_probe_name(&tw->tp), event) == 0 &&
+		    strcmp(trace_probe_group_name(&tw->tp), group) == 0)
+			return tw;
+	return NULL;
+}
+
+static enum print_line_t
+print_wprobe_event(struct trace_iterator *iter, int flags,
+		   struct trace_event *event)
+{
+	struct wprobe_trace_entry_head *field;
+	struct trace_seq *s = &iter->seq;
+	struct trace_probe *tp;
+
+	field = (struct wprobe_trace_entry_head *)iter->ent;
+	tp = trace_probe_primary_from_call(
+		container_of(event, struct trace_event_call, event));
+	if (WARN_ON_ONCE(!tp))
+		goto out;
+
+	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
+
+	if (!seq_print_ip_sym_offset(s, field->ip, flags))
+		goto out;
+
+	trace_seq_putc(s, ')');
+
+	if (trace_probe_print_args(s, tp->args, tp->nr_args,
+			     (u8 *)&field[1], field) < 0)
+		goto out;
+
+	trace_seq_putc(s, '\n');
+out:
+	return trace_handle_return(s);
+}
+
+static int wprobe_event_define_fields(struct trace_event_call *event_call)
+{
+	int ret;
+	struct wprobe_trace_entry_head field;
+	struct trace_probe *tp;
+
+	tp = trace_probe_primary_from_call(event_call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENOENT;
+
+	DEFINE_FIELD(unsigned long, ip, FIELD_STRING_IP, 0);
+
+	return traceprobe_define_arg_fields(event_call, sizeof(field), tp);
+}
+
+static struct trace_event_functions wprobe_funcs = {
+	.trace	= print_wprobe_event
+};
+
+static struct trace_event_fields wprobe_fields_array[] = {
+	{ .type = TRACE_FUNCTION_TYPE,
+	  .define_fields = wprobe_event_define_fields },
+	{}
+};
+
+static int wprobe_register(struct trace_event_call *event,
+			   enum trace_reg type, void *data);
+
+static inline void init_trace_event_call(struct trace_wprobe *tw)
+{
+	struct trace_event_call *call = trace_probe_event_call(&tw->tp);
+
+	call->event.funcs = &wprobe_funcs;
+	call->class->fields_array = wprobe_fields_array;
+	call->flags = TRACE_EVENT_FL_WPROBE;
+	call->class->reg = wprobe_register;
+}
+
+static int register_wprobe_event(struct trace_wprobe *tw)
+{
+	init_trace_event_call(tw);
+	return trace_probe_register_event_call(&tw->tp);
+}
+
+static int register_trace_wprobe_event(struct trace_wprobe *tw)
+{
+	struct trace_wprobe *old_tb;
+	int ret;
+
+	guard(mutex)(&event_mutex);
+
+	old_tb = find_trace_wprobe(trace_probe_name(&tw->tp),
+				   trace_probe_group_name(&tw->tp));
+	if (old_tb)
+		return -EBUSY;
+
+	ret = register_wprobe_event(tw);
+	if (ret)
+		return ret;
+
+	dyn_event_add(&tw->devent, trace_probe_event_call(&tw->tp));
+	return 0;
+}
+static int unregister_wprobe_event(struct trace_wprobe *tw)
+{
+	return trace_probe_unregister_event_call(&tw->tp);
+}
+
+static int unregister_trace_wprobe(struct trace_wprobe *tw)
+{
+	if (trace_probe_has_sibling(&tw->tp))
+		goto unreg;
+
+	if (trace_probe_is_enabled(&tw->tp))
+		return -EBUSY;
+
+	if (trace_event_dyn_busy(trace_probe_event_call(&tw->tp)))
+		return -EBUSY;
+
+	if (unregister_wprobe_event(tw))
+		return -EBUSY;
+
+unreg:
+	__unregister_trace_wprobe(tw);
+	dyn_event_remove(&tw->devent);
+	trace_probe_unlink(&tw->tp);
+
+	return 0;
+}
+
+static int enable_trace_wprobe(struct trace_event_call *call,
+			       struct trace_event_file *file)
+{
+	struct trace_probe *tp;
+	struct trace_wprobe *tw;
+	bool enabled;
+	int ret = 0;
+
+	tp = trace_probe_primary_from_call(call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENODEV;
+	enabled = trace_probe_is_enabled(tp);
+
+	if (file) {
+		ret = trace_probe_add_file(tp, file);
+		if (ret)
+			return ret;
+	} else {
+		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
+	}
+
+	if (!enabled) {
+		list_for_each_entry(tw, trace_probe_probe_list(tp), tp.list) {
+			ret = __register_trace_wprobe(tw);
+			if (ret < 0) {
+				/* TODO: rollback */
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int disable_trace_wprobe(struct trace_event_call *call,
+				struct trace_event_file *file)
+{
+	struct trace_wprobe *tw;
+	struct trace_probe *tp;
+
+	tp = trace_probe_primary_from_call(call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENODEV;
+
+	if (file) {
+		if (!trace_probe_get_file_link(tp, file))
+			return -ENOENT;
+		if (!trace_probe_has_single_file(tp))
+			goto out;
+		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
+	} else {
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+	}
+
+	if (!trace_probe_is_enabled(tp)) {
+		list_for_each_entry(tw, trace_probe_probe_list(tp), tp.list) {
+			__unregister_trace_wprobe(tw);
+		}
+	}
+
+out:
+	if (file)
+		trace_probe_remove_file(tp, file);
+
+	return 0;
+}
+
+static int wprobe_register(struct trace_event_call *event,
+			   enum trace_reg type, void *data)
+{
+	struct trace_event_file *file = data;
+
+	switch (type) {
+	case TRACE_REG_REGISTER:
+		return enable_trace_wprobe(event, file);
+	case TRACE_REG_UNREGISTER:
+		return disable_trace_wprobe(event, file);
+
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_REG_PERF_REGISTER:
+		return enable_trace_wprobe(event, NULL);
+	case TRACE_REG_PERF_UNREGISTER:
+		return disable_trace_wprobe(event, NULL);
+	case TRACE_REG_PERF_OPEN:
+	case TRACE_REG_PERF_CLOSE:
+	case TRACE_REG_PERF_ADD:
+	case TRACE_REG_PERF_DEL:
+		return 0;
+#endif
+	}
+	return 0;
+}
+
+static int parse_address_spec(const char *spec, unsigned long *addr, int *type,
+			      int *len, char **symbol)
+{
+	char *_spec __free(kfree) = NULL;
+	int _len = HW_BREAKPOINT_LEN_4;
+	int _type = HW_BREAKPOINT_RW;
+	unsigned long _addr = 0;
+	char *at, *col;
+
+	_spec = kstrdup(spec, GFP_KERNEL);
+	if (!_spec)
+		return -ENOMEM;
+
+	at = strchr(_spec, '@');
+	col = strchr(_spec, ':');
+
+	if (!at) {
+		trace_probe_log_err(0, BAD_ACCESS_FMT);
+		return -EINVAL;
+	}
+
+	if (at != _spec) {
+		*at = '\0';
+
+		if (strcmp(_spec, "r") == 0)
+			_type = HW_BREAKPOINT_R;
+		else if (strcmp(_spec, "w") == 0)
+			_type = HW_BREAKPOINT_W;
+		else if (strcmp(_spec, "rw") == 0)
+			_type = HW_BREAKPOINT_RW;
+		else {
+			trace_probe_log_err(0, BAD_ACCESS_TYPE);
+			return -EINVAL;
+		}
+	}
+
+	if (col) {
+		*col = '\0';
+		if (kstrtoint(col + 1, 0, &_len)) {
+			trace_probe_log_err(col + 1 - _spec, BAD_ACCESS_LEN);
+			return -EINVAL;
+		}
+
+		switch (_len) {
+		case 1:
+			_len = HW_BREAKPOINT_LEN_1;
+			break;
+		case 2:
+			_len = HW_BREAKPOINT_LEN_2;
+			break;
+		case 4:
+			_len = HW_BREAKPOINT_LEN_4;
+			break;
+		case 8:
+			_len = HW_BREAKPOINT_LEN_8;
+			break;
+		default:
+			trace_probe_log_err(col + 1 - _spec, BAD_ACCESS_LEN);
+			return -EINVAL;
+		}
+	}
+
+	if (kstrtoul(at + 1, 0, &_addr) != 0) {
+		char *off_str = strpbrk(at + 1, "+-");
+		int offset = 0;
+
+		if (off_str) {
+			if (kstrtoint(off_str, 0, &offset) != 0) {
+				trace_probe_log_err(off_str - _spec, BAD_PROBE_ADDR);
+				return -EINVAL;
+			}
+			*off_str = '\0';
+		}
+		_addr = kallsyms_lookup_name(at + 1);
+		if (!_addr) {
+			trace_probe_log_err(at + 1 - _spec, BAD_ACCESS_ADDR);
+			return -ENOENT;
+		}
+		_addr += offset;
+		*symbol = kstrdup(at + 1, GFP_KERNEL);
+		if (!*symbol)
+			return -ENOMEM;
+	}
+
+	*addr = _addr;
+	*type = _type;
+	*len = _len;
+	return 0;
+}
+
+static int __trace_wprobe_create(int argc, const char *argv[])
+{
+	/*
+	 * Argument syntax:
+	 *  b[:[GRP/][EVENT]] SPEC
+	 *
+	 * SPEC:
+	 *  [r|w|rw]@[ADDR|SYMBOL[+OFFS]][:LEN]
+	 */
+	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
+	struct trace_wprobe *tw __free(free_trace_wprobe) = NULL;
+	const char *event = NULL, *group = WPROBE_EVENT_SYSTEM;
+	const char *tplog __free(trace_probe_log_clear) = NULL;
+	char *symbol = NULL;
+	unsigned long addr;
+	int len, type, i;
+	int ret = 0;
+
+	if (argv[0][0] != 'w')
+		return -ECANCELED;
+
+	if (argc < 2)
+		return -EINVAL;
+
+	tplog = trace_probe_log_init("wprobe", argc, argv);
+
+	if (argv[0][1] != '\0') {
+		if (argv[0][1] != ':') {
+			trace_probe_log_set_index(0);
+			trace_probe_log_err(1, BAD_MAXACT_TYPE);
+			/* Invalid format */
+			return -EINVAL;
+		}
+		event = &argv[0][2];
+	}
+
+	trace_probe_log_set_index(1);
+	ret = parse_address_spec(argv[1], &addr, &type, &len, &symbol);
+	if (ret < 0)
+		return ret;
+
+	if (!event)
+		event = symbol ? symbol : "wprobe";
+
+	argc -= 2; argv += 2;
+	tw = alloc_trace_wprobe(group, event, symbol, addr, len, type, argc);
+	if (IS_ERR(tw))
+		return PTR_ERR(tw);
+
+	ctx = kzalloc_obj(*ctx);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->flags = TPARG_FL_KERNEL | TPARG_FL_WPROBE;
+
+	/* parse arguments */
+	for (i = 0; i < argc; i++) {
+		trace_probe_log_set_index(i + 2);
+		ctx->offset = 0;
+		ret = traceprobe_parse_probe_arg(&tw->tp, i, argv[i], ctx);
+		if (ret)
+			return ret;	/* This can be -ENOMEM */
+	}
+
+	ret = traceprobe_set_print_fmt(&tw->tp, PROBE_PRINT_NORMAL);
+	if (ret < 0)
+		return ret;
+
+	ret = register_trace_wprobe_event(tw);
+	if (!ret)
+		tw = NULL; /* To avoid free */
+
+	return ret;
+}
+
+static int trace_wprobe_create(const char *raw_command)
+{
+	return trace_probe_create(raw_command, __trace_wprobe_create);
+}
+
+static int trace_wprobe_release(struct dyn_event *ev)
+{
+	struct trace_wprobe *tw = to_trace_wprobe(ev);
+	int ret = unregister_trace_wprobe(tw);
+
+	if (!ret)
+		free_trace_wprobe(tw);
+	return ret;
+}
+
+static int trace_wprobe_show(struct seq_file *m, struct dyn_event *ev)
+{
+	struct trace_wprobe *tw = to_trace_wprobe(ev);
+	int i;
+
+	seq_printf(m, "w:%s/%s", trace_probe_group_name(&tw->tp),
+		   trace_probe_name(&tw->tp));
+
+	char type_char;
+
+	if (tw->type == HW_BREAKPOINT_R)
+		type_char = 'r';
+	else if (tw->type == HW_BREAKPOINT_W)
+		type_char = 'w';
+	else
+		type_char = 'x'; /* Should be rw */
+
+	int len;
+
+	if (tw->len == HW_BREAKPOINT_LEN_1)
+		len = 1;
+	else if (tw->len == HW_BREAKPOINT_LEN_2)
+		len = 2;
+	else if (tw->len == HW_BREAKPOINT_LEN_4)
+		len = 4;
+	else
+		len = 8;
+
+	if (tw->symbol)
+		seq_printf(m, " %c@%s:%d", type_char, tw->symbol, len);
+	else
+		seq_printf(m, " %c@0x%lx:%d", type_char, tw->addr, len);
+
+	for (i = 0; i < tw->tp.nr_args; i++)
+		seq_printf(m, " %s=%s", tw->tp.args[i].name, tw->tp.args[i].comm);
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static __init int init_wprobe_trace(void)
+{
+	return dyn_event_register(&trace_wprobe_ops);
+}
+fs_initcall(init_wprobe_trace);
+

