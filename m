Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824266;
	b=p7g2/7gpik3MpsjR4jafyZSYlCa6B7t99p+St5Qd8pq2SrDIZzwyWW8h+h2/3gyZXGVm
	 IwDj01euXrpL9tl3xJfkkiM2DxzF9gWad+P3W+2+wyxagIWlSbk/1aHkRNhUU0lRXe88M
	 MlX7zxVnRE5zDfblpsFvVp1bpRup9nr6yiQf87zxhUGd0xJsR0bJt8MihxAhmYleTWfK6
	 1SyZaTcn1Mg5AJVY7mU90N2IjyYTZ50f9EiR73tzfenmBwfy3yMbm2aHQvmLfTI/tyb6h
	 MXrMbNBsqhPB6XeWyGihza8j+QUK/fkofGB0vVqkuIs8llqZlzeY4z3clRH5RjSV2yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824266;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Gvv2DyAp4JVPfUBKtaM8rPmeQgPIXCGymcJ4/vQH2IE=;
	b=Co1YlmHB3BbHlT7U3mffP14zPbbX2fpGnlwWNMhhJaCekCmSU5Q+G8AFThsGfaCeNT1W
	 WeNSrq5pEaYeqeJON2dcGFNb+8qzh7+12+iSIVvJRpOTaWZ2sFtC4AvYo+1yvJcvMtzIu
	 fWpBdn7SwmKnXU3PNMNzjQb5irEZOE+tI1R6aSyV7bAyD7FVvONz5Ab10A1Z24QMRjkp6
	 yQPQxs2/h8puPOB3xBRfNwmZzqonUp+lNx+CadaN0o9FL4r32g5SJYSi5W951mr9YpMBO
	 Nmtzq4mcPx1TzKIoc8sDltgpj+GFAmfr7BVvMjdhoIUwWrEjxlN8LOTfq+x8d5EvOYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=1katym5m;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Z3qyToCD;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4C4606A336;
	Mon, 16 Nov 2026 10:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E4C4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=1katym5m;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Z3qyToCD
Date: Mon, 16 Nov 2026 11:17:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794824264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvv2DyAp4JVPfUBKtaM8rPmeQgPIXCGymcJ4/vQH2IE=;
	b=1katym5mwk/UMOFz3y8SY7HtyY4qM1tRwBmT4GvIm+ownixD5zibEXS5SwUvEuzFaQnXd9
	v6Em+HSx6COsoMP9gQAgr9u09Gnwwb+3pEOu9zUnFeOyhP1OlOfErn3KW/RMuKLIEiZ18D
	bMKNifhkbNgViadEGM0xUYy5Dt7U2R7x1zsYnxzXfnXdeU8JV9xqiXIFXXk13SPvnLLbSi
	qn55njlPDnPjP0+F5hfnDmsq78ChTRyiD4HLomGAnnA4EQHVk8xWXXQ4zc7HHzLxZR8dYb
	LQoOG+NECnapgDW7rL10PqMv9MhZyTtkVxhAta+LB2+ektQ78kwvFoHQBUz6QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794824264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvv2DyAp4JVPfUBKtaM8rPmeQgPIXCGymcJ4/vQH2IE=;
	b=Z3qyToCDZ/Eqh8pNlhKLuZ3PRnXwUkydSt6uFzBShH1eSkEK7vTXwBqt/Grb2cLxrV5pwW
	lHHVaOLD8jmIrBBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] perf/core: Disable context fast-swap for sigtrap
 events
Message-ID: <20261116101742.11G-Kmmb@linutronix.de>
References: <cover.1793870900.git.wutengda@huaweicloud.com>
 <f19b29b90fe1d0126fa8f5cd0e7c8d7da07e5a34.1793870900.git.wutengda@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f19b29b90fe1d0126fa8f5cd0e7c8d7da07e5a34.1793870900.git.wutengda@huaweicloud.com>

On 2026-11-05 09:30:44 [+0000], Tengda Wu wrote:
> perf_sigtrap() contains:
> 
> 	WARN_ON_ONCE(event->ctx->task != current)
> 
> The warning assumes that an event's ctx->task always matches the task
> that ends up running the pending task_work. That assumption can be
> broken by the context fast-swap path.
> 
> The failure sequence is:
> 
>   1. A -> B switch, perf_event_context_sched_out() takes the fast path
>      and does WRITE_ONCE(ctx->task, next) / WRITE_ONCE(next_ctx->task, task).
>      An NMI then hits while the context is swapped, and
>      __perf_event_overflow() queues pending task_work on the *current*
>      task (A), even though the event now belongs to B's swapped-in
>      context view.
> 
>   2. B -> A switch. Because A now has pending task_work,
>      nr_no_switch_fast is non-zero, so the slow path is taken and
>      ctx->task is *not* swapped back.
> 
>   3. A returns to user mode, task_work runs perf_pending_task() ->
>      perf_sigtrap(), and event->ctx->task no longer equals current,
>      tripping the WARN_ON_ONCE().
> 
> The context fast-swap path was already excluded for events that need
> stable task association (inherit + sample read). sigtrap events have
> the same requirement: the SIGTRAP is targeted at ctx->task and must not
> be delivered after ctx->task has been swapped to another task.
> 
> Fix this by also excluding events with attr->sigtrap from the fast-swap
> path, i.e. bump nr_no_switch_fast for sigtrap events in
> list_add_event()/list_del_event(), and update the comment describing
> the invariant accordingly.
> 
> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  include/linux/perf_event.h | 6 ++----
>  kernel/events/core.c       | 9 +++++++--
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1999,7 +1999,7 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
>  		ctx->nr_user++;
>  	if (event->attr.inherit_stat)
>  		ctx->nr_stat++;
> -	if (has_inherit_and_sample_read(&event->attr))
> +	if (has_inherit_and_sample_read(&event->attr) || event->attr.sigtrap)
>  		local_inc(&ctx->nr_no_switch_fast);

This is already done in __perf_event_overflow() while the event is
added. You are saying this is not enough/ too late. This is required to
be done/ disabled once the event is created if I understand it.
If so, do we need to keep this nr_no_switch_fast inc/dec in
__perf_event_overflow() and perf_pending_task()?

Sebastian
