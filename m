Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6C3A16BA;
	Tue, 22 Sep 2026 02:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044775; cv=none; b=utu6vLYUWwPBttvpn3plRDhG1LLaQeaSDFlsayPtI6xP7sjyZdTJ/wyGssteGf6xLuVMOAqlNjJLViEDXTgZMwpFhh0Pr4usAfsXvWYZF7Ps/hhfg36/1RY8MbZCWeA2Oxm8YjouMpWUnRQhTBtmhtXMWAxgE8hp/QOSRlM/Dic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044775; c=relaxed/simple;
	bh=oZLpOhucHC43z4ds0CWKTjnSopVVOHC64Q7+aCD2T9U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pVudwEDAqHqQEr5ExLzb8l8sZB7Z20n3NIrgbQadvkkAKLTHJAiA/+cHtOyuYcCG3i/PakLC5s6rQ7Y+2mmpEEyYE8NMabCvGaQHWAOXzBFohjPo5t6VES8fsrkBfi798iaP9E+AJYJ31NMzg7DU2+VXY0+StUXEejuW3Ngd4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grS8wGjB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grS8wGjB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624791F000FF;
	Tue, 22 Sep 2026 02:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790044766;
	bh=/SAfsVYoWNOJHq26yUF7h5nEJM0KRG0iyQixYLdJd5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=grS8wGjBF4E6C9/mcHeILgxNYrsa6oMXLRS4na/8KMmB4+53iikNfdmTyH5i+6Zf+
	 8YJg0xNC4ZVXroZwuGKsSRmAuu4/iQz6zUkhLTuWTS9P6QmHtW8yhljyAJfpUkC8Og
	 ECCn45hx1OOxUswv48gEzLwnzFdcoutxzmBL9LaXNnI9KSuwNjydL4/4hpziCOs/Lm
	 jl8GrZHIA5LQmZQE3V8TStaJD3/yRG5GjvoHdy6HvjY6avL2qsOTT0z8stwjwJa1VS
	 SHJTetGRQgyjaUOLjTzH7ZU7dMmY+3j47ThBwh3LDJhd6QBhTN+aKxalTJ/vFmYSqD
	 b2u0OjWOHrPJg==
Date: Tue, 22 Sep 2026 11:39:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v16 10/13] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Message-Id: <20260922113923.351783c6db12f18befe1db79@kernel.org>
In-Reply-To: <20260914145845.1D9D21F000FF@smtp.kernel.org>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
	<178939029574.94750.11636803595861231046.stgit@devnote2>
	<20260914145845.1D9D21F000FF@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 14:58:44 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Missing RCU synchronization in the error path of wprobe trigger registration leads to a Use-After-Free of hardware breakpoint perf_event structures.
> - [High] Hardware breakpoint addresses are not updated for offline CPUs, leading to stale addresses when CPUs come online.
> - [Medium] The 'count' parameter is decremented on trigger evaluation misses, causing the trigger to exhaust its count without actually modifying the watchpoint.
> - [Medium] The wprobe event permanently leaks as enabled when the trigger is unregistered because `EVENT_FILE_FL_SOFT_DISABLED_BIT` is manually cleared.
> - [Low] A field named 'unlimited' is silently ignored by `clear_wprobe` if no count keyword is provided.
> --
> 
> commit 146ca411781d7203b266aa3745d30641c87b97d2
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/wprobe: Add set_wprobe and clear_wprobe event triggers
> 
> Add set_wprobe and clear_wprobe event triggers to dynamically attach
> and detach hardware breakpoint address monitoring based on event field
> contents.
> 
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> > index 9c6100b63e8d9..55a201504bb0b 100644
> > --- a/kernel/trace/trace_wprobe.c
> > +++ b/kernel/trace/trace_wprobe.c
> 
> [ ... ]
> 
> > @@ -231,6 +303,12 @@ static struct trace_wprobe *alloc_trace_wprobe(const char *group,
> > 
> > +static void wprobe_work_func(struct work_struct *work)
> > +{
> > +	struct trace_wprobe *tw = container_of(work, struct trace_wprobe, work);
> > +
> > +	on_each_cpu(wprobe_smp_update_func, tw, true);
> 
> [Severity: High]
> Could this leave hardware breakpoints with stale addresses on offline CPUs?
> 
> on_each_cpu() only broadcasts to currently online CPUs, so offline CPUs
> won't execute trace_wprobe_update_local(). When an offline CPU comes
> online, won't the perf event core reinstall the hardware breakpoint using
> the old, stale address since it wasn't updated here?

OK, introduce cpu hotplug callback to handle it.

> 
> [ ... ]
> 
> > @@ -773,3 +866,538 @@ static __init int init_wprobe_trace(void)
> 
> [ ... ]
> 
> > +static void wprobe_trigger(struct event_trigger_data *data,
> > +			   struct trace_buffer *buffer,  void *rec,
> > +			   struct ring_buffer_event *event)
> > +{
> > +	struct wprobe_trigger_data *wprobe_data = data->private_data;
> > +	struct trace_wprobe *tw = wprobe_data->tw;
> > +	unsigned long addr = 0, flags;
> > +	bool changed = false;
> 
> [ ... ]
> 
> > +	raw_spin_lock_irqsave(&tw->lock, flags);
> > +
> > +	if (!wprobe_data->clear) {
> > +		if (!trace_wprobe_is_valid_addr(addr, tw->len)) {
> > +			atomic_inc(&tw->missed);
> > +			goto out;
> > +		}
> > +		if (tw->addr == WPROBE_DEFAULT_CLEAR_ADDRESS) {
> > +			/* Skip if a previous work is still propagating the address */
> > +			if (atomic_read(&tw->work_pending)) {
> > +				atomic_inc(&tw->missed);
> > +				goto out;
> > +			}
> > +			WRITE_ONCE(tw->addr, addr);
> > +			changed = true;
> > +			clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &wprobe_data->file->flags);
> 
> [Severity: Medium]
> Does manually clearing EVENT_FILE_FL_SOFT_DISABLED_BIT cause the event to leak
> as enabled?
> 
> When the trigger is unregistered, wprobe_trigger_free() calls
> trace_event_enable_disable(file, 0, 1). Because the soft-disabled bit was
> cleared here, won't the core event logic skip the unregister step, leaving
> the wprobe tracepoint permanently enabled in the kernel?

Good catch!
Hmm, we should set EVENT_FILE_FL_SOFT_DISABLED_BIT when removing
a wprobe_trigger.

> 
> [ ... ]
> 
> > +static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
> > +				    struct trace_event_file *file,
> > +				    char *glob, char *cmd,
> > +				    char *param_and_filter)
> > +{
> 
> [ ... ]
> 
> > +	} else if (param && (isalpha(param[0]) || param[0] == '_')) {
> > +		if (strncmp(param, "count=", 6) != 0 &&
> > +		    strcmp(param, "unlimited") != 0) {
> 
> [Severity: Low]
> Is this intended to skip fields named "unlimited"?
> 
> If a user configures a clear_wprobe trigger on an event that happens to have
> a field named "unlimited", this parser matches the keyword and skips parsing
> it as a field, which defaults to an unconditional clear action.

Hmm, OK. Let's check the event has "unlimited" field or not.

> 
> [ ... ]
> 
> > +static int wprobe_register_trigger(char *glob,
> > +				   struct event_trigger_data *data,
> > +				   struct trace_event_file *file)
> > +{
> > +	int ret = 0;
> > +
> > +	lockdep_assert_held(&event_mutex);
> > +
> > +	/* The same wprobe is not accept on the same file (event) */
> > +	if (wprobe_trigger_find_same(data, file))
> > +		return -EEXIST;
> > +
> > +	if (data->cmd_ops->init) {
> > +		ret = data->cmd_ops->init(data);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	list_add_rcu(&data->list, &file->triggers);
> > +
> > +	update_cond_flag(file);
> > +	ret = trace_event_trigger_enable_disable(file, 1);
> > +	if (ret < 0) {
> > +		list_del_rcu(&data->list);
> > +		update_cond_flag(file);
> > +		if (data->cmd_ops->free)
> > +			data->cmd_ops->free(data);
> > +	}
> 
> [Severity: High]
> Does this error path need RCU synchronization?
> 
> If trace_event_trigger_enable_disable() fails, list_del_rcu() is called
> without a subsequent synchronize_rcu(). The cmd_ops->free callback
> (wprobe_trigger_free) will then synchronously disable the wprobe, which
> frees the tw->bp_event array.
> 
> Could a concurrent tracepoint reader still observe the trigger data,
> execute wprobe_trigger(), and dereference the freed tw->bp_event via
> this_cpu_ptr() inside trace_wprobe_update_local()?

Yes. Let me add tracepoint_synchronize_unregister() here for
waiting RCU.

> 
> [ ... ]
> 
> > +static struct event_command trigger_wprobe_set_cmd = {
> > +	.name			= SET_WPROBE_STR,
> > +	.trigger_type		= ETT_EVENT_WPROBE,
> > +	/* This triggers after when the event is recorded. */
> > +	.flags			= EVENT_CMD_FL_NEEDS_REC,
> > +	.parse			= wprobe_trigger_cmd_parse,
> > +	.reg			= wprobe_register_trigger,
> > +	.unreg			= wprobe_unregister_trigger,
> > +	.set_filter		= set_trigger_filter,
> > +	.trigger		= wprobe_trigger,
> > +	.count_func		= event_trigger_count,
> 
> [Severity: Medium]
> Will this unconditionally exhaust the trigger's count parameter even on misses?
> 
> Because .count_func is set to event_trigger_count, the count is decremented
> before wprobe_trigger() runs. If the trigger fails its implicit checks inside
> wprobe_trigger() (such as checking if the field matches the watched address),
> the count has already been consumed.

Hmm, OK. Let me add wprobe_count_func() to check the condition.

Thank you,

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/178939017565.94750.9431053336761330458.stgit@devnote2?part=10


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
