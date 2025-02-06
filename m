Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC6528F1;
	Thu,  6 Feb 2025 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810062; cv=none; b=CGOD4bS2Rwx9QRvqy9FEd4OlkCAP8LAXIAQfZQ3ZpB1RGvMTbQbTTzf+jgq5eLHE8xNrmGiFQaFncVH+ANGHXLfvH7/oo1EgFYD7SjQc9e6i0X1izm6lS1TZYOSl0h7P1YiwQgSKT4y2Vmj75Br0tJ4G28QFjbBt5QUaeGCk1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810062; c=relaxed/simple;
	bh=PrMvwKGi5UtfKPCyJ5rO/LHY9qldWhYmTBGh91OnIJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiHR3axE3px42hcuA2xS6WY1PaTFeJ30ZzDYoVAYpOmJNkRlsCwI/D2ayj8NeuaCR7v3Fe0aWymO0cBlaxMq+oHG+rmXmBJidI1XTRQzYBcB7R0NcOVDJUPsle3GG+GPQg+onrZOFxmsK1J22JgrwcP+0DqXJVxqytD5HXkcgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SO2FWV8m; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SO2FWV8m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738810060; x=1770346060;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PrMvwKGi5UtfKPCyJ5rO/LHY9qldWhYmTBGh91OnIJo=;
  b=SO2FWV8mZLbEhRIrNIhNDRCgsuCTlkcIf6xKzJF0THYHU+ejm9kvNqDp
   ikUdoMumd3fK2xSamyK16om5VNo+ces1jteEnBdFIAAT0t9l/Wqg9bjH9
   q26vVLaKOoG7Bww480lCLa/MPmUV3jttIwwkOWJNzJgWaL+9HMqr2Vim1
   aNtn6MY0oMNClGgIa1NgkgPbE9s+rqEcWB62O6WpU5qcrDQJHrUVcL9Cm
   LGyYo8CEgfgNkekSe9EDSpr8sse/z1jzwD5mW7IVZWSY5+FMpQ3A23gaG
   hYpDdqGudmuOHPgloqFidr9XTvyx6aVSnKd45ix79XYJZpHp9rHP4K6Ov
   A==;
X-CSE-ConnectionGUID: cuu662vmRjK7ZhzhSIuOHw==
X-CSE-MsgGUID: amIapsBKSMil+TT6pSlFyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39294538"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="39294538"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:47:39 -0800
X-CSE-ConnectionGUID: HQ1p4ZwkTjmy+I8LaPNb7g==
X-CSE-MsgGUID: CeBRXcb6QxOLe7aqAYAqlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="111052791"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:47:32 -0800
Message-ID: <1338dd77-e9c1-4eac-9d0f-195829acdd2a@linux.intel.com>
Date: Thu, 6 Feb 2025 10:47:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/20] perf/x86/intel: Setup PEBS constraints base on
 counter & pdist map
To: "Liang, Kan" <kan.liang@linux.intel.com>,
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
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <f198c454-ff7c-42eb-80f8-45bc4b94210d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/28/2025 12:07 AM, Liang, Kan wrote:
>
> On 2025-01-23 9:07 a.m., Dapeng Mi wrote:
>> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
>> sampling and precise distribution PEBS sampling. Thus PEBS constraints
>> can be dynamically configured base on these counter and precise
>> distribution bitmap instead of defining them statically.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
>>  arch/x86/events/intel/ds.c   |  1 +
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 7775e1e1c1e9..0f1be36113fa 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3728,6 +3728,7 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>  			    struct perf_event *event)
>>  {
>>  	struct event_constraint *c1, *c2;
>> +	struct pmu *pmu = event->pmu;
>>  
>>  	c1 = cpuc->event_constraint[idx];
>>  
>> @@ -3754,6 +3755,25 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>  		c2->weight = hweight64(c2->idxmsk64);
>>  	}
>>  
>> +	if (x86_pmu.arch_pebs && event->attr.precise_ip) {
>> +		u64 pebs_cntrs_mask;
>> +		u64 cntrs_mask;
>> +
>> +		if (event->attr.precise_ip >= 3)
>> +			pebs_cntrs_mask = hybrid(pmu, arch_pebs_cap).pdists;
>> +		else
>> +			pebs_cntrs_mask = hybrid(pmu, arch_pebs_cap).counters;
>> +
>> +		cntrs_mask = hybrid(pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED |
>> +			     hybrid(pmu, cntr_mask64);
>> +
>> +		if (pebs_cntrs_mask != cntrs_mask) {
>> +			c2 = dyn_constraint(cpuc, c2, idx);
>> +			c2->idxmsk64 &= pebs_cntrs_mask;
>> +			c2->weight = hweight64(c2->idxmsk64);
>> +		}
>> +	}
> The pebs_cntrs_mask and cntrs_mask wouldn't be changed since the machine
> boot. I don't think it's efficient to calculate them every time.
>
> Maybe adding a local pebs_event_constraints_pdist[] and update both
> pebs_event_constraints[] and pebs_event_constraints_pdist[] with the
> enumerated mask at initialization time.
>
> Update the intel_pebs_constraints() to utilize the corresponding array
> according to the precise_ip.
>
> The above may be avoided.

Even we have these two arrays, we still need the dynamic constraint, right?
We can't predict what the event is, the event may be mapped to a quite
specific event constraint and we can know it in advance.


>
> Thanks,
> Kan
>
>> +
>>  	return c2;
>>  }
>>  
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 2f2c6b7c801b..a573ce0e576a 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -2941,6 +2941,7 @@ static void __init intel_arch_pebs_init(void)
>>  	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
>>  	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
>>  	x86_pmu.pebs_capable = ~0ULL;
>> +	x86_pmu.flags |= PMU_FL_PEBS_ALL;
>>  }
>>  
>>  /*
