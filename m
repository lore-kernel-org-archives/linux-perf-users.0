Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA7C18DB04;
	Tue, 25 Feb 2025 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515807; cv=none; b=RetCtSdHn9RzwLfYWe/3c5VIOZeyqxtehYY9Pq+hF+F7qn8h0WNvsa2ML7mgZ2UA8IADgVhK9gc/VTc8tQX5GHZY6/79HsMuHnEJ8841G/wCP7wBuyniUIhinGksMbaZi6A4TLxAEcMN0FxHgaIngGdys5vUkPS4kcsEmvsTLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515807; c=relaxed/simple;
	bh=bBsSca7iPGoKC51DbyRKuTIoqdblhn5vEaotnZn1898=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnHjH7bnJjJyKO4E1Z5FISToJJ4p24yOA9dCM+5bhzH60aQkC22OMAR0o06+1ciA2rvJxOGsb/bIIzZNd9b6sFww3mGQn9yn7vbZNzkvoyot2mBqKgB3ugHlKXbWazm4hWiRVqnWROKyYykOtuAEQh+w14tJI26JlNnfZ4jOXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIXMuKf6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIXMuKf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD672C4CEDD;
	Tue, 25 Feb 2025 20:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740515806;
	bh=bBsSca7iPGoKC51DbyRKuTIoqdblhn5vEaotnZn1898=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIXMuKf6St13MvzpEG60kV3wue5KSI7lX03EQ/mLq6d9GN1AoPzuQjJve2DJAjNIJ
	 syeEBlNr98VOASB/mcvUGk2naiSHu65m/DkWtUdG4Dp1DYX4ZNUZqB1N5JaaloFlv6
	 nc1VYLS40dPYtQpS8o70/WPfs9MU+SyGX/oqULWasZAsExIwTS3jc2GoOCfPsJzYye
	 k0zM7B5WsJddaantrmPhKMBnGS1lLPbWNUQqo3mcdJZ/qFHJWdq8lFqNF5rYmpIYxC
	 ewWs+4PAEF24ybf4MyTN+d1MvhGw3ksAn5D/GmxDNAOd63VZPPC6JDaHfdL6VlapDn
	 CNSNjzqLHtUsg==
Date: Tue, 25 Feb 2025 21:36:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Yeo Reum Yun <YeoReum.Yun@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] events/core: fix acoount failure for event's
 total_enable_time
Message-ID: <Z74p1QaMdNKQRNeu@gmail.com>
References: <20241220100202.804062-1-yeoreum.yun@arm.com>
 <20241220133359.GC17537@noisy.programming.kicks-ass.net>
 <Z2V5s2JM4W7BRckR@e129823.arm.com>
 <20241220151414.GO11133@noisy.programming.kicks-ass.net>
 <Z2WMsnbFmqpEV5Pu@e129823.arm.com>
 <20241220153040.GP11133@noisy.programming.kicks-ass.net>
 <Z2WaC0CqSwU5Ux1B@e129823.arm.com>
 <20250110163643.GB4213@noisy.programming.kicks-ass.net>
 <GV1PR08MB105213E200ED463126D478DF1FBEF2@GV1PR08MB10521.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV1PR08MB105213E200ED463126D478DF1FBEF2@GV1PR08MB10521.eurprd08.prod.outlook.com>


* Yeo Reum Yun <YeoReum.Yun@arm.com> wrote:

> Hi Peter,
> 
> Sorry to late answer. I've missed your last repsonse in this thread,
> and waiting for in new thread:
> https://lore.kernel.org/all/20250110163643.GB4213@noisy.programming.kicks-ass.net/
> 
> > > This patch doesn't work when the event is child event.
> > > In case of parent's event, when you see the list_del_event(),
> > > the total_enable_time is updated properly by changing state with
> > > PERF_EVENT_STATE_OFF.
> > >
> > > However, child event's total_enable_time is added before list_del_event.
> > > So, the missing total_enable_time isn't added to parents event and the
> > > error print happens.
> > >
> > > So, I think it wouldn't be possible to update time with set_state.
> > > instead I think it should update total_enable_time before
> > > child's total_enable_time is added to parents' child_total_enable_time
> > >
> > > like
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 065f9188b44a..d27717c44924 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -13337,6 +13337,7 @@ static void sync_child_event(struct perf_event *child_event)
> > >         }
> > >
> > >         child_val = perf_event_count(child_event, false);
> > > +       perf_event_update_time(child_event);
> > >
> > >         /*
> > >          * Add back the child's count to the parent's count:
> >
> > Well, that again violates the rule that we update time on state change.
> > 
> > AFAICT there is no issue with simply moving the perf_event_set_state()
> > up a few lines in __perf_remove_from_context().
> >
> > Notably event_sched_out() will already put us in OFF state; and nothing
> > after that cares about further states AFAICT.
> >
> > So isn't the below the simpler solution?
> >
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2438,14 +2438,13 @@ __perf_remove_from_context(struct perf_e
> >                state = PERF_EVENT_STATE_DEAD;
> >        }
> >       event_sched_out(event, ctx);
> > +       perf_event_set_state(event, min(event->state, state));
> >       if (flags & DETACH_GROUP)
> >                perf_group_detach(event);
> >       if (flags & DETACH_CHILD)
> >                perf_child_detach(event);
> >        list_del_event(event, ctx);
> >
> > -       perf_event_set_state(event, min(event->state, state));
> > -
> >        if (!pmu_ctx->nr_events) {
> >                pmu_ctx->rotate_necessary = 0;
> 
> Agree, for DETACH_EXIT case, below code in list_del_event()
> doesn't need to be considered because
> the all of event related to event ctx would be freed:
> 
>      /*
>       * If event was in error state, then keep it
>       * that way, otherwise bogus counts will be
>       * returned on read(). The only way to get out
>       * of error state is by explicit re-enabling
>       * of the event
>       */
>       if (event->state > PERF_EVENT_STATE_OFF) {
>           perf_cgroup_event_disable(event, ctx);
>           perf_event_set_state(event, PERF_EVENT_STATE_OFF);
>       }
> 
> With your suggestion, Could I send the v4 for this?

Yes, please send a -v4 version.

Thanks,

	Ingo
