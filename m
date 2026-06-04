Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1821CAA65;
	Thu,  4 Jun 2026 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535820; cv=none; b=M/aX3YEUQ//7+blBNXbDRtKmce2ck1mlJ1Y5jpOxKfhrXur1niwRwBKFzD1LhXpKOGr7W6WDhrHYuG+qz9IPD7Ie2RfhdOyz29NGkPO3ETF+eSMVkANZGrpZuJw6WOsYnTnKgMy/PkjCv7Vne/6dDu6ZsknT7J4Y3tfLPzm5FD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535820; c=relaxed/simple;
	bh=jhpLQHbjADtMpDWfymkbSPayOxzC9XshmSnh2S/O96s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPXQStDWpeTJ7OqH2Yx5LQSrlgT4a31SqZFDyqPSH1o7y0gj4XMpylphm3gy093N8oFz156UouRttSpUsZlBXKy+lMSKIqLrw+EST5tq3gB1R2sTdC7gAJIDGLRFu1RVB7DDGjptSJPcDrF1davwSDZ+10MTabu6i4dlt516ZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1hUPAUq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1hUPAUq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780535819; x=1812071819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jhpLQHbjADtMpDWfymkbSPayOxzC9XshmSnh2S/O96s=;
  b=Z1hUPAUqszvMc7q58w8mfeL719VYYjbbLEhb2kh8LwY3Rgl8Ga2B5d1L
   ikhgarnwS1ncUmrvRrUp04/Ic87sHmyHkTTkiOyRMzodTQ6L2fI0rmCqB
   jsxIKiYZF8ZFrbmC/y7R0nkL0lRDevDutRBPN3JsfT/+JIqw5Gj8XGMWL
   aKctw8M/vi2Nyl6GndmQaWdpVDaBIlMjAGg2tab6rkbMoKBpqnhLPo2r8
   VfV3EpNu1tSRJrR12N094W5REEwwsOLqm9vJPUB2ylDvjgqOteFr65WIk
   uCkv6kRAaMAcTkDQG7y6F/+M6lSTAKL5xgClfk2YRu3d9bYjs7caJDVAt
   A==;
X-CSE-ConnectionGUID: /SxoBD+0S+ynD85XIIiVNw==
X-CSE-MsgGUID: YPhwATzARHCfCwbohYHdXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92842238"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92842238"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 18:16:59 -0700
X-CSE-ConnectionGUID: K7Kndt/4SD6urXtr4XvPQQ==
X-CSE-MsgGUID: PLUNycZrTReixpI5ybaYZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="238063200"
Received: from unknown (HELO [10.238.1.64]) ([10.238.1.64])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 18:16:56 -0700
Message-ID: <d01e4434-7a6a-4e40-9118-39ede3288273@linux.intel.com>
Date: Thu, 4 Jun 2026 09:16:54 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/8] perf/x86/intel/uncore: Fix uncore_box ref/unref
 ordering on CPU hotplug
To: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260601170114.173359-1-zide.chen@intel.com>
 <20260601170114.173359-8-zide.chen@intel.com>
 <74ab79eb-57c8-4a63-b401-b56b0483a5a5@linux.intel.com>
 <254ffa5b-58b7-4eb4-b944-a59c0bc67f2a@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <254ffa5b-58b7-4eb4-b944-a59c0bc67f2a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/4/2026 12:40 AM, Chen, Zide wrote:
>
> On 6/2/2026 9:32 PM, Mi, Dapeng wrote:
>> On 6/2/2026 1:01 AM, Zide Chen wrote:
>>> In uncore_event_cpu_online(), uncore_box_ref() was called before
>>> uncore_change_context().  uncore_box_ref() gates on box->cpu >= 0,
>>> but box->cpu is still -1 at that point because uncore_change_context()
>>> has not run yet.  As a result, the box is never initialized on the
>>> first CPU to come online in a die, leaving it permanently
>>> uninitialized in the single-CPU-per-die case.
>>>
>>> Thus, box->refcnt is one count below the true value, and in the CPU
>>> offline path, the box will be torn down on the second-to-last CPU.
>>>
>>> In uncore_event_cpu_offline(), uncore_box_unref() was called after
>>> uncore_change_context(), so box->cpu is already -1 when the collector
>>> CPU goes offline, which prevents it from tearing down the box.
>>>
>>> Fix by swapping the call order in both paths so that
>>> uncore_box_{ref,unref}() runs at the point where box->cpu reflects
>>> the correct context.
>>>
>>> Fixes: c74443d92f68 ("perf/x86/uncore: Support per PMU cpumask")
>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>>  arch/x86/events/intel/uncore.c | 50 ++++++++++++++++------------------
>>>  1 file changed, 23 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>>> index f2cb3fde2dda..6d710aef52ac 100644
>>> --- a/arch/x86/events/intel/uncore.c
>>> +++ b/arch/x86/events/intel/uncore.c
>>> @@ -1577,9 +1577,15 @@ static int uncore_event_cpu_offline(unsigned int cpu)
>>>  {
>>>  	int die, target;
>>>  
>>> +	/* Clear the references */
>>> +	die = topology_logical_die_id(cpu);
>>> +	uncore_box_unref(uncore_msr_uncores, die);
>>> +	uncore_box_unref(uncore_mmio_uncores, die);
>>> +
>>>  	/* Check if exiting cpu is used for collecting uncore events */
>>>  	if (!cpumask_test_and_clear_cpu(cpu, &uncore_cpu_mask))
>>> -		goto unref;
>>> +		return 0;
>>> +
>>>  	/* Find a new cpu to collect uncore events */
>>>  	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
>>>  
>>> @@ -1592,16 +1598,10 @@ static int uncore_event_cpu_offline(unsigned int cpu)
>>>  	uncore_change_context(uncore_msr_uncores, cpu, target);
>>>  	uncore_change_context(uncore_mmio_uncores, cpu, target);
>>>  	uncore_change_context(uncore_pci_uncores, cpu, target);
>>> -
>>> -unref:
>>> -	/* Clear the references */
>>> -	die = topology_logical_die_id(cpu);
>>> -	uncore_box_unref(uncore_msr_uncores, die);
>>> -	uncore_box_unref(uncore_mmio_uncores, die);
>>>  	return 0;
>>>  }
>>>  
>>> -static int allocate_boxes(struct intel_uncore_type **types,
>>> +static void allocate_boxes(struct intel_uncore_type **types,
>>>  			 unsigned int die, unsigned int cpu)
>>>  {
>>>  	struct intel_uncore_box *box, *tmp;
>>> @@ -1618,8 +1618,10 @@ static int allocate_boxes(struct intel_uncore_type **types,
>>>  			if (pmu->boxes[die] || uncore_pmu_broken(pmu))
>>>  				continue;
>>>  			box = uncore_alloc_box(type, cpu_to_node(cpu));
>>> -			if (!box)
>>> +			if (!box) {
>>> +				uncore_pmu_set_broken(pmu);
>>>  				goto cleanup;
>>> +			}
>>>  			box->pmu = pmu;
>>>  			box->dieid = die;
>>>  			list_add(&box->active_list, &allocated);
>>> @@ -1630,14 +1632,13 @@ static int allocate_boxes(struct intel_uncore_type **types,
>>>  		list_del_init(&box->active_list);
>>>  		box->pmu->boxes[die] = box;
>>>  	}
>>> -	return 0;
>>> +	return;
>>>  
>>>  cleanup:
>>>  	list_for_each_entry_safe(box, tmp, &allocated, active_list) {
>>>  		list_del_init(&box->active_list);
>>>  		kfree(box);
>>>  	}
>>> -	return -ENOMEM;
>>>  }
>>>  
>>>  static int uncore_box_ref(struct intel_uncore_type **types,
>>> @@ -1646,11 +1647,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
>>>  	struct intel_uncore_type *type;
>>>  	struct intel_uncore_pmu *pmu;
>>>  	struct intel_uncore_box *box;
>>> -	int i, ret;
>>> -
>>> -	ret = allocate_boxes(types, die, cpu);
>>> -	if (ret)
>>> -		return ret;
>>> +	int i;
>>>  
>>>  	for (; *types; types++) {
>>>  		type = *types;
>>> @@ -1666,27 +1663,26 @@ static int uncore_box_ref(struct intel_uncore_type **types,
>>>  
>>>  static int uncore_event_cpu_online(unsigned int cpu)
>>>  {
>>> -	int die, target, msr_ret, mmio_ret;
>>> +	int die, target;
>>>  
>>>  	die = topology_logical_die_id(cpu);
>>> -	msr_ret = uncore_box_ref(uncore_msr_uncores, die, cpu);
>>> -	mmio_ret = uncore_box_ref(uncore_mmio_uncores, die, cpu);
>>> +	allocate_boxes(uncore_msr_uncores, die, cpu);
>>> +	allocate_boxes(uncore_mmio_uncores, die, cpu);
>> allocate_boxes() are moved to uncore_event_cpu_online() from
>> uncore_box_ref(). It's a significant and good change since PCI uncore PMUs
>> doesn't call allocate_boxes(), but the commit message doesn't mention this.
>> We'd better extract this change to a separate patch which would make the
>> changes clearer. Thanks.
> All the functions involved in this patch are not called in PCI PMUs, and
> the call graph is not complicated with only one or two callers for each
> of them.
>
> Splitting it into two patches may be overkill; additionally, it may lose
> the big picture and make it harder to understand the overall flow.

Ok, if we still prefer keep them in same patch, please mention the movement
of allocate_boxes() in the change log. Thanks.


>> Others look good to me.
>>
>>
>>>  
>>>  	/*
>>>  	 * Check if there is an online cpu in the package
>>>  	 * which collects uncore events already.
>>>  	 */
>>>  	target = cpumask_any_and(&uncore_cpu_mask, topology_die_cpumask(cpu));
>>> -	if (target < nr_cpu_ids)
>>> -		return 0;
>>> -
>>> -	cpumask_set_cpu(cpu, &uncore_cpu_mask);
>>> -
>>> -	if (!msr_ret)
>>> +	if (target >= nr_cpu_ids) {
>>> +		cpumask_set_cpu(cpu, &uncore_cpu_mask);
>>>  		uncore_change_context(uncore_msr_uncores, -1, cpu);
>>> -	if (!mmio_ret)
>>>  		uncore_change_context(uncore_mmio_uncores, -1, cpu);
>>> -	uncore_change_context(uncore_pci_uncores, -1, cpu);
>>> +		uncore_change_context(uncore_pci_uncores, -1, cpu);
>>> +	}
>>> +
>>> +	uncore_box_ref(uncore_msr_uncores, die, cpu);
>>> +	uncore_box_ref(uncore_mmio_uncores, die, cpu);
>>>  	return 0;
>>>  }
>>>  
