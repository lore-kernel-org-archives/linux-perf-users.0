Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1D1F191E;
	Tue, 21 Jan 2025 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464523; cv=none; b=Jxtf0UB0qocnoY7Z/5qVmOdJ8ebzSEtwDiNx82RVBx22NNwgizWzkdRk1Rpz7YNwaCBJS0Zt+ZyL83Vaw5H2vEL8LFJfVhCOE17DmBS+cEWSrjILXYPDV2GVGApFDJuA+tO/RZ6K8mx/0egdhhgW5AsJ1FPyfg910EI7OtyCE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464523; c=relaxed/simple;
	bh=q/Boh/hxmexBZCuEYU3eWsfDlYGvDQCKVFqyCSKfv4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNpKCtF3hlTFTnru6ujApOHczj+c289Gjq2Z0NUc8UqVlesfLQU7ZXSX8XNj0CDwpXe0rHzbfb+T6FR5/3nT9m3uJKRkbrUY0d6huUT7f4kePP+XL13Ez1JV/MTCvQVGNPedxQJPBZRytgkyRLp2leiJHBwxw7J2jSzhdR9rnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CED9E106F;
	Tue, 21 Jan 2025 05:02:28 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECD173F66E;
	Tue, 21 Jan 2025 05:01:59 -0800 (PST)
Date: Tue, 21 Jan 2025 13:01:54 +0000
From: Leo Yan <leo.yan@arm.com>
To: "mark.barnett@arm.com" <mark.barnett@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com, ben.gainey@arm.com,
	deepak.surti@arm.com, ak@linux.intel.com, will@kernel.org,
	james.clark@arm.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] perf: Allow periodic events to alternate between
 two sample periods
Message-ID: <20250121130154.GA416913@e132581.arm.com>
References: <20250106120156.227273-1-mark.barnett@arm.com>
 <20250106120156.227273-2-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106120156.227273-2-mark.barnett@arm.com>

On Mon, Jan 06, 2025 at 12:01:52PM +0000, mark.barnett@arm.com wrote:
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
> 
> Signed-off-by: Ben Gainey <ben.gainey@arm.com>
> Signed-off-by: Mark Barnett <mark.barnett@arm.com>
> ---
>  include/linux/perf_event.h      |  5 +++++
>  include/uapi/linux/perf_event.h |  3 +++
>  kernel/events/core.c            | 37 ++++++++++++++++++++++++++++++++-
>  3 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index cb99ec8c9e96..cbb332f4e19c 100644
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
> index 065f9188b44a..7e339d12363a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4178,6 +4178,8 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
>  	s64 period, sample_period;
>  	s64 delta;
>  
> +	WARN_ON_ONCE(hwc->using_alt_sample_period);
> +
>  	period = perf_calculate_period(event, nsec, count);
>  
>  	delta = (s64)(period - hwc->sample_period);
> @@ -9850,6 +9852,7 @@ static int __perf_event_overflow(struct perf_event *event,
>  				 int throttle, struct perf_sample_data *data,
>  				 struct pt_regs *regs)
>  {
> +	struct hw_perf_event *hwc = &event->hw;
>  	int events = atomic_read(&event->event_limit);
>  	int ret = 0;
>  
> @@ -9869,6 +9872,18 @@ static int __perf_event_overflow(struct perf_event *event,
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
> @@ -12291,9 +12306,19 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  	if (attr->freq && attr->sample_freq)
>  		hwc->sample_period = 1;
>  	hwc->last_period = hwc->sample_period;
> -

Redundant change at here?

>  	local64_set(&hwc->period_left, hwc->sample_period);
>  
> +	if (attr->alt_sample_period) {
> +		hwc->sample_period = attr->alt_sample_period;
> +		hwc->using_alt_sample_period = true;
> +	}

My understanding it sets a short sample window for the first period.
Would it initialize the `hwc->period_left` with the updated sample
period?

> +
> +	/*
> +	 * alt_sample_period cannot be used with freq
> +	 */
> +	if (attr->freq && attr->alt_sample_period)
> +		goto err_ns;
> +

It is good to validate parameters first. So move the checking before
the adjustment for the alt sample period.

>  	/*
>  	 * We do not support PERF_SAMPLE_READ on inherited events unless
>  	 * PERF_SAMPLE_TID is also selected, which allows inherited events to
> @@ -12763,9 +12788,19 @@ SYSCALL_DEFINE5(perf_event_open,
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
> +			if (attr.alt_sample_period == attr.sample_period)
> +				attr.alt_sample_period = 0;

In theory, the attr.alt_sample_period should be less than
attr.sample_period, right?

Thanks,
Leo

> +		}
>  	}
>  
>  	/* Only privileged users can get physical addresses */
> 
> -- 
> 2.43.0
> 
