Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0B423372C
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783562987; cv=none; b=lmKq21ACx5BgtXSUopAfrR8EceV++pJSvbMZ8bHlG+Qn8WLZj1/SDsHqV0DOCG0G/SocY5Xbo1vJVk96K2GpG+Lt1UG2FjjN8W9JiNJwNnW2GzExoCYIolvWnO5b1Ewt2bUwvxsD8AD7oDQgcrcf+FVBTJAMUwwULBpl732Y8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783562987; c=relaxed/simple;
	bh=ByyfsO+oybVxGImcwOwMAd2J+crIhdjtXGqoawgXPR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B+zwR3arkfou8IXwaM+iPFh0hjfOcTQF91tXWUZOQcLH4EqWpM5tGALN5NJmv7llGQLDX8jfmpJS/oGJgjt0BiuYeGZoZP3o6iKqDWkCZVN8OUIUeeTsQZlCcKwzuAuw/KEljbyxkzgL1dUxuTRuVFNJpJ4pmGNa7dZp8e0Lv7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gwdgn0XKCz27RGB;
	Thu,  9 Jul 2026 10:09:25 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gwdgk21wwz27RGB;
	Thu,  9 Jul 2026 10:09:22 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 7E6B9301C0DA;
	Thu,  9 Jul 2026 10:07:08 +0800 (CST)
Received: from [172.25.61.61] (172.25.61.61) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 9 Jul
 2026 10:09:23 +0800
Message-ID: <ac3eca97-1a29-4d5c-9cfa-19cbc4dcb9e9@hygon.cn>
Date: Thu, 9 Jul 2026 10:09:22 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] perf/x86/amd/uncore: Add Hygon uncore PMU support
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-perf-users@vger.kernel.org>
References: <20260708131315.13766-1-liuqi@hygon.cn>
 <20260708131315.13766-2-liuqi@hygon.cn>
 <20260708132741.9DF131F000E9@smtp.kernel.org>
Content-Language: en-US
From: Qi Liu <liuqi@hygon.cn>
In-Reply-To: <20260708132741.9DF131F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

Hi,

On 7/8/2026 9:27 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Module initialization error path fails to unregister PMUs and leaks per-CPU arrays, leading to a Use-After-Free.
> - [Medium] The CPU online callback aborts PMU initialization on the first failure, leaving remaining independent PMUs uninitialized.
> - [Medium] The patch removes L3 cache uncore PMU support for Hygon processors without providing a replacement.
> - [Medium] The `update_interval` module parameter lacks bounds checking, allowing a value of 0 to cause a CPU-locking interrupt storm.
> --
> 
> --- Patch [1]: [PATCH v3 1/2] perf/x86/amd/uncore: Add Hygon uncore PMU support ---
> commit 451a8d6c91c9ade8b2dbc942f864d5c36dc872c9
> Author: Qi Liu <liuqi@hygon.cn>
> Subject: perf/x86/amd/uncore: Add Hygon uncore PMU support
> 
> This commit adds a new uncore PMU driver specifically for Hygon Family 18h
> processors, supporting Data Fabric and IO Die counters. It also removes the
> Hygon-specific checks from the AMD uncore driver to keep the vendor
> implementations separate.
> 
>> diff --git a/arch/x86/events/amd/hygon_uncore.c b/arch/x86/events/amd/hygon_uncore.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/arch/x86/events/amd/hygon_uncore.c
>> @@ -0,0 +1,863 @@
> 
> [ ... ]
> 
>> +/* Interval for hrtimer, defaults to 60000 milliseconds */
>> +static unsigned int update_interval = 60 * MSEC_PER_SEC;
>> +module_param(update_interval, uint, 0444);
> 
> [Severity: Medium]
> Could setting this to 0 cause an interrupt storm? If a privileged user loads
> the module with update_interval=0, hrtimer_duration becomes 0. When this is
> passed to hrtimer_forward_now(), it is clamped to the minimum resolution,
> causing the high-resolution timer to fire continuously in a loop. Should
> there be a minimum bounds check here to prevent a CPU lockup?
will fix this.>
> [ ... ]
> 
>> +static int hygon_uncore_cpu_online(unsigned int cpu)
>> +{
>> +	struct hygon_uncore *uncore;
>> +	int i;
>> +
>> +	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
>> +		uncore = &uncores[i];
>> +		if (uncore->init(uncore, cpu))
>> +			break;
> 
> [Severity: Medium]
> Should this be a continue instead of a break? If the first PMU type (e.g.,
> hygon_df) fails to initialize, this break aborts the loop, which prevents
> any subsequent independent PMUs (like hygon_df_iod) from initializing on
> this CPU. The same patch corrects this exact logic flaw in
> amd_uncore_cpu_online(), but it seems to have been reintroduced here.
> 
will fix this.>> +	}
>> +
>> +	return 0;
>> +}
> 
> [ ... ]
> 
>> +fail_start:
>> +	cpuhp_remove_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_STARTING);
>> +fail_prep:
>> +	cpuhp_remove_state(CPUHP_PERF_X86_HYGON_UNCORE_PREP);
>> +fail:
>> +	hygon_uncore_info_cleanup();
>> +	return ret;
>> +}
> 
> [Severity: High]
> Does this error path leak the registered PMUs? If cpuhp_setup_state()
> fails for the ONLINE state, we remove the previous hotplug states but it
> looks like hygon_uncore_pmu_cleanup() is never called.
> 
> Any PMUs successfully registered during the initial CPU online callbacks
> would remain registered, and their per-CPU arrays would not be freed. When
> the module unloads, could this lead to a use-after-free if the perf
> subsystem tries to access the freed module memory?
> 
hygon_uncore_cpu_online() always returns 0, so cpuhp_setup_state() for the 
ONLINE state will never fail due to a callback error. The only failure mode is 
that the state slot itself cannot be registered — in which case the startup 
callbacks were never invoked and no PMUs were ever registered.

> [ ... ]
> 
>> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
>> index dbc00b6dd69ee..3f8e40abba736 100644
>> --- a/arch/x86/events/amd/uncore.c
>> +++ b/arch/x86/events/amd/uncore.c
> 
> [ ... ]
> 
>> @@ -1120,8 +1116,7 @@ static int __init amd_uncore_init(void)
>>   	int ret = -ENODEV;
>>   	int i;
>>   
>> -	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
>> -	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
>> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>>   		return -ENODEV;
> 
> [Severity: Medium]
> Does this intentionally drop L3 cache uncore support for Hygon? By
> removing Hygon support here in amd_uncore.c, the previous L3 cache
> counters are no longer available. Looking at the new hygon_uncore.c, it
> only implements the Data Fabric and IO Die PMUs, meaning L3 PMU support
> appears to be lost completely.
> 

Yes, this is intentional. L3 and UMC PMU support for Hygon will be added in 
follow-up series. This series focuses specifically on Data Fabric uncore PMU 
support as the initial step.

Thanks,
Qi>>   	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
>>   		return -ENODEV;
> 


