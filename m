Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9815820C;
	Wed, 12 Mar 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772400; cv=none; b=dfkYaeot+WArRa7D83qlmvI4lrnHlYXXNYtNtZTvugrbgqwIWKF8VfHPOkUEU3Hf+LBWdCBFQ0+TbUaXRbuTULYZs1IwHwt+6+EbtoU2rSHTooeFieJTCjHmIJ3868TJqsEIKXTmFYjU+nY7pk05E/I/+0er3XmLF84FAcqV6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772400; c=relaxed/simple;
	bh=o7M7fRkbCHIKzerwL4wLRbTmeINyNYlXBbL4qCtA+Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwmAtg5b9ibwCBwhwuNa5VYzSeHUjZsY8K5VYZxxnFm9IU2sLiBPi6L/a9oW3k2Q5JP2I5/4rPJxOZ4mAF3ZFwpehWLsuN7q45DhNwLAosfDunWTTjZlMp5CL1FUsrJ+dp9BUw0Hpz8ad671NTFL9y53wct25BWZNwbQeeaCW14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BvNigwEp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BvNigwEp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+guXa85l4m8374ZSaIhSq5yBVp6GHqv8PZJqOh4Sv24=; b=BvNigwEpbh0bCumOLG+Vr9+/dk
	qERJ6KukgwmSyjlHyfkaf82Cu43ZP2iuXg6fWsMR8W0ezR7O5Zbs5zFk3CYTMvgppOfEEmAHfb69c
	C0n7Pqh9tWHAAnpl3bZwGnZu201gAg2KlarWBKJJYeo9loxXOh8gIxVBIcpqXjtEmP6MsPDrL5SqL
	GLiXzMDEiP+UXH2DfHyqTUjFpjWtxJ5mDQ6XHra1VmBfqx0v+y6h5SOteD+NSr9Vr61fOtas9GwGH
	elVbDYnyE0JQwM22kIc9rb47dPOZtS6TgI8qoGaFVRPbeQrPPzHeaQKi5T1We2oOVeUZvqmufS1UX
	IMrUSSuQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsIZ3-00000002LRo-0MO4;
	Wed, 12 Mar 2025 09:39:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0A096300599; Wed, 12 Mar 2025 10:39:48 +0100 (CET)
Date: Wed, 12 Mar 2025 10:39:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Barnett <mark.barnett@arm.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, ben.gainey@arm.com, deepak.surti@arm.com,
	ak@linux.intel.com, will@kernel.org, james.clark@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/5] perf: Allow adding fixed random jitter to the
 alternate sampling period
Message-ID: <20250312093947.GJ19424@noisy.programming.kicks-ass.net>
References: <20250307202247.648633-1-mark.barnett@arm.com>
 <20250307202247.648633-4-mark.barnett@arm.com>
 <20250311113128.GD19424@noisy.programming.kicks-ass.net>
 <431a5acb-4906-4095-8dec-b2d824adaac6@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431a5acb-4906-4095-8dec-b2d824adaac6@arm.com>

On Tue, Mar 11, 2025 at 05:22:16PM +0000, Mark Barnett wrote:

> > @@ -9979,6 +9985,8 @@ static int __perf_event_overflow(struct perf_event *event,
> >   				 int throttle, struct perf_sample_data *data,
> >   				 struct pt_regs *regs)
> >   {
> > +	struct hw_perf_event *hwc = &event->hw;
> > +	u64 sample_period;
> >   	int events = atomic_read(&event->event_limit);
> >   	int ret = 0;
> > @@ -9989,15 +9997,50 @@ static int __perf_event_overflow(struct perf_event *event,
> >   	if (unlikely(!is_sampling_event(event)))
> >   		return 0;
> > -	ret = __perf_event_account_interrupt(event, throttle);
> > +	/*
> > +	 * High Freq samples are injected inside the larger period:
> > +	 *
> > +	 *   |------------|-|------------|-|
> > +	 *   P0          HF P1          HF
> > +	 *
> > +	 * By ignoring the HF samples, we measure the actual period.
> > +	 */
> > +	if (!(hwc->state & PERF_HES_HF_SAMPLE))
> > +		ret = __perf_event_account_interrupt(event, throttle);
> 
> The high-frequency samples should still contribute to interrupt
> accounting/throttling, right? We'd just need to put guards around the
> adaptive period stuff so that HF samples don't contribute to the frequency
> training.

Yeah, I suppose it should. This means breaking up that function but that
isn't hard.
