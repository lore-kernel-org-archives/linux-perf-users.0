Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC5B1534E9;
	Tue, 17 Sep 2024 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726610873; cv=none; b=Z6afiaqibG/WoDGnTQo2eDfBNvcG9i5MFJqLrxTDC0s8x+SNaP9kriFMfqGIND8M00UucBO4dWKOyQA5DCSmqTRGF7f3HaibRZc4JwuBhb+odTS938SdrLI6nPs9gvamdk3g3RIXi1GWAySCkqCvtuiabyaJIeyjDJ9HaeIgT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726610873; c=relaxed/simple;
	bh=DcuKuvbMdwbeLQDLbDaV5ujKJiI0JjD8+iTRjt9kt2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liuXOS6wa68cFpI1iGKkIDoogabqjJGuRdIKsslS/RA784bbA9pwQZcWB1OnLUtaSj2zHawEfmdQJ5UEaGVINhLBc/4+3m4UgoP1ODsy9YlJhQ1v9XDqpkYzbNQsLq5A2NXLfJelK9An3SLjjC1f2JJyrprW5MUvEXJN/e2uTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT1ySX8F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT1ySX8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2A8C4CEC5;
	Tue, 17 Sep 2024 22:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726610872;
	bh=DcuKuvbMdwbeLQDLbDaV5ujKJiI0JjD8+iTRjt9kt2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pT1ySX8F5p8k0PsjfYtxmq7rSQsEWhS8DU/I23ERlYPjbr+wE3roviRikmBOW88tO
	 Mb8NBS1+vfZmCVVkqZXTxGkIjHYULvjfCjb3bokrQTghHnM6GSrPCyDW/NU9ZTO/HI
	 qiMp+HIAXMxu5DyUnSy3aJj9sntefIhhYG83Ei84mwBOHzWwcMiZPAqW4y1ipTD1if
	 J4FrSALJ93uPZod2/J1uPuI3dse6bVejxEFHYMRTEtgema8nhBMxPNTXAsKfmIKT2x
	 efiD0EVGz7opE5F9tsbmh5d3akOlEEjQfQPGTkqtR2OspCD8ewrsHut8eiZ2WWViZj
	 sdvFgF3JL7cEw==
Date: Tue, 17 Sep 2024 15:07:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v2 09/11] perf: Introduce deferred user callchains
Message-ID: <Zun9r1TAAG1slUSA@google.com>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <5bc834b68fe14daaa1782b925ab54fc414245334.1726268190.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5bc834b68fe14daaa1782b925ab54fc414245334.1726268190.git.jpoimboe@kernel.org>

On Sat, Sep 14, 2024 at 01:02:11AM +0200, Josh Poimboeuf wrote:
> Instead of attempting to unwind user space from the NMI handler, defer
> it to run in task context by sending a self-IPI and then scheduling the
> unwind to run in the IRQ's exit task work before returning to user space.
> 
> This allows the user stack page to be paged in if needed, avoids
> duplicate unwinds for kernel-bound workloads, and prepares for SFrame
> unwinding (so .sframe sections can be paged in on demand).
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
[SNIP]  
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 19fd7bd38ecf..5fc7c5156287 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6854,11 +6860,70 @@ static void perf_pending_irq(struct irq_work *entry)
>  		perf_swevent_put_recursion_context(rctx);
>  }
>  
> +struct perf_callchain_deferred_event {
> +	struct perf_event_header	header;
> +	struct perf_callchain_entry	callchain;
> +};
> +
> +#define PERF_CALLCHAIN_DEFERRED_EVENT_SIZE				\
> +	sizeof(struct perf_callchain_deferred_event) +			\
> +	(sizeof(__u64) * 1) + /* PERF_CONTEXT_USER */			\
> +	(sizeof(__u64) * PERF_MAX_STACK_DEPTH)
> +
> +static void perf_event_callchain_deferred(struct perf_event *event)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +	struct perf_callchain_entry *callchain;
> +	struct perf_output_handle handle;
> +	struct perf_sample_data data;
> +	unsigned char buf[PERF_CALLCHAIN_DEFERRED_EVENT_SIZE];
> +	struct perf_callchain_entry_ctx ctx;
> +	struct perf_callchain_deferred_event *deferred_event;
> +
> +	deferred_event = (void *)&buf;
> +
> +	callchain = &deferred_event->callchain;
> +	callchain->nr = 0;
> +
> +	ctx.entry		= callchain;
> +	ctx.max_stack		= MIN(event->attr.sample_max_stack,
> +				      PERF_MAX_STACK_DEPTH);
> +	ctx.nr			= 0;
> +	ctx.contexts		= 0;
> +	ctx.contexts_maxed	= false;
> +
> +	perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
> +	perf_callchain_user_deferred(&ctx, regs);
> +
> +	deferred_event->header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
> +	deferred_event->header.misc = 0;

I think we can use PERF_RECORD_MISC_USER here as it's about user
callchains.

> +	deferred_event->header.size = sizeof(*deferred_event) +
> +				      (callchain->nr * sizeof(u64));
> +
> +	perf_event_header__init_id(&deferred_event->header, &data, event);
> +
> +	if (perf_output_begin(&handle, &data, event,
> +			      deferred_event->header.size))
> +		return;
> +
> +	perf_output_copy(&handle, deferred_event, deferred_event->header.size);

You should not copy the whole event size because it also contains the
id_sample parts in the below.  Maybe something like this instead?

	perf_output_put(&handle, *deferred_event);
	__output_copy(&handle, callchain->ip, callchain->nr * sizeof(u64));

Thanks,
Namhyung


> +	perf_event__output_id_sample(event, &handle, &data);
> +	perf_output_end(&handle);
> +}
> +
>  static void perf_pending_task(struct callback_head *head)
>  {
>  	struct perf_event *event = container_of(head, struct perf_event, pending_task);
>  	int rctx;
>  
> +	if (!is_software_event(event)) {
> +		if (event->pending_callchain) {
> +			perf_event_callchain_deferred(event);
> +			event->pending_callchain = 0;
> +		}
> +		return;
> +	}
> +
>  	/*
>  	 * All accesses to the event must belong to the same implicit RCU read-side
>  	 * critical section as the ->pending_work reset. See comment in
> @@ -7688,6 +7753,8 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>  	bool user   = !event->attr.exclude_callchain_user;
>  	const u32 max_stack = event->attr.sample_max_stack;
>  	struct perf_callchain_entry *callchain;
> +	bool defer_user = IS_ENABLED(CONFIG_HAVE_PERF_CALLCHAIN_DEFERRED) &&
> +			  event->attr.defer_callchain;
>  
>  	/* Disallow cross-task user callchains. */
>  	user &= !event->ctx->task || event->ctx->task == current;
> @@ -7695,7 +7762,14 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>  	if (!kernel && !user)
>  		return &__empty_callchain;
>  
> -	callchain = get_perf_callchain(regs, kernel, user, max_stack, true);
> +	callchain = get_perf_callchain(regs, kernel, user, max_stack, true,
> +				       defer_user);
> +
> +	if (user && defer_user && !event->pending_callchain) {
> +		event->pending_callchain = 1;
> +		irq_work_queue(&event->pending_irq);
> +	}
> +
>  	return callchain ?: &__empty_callchain;
>  }
>  
> -- 
> 2.46.0
> 
