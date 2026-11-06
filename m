Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961648;
	b=GfZSYyeGJ8uRljk6KtMVK3CvJaca/DsH6gogFWbrtAKvGzFu7hoLd/m+fa9ke1Hobank
	 HdzyoJErpfuHrNKjVXftmw5ekIk/hZoq8nxttOIZg8iNCiOiifU9cK+D7NAm9yq/x1HYx
	 /X1dVesclEDh6yXL2kASHX7AxvmQReG3mBvTcwDZ2qCZL7iS5Lv5vV5GMIAOu5tdC0E+s
	 31ODh/W+cidVDvFuy2N8FefhI7e0y+abYa7mhXb9fjNmPZqGdwgYEbuIjaEcwcpk78wsa
	 b4tCC/kkZ5KR1dhA0spJ+oo/GSayQnIw8C0FqR6YJMbTlWbcfw9h9HR4cnmYiX1ZT7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961648;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BE8UiToIGa+BlLQ4NfiXGDJ1iS7fTidQ2pO9YczIG6U=;
	b=32m2etbL2RItpn3l4eHucW3WtYvTxnMPZ5Nn8msDhrs2CFUV+F/DsR6T3SC3SXn6DSdx
	 2K30XgxN1b23+8c3lEtmKZ8NFFsBejPhnjNAYTAg3XYoos75u6+9tcIVfVySf0DIxcfRZ
	 y8j3NzWIll7V/lfgqIxg7TUp+xOXMLQn5RkF+O9+JqaU0JYRhnrYxgtdom2bMOiV55gTk
	 SxNhdwnSUn6KynlVYL7SbCP5M3EJG+1vVMSk1yERpn3xTfAQypUBWrPAhvxBNZp4eMhOe
	 KRS7Ji+Q3Smc4cKDRBFGQTnvWycxYjFNqhb+kwangeKZKMPwhtxJmyjy/xBvAY77/vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qZSK4yK2;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF5D606A326;
	Fri,  6 Nov 2026 10:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF5D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qZSK4yK2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BE8UiToIGa+BlLQ4NfiXGDJ1iS7fTidQ2pO9YczIG6U=; b=qZSK4yK2/g7EUz25pvBahAGT28
	SYyPvMiULZnA5qTNqaazupU2LJCffXAzoeK6TE7HxkOJiujCIs89l1EU4v4CSy3N8rm0MgP8c3HIO
	y2nxfRAV6Cvc45EBOvolwVWggR2AG7RSO+gNyKnuYwIdPSRA/UuvoCZgnvMT8jI1/vWI004gixwZo
	URp+JXqoeloyFeazulbwHo33k01C13+AH7D/GbCSbq80PnEj7e7R0iKHIeNiNRnEMTL7+B+uJVXKc
	/4KkpE0LL5scGnqfc7HVgvXGeYhJB92llaVhg7tbccan0Gs82UObGY7/woT/3ZGyT63hRKzhFVdf/
	0cZ76WmQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHNE-000000047AQ-2SLy;
	Fri, 06 Nov 2026 10:40:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 872BC300882; Fri, 06 Nov 2026 11:40:43 +0100 (CET)
Date: Fri, 6 Nov 2026 11:40:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Phat Dinh <phatdt1116@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	security@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: Do not resurrect cpuctx->cgrp after last
 cgroup event exit
Message-ID: <20261106104043.GF1779021@noisy.programming.kicks-ass.net>
References: <20261106101642.494674-1-phatdt1116@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106101642.494674-1-phatdt1116@gmail.com>

On Fri, Nov 06, 2026 at 05:16:42PM +0700, Phat Dinh wrote:
> perf_cgroup_switch() relies on:
> 
>     /*
>      * cpuctx->cgrp is set when the first cgroup event enabled,
>      * and is cleared when the last cgroup event disabled.
>      */
> 
> It computes the next task's cgroup, schedules out the CPU context and
> then assigns cpuctx->cgrp unconditionally:
> 
>     ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
>     /*
>      * must not be done before ctxswout due
>      * to update_cgrp_time_from_cpuctx() in
>      * ctx_sched_out()
>      */
>     cpuctx->cgrp = cgrp;
> 
> However, ctx_sched_out() can disable events itself. If a cgroup event
> has a pending disable from perf_event_disable_inatomic() (e.g. its
> PERF_EVENT_IOC_REFRESH limit ran out) that the irq_work has not
> handled yet, event_sched_out() consumes it inline:
> 
>     if (event->pending_disable) {
>         event->pending_disable = 0;
>         perf_cgroup_event_disable(event, ctx);
>         state = PERF_EVENT_STATE_OFF;
>     }
> 
> If that was the last cgroup event, perf_cgroup_event_disable() clears
> cpuctx->cgrp:
> 
>     if (--ctx->nr_cgroups)
>         return;
> 
>     cpuctx->cgrp = NULL;
> 
> and perf_cgroup_switch() then sets it again. cpuctx->cgrp is left
> non-NULL with ctx.nr_cgroups == 0, so the NULL check in
> perf_cgroup_switch() no longer catches it and the next switch trips:
> 
>     WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
> 
> cpuctx->cgrp does not hold a reference on the cgroup. Once that cgroup
> is removed, the next ctx_sched_in() dereferences the stale pointer:
> 
>   BUG: KASAN: slab-use-after-free in ctx_sched_in+0xb1f/0xfa0
>   Read of size 8 at addr ffff8881008972d0 by task swapper/3/0
> 
>   Tainted: [W]=WARN
>   Call Trace:
>    <IRQ>
>    ctx_sched_in+0xb1f/0xfa0
>    perf_event_sched_in+0x1a/0x70
>    ctx_resched+0x32b/0xac0
>    __perf_install_in_context+0x475/0xab0
>    remote_function+0x105/0x200
>    __flush_smp_call_function_queue+0x179/0x8d0
>    __sysvec_call_function_single+0x1b/0x1c0
>    sysvec_call_function_single+0x66/0x80
>    </IRQ>
>    <TASK>
>    asm_sysvec_call_function_single+0x1a/0x20
> 
> Only assign cpuctx->cgrp when cgroup events remain after the context
> has been scheduled out, so that it stays NULL as the invariant
> requires.
> 
> Fixes: e19cd0b6fa59 ("perf/core: Always set cpuctx cgrp when enable cgroup event")
> Cc: stable@vger.kernel.org
> Signed-off-by: Phat Dinh <phatdt1116@gmail.com>

Indeed, thanks!

> ---
>  kernel/events/core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f36a3bbaa33c..54b87584c752 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1072,8 +1072,13 @@ static void perf_cgroup_switch(struct task_struct *task)
>  	 * must not be done before ctxswout due
>  	 * to update_cgrp_time_from_cpuctx() in
>  	 * ctx_sched_out()
> +	 *
> +	 * ctx_sched_out() can consume a pending disable and drop the last cgroup
> +	 * event, which clear the cpuctx->cgrp. Cgroup tracking follow active cgroup
> +	 * event, so do not resurrect it
>  	 */
> -	cpuctx->cgrp = cgrp;
> +	if (cpuctx->ctx.nr_cgroups)
> +		cpuctx->cgrp = cgrp;
>  	/*
>  	 * set cgrp before ctxsw in to allow
>  	 * perf_cgroup_set_timestamp() in ctx_sched_in()
> 
> base-commit: d095321349222961813333277881b3c74f10b17b
> -- 
> 2.56.0
> 
