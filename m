Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4D239E69;
	Tue, 13 May 2025 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129513; cv=none; b=MurC9P5I4jQYFWxIPYLStMnEyCdPoydipLUjuHbB05AfD8ZFCA5hLoyPtBx4J+p1NFsojEocg7JzqKYltX1dcqLPRbvrrxdOR+KRF23I963ienuBt325ZgaTXtAeiMugqmttq9xCAbG1klPm5zLuBEDA4nB6nVmRi7cCmqECg18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129513; c=relaxed/simple;
	bh=I7JaZ41hf/htywx5pTWq7vDUrufPp85duFJ03C8Dmrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFK8CwpV8wgg9okZeYN+XDvPBrnEBENUeKEf6tNfh4RtMq33vv5wXTtHFWNLw5Kf3EQ9e/P164HmkKRMozrRozyy5DoC1mXXnKvuiyS+/v8zmoLL2hPjKSlsNN5BNEp1roaZiQHQdsZm0cVWgjLZvylDVNZXUe1VGJXsvbs/lSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PL9SDbIH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PL9SDbIH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x5+g6d7XPTGAlybbl9Ds8O9lbakg1efgSmPKp4nQSwo=; b=PL9SDbIHbfaN2X6gHkVWt47E6c
	9pESVCl45itoadwR28C6OpTtyRNAGiCaii3FzFWNUj8YUZsywLJhTpjsk72qBMPociWZq5cZ9bApa
	H4pGkLePvjqQK9KC2CSCwmr0YXtb+go9GdKT2D+vHJmw1uPDxRz6V8NcEgVixECZwrY6srjHIrfKV
	585VcCALMfY3Try9Hx22k2yfVclwh2HBBe/A/atkVIiK/GgHmxRRPPyMeYdZp/1wDdn5MIu7GbfyA
	dtNbhUPIY/daSvYJ4nMRqBMNipKyxgjmi+w1uxNIuPj4Xte+IPoPc3SAaV2a7UvWEaA5eemQ5TWZb
	ZQzb5mIg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uEmCA-0000000GuDH-1WH7;
	Tue, 13 May 2025 09:45:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E2AD530066A; Tue, 13 May 2025 11:45:05 +0200 (CEST)
Date: Tue, 13 May 2025 11:45:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, namhyung@kernel.org, irogers@google.com,
	mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, eranian@google.com,
	ctshao@google.com, tmricht@linux.ibm.com
Subject: Re: [RFC PATCH 01/15] perf: Fix the throttle logic for a group
Message-ID: <20250513094505.GD25891@noisy.programming.kicks-ass.net>
References: <20250506164740.1317237-1-kan.liang@linux.intel.com>
 <20250506164740.1317237-2-kan.liang@linux.intel.com>
 <20250513094155.GD25763@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513094155.GD25763@noisy.programming.kicks-ass.net>

On Tue, May 13, 2025 at 11:41:55AM +0200, Peter Zijlstra wrote:
> On Tue, May 06, 2025 at 09:47:26AM -0700, kan.liang@linux.intel.com wrote:
> 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index a84abc2b7f20..eb0dc871f4f1 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2734,6 +2734,38 @@ void perf_event_disable_inatomic(struct perf_event *event)
> >  static void perf_log_throttle(struct perf_event *event, int enable);
> >  static void perf_log_itrace_start(struct perf_event *event);
> >  
> > +static void perf_event_group_unthrottle(struct perf_event *event, bool start_event)
> > +{
> > +	struct perf_event *leader = event->group_leader;
> > +	struct perf_event *sibling;
> > +
> > +	if (leader != event || start_event)
> > +		leader->pmu->start(leader, 0);
> > +	leader->hw.interrupts = 0;
> > +
> > +	for_each_sibling_event(sibling, leader) {
> > +		if (sibling != event || start_event)
> > +			sibling->pmu->start(sibling, 0);
> > +		sibling->hw.interrupts = 0;
> > +	}
> > +
> > +	perf_log_throttle(leader, 1);
> > +}
> > +
> > +static void perf_event_group_throttle(struct perf_event *event)
> > +{
> > +	struct perf_event *leader = event->group_leader;
> > +	struct perf_event *sibling;
> > +
> > +	leader->hw.interrupts = MAX_INTERRUPTS;
> > +	leader->pmu->stop(leader, 0);
> > +
> > +	for_each_sibling_event(sibling, leader)
> > +		sibling->pmu->stop(sibling, 0);
> > +
> > +	perf_log_throttle(leader, 0);
> > +}
> 
> Urgh, this seems inconsistent at best.
> 
>  - unthrottle will set interrupts to 0 for the whole group
>  - throttle will set interrupts for leader
>    while the old code would set interrupts for event.
>  - interrupts was written with event stopped, while now you consistently
>    write when started
>  - both now issue perf_log_throttle() on leader, whereas previously it
>    was issued on event.
> 
> IOW
> 
> before:				after:
>  event stops			 leader MAX_INTERRUPTS
>  event MAX_INTERRUPTS		 event group stops
>  event logs			 leader logs
> 
>  event 0			 event group 0
>  event starts			 event group starts
>  event logs			 leader logs

Sorry, that should obviously be:

  event 0			 event group starts
  event starts			 event group 0
  event logs			 leader logs

