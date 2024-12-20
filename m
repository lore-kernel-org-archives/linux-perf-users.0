Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD11B217659;
	Fri, 20 Dec 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708648; cv=none; b=enmXabPE6cM8+/0BmgmT+suPJsyW3uxne8IBPOBBPYpblV2Vd49JvXF7SibRv9fkYEcyAZc0EKQKc7hWDwjIx4XXnSrj7aorfdiMnTEUfxmA2kMyAGxvegw9Ei8+k1CrC8gHnUBes1F0mzO2FrE8cWb+JZtK7QM9gsVZQPncVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708648; c=relaxed/simple;
	bh=tdDD6UCXH5j1bsOuSIvYvaOgRIaBkb4exCJWI38jVCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn5AmnT4aMnoRTqgcNGA1jBryK296taaKypDg1HgHWTK8XodflJIsdWCP37woGEimSqYXrKEM6VdFQnHlJof3gYHkfFZ2Ko/wiYwwKDfc9lnTxRLlYtnwLCvIf2TmKkUxPdW4uLQowZcSzec60VUXeuUk2tFPxfEtxTXewOKQSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A3tqoy7l; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A3tqoy7l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AGI8O9Sne2Jz6QxzLbOPT6Y+rSbNOVcddC2jFEA6Prc=; b=A3tqoy7lxJmhnWCFP13nXsNi0P
	LCYvFXYDV2UKAEEkj2EGtBnorqQO+GuocHaESgXiSy9YHAhLfqL0J4XNbs9/svNLQ6/nvRWMehc4q
	69rmjg3RszdGLLLuXtMrdwNK27aQS40GD3MCr4wXef7TyYng+Gp9m0GMwYGEztnvtXjn/JUBUWTr1
	x2g1vvVMUMpmpdm57vOjKbKN8opovmk7AKmJ2CExH3Eno7rhj/1jwMQp/WGxWX4F6hk+rc0hTlAft
	b77Twf98pCfzTaLc5cVP5t9NxMCfxoVpEAVqrFsotxkggNCNxDT6FMuQsm5Z39V9Hrh9SHMusucgs
	xAe5cyCA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOexd-00000001NXa-0dS3;
	Fri, 20 Dec 2024 15:30:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E9F643003FF; Fri, 20 Dec 2024 16:30:40 +0100 (CET)
Date: Fri, 20 Dec 2024 16:30:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] events/core: fix acoount failure for event's
 total_enable_time
Message-ID: <20241220153040.GP11133@noisy.programming.kicks-ass.net>
References: <20241220100202.804062-1-yeoreum.yun@arm.com>
 <20241220133359.GC17537@noisy.programming.kicks-ass.net>
 <Z2V5s2JM4W7BRckR@e129823.arm.com>
 <20241220151414.GO11133@noisy.programming.kicks-ass.net>
 <Z2WMsnbFmqpEV5Pu@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2WMsnbFmqpEV5Pu@e129823.arm.com>

On Fri, Dec 20, 2024 at 03:26:42PM +0000, Yeoreum Yun wrote:

> > OK, how's this then?
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 065f9188b44a..d12b402f9751 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2422,6 +2422,7 @@ __perf_remove_from_context(struct perf_event *event,
> >  {
> >  	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
> >  	unsigned long flags = (unsigned long)info;
> > +	enum perf_event_state state = PERF_EVENT_STATE_OFF;
> >
> >  	ctx_time_update(cpuctx, ctx);
> >
> > @@ -2438,7 +2439,9 @@ __perf_remove_from_context(struct perf_event *event,
> >  		perf_child_detach(event);
> >  	list_del_event(event, ctx);
> >  	if (flags & DETACH_DEAD)
> > -		event->state = PERF_EVENT_STATE_DEAD;
> > +		state = PERF_EVENT_STATE_DEAD;
> > +
> > +	perf_event_set_state(event, state);
> >
> 
> It works. but what about this?
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 065f9188b44a..71ed8f847b04 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2432,6 +2432,7 @@ __perf_remove_from_context(struct perf_event *event,
>         if (flags & DETACH_DEAD)
>                 event->pending_disable = 1;
>         event_sched_out(event, ctx);
> +       perf_event_update_time(event);
>         if (flags & DETACH_GROUP)
>                 perf_group_detach(event);
>         if (flags & DETACH_CHILD)

Well, the rule is that timekeeping is tied to state change. And as you
can see __perf_remove_from_context() violates that.

Probably because someone (probably me) figured that the event would not
be observed again after detach or something like that.

