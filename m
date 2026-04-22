Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363692BB17;
	Wed, 22 Apr 2026 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776818668; cv=none; b=N3nA7jd4203cJHwVfrnQJPh5lTzu7b0ckvWqEPyVKPvLLxMtubTcPmrxemZ5YdVxgbyIlpe4GasD/8z0Qi6PJ+2ObIuK50TXRVfalA/5F2M8BgcD7cCX8i+MM2XwerHFO/llK20Uwnr0f47JPklIjfzBdHk8XXOY8yt0x3g+zl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776818668; c=relaxed/simple;
	bh=3j/LizLwq1l/lmZqE/geXkCSf6D6OvycLCTTOhWFih0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBMuU2ypZpxsPiEap39QSbl2WBG08vF39FNg/7Tar8jP8xoTpjevi8dtdR+xAr9olGog7BHoNaKF7qoXHRzDlhjXQ4oYoXBzbSnl16KT1PZxsWyJrHN+3Gt5wjTMZPigVBkl1wdIIIT6Om0AaAvVLS7iwj9OZxrwbT1CxqPt5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FehnSMxt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FehnSMxt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776818666; x=1808354666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3j/LizLwq1l/lmZqE/geXkCSf6D6OvycLCTTOhWFih0=;
  b=FehnSMxtvELH+gKrrXEke/3UUwK2Eext+mQnivWEylY8njOZVQng4ivn
   33FIPzAReAkxLxn8gZlP4LlYrKdGgZTTkGH4CPAJrenlUm9aVPo9VT1r5
   FawOpXGOjeWlu2Z3Ci7lygczCE+VvOFApImmX2CLPNL126iu0/bLanPFE
   5Ie5BC7sVKhRt+r4rwAZwHsZBEMqfhw9I95jptF9P9moUm6hDYdIi4cWk
   dLjS/+jhPuRJ6Ufd6bWe8+x1RcTfMIeuSG+3A0Pa5RPgeotHOcn7eXDqS
   EUsUKmyIA2J1WlCSutwRANMKz/GJKL8itjXWRixgp3YhiWIeYkb+Gk0OS
   A==;
X-CSE-ConnectionGUID: qpeixwIvQdSh1h8y1kEhaA==
X-CSE-MsgGUID: O8Oy4NLzQH6KCClPrpEPLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="89235980"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="89235980"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 17:43:41 -0700
X-CSE-ConnectionGUID: tSR8a4URQi2rwe6fyZZGUg==
X-CSE-MsgGUID: Exw9zhAASh+ScNDIM2OoGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="236207788"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 17:43:37 -0700
Message-ID: <9479cd37-f54d-46bb-89d4-4c5fea1a0996@linux.intel.com>
Date: Wed, 22 Apr 2026 08:43:33 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Remove anythread_deprecated bit from
 perf_capabilities
To: "Chen, Zide" <zide.chen@intel.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
References: <20260415021010.1248083-1-dapeng1.mi@linux.intel.com>
 <aeaZUZyILpy6HKnJ@google.com>
 <d93ccac4-d1c6-4d56-9714-33a32e5c4f48@linux.intel.com>
 <546d7ebd-492c-4544-bcb0-adf4046a2447@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <546d7ebd-492c-4544-bcb0-adf4046a2447@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/22/2026 5:58 AM, Chen, Zide wrote:
>
> On 4/20/2026 5:51 PM, Mi, Dapeng wrote:
>> On 4/21/2026 5:23 AM, Namhyung Kim wrote:
>>> On Wed, Apr 15, 2026 at 10:10:10AM +0800, Dapeng Mi wrote:
>>>> AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
>>>> PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
>>>> represent "anythread deprecation" in perf_capabilities. It leads to the
>>>> anythread_deprecated bit could be overwritten by the real value of
>>>> PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.
>>>>
>>>> ```
>>>> if (!intel_pmu_broken_perf_cap()) {
>>>> 	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
>>>> 	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
>>>> }
>>>> ```
>>>>
>>>> It leads to the anythread_deprecated bit is cleared to 0 and the "any"
>>>> attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
>>>> these support Perfmon v6 platforms, like Clearwater Forest.
>>>>
>>>> ```
>>>> $grep . /sys/devices/cpu/format/*
>>>> /sys/devices/cpu/format/acr_mask:config2:0-63
>>>> /sys/devices/cpu/format/any:config:21
>>>> /sys/devices/cpu/format/cmask:config:24-31
>>>> ```
>>>>
>>>> So remove the anythread_deprecated bit from perf_capabilities structure
>>>> and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
>>>> deprecated.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Reported-by: Namhyung Kim <namhyung@kernel.org>
>>>> Fixes: cadbaa039b99 ("perf/x86/intel: Make anythread filter support conditional")
>>>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>> ---
>>>>  arch/x86/events/intel/core.c | 9 +++------
>>>>  arch/x86/events/perf_event.h | 2 +-
>>>>  2 files changed, 4 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>> index 793335c3ce78..450c63165a22 100644
>>>> --- a/arch/x86/events/intel/core.c
>>>> +++ b/arch/x86/events/intel/core.c
>>>> @@ -7612,11 +7612,8 @@ __init int intel_pmu_init(void)
>>>>  
>>>>  	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
>>>>  
>>>> -	if (version >= 5) {
>>>> -		x86_pmu.intel_cap.anythread_deprecated = edx.split.anythread_deprecated;
>>>> -		if (x86_pmu.intel_cap.anythread_deprecated)
>>>> -			pr_cont(" AnyThread deprecated, ");
>>>> -	}
>>>> +	if (version >= 5 && edx.split.anythread_deprecated)
>>>> +		pr_cont(" AnyThread deprecated, ");
>>>>  
>>>>  	/* The perf side of core PMU is ready to support the mediated vPMU. */
>>>>  	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
>>>> @@ -8467,7 +8464,7 @@ __init int intel_pmu_init(void)
>>>>  				      &x86_pmu.intel_ctrl);
>>>>  
>>>>  	/* AnyThread may be deprecated on arch perfmon v5 or later */
>>>> -	if (x86_pmu.intel_cap.anythread_deprecated)
>>>> +	if (edx.split.anythread_deprecated)
>>> Do we need to check the version here as well?
>> hmm, it should be enough to only check the CPUID
>> "edx.split.anythread_deprecated" bit  in practice. But if we want to follow
>> the SDM 100%, the version check should be added here.
>>
>> I would add an version check here. Thanks.
> How about merging pr_cont(" AnyThread deprecated, ") to here? No need to
> repeat "if (version >= 5 && edx.split.anythread_deprecated)" twice in
> one single API.

OK. Although it would change the perfmon print message order slightly, on
one should care about the message order. Thanks.


>
>
>>> Thanks,
>>> Namhyung
>>>
>>>
>>>>  		x86_pmu.format_attrs = intel_arch_formats_attr;
>>>>  
>
