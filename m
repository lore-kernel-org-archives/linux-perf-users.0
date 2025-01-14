Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7B18952C;
	Tue, 14 Jan 2025 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877162; cv=none; b=qQCW1fBfl660bPuFbkVCIxQxiELkaBQuEIuorsgswyUmtTW0kVQTjDs2+FQfDVWgykjb860ZtcuayssNTQbp63tJdUuR5QbhXG8azP1WnBiAb/sEbeyUnK/wkqaopuJyIEDJhJsoqUOyBclj8KPEpfNOokhEv9/Hs1Ej47sR1Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877162; c=relaxed/simple;
	bh=Mjv2BLOZG/NTr21nt8MST1+xyYQg3MqZRCU8ArKHPoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2jjM32e5CuXOliAXaV1hDjoc1uxLAffjq+B8CKVjFaHJiHXz66aIxZca7uI3SzcG09x91QxRGDQOSDUPy/22xFRpOcfew+5zt3DbOZo2/Gss28yldeTjzJ+bHcyX13i+p2zKHMSFTQneED3cT5IM6HsF6Lr6Uo+lDHpdfbps7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGDyGPTc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGDyGPTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736877160; x=1768413160;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mjv2BLOZG/NTr21nt8MST1+xyYQg3MqZRCU8ArKHPoQ=;
  b=QGDyGPTcyIeq4/q4tyK7kYk8U9rVD9Q0KX1Qyfq9v54jZjFfmZRZtdV7
   pjj+98M9wqEHqunHzrMtfkS9MFLXdzOord3h9OSG7xhEUpSNXiXINEZYx
   3UTLZ2cxPyMuC56bZ3iFRi/zzMiQwNxvvKH4tk237ENHSFUTQTV6e+L6s
   B8iCAhnmRG2LOPUHc2E+wtmuwO7MRvNQZIHmiCkVgN5PVzokXe7C4M4Tm
   6Q6JBejpOHOq1sDlzAQPfV+vjZZ9tnnHM/gUoG51BTAK9YC0Ho4btXkUA
   Sl7yUENbOgZCrJC30DLI2qdTToSCQcRqbOvS1cGmpZBQGW5LnRh6EVj5p
   g==;
X-CSE-ConnectionGUID: 6D9osqq5Q6aRyNrCmvqwRQ==
X-CSE-MsgGUID: MgqG/uWTQIm0GEMfvjO0OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36880979"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="36880979"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:52:39 -0800
X-CSE-ConnectionGUID: adQvo0UkSX25t8O5Lo9TSQ==
X-CSE-MsgGUID: OoACoXSeTfCRyclcWX/rbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="104950618"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:52:39 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7D34620B5713;
	Tue, 14 Jan 2025 09:52:37 -0800 (PST)
Message-ID: <698e3cf3-3579-4bd4-93e2-bbcda56a2a29@linux.intel.com>
Date: Tue, 14 Jan 2025 12:52:36 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 2/2] perf/x86/intel: Support PEBS counters snapshotting
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, eranian@google.com,
 dapeng1.mi@linux.intel.com
References: <20250106142103.1735729-1-kan.liang@linux.intel.com>
 <20250106142103.1735729-2-kan.liang@linux.intel.com>
 <20250114120026.GO5388@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250114120026.GO5388@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-14 7:00 a.m., Peter Zijlstra wrote:
> On Mon, Jan 06, 2025 at 06:21:03AM -0800, kan.liang@linux.intel.com wrote:
>> @@ -4059,6 +4087,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
>>  	}
>>  
>> +	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
>> +	    (x86_pmu.intel_cap.pebs_format >= 6) &&
>> +	    is_sampling_event(event) &&
>> +	    event->attr.precise_ip)
>> +			event->group_leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
>> +
> 
> White space fail, easily fixed though.
> 
>>  	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
>>  	    (event->attr.type == PERF_TYPE_HW_CACHE))
>>  		return 0;
>> @@ -4167,6 +4201,24 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  	return 0;
>>  }
>>  
>> +static int intel_pmu_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
>> +{
>> +	struct perf_event *event;
>> +	int ret = x86_schedule_events(cpuc, n, assign);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (cpuc->is_fake)
>> +		return ret;
>> +
>> +	event = cpuc->event_list[n - 1];
>> +	if (event && is_pebs_counter_event_group(event))
>> +		intel_pmu_pebs_update_cfg(cpuc, n, assign);
>> +
>> +	return 0;
>> +}
> 
> This lit up the WTF'o'meter for a bit. This needs a comment at the very
> least, but I also hate how this relies on the core code never doing a
> transaction larger than a single group.
> 
> Furthermore, you can have multiple ->schedule_events() calls in a single
> pmu_disable() section, so why is schedule_events() the right place to do
> this?
> 
> Could it not happen that you add group-a, which has this PEBS_CNTR thing
> on, computes the fancy new pebs_data_cfg field. Then adds another event,
> which perturbs the counter placement, does not update the pebs_data_cfg
> and you're up a creek?
> > I would've thought that x86_pmu_enable() would be a better place for
> this -- that's the one place where everything is set up, right before it
> is made to go.

Yes, the x86_pmu_enable() seems a better place for the global setup.

> Only problem seems to be x86_pmu_enable_all() /
> x86_pmu.enable_all() isn't given the right information, but that should
> be fixable. Maybe clear cpuc->n_added after calling enable_all() ?


Not the x86_pmu_enable_all(). The setup should be done before
x86_pmu_start(), which update the MSR_PEBS_DATA_CFG.

I will send out a V9 to address it.

Thanks,
Kan

> 
> 
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index ba74e1198328..e36bfb95c2a3 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1308,10 +1308,63 @@ static void adaptive_pebs_record_size_update(void)
>>  		sz += sizeof(struct pebs_xmm);
>>  	if (pebs_data_cfg & PEBS_DATACFG_LBRS)
>>  		sz += x86_pmu.lbr_nr * sizeof(struct lbr_entry);
>> +	if (pebs_data_cfg & (PEBS_DATACFG_METRICS | PEBS_DATACFG_CNTR)) {
>> +		sz += sizeof(struct pebs_cntr_header);
>> +
>> +		/* Metrics base and Metrics Data */
>> +		if (pebs_data_cfg & PEBS_DATACFG_METRICS)
>> +			sz += 2 * sizeof(u64);
>> +
>> +		if (pebs_data_cfg & PEBS_DATACFG_CNTR) {
>> +			sz += hweight64((pebs_data_cfg >> PEBS_DATACFG_CNTR_SHIFT) & PEBS_DATACFG_CNTR_MASK)
>> +			      * sizeof(u64);
>> +			sz += hweight64((pebs_data_cfg >> PEBS_DATACFG_FIX_SHIFT) & PEBS_DATACFG_FIX_MASK)
>> +			      * sizeof(u64);
> 
> blergh, when splitting lines the operator goes on the end of the last
> line. These lines are too long anyway.
> 
> Maybe:
> 
> #define PEBS_DATACFG_CNTR(x) \
> 	((x >> PEBS_DATACFG_CNTR_SHIFT) & PEBS_DATACFG_CNTR_MASK)
> #define PEBS_DATACFG_FIX(x) \
> 	((x >> PEBS_DATACFG_FIX_SHIFT) & PEBS_DATACFG_FIX_MASK)
> 
> 			sz += (hweight64(PEBS_DATACFG_CNTR(pebs_data_cfg)) +
> 			       hweight64(PEBS_DATACFG_FIX(pebs_data_cfg)))) *
> 			      sizeof(u64);
> 
>> +		}
>> +	}
>>  
>>  	cpuc->pebs_record_size = sz;
>>  }
>>  
>> +static void __intel_pmu_pebs_update_cfg(struct perf_event *event,
>> +					int idx, u64 *pebs_data_cfg)
>> +{
>> +	if (is_metric_event(event)) {
>> +		*pebs_data_cfg |= PEBS_DATACFG_METRICS;
>> +		return;
>> +	}
>> +
>> +	*pebs_data_cfg |= PEBS_DATACFG_CNTR;
>> +
>> +	if (idx >= INTEL_PMC_IDX_FIXED) {
>> +		*pebs_data_cfg |= ((1ULL << (idx - INTEL_PMC_IDX_FIXED)) & PEBS_DATACFG_FIX_MASK)
>> +				  << PEBS_DATACFG_FIX_SHIFT;
>> +	} else {
>> +		*pebs_data_cfg |= ((1ULL << idx) & PEBS_DATACFG_CNTR_MASK)
>> +				  << PEBS_DATACFG_CNTR_SHIFT;
> 
> Also yuck. Maybe:
> 
> #define PEBS_DATACFG_FIX_BIT(x) \
> 	(((1ULL << x) & PEBS_DATACFG_FIX_MASK) << PEBS_DATACFG_FIX_SHIFT)
> 
> 
> 	pebs_data_cfg |= PEBS_DATACFG_FIX_BIT(idx - INTEL_PMC_IDX_FIXED);
> 
> 
> 
>> +	}
>> +}
>> +
> 
> 
> 

