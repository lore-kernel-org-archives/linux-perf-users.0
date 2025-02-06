Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7561624D4;
	Thu,  6 Feb 2025 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738854113; cv=none; b=gPsTlHseSkXMzMhPm+dzFFcmorfEMTY4FqI5i+de3rPxsZ6ozK994pEC+ECDveKLbTo8dg94n1V+rrk6sekz7Id4HOUUumKzVpMOs0Cz3NiSrY983xh7cu6Psanmm/JTI1rjwgMFILKl/fxnQkmcY4mOSKKIvfmcOXqqlOC0Ev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738854113; c=relaxed/simple;
	bh=ygPGbTCM/PVy4HlH+Dd1yrCQqg3MzBk6HpQSOnvkrRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgWrRGD5NlTgdTTXpSnEQLqtSeOsCblEwRrDRakMLc8AN8IunJbmUtmzUn5o4ztMDLXJ3lCCRCbp8XKXk3EZVY/SYvZ7IBVKsSkwSldqFqk3529FYymDs1R7sKUFt3+6jimvlkGWRuFgl82LvFq9HmoYtBp2rBEBNR7rrTBUGQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbRsD7Nv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbRsD7Nv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738854112; x=1770390112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ygPGbTCM/PVy4HlH+Dd1yrCQqg3MzBk6HpQSOnvkrRs=;
  b=DbRsD7NvUf2NZ8O4I3QcqEKtQEeYv4v8aPKbIyoGcnoqQVtDJh4SrstD
   uuDQNtybVmr5sgHWU+/wxPPyetFNh247Al6GZFLuLFo5b4dDwleclWLHC
   xhMsMuN8FyVzmlQOCds5+VbKYP9s9XHiA9teU+LWHSjg49D7WNpdRFh2B
   xU4pqUiD/myKKcCIx/JQ4hY+JqNsxdF7nOkFTygCZBsVqIvTA3bGt4H7C
   zsSJPApiZqP057+eSpDoUMWlslqbEBEp4zvEJpGHI7ovWkTMzywvAwvmL
   B57Uq9Ry1whGq4zzG9YoOjAvE3e57JkK6d62Nwp8Ju/Lb9OfkRbpmjEaf
   A==;
X-CSE-ConnectionGUID: iUBYHeeOR6OR3i63G2KISQ==
X-CSE-MsgGUID: /Yn9MkcyQN6jc/aavkM/ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39357494"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="39357494"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 07:01:51 -0800
X-CSE-ConnectionGUID: VoHBk7z0SGmokJKKgiWfIQ==
X-CSE-MsgGUID: xSMmApdfRC2XgiFg9E9kNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="142115505"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 07:01:51 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E7B2720B5713;
	Thu,  6 Feb 2025 07:01:48 -0800 (PST)
Message-ID: <e123a3c7-098b-4caf-9f69-601a435bda70@linux.intel.com>
Date: Thu, 6 Feb 2025 10:01:47 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/20] perf/x86/intel: Setup PEBS constraints base on
 counter & pdist map
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-12-dapeng1.mi@linux.intel.com>
 <f198c454-ff7c-42eb-80f8-45bc4b94210d@linux.intel.com>
 <1338dd77-e9c1-4eac-9d0f-195829acdd2a@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <1338dd77-e9c1-4eac-9d0f-195829acdd2a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-05 9:47 p.m., Mi, Dapeng wrote:
> 
> On 1/28/2025 12:07 AM, Liang, Kan wrote:
>>
>> On 2025-01-23 9:07 a.m., Dapeng Mi wrote:
>>> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
>>> sampling and precise distribution PEBS sampling. Thus PEBS constraints
>>> can be dynamically configured base on these counter and precise
>>> distribution bitmap instead of defining them statically.
>>>
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> ---
>>>  arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
>>>  arch/x86/events/intel/ds.c   |  1 +
>>>  2 files changed, 21 insertions(+)
>>>
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index 7775e1e1c1e9..0f1be36113fa 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -3728,6 +3728,7 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>>  			    struct perf_event *event)
>>>  {
>>>  	struct event_constraint *c1, *c2;
>>> +	struct pmu *pmu = event->pmu;
>>>  
>>>  	c1 = cpuc->event_constraint[idx];
>>>  
>>> @@ -3754,6 +3755,25 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>>  		c2->weight = hweight64(c2->idxmsk64);
>>>  	}
>>>  
>>> +	if (x86_pmu.arch_pebs && event->attr.precise_ip) {
>>> +		u64 pebs_cntrs_mask;
>>> +		u64 cntrs_mask;
>>> +
>>> +		if (event->attr.precise_ip >= 3)
>>> +			pebs_cntrs_mask = hybrid(pmu, arch_pebs_cap).pdists;
>>> +		else
>>> +			pebs_cntrs_mask = hybrid(pmu, arch_pebs_cap).counters;
>>> +
>>> +		cntrs_mask = hybrid(pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED |
>>> +			     hybrid(pmu, cntr_mask64);
>>> +
>>> +		if (pebs_cntrs_mask != cntrs_mask) {
>>> +			c2 = dyn_constraint(cpuc, c2, idx);
>>> +			c2->idxmsk64 &= pebs_cntrs_mask;
>>> +			c2->weight = hweight64(c2->idxmsk64);
>>> +		}
>>> +	}
>> The pebs_cntrs_mask and cntrs_mask wouldn't be changed since the machine
>> boot. I don't think it's efficient to calculate them every time.
>>
>> Maybe adding a local pebs_event_constraints_pdist[] and update both
>> pebs_event_constraints[] and pebs_event_constraints_pdist[] with the
>> enumerated mask at initialization time.
>>
>> Update the intel_pebs_constraints() to utilize the corresponding array
>> according to the precise_ip.
>>
>> The above may be avoided.
> 
> Even we have these two arrays, we still need the dynamic constraint, right?
> We can't predict what the event is, the event may be mapped to a quite
> specific event constraint and we can know it in advance.

The dynamic constraint is not necessary, but two arrays seems not
enough. Because a PEBS event may fall back to the event_constraints as
well. Sigh.
Four arrays should be required. pebs_event_constraints[],
pebs_event_constraints_pdist[], event_constraints_for_pebs[],
event_constraints_for_pdist_pebs[].
But it seems too complicated. It may not be implemented now.

But, at least the pebs_cntrs_mask and cntrs_mask can be calculated in
the hw_config(), or even intel_pmu_init() once. It should not be
calculated every time in the critical path.

Thanks,
Kan
> 
> 
>>
>> Thanks,
>> Kan
>>
>>> +
>>>  	return c2;
>>>  }
>>>  
>>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>>> index 2f2c6b7c801b..a573ce0e576a 100644
>>> --- a/arch/x86/events/intel/ds.c
>>> +++ b/arch/x86/events/intel/ds.c
>>> @@ -2941,6 +2941,7 @@ static void __init intel_arch_pebs_init(void)
>>>  	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
>>>  	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
>>>  	x86_pmu.pebs_capable = ~0ULL;
>>> +	x86_pmu.flags |= PMU_FL_PEBS_ALL;
>>>  }
>>>  
>>>  /*
> 

