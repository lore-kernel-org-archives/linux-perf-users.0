Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C136A5F2;
	Tue, 28 Oct 2025 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693068; cv=none; b=F06mf7r5ybMGMFxbnPwOFozoiP5awaC7KcvO+hwK67+XzCRKVKdY7ATkF0J/NnX5fYO1+pVyO/IIeGrxOdbsorCcBWzZcS8RISvldvr6CG+WGz8PXWMrmoRgR94uLaHbYQfdp+fIG7MZpci+DNr1InGQxZnwWZQ9cSfJBGxVcsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693068; c=relaxed/simple;
	bh=XhvOdc47mXAQBrfjChlubd4QQ0kAYV7gF6cSagNgGdQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OqouQkve+vG4dvPYupZN6M8KdD7MRZ89Vdm7QGpq4bxLYDFxeyAlpGTFai3xHEllCpXHVytGWh0Dzpzia6C0AL6MTGzjohvpyhRw3Bv/w+C9HvCC8AJ7IWckPULSwpuSknd5h+TEwTwqUJKfNewwcAGVvSnUO9hegaiFbeBnYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syAF2f6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syAF2f6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28ABCC113D0;
	Tue, 28 Oct 2025 23:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761693068;
	bh=XhvOdc47mXAQBrfjChlubd4QQ0kAYV7gF6cSagNgGdQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=syAF2f6GnmJqRfLIiCw/xE4taToQ4K8MbcLtXAeU20NfybDrznDgSBdOWBku735SU
	 xBR0Gkxbs7mEqoEWHVww1PtSW+3Bbar6hCMafAOTAPyNRrLL2fWjAxLklcSih0CMVC
	 /PXMcJkv8WyBTQ/My+lS7Td5FP6jgLhU/FhuW2rEbhl48MWIEAY/7x+Mp5kr+bJfyF
	 VVe9FBykS6nCAcqH/u55GTd2cwnyAuLOe0NDPULbSkfDvX2QPqMKlbLp4LO0Jg7FH/
	 dUb2kw2Kc6cr9I6M78LDbT15sMofoxO9abS0BIPQxPrq5kz1gibdkuz0c/B50GXDoO
	 T5S+J/2AW9oIQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vDsqx-00000004qpj-1ieI;
	Tue, 28 Oct 2025 19:11:47 -0400
Message-ID: <20251028231147.261867956@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 28 Oct 2025 19:11:16 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v5 02/13] tracing: Have syscall trace events read user space string
References: <20251028231114.820213884@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

As of commit 654ced4a1377 ("tracing: Introduce tracepoint_is_faultable()")
system call trace events allow faulting in user space memory. Have some of
the system call trace events take advantage of this.

Use the trace_user_fault_read() logic to read the user space buffer from
user space and instead of just saving the pointer to the buffer in the
system call event, also save the string that is passed in.

The syscall event has its nb_args shorten from an int to a short (where
even u8 is plenty big enough) and the freed two bytes are used for
"user_mask".  The new "user_mask" field is used to store the index of the
"args" field array that has the address to read from user space. This
value is set to 0 if the system call event does not need to read user
space for a field. This mask can be used to know if the event may fault or
not. Only one bit set in user_mask is supported at this time.

This allows the output to look like this:

 sys_access(filename: 0x7f8c55368470 "/etc/ld.so.preload", mode: 4)
 sys_execve(filename: 0x564ebcf5a6b8 "/usr/bin/emacs", argv: 0x7fff357c0300, envp: 0x564ebc4a4820)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v4: https://lore.kernel.org/20251021005232.590696802@kernel.org

- Hide __NR_<syscall> values in switch statement when not defined
  (kernel test robot)

 include/trace/syscall.h       |   4 +-
 kernel/trace/trace_syscalls.c | 436 ++++++++++++++++++++++++++++++++--
 2 files changed, 420 insertions(+), 20 deletions(-)

diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index 8e193f3a33b3..85f21ca15a41 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -16,6 +16,7 @@
  * @name: name of the syscall
  * @syscall_nr: number of the syscall
  * @nb_args: number of parameters it takes
+ * @user_mask: mask of @args that will read user space
  * @types: list of types as strings
  * @args: list of args as strings (args[i] matches types[i])
  * @enter_fields: list of fields for syscall_enter trace event
@@ -25,7 +26,8 @@
 struct syscall_metadata {
 	const char	*name;
 	int		syscall_nr;
-	int		nb_args;
+	short		nb_args;
+	short		user_mask;
 	const char	**types;
 	const char	**args;
 	struct list_head enter_fields;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 0f932b22f9ec..528ac90eda5d 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <trace/syscall.h>
 #include <trace/events/syscalls.h>
+#include <linux/kernel_stat.h>
 #include <linux/syscalls.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -123,6 +124,9 @@ const char *get_syscall_name(int syscall)
 	return entry->name;
 }
 
+/* Added to user strings when max limit is reached */
+#define EXTRA "..."
+
 static enum print_line_t
 print_syscall_enter(struct trace_iterator *iter, int flags,
 		    struct trace_event *event)
@@ -132,7 +136,9 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 	struct trace_entry *ent = iter->ent;
 	struct syscall_trace_enter *trace;
 	struct syscall_metadata *entry;
-	int i, syscall;
+	int i, syscall, val;
+	unsigned char *ptr;
+	int len;
 
 	trace = (typeof(trace))ent;
 	syscall = trace->nr;
@@ -167,6 +173,19 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 		else
 			trace_seq_printf(s, "%s: 0x%lx", entry->args[i],
 					 trace->args[i]);
+
+		if (!(BIT(i) & entry->user_mask))
+			continue;
+
+		/* This arg points to a user space string */
+		ptr = (void *)trace->args + sizeof(long) * entry->nb_args;
+		val = *(int *)ptr;
+
+		/* The value is a dynamic string (len << 16 | offset) */
+		ptr = (void *)ent + (val & 0xffff);
+		len = val >> 16;
+
+		trace_seq_printf(s, " \"%.*s\"", len, ptr);
 	}
 
 	trace_seq_putc(s, ')');
@@ -223,15 +242,27 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 	for (i = 0; i < entry->nb_args; i++) {
-		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s: 0x%%0%zulx%s",
-				entry->args[i], sizeof(unsigned long),
-				i == entry->nb_args - 1 ? "" : ", ");
+		if (i)
+			pos += snprintf(buf + pos, LEN_OR_ZERO, ", ");
+		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s: 0x%%0%zulx",
+				entry->args[i], sizeof(unsigned long));
+
+		if (!(BIT(i) & entry->user_mask))
+			continue;
+
+		/* Add the format for the user space string */
+		pos += snprintf(buf + pos, LEN_OR_ZERO, " \\\"%%s\\\"");
 	}
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 
 	for (i = 0; i < entry->nb_args; i++) {
 		pos += snprintf(buf + pos, LEN_OR_ZERO,
 				", ((unsigned long)(REC->%s))", entry->args[i]);
+		if (!(BIT(i) & entry->user_mask))
+			continue;
+		/* The user space string for arg has name __<arg>_val */
+		pos += snprintf(buf + pos, LEN_OR_ZERO, ", __get_str(__%s_val)",
+				entry->args[i]);
 	}
 
 #undef LEN_OR_ZERO
@@ -277,8 +308,12 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 {
 	struct syscall_trace_enter trace;
 	struct syscall_metadata *meta = call->data;
+	unsigned long mask;
+	char *arg;
 	int offset = offsetof(typeof(trace), args);
+	int idx;
 	int ret = 0;
+	int len;
 	int i;
 
 	for (i = 0; i < meta->nb_args; i++) {
@@ -291,9 +326,148 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 		offset += sizeof(unsigned long);
 	}
 
+	if (ret || !meta->user_mask)
+		return ret;
+
+	mask = meta->user_mask;
+	idx = ffs(mask) - 1;
+
+	/*
+	 * User space strings are faulted into a temporary buffer and then
+	 * added as a dynamic string to the end of the event.
+	 * The user space string name for the arg pointer is "__<arg>_val".
+	 */
+	len = strlen(meta->args[idx]) + sizeof("___val");
+	arg = kmalloc(len, GFP_KERNEL);
+	if (WARN_ON_ONCE(!arg)) {
+		meta->user_mask = 0;
+		return -ENOMEM;
+	}
+
+	snprintf(arg, len, "__%s_val", meta->args[idx]);
+
+	ret = trace_define_field(call, "__data_loc char[]",
+				 arg, offset, sizeof(int), 0,
+				 FILTER_OTHER);
+	if (ret)
+		kfree(arg);
 	return ret;
 }
 
+#define SYSCALL_FAULT_BUF_SZ 512
+
+/* Use the tracing per CPU buffer infrastructure to copy from user space */
+struct syscall_user_buffer {
+	struct trace_user_buf_info	buf;
+	struct rcu_head			rcu;
+};
+
+static struct syscall_user_buffer *syscall_buffer;
+
+static int syscall_fault_buffer_enable(void)
+{
+	struct syscall_user_buffer *sbuf;
+	int ret;
+
+	lockdep_assert_held(&syscall_trace_lock);
+
+	if (syscall_buffer) {
+		trace_user_fault_get(&syscall_buffer->buf);
+		return 0;
+	}
+
+	sbuf = kmalloc(sizeof(*sbuf), GFP_KERNEL);
+	if (!sbuf)
+		return -ENOMEM;
+
+	ret = trace_user_fault_init(&sbuf->buf, SYSCALL_FAULT_BUF_SZ);
+	if (ret < 0) {
+		kfree(sbuf);
+		return ret;
+	}
+
+	WRITE_ONCE(syscall_buffer, sbuf);
+
+	return 0;
+}
+
+static void rcu_free_syscall_buffer(struct rcu_head *rcu)
+{
+	struct syscall_user_buffer *sbuf =
+		container_of(rcu, struct syscall_user_buffer, rcu);
+
+	trace_user_fault_destroy(&sbuf->buf);
+	kfree(sbuf);
+}
+
+
+static void syscall_fault_buffer_disable(void)
+{
+	struct syscall_user_buffer *sbuf = syscall_buffer;
+
+	lockdep_assert_held(&syscall_trace_lock);
+
+	if (trace_user_fault_put(&sbuf->buf))
+		return;
+
+	WRITE_ONCE(syscall_buffer, NULL);
+	call_rcu_tasks_trace(&sbuf->rcu, rcu_free_syscall_buffer);
+}
+
+static int syscall_copy_user(char *buf, const char __user *ptr,
+			     size_t size, void *data)
+{
+	unsigned long *ret_size = data;
+	int ret;
+
+	ret = strncpy_from_user(buf, ptr, size);
+	if (ret < 0)
+		return 1;
+	*ret_size = ret;
+	return 0;
+}
+
+static char *sys_fault_user(struct syscall_metadata *sys_data,
+			    struct syscall_user_buffer *sbuf,
+			    unsigned long *args, unsigned int *data_size)
+{
+	unsigned long size = SYSCALL_FAULT_BUF_SZ - 1;
+	unsigned long mask = sys_data->user_mask;
+	int idx = ffs(mask) - 1;
+	char *ptr;
+	char *buf;
+
+	/* Get the pointer to user space memory to read */
+	ptr = (char *)args[idx];
+	*data_size = 0;
+
+	buf = trace_user_fault_read(&sbuf->buf, ptr, size,
+				    syscall_copy_user, &size);
+	if (!buf)
+		return NULL;
+
+	/* Replace any non-printable characters with '.' */
+	for (int i = 0; i < size; i++) {
+		if (!isprint(buf[i]))
+			buf[i] = '.';
+	}
+
+	/*
+	 * If the text was truncated due to our max limit, add "..." to
+	 * the string.
+	 */
+	if (size > SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA)) {
+		strscpy(buf + SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA),
+			EXTRA, sizeof(EXTRA));
+		size = SYSCALL_FAULT_BUF_SZ;
+	} else {
+		buf[size++] = '\0';
+	}
+
+	*data_size = size;
+	return buf;
+}
+
 static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 {
 	struct trace_array *tr = data;
@@ -302,15 +476,17 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	struct syscall_metadata *sys_data;
 	struct trace_event_buffer fbuffer;
 	unsigned long args[6];
+	char *user_ptr;
+	int user_size = 0;
 	int syscall_nr;
-	int size;
+	int size = 0;
+	bool mayfault;
 
 	/*
 	 * Syscall probe called with preemption enabled, but the ring
 	 * buffer and per-cpu data require preemption to be disabled.
 	 */
 	might_fault();
-	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
@@ -327,7 +503,32 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	if (!sys_data)
 		return;
 
-	size = sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
+	/* Check if this syscall event faults in user space memory */
+	mayfault = sys_data->user_mask != 0;
+
+	guard(preempt_notrace)();
+
+	syscall_get_arguments(current, regs, args);
+
+	if (mayfault) {
+		struct syscall_user_buffer *sbuf;
+
+		/* If the syscall_buffer is NULL, tracing is being shutdown */
+		sbuf = READ_ONCE(syscall_buffer);
+		if (!sbuf)
+			return;
+
+		user_ptr = sys_fault_user(sys_data, sbuf, args, &user_size);
+		/*
+		 * user_size is the amount of data to append.
+		 * Need to add 4 for the meta field that points to
+		 * the user memory at the end of the event and also
+		 * stores its size.
+		 */
+		size = 4 + user_size;
+	}
+
+	size += sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
 	if (!entry)
@@ -335,9 +536,36 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	entry = ring_buffer_event_data(fbuffer.event);
 	entry->nr = syscall_nr;
-	syscall_get_arguments(current, regs, args);
+
 	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
+	if (mayfault) {
+		void *ptr;
+		int val;
+
+		/*
+		 * Set the pointer to point to the meta data of the event
+		 * that has information about the stored user space memory.
+		 */
+		ptr = (void *)entry->args + sizeof(unsigned long) * sys_data->nb_args;
+
+		/*
+		 * The meta data will store the offset of the user data from
+		 * the beginning of the event.
+		 */
+		val  = (ptr - (void *)entry) + 4;
+
+		/* Store the offset and the size into the meta data */
+		*(int *)ptr = val | (user_size << 16);
+
+		/* Nothing to do if the user space was empty or faulted */
+		if (user_size) {
+			/* Now store the user space data into the event */
+			ptr += 4;
+			memcpy(ptr, user_ptr, user_size);
+		}
+	}
+
 	trace_event_buffer_commit(&fbuffer);
 }
 
@@ -386,39 +614,50 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 static int reg_event_syscall_enter(struct trace_event_file *file,
 				   struct trace_event_call *call)
 {
+	struct syscall_metadata *sys_data = call->data;
 	struct trace_array *tr = file->tr;
 	int ret = 0;
 	int num;
 
-	num = ((struct syscall_metadata *)call->data)->syscall_nr;
+	num = sys_data->syscall_nr;
 	if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls))
 		return -ENOSYS;
-	mutex_lock(&syscall_trace_lock);
-	if (!tr->sys_refcount_enter)
+	guard(mutex)(&syscall_trace_lock);
+	if (sys_data->user_mask) {
+		ret = syscall_fault_buffer_enable();
+		if (ret < 0)
+			return ret;
+	}
+	if (!tr->sys_refcount_enter) {
 		ret = register_trace_sys_enter(ftrace_syscall_enter, tr);
-	if (!ret) {
-		WRITE_ONCE(tr->enter_syscall_files[num], file);
-		tr->sys_refcount_enter++;
+		if (ret < 0) {
+			if (sys_data->user_mask)
+				syscall_fault_buffer_disable();
+			return ret;
+		}
 	}
-	mutex_unlock(&syscall_trace_lock);
-	return ret;
+	WRITE_ONCE(tr->enter_syscall_files[num], file);
+	tr->sys_refcount_enter++;
+	return 0;
 }
 
 static void unreg_event_syscall_enter(struct trace_event_file *file,
 				      struct trace_event_call *call)
 {
+	struct syscall_metadata *sys_data = call->data;
 	struct trace_array *tr = file->tr;
 	int num;
 
-	num = ((struct syscall_metadata *)call->data)->syscall_nr;
+	num = sys_data->syscall_nr;
 	if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls))
 		return;
-	mutex_lock(&syscall_trace_lock);
+	guard(mutex)(&syscall_trace_lock);
 	tr->sys_refcount_enter--;
 	WRITE_ONCE(tr->enter_syscall_files[num], NULL);
 	if (!tr->sys_refcount_enter)
 		unregister_trace_sys_enter(ftrace_syscall_enter, tr);
-	mutex_unlock(&syscall_trace_lock);
+	if (sys_data->user_mask)
+		syscall_fault_buffer_disable();
 }
 
 static int reg_event_syscall_exit(struct trace_event_file *file,
@@ -459,6 +698,163 @@ static void unreg_event_syscall_exit(struct trace_event_file *file,
 	mutex_unlock(&syscall_trace_lock);
 }
 
+/*
+ * For system calls that reference user space memory that can
+ * be recorded into the event, set the system call meta data's user_mask
+ * to the "args" index that points to the user space memory to retrieve.
+ */
+static void check_faultable_syscall(struct trace_event_call *call, int nr)
+{
+	struct syscall_metadata *sys_data = call->data;
+
+	/* Only work on entry */
+	if (sys_data->enter_event != call)
+		return;
+
+	switch (nr) {
+	/* user arg at position 0 */
+#ifdef __NR_access
+	case __NR_access:
+#endif
+	case __NR_acct:
+	case __NR_add_key: /* Just _type. TODO add _description */
+	case __NR_chdir:
+#ifdef  __NR_chown
+	case __NR_chown:
+#endif
+#ifdef  __NR_chmod
+	case __NR_chmod:
+#endif
+	case __NR_chroot:
+#ifdef __NR_creat
+	case __NR_creat:
+#endif
+	case __NR_delete_module:
+	case __NR_execve:
+	case __NR_fsopen:
+	case __NR_getxattr: /* Just pathname, TODO add name */
+#ifdef __NR_lchown
+	case __NR_lchown:
+#endif
+	case __NR_lgetxattr: /* Just pathname, TODO add name */
+	case __NR_lremovexattr: /* Just pathname, TODO add name */
+#ifdef __NR_link
+	case __NR_link: /* Just oldname. TODO add newname */
+#endif
+	case __NR_listxattr: /* Just pathname, TODO add list */
+	case __NR_llistxattr: /* Just pathname, TODO add list */
+	case __NR_lsetxattr: /* Just pathname, TODO add list */
+#ifdef __NR_open
+	case __NR_open:
+#endif
+	case __NR_memfd_create:
+	case __NR_mount: /* Just dev_name, TODO add dir_name and type */
+#ifdef __NR_mkdir
+	case __NR_mkdir:
+#endif
+#ifdef __NR_mknod
+	case __NR_mknod:
+#endif
+	case __NR_mq_open:
+	case __NR_mq_unlink:
+	case __NR_pivot_root: /* Just new_root, TODO add old_root */
+#ifdef __NR_readlink
+	case __NR_readlink:
+#endif
+	case __NR_removexattr: /* Just pathname, TODO add name */
+#ifdef __NR_rename
+	case __NR_rename: /* Just oldname. TODO add newname */
+#endif
+	case __NR_request_key: /* Just _type. TODO add _description */
+#ifdef  __NR_rmdir
+	case __NR_rmdir:
+#endif
+	case __NR_setxattr: /* Just pathname, TODO add list */
+	case __NR_shmdt:
+#ifdef __NR_statfs
+	case __NR_statfs:
+#endif
+	case __NR_swapon:
+	case __NR_swapoff:
+#ifdef __NR_symlink
+	case __NR_symlink: /* Just oldname. TODO add newname */
+#endif
+#ifdef __NR_truncate
+	case __NR_truncate:
+#endif
+#ifdef __NR_unlink
+	case __NR_unlink:
+#endif
+	case __NR_umount2:
+#ifdef __NR_utime
+	case __NR_utime:
+#endif
+#ifdef __NR_utimes
+	case __NR_utimes:
+#endif
+		sys_data->user_mask = BIT(0);
+		break;
+	/* user arg at position 1 */
+	case __NR_execveat:
+	case __NR_faccessat:
+	case __NR_faccessat2:
+	case __NR_finit_module:
+	case __NR_fchmodat:
+	case __NR_fchmodat2:
+	case __NR_fchownat:
+	case __NR_fgetxattr:
+	case __NR_flistxattr:
+	case __NR_fsetxattr:
+	case __NR_fspick:
+	case __NR_fremovexattr:
+#ifdef __NR_futimesat
+	case __NR_futimesat:
+#endif
+	case __NR_getxattrat: /* Just pathname, TODO add name */
+	case __NR_inotify_add_watch:
+	case __NR_linkat: /* Just oldname. TODO add newname */
+	case __NR_listxattrat: /* Just pathname, TODO add list */
+	case __NR_mkdirat:
+	case __NR_mknodat:
+	case __NR_mount_setattr:
+	case __NR_move_mount: /* Just from_pathname, TODO add to_pathname */
+	case __NR_name_to_handle_at:
+#ifdef __NR_newfstatat
+	case __NR_newfstatat:
+#endif
+	case __NR_openat:
+	case __NR_openat2:
+	case __NR_open_tree:
+	case __NR_open_tree_attr:
+	case __NR_readlinkat:
+#ifdef __NR_renameat
+	case __NR_renameat: /* Just oldname. TODO add newname */
+#endif
+	case __NR_renameat2: /* Just oldname. TODO add newname */
+	case __NR_removexattrat: /* Just pathname, TODO add name */
+	case __NR_quotactl:
+	case __NR_setxattrat: /* Just pathname, TODO add list */
+	case __NR_syslog:
+	case __NR_symlinkat: /* Just oldname. TODO add newname */
+	case __NR_statx:
+	case __NR_unlinkat:
+	case __NR_utimensat:
+		sys_data->user_mask = BIT(1);
+		break;
+	/* user arg at position 2 */
+	case __NR_init_module:
+	case __NR_fsconfig:
+		sys_data->user_mask = BIT(2);
+		break;
+	/* user arg at position 4 */
+	case __NR_fanotify_mark:
+		sys_data->user_mask = BIT(4);
+		break;
+	default:
+		sys_data->user_mask = 0;
+	}
+}
+
 static int __init init_syscall_trace(struct trace_event_call *call)
 {
 	int id;
@@ -471,6 +867,8 @@ static int __init init_syscall_trace(struct trace_event_call *call)
 		return -ENOSYS;
 	}
 
+	check_faultable_syscall(call, num);
+
 	if (set_syscall_print_fmt(call) < 0)
 		return -ENOMEM;
 
-- 
2.51.0


