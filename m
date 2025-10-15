Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D92FF16D;
	Wed, 15 Oct 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549740; cv=none; b=fDJnCTyzGCD7tT38F6bJutysA2G8xqycQzbrKoVPSaVEf5TKcpG7c8OPhakFkrYnHhKX5fCGH7PXwWIPpPKZgdaQUaS+ZXgWgqIjXpUbmU5MsYX/RiGXDEsGaCZiHcCeOTAtUKT+aoTtJQ888uZZD0R132hhABD0BhFM4zeoMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549740; c=relaxed/simple;
	bh=IYvN9tMRf8wgduo43yMF9qHBcJoYC66DWt4c7ctc9UE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kHBhZhUfM1mo7D780/+SHG4jtyCsYwvHRXD1Jlm7mWDpu1VsK+wh50lRCGEzHlgWheFL/VOX2QfcolzveCpzdYRGprBhQYRB+6vD7+Lx/reRcKdTRIPLK3rKzFfyBkBoEB2GQloxsTXvHJYAYzD3pwGjR5rjjitngcUUbTF/YyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFYWgRzG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFYWgRzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA3FC116C6;
	Wed, 15 Oct 2025 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760549740;
	bh=IYvN9tMRf8wgduo43yMF9qHBcJoYC66DWt4c7ctc9UE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=sFYWgRzG6NEyzCOiKrrqiWi0zkabBai5MROUzN3lo2FUJn5jmXNi67F0itplKh+WB
	 oIuFVUKouqkB/CnIaZm/xNtvP2KM7QT87EFLjshPo767O9wlUu+N8pwZssYDtulfcx
	 UuLi4yTqChxLB5BSJuSDHOuSOG1byfU4EitcT01qv933iwRIxWkan7Ue5LO04exF1d
	 ZXXOj0dr0nGQFULwOS+yATasdkWweH2B8tLvZB4gFdhU3lCgN/Woe0jAAIyVyTN724
	 58D16GWG7cD8aFgvIvkMrZjnrBeO+TrOrufswdBzyc+j/ajkA/BbCJqeNkPU0cIk2U
	 KMvac5VvVA8jg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v95Ph-000000011xR-06JB;
	Wed, 15 Oct 2025 13:35:49 -0400
Message-ID: <20251015173548.877256395@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 15 Oct 2025 13:32:19 -0400
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
Subject: [PATCH v3 05/13] tracing: Have system call events record user array data
References: <20251015173214.760495866@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

For system call events that have a length field, add a "user_arg_size"
parameter to the system call meta data that denotes the index of the args
array that holds the size of arg that the user_mask field has a bit set
for.

The "user_mask" has a bit set that denotes the arg that points to an array
in the user space address space and if a system call event has the
user_mask field set and the user_arg_size set, it will then record the
content of that address into the trace event, up to the size defined by
SYSCALL_FAULT_BUF_SZ - 1.

This allows the output to look like:

  sys_write(fd: 0xa, buf: 0x5646978d13c0 (01:00:05:00:00:00:00:00:01:87:55:89:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00), count: 0x20)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/syscall.h       |   4 +-
 kernel/trace/trace_syscalls.c | 121 ++++++++++++++++++++++++----------
 2 files changed, 90 insertions(+), 35 deletions(-)

diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index 85f21ca15a41..9413c139da66 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -16,6 +16,7 @@
  * @name: name of the syscall
  * @syscall_nr: number of the syscall
  * @nb_args: number of parameters it takes
+ * @user_arg_size: holds @arg that has size of the user space to read
  * @user_mask: mask of @args that will read user space
  * @types: list of types as strings
  * @args: list of args as strings (args[i] matches types[i])
@@ -26,7 +27,8 @@
 struct syscall_metadata {
 	const char	*name;
 	int		syscall_nr;
-	short		nb_args;
+	u8		nb_args;
+	s8		user_arg_size;
 	short		user_mask;
 	const char	**types;
 	const char	**args;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index c1dfc3208a12..8da2a1d38042 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -124,7 +124,7 @@ const char *get_syscall_name(int syscall)
 	return entry->name;
 }
 
-/* Added to user strings when max limit is reached */
+/* Added to user strings or arrays when max limit is reached */
 #define EXTRA "..."
 
 static enum print_line_t
@@ -136,9 +136,8 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 	struct trace_entry *ent = iter->ent;
 	struct syscall_trace_enter *trace;
 	struct syscall_metadata *entry;
-	int i, syscall, val;
+	int i, syscall, val, len;
 	unsigned char *ptr;
-	int len;
 
 	trace = (typeof(trace))ent;
 	syscall = trace->nr;
@@ -185,7 +184,23 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 		ptr = (void *)ent + (val & 0xffff);
 		len = val >> 16;
 
-		trace_seq_printf(s, " \"%.*s\"", len, ptr);
+		if (entry->user_arg_size < 0) {
+			trace_seq_printf(s, " \"%.*s\"", len, ptr);
+			continue;
+		}
+
+		val = trace->args[entry->user_arg_size];
+
+		trace_seq_puts(s, " (");
+		for (int x = 0; x < len; x++, ptr++) {
+			if (x)
+				trace_seq_putc(s, ':');
+			trace_seq_printf(s, "%02x", *ptr);
+		}
+		if (len < val)
+			trace_seq_printf(s, ", %s", EXTRA);
+
+		trace_seq_putc(s, ')');
 	}
 
 	trace_seq_putc(s, ')');
@@ -250,8 +265,11 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 		if (!(BIT(i) & entry->user_mask))
 			continue;
 
-		/* Add the format for the user space string */
-		pos += snprintf(buf + pos, LEN_OR_ZERO, " \\\"%%s\\\"");
+		/* Add the format for the user space string or array */
+		if (entry->user_arg_size < 0)
+			pos += snprintf(buf + pos, LEN_OR_ZERO, " \\\"%%s\\\"");
+		else
+			pos += snprintf(buf + pos, LEN_OR_ZERO, " (%%s)");
 	}
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 
@@ -260,9 +278,14 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 				", ((unsigned long)(REC->%s))", entry->args[i]);
 		if (!(BIT(i) & entry->user_mask))
 			continue;
-		/* The user space string for arg has name __<arg>_val */
-		pos += snprintf(buf + pos, LEN_OR_ZERO, ", __get_str(__%s_val)",
-				entry->args[i]);
+		/* The user space data for arg has name __<arg>_val */
+		if (entry->user_arg_size < 0) {
+			pos += snprintf(buf + pos, LEN_OR_ZERO, ", __get_str(__%s_val)",
+					entry->args[i]);
+		} else {
+			pos += snprintf(buf + pos, LEN_OR_ZERO, ", __print_dynamic_array(__%s_val, 1)",
+					entry->args[i]);
+		}
 	}
 
 #undef LEN_OR_ZERO
@@ -333,9 +356,9 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 	idx = ffs(mask) - 1;
 
 	/*
-	 * User space strings are faulted into a temporary buffer and then
-	 * added as a dynamic string to the end of the event.
-	 * The user space string name for the arg pointer is "__<arg>_val".
+	 * User space data is faulted into a temporary buffer and then
+	 * added as a dynamic string or array to the end of the event.
+	 * The user space data name for the arg pointer is "__<arg>_val".
 	 */
 	len = strlen(meta->args[idx]) + sizeof("___val");
 	arg = kmalloc(len, GFP_KERNEL);
@@ -431,9 +454,11 @@ static char *sys_fault_user(struct syscall_metadata *sys_data,
 			    struct syscall_user_buffer *sbuf,
 			    unsigned long *args, unsigned int *data_size)
 {
+	trace_user_buf_copy syscall_copy = syscall_copy_user;
 	unsigned long size = SYSCALL_FAULT_BUF_SZ - 1;
 	unsigned long mask = sys_data->user_mask;
 	int idx = ffs(mask) - 1;
+	bool array = false;
 	char *ptr;
 	char *buf;
 
@@ -441,27 +466,43 @@ static char *sys_fault_user(struct syscall_metadata *sys_data,
 	ptr = (char *)args[idx];
 	*data_size = 0;
 
+	/*
+	 * If this system call event has a size argument, use
+	 * it to define how much of user space memory to read,
+	 * and read it as an array and not a string.
+	 */
+	if (sys_data->user_arg_size >= 0) {
+		array = true;
+		size = args[sys_data->user_arg_size];
+		if (size > SYSCALL_FAULT_BUF_SZ - 1)
+			size = SYSCALL_FAULT_BUF_SZ - 1;
+		/* use normal copy_from_user() */
+		syscall_copy = NULL;
+	}
+
 	buf = trace_user_fault_read(&sbuf->buf, ptr, size,
-				    syscall_copy_user, &size);
+				    syscall_copy, &size);
 	if (!buf)
 		return NULL;
 
-	/* Replace any non-printable characters with '.' */
-	for (int i = 0; i < size; i++) {
-		if (!isprint(buf[i]))
-			buf[i] = '.';
-	}
+	/* For strings, replace any non-printable characters with '.' */
+	if (!array) {
+		for (int i = 0; i < size; i++) {
+			if (!isprint(buf[i]))
+				buf[i] = '.';
+		}
 
-	/*
-	 * If the text was truncated due to our max limit, add "..." to
-	 * the string.
-	 */
-	if (size > SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA)) {
-		strscpy(buf + SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA),
-			EXTRA, sizeof(EXTRA));
-		size = SYSCALL_FAULT_BUF_SZ;
-	} else {
-		buf[size++] = '\0';
+		/*
+		 * If the text was truncated due to our max limit, add "..." to
+		 * the string.
+		 */
+		if (size > SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA)) {
+			strscpy(buf + SYSCALL_FAULT_BUF_SZ - sizeof(EXTRA),
+				EXTRA, sizeof(EXTRA));
+			size = SYSCALL_FAULT_BUF_SZ;
+		} else {
+			buf[size++] = '\0';
+		}
 	}
 
 	*data_size = size;
@@ -492,7 +533,7 @@ syscall_get_data(struct syscall_metadata *sys_data, unsigned long *args,
 
 static void syscall_put_data(struct syscall_metadata *sys_data,
 			     struct syscall_trace_enter *entry,
-			     char *buffer, int size)
+			     char *buffer, int size, int user_size)
 {
 	void *ptr;
 	int val;
@@ -510,13 +551,16 @@ static void syscall_put_data(struct syscall_metadata *sys_data,
 	val  = (ptr - (void *)entry) + 4;
 
 	/* Store the offset and the size into the meta data */
-	*(int *)ptr = val | (size << 16);
+	*(int *)ptr = val | (user_size << 16);
+
+	if (WARN_ON_ONCE((ptr - (void *)entry + user_size) > size))
+		user_size = 0;
 
 	/* Nothing to do if the user space was empty or faulted */
-	if (size) {
+	if (user_size) {
 		/* Now store the user space data into the event */
 		ptr += 4;
-		memcpy(ptr, buffer, size);
+		memcpy(ptr, buffer, user_size);
 	}
 }
 
@@ -580,7 +624,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	if (mayfault)
-		syscall_put_data(sys_data, entry, user_ptr, user_size);
+		syscall_put_data(sys_data, entry, user_ptr, size, user_size);
 
 	trace_event_buffer_commit(&fbuffer);
 }
@@ -727,7 +771,16 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	if (sys_data->enter_event != call)
 		return;
 
+	sys_data->user_arg_size = -1;
+
 	switch (nr) {
+	/* user arg 1 with size arg at 2 */
+	case __NR_write:
+	case __NR_mq_timedsend:
+	case __NR_pwrite64:
+		sys_data->user_mask = BIT(1);
+		sys_data->user_arg_size = 2;
+		break;
 	/* user arg at position 0 */
 	case __NR_access:
 	case __NR_acct:
@@ -1025,7 +1078,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	memcpy(&rec->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	if (mayfault)
-		syscall_put_data(sys_data, rec, user_ptr, user_size);
+		syscall_put_data(sys_data, rec, user_ptr, size, user_size);
 
 	if ((valid_prog_array &&
 	     !perf_call_bpf_enter(sys_data->enter_event, fake_regs, sys_data, rec)) ||
-- 
2.51.0


