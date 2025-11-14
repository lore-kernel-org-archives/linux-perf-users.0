Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D478279DC0;
	Fri, 14 Nov 2025 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763107330; cv=none; b=oKQNfaORl7emQYA5E+TFftuLHLl0e/eUofRywyAzLduwCwR1rm2NZYb7xmv2vDsrNr4Kk6qqcYt4kIQCWkGXyvrrXKryq9dEz4kqER9UeQGHV3hbEC8EIgGI9IiTgMv4Wvm0tbEMkibgfNyPvVrPvAyDWzPGJHz80jNgNeCg7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763107330; c=relaxed/simple;
	bh=t8FvFDcwml7eN5Pu3DEI1yBsCR7WXaS/+SVQSnBwAfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3iqZ7woj40edc2FsVP/TzqPPfRIx52NbTjhHG6i0f0Gtm8P1EvLDb/odUXiFO6Ee6lVVW+nbdl6lAO6WRVJjEOlNBSnquRld+qWksTOThgTlXGjPv83xy0w9Lus0blxqDSXyeJx+ekCoTCLj4hW/ivR0frk3S8Puv9ajsoKons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2BhAnu9u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JP5OtxH5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2BhAnu9u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JP5OtxH5"
Date: Fri, 14 Nov 2025 09:02:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763107324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SrVOPdCwE2JO7jfKCTx6/W/Y6YwB9uSRmSqmI/gBK6M=;
	b=2BhAnu9ugHNFrVOTC9RiRVUBHhRZWk0iS1fwoyl9Bz1w0tDJeb5/lmZLoZe4Xtf5ivuASQ
	neoJMha7BPbacvIGi5icKQ+k7ckI5cb3d3LOHnNKg7+3pY8fR6AVKI2tKszJRc2gVSr2KC
	lT2CDbuM3q30+AGCYrClQDXi95IYbLtLTBT0bAEjAuI/GnMR1NuOaVTxFQxreqkQTSeSma
	zqsjpVDrO+tis5OwSGGxLnnOvP9Ef+4y3It8JpsFWwdCsfLPENH2Pj8H8hLbG+YAIu/4mR
	va/7XFoEyAPlyYbrbhaL3Kl+VKfVWqNOCOkH46/tssllTwbHOMs5DbCpGTL8mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763107324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SrVOPdCwE2JO7jfKCTx6/W/Y6YwB9uSRmSqmI/gBK6M=;
	b=JP5OtxH5m31dquP+yCpVVrPW2LYRHEKOwl+h91gi7IrjB6tpiEnkW10YKadi8t6WkJzi9v
	hmQx+fZJcBYO14BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Liangyan <liangyan.peng@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	zengxianjun@bytedance.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf/core: Fix pending work re-queued in
 __perf_event_overflow
Message-ID: <20251114080203.kFM7NGAU@linutronix.de>
References: <20251109164122.80138-1-liangyan.peng@bytedance.com>
 <20251114033349.3048-1-liangyan.peng@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251114033349.3048-1-liangyan.peng@bytedance.com>

On 2025-11-14 11:33:49 [+0800], Liangyan wrote:
> We got warning below during perf test.
> [  467.100914] [      T1] WARNING: CPU: 0 PID: 1 at kernel/events/core.c:5147 put_pmu_ctx+0x2ef/0x3c0
> [  467.107702] [      T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Kdump: loaded Tainted: G            E       6.18.0-rc4-dirty #114 PREEMPT(voluntary)
> [  467.109835] [      T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1
> [  467.111027] [      T1] RIP: 0010:put_pmu_ctx+0x2ef/0x3c0
> [  467.122081] [      T1] Call Trace:
> [  467.122463] [      T1]  <TASK>
> [  467.124822] [      T1]  __free_event+0x337/0xa50
> [  467.125306] [      T1]  perf_pending_task+0x10f/0x3b0
> [  467.125824] [      T1]  task_work_run+0x140/0x210
> [  467.127413] [      T1]  exit_to_user_mode_loop+0x10e/0x130
> [  467.127965] [      T1]  do_syscall_64+0x26d/0x2e0
> [  467.128453] [      T1]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  467.129025] [      T1] RIP: 0033:0x7f01d22349ca
> [  467.135157] [      T1]  </TASK>
> 
> A race condition occurs between task context and IRQ context when
> handling sigtrap tracepoint event overflows:
> 
> 1. In task context, an event is overflowed and its pending work is
>    queued to task->task_works
> 2. Before pending_work is set, the same event overflows in IRQ context
> 3. Both contexts queue the same perf pending work to task->task_works
> 
> This double queuing causes:
> - task_work_run() enters infinite loop calling perf_pending_task()
> - Potential warnings and use-after-free when event is freed in
> perf_pending_task()
> 
> Fix the race by disabling interrupts during queuing of perf pending work.
> 
> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
> Reported-by: Xianjun Zeng <zengxianjun@bytedance.com>
> Signed-off-by: Liangyan <liangyan.peng@bytedance.com>
> ---
> v3: Refine commit log suggested by Sebastian.

I assumed you get rid of the warning backtrace as it adds to value but
instead you added the whole thing including timestamps and so on.

> ---
>  kernel/events/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cae921f4d137..7c63e5fdd334 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10433,6 +10433,16 @@ static int __perf_event_overflow(struct perf_event *event,
>  
>  		notify_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
>  
> +		/*
> +		 * Task context queues the work via task_work_add() but has not yet
> +		 * set event->pending_work when the same event overflows in
> +		 * IRQ context. The IRQ path, seeing !event->pending_work,
> +		 * queues the work again.
> +		 * The double queuing causes corruption in task->task_works.

    The same event can be enqueued in TASK and IRQ context because
    assigning perf_event::pending_work is not atomic in regard to
    enqueue. task_work_add() does not prevent double enqueue.

The above should be enough if it is not self explained :)
However I did think that we have per-context events here. But it seems
those are not used in this case here.

> +		 * Prevent this by disabling interrupts around the critical section.
> +		 */
> +		guard(irqsave)();
> +
>  		if (!event->pending_work &&
>  		    !task_work_add(current, &event->pending_task, notify_mode)) {
>  			event->pending_work = pending_id;

Sebastian
