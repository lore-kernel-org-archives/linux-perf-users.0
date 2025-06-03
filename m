Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF7AD23;
	Tue,  3 Jun 2025 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748916883; cv=none; b=pu7GIV4Uh/gvkdE9nLukNAeR9oSeewmQqiZfMWAuP7cQBvULPC5WeVvxI2/lQwj2shmAxYVk1iDW6UiE/R4UvVxDLSB3tTl0c73tPhFqrTujsPiVQJyXbIx8Tvwjk5HbWnhaGHfD4dI5man3fo2vcy6PPlcLQHFvbPk/334Z2GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748916883; c=relaxed/simple;
	bh=y8oBFuwHhFlEhkjWTDjbf0m9eyGhP7r/lbU9v9hLVYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6XubYCCDsY1dCgt0OQ2lGkKzeG8X6Ro6gFyRToH3WKpVrQ2rkSEyLWHx1o8aqr3DSJoIvzjCk9ykpvwUUFw20fpe0Nn9zzsyNcTm82oFbVoeH9NaWRzadeVLzZODln5JGCRGBnO2yilDC5JwTDXhM5/fvUel+PQgZz7Ieyalmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ku2EBJ2t; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ku2EBJ2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748916881; x=1780452881;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y8oBFuwHhFlEhkjWTDjbf0m9eyGhP7r/lbU9v9hLVYo=;
  b=Ku2EBJ2t+eUiQ+hLxcUU/pJwJGQfAXD8jjQvDZXpSmlI6PPQgucvw6q+
   ckVkYLKuvMWgR618h/1rx2wfMeDsjkXz4gcWTxOHOrLFSWuEAwVr+m5ZP
   xBRSzG3MlnU/G3SVM79KRBwkXtKHBmjBgHcTQn+JEYh/64Jzc0PU/LIKV
   Tcy6d9X1q8as6w5ZHqE2xLg6aSD6XOmgbfsfh4Ke9S/DoGvLLFPonYyw0
   f/VjAQCAVfqOFdpMqGDvro1TNWyfJ3yhvD/MjtM2AwhpUGgsYob3pKZrl
   QL6S9Vw56R5QM1x2He2+BJyvtLKoJFt7eoWz6k7Py+9hjG8fAIWL8zt55
   Q==;
X-CSE-ConnectionGUID: 34CP8NXDTUaRKMj+YcN+lA==
X-CSE-MsgGUID: PK3y0+7ERMiq+ZbCThkauw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50806111"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="50806111"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 19:14:41 -0700
X-CSE-ConnectionGUID: FU2B+paLSUOKFVS1BgBgXw==
X-CSE-MsgGUID: 47HY3mYyRpaxlEllrdS67Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="149869266"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.144]) ([10.124.245.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 19:14:36 -0700
Message-ID: <15e4f7a6-7c68-4d89-8813-cd142eb4c416@linux.intel.com>
Date: Tue, 3 Jun 2025 10:14:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access
 error
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250529080236.2552247-1-dapeng1.mi@linux.intel.com>
 <aDq3S9lwO1YadCKT@gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aDq3S9lwO1YadCKT@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/31/2025 4:01 PM, Ingo Molnar wrote:
> * Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>
>> When running perf_fuzzer on PTL, sometimes the below "unchecked MSR
>>  access error" is seen when accessing IA32_PMC_x_CFG_B MSRs.
>>
>> [   55.611268] unchecked MSR access error: WRMSR to 0x1986 (tried to write 0x0000000200000001) at rIP: 0xffffffffac564b28 (native_write_msr+0x8/0x30)
>> [   55.611280] Call Trace:
>> [   55.611282]  <TASK>
>> [   55.611284]  ? intel_pmu_config_acr+0x87/0x160
>> [   55.611289]  intel_pmu_enable_acr+0x6d/0x80
>> [   55.611291]  intel_pmu_enable_event+0xce/0x460
>> [   55.611293]  x86_pmu_start+0x78/0xb0
>> [   55.611297]  x86_pmu_enable+0x218/0x3a0
>> [   55.611300]  ? x86_pmu_enable+0x121/0x3a0
>> [   55.611302]  perf_pmu_enable+0x40/0x50
>> [   55.611307]  ctx_resched+0x19d/0x220
>> [   55.611309]  __perf_install_in_context+0x284/0x2f0
>> [   55.611311]  ? __pfx_remote_function+0x10/0x10
>> [   55.611314]  remote_function+0x52/0x70
>> [   55.611317]  ? __pfx_remote_function+0x10/0x10
>> [   55.611319]  generic_exec_single+0x84/0x150
>> [   55.611323]  smp_call_function_single+0xc5/0x1a0
>> [   55.611326]  ? __pfx_remote_function+0x10/0x10
>> [   55.611329]  perf_install_in_context+0xd1/0x1e0
>> [   55.611331]  ? __pfx___perf_install_in_context+0x10/0x10
>> [   55.611333]  __do_sys_perf_event_open+0xa76/0x1040
>> [   55.611336]  __x64_sys_perf_event_open+0x26/0x30
>> [   55.611337]  x64_sys_call+0x1d8e/0x20c0
>> [   55.611339]  do_syscall_64+0x4f/0x120
>> [   55.611343]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> On PTL, GP counter 0 and 1 doesn't support auto counter reload feature,
>> thus it would trigger a #GP when trying to write 1 on bit 0 of CFG_B MSR
>> which requires to enable auto counter reload on GP counter 0.
>>
>> The root cause of causing this issue is the check for auto counter
>> reload (ACR) counter mask from user space is incorrect in
>> intel_pmu_acr_late_setup() helper. It leads to an invalid ACR counter
>> mask from user space could be set into hw.config1 and then written into
>> CFG_B MSRs and trigger the MSR access warning.
>>
>> e.g., User may create a perf event with ACR counter mask (config2=0xcb),
>> and there is only 1 event created, so "cpuc->n_events" is 1.
>>
>> The correct check condition should be "i + idx >= cpuc->n_events"
>> instead of "i + idx > cpuc->n_events" (it looks a typo). Otherwise,
>> the counter mask would traverse twice and an invalid "cpuc->assign[1]"
>> bit (bit 0) is set into hw.config1 and cause MSR accessing error.
>>
>> Besides, also check if the ACR counter mask corresponding events are
>> ACR events. If not, filter out these counter mask. If a event is not a
>> ACR event, it could be scheduled to an HW counter which doesn't support
>> ACR. It's invalid to add their counter index in ACR counter mask.
>>
>> Furthermore, remove the WARN_ON_ONCE() since it's easily triggered as
>> user could set any invalid ACR counter mask and the warning message
>> could mislead users.
>>
>> Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 3a319cf6d364..8d046b1a237e 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2994,7 +2994,8 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
>>  			if (event->group_leader != leader->group_leader)
>>  				break;
>>  			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
>> -				if (WARN_ON_ONCE(i + idx > cpuc->n_events))
>> +				if (i + idx >= cpuc->n_events ||
>> +				    !is_acr_event_group(cpuc->event_list[i + idx]))
>>  					return;
> Is this a normal condition?
>
>  - If it's normal then the 'return' is destructive, isn't it? Shouldn't 
>    it be a 'break', if this condition is legitimate?
>
>  - If it's not normal, then the WARN_ON_ONCE() was justified, right?

It's not normal.Strictly speaking, it's an invalid user configuration. It
looks not reasonable to trigger a kernel space warning for an invalid user
space configuration. It would mislead users and let users think there is
something wrong in kernel. That's why to remove the WARN_ON_ONCE(). Thanks.


>
> Thanks,
>
> 	Ingo
