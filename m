Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF81A9FAA;
	Thu, 23 Oct 2025 02:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761186575; cv=none; b=UqJzRkW2ZMx9/m2XqmIeFniz7tgvMrl6p5FTHzYRsR1OXCwOxalFc4ysnwSik5dgtxLylMvmDaoCO9xJHIYhRrFummS4bYNejJZgh359J3Zl5jDmlpGBJTMCCoNtDnOIAuvOdioKpWdlvXYLumJgcf5uE99q+g4bKXW4DNi8uY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761186575; c=relaxed/simple;
	bh=mhVovYrN43YXZHi0w7HO1gTno9goaEA7sg/nYs14rAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFsx2fGK5iWLIFPpTDHoktF2aYy49G3WKx7xL3NFgjIwg23a0gw6wSwvW1g+LFZwP4nE+sPrVeapscuWFacap5rI9iHEncU1oCXNzjoNx9UwlOA5fNTQGjdqlym6Vk5wlYeVvc5Gbcg0EEML/L3Ev66GqtloAzuZatPpplHCJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7s//+BL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7s//+BL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761186573; x=1792722573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mhVovYrN43YXZHi0w7HO1gTno9goaEA7sg/nYs14rAg=;
  b=f7s//+BLqLPk8tAuGUHeh4JE5CiW+gqPLA1PH7gJAuQKbHhwLL3B39D+
   Sg5GCArVICCf5t4Zhsf2tFaDbYObfehL3JIKg0KD2A429UNcD0xfn9cYw
   upTgLi59ud644eGwPdSKc4uP+eZyoFqrKXHezKYhQzGtYsXp+tWQhx+/1
   PZ1ck4nZjIRXNtN1RpOH03789Ehri9XdAU0rlS6NqiG0kjlDMTAjCIZ8N
   xRFg0G+gTv/Nh0tzF+GGG+Un4vpwj2DrTYt4ctbFaXBc0RrYG0jA37kbm
   Sf80fGvWG3sP5DPIsezM14HPdXiIIsr+Bj/5q46IB8tNNpqBmIVZ7r/Ua
   Q==;
X-CSE-ConnectionGUID: S07AW26USYGdUnQBKmDIZA==
X-CSE-MsgGUID: gX0/cyQbSHeFff6gXdSU6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74016098"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="74016098"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 19:29:33 -0700
X-CSE-ConnectionGUID: lqGJ9xqWRsq7YZHRRpD5fw==
X-CSE-MsgGUID: Je5oPvzaTnmff52U59Kz/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="188318580"
Received: from unknown (HELO [10.238.3.234]) ([10.238.3.234])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 19:29:29 -0700
Message-ID: <aa0667d2-c0ad-4a40-898b-cf1363a0941f@linux.intel.com>
Date: Thu, 23 Oct 2025 10:29:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 02/12] perf/x86/intel: Fix NULL event access and
 potential PEBS record loss
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, kernel test robot <oliver.sang@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
 <20251015064422.47437-3-dapeng1.mi@linux.intel.com>
 <fcb09e14-970c-4ebd-82f2-a12150fe3708@linux.intel.com>
 <20251022112432.GN4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251022112432.GN4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/22/2025 7:24 PM, Peter Zijlstra wrote:
> On Wed, Oct 22, 2025 at 04:12:14PM +0800, Mi, Dapeng wrote:
>
>> Just think twice about this fix, it seems current fix is incomplete.
>> Besides the PEBS handler, the basic PMI handler could encounter same issue,
>> like the below code in handle_pmi_common(),
>>
>>     for_each_set_bit(bit, (unsigned long *)&status, X86_PMC_IDX_MAX) {
>>         struct perf_event *event = cpuc->events[bit];
>>         u64 last_period;
>>
>>         handled++;
>>
>>         if (!test_bit(bit, cpuc->active_mask))
>>             continue;
>>
>> Although the NULL event would not be accessed by checking
>> the cpuc->active_mask, the potential overflow process of these NULL events
>> is skipped as well, it may cause data loss.
>>
>> Moreover, current approach defines temporary variables to snapshot the
>> active events, the temporary variables may consume too much stack memory
>> (384 bytes).
>>
>> So I enhance the fix as below. Do you have any comment on this? Thanks.
> So I didn't like the previous and I like this even less. What about
> something like this instead?
>
> I quickly went through the cpuc->event[ users and they all either check
> active_mask or, in case of the PEBS stuff, check pebs_enabled mask
> (which should be a subset of active_mask).
>
> (the PEBS last case depends on count being 0 for all counters that are
> not set in pebs_enabled)

Yes.


>
> WDYT?
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 745caa6c15a3..74479f9d6eed 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1344,6 +1344,7 @@ static void x86_pmu_enable(struct pmu *pmu)
>  				hwc->state |= PERF_HES_ARCH;
>  
>  			x86_pmu_stop(event, PERF_EF_UPDATE);
> +			cpuc->events[hwc->idx] = NULL;
>  		}
>  
>  		/*
> @@ -1365,6 +1366,7 @@ static void x86_pmu_enable(struct pmu *pmu)
>  			 * if cpuc->enabled = 0, then no wrmsr as
>  			 * per x86_pmu_enable_event()
>  			 */
> +			cpuc->events[hwc->idx] = event;
>  			x86_pmu_start(event, PERF_EF_RELOAD);
>  		}
>  		cpuc->n_added = 0;
> @@ -1531,7 +1533,6 @@ static void x86_pmu_start(struct perf_event *event, int flags)
>  
>  	event->hw.state = 0;
>  
> -	cpuc->events[idx] = event;
>  	__set_bit(idx, cpuc->active_mask);
>  	static_call(x86_pmu_enable)(event);
>  	perf_event_update_userpage(event);
> @@ -1610,7 +1611,6 @@ void x86_pmu_stop(struct perf_event *event, int flags)
>  	if (test_bit(hwc->idx, cpuc->active_mask)) {
>  		static_call(x86_pmu_disable)(event);
>  		__clear_bit(hwc->idx, cpuc->active_mask);
> -		cpuc->events[hwc->idx] = NULL;
>  		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
>  		hwc->state |= PERF_HES_STOPPED;
>  	}
> @@ -1648,6 +1648,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
>  	 * Not a TXN, therefore cleanup properly.
>  	 */
>  	x86_pmu_stop(event, PERF_EF_UPDATE);
> +	cpuc->events[event->hw.idx] = NULL;
>  
>  	for (i = 0; i < cpuc->n_events; i++) {
>  		if (event == cpuc->event_list[i])

This is a much prettier fix. Thanks.👍 

It looks good to me. I did basic tests with this fix, and didn't find any
issues. But considering this is a such fundamental change, I would do more
tests later. 


>
