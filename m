Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B51FC0E2;
	Thu,  5 Jun 2025 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749108974; cv=none; b=kCd/wqab07OeaCTxOBdjnEKLut+JlxCt4xnkqC3dUtCHIo22x5kQ/VbTsmpddIzfGUJxXzleFlLBr1nD/owbVfADDjFGpCkAQW3ZBmSrVG8pLmQhQvPv/4xXgUanbwe9Nbbni2aHBZjjbgxBZtBQHgmFCF0mOXKChNNGVBEmVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749108974; c=relaxed/simple;
	bh=lPSk1zTgBjw5dlObECTVLPMDmMod2obRq9c4037H3KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRh+Gq4NcfQu1a6E4+mB2L90/k3wLgut7DPaDvH3ZJnMPaGeZEztmgpoU4QOoWplGSmxixHicHvpqnDrY4/8WVmRrS3v9oQloPn8Q2Wga6TskAzlUBGug5+Vfv+xK0IAwxsNAq68xJRN6Hxrdfv9FLylH296L/vNOp54uxSFUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oRRIjfmH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oRRIjfmH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aqIUgY4IbWVDJNz7BT6PJBOfARTAlq5AqNMDaZOs/Wk=; b=oRRIjfmHBor+Ye/jJINWRyTiNs
	RpBrGaJBfJPy+oVDmcX9OdGUOlNyERPVr8qimqU8RwyG8PEW7xivQmJEI+Z/7Ytnhx7/c7ICW0JO9
	NIfAwDyvnCAJrpnJwvAKa8lZ29bl5S9eIXLK2o+49srhPd6UcW145iJed8HfivCV14wUuwVFcI1XR
	VSOrGn1BgzrjOrevr61t3Y1zr0doX4jCw6niJ7R/a5SHE+dwK+BAMBr9Pp2oippIKs5dEMuzBZr5g
	a5lcoBQp78fONlo5lTL5ZvBEY1DmiYTnuvUb/Y/Llax3NjOdwVoGndLH/3x5xG+Ybx4mJMi6G9jDW
	Vu2+Qz3Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN58r-00000003z5h-15DF;
	Thu, 05 Jun 2025 07:36:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F8FB3005AF; Thu,  5 Jun 2025 09:36:00 +0200 (CEST)
Date: Thu, 5 Jun 2025 09:36:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, davidcc@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf/core: Fix
 WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0) in perf_cgroup_switch
Message-ID: <20250605073600.GN39944@noisy.programming.kicks-ass.net>
References: <20250604033924.3914647-1-luogengkun@huaweicloud.com>
 <20250604033924.3914647-3-luogengkun@huaweicloud.com>
 <20250604100052.GH38114@noisy.programming.kicks-ass.net>
 <83d9c5e8-9c72-4ab8-a3ac-638e49691694@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d9c5e8-9c72-4ab8-a3ac-638e49691694@huaweicloud.com>

On Thu, Jun 05, 2025 at 11:55:03AM +0800, Luo Gengkun wrote:
> 
> On 2025/6/4 18:00, Peter Zijlstra wrote:
> > On Wed, Jun 04, 2025 at 03:39:24AM +0000, Luo Gengkun wrote:
> > > There may be concurrency between perf_cgroup_switch and
> > > perf_cgroup_event_disable. Consider the following scenario: after a new
> > > perf cgroup event is created on CPU0, the new event may not trigger
> > > a reprogramming, causing ctx->is_active to be 0. In this case, when CPU1
> > > disables this perf event, it executes __perf_remove_from_context->
> > > list _del_event->perf_cgroup_event_disable on CPU1, which causes a race
> > > with perf_cgroup_switch running on CPU0.
> > > 
> > > The following describes the details of this concurrency scenario:
> > > 
> > > CPU0						CPU1
> > > 
> > > perf_cgroup_switch:
> > >     ...
> > >     # cpuctx->cgrp is not NULL here
> > >     if (READ_ONCE(cpuctx->cgrp) == NULL)
> > >     	return;
> > > 
> > > 						perf_remove_from_context:
> > > 						   ...
> > > 						   raw_spin_lock_irq(&ctx->lock);
> > > 						   ...
> > > 						   # ctx->is_active == 0 because reprogramm is not
> > > 						   # tigger, so CPU1 can do __perf_remove_from_context
> > > 						   # for CPU0
> > > 						   __perf_remove_from_context:
> > > 						         perf_cgroup_event_disable:
> > > 							    ...
> > > 							    if (--ctx->nr_cgroups)
> > > 							    ...
> > > 
> > >     # this warning will happened because CPU1 changed
> > >     # ctx.nr_cgroups to 0.
> > >     WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
> > > 
> > > To fix this problem, expand the lock-holding critical section in
> > > perf_cgroup_switch.
> > > 
> > > Fixes: db4a835601b7 ("perf/core: Set cgroup in CPU contexts for new cgroup events")
> > > Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> > > ---
> > Right, so how about we simply re-check the condition once we take the
> > lock?
> > 
> > Also, take the opportunity to convert to guard instead of adding goto
> > unlock.
> > 
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -207,6 +207,19 @@ static void perf_ctx_unlock(struct perf_
> >   	__perf_ctx_unlock(&cpuctx->ctx);
> >   }
> > +typedef struct {
> > +	struct perf_cpu_context *cpuctx;
> > +	struct perf_event_context *ctx;
> > +} class_perf_ctx_lock_t;
> > +
> > +static inline void class_perf_ctx_lock_destructor(class_perf_ctx_lock_t *_T)
> > +{ perf_ctx_unlock(_T->cpuctx, _T->ctx); }
> > +
> > +static inline class_perf_ctx_lock_t
> > +class_perf_ctx_lock_constructor(struct perf_cpu_context *cpuctx,
> > +				struct perf_event_context *ctx)
> > +{ perf_ctx_lock(cpuctx, ctx); return (class_perf_ctx_lock_t){ cpuctx, ctx }; }
> > +
> >   #define TASK_TOMBSTONE ((void *)-1L)
> >   static bool is_kernel_event(struct perf_event *event)
> > @@ -944,7 +957,13 @@ static void perf_cgroup_switch(struct ta
> >   	if (READ_ONCE(cpuctx->cgrp) == cgrp)
> >   		return;
> > -	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> > +	guard(perf_ctx_lock)(cpuctx, cpuctx->task_ctx);
> > +	/*
> > +	 * Re-check, could've raced vs perf_remove_from_context().
> > +	 */
> > +	if (READ_ONCE(cpuctx->cgrp) == NULL)
> > +		return;
> > +
> >   	perf_ctx_disable(&cpuctx->ctx, true);
> >   	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
> > @@ -962,7 +981,6 @@ static void perf_cgroup_switch(struct ta
> >   	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
> >   	perf_ctx_enable(&cpuctx->ctx, true);
> > -	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> >   }
> >   static int perf_cgroup_ensure_storage(struct perf_event *event,
> 
> Thank for your review, I will make changes based on your suggestions.
> 

No need to resend. I've got your patch with modifications. But please
confirm it does work :-)
