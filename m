Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA981F5851;
	Mon, 11 Aug 2025 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754955174; cv=none; b=JWWcog6K5pQV1RVvEweIOTKkaM8LtHKmk1iq2l7dpr9TJei4FOhLQOKRHxFGqVDzYF1iOOv3iGtBvxuu/qai8P84O1Td9CL8dVNVUOY55LWjnd+s2pxy/AeJytylHXuCn43JR9kpmUxlMSeNZAscTUUD1bspCIyhIljTvxq1cF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754955174; c=relaxed/simple;
	bh=7cLJdH8KF2VZBdJI+NHRPlbrq7ivdih1u7haMen+RKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3stElAtCuT00ICGmb+71S/yek4Wyl3jwdlb0LRgSmtE9jacKyVWhiIzOMsC9kVnzsEAOW8dtWoxj34aA/pUIlijrTZG+m3qWH9cs8JvpkNR/6kT5UbZZTFcfM+Og/Es5RZ7vCjzWOgLgR9EWecVg2FdDHh02+lB2H+GpaWa8hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYxZ87oZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYxZ87oZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754955173; x=1786491173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7cLJdH8KF2VZBdJI+NHRPlbrq7ivdih1u7haMen+RKU=;
  b=AYxZ87oZBHwaK5mesHOq6NtXu3pejOGF4PkRFi5mK8SCeTkS8tnxoCur
   jFcItOnO9Lc/xkasU7SLhgTuiEQaVNaJt0OkCqKWJULtLRROs7dgRDGuE
   6XhjWon4US9LoYUS/0qHAgIHvLDKo69kjwZ0IEUjS9/VH5TqExJF3htqo
   S0bSrFeNpR85cfxAciSof6UIc3IsGUfARAEY3oPlCjz5jjUr90YVhm8fX
   Py1ZATW5+HtYNlKY02X3sIi4T6DtYXicIgHGKZwOljItb0n/6RA9EBP5/
   WfqbAZi9wMJ9HKw4qwVgMhror6IGIcWwzB95UNmqGYFMa3GgWr/ru0hzd
   A==;
X-CSE-ConnectionGUID: xExRFH7mSL2jCIkHq3uaaw==
X-CSE-MsgGUID: oGJUxb6QSxiM/dRjoU1V6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68673243"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68673243"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 16:32:52 -0700
X-CSE-ConnectionGUID: 9vZR6MreSQycM6+KUugAjA==
X-CSE-MsgGUID: nEoiVLPGRDC0WiG4eVCKqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="171277787"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 16:32:51 -0700
Received: from [10.124.35.105] (kliang2-mobl1.ccr.corp.intel.com [10.124.35.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6354020B5720;
	Mon, 11 Aug 2025 16:32:50 -0700 (PDT)
Message-ID: <17298e98-1a2d-4cdd-9156-73e77cc4eb5b@linux.intel.com>
Date: Mon, 11 Aug 2025 16:32:49 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 3/6] perf/x86: Check if cpuc->events[*] pointer exists
 before accessing it
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, kernel test robot <oliver.sang@intel.com>
References: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
 <20250811090034.51249-4-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250811090034.51249-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-08-11 2:00 a.m., Dapeng Mi wrote:
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

The PMU is disabled when draining the PEBS records. I don't think a PMI
can be triggered in the setup_pebs_adaptive_sample_data().

> So once PMI handling
> finishes and returns into setup_pebs_adaptive_sample_data() and it could
> find the cpuc->events[*] becomes NULL and accessing this NULL pointer
> triggers an invalid memory access and leads to kernel crashes eventually.

The commit 9734e25fbf5a stops all events in a group when processing the
last records of the leader event. For large PEBS, it's possible that
there are still some records for member events left. It should be the
root cause of the NULL pointer. If so, we should drain those records as
well.

Thanks,
Kan>
> Thus add NULL check before accessing cpuc->events[*] pointer.
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

