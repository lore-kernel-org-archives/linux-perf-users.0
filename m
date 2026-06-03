Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F1202963;
	Wed,  3 Jun 2026 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453962; cv=none; b=rg71U6yKAIQk6n6+F5rcmP/Mf8zSlHqg/UdgZhKpImK+EqvU2UzXwKRcaExA+rk93LMzzBH1y2dvt3OQ7FO85QCHfutKk3VrFGcnfcL48LwnmRxPcJsYQWrZ6bt7A8L4j0qi96ZoE8spGBGwBeGlWjMfytWD6S4fCW0UCNKJZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453962; c=relaxed/simple;
	bh=izA4LRQqrIFjvaTgCl1F7ThB0hvHZoX7CvyWDro6Wo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyFalGlnAFybVXaeguhoTa2Cmn7KUAOX27aGGL1ySU5UYDqQbah+7LoSD4yW3+NPLOhmly+52SjIoRy420jTQr0LiA+/ZkEc8jBES7hoF7ZNo2njtN2/XspzrmO89T03txCCAuXqOY0CiZJLHyWzUedsuI0FA6Ov05/DaCcdwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idKlAykr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idKlAykr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780453960; x=1811989960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=izA4LRQqrIFjvaTgCl1F7ThB0hvHZoX7CvyWDro6Wo8=;
  b=idKlAykr31nsanGlUC2oVp6U3Rbad6LyrVdVYY8o+lG5rguNtuc/o0jP
   w5uvp9kSlVNDty5dHwftX37+cpdeIgpunW21i1xMWcOcpSB7+pSeYK29C
   kX7sIYTSwW+UK3/68/G4UK12tAdgMS9dc28plIztuqTF2XJ0fAP7yR0So
   zlmRWNUgZdqniC9M1kiLWSq87VURBujQ2UonKLiriCAFIZY0L4BuRcHSa
   LHSVfxUaK+Sw3ZrviHnQfP2xxQH+PA6XNMbYxHr6yJ47oi87Of6iMXlbE
   wRQaHb6q8S4FBQ6Nhkji5BWakZOmVh0oHlorKtrl+PMru80bQaYa4MCg7
   w==;
X-CSE-ConnectionGUID: p3iYdZLQQb2hGGQu/DIatg==
X-CSE-MsgGUID: JjC2GguFRAWZHDjh/EksuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81226678"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81226678"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 19:32:40 -0700
X-CSE-ConnectionGUID: Y8HAKw+zR5aj/DY1ujJNIw==
X-CSE-MsgGUID: 2ISWOOPRTumZPHJEcag+jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="243924755"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 19:32:36 -0700
Message-ID: <74ab79eb-57c8-4a63-b401-b56b0483a5a5@linux.intel.com>
Date: Wed, 3 Jun 2026 10:32:33 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/8] perf/x86/intel/uncore: Fix uncore_box ref/unref
 ordering on CPU hotplug
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260601170114.173359-1-zide.chen@intel.com>
 <20260601170114.173359-8-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260601170114.173359-8-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/2/2026 1:01 AM, Zide Chen wrote:
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
> Fixes: c74443d92f68 ("perf/x86/uncore: Support per PMU cpumask")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore.c | 50 ++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 27 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index f2cb3fde2dda..6d710aef52ac 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1577,9 +1577,15 @@ static int uncore_event_cpu_offline(unsigned int cpu)
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
> @@ -1592,16 +1598,10 @@ static int uncore_event_cpu_offline(unsigned int cpu)
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
> @@ -1618,8 +1618,10 @@ static int allocate_boxes(struct intel_uncore_type **types,
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
> @@ -1630,14 +1632,13 @@ static int allocate_boxes(struct intel_uncore_type **types,
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
> @@ -1646,11 +1647,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
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
> @@ -1666,27 +1663,26 @@ static int uncore_box_ref(struct intel_uncore_type **types,
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

allocate_boxes() are moved to uncore_event_cpu_online() from
uncore_box_ref(). It's a significant and good change since PCI uncore PMUs
doesn't call allocate_boxes(), but the commit message doesn't mention this.
We'd better extract this change to a separate patch which would make the
changes clearer. Thanks.

Others look good to me.


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
