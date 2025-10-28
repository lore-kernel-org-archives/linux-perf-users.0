Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE036B995;
	Tue, 28 Oct 2025 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693069; cv=none; b=hbi3eIdcuYhfP1+isuuglgBWfv1oXVFRCzlHaUu6ibdiia7w3ksCPS0MNPF63hNXIoeUdDXArGrZ2rL/Wg5mUdCVg+At2o3Wzl3KhEmdC9JVbWnrAOZkSM3zqq5soJUkl0PfHAi/8OIOniiEVvYWSuoByUFVHCq2EIPBdHVn/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693069; c=relaxed/simple;
	bh=RLJZLUQvp5+TQAFf9/GPVT3D7wyG54pV2Z69yQRZrl4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fO/IPRTzWILrcOgy8zezMCp86s4r8h1bPkoZUxGG/D9HIuCkcz7K0EhZ+8AK1EVnIoXWbFADFfpR8fIkCASSCNKZTng9BpxeJ5BbZRem0E5xIHrT0UCwbVzttVMAzWCab7pl6ZWXBGEJoelCtvC/oZWGX3IV4YboKuh1f5JeV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsvyR+Kj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsvyR+Kj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F69C19421;
	Tue, 28 Oct 2025 23:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761693069;
	bh=RLJZLUQvp5+TQAFf9/GPVT3D7wyG54pV2Z69yQRZrl4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=CsvyR+Kju9uNX3raBQzCWAZzfuz8zlfFw20a0PtwQENi0fo9oSHNCHy72e+ZUrBbi
	 zsd2NQJTK1U2Q7UEJb6YMSd+lYYGVm2ZOVqqE5i7pTA5KM3yDUSKKkuYlneQOaCzig
	 IrW+Ky12k56AH7hT5Pq4FLBbEqvMLe32IU48+W8QYBRuoHE9dIb9bHp/NhPmBYonKN
	 JG1MXeqAuFca1c1jqgBYAM4EaUwapuuaBQ01b4LSCyag4dBMJeC/GVJHjKMUmcZ9BL
	 5y2kHHUCrkx7zg2BPQGh0CRBQ1pgCjBWpPYHi55iCdjeIKvCQp/icMAp+bJgM9ocQp
	 C38XSJGN13SDQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vDsqy-00000004qs9-10ab;
	Tue, 28 Oct 2025 19:11:48 -0400
Message-ID: <20251028231148.095789277@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 28 Oct 2025 19:11:21 -0400
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
Subject: [PATCH v5 07/13] tracing: Allow syscall trace events to read more than one user
 parameter
References: <20251028231114.820213884@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Allow more than one field of a syscall trace event to read user space.
Build on top of the user_mask by allowing more than one bit to be set that
corresponds to the @args array of the syscall metadata. For each argument
in the @args array that is to be read, it will have a dynamic array/string
field associated to it.

Note that multiple fields to be read from user space is not supported if
the user_arg_size field is set in the syscall metada. That field can only
be used if only one field is being read from user space as that field is a
number representing the size field of the syscall event that holds the
size of the data to read from user space. It becomes ambiguous if the
system call reads more than one field. Currently this is not an issue.

If a syscall event happens to enable two events to read user space and
sets the user_arg_size field, it will trigger a warning at boot and the
user_arg_size field will be cleared.

The per CPU buffer that is used to read the user space addresses is now
broken up into 3 sections, each of 168 bytes. The reason for 168 is that
it is the biggest portion of 512 bytes divided by 3 that is 8 byte aligned.

The max amount copied into the ring buffer from user space is now only 128
bytes, which is plenty. When reading user space, it still reads 167
(168-1) bytes and uses the remaining to know if it should append the extra
"..." to the end or not.

This will allow the event to look like this:

  sys_renameat2(olddfd: 0xffffff9c, oldname: 0x7ffe02facdff "/tmp/x", newdfd: 0xffffff9c, newname: 0x7ffe02face06 "/tmp/y", flags: 1)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 337 +++++++++++++++++++++++-----------
 1 file changed, 229 insertions(+), 108 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index b8e9774a8abd..3eafe1b8f53e 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -138,6 +138,7 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 	struct syscall_metadata *entry;
 	int i, syscall, val, len;
 	unsigned char *ptr;
+	int offset = 0;
 
 	trace = (typeof(trace))ent;
 	syscall = trace->nr;
@@ -177,12 +178,13 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 			continue;
 
 		/* This arg points to a user space string */
-		ptr = (void *)trace->args + sizeof(long) * entry->nb_args;
+		ptr = (void *)trace->args + sizeof(long) * entry->nb_args + offset;
 		val = *(int *)ptr;
 
 		/* The value is a dynamic string (len << 16 | offset) */
 		ptr = (void *)ent + (val & 0xffff);
 		len = val >> 16;
+		offset += 4;
 
 		if (entry->user_arg_size < 0 || entry->user_arg_is_str) {
 			trace_seq_printf(s, " \"%.*s\"", len, ptr);
@@ -335,7 +337,6 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 	unsigned long mask;
 	char *arg;
 	int offset = offsetof(typeof(trace), args);
-	int idx;
 	int ret = 0;
 	int len;
 	int i;
@@ -354,31 +355,56 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 		return ret;
 
 	mask = meta->user_mask;
-	idx = ffs(mask) - 1;
 
-	/*
-	 * User space data is faulted into a temporary buffer and then
-	 * added as a dynamic string or array to the end of the event.
-	 * The user space data name for the arg pointer is "__<arg>_val".
-	 */
-	len = strlen(meta->args[idx]) + sizeof("___val");
-	arg = kmalloc(len, GFP_KERNEL);
-	if (WARN_ON_ONCE(!arg)) {
-		meta->user_mask = 0;
-		return -ENOMEM;
-	}
+	while (mask) {
+		int idx = ffs(mask) - 1;
+		mask &= ~BIT(idx);
+
+		/*
+		 * User space data is faulted into a temporary buffer and then
+		 * added as a dynamic string or array to the end of the event.
+		 * The user space data name for the arg pointer is
+		 * "__<arg>_val".
+		 */
+		len = strlen(meta->args[idx]) + sizeof("___val");
+		arg = kmalloc(len, GFP_KERNEL);
+		if (WARN_ON_ONCE(!arg)) {
+			meta->user_mask = 0;
+			return -ENOMEM;
+		}
 
-	snprintf(arg, len, "__%s_val", meta->args[idx]);
+		snprintf(arg, len, "__%s_val", meta->args[idx]);
 
-	ret = trace_define_field(call, "__data_loc char[]",
-				 arg, offset, sizeof(int), 0,
-				 FILTER_OTHER);
-	if (ret)
-		kfree(arg);
+		ret = trace_define_field(call, "__data_loc char[]",
+					 arg, offset, sizeof(int), 0,
+					 FILTER_OTHER);
+		if (ret) {
+			kfree(arg);
+			break;
+		}
+		offset += 4;
+	}
 	return ret;
 }
 
+/*
+ * Create a per CPU temporary buffer to copy user space pointers into.
+ *
+ * SYSCALL_FAULT_BUF_SZ holds the size of the per CPU buffer to use
+ * to copy memory from user space addresses into.
+ *
+ * SYSCALL_FAULT_ARG_SZ is the amount to copy from user space.
+ *
+ * SYSCALL_FAULT_USER_MAX is the amount to copy into the ring buffer.
+ *  It's slightly smaller than SYSCALL_FAULT_ARG_SZ to know if it
+ *  needs to append the EXTRA or not.
+ *
+ * This only allows up to 3 args from system calls.
+ */
 #define SYSCALL_FAULT_BUF_SZ 512
+#define SYSCALL_FAULT_ARG_SZ 168
+#define SYSCALL_FAULT_USER_MAX 128
+#define SYSCALL_FAULT_MAX_CNT 3
 
 /* Use the tracing per CPU buffer infrastructure to copy from user space */
 struct syscall_user_buffer {
@@ -438,34 +464,58 @@ static void syscall_fault_buffer_disable(void)
 	call_rcu_tasks_trace(&sbuf->rcu, rcu_free_syscall_buffer);
 }
 
+struct syscall_args {
+	char		*ptr_array[SYSCALL_FAULT_MAX_CNT];
+	int		read[SYSCALL_FAULT_MAX_CNT];
+	int		uargs;
+};
+
 static int syscall_copy_user(char *buf, const char __user *ptr,
 			     size_t size, void *data)
 {
-	unsigned long *ret_size = data;
+	struct syscall_args *args = data;
+	int ret;
+
+	for (int i = 0; i < args->uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
+		ptr = (char __user *)args->ptr_array[i];
+		ret = strncpy_from_user(buf, ptr, size);
+		args->read[i] = ret;
+	}
+	return 0;
+}
+
+static int syscall_copy_user_array(char *buf, const char __user *ptr,
+				   size_t size, void *data)
+{
+	struct syscall_args *args = data;
 	int ret;
 
-	ret = strncpy_from_user(buf, ptr, size);
-	if (ret < 0)
-		return 1;
-	*ret_size = ret;
+	for (int i = 0; i < args->uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
+		ptr = (char __user *)args->ptr_array[i];
+		ret = __copy_from_user(buf, ptr, size);
+		args->read[i] = ret ? -1 : size;
+	}
 	return 0;
 }
 
 static char *sys_fault_user(struct syscall_metadata *sys_data,
 			    struct syscall_user_buffer *sbuf,
-			    unsigned long *args, unsigned int *data_size)
+			    unsigned long *args,
+			    unsigned int data_size[SYSCALL_FAULT_MAX_CNT])
 {
 	trace_user_buf_copy syscall_copy = syscall_copy_user;
-	unsigned long size = SYSCALL_FAULT_BUF_SZ - 1;
 	unsigned long mask = sys_data->user_mask;
-	int idx = ffs(mask) - 1;
+	unsigned long size = SYSCALL_FAULT_ARG_SZ - 1;
+	struct syscall_args sargs;
 	bool array = false;
-	char *ptr;
+	char *buffer;
 	char *buf;
+	int ret;
+	int i = 0;
 
-	/* Get the pointer to user space memory to read */
-	ptr = (char *)args[idx];
-	*data_size = 0;
+	/* The extra is appended to the user data in the buffer */
+	BUILD_BUG_ON(SYSCALL_FAULT_USER_MAX + sizeof(EXTRA) >=
+		     SYSCALL_FAULT_ARG_SZ);
 
 	/*
 	 * If this system call event has a size argument, use
@@ -475,67 +525,103 @@ static char *sys_fault_user(struct syscall_metadata *sys_data,
 	if (sys_data->user_arg_size >= 0) {
 		array = true;
 		size = args[sys_data->user_arg_size];
-		if (size > SYSCALL_FAULT_BUF_SZ - 1)
-			size = SYSCALL_FAULT_BUF_SZ - 1;
-		/* use normal copy_from_user() */
-		syscall_copy = NULL;
+		if (size > SYSCALL_FAULT_ARG_SZ - 1)
+			size = SYSCALL_FAULT_ARG_SZ - 1;
+		syscall_copy = syscall_copy_user_array;
 	}
 
-	buf = trace_user_fault_read(&sbuf->buf, ptr, size,
-				    syscall_copy, &size);
-	if (!buf)
+	while (mask) {
+		int idx = ffs(mask) - 1;
+		mask &= ~BIT(idx);
+
+		if (WARN_ON_ONCE(i == SYSCALL_FAULT_MAX_CNT))
+			break;
+
+		/* Get the pointer to user space memory to read */
+		sargs.ptr_array[i++] = (char *)args[idx];
+	}
+
+	sargs.uargs = i;
+
+	/* Clear the values that are not used */
+	for (; i < SYSCALL_FAULT_MAX_CNT; i++) {
+		data_size[i] = -1; /* Denotes no pointer */
+	}
+
+	buffer = trace_user_fault_read(&sbuf->buf, NULL, size,
+				       syscall_copy, &sargs);
+	if (!buffer)
 		return NULL;
 
-	/* For strings, replace any non-printable characters with '.' */
-	if (!array) {
-		for (int i = 0; i < size; i++) {
-			if (!isprint(buf[i]))
-				buf[i] = '.';
-		}
+	buf = buffer;
+	for (i = 0; i < sargs.uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
 
-		/*
-		 * If the text was truncated due to our max limit, add "..." to
-		 * the string.
-		 */
-		if (size > SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA)) {
-			strscpy(buf + SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA),
-				EXTRA, sizeof(EXTRA));
-			size = SYSCALL_FAULT_BUF_SZ;
+		ret = sargs.read[i];
+		if (ret < 0)
+			continue;
+		buf[ret] = '\0';
+
+		/* For strings, replace any non-printable characters with '.' */
+		if (!array) {
+			for (int x = 0; x < ret; x++) {
+				if (!isprint(buf[x]))
+					buf[x] = '.';
+			}
+
+			/*
+			 * If the text was truncated due to our max limit,
+			 * add "..." to the string.
+			 */
+			if (ret > SYSCALL_FAULT_USER_MAX) {
+				strscpy(buf + SYSCALL_FAULT_USER_MAX, EXTRA,
+					sizeof(EXTRA));
+				ret = SYSCALL_FAULT_USER_MAX + sizeof(EXTRA);
+			} else {
+				buf[ret++] = '\0';
+			}
 		} else {
-			buf[size++] = '\0';
+			ret = min(ret, SYSCALL_FAULT_USER_MAX);
 		}
+		data_size[i] = ret;
 	}
 
-	*data_size = size;
-	return buf;
+	return buffer;
 }
 
 static int
 syscall_get_data(struct syscall_metadata *sys_data, unsigned long *args,
-		 char **buffer, int *size, int *user_size)
+		 char **buffer, int *size, int *user_sizes, int *uargs)
 {
 	struct syscall_user_buffer *sbuf;
+	int i;
 
 	/* If the syscall_buffer is NULL, tracing is being shutdown */
 	sbuf = READ_ONCE(syscall_buffer);
 	if (!sbuf)
 		return -1;
 
-	*buffer = sys_fault_user(sys_data, sbuf, args, user_size);
+	*buffer = sys_fault_user(sys_data, sbuf, args, user_sizes);
 	/*
 	 * user_size is the amount of data to append.
 	 * Need to add 4 for the meta field that points to
 	 * the user memory at the end of the event and also
 	 * stores its size.
 	 */
-	*size = 4 + *user_size;
+	for (i = 0; i < SYSCALL_FAULT_MAX_CNT; i++) {
+		if (user_sizes[i] < 0)
+			break;
+		*size += user_sizes[i] + 4;
+	}
+	/* Save the number of user read arguments of this syscall */
+	*uargs = i;
 	return 0;
 }
 
 static void syscall_put_data(struct syscall_metadata *sys_data,
 			     struct syscall_trace_enter *entry,
-			     char *buffer, int size, int user_size)
+			     char *buffer, int size, int *user_sizes, int uargs)
 {
+	char *buf = buffer;
 	void *ptr;
 	int val;
 
@@ -547,21 +633,30 @@ static void syscall_put_data(struct syscall_metadata *sys_data,
 
 	/*
 	 * The meta data will store the offset of the user data from
-	 * the beginning of the event.
+	 * the beginning of the event. That is after the static arguments
+	 * and the meta data fields.
 	 */
-	val  = (ptr - (void *)entry) + 4;
+	val = (ptr - (void *)entry) + 4 * uargs;
+
+	for (int i = 0; i < uargs; i++) {
 
-	/* Store the offset and the size into the meta data */
-	*(int *)ptr = val | (user_size << 16);
+		if (i)
+			val += user_sizes[i - 1];
 
-	if (WARN_ON_ONCE((ptr - (void *)entry + user_size) > size))
-		user_size = 0;
+		/* Store the offset and the size into the meta data */
+		*(int *)ptr = val | (user_sizes[i] << 16);
 
-	/* Nothing to do if the user space was empty or faulted */
-	if (user_size) {
-		/* Now store the user space data into the event */
+		/* Skip the meta data */
 		ptr += 4;
-		memcpy(ptr, buffer, user_size);
+	}
+
+	for (int i = 0; i < uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
+		/* Nothing to do if the user space was empty or faulted */
+		if (!user_sizes[i])
+			continue;
+
+		memcpy(ptr, buf, user_sizes[i]);
+		ptr += user_sizes[i];
 	}
 }
 
@@ -574,9 +669,10 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	struct trace_event_buffer fbuffer;
 	unsigned long args[6];
 	char *user_ptr;
-	int user_size = 0;
+	int user_sizes[SYSCALL_FAULT_MAX_CNT] = {};
 	int syscall_nr;
 	int size = 0;
+	int uargs = 0;
 	bool mayfault;
 
 	/*
@@ -609,7 +705,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	if (mayfault) {
 		if (syscall_get_data(sys_data, args, &user_ptr,
-				     &size, &user_size) < 0)
+				     &size, user_sizes, &uargs) < 0)
 			return;
 	}
 
@@ -625,7 +721,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	if (mayfault)
-		syscall_put_data(sys_data, entry, user_ptr, size, user_size);
+		syscall_put_data(sys_data, entry, user_ptr, size, user_sizes, uargs);
 
 	trace_event_buffer_commit(&fbuffer);
 }
@@ -767,6 +863,7 @@ static void unreg_event_syscall_exit(struct trace_event_file *file,
 static void check_faultable_syscall(struct trace_event_call *call, int nr)
 {
 	struct syscall_metadata *sys_data = call->data;
+	unsigned long mask;
 
 	/* Only work on entry */
 	if (sys_data->enter_event != call)
@@ -802,7 +899,6 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	case __NR_access:
 #endif
 	case __NR_acct:
-	case __NR_add_key: /* Just _type. TODO add _description */
 	case __NR_chdir:
 #ifdef  __NR_chown
 	case __NR_chown:
@@ -817,23 +913,13 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	case __NR_delete_module:
 	case __NR_execve:
 	case __NR_fsopen:
-	case __NR_getxattr: /* Just pathname, TODO add name */
 #ifdef __NR_lchown
 	case __NR_lchown:
 #endif
-	case __NR_lgetxattr: /* Just pathname, TODO add name */
-	case __NR_lremovexattr: /* Just pathname, TODO add name */
-#ifdef __NR_link
-	case __NR_link: /* Just oldname. TODO add newname */
-#endif
-	case __NR_listxattr: /* Just pathname, TODO add list */
-	case __NR_llistxattr: /* Just pathname, TODO add list */
-	case __NR_lsetxattr: /* Just pathname, TODO add list */
 #ifdef __NR_open
 	case __NR_open:
 #endif
 	case __NR_memfd_create:
-	case __NR_mount: /* Just dev_name, TODO add dir_name and type */
 #ifdef __NR_mkdir
 	case __NR_mkdir:
 #endif
@@ -842,28 +928,18 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 #endif
 	case __NR_mq_open:
 	case __NR_mq_unlink:
-	case __NR_pivot_root: /* Just new_root, TODO add old_root */
 #ifdef __NR_readlink
 	case __NR_readlink:
 #endif
-	case __NR_removexattr: /* Just pathname, TODO add name */
-#ifdef __NR_rename
-	case __NR_rename: /* Just oldname. TODO add newname */
-#endif
-	case __NR_request_key: /* Just _type. TODO add _description */
 #ifdef  __NR_rmdir
 	case __NR_rmdir:
 #endif
-	case __NR_setxattr: /* Just pathname, TODO add list */
 	case __NR_shmdt:
 #ifdef __NR_statfs
 	case __NR_statfs:
 #endif
 	case __NR_swapon:
 	case __NR_swapoff:
-#ifdef __NR_symlink
-	case __NR_symlink: /* Just oldname. TODO add newname */
-#endif
 #ifdef __NR_truncate
 	case __NR_truncate:
 #endif
@@ -895,14 +971,10 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 #ifdef __NR_futimesat
 	case __NR_futimesat:
 #endif
-	case __NR_getxattrat: /* Just pathname, TODO add name */
 	case __NR_inotify_add_watch:
-	case __NR_linkat: /* Just oldname. TODO add newname */
-	case __NR_listxattrat: /* Just pathname, TODO add list */
 	case __NR_mkdirat:
 	case __NR_mknodat:
 	case __NR_mount_setattr:
-	case __NR_move_mount: /* Just from_pathname, TODO add to_pathname */
 	case __NR_name_to_handle_at:
 #ifdef __NR_newfstatat
 	case __NR_newfstatat:
@@ -912,15 +984,8 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	case __NR_open_tree:
 	case __NR_open_tree_attr:
 	case __NR_readlinkat:
-#ifdef __NR_renameat
-	case __NR_renameat: /* Just oldname. TODO add newname */
-#endif
-	case __NR_renameat2: /* Just oldname. TODO add newname */
-	case __NR_removexattrat: /* Just pathname, TODO add name */
 	case __NR_quotactl:
-	case __NR_setxattrat: /* Just pathname, TODO add list */
 	case __NR_syslog:
-	case __NR_symlinkat: /* Just oldname. TODO add newname */
 	case __NR_statx:
 	case __NR_unlinkat:
 	case __NR_utimensat:
@@ -935,9 +1000,64 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	case __NR_fanotify_mark:
 		sys_data->user_mask = BIT(4);
 		break;
+	/* 2 user args, 0 and 1 */
+	case __NR_add_key:
+	case __NR_getxattr:
+	case __NR_lgetxattr:
+	case __NR_lremovexattr:
+#ifdef __NR_link
+	case __NR_link:
+#endif
+	case __NR_listxattr:
+	case __NR_llistxattr:
+	case __NR_lsetxattr:
+	case __NR_pivot_root:
+	case __NR_removexattr:
+#ifdef __NR_rename
+	case __NR_rename:
+#endif
+	case __NR_request_key:
+	case __NR_setxattr:
+#ifdef __NR_symlink
+	case __NR_symlink:
+#endif
+		sys_data->user_mask = BIT(0) | BIT(1);
+		break;
+	/* 2 user args, 0 and 2 */
+	case __NR_symlinkat:
+		sys_data->user_mask = BIT(0) | BIT(2);
+		break;
+	/* 2 user args, 1 and 3 */
+	case __NR_getxattrat:
+	case __NR_linkat:
+	case __NR_listxattrat:
+	case __NR_move_mount:
+#ifdef __NR_renameat
+	case __NR_renameat:
+#endif
+	case __NR_renameat2:
+	case __NR_removexattrat:
+	case __NR_setxattrat:
+		sys_data->user_mask = BIT(1) | BIT(3);
+		break;
+	case __NR_mount: /* Just dev_name and dir_name, TODO add type */
+		sys_data->user_mask = BIT(0) | BIT(1) | BIT(2);
+		break;
 	default:
 		sys_data->user_mask = 0;
+		return;
 	}
+
+	if (sys_data->user_arg_size < 0)
+		return;
+
+	/*
+	 * The user_arg_size can only be used when the system call
+	 * is reading only a single address from user space.
+	 */
+	mask = sys_data->user_mask;
+	if (WARN_ON(mask & (mask - 1)))
+		sys_data->user_arg_size = -1;
 }
 
 static int __init init_syscall_trace(struct trace_event_call *call)
@@ -1083,10 +1203,11 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	bool valid_prog_array;
 	bool mayfault;
 	char *user_ptr;
+	int user_sizes[SYSCALL_FAULT_MAX_CNT] = {};
 	int syscall_nr;
-	int user_size;
 	int rctx;
 	int size = 0;
+	int uargs = 0;
 
 	/*
 	 * Syscall probe called with preemption enabled, but the ring
@@ -1112,7 +1233,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 
 	if (mayfault) {
 		if (syscall_get_data(sys_data, args, &user_ptr,
-				     &size, &user_size) < 0)
+				     &size, user_sizes, &uargs) < 0)
 			return;
 	}
 
@@ -1134,7 +1255,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	memcpy(&rec->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	if (mayfault)
-		syscall_put_data(sys_data, rec, user_ptr, size, user_size);
+		syscall_put_data(sys_data, rec, user_ptr, size, user_sizes, uargs);
 
 	if ((valid_prog_array &&
 	     !perf_call_bpf_enter(sys_data->enter_event, fake_regs, sys_data, rec)) ||
-- 
2.51.0


