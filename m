Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474B22172D;
	Mon, 10 Mar 2025 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610660; cv=none; b=CKyI8GwLl0ICJ4eVa63QiMpNV8UfcSkoUXxuoy37Tzcd9KX2tyaq3Ab+DL0RRMGaKIuhN4O85n9ZNxV+GPNscrCEhbdhdmiEem/DoeteEUGnEV4VG8Pjkax0hjV2bWQE/21lV4BxAP2sC1L6KF2PO1C4mw/pqvIqQm5ngYSADxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610660; c=relaxed/simple;
	bh=zP/SBsawh9IJ4rFGXkTfKbMGgKVbMiboFwfKn+yD3Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rphhGlh/rI2IhhBKiUBKra+FaEu7DphY6O7w7IHTKie2BaLah6X4BIz8mRa4zZd5BjFF8QVFGNdbhqhVoaFvGRDZF6lhGIqKo7o4T6VeKnqV1Fyhb60AdsJnMJ+MH/wArTQMOmEFhr8+zQiz0Q3Vd8JN1Z2j5fG2JW4jd/Vf+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YegjSBP9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YegjSBP9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ScP3/QN7pJ6oT8ufJYhHtcaoJqNafq5u9wpkG818K9k=; b=YegjSBP9TEr78VdbHgWlSAeRaX
	2gBu+99MlytfKi3louhCon8+cTDF61pRxIgRK6+LhliqHqUs9BdatSy/kKPDvK4aG1VR3aDdqDqgc
	3/iL19v2sDDZ9WCn/ljHALcRCD+NjNTKKE17n8KNzHzm50eT0NZP7LtwD0YhYmh71TPm4XWu5oe5j
	q+oDD50mb0gKdjuaxmBtq2pd4Jc3uUfEpgA8k5cwjMNVgtPYP7c6yNVznsPDtKw31m9JUnKd1gFhM
	6OfjdKpggLqeZlrvHPrNv1bDEFI/Cl8pQtG+x3LtxE5ajjQvwFyBfwteD0nMzTGPR3gX40IMW23OB
	gYhL6yYA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trcUG-00000001rMT-15Xu;
	Mon, 10 Mar 2025 12:44:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 41D40300599; Mon, 10 Mar 2025 13:44:03 +0100 (CET)
Date: Mon, 10 Mar 2025 13:44:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mark.barnett@arm.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, ben.gainey@arm.com, deepak.surti@arm.com,
	ak@linux.intel.com, will@kernel.org, james.clark@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/5] perf: Allow periodic events to alternate between
 two sample periods
Message-ID: <20250310124403.GQ5880@noisy.programming.kicks-ass.net>
References: <20250307202247.648633-1-mark.barnett@arm.com>
 <20250307202247.648633-3-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307202247.648633-3-mark.barnett@arm.com>

On Fri, Mar 07, 2025 at 08:22:44PM +0000, mark.barnett@arm.com wrote:
> From: Ben Gainey <ben.gainey@arm.com>
> 
> This change modifies perf_event_attr to add a second, alternative
> sample period field, and modifies the core perf overflow handling
> such that when specified an event will alternate between two sample
> periods.
> 
> Currently, perf does not provide a  mechanism for decoupling the period
> over which counters are counted from the period between samples. This is
> problematic for building a tool to measure per-function metrics derived
> from a sampled counter group. Ideally such a tool wants a very small
> sample window in order to correctly attribute the metrics to a given
> function, but prefers a larger sample period that provides representative
> coverage without excessive probe effect, triggering throttling, or
> generating excessive amounts of data.
> 
> By alternating between a long and short sample_period and subsequently
> discarding the long samples, tools may decouple the period between
> samples that the tool cares about from the window of time over which
> interesting counts are collected.
> 
> It is expected that typically tools would use this feature with the
> cycles or instructions events as an approximation for time, but no
> restrictions are applied to which events this can be applied to.

So you do add the constraint that 'alt_sample_period < sample_period'
but there is no natural reason for this to be so.

Additionally, this way the total period ends up being 'sample_period +
alt_sample_period'.

Would not a more natural way to express things be:

	p1 = sample_period - alt_sample_period;
	p2 = alt_sample_period;

This way you retain the total period to be 'sample_period' and naturally
get the constraint: 'alt_sample_period < sample_period'.

That is; I'm somewhat confused by the state of things; it doesn't seem
consistent.

(Also note that this alternative form might actually work in combination
with attr.freq set -- although that has a number of 'fun' details I'm
sure).

> Signed-off-by: Ben Gainey <ben.gainey@arm.com>
> Signed-off-by: Mark Barnett <mark.barnett@arm.com>
> ---
>  include/linux/perf_event.h      |  5 +++++
>  include/uapi/linux/perf_event.h |  3 +++
>  kernel/events/core.c            | 39 ++++++++++++++++++++++++++++++++-
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 8333f132f4a9..99ba72c8fb6d 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -276,6 +276,11 @@ struct hw_perf_event {
>  	 */
>  	u64				freq_time_stamp;
>  	u64				freq_count_stamp;
> +
> +	/*
> +	 * Indicates that the alternative sample period is used
> +	 */
> +	bool				using_alt_sample_period;

There's a 4 byte hole in this structure if you look; also please use a
flag, sizeof(_Bool) is ABI dependent.

>  #endif
>  };
>  
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 0524d541d4e3..499a8673df8e 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -379,6 +379,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
>  #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
> +#define PERF_ATTR_SIZE_VER9	144	/* add: alt_sample_period */
>  
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -531,6 +532,8 @@ struct perf_event_attr {
>  	__u64	sig_data;
>  
>  	__u64	config3; /* extension of config2 */
> +
> +	__u64	alt_sample_period;
>  };
>  
>  /*
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index bcb09e011e9e..7ec8ec6ba7ef 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4178,6 +4178,8 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
>  	s64 period, sample_period;
>  	s64 delta;
>  
> +	WARN_ON_ONCE(hwc->using_alt_sample_period);

Groan; so that bit keeps flipping in and off, and statistically we'll
warn, but urgh.

>  	period = perf_calculate_period(event, nsec, count);
>  
>  	delta = (s64)(period - hwc->sample_period);
> @@ -9894,6 +9896,7 @@ static int __perf_event_overflow(struct perf_event *event,
>  				 int throttle, struct perf_sample_data *data,
>  				 struct pt_regs *regs)
>  {
> +	struct hw_perf_event *hwc = &event->hw;
>  	int events = atomic_read(&event->event_limit);
>  	int ret = 0;
>  
> @@ -9913,6 +9916,18 @@ static int __perf_event_overflow(struct perf_event *event,
>  	    !bpf_overflow_handler(event, data, regs))
>  		goto out;
>  
> +	/*
> +	 * Swap the sample period to the alternative period
> +	 */
> +	if (event->attr.alt_sample_period) {
> +		bool using_alt = hwc->using_alt_sample_period;
> +		u64 sample_period = (using_alt ? event->attr.sample_period
> +					       : event->attr.alt_sample_period);
> +
> +		hwc->sample_period = sample_period;
> +		hwc->using_alt_sample_period = !using_alt;
> +	}
> +
>  	/*
>  	 * XXX event_limit might not quite work as expected on inherited
>  	 * events
> @@ -12335,9 +12350,19 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  	if (attr->freq && attr->sample_freq)
>  		hwc->sample_period = 1;
>  	hwc->last_period = hwc->sample_period;
> -
>  	local64_set(&hwc->period_left, hwc->sample_period);
>  
> +	/*
> +	 * alt_sample_period cannot be used with freq
> +	 */
> +	if (attr->freq && attr->alt_sample_period)
> +		goto err_ns;

How can this happen? This case has already been filtered in
perf_event_open() below, no?

Also, this doesn't apply to tip/perf/core, someone went and changed
things...

> +
> +	if (attr->alt_sample_period) {
> +		hwc->sample_period = attr->alt_sample_period;
> +		hwc->using_alt_sample_period = true;
> +	}
> +
>  	/*
>  	 * We do not support PERF_SAMPLE_READ on inherited events unless
>  	 * PERF_SAMPLE_TID is also selected, which allows inherited events to
> @@ -12807,9 +12832,21 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (attr.freq) {
>  		if (attr.sample_freq > sysctl_perf_event_sample_rate)
>  			return -EINVAL;
> +		if (attr.alt_sample_period)
> +			return -EINVAL;
>  	} else {
>  		if (attr.sample_period & (1ULL << 63))
>  			return -EINVAL;
> +		if (attr.alt_sample_period) {
> +			if (!attr.sample_period)
> +				return -EINVAL;
> +			if (attr.alt_sample_period & (1ULL << 63))
> +				return -EINVAL;
> +			if (attr.alt_sample_period > attr.sample_period)
> +				return -EINVAL;
> +			if (attr.alt_sample_period == attr.sample_period)
> +				attr.alt_sample_period = 0;
> +		}
>  	}
>  
>  	/* Only privileged users can get physical addresses */
> -- 
> 2.43.0
> 
