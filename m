Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FF184;
	Fri, 25 Sep 2026 02:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790303223; cv=none; b=CQ1NDdLAz54mAJu0Sxo5jR67LqgebVz3xzKgU5TyzhNdvOrQn/6ijX1y4HpYvweKAXKqaJJArP1iBDMOU1y6n286sORw+dtwvRTDpz7POUclJ7BqpyZLnQOvPFqbnedyrvIga7owQChx3MapDquAWZpjEBegQ8Tec7RwomzYqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790303223; c=relaxed/simple;
	bh=6PXS7H4wFEJClTzUFNo4UzuQSmfvDpFmThwxZEYbYB8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fbp50tEInoMlHLI3aS8SanHwDlA3otuqY2mQebFYZRsG7vA+/B4TDx5IIqYgNPX1wUIngdll15fIZx0z7zCJxzx5nWTPF0Xf2lOCr4q149ohrDk/Txej8tFgH8LtH0MWBOx9HtcXfjHTQnvyOTk8SUeOzS7EDuo/z+MC1rEOqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQIipZNM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQIipZNM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C5A1F000FF;
	Fri, 25 Sep 2026 02:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790303221;
	bh=xIV86QW+Coqh6Iuh30T332CDhfsBi3YyDaDo9LRNPcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oQIipZNMlSPo/4Rd0UOQ3e3qgWvs2ojWz933HYzGA4Vlhc/V9spMb266t7N0wa5Vb
	 aRXPhDyjSyxQUGgBh0UpkGP2Fx9+mwY0DW/Z70JuYW0hinIzy8XNhowlRC0Mm0aKiP
	 Q0CItD8NRoByJQU0EN1KBi9eblXtpgmLSdnchioIXehUuhFrlaRc3RH7Kie+EqFlxy
	 zTo6N+TLrZy4UO77r5+fJ1XXyRo9jaA7N6VIVEvJTcGjUPXTbgWb9mx0aA8XQjcijA
	 BQ+bJA2zn3YskhogbVpDtOsCKlLIxpZd+xj0lyq4P961n89Jg1SgR9oXTub+12QfLS
	 HqaufgPpI9JvQ==
Date: Fri, 25 Sep 2026 11:26:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v17 10/13] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Message-Id: <20260925112657.541352e9e87b745bd56ea76c@kernel.org>
In-Reply-To: <20260922044325.587F31F00898@smtp.kernel.org>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
	<179005120276.388919.1645992887114424511.stgit@devnote2>
	<20260922044325.587F31F00898@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 04:43:24 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] tracing/wprobe: NMI deadlock in wprobe_trigger() when count is not specified
> - [High] tracing/wprobe: CPU hotplug race in __register_trace_wprobe() misses new CPUs
> - [Medium] tracing/wprobe: TOCTOU race in wprobe_trigger() corrupts watchpoint address
> --
> 
> commit b9f67542e6bf772512bb8cbf3c3011379c301eb4
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
> > index 9c6100b63e8d9..f1d6aa320f213 100644
> > --- a/kernel/trace/trace_wprobe.c
> > +++ b/kernel/trace/trace_wprobe.c
> > @@ -193,20 +217,130 @@ static int __register_trace_wprobe(struct trace_wprobe *tw)
> 
> [ ... ]
> 
> >  	tw->bp_event = register_wide_hw_breakpoint(&attr, wprobe_perf_handler, tw);
> >  	if (IS_ERR_PCPU(tw->bp_event)) {
> >  		int ret = PTR_ERR_PCPU(tw->bp_event);
> >  
> >  		tw->bp_event = NULL;
> >  		return ret;
> >  	}
> >  
> > +	mutex_lock(&wprobe_mutex);
> > +	list_add(&tw->active_list, &active_wprobes);
> > +	mutex_unlock(&wprobe_mutex);
> > +
> 
> [Severity: High]
> Does this code have a race condition with CPU hotplug?
> 
> Looking at __register_trace_wprobe(), it calls register_wide_hw_breakpoint()
> which installs breakpoints and releases the hotplug lock internally.
> 
> If a new CPU comes online immediately after that lock is released, but before
> this wprobe is added to active_wprobes under wprobe_mutex, could the
> wprobe_cpu_online() callback miss the wprobe? This would leave the new CPU
> without hardware breakpoints installed for this probe.

Hmm, OK. Taking a cpus_read_lock() for both can avoid this issue.

> 
> >  	return 0;
> >  }
> 
> [ ... ]
> 
> > @@ -767,9 +923,608 @@ static int trace_wprobe_show(struct seq_file *m, struct dyn_event *ev)
> 
> [ ... ]
> 
> > +static void wprobe_trigger(struct event_trigger_data *data,
> > +			   struct trace_buffer *buffer,  void *rec,
> > +			   struct ring_buffer_event *event)
> > +{
> > +	struct wprobe_trigger_data *wprobe_data = data->private_data;
> > +	struct trace_wprobe *tw = wprobe_data->tw;
> > +	unsigned long target_addr, addr = 0, flags;
> > +
> > +	if (wprobe_data->field) {
> > +		if (!rec)
> > +			return;
> > +		addr = *(unsigned long *)((char *)rec + wprobe_data->offset);
> > +		addr += wprobe_data->adjust;
> > +	}
> > +
> > +	raw_spin_lock_irqsave(&tw->lock, flags);
> > +
> 
> [Severity: High]
> Could this raw_spin_lock_irqsave() cause a deadlock if interrupted by an NMI?
> 
> When no count limit is specified (EVENT_TRIGGER_FL_COUNT is not set),
> wprobe_trigger() takes tw->lock before calling __wprobe_count_func().
> 
> If an NMI interrupts a CPU already holding tw->lock and hits a trace event
> that fires the same uncounted trigger, it will attempt to acquire tw->lock
> again here. Since the in_nmi() check is located inside __wprobe_count_func(),
> the NMI would spin forever before realizing it shouldn't proceed.

Ah, indeed. It should check in_nmi() earlier than the spin lock.

> 
> > +	if (!(data->flags & EVENT_TRIGGER_FL_COUNT)) {
> > +		if (!__wprobe_count_func(data, addr)) {
> > +			atomic_inc(&tw->missed);
> > +			goto out;
> > +		}
> > +	}
> 
> [Severity: Medium]
> Is there a time-of-check to time-of-use (TOCTOU) race here for counted
> triggers?
> 
> For counted triggers, wprobe_count_func() is called locklessly by the trace
> core, which evaluates __wprobe_count_func(). Then, wprobe_trigger() is called
> and takes tw->lock. Because EVENT_TRIGGER_FL_COUNT is set, the state
> validation check (__wprobe_count_func()) is explicitly skipped under the lock.
> 
> If a counted trigger fires concurrently on multiple CPUs, both might
> observe the unset address locklessly. Could the second CPU unconditionally
> overwrite tw->addr, breaking the exclusive trigger constraint?

Hmm, indeed. I think the current event trigger subsystem is not well
designed for the concurrency. Let me move the data->count update to
wprobe_trigger() inside tw->lock critical region.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
