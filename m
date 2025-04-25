Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E228195808;
	Fri, 25 Apr 2025 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745552653; cv=none; b=cyyy4PqZqKO4LpgjoOycZzIqSe8Z956MvCienKv+z9kd7ludEPN0nFLnhnxAzqXQOxEOwADy0Spaetn9c6gUPpxH+hdfnBJaNEJY/2L8aFGhcHIwo3bRy7PdBshJzsHnXWAzRe91MWRMHLD9wWt70MxljBpJ51M83JD1UD8Uqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745552653; c=relaxed/simple;
	bh=C+PlvwyiVxvSAR/Lb3vYBgjgbXtxr++0MUnqWe5M/I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRo7nTXhhOrY1Mklku28epFAO7Zu+JFPsPFpZjRtDQUFN7Aq1xhsHtMTq7GXZnBGhfOORS0MjShoORcjSnGobUNzTivOO88T7vw9bgdoEqdLiZA4NW2HQNyHsy7VHF1q9lPw5iMNIY6J70/rioW6b2V+M4XaTdUKGNWXKgWbT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZkJbk4vSNz4f3jLm;
	Fri, 25 Apr 2025 11:43:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 678A61A06D7;
	Fri, 25 Apr 2025 11:44:05 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP1 (Coremail) with SMTP id cCh0CgBHq3sBBQtosqhRKQ--.26866S3;
	Fri, 25 Apr 2025 11:44:02 +0800 (CST)
Message-ID: <f0f1d9d1-ffae-4075-ab39-b96516e247db@huaweicloud.com>
Date: Fri, 25 Apr 2025 11:44:01 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Fix lbr event can placed into non lbr
 group
Content-Language: en-US
To: "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org
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
 <a9d12369-9aca-473a-a660-478bfe969396@linux.intel.com>
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <a9d12369-9aca-473a-a660-478bfe969396@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHq3sBBQtosqhRKQ--.26866S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JFyUKF4xAFyfWr1rKr1ftFb_yoW7ur1Dpr
	n5JF4UKFWUWwn5u348tr1UtFyUtrykt3Z5Wr1UJFyUJr1qvr1aqF4UX34Y9r95Gr48JFyr
	Xw1UXr17ZFy5JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	aFAJUUUUU==
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/


On 2025/4/24 6:11, Liang, Kan wrote:
>
> On 2025-04-21 10:56 a.m., Liang, Kan wrote:
>>
>> On 2025-04-19 12:50 a.m., Luo Gengkun wrote:
>>> On 2025/4/19 10:25, Luo Gengkun wrote:
>>>> On 2025/4/14 22:29, Liang, Kan wrote:
>>>>> On 2025-04-12 5:14 a.m., Luo Gengkun wrote:
>>>>>> The following perf command can trigger a warning on
>>>>>> intel_pmu_lbr_counters_reorder.
>>>>>>
>>>>>>    # perf record -e "{cpu-clock,cycles/call-graph="lbr"/}" -- sleep 1
>>>>>>
>>>>>> The reason is that a lbr event are placed in non lbr group. And the
>>>>>> previous implememtation cannot force the leader to be a lbr event in
>>>>>> this
>>>>>> case.
>>>>> Perf should only force the LBR leader for the branch counters case, so
>>>>> perf only needs to reset the LBRs for the leader.
>>>>> I don't think the leader restriction should be applied to other cases.
>>>> Yes, the commit message should be updated.  The code implementation only
>>>>
>>>> restricts the leader to be an LBRs.
>>>>
>>>>>> And is_branch_counters_group will check if the group_leader supports
>>>>>> BRANCH_COUNTERS.
>>>>>> So if a software event becomes a group_leader, which
>>>>>> hw.flags is -1, this check will alway pass.
>>>>> I think the default flags for all events is 0. Can you point me to where
>>>>> it is changed to -1?
>>>>>
>>>>> Thanks,
>>>>> Kan>
>>>> The hw_perf_event contains a union, hw.flags is used only for hardware
>>>> events.
>>>>
>>>> For the software events, it uses hrtimer. Therefor, when
>>>> perf_swevent_init_hrtimer
>>>>
>>>> is called, it changes the value of hw.flags too.
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> Gengkun
>>>
>>> It seems that using union is dangerous because different types of
>>> perf_events can be
>>> placed in the same group.
>> Only the PMU with perf_sw_context can be placed in the same group with
>> other types.
>>
>>> Currently, a large number of codes directly
>>> access the hw
>>> of the leader, which is insecure.
>> For X86, the topdown, ACR and branch counters will touch the
>> leader.hw->flags. The topdown and ACR have already checked the leader
>> before updating the flags. The branch counters missed it. I think a
>> check is required for the branch counters as well, which should be good
>> enough to address the issue.
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 16f8aea33243..406f58b3b5d4 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4256,6 +4256,12 @@ static int intel_pmu_hw_config(struct perf_event
>> *event)
>>   		 * group, which requires the extra space to store the counters.
>>   		 */
>>   		leader = event->group_leader;
>> +		/*
>> +		 * The leader's hw.flags will be used to determine a
>> +		 * branch counter logging group. Force it a X86 event.
>> +		 */
>> +		if (!is_x86_event(leader))
>> +			return -EINVAL;
>>   		if (branch_sample_call_stack(leader))
>>   			return -EINVAL;
>>   		if (branch_sample_counters(leader)) {
>>
> The above check may not enough, since the
> intel_pmu_lbr_counters_reorder() can be invoked without branch counters
> event.
>
> I've posted a fix to address the issue. Please take a look.
> https://lore.kernel.org/lkml/20250423221015.268949-1-kan.liang@linux.intel.com/
>
> Thanks,
> Kan


LGTM.
Thanks,
Gengkun
>>> This part of the logic needs to be
>>> redesigned to void
>>> similar problems. And I am happy to work for this.
>>>
>> OK. Please share your idea.
>>
>> Thanks,
>> Kan
>>> Thanks,
>>> Gengkun
>>>>>> To fix this problem, using has_branch_stack to judge if leader is lbr
>>>>>> event.
>>>>>>
>>>>>> Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
>>>>>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>>>>>> ---
>>>>>>    arch/x86/events/intel/core.c | 14 +++++++-------
>>>>>>    1 file changed, 7 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/
>>>>>> core.c
>>>>>> index 09d2d66c9f21..c6b394019e54 100644
>>>>>> --- a/arch/x86/events/intel/core.c
>>>>>> +++ b/arch/x86/events/intel/core.c
>>>>>> @@ -4114,6 +4114,13 @@ static int intel_pmu_hw_config(struct
>>>>>> perf_event *event)
>>>>>>                event->hw.flags |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>>>>>>        }
>>>>>>    +    /*
>>>>>> +     * Force the leader to be a LBR event. So LBRs can be reset
>>>>>> +     * with the leader event. See intel_pmu_lbr_del() for details.
>>>>>> +     */
>>>>>> +    if (has_branch_stack(event) && !has_branch_stack(event-
>>>>>>> group_leader))
>>>>>> +        return -EINVAL;
>>>>>> +
>>>>>>        if (branch_sample_counters(event)) {
>>>>>>            struct perf_event *leader, *sibling;
>>>>>>            int num = 0;
>>>>>> @@ -4157,13 +4164,6 @@ static int intel_pmu_hw_config(struct
>>>>>> perf_event *event)
>>>>>>                  ~(PERF_SAMPLE_BRANCH_PLM_ALL |
>>>>>>                    PERF_SAMPLE_BRANCH_COUNTERS)))
>>>>>>                event->hw.flags  &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>>>>>> -
>>>>>> -        /*
>>>>>> -         * Force the leader to be a LBR event. So LBRs can be reset
>>>>>> -         * with the leader event. See intel_pmu_lbr_del() for details.
>>>>>> -         */
>>>>>> -        if (!intel_pmu_needs_branch_stack(leader))
>>>>>> -            return -EINVAL;
>>>>>>        }
>>>>>>          if (intel_pmu_needs_branch_stack(event)) {
>>

