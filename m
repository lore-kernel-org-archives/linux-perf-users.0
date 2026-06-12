Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309C258EC1;
	Fri, 12 Jun 2026 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225719; cv=none; b=X/JX2KgMOIooxfxttiD4j8N8Yhqkipz8hu2F/fvK23tFaVjx5sidy0iWscGBu0doYno9u7NGpOqLDjDGPStIC8zMUH+4vlHZx4goj2mgcMV1sKlTzfuT2x0vXH5IUqnrrY6n5+DTcZ2Ku1UKAO3gqEYO2Ar0wvK9CbyG/wVBKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225719; c=relaxed/simple;
	bh=PULvi3h/F1+HzOx6ul4yoadlXQNLErzW6TxnQ60JFUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfC8uWeIHo1v9jIQGA5W9KrR2GjvpCwmaT2qoDlhV5aiO8c1ZZds6Ikmbfkw7w9V35b30XdLco58Fj7U3B9IXdN7CCjUn5l6r3Cr1uaAWAhf4iIbko9GAeHz3ACkSoLgyz7ECgs71OXdPoXs5jBItzylrX8/TQABgf8dwEwotsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMRgB4ql; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMRgB4ql"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781225718; x=1812761718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PULvi3h/F1+HzOx6ul4yoadlXQNLErzW6TxnQ60JFUQ=;
  b=MMRgB4qlY0LrD4IpvNssx7xkVEf6yqrNKoqaNmKIULYNskyG3PBnaEkk
   lSnVajBZieFZS0r48Uyfu8s6H/rvjKWEZYZzeExcbiO4vY2qA0ErzdB7D
   mhD/lyNvJphJr6I6QL7o++9XiJW0eRc4Js/tlVtfg1oBmO4uIZTm8yUtx
   PpvPNP2FIKr9DlvnbWsZdmx0rCKfuRQFUOfdF0GbjPQOWM3EOLKPjd5aI
   JunuCOgoT5aV25GgXkwbQy2hskH0qcesjiiGq9VAv6eLzhLGsauxZGM2/
   G2mIYipX1pcXL/xPaIQV//qN/LDiDOoza8bwlX5CTB8iI8gz8X6WToqLX
   A==;
X-CSE-ConnectionGUID: 7k1qm0CnQhC8voc1hDdQ7Q==
X-CSE-MsgGUID: gP/ygrV7Rnmk5nps4U15Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92622871"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="92622871"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 17:55:18 -0700
X-CSE-ConnectionGUID: gFrsCiYCR2ajFCMkACx5AQ==
X-CSE-MsgGUID: 89UP3KaZSVCyYXo/4UqOpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="245568356"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 17:55:15 -0700
Message-ID: <8c424e86-d410-46bd-9389-e71fdfe657d5@linux.intel.com>
Date: Fri, 12 Jun 2026 08:55:12 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 7/8] perf/x86/intel/uncore: Fix uncore_box ref/unref
 ordering
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260611160033.66760-1-zide.chen@intel.com>
 <20260611160033.66760-8-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260611160033.66760-8-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thanks.

On 6/12/2026 12:00 AM, Zide Chen wrote:
> In uncore_event_cpu_online(), uncore_box_ref() was called before
> uncore_change_context().  uncore_box_ref() gates on box->cpu >= 0,
> but box->cpu is still -1 at that point because uncore_change_context()
> has not run yet.  As a result, the box is never initialized on the
> first CPU to come online in a die, leaving it permanently
> uninitialized in the single-CPU-per-die case.
>
> Thus, box->refcnt is one count below the true value, and in the CPU
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
> Move allocate_boxes() out of uncore_box_ref() to enable this
> reordering.
>
> Fixes: c74443d92f68 ("perf/x86/uncore: Support per PMU cpumask")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v3:
> - Update changelog to mention moving allocate_boxes(). (Dapeng)
> - Update title; the bug is not limited to CPU hotplug.
> ---
>  arch/x86/events/intel/uncore.c | 50 ++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 27 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index feb8c3b0076b..b9ac2f7d31ca 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1580,9 +1580,15 @@ static int uncore_event_cpu_offline(unsigned int cpu)
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
> @@ -1595,16 +1601,10 @@ static int uncore_event_cpu_offline(unsigned int cpu)
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
> @@ -1621,8 +1621,10 @@ static int allocate_boxes(struct intel_uncore_type **types,
>  			if (pmu->boxes[die] || uncore_pmu_broken(pmu))
>  				continue;
>  			box = uncore_alloc_box(type, cpu_to_node(cpu));
> -			if (!box)
> +			if (!box) {
> +				uncore_pmu_set_broken(pmu);
>  				goto cleanup;
> +			}
>  			box->pmu = pmu;
>  			box->dieid = die;
>  			list_add(&box->active_list, &allocated);
> @@ -1633,14 +1635,13 @@ static int allocate_boxes(struct intel_uncore_type **types,
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
>  }
>  
>  static int uncore_box_ref(struct intel_uncore_type **types,
> @@ -1649,11 +1650,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
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
> @@ -1669,27 +1666,26 @@ static int uncore_box_ref(struct intel_uncore_type **types,
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
