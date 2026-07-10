Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316833B14C0
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670529; cv=none; b=lZDuicmeJbxBdm80GNnNmRcvUAyXteazL82UAEzaG1zfRhXwrxQiglcE21e3ujJFSZRWGYFwrumwqaAsNsStqpe+Ep41Pd0KtrCBe//Ex259FDfFoth7fw0Fv7ZGJxV+BKT5I/XD/+lFqwu6gr4q5lon+71qIOx5jGTmSkdepus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670529; c=relaxed/simple;
	bh=pxctsRD5ChK9qiZ8WLOXWmucfqa7rIE1jMaLD9CAgMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlYfWZCq77qPQGJRJ0idYBXwsvqzmuss5zHc2PBvikM5rwSqtGapKGuqd7aNjCivEftHHKlBJOMCtxAAcu3oLLhDTMn9WqP3t3u3uqzQoVXGd2PnrLvbVh3LptNla9mn6iEHGmMKZUa1WRURtMyYZTUEzQMmNVwc1fh5fgMvMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtF8Z+dp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtF8Z+dp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783670524; x=1815206524;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pxctsRD5ChK9qiZ8WLOXWmucfqa7rIE1jMaLD9CAgMY=;
  b=PtF8Z+dpg1XDhliFwD1IQ463fzPuvtEkx7/IvOMsDCnGhUs8R0LRwY9i
   IbKx8gnlcMUjl7ZBVs1fD3NnU5SirkHnO9FsjNEfmmnoo30Xa2Z54LYKv
   fl+mb7WTqCbXahr0zAg4NgK99Ufj9CzfteEncNeIvkdc/ZB2oObcV5HaT
   fpIP2KSGr5sa72UKd/b7y1dFG1hCk4vWXmlwP9u56/OaVQCGkUq5aNacT
   Zc/3iDAy3eexWFH+marMuORbc41qyM/wpbTWK9uDvMiwS7pM1Pr0u7sVB
   GlQAb66fEYB7G5APb618uSCNBHZpg9IoiNL285/7SxSdy1iNVKTiQURY/
   Q==;
X-CSE-ConnectionGUID: MxOcO9EMQreOarvrRJ8JGQ==
X-CSE-MsgGUID: 4IlV1mgJQyyR2vOMkD8Wng==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95881761"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95881761"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:02:03 -0700
X-CSE-ConnectionGUID: /XsLe0VPS/GwSdcNom1F4Q==
X-CSE-MsgGUID: NezE0kYHTia8QwIpC2Zmew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="279234881"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:02:02 -0700
Message-ID: <35bcf4a5-29ca-46b5-9ca6-e1b44a9c08b0@linux.intel.com>
Date: Fri, 10 Jul 2026 16:01:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] perf/x86/intel: Clear cpuc->pmu on hybrid PMU init
 failure
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
 <20260710065128.1799838-4-dapeng1.mi@linux.intel.com>
 <20260710072619.5E3011F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260710072619.5E3011F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/10/2026 3:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [High] Lockless double-read of `cpuc->pmu` in `x86_get_pmu()` leads to a TOCTOU race when racing with `cpuc->pmu = NULL`, causing a NULL pointer dereference.
>
> Pre-existing issues:
> - [High] The patch leaves a critical memory corruption vulnerability unhandled if a CPU hotplug rollback occurs before the hybrid PMU initialization runs.
> - [High] An unhandled #GP fault occurs in `intel_pmu_handle_irq` if a spurious NMI/PMI is received on a CPU where PMU initialization failed.
> --
>
> --- Patch [3]: [PATCH 3/7] perf/x86/intel: Clear cpuc->pmu on hybrid PMU init failure ---
> commit 0c199c356195e47c5b429eac88846944835a4589
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Clear cpuc->pmu on hybrid PMU init failure
>
> When init_hybrid_pmu() fails at check_hw_exists(), cpuc->pmu may still
> point to the default static PMU. The CPU hotplug rollback then runs
> intel_pmu_cpu_dead(). On hybrid systems, that path may call
> hybrid_pmu(cpuc->pmu), which is not valid for the static PMU pointer and
> can result in incorrect hybrid state access.
>
> Fix this by resetting cpuc->pmu to NULL on hybrid PMU init failure.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index b39c6ce0efb5c..9d4774278b508 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -6329,8 +6329,10 @@ static bool init_hybrid_pmu(int cpu)
>>  
>>  	intel_pmu_check_hybrid_pmus(pmu);
>>  
>> -	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask))
>> +	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask)) {
>> +		cpuc->pmu = NULL;
> [Severity: High]
> Can this assignment race with concurrent readers?  Looking at x86_get_pmu()
> in arch/x86/events/core.c, there is a lockless double-read of cpuc->pmu:
>
> x86_get_pmu(int cpu)
> {
>     ...
>     if (WARN_ON_ONCE(!cpuc->pmu))
>         return &pmu;
>
>     return cpuc->pmu;
> }
>
> If sys_perf_event_open() executes concurrently and calls x86_get_pmu()
> via reserve_lbr_buffers(), could the compiler emit two independent loads?
>
> If cpuc->pmu is non-NULL during the first load but is set to NULL by this
> patch before the second load, x86_get_pmu() would return NULL.  Does this
> lead to a NULL pointer dereference in reserve_lbr_buffers()?

Doubt if the issue could really happen. init_hybrid_pmu() is called on cpu
online phase. When it's called, there should no any perf event is created
and enabled. As the 3rd comment says, currently "If init_hybrid_pmu()
returns false here, x86_pmu_starting_cpu() ignores this
failure and returns 0, allowing the CPU to come online with a disabled
PMU." But If we enhance x86_pmu_starting_cpu() to propagate the error, then
the CPU won't be really online and no events can be run this cpu.


>
>> +		return false;
>> +	}
> [Severity: High]
> This isn't a bug introduced by this patch, but does this fully resolve the
> rollback vulnerability?
>
> If a CPU hotplug operation fails between the CPUHP_PERF_X86_PREPARE and
> CPUHP_AP_PERF_X86_STARTING states, the hotplug core rolls back and invokes
> intel_pmu_cpu_dead().
>
> Because init_hybrid_pmu() is bypassed entirely, cpuc->pmu remains pointing
> to the static default pmu struct.
>
> intel_pmu_cpu_dead() then executes:
>
>     if (is_hybrid() && cpuc->pmu)
>         cpumask_clear_cpu(cpu, &hybrid_pmu(cpuc->pmu)->supported_cpus);
>
> Since cpuc->pmu is non-NULL, hybrid_pmu() calculates a negative offset from
> the static pmu struct, and cpumask_clear_cpu() performs an out-of-bounds
> memory write. Is there a way to safely handle rollbacks that bypass
> initialization entirely?

Hmm, yes. Need to check if cpuc->pmu still points to the static pmu before
calling hybrid_pmu().


>
> [Severity: High]
> This is also a pre-existing issue, but what happens if a spurious NMI is
> received on a CPU where check_hw_exists() failed?
>
> If init_hybrid_pmu() returns false here, x86_pmu_starting_cpu() ignores this
> failure and returns 0, allowing the CPU to come online with a disabled PMU.
> If another CPU has active perf events, active_events is greater than 0.
>
> When an NMI broadcast hits this broken CPU, perf_event_nmi_handler() sees
> active_events > 0 and calls intel_pmu_handle_irq(), which executes:
>
>     __intel_pmu_disable_all(true);
>
> This unconditionally executes wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL, 0).
> Since the PMU MSRs are unsupported on this CPU, will this unchecked wrmsrq
> trigger a fatal general protection fault?

Yes, need to propagate the error for x86_pmu_starting_cpu().

would fix this issue in v2. Thanks.



>
>>  	pr_info("%s PMU driver: ", pmu->name);
>>
