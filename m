Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE922DC44;
	Tue, 14 Jan 2025 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856034; cv=none; b=VFed/1lGmOET+VdiZ7qnWkdk+bl363nyHUIipCoC+iXxsgvoy7DPy1//5i8NmggZxAtNgAPU/MwdGYiHm+s2yFK5WUPXUxipIhWf9FefjsOFbTSOYmfdYjCACAJmUmt7itu1c3teZinuikCMwGTgHi9LezbYWX/KE8PQU23MOGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856034; c=relaxed/simple;
	bh=txBrErmauC3imlBY1vZQedzPbVDsQuzh7dqG3+sOaO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZItFZP2NuL2tMn3KnGGlBno1zGZb+EgR9m3t6u6LTBWaIKMQFzVeL9mvHrVuq1E1glFNnu9pkeQajORK78ZV7qsPiRBAf0hpgalB0l8cSANl1GFGg6pmfTNwpWqkVUJzLzR3DbaZYB+Jg7AZtUGSZjr8RDyeLQwVHcDvexAfVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nNnQWVU2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nNnQWVU2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dPm2Uldyj5WoDX5TPv+zJgjV06b2wZfJvY0Gqx3Ymp4=; b=nNnQWVU21Yqvy14ImV2c4so6Gq
	sY/58XhLzekZGlKk0SlKLziZ+YjvqK8THtaygOmFDiUWt2T7m/s1h7nrjgUsL0LHsd5JY/s62scyV
	kNINgSgLEFz8fs71Hjm3NjcQV6uKXlKo1ZAdaWv9R3p2yGs/FTWHxoxkmRBUGSS2qeNI8yrL5xNzy
	Bye22ZK9UcT6oVEjx3uYm1qnsqOV+8OhiaoVHoQl2njcI5CuxVfPhYDSF6xvSdP0Li6HrTuxGJ3pN
	brEWcU9DkfokZa18MU+erjK5GeYp8kLMVPpHPlMOiaX20UWZojdldpZC9rAQ6WjpXHD7ggAmX7IGy
	l1h87j9A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfas-0000000ASKN-39Av;
	Tue, 14 Jan 2025 12:00:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5637B300346; Tue, 14 Jan 2025 13:00:26 +0100 (CET)
Date: Tue, 14 Jan 2025 13:00:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH V8 2/2] perf/x86/intel: Support PEBS counters snapshotting
Message-ID: <20250114120026.GO5388@noisy.programming.kicks-ass.net>
References: <20250106142103.1735729-1-kan.liang@linux.intel.com>
 <20250106142103.1735729-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106142103.1735729-2-kan.liang@linux.intel.com>

On Mon, Jan 06, 2025 at 06:21:03AM -0800, kan.liang@linux.intel.com wrote:
> @@ -4059,6 +4087,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
>  	}
>  
> +	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
> +	    (x86_pmu.intel_cap.pebs_format >= 6) &&
> +	    is_sampling_event(event) &&
> +	    event->attr.precise_ip)
> +			event->group_leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
> +

White space fail, easily fixed though.

>  	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
>  	    (event->attr.type == PERF_TYPE_HW_CACHE))
>  		return 0;
> @@ -4167,6 +4201,24 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  	return 0;
>  }
>  
> +static int intel_pmu_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
> +{
> +	struct perf_event *event;
> +	int ret = x86_schedule_events(cpuc, n, assign);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (cpuc->is_fake)
> +		return ret;
> +
> +	event = cpuc->event_list[n - 1];
> +	if (event && is_pebs_counter_event_group(event))
> +		intel_pmu_pebs_update_cfg(cpuc, n, assign);
> +
> +	return 0;
> +}

This lit up the WTF'o'meter for a bit. This needs a comment at the very
least, but I also hate how this relies on the core code never doing a
transaction larger than a single group.

Furthermore, you can have multiple ->schedule_events() calls in a single
pmu_disable() section, so why is schedule_events() the right place to do
this?

Could it not happen that you add group-a, which has this PEBS_CNTR thing
on, computes the fancy new pebs_data_cfg field. Then adds another event,
which perturbs the counter placement, does not update the pebs_data_cfg
and you're up a creek?

I would've thought that x86_pmu_enable() would be a better place for
this -- that's the one place where everything is set up, right before it
is made to go. Only problem seems to be x86_pmu_enable_all() /
x86_pmu.enable_all() isn't given the right information, but that should
be fixable. Maybe clear cpuc->n_added after calling enable_all() ?


> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index ba74e1198328..e36bfb95c2a3 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1308,10 +1308,63 @@ static void adaptive_pebs_record_size_update(void)
>  		sz += sizeof(struct pebs_xmm);
>  	if (pebs_data_cfg & PEBS_DATACFG_LBRS)
>  		sz += x86_pmu.lbr_nr * sizeof(struct lbr_entry);
> +	if (pebs_data_cfg & (PEBS_DATACFG_METRICS | PEBS_DATACFG_CNTR)) {
> +		sz += sizeof(struct pebs_cntr_header);
> +
> +		/* Metrics base and Metrics Data */
> +		if (pebs_data_cfg & PEBS_DATACFG_METRICS)
> +			sz += 2 * sizeof(u64);
> +
> +		if (pebs_data_cfg & PEBS_DATACFG_CNTR) {
> +			sz += hweight64((pebs_data_cfg >> PEBS_DATACFG_CNTR_SHIFT) & PEBS_DATACFG_CNTR_MASK)
> +			      * sizeof(u64);
> +			sz += hweight64((pebs_data_cfg >> PEBS_DATACFG_FIX_SHIFT) & PEBS_DATACFG_FIX_MASK)
> +			      * sizeof(u64);

blergh, when splitting lines the operator goes on the end of the last
line. These lines are too long anyway.

Maybe:

#define PEBS_DATACFG_CNTR(x) \
	((x >> PEBS_DATACFG_CNTR_SHIFT) & PEBS_DATACFG_CNTR_MASK)
#define PEBS_DATACFG_FIX(x) \
	((x >> PEBS_DATACFG_FIX_SHIFT) & PEBS_DATACFG_FIX_MASK)

			sz += (hweight64(PEBS_DATACFG_CNTR(pebs_data_cfg)) +
			       hweight64(PEBS_DATACFG_FIX(pebs_data_cfg)))) *
			      sizeof(u64);

> +		}
> +	}
>  
>  	cpuc->pebs_record_size = sz;
>  }
>  
> +static void __intel_pmu_pebs_update_cfg(struct perf_event *event,
> +					int idx, u64 *pebs_data_cfg)
> +{
> +	if (is_metric_event(event)) {
> +		*pebs_data_cfg |= PEBS_DATACFG_METRICS;
> +		return;
> +	}
> +
> +	*pebs_data_cfg |= PEBS_DATACFG_CNTR;
> +
> +	if (idx >= INTEL_PMC_IDX_FIXED) {
> +		*pebs_data_cfg |= ((1ULL << (idx - INTEL_PMC_IDX_FIXED)) & PEBS_DATACFG_FIX_MASK)
> +				  << PEBS_DATACFG_FIX_SHIFT;
> +	} else {
> +		*pebs_data_cfg |= ((1ULL << idx) & PEBS_DATACFG_CNTR_MASK)
> +				  << PEBS_DATACFG_CNTR_SHIFT;

Also yuck. Maybe:

#define PEBS_DATACFG_FIX_BIT(x) \
	(((1ULL << x) & PEBS_DATACFG_FIX_MASK) << PEBS_DATACFG_FIX_SHIFT)


	pebs_data_cfg |= PEBS_DATACFG_FIX_BIT(idx - INTEL_PMC_IDX_FIXED);



> +	}
> +}
> +


