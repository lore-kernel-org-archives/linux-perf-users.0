Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49F547041;
	Fri, 18 Sep 2026 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722587; cv=none; b=ewT7/gzR0YqvsjbtI16EEE5tq96zDpVcGZJJlUueZKIUP8Pd6jK+CFWg7QzvDbprtCd9P5ePPiicoe19pBhK7ZLr5nF34QM6irMoKhiBXHLJGcq6muilyXXVCt1sNMPgrTmL4ofZaF27KARDNCP2Vvbv+11V/ZTRzRQKEgXWKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722587; c=relaxed/simple;
	bh=Buqk4YxB+nB9KLf/J7geKMOB6v7b+g4gxwNggtOsDyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noo4TiA84sD190DKKbGgU9hKMh73hryR/NIKhgmVsT9XO7GcfO6n1aAiN7keCtYOnwZHEyLyQKqebLz1/bHW9JV7Lqbh9ZOUMfBPksx2IKgEj7SOFa1zLhxG+MS5xKki5zyxmNXXrXPcVnw7ovGzFlDi8A4JTE+aZMhxx9Lazz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h1mj5cUa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h1mj5cUa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=z2FtHOSqaJj9DQ9TcDQ+kVbXa3NOo5MG8WgN9i1D1GI=; b=h1mj5cUaNdkYe2X/0lLzikUplp
	ZomURzXqLslHFxqOBy1BepJHVNVJVn1Ww0GFGBK6Qqh5WmARotM5w7LVNzuROseAwVTg2pkb3Okkx
	fxJlXWtRR9ULqG/Ab1ZP5/fHMddB3JasIkCPSZzXReAu96M3vWz9QzBOjK1XCedWjprQVHhOp10t/
	DxUNF1owMde5DxA5DGyP81IL13SS/RWHCYq1Odh1zEF782lY3kLd+SML8dZ/juUHKIski53OtEHtp
	k+h+J2HVAMiTmrM2bu50Kk3NxkVyZTu4CnEHtUgifisoU8UQT3fuLc5HlufqP4dj0JGK0Hp75p18a
	On1rZ5lw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Ub6-0000000Gdt4-3cmg;
	Fri, 18 Sep 2026 09:09:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7949930057F; Fri, 18 Sep 2026 11:09:31 +0200 (CEST)
Date: Fri, 18 Sep 2026 11:09:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Belgaumkar, Vinay" <vinay.belgaumkar@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH 2/2] perf: Add checks to prevent null ptr access
Message-ID: <20260918090931.GK1837346@noisy.programming.kicks-ass.net>
References: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
 <20260904181625.1394082-2-vinay.belgaumkar@intel.com>
 <20260917083951.GC2009045@noisy.programming.kicks-ass.net>
 <e5e1d901-9cb8-44b0-a897-da48f12268bf@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5e1d901-9cb8-44b0-a897-da48f12268bf@intel.com>

On Thu, Sep 17, 2026 at 01:10:15PM -0700, Belgaumkar, Vinay wrote:
> 
> On 9/17/2026 1:39 AM, Peter Zijlstra wrote:
> > On Fri, Sep 04, 2026 at 11:16:25AM -0700, Vinay Belgaumkar wrote:
> > > Sashiko recommended some additional checks to prevent null pointer
> > > access. Check for revoked states inside perf_event_read_local(), as
> > > the pmu event may have already been freed at this point. Add a null
> > > check inside __perf_event_read_cpu() as well before accessing the pmu
> > > ptr.
> > > 
> > > Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > > Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> > > ---
> > >   kernel/events/core.c | 12 +++++++++++-
> > >   1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 7777e82aad5e..059f82f0cadd 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -4788,14 +4788,19 @@ static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int
> > >   static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
> > >   {
> > > +	struct pmu *pmu = READ_ONCE(event->pmu);
> > >   	int local_cpu = smp_processor_id();
> > >   	u16 local_pkg, event_pkg;
> > >   	if ((unsigned)event_cpu >= nr_cpu_ids)
> > >   		return event_cpu;
> > > +	if (!pmu)
> > > +		return -ENODEV;
> > > +
> > >   	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
> > > -		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
> > > +		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope,
> > > +										event_cpu);
> > >   		if (cpumask && cpumask_test_cpu(local_cpu, cpumask))
> > >   			return local_cpu;
> > > @@ -4917,6 +4922,11 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
> > >   		goto out;
> > >   	}
> > > +	if (READ_ONCE(event->state) <= PERF_EVENT_STATE_REVOKED) {
> > > +		ret = -ENODEV;
> > > +		goto out;
> > > +	}
> > > +
> > >   	/*
> > >   	 * Get the event CPU numbers, and adjust them to local if the event is
> > >   	 * a per-package event that can be read locally
> > I don't think any of this is right.
> > 
> > When unregistered, the event is de-scheduled, this means event->oncpu
> > will be -1, therefore __perf_event_read_cpu() will already exit early.
> > 
> > And perf_event_read_local() will then already do the right thing, by
> > returning the old value.
> > 
> > So AFAICT, there is nothing to fix here.
> 
> yeah, I think this was more of a defensive fix which Sashiko suggested-
> 
> CPU A                                                  CPU B
> 
> perf_event_read_local                     ...
> 
> __perf_event_read_cpu                  perf_pmu_unregister
> 
> I don't think it is easy to repro this situation, but there is a theoretical
> possibility of a race between these two functions. I don't think even the
> changes above can guarantee to work in any case. We can drop this second
> patch if that is the case.

perf_event_read_local() has IRQs disabled, perf_pmu_unregister() will
eventually have to de-schedule the event, which involves IPIs.

If you have IRQs disabled, those IPIs will wait.

IOW, as long as you have IRQs disabled, your event->oncpu is stable,
provided of course that event->cpu is the local CPU, otherwise having
called perf_event_read_local() was a bug in the first place.

Hmm... I think I see a problem though.

The verification of that last condition, it being a local event. That
uses event->cpu as argument to __perf_event_read_cpu(), and that *can*
indeed hit the pmu.

I'm thinking __pmu_detach_event() should probably clear
PERF_EV_CAP_READ_SCOPE or something from all the
event->{event,group}_caps fields.
