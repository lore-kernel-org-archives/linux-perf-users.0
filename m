Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8F32824C;
	Mon,  8 Dec 2025 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765176414; cv=none; b=D1P/JCY0jB2DEivws9iuYumfSQG9AmKUlDgn8sztZZEo4OQdzkNoWMaCGA4ft4b6PBNKxPLQrjxBmxGS/dFBQoHT82nGSm990t/kTqW5M41sOWBkXv4jWE9Yvtm+Ai3Zap7O3ybJMwfDGxi1Esp2QLHzdBJCa9iJK3jHW646qNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765176414; c=relaxed/simple;
	bh=AxuIQYBlWT1fy6f6uKhDRn+dunOxIjSbwOTfASPg7F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKwl/pThJ/DNdqhOAHIv57zbVT1CF8mdIqMysO59vDBuOnfUscuRwZbpQ3IuJZ/2ilqT3SxEWxZ2NScTUD4HrGBsFqOagfsoNF6IuAhDPn2S9bR5gkDusXTViTDTRMxUT6dEONI96qJkcb5KBXmhDNr7PLtRSZPfLSzW1mbJN7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEBwkUP9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEBwkUP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765176413; x=1796712413;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AxuIQYBlWT1fy6f6uKhDRn+dunOxIjSbwOTfASPg7F0=;
  b=CEBwkUP9GHCuO4nM3afAz2iJtzYni+zPevTA/42K85C4OS9qOd35NcyM
   6sZXCAJV6tqRHPdclj7Vug42mcJuGXsRf628UuvOMiZClbtErJSPwDEib
   2uhkHwvLZnuy2pe8BBhgJ5Et/ueMhSsC+YOJdCiheaM/KeQssg6CEYGt0
   2pg4UHuz5IhXvrFO4qBHcN1ZvyuVhMhiEY+58irAsu3hKfX+BoOv5hIPF
   SSHLJzzJtVz9DvEhVky97L5d9+jwQB4IkGvxfeCEsngfxnd9CWQhBFby1
   hFGa0FN+JcR71oqrq7WDowsIlC0W3doGojP+copzzA+oJVM3EbI4KTTc5
   Q==;
X-CSE-ConnectionGUID: tq0bJG64QvakE01RkUKVsA==
X-CSE-MsgGUID: X0zrfy/iSQiFH2T+vC27yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="84521912"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="84521912"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 22:46:53 -0800
X-CSE-ConnectionGUID: zhvgWjiGQeOy33J5281s7w==
X-CSE-MsgGUID: i7j1oDlTT5GYEDNx8plMKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="200774255"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.12]) ([10.124.240.12])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 22:46:47 -0800
Message-ID: <5e808ff0-0107-4085-a1ab-ea1cfed4e0ca@linux.intel.com>
Date: Mon, 8 Dec 2025 14:46:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 16/19] perf/x86: Activate back-to-back NMI detection
 for arch-PEBS induced NMIs
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-17-dapeng1.mi@linux.intel.com>
 <20251205123940.GY2528459@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251205123940.GY2528459@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/5/2025 8:39 PM, Peter Zijlstra wrote:
> On Wed, Dec 03, 2025 at 02:54:57PM +0800, Dapeng Mi wrote:
>> When two or more identical PEBS events with the same sampling period are
>> programmed on a mix of PDIST and non-PDIST counters, multiple
>> back-to-back NMIs can be triggered.
> This is a hardware defect -- albeit a fairly common one.
>
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index da48bcde8fce..a130d3f14844 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3351,8 +3351,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>  	 */
>>  	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
>>  				 (unsigned long *)&status)) {
>> -		handled++;
>> -		static_call(x86_pmu_drain_pebs)(regs, &data);
>> +		handled += static_call(x86_pmu_drain_pebs)(regs, &data);
>>  
>>  		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
>>  		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
> Note that the old code would return handled++, while the new code:
>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index a01c72c03bd6..c7cdcd585574 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -2759,7 +2759,7 @@ __intel_pmu_pebs_events(struct perf_event *event,
>>  	__intel_pmu_pebs_last_event(event, iregs, regs, data, at, count, setup_sample);
>>  }
>>  
>> -static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
>> +static int intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  	struct debug_store *ds = cpuc->ds;
>> @@ -2768,7 +2768,7 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
>>  	int n;
>>  
>>  	if (!x86_pmu.pebs_active)
>> -		return;
>> +		return 0;
>>  
>>  	at  = (struct pebs_record_core *)(unsigned long)ds->pebs_buffer_base;
>>  	top = (struct pebs_record_core *)(unsigned long)ds->pebs_index;
>> @@ -2779,22 +2779,24 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
>>  	ds->pebs_index = ds->pebs_buffer_base;
>>  
>>  	if (!test_bit(0, cpuc->active_mask))
>> -		return;
>> +		return 0;
>>  
>>  	WARN_ON_ONCE(!event);
>>  
>>  	if (!event->attr.precise_ip)
>> -		return;
>> +		return 0;
>>  
>>  	n = top - at;
>>  	if (n <= 0) {
>>  		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
>>  			intel_pmu_save_and_restart_reload(event, 0);
>> -		return;
>> +		return 0;
>>  	}
>>  
>>  	__intel_pmu_pebs_events(event, iregs, data, at, top, 0, n,
>>  				setup_pebs_fixed_sample_data);
>> +
>> +	return 0;
>>  }
>>  
>>  static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64 mask)
>> @@ -2817,7 +2819,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64
>>  	}
>>  }
>>  
>> -static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
>> +static int intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  	struct debug_store *ds = cpuc->ds;
>> @@ -2830,7 +2832,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>  	u64 mask;
>>  
>>  	if (!x86_pmu.pebs_active)
>> -		return;
>> +		return 0;
>>  
>>  	base = (struct pebs_record_nhm *)(unsigned long)ds->pebs_buffer_base;
>>  	top = (struct pebs_record_nhm *)(unsigned long)ds->pebs_index;
>> @@ -2846,7 +2848,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>  
>>  	if (unlikely(base >= top)) {
>>  		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
>> -		return;
>> +		return 0;
>>  	}
>>  
>>  	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
>> @@ -2931,6 +2933,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>  						setup_pebs_fixed_sample_data);
>>  		}
>>  	}
>> +
>> +	return 0;
>>  }
>>  
>>  static __always_inline void
>> @@ -2984,7 +2988,7 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
>>  
>>  }
>>  
>> -static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
>> +static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
>>  {
>>  	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
>>  	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
>> @@ -2997,7 +3001,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>>  	u64 mask;
>>  
>>  	if (!x86_pmu.pebs_active)
>> -		return;
>> +		return 0;
>>  
>>  	base = (struct pebs_basic *)(unsigned long)ds->pebs_buffer_base;
>>  	top = (struct pebs_basic *)(unsigned long)ds->pebs_index;
>> @@ -3010,7 +3014,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>>  
>>  	if (unlikely(base >= top)) {
>>  		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
>> -		return;
>> +		return 0;
>>  	}
>>  
>>  	if (!iregs)
>> @@ -3032,9 +3036,11 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>>  
>>  	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
>>  					    setup_pebs_adaptive_sample_data);
>> +
>> +	return 0;
>>  }
> will now return handled+=0 for all these. Which is a change in
> behaviour. Also:

This change only take effects for arch-PEBS. For the legacy PEBS, the
"handled" would still be added 1 unconditionally even the *_drain_pebs()
helpers always return 0.

    /*
     * PEBS overflow sets bit 62 in the global status register
     */
    if (__test_and_clear_bit(GLOBAL_STATUS_BUFFER_OVF_BIT, (unsigned long
*)&status)) {
        u64 pebs_enabled = cpuc->pebs_enabled;

        handled++;
        x86_pmu_handle_guest_pebs(regs, &data);
        static_call(x86_pmu_drain_pebs)(regs, &data);


>
>> -static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
>> +static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
>>  				      struct perf_sample_data *data)
>>  {
>>  	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
>> @@ -3044,13 +3050,14 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
>>  	struct x86_perf_regs perf_regs;
>>  	struct pt_regs *regs = &perf_regs.regs;
>>  	void *base, *at, *top;
>> +	u64 events_bitmap = 0;
>>  	u64 mask;
>>  
>>  	rdmsrq(MSR_IA32_PEBS_INDEX, index.whole);
>>  
>>  	if (unlikely(!index.wr)) {
>>  		intel_pmu_pebs_event_update_no_drain(cpuc, X86_PMC_IDX_MAX);
>> -		return;
>> +		return 0;

If index.wr is 0, then it indicates there is no any PEBS record written in
buffer since last drain of PEBS buffer. In this case, the PEBS PMI should
not be generated. If it's generated, then it implies there must be
something wrong. The 0 return value would lead to a "suspicious NMI"
warning which is good to warn us there are something wrong.


>>  	}
>>  
>>  	base = cpuc->pebs_vaddr;
>> @@ -3089,6 +3096,7 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
>>  
>>  		basic = at + sizeof(struct arch_pebs_header);
>>  		pebs_status = mask & basic->applicable_counters;
>> +		events_bitmap |= pebs_status;
>>  		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
>>  					       pebs_status, counts, last,
>>  					       setup_arch_pebs_sample_data);
>> @@ -3108,6 +3116,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
>>  	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
>>  					    counts, last,
>>  					    setup_arch_pebs_sample_data);
>> +
> 	/*
> 	 * Comment that explains the arch pebs defect goes here.
> 	 */
>> +	return hweight64(events_bitmap);
>>  }
