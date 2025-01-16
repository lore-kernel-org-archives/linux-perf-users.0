Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353701DE4FC;
	Thu, 16 Jan 2025 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028932; cv=none; b=Tm3yxVZrayvQaGBU4WyqPTDjoQzmxLHhRr9+dpggzBgzhVXVor4F0GixRcAzeIXg/CbfMh4hLHHtVlfMg/9ci4fovHu4nv/qy1grU++P79cpmFWyLqtXsTIzQCnAtxhChS+DedHZZOGH+ZiloeMqT2baYYP30sgEjgK7bmvcQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028932; c=relaxed/simple;
	bh=ibsKHbyo2VQ/DV9M0kk07F4zbKTpRd6NkgfGkmph6BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S81T4JAk3qkXS0iCIpEQSuZ/z0ENR7bAmKutO7ZusymAW9a+VEixvHu+TgsOiMJG7A70i0KH8iEKB+rLbCMhNEBeR8OoZbKouw7R2iclRhXI0QMbDID//5ziuoIlOKbI6dPexfTudOkLzdfFskrKw5pB6n9X8xPgirLjhCAn7MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jRbnOrzQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jRbnOrzQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HpIJ8WNpWrfXSs8bTFtnaCi5H1JzV8juPRSTrMtcQ28=; b=jRbnOrzQclpvVJz7Au40XgkK08
	SoVD/N31oWLONVY8u97GKy1+Jeajywk3nKmFl+syLCLNyTATM/N5whokVRNsZ3pn9WtXvFABKQbOb
	I/GWV2p+zPpOe7AQTGQ42TGs3fqbwuwPxUGsncIq2oILd5cv3GwBrDpsSYZVQIijb/d7digLbfHcv
	JFAbZsleeaJfwPhq2KAKPbI/0tX6Tpe1x6Ub4Bi4vb6TW6bWhk0M/5aJLndQCoX3PsWlWA1t3dulV
	HCXuxRzetMn6FleVnvqwma8a/XYO30k3Ar48EoF9zBtGGPuGyuYdac0jPe+n5eY9++E+BB8/+Z7NA
	dgMTYCkQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tYOZY-0000000DLsZ-2iwu;
	Thu, 16 Jan 2025 12:02:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC7D9300777; Thu, 16 Jan 2025 13:02:03 +0100 (CET)
Date: Thu, 16 Jan 2025 13:02:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH V9 3/3] perf/x86/intel: Support PEBS counters snapshotting
Message-ID: <20250116120203.GK8362@noisy.programming.kicks-ass.net>
References: <20250115184318.2854459-1-kan.liang@linux.intel.com>
 <20250115184318.2854459-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115184318.2854459-3-kan.liang@linux.intel.com>

On Wed, Jan 15, 2025 at 10:43:18AM -0800, kan.liang@linux.intel.com wrote:

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 81b6ec8e824e..10ce80230ad3 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1294,6 +1294,19 @@ static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
>  	ds->pebs_interrupt_threshold = threshold;
>  }
>  
> +#define PEBS_DATACFG_CNTRS(x)						\
> +	((x >> PEBS_DATACFG_CNTR_SHIFT) & PEBS_DATACFG_CNTR_MASK)
> +
> +#define PEBS_DATACFG_CNTR_BIT(x)					\
> +	(((1ULL << x) & PEBS_DATACFG_CNTR_MASK) << PEBS_DATACFG_CNTR_SHIFT)
> +
> +#define PEBS_DATACFG_FIX(x)						\
> +	((x >> PEBS_DATACFG_FIX_SHIFT) & PEBS_DATACFG_FIX_MASK)
> +
> +#define PEBS_DATACFG_FIX_BIT(x)						\
> +	(((1ULL << (x - INTEL_PMC_IDX_FIXED)) & PEBS_DATACFG_FIX_MASK)	\
> +	 << PEBS_DATACFG_FIX_SHIFT)

That INTEL_PMX_IDX_FIXED does not belong here, needs to be at the
callsite.


> @@ -1914,6 +1975,34 @@ static void adaptive_pebs_save_regs(struct pt_regs *regs,
>  #endif
>  }
>  
> +static void intel_perf_event_pmc_to_count(struct perf_event *event, u64 pmc)
> +{
> +	int shift = 64 - x86_pmu.cntval_bits;
> +	struct hw_perf_event *hwc;
> +	u64 delta, prev_pmc;
> +
> +	/*
> +	 * The PEBS record doesn't shrink on pmu::del().
> +	 * See pebs_update_state().
> +	 * Ignore the non-exist event.
> +	 */
> +	if (!event)
> +		return;
> +
> +	hwc = &event->hw;
> +	prev_pmc = local64_read(&hwc->prev_count);
> +
> +	/* Only update the count when the PMU is disabled */
> +	WARN_ON(this_cpu_read(cpu_hw_events.enabled));
> +	local64_set(&hwc->prev_count, pmc);
> +
> +	delta = (pmc << shift) - (prev_pmc << shift);
> +	delta >>= shift;
> +
> +	local64_add(delta, &event->count);
> +	local64_sub(delta, &hwc->period_left);
> +}

Name and function don't really match at this point. When I suggested
this function it returned a count value, now it's closer to
intel_perf_event_update_pmc() or somesuch.



> @@ -2049,6 +2138,61 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>  		}
>  	}
>  
> +	if (format_group & (PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS)) {
> +		struct pebs_cntr_header *cntr = next_record;
> +		int bit;
> +
> +		next_record += sizeof(struct pebs_cntr_header);
> +
> +		/*
> +		 * The PEBS_DATA_CFG is a global register, which is the
> +		 * superset configuration for all PEBS events.
> +		 * For the PEBS record of non-sample-read group, ignore
> +		 * the counter snapshot fields.
> +		 */
> +		if (!is_pebs_counter_event_group(event)) {
> +			unsigned int nr;
> +
> +			nr = bitmap_weight((unsigned long *)&cntr->cntr, INTEL_PMC_MAX_GENERIC) +
> +			     bitmap_weight((unsigned long *)&cntr->fixed, INTEL_PMC_MAX_FIXED);

hweight32 ?

> +			if (cntr->metrics == INTEL_CNTR_METRICS)
> +				nr += 2;
> +			next_record += nr * sizeof(u64);
> +			goto end_cntr;

Yuck, can't you break out stuff into a helper function to get rid of
that goto?

> +		}
> +
> +		for_each_set_bit(bit, (unsigned long *)&cntr->cntr, INTEL_PMC_MAX_GENERIC) {
> +			intel_perf_event_pmc_to_count(cpuc->events[bit], *(u64 *)next_record);
> +			next_record += sizeof(u64);
> +		}
> +
> +		for_each_set_bit(bit, (unsigned long *)&cntr->fixed, INTEL_PMC_MAX_FIXED) {
> +			/* The slots event will be handled with perf_metric later */
> +			if ((cntr->metrics == INTEL_CNTR_METRICS) &&
> +			    (bit + INTEL_PMC_IDX_FIXED == INTEL_PMC_IDX_FIXED_SLOTS)) {
> +				next_record += sizeof(u64);
> +				continue;
> +			}
> +			intel_perf_event_pmc_to_count(cpuc->events[bit + INTEL_PMC_IDX_FIXED],
> +						      *(u64 *)next_record);
> +			next_record += sizeof(u64);
> +		}
> +
> +		/* HW will reload the value right after the overflow. */
> +		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
> +			local64_set(&event->hw.prev_count, (u64)-event->hw.sample_period);
> +
> +		if (cntr->metrics == INTEL_CNTR_METRICS) {
> +			static_call(intel_pmu_update_topdown_event)
> +				   (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS],
> +				    (u64 *)next_record);
> +			next_record += 2 * sizeof(u64);
> +		}
> +		data->sample_flags |= PERF_SAMPLE_READ;
> +	}
> +
> +end_cntr:
> +
>  	WARN_ONCE(next_record != __pebs + basic->format_size,
>  			"PEBS record size %u, expected %llu, config %llx\n",
>  			basic->format_size,
