Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041511A3166
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784511058; cv=none; b=q+BC0IgJtFbsO73EDftrQzRjltVEmKdGS9D97kePmSUcvuENIY/9Jo5BaYjU8xmX86VNgQc2yGR5wUWqwgF28CUIHxLobIS160a/GflbsNlDEJ2TtK36BsbzYwCNJC5Mz7LXpAHJoZ4/vMPVywrRuNJVsajrrJtSFfVaDXJ0xcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784511058; c=relaxed/simple;
	bh=6rn8kEeqBm39gFvFfndNUSnocPk989mgGC8WatF24fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JybN8WQ0zDhasdc3uAufhcJV+X0+DO70ciagkVztKp17IGm7jwWd8qS5hAZqmGkCNtHiYD3f3k1nyJ+d1eIPiXLWKK2rH7miNya+Nod3NF81U6ddlixcMtugXUeJuxBNgSbMdx2USJ0aTk59w8OX9PidZu5DFvjMqoR/a3wNmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdcD9frt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdcD9frt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784511056; x=1816047056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6rn8kEeqBm39gFvFfndNUSnocPk989mgGC8WatF24fw=;
  b=YdcD9frtW+1wS56CVdA91zA4JwlXaz4hcHwMRRugNMmfVmXLcTdjlhGs
   O1ME3u3/k8aU8/LWHCzJaDBfOPWU1W3H7M1uY92Ba5yVmu8VbN5nv4J1r
   ufLr8DPHNjslm7q/PzX22CQh5hN3KuU34mWegT8m2Voz6lEPqSgghTx2l
   55eL+RWs8VkFo7dZME/T5MaPm4dQgiTDAPVo82bnyR3EbUI3afj40TDfn
   3IjlQTBznlxNZ90pCtA4vpd4b50KAHfD4BIFQqx5XmZ31eOPN76i2DYmp
   GnLlh5aFyCUuKtRi45B6nVBLr7Ec8xpkuomVKRiYMIcJi41Etm4TlU9bS
   g==;
X-CSE-ConnectionGUID: gFWyTMOvQ7CWKTKhfjDqkg==
X-CSE-MsgGUID: y4H0ntT6TE+SXupumlWHbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="87625230"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="87625230"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 18:30:55 -0700
X-CSE-ConnectionGUID: xL3W2rzQSs6hYc5SyOjbeA==
X-CSE-MsgGUID: lT/ZUd+CSWCWC7mWS5uinA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="281784084"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 18:30:54 -0700
Message-ID: <7e41230e-a09f-474a-83c4-12505c38930e@linux.intel.com>
Date: Mon, 20 Jul 2026 09:30:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 3/8] perf/x86: Guard intel_pmu_cpu_dead() against
 invalid hybrid PMU casts
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
 <20260717080342.1879573-4-dapeng1.mi@linux.intel.com>
 <20260717093111.A5A0F1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260717093111.A5A0F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/17/2026 5:31 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Setting `cpuc->pmu = NULL` on initialization failure triggers a user-triggerable `WARN_ON_ONCE` in `x86_get_pmu()`.
>
> Pre-existing issues:
> - [High] Unchecked MSR writes in NMI handler cause a #GP fault on asymmetric PMU configurations.
> --
>
> --- Patch [3]: [Patch v3 3/8] perf/x86: Guard intel_pmu_cpu_dead() against invalid hybrid PMU casts ---
> commit 2ef12c59a0f0eb0a83a45dd11cf187ca55beecdf
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Guard intel_pmu_cpu_dead() against invalid hybrid PMU casts
>     
> Fix invalid container conversions in failure paths by clearing cpuc->pmu to
> NULL when check_hw_exists() fails, and validating cpuc->pmu in
> intel_pmu_cpu_dead(). A new helper x86_get_static_pmu() is added.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index b39c6ce0efb5c..a991fc4f1575f 100644
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
> Does setting cpuc->pmu to NULL here trigger a warning in x86_get_pmu()?
>
> If check_hw_exists() fails (e.g., due to a hypervisor restricting PMU MSRs),
> we now set cpuc->pmu to NULL but leave the CPU in the possible_cpus mask.
>
> If a user later opens a perf event utilizing Architectural LBRs (like perf
> record -b), x86_reserve_hardware() calls reserve_lbr_buffers() which
> iterates over all possible CPUs:
>
> arch/x86/events/intel/lbr.c:reserve_lbr_buffers() {
> 	...
> 	for_each_possible_cpu(cpu) {
> 		kmem_cache = x86_get_pmu(cpu)->task_ctx_cache;
> 	...
> }
>
> Because the failed CPU's cpuc->pmu is NULL, x86_get_pmu() hits its strict
> WARN_ON_ONCE(!cpuc->pmu) assertion. If panic_on_warn=1 is set, could this
> upgrade a graceful PMU initialization failure into a local panic?
>
> Since intel_pmu_cpu_dead() now safely guards against the invalid cast with
> cpuc->pmu != pmu, is this assignment necessary?

This is expected. If the PMU initialization fails on a cpu, the cpuc->pmu
has to set NULL, which is the simplest (maybe best) way to indicate the
initialization failure. 

Strictly speaking, it's unnecessary to check if cpuc->pmu != NULL, but we
still want to keep it since it obviously indicates the cpuc->pmu could be
reset to NULL.

>
> [Severity: High]
> This is a pre-existing issue, but does failing check_hw_exists() leave the
> CPU vulnerable to a #GP fault during a spurious NMI?
>
> If a CPU is brought online but its PMU MSRs are disabled by a hypervisor,
> initialization for that CPU aborts here. However, perf_event_nmi_handler()
> is registered globally if at least one CPU succeeds.
>
> If an active perf event runs on a healthy CPU (so active_events > 0), and a
> spurious or broadcast NMI strikes the broken CPU, it will execute:
>
> intel_pmu_handle_irq()
>     __intel_pmu_disable_all(true)
>         wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL, 0);
>
> Could accessing this non-existent MSR on the failed CPU trigger an unchecked
> #GP fault and kernel panic?
>
>>  		return false;
>> +	}
>>  
>>  	pr_info("%s PMU driver: ", pmu->name);

Yeah, it's possible but it's hard to fix in current hotplug implementation.
The best way to fix this issue is to let hotplug rollback and offline the
CPU, but it seems currently the failure of CPUHP_AP_PERF_X86_STARTING won't
really cause the rollback. 


