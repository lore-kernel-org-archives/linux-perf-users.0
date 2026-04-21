Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C7194C96;
	Tue, 21 Apr 2026 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808727; cv=none; b=RgqABzI2OKo9jietRWX7WvhrnRuSQNQy84bWAwTu1Qu6NTN/ij7s5Kat7WVlXPnDbDXPM54OgFpyKNgKkiNBPZE88MZ0WCU5hG6Xw3OuZZQKrzctYws+/mHNcDyz90Hf5e336JuoN4rxGiyiU7k4RnkBjJP/Fe5JInkKgDkMY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808727; c=relaxed/simple;
	bh=mM9l120PwvCb6pBLBa97RryQjf936e+knIHkhOOg0X4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tuTaaz9xOQJ4bUdVQq3kdcQDCGI43uaNjka0N4myM0Xvmr0/GlZqM9ynlzrb1+5+2HlVNG+rgCvVPaNLTBbvqBfsy9SzdTndQBweXidmDBdnKHgMgB7eSHPyqU9E9PIodkktlatSLQLiuDQbs1OmjD3pQGDCfz5vtc5NN1nQNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iT5NkZMq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iT5NkZMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776808725; x=1808344725;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=mM9l120PwvCb6pBLBa97RryQjf936e+knIHkhOOg0X4=;
  b=iT5NkZMq7DXMHAtBm/o/MKN2VLtG8VKxohzg//tSOeJqDTvsWYqdJWB/
   1t5ftoqSsJ9LUTZhpwyOyl2JcgcLaN7jzglSs/5PIREahfTm6L+fxMTU0
   crm/DUwBfQ7h2SkRk8SQmGJnrJOuOWsdh2vAoBlWvjtHPcJ9NF6a9N1WO
   fEiourr79/CY057Z/x9iEJiS/I3CvI/DZyBxSuWdAtLXhOM0SboOQFZIe
   c/SNaw9ApEKK5sBpXSE5XZuDmRvRFuY8g74TZPghHm/S6rDHJZ6OTOhCU
   pFnIupFVnopeKivTvkrvaMxK4auGWf35jE/QRlucqUD4xDtuGTQIpLBTB
   A==;
X-CSE-ConnectionGUID: pWXh6l7RTHW9WByiZl0kVA==
X-CSE-MsgGUID: spVCcThGRDeEkokWDV167g==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77824121"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77824121"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 14:58:43 -0700
X-CSE-ConnectionGUID: 6rwEQcXFSKyScyFWN+o0OQ==
X-CSE-MsgGUID: ny8u1QXOSDu2KwzqKBKJ9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232452487"
Received: from unknown (HELO [10.241.241.106]) ([10.241.241.106])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 14:58:42 -0700
Message-ID: <546d7ebd-492c-4544-bcb0-adf4046a2447@intel.com>
Date: Tue, 21 Apr 2026 14:58:42 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Chen, Zide" <zide.chen@intel.com>
Subject: Re: [PATCH] perf/x86/intel: Remove anythread_deprecated bit from
 perf_capabilities
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>
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
Content-Language: en-US
In-Reply-To: <d93ccac4-d1c6-4d56-9714-33a32e5c4f48@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/20/2026 5:51 PM, Mi, Dapeng wrote:
> 
> On 4/21/2026 5:23 AM, Namhyung Kim wrote:
>> On Wed, Apr 15, 2026 at 10:10:10AM +0800, Dapeng Mi wrote:
>>> AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
>>> PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
>>> represent "anythread deprecation" in perf_capabilities. It leads to the
>>> anythread_deprecated bit could be overwritten by the real value of
>>> PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.
>>>
>>> ```
>>> if (!intel_pmu_broken_perf_cap()) {
>>> 	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
>>> 	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
>>> }
>>> ```
>>>
>>> It leads to the anythread_deprecated bit is cleared to 0 and the "any"
>>> attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
>>> these support Perfmon v6 platforms, like Clearwater Forest.
>>>
>>> ```
>>> $grep . /sys/devices/cpu/format/*
>>> /sys/devices/cpu/format/acr_mask:config2:0-63
>>> /sys/devices/cpu/format/any:config:21
>>> /sys/devices/cpu/format/cmask:config:24-31
>>> ```
>>>
>>> So remove the anythread_deprecated bit from perf_capabilities structure
>>> and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
>>> deprecated.
>>>
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Namhyung Kim <namhyung@kernel.org>
>>> Fixes: cadbaa039b99 ("perf/x86/intel: Make anythread filter support conditional")
>>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> ---
>>>  arch/x86/events/intel/core.c | 9 +++------
>>>  arch/x86/events/perf_event.h | 2 +-
>>>  2 files changed, 4 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index 793335c3ce78..450c63165a22 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -7612,11 +7612,8 @@ __init int intel_pmu_init(void)
>>>  
>>>  	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
>>>  
>>> -	if (version >= 5) {
>>> -		x86_pmu.intel_cap.anythread_deprecated = edx.split.anythread_deprecated;
>>> -		if (x86_pmu.intel_cap.anythread_deprecated)
>>> -			pr_cont(" AnyThread deprecated, ");
>>> -	}
>>> +	if (version >= 5 && edx.split.anythread_deprecated)
>>> +		pr_cont(" AnyThread deprecated, ");
>>>  
>>>  	/* The perf side of core PMU is ready to support the mediated vPMU. */
>>>  	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
>>> @@ -8467,7 +8464,7 @@ __init int intel_pmu_init(void)
>>>  				      &x86_pmu.intel_ctrl);
>>>  
>>>  	/* AnyThread may be deprecated on arch perfmon v5 or later */
>>> -	if (x86_pmu.intel_cap.anythread_deprecated)
>>> +	if (edx.split.anythread_deprecated)
>> Do we need to check the version here as well?
> 
> hmm, it should be enough to only check the CPUID
> "edx.split.anythread_deprecated" bit  in practice. But if we want to follow
> the SDM 100%, the version check should be added here.
> 
> I would add an version check here. Thanks.

How about merging pr_cont(" AnyThread deprecated, ") to here? No need to
repeat "if (version >= 5 && edx.split.anythread_deprecated)" twice in
one single API.


>>
>> Thanks,
>> Namhyung
>>
>>
>>>  		x86_pmu.format_attrs = intel_arch_formats_attr;
>>>  

