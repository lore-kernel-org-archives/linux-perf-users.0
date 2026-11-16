Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810029;
	b=JDFG17tm5InD1NJXrwMQbnXKfJi1en6kNYRq7tNQFAcr/sm/xyaumayjGih5lqYnijcX
	 5DN9mwlzYh1Dm/d/1T18bcGV1xP+6PEPepts6IS195ngZKCkYcduybLrGtDWg5oYWsoe1
	 r25zQ4yJHBgm+ukYxvqA8W1/jmwZgHhMX9mHKdrCetAfY0v2eVDHpela0aZidtGWt2AN0
	 9z9ac412B1+Og5C5SaUyukDWWNLPnvKURr9odTqgZLFRqROoFmas4SQwlSx0o9CkDyf3h
	 rONWasJhey8EzKCLEayY+DK/tzsx/BDh0sKasOk/76829RhQXK4lg1a6K1CDalQmICg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810029;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NpBJPnfXG9wk02UFI4+Xt2ZnsLfLAt9L52hAXt1auZo=;
	b=JOm8aqqQO9ofGTSieO9qFnzr3JQG6PLEkaRgcwiuUMvkk6Lnu1qRoXTq1vlK6auRkMv3
	 aYwMVBWUcEJqq98U0UAFFcV1Im6UzkjLunIfl4zXFLANwFYYGUIPQuyTsiUAzUoHcjcEg
	 nOl9n3wtDfvQgo/yWyD0NwiizblsFtlt5p5MrOgBUWo9dOwSIVZwDh3yJ1D7Sk5IAMF38
	 tdeEja5Vj8ezbAl7JeqstfUkbPRnEwde3X6UuEGlV3E8C06hpI1FAv7EK6szt3hsWc+Wp
	 YPfMFCZfIQKULF9T4sHJosltDT0z9iEf1/1KQ+ZkzvKDXuJP6DUgknD3gdPHj0qWcOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUwFFZ0Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C2606A336;
	Mon, 16 Nov 2026 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUwFFZ0Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A7B1F000C5;
	Mon, 16 Nov 2026 06:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794810028;
	bh=NpBJPnfXG9wk02UFI4+Xt2ZnsLfLAt9L52hAXt1auZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YUwFFZ0Y8M/EQguY+k+h+DcuCgF5LKaukqdHjXvnvYBorg1pGPRTdNDaeIK37d4RB
	 WNQJ7Gl8p+azlP/lQE465UF5JOEprC5Bxwc4ZCY4CA/LZOhQsOxnq2g8azn3VZ4PDE
	 iRypm9xmWZqX3xhpn5V2RRB7nvUA8EIAKSTJJiw/1jVspUhB6evVwDv+ZqmVk/Absr
	 nfbTJt3AXV/HUUtk8ORdP7YTnmflCjTpb1iFMc6fUgciPsQhBARBIV9Hn38tOM9g7J
	 YU8uPL4UemPrc9/0i55WnSYFmDmqzKj80aabmeUaj/V8BE/YF2OuXZTasSr9HyQkb9
	 x1ZdfkKbWpsMA==
Message-ID: <sashiko-outbox-216266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 08/11] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179480684514.38065.14028970872476288842.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
 <179480684514.38065.14028970872476288842.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:20:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [Medium] tracing/wprobe: stale work_pending after cancel_work_sync()
  wedges triggers
- [Medium] tracing/wprobe: race and UAF on bp_event in
  wprobe_trigger_free() teardown
- [Medium] tracing/wprobe: broken trace_probe_is_enabled() check in
  trigger parse
- [Medium] tracing/wprobe: TASK_SIZE in trace_wprobe_is_valid_addr()
  allows user addr
- [Medium] tracing/wprobe: unrestored tw->addr after set_wprobe breaks
  show and match
- [Medium] tracing/wprobe: stale breakpoint hits fire triggers in
  wprobe_trace_handler()
- [Medium] tracing/wprobe: self-deadlock on tw->lock in wprobe_trigger()
- [Low] tracing/wprobe: in-place NUL mutation of glob truncates trigger
  error_log
- [Low] tracing/wprobe: unlocked double read of tw->addr in
  trace_wprobe_show()
--

commit 86f0de972cafa3458ae22f00d7d3014fc1fc6164
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Add set_wprobe and clear_wprobe event triggers

This commit adds set_wprobe and clear_wprobe event triggers to dynamically
configure and clear hardware watchpoint addresses from trace event fields.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index 644183cf5155e..d2b41aa69cfdf 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c

[ ... ]

> @@ -217,28 +241,143 @@ static int __register_trace_wprobe(struct trace_wp=
robe *tw)
>  	attr.bp_len =3D tw->len;
>  	attr.bp_type =3D tw->type;
> =20
> -	tw->bp_event =3D register_wide_hw_breakpoint(&attr, wprobe_perf_handler=
, tw);
> +	cpus_read_lock();
> +	tw->bp_event =3D register_wide_hw_breakpoint_cpuslocked(&attr,
> +							      wprobe_perf_handler,
> +							      tw);
>  	if (IS_ERR_PCPU(tw->bp_event)) {
>  		int ret =3D PTR_ERR_PCPU(tw->bp_event);
> =20
>  		tw->bp_event =3D NULL;
> +		cpus_read_unlock();
>  		return ret;
>  	}
> =20
> +	mutex_lock(&wprobe_mutex);
> +	list_add(&tw->active_list, &active_wprobes);
> +	mutex_unlock(&wprobe_mutex);
> +	cpus_read_unlock();
> +
>  	return 0;
>  }
> =20
>  static void __unregister_trace_wprobe(struct trace_wprobe *tw)
>  {
>  	if (tw->bp_event) {
> +		mutex_lock(&wprobe_mutex);
> +		list_del_init(&tw->active_list);
> +		mutex_unlock(&wprobe_mutex);
> +
> +		irq_work_sync(&tw->irq_work);
> +		cancel_work_sync(&tw->work);
>  		unregister_wide_hw_breakpoint(tw->bp_event);
>  		tw->bp_event =3D NULL;
>  	}
>  }

[Severity: Medium]
Does cancelling tw->work in __unregister_trace_wprobe() leave
tw->work_pending stuck at 1?

wprobe_trigger() sets tw->work_pending to 1 before queueing tw->irq_work,
and only wprobe_work_func() resets it to 0.  If __unregister_trace_wprobe()
runs after wprobe_irq_work_func() schedules tw->work but before
wprobe_work_func() executes, cancel_work_sync(&tw->work) cancels the work
item without clearing tw->work_pending.  Every later trigger evaluation on
that wprobe then sees atomic_read(&tw->work_pending) !=3D 0 in
__wprobe_count_func(), increments tw->missed, and drops all future updates.

[ ... ]

> @@ -788,6 +945,10 @@ static int trace_wprobe_show(struct seq_file *m, str=
uct dyn_event *ev)
>  				   tw->offset, len);
>  		else
>  			seq_printf(m, " %s@%s:%d", type_str, tw->symbol, len);
> +#ifdef CONFIG_WPROBE_TRIGGERS
> +	} else if (tw->addr =3D=3D WPROBE_DEFAULT_CLEAR_ADDRESS) {\
> +		seq_printf(m, " %s@-1:%d", type_str, len);
> +#endif
>  	} else {
>  		seq_printf(m, " %s@0x%lx:%d", type_str, tw->addr, len);
>  	}

[Severity: Low]
Can trace_wprobe_show() print the raw address of
wprobe_trigger_clear_target instead of -1?

wprobe_trigger() updates tw->addr concurrently under tw->lock without
holding dyn_event_ops_mutex.  Because trace_wprobe_show() reads tw->addr a
second time in the else branch instead of reading it once with READ_ONCE()
into a local variable, a concurrent clear_wprobe trigger setting tw->addr
to WPROBE_DEFAULT_CLEAR_ADDRESS between the comparison and seq_printf()
causes dynamic_events to print the address of wprobe_trigger_clear_target.

> @@ -800,9 +961,635 @@ static int trace_wprobe_show(struct seq_file *m, st=
ruct dyn_event *ev)

[ ... ]

> +static bool __wprobe_count_func(struct event_trigger_data *data,
> +				unsigned long addr)
> +{
> +	struct wprobe_trigger_data *wprobe_data =3D data->private_data;
> +	struct trace_wprobe *tw =3D wprobe_data->tw;
> +	unsigned long cur_addr;
> +
> +	if (atomic_read(&tw->work_pending))
> +		return false;
> +
> +	cur_addr =3D READ_ONCE(tw->addr);
> +
> +	if (!wprobe_data->clear) {
> +		if (cur_addr !=3D WPROBE_DEFAULT_CLEAR_ADDRESS)
> +			return false;
> +		if (!trace_wprobe_is_valid_addr(addr, tw->len))
> +			return false;

[Severity: Medium]
Can trace_wprobe_is_valid_addr() allow a set_wprobe trigger to install a
user-space watchpoint address when a 32-bit compat task is running?

kernel/trace/trace_wprobe.c:trace_wprobe_is_valid_addr() {
	if (addr < TASK_SIZE)
		return false;
    ...
}

On 64-bit architectures with 32-bit compatibility mode (such as x86_64 with
CONFIG_IA32_EMULATION), TASK_SIZE depends on the current task's personality
and evaluates to IA32_PAGE_OFFSET (~4 GiB) when a 32-bit compat task is
running.  Because modify_local_hw_breakpoint_addr() bypasses
arch_check_bp_in_kernelspace() (which checks TASK_SIZE_MAX), a set_wprobe
trigger firing in the context of a 32-bit compat task accepts any aligned
64-bit user-space address in [IA32_PAGE_OFFSET, TASK_SIZE_MAX) and programs
it into the CPU-wide hardware debug registers.  Using TASK_SIZE_MAX (or
arch_check_bp_in_kernelspace()) avoids depending on current.

[ ... ]

> +static void wprobe_trigger(struct event_trigger_data *data,
> +			   struct trace_buffer *buffer,  void *rec,
> +			   struct ring_buffer_event *event)
> +{
> +	struct wprobe_trigger_data *wprobe_data =3D data->private_data;
> +	struct trace_wprobe *tw =3D wprobe_data->tw;
> +	unsigned long target_addr, addr =3D 0, flags;
> +
> +	if (in_nmi())
> +		return;
> +
> +	if (wprobe_data->field) {
> +		if (!rec)
> +			return;
> +		addr =3D *(unsigned long *)((char *)rec + wprobe_data->offset);
> +		addr +=3D wprobe_data->adjust;
> +	}
> +
> +	raw_spin_lock_irqsave(&tw->lock, flags);
> +
> +	if (!__wprobe_count_func(data, addr)) {
> +		atomic_inc(&tw->missed);
> +		goto out;
> +	}
> +
> +	/*
> +	 * For counted triggers, verify data->count is still available under
> +	 * tw->lock to prevent concurrent executions from exceeding the limit.
> +	 */
> +	if ((data->flags & EVENT_TRIGGER_FL_COUNT) && !data->count)
> +		goto out;
> +
> +	target_addr =3D wprobe_data->clear ? WPROBE_DEFAULT_CLEAR_ADDRESS : add=
r;
> +
> +	/*
> +	 * Try updating the hardware breakpoint on the local CPU first.
> +	 * If this fails, skip updating tw->addr and do not queue irq_work.
> +	 * Note that this wprobe will not be traced until tw_addr is updated.
> +	 * (e.g. NMI happens on this CPU.)
> +	 */
> +	if (trace_wprobe_update_local(tw, target_addr)) {
> +		atomic_inc(&tw->missed);
> +		goto out;
> +	}
> +
> +	/*
> +	 * Decrement data->count here under tw->lock only after the local
> +	 * hardware breakpoint has been successfully updated. This avoids:
> +	 * 1) Consuming count on trigger attempts that failed/missed.
> +	 * 2) Race windows where concurrent CPUs decrement count and underflow
> +	 *    to -1 (unlimited).
> +	 */
> +	if (data->flags & EVENT_TRIGGER_FL_COUNT) {
> +		if (data->count > 0)
> +			(data->count)--;
> +	}
> +
> +	WRITE_ONCE(tw->addr, target_addr);
> +	if (!wprobe_data->clear)
> +		clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &wprobe_data->file->flags);
> +	else
> +		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &wprobe_data->file->flags);
> +
> +	/*
> +	 * For other CPUs, kick irq_work to asynchronously propagate
> +	 * the new address.
> +	 */
> +	if (num_online_cpus() > 1) {
> +		atomic_set(&tw->work_pending, 1);
> +		irq_work_queue(&tw->irq_work);
> +	}
> +
> +out:
> +	raw_spin_unlock_irqrestore(&tw->lock, flags);
> +}

[Severity: Medium]
Can wprobe_trigger() self-deadlock on tw->lock if a nested event fires
while tw->lock is held?

wprobe_trigger()
  raw_spin_lock_irqsave(&tw->lock, flags)
  irq_work_queue(&tw->irq_work)
    ...
      native_write_msr()
        trace_write_msr()
          ...
            wprobe_trigger()
              raw_spin_lock_irqsave(&tw->lock, flags)  <-- spins forever

While wprobe_trigger() holds tw->lock, irq_work_queue() on x86 with x2APIC
raises a self-IPI via native_write_msr(), firing the msr:write_msr
tracepoint, and functions called by trace_wprobe_update_local() (such as
modify_local_hw_breakpoint_addr()) can also be traced by fprobe events.  If
a wprobe trigger targeting the same trace_wprobe is attached to one of
those nested events, the inner wprobe_trigger() runs on the same CPU with
in_nmi() =3D=3D false and spins forever on tw->lock.

[Severity: Medium]
Can a stale breakpoint hit on a remote CPU fire unconditional triggers
attached to the wprobe event after clear_wprobe or set_wprobe updates
tw->addr?

CPU0                              CPU1
wprobe_trigger()
  WRITE_ONCE(tw->addr,
    WPROBE_DEFAULT_CLEAR_ADDRESS)
  set_bit(SOFT_DISABLED_BIT, ...)
  irq_work_queue(&tw->irq_work)
                                  wprobe_perf_handler()
                                    wprobe_trace_handler(tw, old_addr, ...)
                                      trace_trigger_soft_disabled(trace_fil=
e)
                                        event_triggers_call(...)
                                      if (READ_ONCE(tw->addr) !=3D addr)
                                        return;

kernel/trace/trace_wprobe.c:wprobe_trace_handler() {
    ...
	if (trace_trigger_soft_disabled(trace_file))
		return;

	if (READ_ONCE(tw->addr) !=3D addr)
		return;
    ...
}

Because remote CPUs update their hardware debug registers asynchronously via
tw->work, a remote CPU can still take a breakpoint exception for the old
address after tw->addr has changed.  In wprobe_trace_handler(),
trace_trigger_soft_disabled() runs before the READ_ONCE(tw->addr) !=3D addr
check, which invokes __trace_trigger_soft_disabled() ->
event_triggers_call() and fires any unconditional triggers (such as
traceoff, snapshot, or stacktrace) attached to the wprobe event.  Checking
READ_ONCE(tw->addr) !=3D addr before trace_trigger_soft_disabled() avoids
firing triggers on stale hits.

[ ... ]

> +static void release_private_wprobe_trigger_data(struct event_trigger_dat=
a *data)
> +{
> +	struct wprobe_trigger_data *wprobe_data =3D data->private_data;
> +
> +	/* The file may already be freed here, only the call is kept alive */
> +	trace_event_put_ref(trace_probe_event_call(&wprobe_data->tw->tp));
> +	free_wprobe_trigger_data(wprobe_data);
> +}

[ ... ]

> +static void wprobe_trigger_free(struct event_trigger_data *data)
> +{
> +	struct wprobe_trigger_data *wprobe_data =3D data->private_data;
> +
> +	if (WARN_ON_ONCE(data->ref <=3D 0))
> +		return;
> +
> +	data->ref--;
> +	if (!data->ref) {
> +		/* Remove the SOFT_MODE flag */
> +		trace_event_enable_disable(wprobe_data->file, 0, 1);
> +		data->private_data_free =3D release_private_wprobe_trigger_data;
> +		trigger_data_free(data);
> +	}
> +}

[Severity: Medium]
Can wprobe_trigger_free() unregister and free tw->bp_event while an
in-flight wprobe_trigger() is still using it?

CPU0                              CPU1
clear_event_triggers()
  list_del_rcu(&data->list)
  wprobe_trigger_free(data)
    trace_event_enable_disable()
      ...
        __unregister_trace_wprobe(tw)
          unregister_wide_hw_breakpoint(
            tw->bp_event)
                                  wprobe_trigger()
                                    trace_wprobe_update_local(tw, ...)
                                      bp =3D *this_cpu_ptr(tw->bp_event)
                                      modify_local_hw_breakpoint_addr(bp, .=
..)
                                        <-- use-after-free
          tw->bp_event =3D NULL
    trigger_data_free(data)
      /* tracepoint_synchronize_unregister() happens later in kthread */

When a trace instance is removed, clear_event_triggers() calls
data->cmd_ops->free(data) immediately after list_del_rcu() without waiting
for tracepoint_synchronize_unregister().  Because wprobe_trigger_free()
calls trace_event_enable_disable() before trigger_data_free() waits for
in-flight tracepoints, __unregister_trace_wprobe() frees the per-CPU
perf_event breakpoints and tw->bp_event before clearing tw->bp_event =3D NU=
LL
and without synchronizing with tw->lock, while a concurrent wprobe_trigger()
on another CPU dereferences tw->bp_event and queues tw->irq_work after
irq_work_sync() has already returned.

Conversely, when a user removes a trigger via wprobe_unregister_trigger(),
tracepoint_synchronize_unregister() has already completed, but deferring
trace_event_put_ref() to release_private_wprobe_trigger_data() on
trigger_kthread means an immediate dynamic_events removal of the wprobe can
race with the kthread and fail with -EBUSY.

> +static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
> +				    struct trace_event_file *file,
> +				    char *glob, char *cmd,
> +				    char *param_and_filter)
> +{
> +	/*
> +	 * set_wprobe:EVENT:FIELD[+OFFS]
> +	 * clear_wprobe:EVENT[:FIELD[+OFFS]]
> +	 */
> +	struct wprobe_trigger_data *wprobe_data =3D NULL;
> +	struct event_trigger_data *trigger_data =3D NULL;
> +	struct trace_event_file *wprobe_file;
> +	struct trace_array *tr =3D file->tr;
> +	char *event_str, *field_str, *comment;
> +	struct ftrace_event_field *field;
> +	struct trace_event_call *event;
> +	bool remove, clear =3D false;
> +	unsigned long orig_addr =3D 0;
> +	struct trace_wprobe *tw;
> +	char *param, *filter;
> +	int ret;
> +
> +	remove =3D event_trigger_check_remove(glob);
> +
> +	if (!strcmp(cmd, CLEAR_WPROBE_STR))
> +		clear =3D true;
> +
> +	if (param_and_filter) {
> +		/* Recover original trigger string to show the error log correctly. */
> +		if (*(param_and_filter - 1) =3D=3D '\0')
> +			*(param_and_filter - 1) =3D ':';
> +		comment =3D strchr(param_and_filter, '#');
> +		if (comment)
> +			*comment =3D '\0';
> +	}
> +
> +	if (event_trigger_empty_param(param_and_filter)) {
> +		wprobe_trigger_log_err(file, glob, strlen(cmd) + 1, WPROBE_NOT_FOUND);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D event_trigger_separate_filter(param_and_filter, &param, &filter=
, true);
> +	if (ret)
> +		return ret;
> +
> +	if (file->event_call->flags & TRACE_EVENT_FL_KPROBE) {
> +		wprobe_trigger_log_err(file, glob, 0, WPROBE_ON_KPROBE);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	event_str =3D strsep(&param, ":");

[Severity: Low]
Does mutating param_and_filter in place truncate the command string logged
by wprobe_trigger_log_err()?

param_and_filter points into the glob buffer.  Although the code restores
the colon at *(param_and_filter - 1), subsequent calls to
event_trigger_separate_filter(), strsep(&param, ":"), and *offs =3D '\0'
insert NUL terminators directly into glob.  Any later
wprobe_trigger_log_err(file, glob, ...) call for a bad field, offset, or
count logs only the truncated prefix of glob while passing an error caret
offset past the end of the logged string.  Also, when param_and_filter is
NULL (for example, writing "set_wprobe" with no colon), strlen(cmd) + 1
points one byte past the NUL terminator of glob.

> +	/* Find target wprobe */
> +	tw =3D find_trace_wprobe(event_str, WPROBE_EVENT_SYSTEM);
> +	if (!tw) {
> +		wprobe_trigger_log_err(file, glob, event_str - glob, WPROBE_NOT_FOUND);
> +		return -ENOENT;
> +	}
> +	/* The target wprobe must not be used (unless clear) */
> +	if (!remove && !clear && trace_probe_is_enabled(&tw->tp)) {
> +		wprobe_trigger_log_err(file, glob, event_str - glob, WPROBE_BUSY);
> +		return -EBUSY;
> +	}

[Severity: Medium]
Does checking trace_probe_is_enabled(&tw->tp) here conflate manual enabling
with trigger soft-enabling?

Both set_wprobe and clear_wprobe call trace_event_enable_disable(wprobe_fil=
e,
1, 1), which sets TP_FLAG_TRACE on tw->tp and makes
trace_probe_is_enabled(&tw->tp) return true.  As a result, registering
clear_wprobe before set_wprobe, re-adding set_wprobe after removing it while
clear_wprobe is still attached, or attaching set_wprobe to a second event
all fail with -EBUSY.  When clear_wprobe is registered first, tw->addr is
also not initialized to WPROBE_DEFAULT_CLEAR_ADDRESS because that assignment
is gated on !clear.

Conversely, because clear_wprobe skips this busy check, it can be attached
to a wprobe that was manually enabled by the user (where sm_ref =3D=3D 0); =
when
clear_wprobe fires or is later removed, it soft-disables or unregisters the
manually enabled wprobe.

[ ... ]

> +	if (!clear) {
> +		orig_addr =3D tw->addr;
> +		WRITE_ONCE(tw->addr, WPROBE_DEFAULT_CLEAR_ADDRESS);
> +	}
> +
> +	ret =3D trace_event_enable_disable(wprobe_file, 1, 1);

[Severity: Medium]
Does overwriting tw->addr without restoring it on trigger teardown break
trace_wprobe_show() and dynamic_events deletion?

When set_wprobe is registered and fires, tw->addr is overwritten first with
WPROBE_DEFAULT_CLEAR_ADDRESS and then with the runtime target address, and
removing the trigger leaves tw->addr at that runtime value.  For a wprobe
created with rw@-1:8, removing set_wprobe after it fires causes
trace_wprobe_show() to print the runtime address instead of -1, and
deleting the wprobe with "!w:watch rw@-1:8 ..." fails in
trace_wprobe_match_command_head() because tw->addr no longer equals
WPROBE_DEFAULT_CLEAR_ADDRESS.  For a symbol-based wprobe, tw->symbol remains
set while tw->addr is left clobbered, so trace_wprobe_show() still shows
@symbol while re-enabling the wprobe watches the wrong address.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179480675130.38065.=
3086970856119381693.stgit@devnote2?part=3D8
