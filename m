Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6381212FA5;
	Fri, 10 Jan 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527015; cv=none; b=SPPtbT4+pZ/PbL+P+PeBG1qbzhjGXTrkJoQq6YoNWNsL27OC26cVKWeodd+XGWGEfld4dRC1p4Ur/u+QyJbzMQFCy8v0BB2C4YeDZTujbrtqND6kfD79N3x3smz92u3XZJPim+EaTcwPmubNq0G85DykrBQFxExe5OCRy8YXvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527015; c=relaxed/simple;
	bh=ZCz2+pC6wLKON9YoJBTXeQ2XJ07nJo7hwotg/rvW/Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qoi4cdMRqMM/2+b467Wy2O/fC4KYTheG/CTG9b5qdaafnTbH64M+lvimzsTXaXDXGkMUb1CZ83LQSl+c0mx2pmZwzjzSWmaMxCm3ImElLCMjnGIikkQKd1vcF45ILIe/sBZM64lHsVFQpxpKykx77o+Ol+Ohllwpitd/R9YpBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ap6+aCH+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ap6+aCH+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MtkPXuoXZ/migsqLj0B9GrKUfhi1/7J050hLg/XKFhg=; b=ap6+aCH+947YwvbbMBWJGoIkop
	sgoq6ZOUWzjwZqHP9qhr/02OiV9z7CTVpus2cZwk04zhYW5HLY354heuRKnBOgml715Obbq+iQ+jR
	nw4kvTnbPZLP60YWjFX70LByZSq7w/2lrs9Nve0IgfnHAqzA0jXVj9UG8xXJujKLD69MUNsR25obe
	5+LnOwUlLjqa+kVrvIdEkqUPGyHcAdkc7JALa6qnIlHTMOyKdchmMhD3gYlXUKJ3diu3W/kFHKB9G
	4BVx4QBrXvnDh8R05Gz52LfVAB+uRye3+S5VrZ2L+ycZdrg/68AV6L5Lis1H2nPrOkDz4m7Ft/a5P
	tAxCIpnA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tWI04-00000009qDF-38eC;
	Fri, 10 Jan 2025 16:36:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CFA153005D6; Fri, 10 Jan 2025 17:36:43 +0100 (CET)
Date: Fri, 10 Jan 2025 17:36:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] events/core: fix acoount failure for event's
 total_enable_time
Message-ID: <20250110163643.GB4213@noisy.programming.kicks-ass.net>
References: <20241220100202.804062-1-yeoreum.yun@arm.com>
 <20241220133359.GC17537@noisy.programming.kicks-ass.net>
 <Z2V5s2JM4W7BRckR@e129823.arm.com>
 <20241220151414.GO11133@noisy.programming.kicks-ass.net>
 <Z2WMsnbFmqpEV5Pu@e129823.arm.com>
 <20241220153040.GP11133@noisy.programming.kicks-ass.net>
 <Z2WaC0CqSwU5Ux1B@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2WaC0CqSwU5Ux1B@e129823.arm.com>

On Fri, Dec 20, 2024 at 04:23:39PM +0000, Yeoreum Yun wrote:

> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 065f9188b44a..71ed8f847b04 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -2432,6 +2432,7 @@ __perf_remove_from_context(struct perf_event *event,
> > >         if (flags & DETACH_DEAD)
> > >                 event->pending_disable = 1;
> > >         event_sched_out(event, ctx);
> > > +       perf_event_update_time(event);
> > >         if (flags & DETACH_GROUP)
> > >                 perf_group_detach(event);
> > >         if (flags & DETACH_CHILD)
> >
> 
> This patch doesn't work when the event is child event.
> In case of parent's event, when you see the list_del_event(),
> the total_enable_time is updated properly by changing state with
> PERF_EVENT_STATE_OFF.
> 
> However, child event's total_enable_time is added before list_del_event.
> So, the missing total_enable_time isn't added to parents event and the
> error print happens.
> 
> So, I think it wouldn't be possible to update time with set_state.
> instead I think it should update total_enable_time before
> child's total_enable_time is added to parents' child_total_enable_time
> 
> like
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 065f9188b44a..d27717c44924 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13337,6 +13337,7 @@ static void sync_child_event(struct perf_event *child_event)
>         }
> 
>         child_val = perf_event_count(child_event, false);
> +       perf_event_update_time(child_event);
> 
>         /*
>          * Add back the child's count to the parent's count:

Well, that again violates the rule that we update time on state change.

AFAICT there is no issue with simply moving the perf_event_set_state()
up a few lines in __perf_remove_from_context().

Notably event_sched_out() will already put us in OFF state; and nothing
after that cares about further states AFAICT.

So isn't the below the simpler solution?

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2438,14 +2438,13 @@ __perf_remove_from_context(struct perf_e
 		state = PERF_EVENT_STATE_DEAD;
 	}
 	event_sched_out(event, ctx);
+	perf_event_set_state(event, min(event->state, state));
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
 
-	perf_event_set_state(event, min(event->state, state));
-
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
 
