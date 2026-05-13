Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E63E9C10;
	Wed, 13 May 2026 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662757; cv=none; b=qccWQ+uQoC3u+uXGXL/0LZo8x6FfoRk4pcgldJQVS6mrrM7zZ4Kr3JM1pqWjKKCZv7RpgXOLBiF27+WoLvZZx3k+XYQSeurkyYo7uunnzJvLQgnHdu4eKL2FZrNMPVUD9KB2znPOR05Pqg7rkVQ6/qpbvTryc8mq59pNV8fmaqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662757; c=relaxed/simple;
	bh=PEVTgJ+WEITKcKHlM3A2AERVxB7EIIeMbzNifZFMaIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8LgXTAtWBnVpxRhbuxoLj1swDP2AOS/n2O5cjN1vPG4yVnsQ4wVzkiViag/EZPZuuqnh8nbI68aTs2lEFMbA3KEseBRwGWWL2L9TiTCfBr0g5nuOsANh2Gvng98IeYkBjQaSYgX/P7voogErXRdY9APegjixz3A0RUnJpI5mf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLzB0lXx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLzB0lXx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778662755; x=1810198755;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PEVTgJ+WEITKcKHlM3A2AERVxB7EIIeMbzNifZFMaIk=;
  b=CLzB0lXxWSrEjzzdvskiVAsL5yv0YptCZ59tvPh4wBiKYmiUIuvBAGqA
   jYtuxwgJSiAN2XZUQWRvo0nynF5ovuGfYq6tkRevKSk582bsJVvb/yVCP
   ISYrRawJmQpxefQNzNTS3ce1flce4k+aBP6qNIvVptrdkavHswB52jej/
   SjAkYB4OyZID7tOTMhfGL3V1MZsHz7PDGt4RHHoe7HrZXU3UkTKSbFDhr
   +aeOy07yiS+3X/fs9bEY7C7hU228ubviLnQ8mDVXatmlqbME14ZFvo3w9
   cEd6IUI1Gxlo1AweHILBq3Dh1YZfubOQC1qYM5eaGjep6QLeZ7HBTDoOf
   g==;
X-CSE-ConnectionGUID: GuwcmZyKQ+y2N7uhMnElBg==
X-CSE-MsgGUID: 5w+La3NuREqu7V/DNa89cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="97152172"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="97152172"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 01:59:15 -0700
X-CSE-ConnectionGUID: oIGyYMHwTLW0UKD1/rEzrA==
X-CSE-MsgGUID: 3RXCl4SaQqWZZ9hTG0lC4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="234959915"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 01:59:12 -0700
Message-ID: <f1bd7228-d809-4e62-88d4-a5c17ba44723@linux.intel.com>
Date: Wed, 13 May 2026 16:59:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] perf/x86/intel/uncore: Fix uncore_box ref/unref
 ordering on CPU hotplug
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260512233048.9577-1-zide.chen@intel.com>
 <20260512233048.9577-7-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260512233048.9577-7-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/13/2026 7:30 AM, Zide Chen wrote:
> In uncore_event_cpu_online(), uncore_box_ref() was called before
> uncore_change_context().  uncore_box_ref() gates on box->cpu >= 0,
> but box->cpu is still -1 at that point because uncore_change_context()
> has not run yet.  As a result, the box is never initialized on the
> first CPU to come online in a die, leaving it permanently
> uninitialized in the single-CPU-per-die case.
>
> Thus, cpu_refcnt is one count below the true value, and in the CPU
> offline path, the box will be torn down on the second-to-last CPU.
>
> In uncore_event_cpu_offline(), uncore_box_unref() was called after
> uncore_change_context(), so box->cpu is already -1 when the collector
> CPU goes offline, which prevents it from tearing down the box.
>
> Fix by swapping the call order in both paths so that
> uncore_box_{ref,unref}() runs at the point where box->cpu reflects
> the correct context.
>
> Fixes: c74443d92f68 ("perf/x86/uncore: Support per PMU cpumask")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore.c | 56 ++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 922ba299533e..399f434e1a7d 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1574,9 +1574,15 @@ static int uncore_event_cpu_offline(unsigned int cpu)
>  {
>  	int die, target;
>  
> +	/* Clear the references */
> +	die = topology_logical_die_id(cpu);
> +	uncore_box_unref(uncore_msr_uncores, die);
> +	uncore_box_unref(uncore_mmio_uncores, die);
> +
>  	/* Check if exiting cpu is used for collecting uncore events */
>  	if (!cpumask_test_and_clear_cpu(cpu, &uncore_cpu_mask))
> -		goto unref;
> +		return 0;
> +
>  	/* Find a new cpu to collect uncore events */
>  	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
>  
> @@ -1589,20 +1595,14 @@ static int uncore_event_cpu_offline(unsigned int cpu)
>  	uncore_change_context(uncore_msr_uncores, cpu, target);
>  	uncore_change_context(uncore_mmio_uncores, cpu, target);
>  	uncore_change_context(uncore_pci_uncores, cpu, target);
> -
> -unref:
> -	/* Clear the references */
> -	die = topology_logical_die_id(cpu);
> -	uncore_box_unref(uncore_msr_uncores, die);
> -	uncore_box_unref(uncore_mmio_uncores, die);
>  	return 0;
>  }
>  
> -static int allocate_boxes(struct intel_uncore_type **types,
> +static void allocate_boxes(struct intel_uncore_type **types,
>  			 unsigned int die, unsigned int cpu)
>  {
>  	struct intel_uncore_box *box, *tmp;
> -	struct intel_uncore_type *type;
> +	struct intel_uncore_type *type, **start = types;
>  	struct intel_uncore_pmu *pmu;
>  	LIST_HEAD(allocated);
>  	int i;
> @@ -1627,14 +1627,21 @@ static int allocate_boxes(struct intel_uncore_type **types,
>  		list_del_init(&box->active_list);
>  		box->pmu->boxes[die] = box;
>  	}
> -	return 0;
> +	return;
>  
>  cleanup:
>  	list_for_each_entry_safe(box, tmp, &allocated, active_list) {
>  		list_del_init(&box->active_list);
>  		kfree(box);
>  	}
> -	return -ENOMEM;
> +
> +	/* mark the PMU broken to prevent future ussage. */
> +	for (; *start; start++) {
> +		type = *start;
> +		pmu = type->pmus;
> +		for (i = 0; i < type->num_boxes; i++, pmu++)
> +			uncore_pmu_set_broken(pmu);
> +	}

It looks all PMUs of all types are set to be broken even the boxes
allocation of some PMUs didn't fail. Could we set the only the failed and
later PMUs to be broken?


>  }
>  
>  static int uncore_box_ref(struct intel_uncore_type **types,
> @@ -1643,11 +1650,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
>  	struct intel_uncore_type *type;
>  	struct intel_uncore_pmu *pmu;
>  	struct intel_uncore_box *box;
> -	int i, ret;
> -
> -	ret = allocate_boxes(types, die, cpu);
> -	if (ret)
> -		return ret;
> +	int i;
>  
>  	for (; *types; types++) {
>  		type = *types;
> @@ -1664,27 +1667,26 @@ static int uncore_box_ref(struct intel_uncore_type **types,
>  
>  static int uncore_event_cpu_online(unsigned int cpu)
>  {
> -	int die, target, msr_ret, mmio_ret;
> +	int die, target;
>  
>  	die = topology_logical_die_id(cpu);
> -	msr_ret = uncore_box_ref(uncore_msr_uncores, die, cpu);
> -	mmio_ret = uncore_box_ref(uncore_mmio_uncores, die, cpu);
> +	allocate_boxes(uncore_msr_uncores, die, cpu);
> +	allocate_boxes(uncore_mmio_uncores, die, cpu);
>  
>  	/*
>  	 * Check if there is an online cpu in the package
>  	 * which collects uncore events already.
>  	 */
>  	target = cpumask_any_and(&uncore_cpu_mask, topology_die_cpumask(cpu));
> -	if (target < nr_cpu_ids)
> -		return 0;
> -
> -	cpumask_set_cpu(cpu, &uncore_cpu_mask);
> -
> -	if (!msr_ret)
> +	if (target >= nr_cpu_ids) {
> +		cpumask_set_cpu(cpu, &uncore_cpu_mask);
>  		uncore_change_context(uncore_msr_uncores, -1, cpu);
> -	if (!mmio_ret)
>  		uncore_change_context(uncore_mmio_uncores, -1, cpu);
> -	uncore_change_context(uncore_pci_uncores, -1, cpu);
> +		uncore_change_context(uncore_pci_uncores, -1, cpu);
> +	}
> +
> +	uncore_box_ref(uncore_msr_uncores, die, cpu);
> +	uncore_box_ref(uncore_mmio_uncores, die, cpu);
>  	return 0;
>  }
>  
