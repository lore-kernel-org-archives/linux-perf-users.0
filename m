Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524925D202;
	Tue, 19 Aug 2025 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593153; cv=none; b=pbTxyTfj5fFBuR9Nt6Ui8BFQDOXo2GwrIgz+7PAASYri/9N7izS7U9Nk54RRzQ+jfTvFKwxMlwkyWuYzzzTzQ8kSAYiYKMfUOUitPKmr0qKXvTTonnAN5fPiyOP4wqIZidQ3kO23ML1PtjpXpxA27iA/MVdkKjNjA/iqE00qPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593153; c=relaxed/simple;
	bh=v1lovRa7L9CtbXbJ5XSAYClSZnPlMp2T8lQ2SwwCE6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfkrDpI/zZFYc6/UwCgIt/dRGmKZjbhrHJ9Vcw/7HrkAPKO+mM1QWi8a9Cu9owwz5tUGXtRk1+H9dRx26U8/R/c0qlKKInCvIKAQGvnQWKJzGEX73X2GkadHB0s4qd4ju8gYeDdZTdXkyDtFfjJR8dJLMH2BzLZMzN8UV+BSHxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=arOtl12A; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="arOtl12A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=brn1kG/AFuqEBTsxYiHvrO8wEDuL4EYKauL762B24mA=; b=arOtl12A9UmkB1PCAN3anpM28Q
	HCVA7u6B4GlKagUiczuwSao8C677DRbshPZMvOZJQlywrMR61lft1c/VGJpvhkQQHmeNPj0V7h1xe
	GMhwKOBT6SzJG5hHZ91qtDOxFHLSb4Wg3VBvEzOIrWH51cOVK3qUs4swccmz+VUjlMvw31kD9h7WU
	q0tqFzk2O0AYH8In5P01nDlfL2qdXVTjHHx9bROm8Ls3ydwLCK66UGKX+ygS9dSb1BxvScx9XATng
	NKWX7O/LcxNEe10INom9YO1SpmSgFkqcrfq5v2TbNDRUW2AAy07QugeWVKKoqf3p3wHWmyYbdOaOs
	h9efIN4Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoHyR-0000000007w-1FqF;
	Tue, 19 Aug 2025 08:45:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5728830036F; Tue, 19 Aug 2025 10:45:42 +0200 (CEST)
Date: Tue, 19 Aug 2025 10:45:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [Patch v2 3/6] perf/x86: Check if cpuc->events[*] pointer exists
 before accessing it
Message-ID: <20250819084542.GG3245006@noisy.programming.kicks-ass.net>
References: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
 <20250811090034.51249-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811090034.51249-4-dapeng1.mi@linux.intel.com>

On Mon, Aug 11, 2025 at 05:00:31PM +0800, Dapeng Mi wrote:
> The PMI handler could disable some events as the interrupt throttling
> and clear the corresponding items in cpuc->events[] array.
> 
> perf_event_overflow()
>   -> __perf_event_overflow()
>     ->__perf_event_account_interrupt()
>       -> perf_event_throttle_group()
>         -> perf_event_throttle()
>           -> event->pmu->stop()
>             -> x86_pmu_stop()
> 
> Moreover PMI is NMI on x86 platform and it could interrupt other perf
> code like setup_pebs_adaptive_sample_data(). 

Uhh, how? AFAICT we only do drain_pebs() from the PMI itself, or disable
the PMU first by clearing GLOBAL_CTRL.

> So once PMI handling
> finishes and returns into setup_pebs_adaptive_sample_data() and it could
> find the cpuc->events[*] becomes NULL and accessing this NULL pointer
> triggers an invalid memory access and leads to kernel crashes eventually.
> 
> Thus add NULL check before accessing cpuc->events[*] pointer.

This doesn't seem fully thought through.

If we do this NULL check, then the active_mask bittest is completely
superfluous and can be removed, no?

Also, what about this race:

	event = cpuc->events[idx]; // !NULL;
	<PMI>
		x86_pmu_stop()
		  cpuc->events[idx] = NULL;
	</PMI>
	... uses event

Worse, since it is a 'normal' load, it is permitted for the compiler to
re-issue the load, at which point it will still explode. IOW, it should
be READ_ONCE(), *if* we can live with the above race at all. Can we?

First though, you need to explain how we get here. Because drain_pebs()
nesting would be *BAD*.

> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202507042103.a15d2923-lkp@intel.com
> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> ---
>  arch/x86/events/core.c       |  3 +++
>  arch/x86/events/intel/core.c |  6 +++++-
>  arch/x86/events/intel/ds.c   | 13 ++++++-------
>  3 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 7610f26dfbd9..f0a3bc57157d 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1711,6 +1711,9 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
>  			continue;
>  
>  		event = cpuc->events[idx];
> +		if (!event)
> +			continue;
> +
>  		last_period = event->hw.last_period;
>  
>  		val = static_call(x86_pmu_update)(event);
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 15da60cf69f2..386717b75a09 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2718,6 +2718,8 @@ static void update_saved_topdown_regs(struct perf_event *event, u64 slots,
>  		if (!is_topdown_idx(idx))
>  			continue;
>  		other = cpuc->events[idx];
> +		if (!other)
> +			continue;
>  		other->hw.saved_slots = slots;
>  		other->hw.saved_metric = metrics;
>  	}
> @@ -2761,6 +2763,8 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end,
>  		if (!is_topdown_idx(idx))
>  			continue;
>  		other = cpuc->events[idx];
> +		if (!other)
> +			continue;
>  		__icl_update_topdown_event(other, slots, metrics,
>  					   event ? event->hw.saved_slots : 0,
>  					   event ? event->hw.saved_metric : 0);
> @@ -3138,7 +3142,7 @@ static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
>  
>  	for_each_set_bit(bit, (unsigned long *)&guest_pebs_idxs, X86_PMC_IDX_MAX) {
>  		event = cpuc->events[bit];
> -		if (!event->attr.precise_ip)
> +		if (!event || !event->attr.precise_ip)
>  			continue;
>  
>  		perf_sample_data_init(data, 0, event->hw.last_period);
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index c0b7ac1c7594..b23c49e2e06f 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2480,6 +2480,8 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64
>  	 */
>  	for_each_set_bit(bit, (unsigned long *)&pebs_enabled, X86_PMC_IDX_MAX) {
>  		event = cpuc->events[bit];
> +		if (!event)
> +			continue;
>  		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
>  			intel_pmu_save_and_restart_reload(event, 0);
>  	}
> @@ -2579,10 +2581,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  			continue;
>  
>  		event = cpuc->events[bit];
> -		if (WARN_ON_ONCE(!event))
> -			continue;
> -
> -		if (WARN_ON_ONCE(!event->attr.precise_ip))
> +		if (!event || WARN_ON_ONCE(!event->attr.precise_ip))
>  			continue;
>  
>  		/* log dropped samples number */
> @@ -2645,9 +2644,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>  		pebs_status = basic->applicable_counters & cpuc->pebs_enabled & mask;
>  		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
>  			event = cpuc->events[bit];
> -
> -			if (WARN_ON_ONCE(!event) ||
> -			    WARN_ON_ONCE(!event->attr.precise_ip))
> +			if (!event || WARN_ON_ONCE(!event->attr.precise_ip))
>  				continue;
>  
>  			if (counts[bit]++) {
> @@ -2663,6 +2660,8 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>  			continue;
>  
>  		event = cpuc->events[bit];
> +		if (!event)
> +			continue;
>  
>  		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
>  					    counts[bit], setup_pebs_adaptive_sample_data);
> -- 
> 2.34.1
> 
