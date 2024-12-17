Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1742A9B;
	Tue, 17 Dec 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467374; cv=none; b=ZyzkZm1GCOF5zLyS0NT+QX805CieQ5jELK3ak5p/oFPRINuGYDeX//m7NQpnOO+O7KePMFT5brx5u7hNv/KuPhdw8jGWETKucsJXJK9UakLziS5x0+lPAa8orGvABrckk7auPb2FGA8VJUkJxNFJa+Wiw2Rl/UuZut7Tl8TF0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467374; c=relaxed/simple;
	bh=eWeXh3padBIVZXFXGw3YT3LPGZ55w+pqerK1il1z0tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZpJaxUmx3TM3MJ0Pi6q97Jolri1PX9G/+hPn0550r9auUGFhZgLXvIi2XOqvuxTIkFS4i9MSt0a6aJVjC+F1ZCV3AqUjmFl+5+49dDtHSXl5xbGwIQYzCJDGZQ/8HWkCF+xKTLyV4PJTQXxZR7zBcU/h5FwwNGa8nWm0fJhcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jb2OFox3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jb2OFox3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9aP9Zr26Vzamj4jtRSpIPXMz4aO8AxXiYD0Uc3A2+XE=; b=jb2OFox3hZo7o9puh+LWtE5Jb3
	P6Al/CjbtuMEQocNsx6yVFICPnT1E51ZDaylvqpJLqeQ1+CrTLH747PwMhgo1d8z5aOcRRNz4Q8i7
	23kEnQSqwp6N2YK5Er+D/dn4bfz2Vmb1ar6qLilQ2BWRupaveCy45gF9/fPliUW90N5cjeMODEEzp
	6/Yfu7hnAbNfEKXN4EHmJlcghpkrg6dPzGfEzTOdqfs68sn93XZUadpLdeib88HN/GqW6ZHaOuduG
	ju4z2+a0wmm0LK6XVom3+iL3zUSNus7XnodFm1GzI4hEIkrRXiMj2kpKQCUepZtWwhRg1RncEP939
	2zTT/BVQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeC1-000000057tn-0ddm;
	Tue, 17 Dec 2024 20:29:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D92CD3003E1; Tue, 17 Dec 2024 21:29:19 +0100 (CET)
Date: Tue, 17 Dec 2024 21:29:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com
Subject: Re: [PATCH V5 4/4] perf/x86/intel: Support PEBS counters snapshotting
Message-ID: <20241217202919.GG11133@noisy.programming.kicks-ass.net>
References: <20241216204505.748363-1-kan.liang@linux.intel.com>
 <20241216204505.748363-4-kan.liang@linux.intel.com>
 <20241217133707.GB2354@noisy.programming.kicks-ass.net>
 <96cb859f-8265-4f5a-99bb-44cfdcd25b9e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96cb859f-8265-4f5a-99bb-44cfdcd25b9e@linux.intel.com>

On Tue, Dec 17, 2024 at 12:45:56PM -0500, Liang, Kan wrote:


> > Why can't you use something like the below -- that gives you a count
> > value matching the pmc value you put in, as long as it is 'near' the
> > current value.
> > 
> > ---
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 8f218ac0d445..3cf8b4f2b2c1 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -154,6 +154,26 @@ u64 x86_perf_event_update(struct perf_event *event)
> >  	return new_raw_count;
> >  }
> >  
> > +u64 x86_perf_event_pmc_to_count(struct perf_event *event, u64 pmc)
> > +{
> > +	struct hw_perf_event *hwc = &event->hw;
> > +	int shift = 64 - x86_pmu.cntval_bits;
> > +	u64 prev_pmc, prev_count;
> > +	u64 delta;
> > +
> > +	do {
> > +		prev_pmc = local64_read(&hwc->prev_count);
> > +		barrier();
> > +		prev_count = local64_read(&event->count);
> > +		barrier();
> > +	} while (prev_pmc != local64_read(&hwc->prev_count));
> 
> Is the "while()" to handle PMI? But there should be no PMI, since the
> PMU has been disabled when draining the PEBS buffer.

Perhaps not in your case, but this way the function is more widely
usable.

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index e06ac9a3cdf8..7f0b850f7277 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1969,6 +1969,23 @@ static void adaptive_pebs_save_regs(struct
> pt_regs *regs,
> 
>  #define PEBS_LATENCY_MASK			0xffff
> 
> +void intel_perf_event_pmc_to_count(struct perf_event *event, u64 pmc)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	int shift = 64 - x86_pmu.cntval_bits;
> +	u64 prev_pmc;
> +	u64 delta;
> +
> +	prev_pmc = local64_read(&hwc->prev_count);
> +
> +	delta = (pmc << shift) - (prev_pmc << shift);
> +	delta >>= shift;
> +
> +	local64_add(delta, &event->count);
> +	local64_sub(delta, &hwc->period_left);
> +	local64_set(&hwc->prev_count, pmc);
> +}

This seems very fragile, at least keep the same store order and assert
you're in NMI/PMI context.

