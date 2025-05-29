Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B5224B0C;
	Thu, 29 May 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748526898; cv=none; b=UD7l7MNwKua0y+qOykEoRmY+FKtvVvdB4fgcMSkpXzr3QTgPswsipV6NgNOxxZF001QCAP+C8Wi2gWhJokkOXeavJAjpnW5JV/yhiRHgldL8JFd2qM7kGt0VhRAIhpQPNB5/TmWN02z63ZO37b717jb7RTeyl2fsqY5+tAzBefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748526898; c=relaxed/simple;
	bh=G9zKVYl5/7Fysz+nA+N2I9IvWHKk4YGRE0Lxjp+hjGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BltSj07kMcbckpI79iGUkyfczrtLjN77Jrv0XvMSw4Hbn23nWRV322Eir2Scuz5HAvOhTgf+gFtUwrjMlMv3hVZZ3HCiG/H1/OUqSkCjAG4zt1pAWenhCT6tMPuDz13QBxNqBuK3toFnVtl+igH4eUpUVEa7hn7lbdtqTUiuNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GczzulEZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GczzulEZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748526897; x=1780062897;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G9zKVYl5/7Fysz+nA+N2I9IvWHKk4YGRE0Lxjp+hjGU=;
  b=GczzulEZStBdtr3Lm9oLYmFfJcyLFegcrT27Jx/WrFj2Ju2T4tdTukBQ
   1b2j+9PikeoqwK/xCuF7RKSCtWiMalgf7CPitKm6edM6iXdpyMqevnslP
   Fv8IYB3DQwOPUZVBcIpp43lkWe2dAgFvmjv5fyH6J+rAbh2FwhWlOnL0Y
   F+jFf7GVmG8ZBvcYW9/W0xMk90OmQAR/t/USfETJpCJTe1lseyVXiOdPU
   BWHJplLZcbuUlgF7tkzoqCf8DT0l11btua+fbAFjP3MqhS/+M7SPYqn7X
   bg62hmfuSi9HJtlrpX8i8WccPacISaAEJKMB7pLEQrlgZskYAE3T63QTF
   A==;
X-CSE-ConnectionGUID: mUSTDXt1QTC7W0w7Ly98vg==
X-CSE-MsgGUID: 1te+pbwaQjGHOMPV7rVeQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="75979817"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="75979817"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 06:54:56 -0700
X-CSE-ConnectionGUID: J0aGq3eWRZC5Q8324Zr8fw==
X-CSE-MsgGUID: DUs+DyxLTiqsVNTXxMdCwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="143473640"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 06:54:56 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 66CD520B5736;
	Thu, 29 May 2025 06:54:54 -0700 (PDT)
Message-ID: <4bf124b7-a7e5-42be-b633-8d6ee86d3a2e@linux.intel.com>
Date: Thu, 29 May 2025 09:54:53 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access
 error
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250529080236.2552247-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250529080236.2552247-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-29 4:02 a.m., Dapeng Mi wrote:
> When running perf_fuzzer on PTL, sometimes the below "unchecked MSR
>  access error" is seen when accessing IA32_PMC_x_CFG_B MSRs.
> 
> [   55.611268] unchecked MSR access error: WRMSR to 0x1986 (tried to write 0x0000000200000001) at rIP: 0xffffffffac564b28 (native_write_msr+0x8/0x30)
> [   55.611280] Call Trace:
> [   55.611282]  <TASK>
> [   55.611284]  ? intel_pmu_config_acr+0x87/0x160
> [   55.611289]  intel_pmu_enable_acr+0x6d/0x80
> [   55.611291]  intel_pmu_enable_event+0xce/0x460
> [   55.611293]  x86_pmu_start+0x78/0xb0
> [   55.611297]  x86_pmu_enable+0x218/0x3a0
> [   55.611300]  ? x86_pmu_enable+0x121/0x3a0
> [   55.611302]  perf_pmu_enable+0x40/0x50
> [   55.611307]  ctx_resched+0x19d/0x220
> [   55.611309]  __perf_install_in_context+0x284/0x2f0
> [   55.611311]  ? __pfx_remote_function+0x10/0x10
> [   55.611314]  remote_function+0x52/0x70
> [   55.611317]  ? __pfx_remote_function+0x10/0x10
> [   55.611319]  generic_exec_single+0x84/0x150
> [   55.611323]  smp_call_function_single+0xc5/0x1a0
> [   55.611326]  ? __pfx_remote_function+0x10/0x10
> [   55.611329]  perf_install_in_context+0xd1/0x1e0
> [   55.611331]  ? __pfx___perf_install_in_context+0x10/0x10
> [   55.611333]  __do_sys_perf_event_open+0xa76/0x1040
> [   55.611336]  __x64_sys_perf_event_open+0x26/0x30
> [   55.611337]  x64_sys_call+0x1d8e/0x20c0
> [   55.611339]  do_syscall_64+0x4f/0x120
> [   55.611343]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> On PTL, GP counter 0 and 1 doesn't support auto counter reload feature,
> thus it would trigger a #GP when trying to write 1 on bit 0 of CFG_B MSR
> which requires to enable auto counter reload on GP counter 0.
> 
> The root cause of causing this issue is the check for auto counter
> reload (ACR) counter mask from user space is incorrect in
> intel_pmu_acr_late_setup() helper. It leads to an invalid ACR counter
> mask from user space could be set into hw.config1 and then written into
> CFG_B MSRs and trigger the MSR access warning.
> 
> e.g., User may create a perf event with ACR counter mask (config2=0xcb),
> and there is only 1 event created, so "cpuc->n_events" is 1.
> 
> The correct check condition should be "i + idx >= cpuc->n_events"
> instead of "i + idx > cpuc->n_events" (it looks a typo). Otherwise,
> the counter mask would traverse twice and an invalid "cpuc->assign[1]"
> bit (bit 0) is set into hw.config1 and cause MSR accessing error.
> 
> Besides, also check if the ACR counter mask corresponding events are
> ACR events. If not, filter out these counter mask. If a event is not a
> ACR event, it could be scheduled to an HW counter which doesn't support
> ACR. It's invalid to add their counter index in ACR counter mask.
> 
> Furthermore, remove the WARN_ON_ONCE() since it's easily triggered as
> user could set any invalid ACR counter mask and the warning message
> could mislead users.
> 
> Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thanks for the fix.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  arch/x86/events/intel/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 3a319cf6d364..8d046b1a237e 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2994,7 +2994,8 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
>  			if (event->group_leader != leader->group_leader)
>  				break;
>  			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
> -				if (WARN_ON_ONCE(i + idx > cpuc->n_events))
> +				if (i + idx >= cpuc->n_events ||
> +				    !is_acr_event_group(cpuc->event_list[i + idx]))
>  					return;
>  				__set_bit(cpuc->assign[i + idx], (unsigned long *)&event->hw.config1);
>  			}
> 
> base-commit: e7d952cc39fca34386ec9f15f68cb2eaac01b5ae

