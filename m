Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5162236FA;
	Tue, 21 Oct 2025 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007933; cv=none; b=cRwtURJEjPovdUvGZbFkESay7QmHiKQAxE4LcCG8OCe6LCzE8s6XbAsFKaxxJgmnW3kBzFbS2/NjAA6Tn8pDronkujK+yAznQuTAF0eDBdbGAY8LIEObaxqzyzOebeIfsN5HUx4eg2KRVPcf5J1gZCUYrN0fczF4LN80JtmCSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007933; c=relaxed/simple;
	bh=P3xoUKqXucWQWvckaMxIv1PJFPMLjAY0O+OGx8M8eJ4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=muiGqU0Z+sMkoD5sFmSAX3rw3kMwRqAZGG8Dc6a5flHNaHU4SVihLdizDrE05dDBaFpKcGSo/avjZaDn8bO1V3QC9PuTNkprA5xQOCWaYkSHx/pENhMs99dGv68jnM1pazgDBFoqYPs3acaHnm/7/mBxAH5huWgu770yKBYmXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OreyW5N6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OreyW5N6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFE6C19425;
	Tue, 21 Oct 2025 00:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007932;
	bh=P3xoUKqXucWQWvckaMxIv1PJFPMLjAY0O+OGx8M8eJ4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=OreyW5N6oY4ucGKzzUqzCnJf74FYNzjgs88GhpJg9QSntg1E1fL17hw8/2XotpbPf
	 kgjiFfRrzWju5YbKI6QmGfC9mkf4xrZ/3PTCD3cpYOPgmK3uK2Knj2WNy1NfyUs4Ky
	 w8svuhzDE5IaOpMt+Ssek2Q4jQr0hTzUdrMpEjnWLCyrT5d+ktSZp0i7qaeOo4IQfh
	 c6cnMAC95PNQwCM3UWFLO7qjpZauHFfCCghw8vCpx84OSt1ENepLE65fN21f/p7QcD
	 8kWpFVrsBQpbiv4c0HEKw0l+bZfAIU10rguE9DFLstOoEUozZ/TlvTsZ932ELE1tDF
	 oAnG/HnoqYxGQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vB0c5-0000000206s-0HHo;
	Mon, 20 Oct 2025 20:52:33 -0400
Message-ID: <20251021005232.923064684@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 20 Oct 2025 20:51:59 -0400
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
Subject: [PATCH v4 04/13] perf: tracing: Have perf system calls read user space
References: <20251021005155.705735078@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Allow some of the system call events to read user space buffers. Instead
of just showing the pointer into user space, allow perf events to also
record the content of those pointers. For example:

  # perf record -e syscalls:sys_enter_openat ls /usr/bin
  [..]
  # perf script
      ls    1024 [005]    52.902721: syscalls:sys_enter_openat: dfd: 0xffffff9c, filename: 0x7fc1dbae321c "/etc/ld.so.cache", flags: 0x00080000, mode: 0x00000000
      ls    1024 [005]    52.902899: syscalls:sys_enter_openat: dfd: 0xffffff9c, filename: 0x7fc1dbaae140 "/lib/x86_64-linux-gnu/libselinux.so.1", flags: 0x00080000, mode: 0x00000000
      ls    1024 [005]    52.903471: syscalls:sys_enter_openat: dfd: 0xffffff9c, filename: 0x7fc1dbaae690 "/lib/x86_64-linux-gnu/libcap.so.2", flags: 0x00080000, mode: 0x00000000
      ls    1024 [005]    52.903946: syscalls:sys_enter_openat: dfd: 0xffffff9c, filename: 0x7fc1dbaaebe0 "/lib/x86_64-linux-gnu/libc.so.6", flags: 0x00080000, mode: 0x00000000
      ls    1024 [005]    52.904629: syscalls:sys_enter_openat: dfd: 0xffffff9c, filename: 0x7fc1dbaaf110 "/lib/x86_64-linux-gnu/libpcre2-8.so.0", flags: 0x00080000, mode: 0x00000000
      ls    1024 [005]    52.906985: syscalls:sys_enter_openat: dfd: 0xffffffffffffff9c, filename: 0x7fc1dba92904 "/proc/filesystems", flags: 0x00080000, mode: 0x00000000
      ls    1024 [005]    52.907323: syscalls:sys_enter_openat: dfd: 0xffffff9c, filename: 0x7fc1dba19490 "/usr/lib/locale/locale-archive", flags: 0x00080000, mode: 0x00000000
      ls    1024 [005]    52.907746: syscalls:sys_enter_openat: dfd: 0xffffff9c, filename: 0x556fb888dcd0 "/usr/bin", flags: 0x00090800, mode: 0x00000000

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v3: https://lore.kernel.org/20251015173548.710051410@kernel.org

- Fix use of ret in perf_sysenter_enable. (kernel test robot)

 kernel/trace/trace_syscalls.c | 136 ++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 46 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index de2b6e285fc5..bc736839c323 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -468,6 +468,58 @@ static char *sys_fault_user(struct syscall_metadata *sys_data,
 	return buf;
 }
 
+static int
+syscall_get_data(struct syscall_metadata *sys_data, unsigned long *args,
+		 char **buffer, int *size, int *user_size)
+{
+	struct syscall_user_buffer *sbuf;
+
+	/* If the syscall_buffer is NULL, tracing is being shutdown */
+	sbuf = READ_ONCE(syscall_buffer);
+	if (!sbuf)
+		return -1;
+
+	*buffer = sys_fault_user(sys_data, sbuf, args, user_size);
+	/*
+	 * user_size is the amount of data to append.
+	 * Need to add 4 for the meta field that points to
+	 * the user memory at the end of the event and also
+	 * stores its size.
+	 */
+	*size = 4 + *user_size;
+	return 0;
+}
+
+static void syscall_put_data(struct syscall_metadata *sys_data,
+			     struct syscall_trace_enter *entry,
+			     char *buffer, int size)
+{
+	void *ptr;
+	int val;
+
+	/*
+	 * Set the pointer to point to the meta data of the event
+	 * that has information about the stored user space memory.
+	 */
+	ptr = (void *)entry->args + sizeof(unsigned long) * sys_data->nb_args;
+
+	/*
+	 * The meta data will store the offset of the user data from
+	 * the beginning of the event.
+	 */
+	val  = (ptr - (void *)entry) + 4;
+
+	/* Store the offset and the size into the meta data */
+	*(int *)ptr = val | (size << 16);
+
+	/* Nothing to do if the user space was empty or faulted */
+	if (size) {
+		/* Now store the user space data into the event */
+		ptr += 4;
+		memcpy(ptr, buffer, size);
+	}
+}
+
 static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 {
 	struct trace_array *tr = data;
@@ -511,21 +563,9 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	syscall_get_arguments(current, regs, args);
 
 	if (mayfault) {
-		struct syscall_user_buffer *sbuf;
-
-		/* If the syscall_buffer is NULL, tracing is being shutdown */
-		sbuf = READ_ONCE(syscall_buffer);
-		if (!sbuf)
+		if (syscall_get_data(sys_data, args, &user_ptr,
+				     &size, &user_size) < 0)
 			return;
-
-		user_ptr = sys_fault_user(sys_data, sbuf, args, &user_size);
-		/*
-		 * user_size is the amount of data to append.
-		 * Need to add 4 for the meta field that points to
-		 * the user memory at the end of the event and also
-		 * stores its size.
-		 */
-		size = 4 + user_size;
 	}
 
 	size += sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
@@ -539,32 +579,8 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
-	if (mayfault) {
-		void *ptr;
-		int val;
-
-		/*
-		 * Set the pointer to point to the meta data of the event
-		 * that has information about the stored user space memory.
-		 */
-		ptr = (void *)entry->args + sizeof(unsigned long) * sys_data->nb_args;
-
-		/*
-		 * The meta data will store the offset of the user data from
-		 * the beginning of the event.
-		 */
-		val  = (ptr - (void *)entry) + 4;
-
-		/* Store the offset and the size into the meta data */
-		*(int *)ptr = val | (user_size << 16);
-
-		/* Nothing to do if the user space was empty or faulted */
-		if (user_size) {
-			/* Now store the user space data into the event */
-			ptr += 4;
-			memcpy(ptr, user_ptr, user_size);
-		}
-	}
+	if (mayfault)
+		syscall_put_data(sys_data, entry, user_ptr, user_size);
 
 	trace_event_buffer_commit(&fbuffer);
 }
@@ -956,9 +972,12 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	struct hlist_head *head;
 	unsigned long args[6];
 	bool valid_prog_array;
+	bool mayfault;
+	char *user_ptr;
 	int syscall_nr;
+	int user_size;
 	int rctx;
-	int size;
+	int size = 0;
 
 	/*
 	 * Syscall probe called with preemption enabled, but the ring
@@ -977,13 +996,24 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	if (!sys_data)
 		return;
 
+	syscall_get_arguments(current, regs, args);
+
+	/* Check if this syscall event faults in user space memory */
+	mayfault = sys_data->user_mask != 0;
+
+	if (mayfault) {
+		if (syscall_get_data(sys_data, args, &user_ptr,
+				     &size, &user_size) < 0)
+			return;
+	}
+
 	head = this_cpu_ptr(sys_data->enter_event->perf_events);
 	valid_prog_array = bpf_prog_array_valid(sys_data->enter_event);
 	if (!valid_prog_array && hlist_empty(head))
 		return;
 
 	/* get the size after alignment with the u32 buffer size field */
-	size = sizeof(unsigned long) * sys_data->nb_args + sizeof(*rec);
+	size += sizeof(unsigned long) * sys_data->nb_args + sizeof(*rec);
 	size = ALIGN(size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
 
@@ -992,9 +1022,11 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 		return;
 
 	rec->nr = syscall_nr;
-	syscall_get_arguments(current, regs, args);
 	memcpy(&rec->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
+	if (mayfault)
+		syscall_put_data(sys_data, rec, user_ptr, user_size);
+
 	if ((valid_prog_array &&
 	     !perf_call_bpf_enter(sys_data->enter_event, fake_regs, sys_data, rec)) ||
 	    hlist_empty(head)) {
@@ -1009,15 +1041,24 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 
 static int perf_sysenter_enable(struct trace_event_call *call)
 {
+	struct syscall_metadata *sys_data = call->data;
 	int num;
+	int ret;
 
-	num = ((struct syscall_metadata *)call->data)->syscall_nr;
+	num = sys_data->syscall_nr;
 
 	guard(mutex)(&syscall_trace_lock);
+	if (sys_data->user_mask) {
+		ret = syscall_fault_buffer_enable();
+		if (ret < 0)
+			return ret;
+	}
 	if (!sys_perf_refcount_enter) {
-		int ret = register_trace_sys_enter(perf_syscall_enter, NULL);
+		ret = register_trace_sys_enter(perf_syscall_enter, NULL);
 		if (ret) {
 			pr_info("event trace: Could not activate syscall entry trace point");
+			if (sys_data->user_mask)
+				syscall_fault_buffer_disable();
 			return ret;
 		}
 	}
@@ -1028,15 +1069,18 @@ static int perf_sysenter_enable(struct trace_event_call *call)
 
 static void perf_sysenter_disable(struct trace_event_call *call)
 {
+	struct syscall_metadata *sys_data = call->data;
 	int num;
 
-	num = ((struct syscall_metadata *)call->data)->syscall_nr;
+	num = sys_data->syscall_nr;
 
 	guard(mutex)(&syscall_trace_lock);
 	sys_perf_refcount_enter--;
 	clear_bit(num, enabled_perf_enter_syscalls);
 	if (!sys_perf_refcount_enter)
 		unregister_trace_sys_enter(perf_syscall_enter, NULL);
+	if (sys_data->user_mask)
+		syscall_fault_buffer_disable();
 }
 
 static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *regs,
-- 
2.51.0


