Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D851E7C19;
	Tue, 21 Oct 2025 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007932; cv=none; b=fIyajd63uyT65FglOewk/mRi0YRmcVfMorDwalrhfJAo7KjXyJ+APG7YULbxtSdlQ+b2VZQwNfC6wmfkJluZonSdcWPU5vr9ixQ8FThEXldLAdGuR3vt+wZRV0h5Wqu0SlDYtVZcZYHGfRPvbOX1dpJ7DSJCSfHvpPx3Fu04+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007932; c=relaxed/simple;
	bh=gpImYmddmWpDMEFMGThwcGsf1u5xb28cmOX36GHILGs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=njsMwoHbtKrIHfmmUmOFsADx7eF+f1bOcrw6gIhJk5NJNBsf7kT5JCGTl7vY2rswIgnGsp/o+8mq3qJh5FaGP0jvMCbStBQhrAXXUqAEmcY03PS8pjVuvPMOsFgCwi26vffJy6FwvQAq/ymg6dHKBZds9qrN7b+HEvoUyAOMjsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV6rEXoB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV6rEXoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4380C4CEFB;
	Tue, 21 Oct 2025 00:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007932;
	bh=gpImYmddmWpDMEFMGThwcGsf1u5xb28cmOX36GHILGs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=WV6rEXoBBczbIK/uHYFKqXIXfZqh+5RoqD+ygt0YYJjqHVTaleSye6HiIDn/cG64i
	 HoDVYonABvg0moHHf0hpj2Tg9MWugF7/5PqeS37Zg8dMb/UZeIbAaJFZgXFGGP/sPZ
	 eE3G37eeaVR5NrISFQircDDI/j+/uN7KZKon9q8+KZKHnBCsBeznuU+XeSJzFMJ6mI
	 DAOKUHJF94DzNDvv0ioPEYmMQr+osjLdDS9HqlIm2nZ/gv+b5nCYcRZChBVC8aksWq
	 TN3tLJgE+9q/yzSyL445FRCeQS7yc9MTEmNPfNhCBn7CeDOQ+3LH0huSwAgY2Jmut4
	 xf4p6gxrz6kCw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vB0c4-0000000205P-2OQ7;
	Mon, 20 Oct 2025 20:52:32 -0400
Message-ID: <20251021005232.428221068@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 20 Oct 2025 20:51:56 -0400
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
Subject: [PATCH v4 01/13] tracing: Make trace_user_fault_read() exposed to rest of tracing
References: <20251021005155.705735078@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The write to the trace_marker file is a critical section where it cannot
take locks nor allocate memory. To read from user space, it allocates a per
CPU buffer when the trace_marker file is opened, and then when the write
system call is performed, it uses the following method to read from user
space:

	preempt_disable();
	buffer = per_cpu_ptr(cpu_buffers, cpu);
	do {
		cnt = nr_context_switches_cpu();
		migrate_disable();
		preempt_enable();
		ret = copy_from_user(buffer, ptr, len);
		preempt_disable();
		migrate_enable();
	} while (!ret && cnt != nr_context_switches_cpu());
	if (!ret)
		ring_buffer_write(buffer);
	preempt_enable();

It records the number of context switches for the current CPU, enables
preemption, copies from user space, disable preemption and then checks if
the number of context switches changed. If it did not, then the buffer is
valid, otherwise the buffer may have been corrupted and the read from user
space must be tried again.

The system call trace events are now faultable and have the same
restrictions as the trace_marker write. For system calls to read the user
space buffer (for example to read the file of the openat system call), it
needs the same logic. Instead of copying the code over to the system call
trace events, make the code generic to allow the system call trace events to
use the same code. The following API is added internally to the tracing sub
system (these are only exposed within the tracing subsystem and not to be
used outside of it):

  trace_user_fault_init() - initializes a trace_user_buf_info descriptor
       that will allocate the per CPU buffers to copy from user space into.

  trace_user_fault_destroy() - used to free the allocations made by
       trace_user_fault_init().

  trace_user_fault_get() - update the ref count of the info descriptor to
       allow more than one user to use the same descriptor.

  trace_user_fault_put() - decrement the ref count.

  trace_user_fault_read() - performs the above action to read user space
      into the per CPU buffer. The preempt_disable() is expected before
      calling this function and preemption must remain disabled while the
      buffer returned is in use.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 250 ++++++++++++++++++++++++++++++++-----------
 kernel/trace/trace.h |  17 +++
 2 files changed, 205 insertions(+), 62 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d1e527cf2aae..50832411c5c0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7223,52 +7223,43 @@ struct trace_user_buf {
 	char		*buf;
 };
 
-struct trace_user_buf_info {
-	struct trace_user_buf __percpu	*tbuf;
-	int				ref;
-};
-
-
 static DEFINE_MUTEX(trace_user_buffer_mutex);
 static struct trace_user_buf_info *trace_user_buffer;
 
-static void trace_user_fault_buffer_free(struct trace_user_buf_info *tinfo)
+/**
+ * trace_user_fault_destroy - free up allocated memory of a trace user buffer
+ * @tinfo: The descriptor to free up
+ *
+ * Frees any data allocated in the trace info dsecriptor.
+ */
+void trace_user_fault_destroy(struct trace_user_buf_info *tinfo)
 {
 	char *buf;
 	int cpu;
 
+	if (!tinfo || !tinfo->tbuf)
+		return;
+
 	for_each_possible_cpu(cpu) {
 		buf = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
 		kfree(buf);
 	}
 	free_percpu(tinfo->tbuf);
-	kfree(tinfo);
 }
 
-static int trace_user_fault_buffer_enable(void)
+static int user_fault_buffer_enable(struct trace_user_buf_info *tinfo, size_t size)
 {
-	struct trace_user_buf_info *tinfo;
 	char *buf;
 	int cpu;
 
-	guard(mutex)(&trace_user_buffer_mutex);
-
-	if (trace_user_buffer) {
-		trace_user_buffer->ref++;
-		return 0;
-	}
-
-	tinfo = kmalloc(sizeof(*tinfo), GFP_KERNEL);
-	if (!tinfo)
-		return -ENOMEM;
+	lockdep_assert_held(&trace_user_buffer_mutex);
 
 	tinfo->tbuf = alloc_percpu(struct trace_user_buf);
-	if (!tinfo->tbuf) {
-		kfree(tinfo);
+	if (!tinfo->tbuf)
 		return -ENOMEM;
-	}
 
 	tinfo->ref = 1;
+	tinfo->size = size;
 
 	/* Clear each buffer in case of error */
 	for_each_possible_cpu(cpu) {
@@ -7276,42 +7267,165 @@ static int trace_user_fault_buffer_enable(void)
 	}
 
 	for_each_possible_cpu(cpu) {
-		buf = kmalloc_node(TRACE_MARKER_MAX_SIZE, GFP_KERNEL,
+		buf = kmalloc_node(size, GFP_KERNEL,
 				   cpu_to_node(cpu));
-		if (!buf) {
-			trace_user_fault_buffer_free(tinfo);
+		if (!buf)
 			return -ENOMEM;
-		}
 		per_cpu_ptr(tinfo->tbuf, cpu)->buf = buf;
 	}
 
-	trace_user_buffer = tinfo;
-
 	return 0;
 }
 
-static void trace_user_fault_buffer_disable(void)
+/* For internal use. Free and reinitialize */
+static void user_buffer_free(struct trace_user_buf_info **tinfo)
 {
-	struct trace_user_buf_info *tinfo;
+	lockdep_assert_held(&trace_user_buffer_mutex);
 
-	guard(mutex)(&trace_user_buffer_mutex);
+	trace_user_fault_destroy(*tinfo);
+	kfree(*tinfo);
+	*tinfo = NULL;
+}
+
+/* For internal use. Initialize and allocate */
+static int user_buffer_init(struct trace_user_buf_info **tinfo, size_t size)
+{
+	bool alloc = false;
+	int ret;
+
+	lockdep_assert_held(&trace_user_buffer_mutex);
+
+	if (!*tinfo) {
+		alloc = true;
+		*tinfo = kzalloc(sizeof(**tinfo), GFP_KERNEL);
+		if (!*tinfo)
+			return -ENOMEM;
+	}
 
-	tinfo = trace_user_buffer;
+	ret = user_fault_buffer_enable(*tinfo, size);
+	if (ret < 0 && alloc)
+		user_buffer_free(tinfo);
 
-	if (WARN_ON_ONCE(!tinfo))
+	return ret;
+}
+
+/* For internal use, derefrence and free if necessary */
+static void user_buffer_put(struct trace_user_buf_info **tinfo)
+{
+	guard(mutex)(&trace_user_buffer_mutex);
+
+	if (WARN_ON_ONCE(!*tinfo || !(*tinfo)->ref))
 		return;
 
-	if (--tinfo->ref)
+	if (--(*tinfo)->ref)
 		return;
 
-	trace_user_fault_buffer_free(tinfo);
-	trace_user_buffer = NULL;
+	user_buffer_free(tinfo);
 }
 
-/* Must be called with preemption disabled */
-static char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
-				   const char __user *ptr, size_t size,
-				   size_t *read_size)
+/**
+ * trace_user_fault_init - Allocated or reference a per CPU buffer
+ * @tinfo: A pointer to the trace buffer descriptor
+ * @size: The size to allocate each per CPU buffer
+ *
+ * Create a per CPU buffer that can be used to copy from user space
+ * in a task context. When calling trace_user_fault_read(), preemption
+ * must be disabled, and it will enable preemption and copy user
+ * space data to the buffer. If any schedule switches occur, it will
+ * retry until it succeeds without a schedule switch knowing the buffer
+ * is still valid.
+ *
+ * Returns 0 on success, negative on failure.
+ */
+int trace_user_fault_init(struct trace_user_buf_info *tinfo, size_t size)
+{
+	int ret;
+
+	if (!tinfo)
+		return -EINVAL;
+
+	guard(mutex)(&trace_user_buffer_mutex);
+
+	ret = user_buffer_init(&tinfo, size);
+	if (ret < 0)
+		trace_user_fault_destroy(tinfo);
+
+	return ret;
+}
+
+/**
+ * trace_user_fault_get - up the ref count for the user buffer
+ * @tinfo: A pointer to a pointer to the trace buffer descriptor
+ *
+ * Ups the ref count of the trace buffer.
+ *
+ * Returns the new ref count.
+ */
+int trace_user_fault_get(struct trace_user_buf_info *tinfo)
+{
+	if (!tinfo)
+		return -1;
+
+	guard(mutex)(&trace_user_buffer_mutex);
+
+	tinfo->ref++;
+	return tinfo->ref;
+}
+
+/**
+ * trace_user_fault_put - dereference a per cpu trace buffer
+ * @tinfo: The @tinfo that was passed to trace_user_fault_get()
+ *
+ * Decrement the ref count of @tinfo.
+ *
+ * Returns the new refcount (negative on error).
+ */
+int trace_user_fault_put(struct trace_user_buf_info *tinfo)
+{
+	guard(mutex)(&trace_user_buffer_mutex);
+
+	if (WARN_ON_ONCE(!tinfo || !tinfo->ref))
+		return -1;
+
+	--tinfo->ref;
+	return tinfo->ref;
+}
+
+/**
+ * trace_user_fault_read - Read user space into a per CPU buffer
+ * @tinfo: The @tinfo allocated by trace_user_fault_get()
+ * @ptr: The user space pointer to read
+ * @size: The size of user space to read.
+ * @copy_func: Optional function to use to copy from user space
+ * @data: Data to pass to copy_func if it was supplied
+ *
+ * Preemption must be disabled when this is called, and must not
+ * be enabled while using the returned buffer.
+ * This does the copying from user space into a per CPU buffer.
+ *
+ * The @size must not be greater than the size passed in to
+ * trace_user_fault_init().
+ *
+ * If @copy_func is NULL, trace_user_fault_read() will use copy_from_user(),
+ * otherwise it will call @copy_func. It will call @copy_func with:
+ *
+ *   buffer: the per CPU buffer of the @tinfo.
+ *   ptr: The pointer @ptr to user space to read
+ *   size: The @size of the ptr to read
+ *   data: The @data parameter
+ *
+ * It is expected that @copy_func will return 0 on success and non zero
+ * if there was a fault.
+ *
+ * Returns a pointer to the buffer with the content read from @ptr.
+ *   Preemption must remain disabled while the caller accesses the
+ *   buffer returned by this function.
+ * Returns NULL if there was a fault, or the size passed in is
+ *   greater than the size passed to trace_user_fault_init().
+ */
+char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
+			     const char __user *ptr, size_t size,
+			     trace_user_buf_copy copy_func, void *data)
 {
 	int cpu = smp_processor_id();
 	char *buffer = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
@@ -7319,9 +7433,14 @@ static char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 	int trys = 0;
 	int ret;
 
-	if (size > TRACE_MARKER_MAX_SIZE)
-		size = TRACE_MARKER_MAX_SIZE;
-	*read_size = 0;
+	lockdep_assert_preemption_disabled();
+
+	/*
+	 * It's up to the caller to not try to copy more than it said
+	 * it would.
+	 */
+	if (size > tinfo->size)
+		return NULL;
 
 	/*
 	 * This acts similar to a seqcount. The per CPU context switches are
@@ -7361,7 +7480,14 @@ static char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 		 */
 		preempt_enable_notrace();
 
-		ret = __copy_from_user(buffer, ptr, size);
+		/* Make sure preemption is enabled here */
+		lockdep_assert_preemption_enabled();
+
+		if (copy_func) {
+			ret = copy_func(buffer, ptr, size, data);
+		} else {
+			ret = __copy_from_user(buffer, ptr, size);
+		}
 
 		preempt_disable_notrace();
 		migrate_enable();
@@ -7378,7 +7504,6 @@ static char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 		 */
 	} while (nr_context_switches_cpu(cpu) != cnt);
 
-	*read_size = size;
 	return buffer;
 }
 
@@ -7389,7 +7514,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	struct trace_array *tr = filp->private_data;
 	ssize_t written = -ENODEV;
 	unsigned long ip;
-	size_t size;
 	char *buf;
 
 	if (tracing_disabled)
@@ -7407,13 +7531,10 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	/* Must have preemption disabled while having access to the buffer */
 	guard(preempt_notrace)();
 
-	buf = trace_user_fault_read(trace_user_buffer, ubuf, cnt, &size);
+	buf = trace_user_fault_read(trace_user_buffer, ubuf, cnt, NULL, NULL);
 	if (!buf)
 		return -EFAULT;
 
-	if (cnt > size)
-		cnt = size;
-
 	/* The selftests expect this function to be the IP address */
 	ip = _THIS_IP_;
 
@@ -7473,7 +7594,6 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	ssize_t written = -ENODEV;
-	size_t size;
 	char *buf;
 
 	if (tracing_disabled)
@@ -7486,17 +7606,17 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	if (cnt < sizeof(unsigned int))
 		return -EINVAL;
 
+	/* raw write is all or nothing */
+	if (cnt > TRACE_MARKER_MAX_SIZE)
+		return -EINVAL;
+
 	/* Must have preemption disabled while having access to the buffer */
 	guard(preempt_notrace)();
 
-	buf = trace_user_fault_read(trace_user_buffer, ubuf, cnt, &size);
+	buf = trace_user_fault_read(trace_user_buffer, ubuf, cnt, NULL, NULL);
 	if (!buf)
 		return -EFAULT;
 
-	/* raw write is all or nothing */
-	if (cnt > size)
-		return -EINVAL;
-
 	/* The global trace_marker_raw can go to multiple instances */
 	if (tr == &global_trace) {
 		guard(rcu)();
@@ -7516,20 +7636,26 @@ static int tracing_mark_open(struct inode *inode, struct file *filp)
 {
 	int ret;
 
-	ret = trace_user_fault_buffer_enable();
-	if (ret < 0)
-		return ret;
+	scoped_guard(mutex, &trace_user_buffer_mutex) {
+		if (!trace_user_buffer) {
+			ret = user_buffer_init(&trace_user_buffer, TRACE_MARKER_MAX_SIZE);
+			if (ret < 0)
+				return ret;
+		} else {
+			trace_user_buffer->ref++;
+		}
+	}
 
 	stream_open(inode, filp);
 	ret = tracing_open_generic_tr(inode, filp);
 	if (ret < 0)
-		trace_user_fault_buffer_disable();
+		user_buffer_put(&trace_user_buffer);
 	return ret;
 }
 
 static int tracing_mark_release(struct inode *inode, struct file *file)
 {
-	trace_user_fault_buffer_disable();
+	user_buffer_put(&trace_user_buffer);
 	return tracing_release_generic_tr(inode, file);
 }
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 85eabb454bee..8439fe3058cc 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1531,6 +1531,23 @@ void trace_buffered_event_enable(void);
 
 void early_enable_events(struct trace_array *tr, char *buf, bool disable_first);
 
+struct trace_user_buf;
+struct trace_user_buf_info {
+	struct trace_user_buf __percpu	*tbuf;
+	size_t				size;
+	int				ref;
+};
+
+typedef int (*trace_user_buf_copy)(char *dst, const char __user *src,
+				  size_t size, void *data);
+int trace_user_fault_init(struct trace_user_buf_info *tinfo, size_t size);
+int trace_user_fault_get(struct trace_user_buf_info *tinfo);
+int trace_user_fault_put(struct trace_user_buf_info *tinfo);
+void trace_user_fault_destroy(struct trace_user_buf_info *tinfo);
+char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
+			    const char __user *ptr, size_t size,
+			    trace_user_buf_copy copy_func, void *data);
+
 static inline void
 __trace_event_discard_commit(struct trace_buffer *buffer,
 			     struct ring_buffer_event *event)
-- 
2.51.0


