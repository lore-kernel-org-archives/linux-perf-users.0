Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F64E1EB5E1;
	Wed, 23 Apr 2025 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446325; cv=none; b=MV+XjouWJ3STKhUezTx+GfBVoAzwi5aJBtwYK8zPoqSE1b7dFRHGTxIC6DokgQmlGXs8Xvqi0C97+vpga11C+tka4UHoFIfepF0jTPmTrW+jcXP8zNAIPWrog5rTjPgstJkpOVsuwlEWwvghl+vTScWK1XrHN5k+tRiPf1A/G+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446325; c=relaxed/simple;
	bh=LABfqZ4Uk4jqG7/HLj3qJ8R7UOLwRGwpcvmEI36Q0pg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=crVViEbkIi0FR2uooI16/5I83oRDk1eGqDnNmwiGBHELEtX1Wnk/7yJ2LgQcbqmEVp2vMABV3u1t5W6N1c5M3UzQWhCVDe02n/H7QIrPFllElmTIAE26CqYz1bGAfXrXG1YLwQA+5vTALfiB/PNuHCFOZLLV/MfsO89HOhb1GZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXfHJxth; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXfHJxth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745446324; x=1776982324;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=LABfqZ4Uk4jqG7/HLj3qJ8R7UOLwRGwpcvmEI36Q0pg=;
  b=WXfHJxthMym0fREOe4kMoEiVm9M+MbVNGKFy21rgH+IqYvckP2lxuK+X
   RSh4pFxZPPoBe4vk3ZiujjnuD/OoK9Pd2HsOdydkX7i9k5WPPbZ3SFORa
   +Fx61185Njy1853ta/g0va3fL7+KlnZO2NIoxNjh53FOF4ZIGWsX+qM4K
   ht4PqWyTl6a98aSta3BWm3PVBw57YUMuiVvrtiI7/Qd5Zfwt69G1kvGcs
   nEnx8ewadkabr8XGb8Z3Q16IlC06BfHi/5rOLRzyzmoAUPZd99kAGPC4N
   j7XsADT4cUjNnGyesnowJLC7bfP6JpJO4twxzaeQ36gWw95lc+dkB/XEL
   g==;
X-CSE-ConnectionGUID: J0AswTzGTJyZm6wdSvCeUw==
X-CSE-MsgGUID: qzlZ2mWFSl+aa8xMmhAznQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="64469375"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="64469375"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 15:12:03 -0700
X-CSE-ConnectionGUID: 3oaKo1/ZRyyG8FN3jQ+sww==
X-CSE-MsgGUID: BupJ80JpTFGHGi3+ygE0Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="169651800"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 15:12:03 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id BDF2020B5736;
	Wed, 23 Apr 2025 15:12:00 -0700 (PDT)
Message-ID: <a9d12369-9aca-473a-a660-478bfe969396@linux.intel.com>
Date: Wed, 23 Apr 2025 18:11:59 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Fix lbr event can placed into non lbr
 group
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250412091423.1839809-1-luogengkun@huaweicloud.com>
 <342ad7ad-417b-446d-8269-521a1ce9a6c6@linux.intel.com>
 <7b7642b8-2608-4349-b3cd-3c42eaafcabd@huaweicloud.com>
 <231276ba-bcdd-4d88-af07-4afe46da179b@huaweicloud.com>
 <f142d45d-4164-4883-ac4c-ea5b1c20c1c0@linux.intel.com>
Content-Language: en-US
In-Reply-To: <f142d45d-4164-4883-ac4c-ea5b1c20c1c0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-04-21 10:56 a.m., Liang, Kan wrote:
> 
> 
> On 2025-04-19 12:50 a.m., Luo Gengkun wrote:
>>
>> On 2025/4/19 10:25, Luo Gengkun wrote:
>>>
>>> On 2025/4/14 22:29, Liang, Kan wrote:
>>>>
>>>> On 2025-04-12 5:14 a.m., Luo Gengkun wrote:
>>>>> The following perf command can trigger a warning on
>>>>> intel_pmu_lbr_counters_reorder.
>>>>>
>>>>>   # perf record -e "{cpu-clock,cycles/call-graph="lbr"/}" -- sleep 1
>>>>>
>>>>> The reason is that a lbr event are placed in non lbr group. And the
>>>>> previous implememtation cannot force the leader to be a lbr event in
>>>>> this
>>>>> case.
>>>> Perf should only force the LBR leader for the branch counters case, so
>>>> perf only needs to reset the LBRs for the leader.
>>>> I don't think the leader restriction should be applied to other cases.
>>>
>>> Yes, the commit message should be updated.  The code implementation only
>>>
>>> restricts the leader to be an LBRs.
>>>
>>>>> And is_branch_counters_group will check if the group_leader supports
>>>>> BRANCH_COUNTERS.
>>>>> So if a software event becomes a group_leader, which
>>>>> hw.flags is -1, this check will alway pass.
>>>> I think the default flags for all events is 0. Can you point me to where
>>>> it is changed to -1?
>>>>
>>>> Thanks,
>>>> Kan>
>>>
>>> The hw_perf_event contains a union, hw.flags is used only for hardware
>>> events.
>>>
>>> For the software events, it uses hrtimer. Therefor, when
>>> perf_swevent_init_hrtimer
>>>
>>> is called, it changes the value of hw.flags too.
>>>
>>>
>>> Thanks,
>>>
>>> Gengkun
>>
>>
>> It seems that using union is dangerous because different types of
>> perf_events can be
>> placed in the same group.
> 
> Only the PMU with perf_sw_context can be placed in the same group with
> other types.
> 
>> Currently, a large number of codes directly
>> access the hw
>> of the leader, which is insecure. 
> 
> For X86, the topdown, ACR and branch counters will touch the
> leader.hw->flags. The topdown and ACR have already checked the leader
> before updating the flags. The branch counters missed it. I think a
> check is required for the branch counters as well, which should be good
> enough to address the issue.
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 16f8aea33243..406f58b3b5d4 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4256,6 +4256,12 @@ static int intel_pmu_hw_config(struct perf_event
> *event)
>  		 * group, which requires the extra space to store the counters.
>  		 */
>  		leader = event->group_leader;
> +		/*
> +		 * The leader's hw.flags will be used to determine a
> +		 * branch counter logging group. Force it a X86 event.
> +		 */
> +		if (!is_x86_event(leader))
> +			return -EINVAL;
>  		if (branch_sample_call_stack(leader))
>  			return -EINVAL;
>  		if (branch_sample_counters(leader)) {
>

The above check may not enough, since the
intel_pmu_lbr_counters_reorder() can be invoked without branch counters
event.

I've posted a fix to address the issue. Please take a look.
https://lore.kernel.org/lkml/20250423221015.268949-1-kan.liang@linux.intel.com/

Thanks,
Kan
>> This part of the logic needs to be
>> redesigned to void
>> similar problems. And I am happy to work for this.
>>
> 
> OK. Please share your idea.
> 
> Thanks,
> Kan
>>
>> Thanks,
>> Gengkun
>>>>> To fix this problem, using has_branch_stack to judge if leader is lbr
>>>>> event.
>>>>>
>>>>> Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
>>>>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>>>>> ---
>>>>>   arch/x86/events/intel/core.c | 14 +++++++-------
>>>>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/
>>>>> core.c
>>>>> index 09d2d66c9f21..c6b394019e54 100644
>>>>> --- a/arch/x86/events/intel/core.c
>>>>> +++ b/arch/x86/events/intel/core.c
>>>>> @@ -4114,6 +4114,13 @@ static int intel_pmu_hw_config(struct
>>>>> perf_event *event)
>>>>>               event->hw.flags |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>>>>>       }
>>>>>   +    /*
>>>>> +     * Force the leader to be a LBR event. So LBRs can be reset
>>>>> +     * with the leader event. See intel_pmu_lbr_del() for details.
>>>>> +     */
>>>>> +    if (has_branch_stack(event) && !has_branch_stack(event-
>>>>>> group_leader))
>>>>> +        return -EINVAL;
>>>>> +
>>>>>       if (branch_sample_counters(event)) {
>>>>>           struct perf_event *leader, *sibling;
>>>>>           int num = 0;
>>>>> @@ -4157,13 +4164,6 @@ static int intel_pmu_hw_config(struct
>>>>> perf_event *event)
>>>>>                 ~(PERF_SAMPLE_BRANCH_PLM_ALL |
>>>>>                   PERF_SAMPLE_BRANCH_COUNTERS)))
>>>>>               event->hw.flags  &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>>>>> -
>>>>> -        /*
>>>>> -         * Force the leader to be a LBR event. So LBRs can be reset
>>>>> -         * with the leader event. See intel_pmu_lbr_del() for details.
>>>>> -         */
>>>>> -        if (!intel_pmu_needs_branch_stack(leader))
>>>>> -            return -EINVAL;
>>>>>       }
>>>>>         if (intel_pmu_needs_branch_stack(event)) {
>>
> 
> 

