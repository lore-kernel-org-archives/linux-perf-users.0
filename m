Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F42C324C;
	Tue,  3 Jun 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942041; cv=none; b=TkEmpWQBFkoL7izGUUyNg01zKV6sH4yazwfK9n/Slcp2agPiolmxCShOjNZP0O6h7XTGy8WSc8cf/KPXDVUowZqF8pe8YxVA594a3jOjih3b2oGrCzM39aupSmvX5N7NOeTzhvATAElrpg7d8hH1ny59rP/wnIxGIa2dBdInbCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942041; c=relaxed/simple;
	bh=m1CYRoFP7GdOXWY6GfCe8KAfcwT4NpaKLyPcSYGgEx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ll3OzDqmGsT0YBUUAbtJ1sZCRGFlHzWNJoQALW6a3g0LxgJyEaCgH+v95EAxYT+WOQKg74HOeISQ1zmDqopZ9mFzO99/kCLRv7UUibUam5/lHK+NfR1cuGduVrCaHmwA63XEhYp3pVtKuipX2r5AiBzJrySyAYXIjal8pDQyEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uvyObkpv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uvyObkpv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PTK4EZERvcyf/RV0NxqSFkpa2G5REi4wJsL3hiP579g=; b=uvyObkpvJyqvFxKjg5iZKzDiXb
	YVDhA7OPC05buNgxpPSOZ9QCyM69N/lpBlMK6RJTPRGMXM7sf8rq2HqrFTlS0KXZZKAYcwKqsPuMY
	mL7A/epEcuGQbOcgps26J9UcLc/N6uQlMqkc7X8DnHhsh3Vgn/isHmD3ocwMqmzLUDtSz2SyitUlq
	POudBwk+rzmOCPdZUznIhO26lxyOeXn5M8FLcOKsSb/vx4dEnwCjka7QTJqXztzoA0TGJbR2g8AmE
	+uCUmFW38cwd4C8RohL03hy4UvgmyfEZ9baemvH1QzEcUSmjl9PvdpG7F2jOxaDwqh4fg5SdmGoJl
	Ei0h1dwA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMNiT-00000001qer-0VnF;
	Tue, 03 Jun 2025 09:13:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7F8773005AF; Tue,  3 Jun 2025 11:13:52 +0200 (CEST)
Date: Tue, 3 Jun 2025 11:13:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Wang <00107082@163.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mingo@kernel.org, yeoreum.yun@arm.com, leo.yan@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: restore __perf_remove_from_context when
 DETACH_EXIT not set
Message-ID: <20250603091352.GJ21197@noisy.programming.kicks-ass.net>
References: <20250603032651.3988-1-00107082@163.com>
 <20250603083304.34132-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603083304.34132-1-00107082@163.com>

On Tue, Jun 03, 2025 at 04:33:04PM +0800, David Wang wrote:
> commit a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting
> bug at task exit") made changes to __perf_remove_from_context() to
> coordinate its changes with perf_event_exit_event(), but the change are
> unconditional, it impacts callpaths to __perf_remove_from_context()
> other than from perf_event_exit_event(). One of the impact is to cgroup,
> which is not properly handled and would cause kernel panic with high
> probalibity during reboot on some system[1].

Sorry, but no. This does not describe the problem adequately. I would
have to go read your [1] to figure out what is actually broken.

That is, having read the above, I'm still clueless as to what the actual
problem is.

> To confine the side effects, make the changes to
> __perf_remove_from_context() conditional, restore to its previous state
> except when DETACH_EXIT is set.
> 
> Closes: https://lore.kernel.org/lkml/20250601173603.3920-1-00107082@163.com/ [1]
> Fixes: a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")
> Signed-off-by: David Wang <00107082@163.com>
> ---
> Changes:
> Address yeoreum.yun@arm.com's concern about missing cgroup event.
> ---
>  kernel/events/core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 95e703891b24..e2c0f34b0789 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2466,7 +2466,7 @@ __perf_remove_from_context(struct perf_event *event,
>  			   void *info)
>  {
>  	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
> -	enum perf_event_state state = PERF_EVENT_STATE_OFF;
> +	enum perf_event_state exit_state = PERF_EVENT_STATE_EXIT;
>  	unsigned long flags = (unsigned long)info;
>  
>  	ctx_time_update(cpuctx, ctx);
> @@ -2475,19 +2475,20 @@ __perf_remove_from_context(struct perf_event *event,
>  	 * Ensure event_sched_out() switches to OFF, at the very least
>  	 * this avoids raising perf_pending_task() at this time.
>  	 */
> -	if (flags & DETACH_EXIT)
> -		state = PERF_EVENT_STATE_EXIT;
>  	if (flags & DETACH_DEAD) {
>  		event->pending_disable = 1;
> -		state = PERF_EVENT_STATE_DEAD;
> +		exit_state = PERF_EVENT_STATE_DEAD;
>  	}
>  	event_sched_out(event, ctx);
> -	perf_event_set_state(event, min(event->state, state));
>  	if (flags & DETACH_GROUP)
>  		perf_group_detach(event);
>  	if (flags & DETACH_CHILD)
>  		perf_child_detach(event);
>  	list_del_event(event, ctx);
> +	if (flags & DETACH_EXIT)
> +		perf_event_set_state(event, min(event->state, exit_state));
> +	if (flags & DETACH_DEAD)
> +		event->state = PERF_EVENT_STATE_DEAD;

Urgh, no. Trying to reverse engineer the above, the intent appears to be
to not set OFF.

This can be achieved by doing:

-       enum perf_event_state state = PERF_EVENT_STATE_OFF;
+       enum perf_event_state state = event->state;

No other changes required. You also move the location of
perf_event_set_state(), but it is entirely unclear to me if that is
actually needed.

Worse, you split the means of setting state -- that is entirely uncalled
for.
