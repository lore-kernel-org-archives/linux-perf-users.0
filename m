Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650DC3A6EFA;
	Wed, 13 May 2026 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697801; cv=none; b=WKlX3u9UvljnywWjBimNxsnuIBKc5+vk+ofeOx0vX9y4CD+vCJ7Qmd5TgEpYU3M5LONxNW1OduVfUDLTN6jCOc4Q/vbYVdkjPmowhubBBH3Pdq6ydm3gU+prTw/9c+Iip5sbDe3H3AtqDwpoZ2Q2HkacJM0V9hlnBF3DloV0phI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697801; c=relaxed/simple;
	bh=f1sX5pUZqGIzGTAMWYuRtNovZ3njN2HVqkXsM5gT4Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkJK7CS9fJDxyTxyi4gbvKsEWK8ZSmCki5ntNUNvEZ/n3lpcxDCW/g91WuF0GgCLB4papLe2vFjLdw39Tz4CnSE+aLEqGWFADvDLOctJeFpesYtFTEEs0j0CAQ3SHXgixQy55dIz3FpmKTahME+IKlgjLSTd/MU2hwPWGoSy1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lv3EEqwy; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lv3EEqwy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778697799; x=1810233799;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f1sX5pUZqGIzGTAMWYuRtNovZ3njN2HVqkXsM5gT4Bc=;
  b=lv3EEqwy2mNKpiJ13QvzQ0L40bBGCBfvTCyVimk62FkHJjbMWl0erlys
   0VYaxux0/rCCptMEoWUsFbkhoT1NRY5cjST7o99r5KQc0ldQBvIyoyxj3
   CVYsiBl0x0O1V5aTCkdFLKOcvb6L0sFRO28leu9uwztA2nq/hM29qnMU3
   6ivdMC5jSL6hc7c39RJ4CXlF7lHjhfwsW9K7PohoA4mmPCbYEm3xZxISu
   /tzVPb2sCgxFF3nTYqCLQEslb+d9k4oRQYzaDzsdRkKRwgtV6NUE9UQia
   1x/T3e+0qw0OPDdpjqg6e+udnxhh9Sa4HE39fPKM1+pw6kFOjSmk0+FR2
   A==;
X-CSE-ConnectionGUID: FoRM8nKkSdiurn6V0YOfzg==
X-CSE-MsgGUID: q+BuxGTSRHyZucKASMEAHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79530335"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79530335"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 11:43:18 -0700
X-CSE-ConnectionGUID: d+F2dxCiT1aEoZUO0BRdaw==
X-CSE-MsgGUID: NefVp/7RSwuSOQZPviqvuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="235491870"
Received: from unknown (HELO [10.241.241.90]) ([10.241.241.90])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 11:43:18 -0700
Message-ID: <f31f8dca-4b61-4a99-883c-1d380ab2434a@intel.com>
Date: Wed, 13 May 2026 11:43:17 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] perf/x86/intel/uncore: Fix uncore_box ref/unref
 ordering on CPU hotplug
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260512233048.9577-1-zide.chen@intel.com>
 <20260512233048.9577-7-zide.chen@intel.com>
 <f1bd7228-d809-4e62-88d4-a5c17ba44723@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <f1bd7228-d809-4e62-88d4-a5c17ba44723@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/2026 1:59 AM, Mi, Dapeng wrote:
> 
> On 5/13/2026 7:30 AM, Zide Chen wrote:
>> In uncore_event_cpu_online(), uncore_box_ref() was called before
>> uncore_change_context().  uncore_box_ref() gates on box->cpu >= 0,
>> but box->cpu is still -1 at that point because uncore_change_context()
>> has not run yet.  As a result, the box is never initialized on the
>> first CPU to come online in a die, leaving it permanently
>> uninitialized in the single-CPU-per-die case.
>>
>> Thus, cpu_refcnt is one count below the true value, and in the CPU
>> offline path, the box will be torn down on the second-to-last CPU.
>>
>> In uncore_event_cpu_offline(), uncore_box_unref() was called after
>> uncore_change_context(), so box->cpu is already -1 when the collector
>> CPU goes offline, which prevents it from tearing down the box.
>>
>> Fix by swapping the call order in both paths so that
>> uncore_box_{ref,unref}() runs at the point where box->cpu reflects
>> the correct context.
>>
>> Fixes: c74443d92f68 ("perf/x86/uncore: Support per PMU cpumask")
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/events/intel/uncore.c | 56 ++++++++++++++++++----------------
>>  1 file changed, 29 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 922ba299533e..399f434e1a7d 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -1574,9 +1574,15 @@ static int uncore_event_cpu_offline(unsigned int cpu)
>>  {
>>  	int die, target;
>>  
>> +	/* Clear the references */
>> +	die = topology_logical_die_id(cpu);
>> +	uncore_box_unref(uncore_msr_uncores, die);
>> +	uncore_box_unref(uncore_mmio_uncores, die);
>> +
>>  	/* Check if exiting cpu is used for collecting uncore events */
>>  	if (!cpumask_test_and_clear_cpu(cpu, &uncore_cpu_mask))
>> -		goto unref;
>> +		return 0;
>> +
>>  	/* Find a new cpu to collect uncore events */
>>  	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
>>  
>> @@ -1589,20 +1595,14 @@ static int uncore_event_cpu_offline(unsigned int cpu)
>>  	uncore_change_context(uncore_msr_uncores, cpu, target);
>>  	uncore_change_context(uncore_mmio_uncores, cpu, target);
>>  	uncore_change_context(uncore_pci_uncores, cpu, target);
>> -
>> -unref:
>> -	/* Clear the references */
>> -	die = topology_logical_die_id(cpu);
>> -	uncore_box_unref(uncore_msr_uncores, die);
>> -	uncore_box_unref(uncore_mmio_uncores, die);
>>  	return 0;
>>  }
>>  
>> -static int allocate_boxes(struct intel_uncore_type **types,
>> +static void allocate_boxes(struct intel_uncore_type **types,
>>  			 unsigned int die, unsigned int cpu)
>>  {
>>  	struct intel_uncore_box *box, *tmp;
>> -	struct intel_uncore_type *type;
>> +	struct intel_uncore_type *type, **start = types;
>>  	struct intel_uncore_pmu *pmu;
>>  	LIST_HEAD(allocated);
>>  	int i;
>> @@ -1627,14 +1627,21 @@ static int allocate_boxes(struct intel_uncore_type **types,
>>  		list_del_init(&box->active_list);
>>  		box->pmu->boxes[die] = box;
>>  	}
>> -	return 0;
>> +	return;
>>  
>>  cleanup:
>>  	list_for_each_entry_safe(box, tmp, &allocated, active_list) {
>>  		list_del_init(&box->active_list);
>>  		kfree(box);
>>  	}
>> -	return -ENOMEM;
>> +
>> +	/* mark the PMU broken to prevent future ussage. */
>> +	for (; *start; start++) {
>> +		type = *start;
>> +		pmu = type->pmus;
>> +		for (i = 0; i < type->num_boxes; i++, pmu++)
>> +			uncore_pmu_set_broken(pmu);
>> +	}
> 
> It looks all PMUs of all types are set to be broken even the boxes
> allocation of some PMUs didn't fail. Could we set the only the failed and
> later PMUs to be broken?

Right, it should simply set one PMU broken:
-                       if (!box)
+                       if (!box) {
+                               uncore_pmu_set_broken(pmu);
                                goto cleanup;
+                       }

>>  }
>>  
>>  static int uncore_box_ref(struct intel_uncore_type **types,
>> @@ -1643,11 +1650,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
>>  	struct intel_uncore_type *type;
>>  	struct intel_uncore_pmu *pmu;
>>  	struct intel_uncore_box *box;
>> -	int i, ret;
>> -
>> -	ret = allocate_boxes(types, die, cpu);
>> -	if (ret)
>> -		return ret;
>> +	int i;
>>  
>>  	for (; *types; types++) {
>>  		type = *types;
>> @@ -1664,27 +1667,26 @@ static int uncore_box_ref(struct intel_uncore_type **types,
>>  
>>  static int uncore_event_cpu_online(unsigned int cpu)
>>  {
>> -	int die, target, msr_ret, mmio_ret;
>> +	int die, target;
>>  
>>  	die = topology_logical_die_id(cpu);
>> -	msr_ret = uncore_box_ref(uncore_msr_uncores, die, cpu);
>> -	mmio_ret = uncore_box_ref(uncore_mmio_uncores, die, cpu);
>> +	allocate_boxes(uncore_msr_uncores, die, cpu);
>> +	allocate_boxes(uncore_mmio_uncores, die, cpu);
>>  
>>  	/*
>>  	 * Check if there is an online cpu in the package
>>  	 * which collects uncore events already.
>>  	 */
>>  	target = cpumask_any_and(&uncore_cpu_mask, topology_die_cpumask(cpu));
>> -	if (target < nr_cpu_ids)
>> -		return 0;
>> -
>> -	cpumask_set_cpu(cpu, &uncore_cpu_mask);
>> -
>> -	if (!msr_ret)
>> +	if (target >= nr_cpu_ids) {
>> +		cpumask_set_cpu(cpu, &uncore_cpu_mask);
>>  		uncore_change_context(uncore_msr_uncores, -1, cpu);
>> -	if (!mmio_ret)
>>  		uncore_change_context(uncore_mmio_uncores, -1, cpu);
>> -	uncore_change_context(uncore_pci_uncores, -1, cpu);
>> +		uncore_change_context(uncore_pci_uncores, -1, cpu);
>> +	}
>> +
>> +	uncore_box_ref(uncore_msr_uncores, die, cpu);
>> +	uncore_box_ref(uncore_mmio_uncores, die, cpu);
>>  	return 0;
>>  }
>>  

