Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1C4C8F;
	Wed,  5 Mar 2025 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138895; cv=none; b=ag4hMxXxZ4FcwSARiMbakYDt2SI+YzeqRtu4KB6FCtTovSBKB6g9bn/wpZNu3AGGakBUX9MtA16nxsdgQLAMTpdELPQ+iWgrNfK3du40VmLdrggUS5Hoh0pMEbuHb15B7R4eDaoKDajv0Yvn8qaK9nDbe6ZoirQVn/huTY0E6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138895; c=relaxed/simple;
	bh=we7gVSDwOrHiHsKUcyKkJPqMAz8+16UeGux/dgmOjpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ur3M+Ll9xYlGH63FkHAkXV9G29gNxm0gfRPFYyGiR+r+ynR2HiA9g5PghbTQrXcaVzf6ya6mgZ+pYtG3wwWCqF3bYsUqfU/mJHSxu3UTyh/h6UHjwatYKmokOE5/1uYmWaOoTluKQJbimY48IUQPOdlHAnoL0vnh2zOlABBDYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJTIn91g; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJTIn91g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741138895; x=1772674895;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=we7gVSDwOrHiHsKUcyKkJPqMAz8+16UeGux/dgmOjpM=;
  b=jJTIn91ghjcMGk+CeedZJh8a3XJLEVfmdqB7N62sruZioF1pn+CElGQw
   9VXb54uLxpNglW3adAOxIcLxQAJIXj9Hj8vaB8jRKUda/aD8+2XfXsK9g
   +g/3Dt8a37AYifNrRhgyAP//ku1AZX4T4l9+RQVrgZIc0ga/6zzwVvlv9
   pA3xCt5pA8olfCZya3zdGmMxOS4r7r5cFSFshKi4IcqRdE4XznE/GT9oO
   lyiKqd2NU9qy5aKXNgHM37MYf9BjI5Z0NDR69UTy+46ATPZW1oxyjXKji
   i1QkD3Kp6J/86uAOre+vZ4WO/r4B2bXjLUvnDTXAw4KaE7zFK4rgbcZUi
   Q==;
X-CSE-ConnectionGUID: IT8f9VSuSVGdiq7cqq0ncQ==
X-CSE-MsgGUID: UNj7ZPX7T6Smc6s/MeJUsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42109144"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="42109144"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 17:41:34 -0800
X-CSE-ConnectionGUID: 3szEw2DeRnKO40PJSlYBzQ==
X-CSE-MsgGUID: k2M+gLJBTPyeqXesPisk0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119050926"
Received: from unknown (HELO [10.238.2.135]) ([10.238.2.135])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 17:41:31 -0800
Message-ID: <0496c7b0-098c-4b2f-9c71-a258a398c5a8@linux.intel.com>
Date: Wed, 5 Mar 2025 09:41:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 13/24] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-14-dapeng1.mi@linux.intel.com>
 <afdc5b07-9795-4049-8941-c2e3d2bbaa87@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <afdc5b07-9795-4049-8941-c2e3d2bbaa87@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/27/2025 10:06 PM, Liang, Kan wrote:
>
> On 2025-02-18 10:28 a.m., Dapeng Mi wrote:
>> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
>> sampling and precise distribution PEBS sampling. Thus PEBS constraints
>> should be dynamically configured base on these counter and precise
>> distribution bitmap instead of defining them statically.
>>
>> Update event dyn_constraint base on PEBS event precise level.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 6 ++++++
>>  arch/x86/events/intel/ds.c   | 1 +
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 472366c3db22..c777e0531d40 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4033,6 +4033,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  		return ret;
>>  
>>  	if (event->attr.precise_ip) {
>> +		struct arch_pebs_cap pebs_cap = hybrid(event->pmu, arch_pebs_cap);
>> +
>>  		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
>>  			return -EINVAL;
>>  
>> @@ -4046,6 +4048,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  		}
>>  		if (x86_pmu.pebs_aliases)
>>  			x86_pmu.pebs_aliases(event);
>> +
>> +		if (x86_pmu.arch_pebs)
>> +			event->hw.dyn_constraint = event->attr.precise_ip >= 3 ?
>> +						   pebs_cap.pdists : pebs_cap.counters;
>>  	}
> The dyn_constraint is only required when the counter mask is different.
> I think the pebs_cap.counters should be very likely the same as the
> regular counter mask. Maybe something as below (not test).
>
> 	if (x86_pmu.arch_pebs) {
> 		u64 cntr_mask = event->attr.precise_ip >= 3 ?
> 				pebs_cap.pdists : pebs_cap.counters;
> 		if (cntr_mask != hybrid(event->pmu, intel_ctrl))
> 			event->hw.dyn_constraint = cntr_mask;
> 	}

Sure. Thanks.


>
> Thanks,
> Kan
>>  
>>  	if (needs_branch_stack(event)) {
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 519767fc9180..615aefb4e52e 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -2948,6 +2948,7 @@ static void __init intel_arch_pebs_init(void)
>>  	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
>>  	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
>>  	x86_pmu.pebs_capable = ~0ULL;
>> +	x86_pmu.flags |= PMU_FL_PEBS_ALL;
>>  
>>  	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
>>  	x86_pmu.pebs_disable = __intel_pmu_pebs_disable;
>
