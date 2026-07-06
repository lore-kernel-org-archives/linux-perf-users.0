Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB323E8326
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325145; cv=none; b=ouyJJaEMstnMvLLq9HxUFy4tQuAy+Zgj1GRW3H/8YoVpw8zx6VIV8zOTFb5zXkmMkOF8Ni7QSMPsWEpMhSEyQLMRhBEl8T2zxNDmYGYxbiesY+6ICHoiBP0i2Dp5UM9qKIXRJ7CgvPcAJyx8uC510wptBUibDPXpzuW+m85jKfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325145; c=relaxed/simple;
	bh=uHe1X7AB00jTLT6Dky5K6tyJqhbbbMBFAvtoajNyGAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scJj3xHjz+ddQ3ciMMF1T1jGebsYAH5XsDyp6sfXWlZoaUfNEoRlxm/Bemd4JCJK4eDSf/dtp/1Drp77YyJf28HywCtT3tm0VWg6ddIrgNNlA1LMXoq3N+udde4ipvdbu2Bb4920/qjFiPa6YAATeCudVFOCmxINUDmoEzWodnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+CNFE2O; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+CNFE2O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783325137; x=1814861137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uHe1X7AB00jTLT6Dky5K6tyJqhbbbMBFAvtoajNyGAE=;
  b=h+CNFE2OF/oYzY0a+Mn7c/Xr3fJkzngH0/Fkq5AcRFz08KNutPm2D1lZ
   9Yzf1axkm8fOwH7q7dRuqzn4kKLn/J/X8ue9NOAPowHYC1rzN6lYTqMw5
   gMh9Xsg2egYtR3ef74WQI2nfOHHy/HdJVrM9kV9PAMXiGifxRJ1qmwpe/
   x6NXwbh0l6QoFoJ6HtFeLGsKZaINlv28tu47QOPni9kp672q7zgcNnOA1
   mGlv5BIjkC7Js6KhxVDOJmSMa3oN/MLVju1t+Kz+FgBmL5EPBQvNDNpMA
   YDqOMF3DtwvooUPVGOv/QDa8pmEdPn1lDlZmyqtvG4GwWz1bfB5471j1v
   g==;
X-CSE-ConnectionGUID: CKqK45wpSze/c15z87Kylw==
X-CSE-MsgGUID: n3tON+VZSeekqcCDA2N2Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95329632"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="95329632"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 01:05:33 -0700
X-CSE-ConnectionGUID: mzeArXHPS4KkR0M2ZhL5Tg==
X-CSE-MsgGUID: na2LPpCvR+Cj8nMdk4x7uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="249657710"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 01:05:33 -0700
Message-ID: <b4e681de-cd72-4801-8ead-904b13dc114c@linux.intel.com>
Date: Mon, 6 Jul 2026 16:05:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 01/24] perf/x86: Fix two error-path and hybrid PMU
 guard issues
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-2-dapeng1.mi@linux.intel.com>
 <20260706022123.480411F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706022123.480411F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/6/2026 10:21 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] The patch adds a check for `x86_pmu.num_hybrid_pmus` to prevent memory corruption in `intel_pmu_cpu_dead()` on error paths, but it is incomplete and still allows an out-of-bounds write during CPU hotplug rollback if the `CPUHP_AP_PERF_X86_STARTING` state setup fails.
> - [High] If `alloc_arch_pebs_buf_on_cpu()` fails in `intel_pmu_cpu_prepare()`, resources allocated by `intel_cpuc_prepare()` are leaked.
> - [High] Dangling `cpuc->pmu` pointer leads to Use-After-Free in `perf_event_print_debug()` when hybrid PMU registration fails.
> - [High] Out-of-bounds read on the global `.bss` section in `perf_event_print_debug()` due to an invalid struct cast when `init_hw_perf_events()` fails early.
> - [Medium] The dynamically allocated `x86_pmu.hybrid_pmu` array is permanently leaked on multiple error paths in `init_hw_perf_events()`.
> --
>
> commit e4457672386c09fea418faeba61fc0c2418ad7e5
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Fix two error-path and hybrid PMU guard issues
>
> Fix an NMI handler leak in init_hw_perf_events(). When PMU
> initialization fails after register_nmi_handler(), the error path
> exits without calling unregister_nmi_handler(), leaving a stale
> NMI_LOCAL "PMI" handler registered. Add the missing call before
> clearing x86_pmu state.
>
> Also guard the hybrid PMU cpumask update in intel_pmu_cpu_dead()
> with a check on x86_pmu.num_hybrid_pmus. Without this, hybrid_pmu()
> may be called when the hybrid PMU array has not been allocated,
> leading to an out-of-bounds access.
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index af0b67ffb43d8..872d07a5fa80d 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
> [ ... ]
>
>> @@ -2273,6 +2273,8 @@ static int __init init_hw_perf_events(void)
>>  	cpuhp_remove_state(CPUHP_AP_PERF_X86_STARTING);
>>  out:
>>  	cpuhp_remove_state(CPUHP_PERF_X86_PREPARE);
>> +pmi_unregister:
>> +	unregister_nmi_handler(NMI_LOCAL, "PMI");
>>  out_bad_pmu:
>>  	memset(&x86_pmu, 0, sizeof(x86_pmu));
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does this memset cause a
> memory leak?
>
> If cpuhp_setup_state() or check_hw_exists() fails during initialization,
> the code jumps to the out_bad_pmu label and executes the memset without
> freeing x86_pmu.hybrid_pmu. Could this permanently leak the dynamically
> allocated hybrid PMU array?

Yeah, this is a true issue, need to free the x86_pmu.hybrid_pmu after the
out_bad_pmu tag. Considering this patchset is quite large and close to
mature, would fix it in a separate patch.



>
>
> [Severity: High]
> This is a pre-existing issue, but could this error path lead to an
> out-of-bounds read in perf_event_print_debug()?
>
> If check_hw_exists() fails early during initialization, out_bad_pmu is
> reached, but the perf_is_hybrid static key is never disabled. cpuc->pmu
> defaults to the global &pmu.
>
> If a privileged user triggers sysrq-p, perf_event_print_debug() uses
> hybrid(cpuc->pmu, cntr_mask). Because is_hybrid() evaluates to true, it
> casts the global &pmu to the larger struct x86_hybrid_pmu and attempts to
> read cntr_mask, reading memory well beyond the object bounds in the .bss
> section.

Yeah, it's real issue too. Need to call
"static_branch_disable(&perf_is_hybrid);" to disable the hybrid PMU
after the out_bad_pmu tag,


>
>
> [Severity: High]
> This is a pre-existing issue, but is there a use-after-free risk here if
> hybrid PMU registration fails?
>
> If perf_pmu_register() fails for a hybrid PMU inside init_hw_perf_events(),
> the x86_pmu.hybrid_pmu array is freed via kfree. However, cpuc->pmu was
> already assigned to elements of this array during intel_pmu_cpu_starting().
>
> Since the teardown callbacks do not clear the cpuc->pmu pointers, they
> remain dangling. A privileged user triggering sysrq-p will invoke
> perf_event_print_debug(), which dereferences cpuc->pmu, potentially causing
> a use-after-free.

Yes, real issue too. Need to reset the cpuc->pmu to static pmu in
intel_pmu_cpu_dead().



>
>>  	return err;
>>  }
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index b39c6ce0efb5c..b8a6382dbb825 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>
>> @@ -6479,7 +6479,7 @@ static void intel_pmu_cpu_dead(int cpu)
>>  	release_arch_pebs_buf_on_cpu(cpu);
>>  	intel_cpuc_finish(cpuc);
>>  
>> -	if (is_hybrid() && cpuc->pmu)
>> +	if (is_hybrid() && x86_pmu.num_hybrid_pmus && cpuc->pmu)
> [Severity: High]
> This is a pre-existing issue, but does this incomplete guard still allow an
> out-of-bounds write during CPU hotplug rollback?
>
> If CPUHP_AP_PERF_X86_STARTING hotplug setup fails, it rolls back the already
> successful CPUHP_PERF_X86_PREPARE state by invoking intel_pmu_cpu_dead().
>
> Because cpuc->pmu defaults to the statically allocated &pmu, the condition
> evaluates to true. hybrid_pmu() casts the global pmu to the much larger
> struct x86_hybrid_pmu, which could result in an out-of-bounds write when
> modifying supported_cpus.

Yes, real issue. Need to check "cpuc->pmu != pmu" before accessing
hybrid_pmu(cpuc->pmu).


>
>>  		cpumask_clear_cpu(cpu, &hybrid_pmu(cpuc->pmu)->supported_cpus);
>>  }
>
> [Severity: High]
> This is a pre-existing issue, but can intel_pmu_cpu_prepare() leak memory
> allocated by intel_cpuc_prepare() if alloc_arch_pebs_buf_on_cpu() fails?
>
> When the CPU hotplug core attempts to online a CPU, it runs the prepare
> callback. If alloc_arch_pebs_buf_on_cpu() fails, the state transitions are
> aborted without calling the teardown callback intel_pmu_cpu_dead() for this
> specific CPU.
>
> Under memory pressure, could repeated CPU hotplug operations leak the
> cpuc->shared_regs, cpuc->constraint_list, and cpuc->excl_cntrs structures?

Yes, need to call intel_cpuc_finish() once alloc_arch_pebs_buf_on_cpu()
fails in intel_pmu_cpu_prepare(). 

Thanks.


>
