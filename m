Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99465DDBC;
	Sat, 19 Apr 2025 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745038255; cv=none; b=cFzRiIVetcHiTk7a37JfGVgMr36fXlvgX7Zb2d2atGIWKZqr7thJKXld4LbyuLG/kBpjcj0xbS5G3cu4MurBmZF4/Tj8ENiGR/+Ap4qj/b/a1Nm8SoX3S6CJDTTgV4GRBgDGncqEGt/KxACy7QvhMofc32DFJ2AObUDlyWT20h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745038255; c=relaxed/simple;
	bh=2ftc5ejbzpeva4waI8OSByzjRMedKnQgk4uz+UHSB0s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FXYteYQpzcFlAwM0qwALn4iNoyHA9W8qG0zJKrDLWrsoAOI+z3VmLAk4k0ElkaMEQTssjP0maj9VI0+jp7EqP10tjsqFff8PR+85LTxPWZJkXwB3ZAjCOMkdUiFsnLWUy768BxcRg7M95XKZN2dpeoCuCTT8x+/vULoDNanXEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZffML1b03z4f3m6s;
	Sat, 19 Apr 2025 12:50:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 88A941A058E;
	Sat, 19 Apr 2025 12:50:47 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgAHa1+mKwNo5N2nJw--.29213S3;
	Sat, 19 Apr 2025 12:50:47 +0800 (CST)
Message-ID: <231276ba-bcdd-4d88-af07-4afe46da179b@huaweicloud.com>
Date: Sat, 19 Apr 2025 12:50:45 +0800
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
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250412091423.1839809-1-luogengkun@huaweicloud.com>
 <342ad7ad-417b-446d-8269-521a1ce9a6c6@linux.intel.com>
 <7b7642b8-2608-4349-b3cd-3c42eaafcabd@huaweicloud.com>
In-Reply-To: <7b7642b8-2608-4349-b3cd-3c42eaafcabd@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHa1+mKwNo5N2nJw--.29213S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW7ZrWUZr1DZFykJr1fWFg_yoWrJw15pr
	n5JF45KFW5Wwn5u34ftr1UtFyUtr1kJ3Z8Gw1UtFyUXF4qvr12gF4UX34Y9r98Ar48Jryr
	Xw1UXr17ZFy5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFk
	u4UUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/


On 2025/4/19 10:25, Luo Gengkun wrote:
>
> On 2025/4/14 22:29, Liang, Kan wrote:
>>
>> On 2025-04-12 5:14 a.m., Luo Gengkun wrote:
>>> The following perf command can trigger a warning on
>>> intel_pmu_lbr_counters_reorder.
>>>
>>>   # perf record -e "{cpu-clock,cycles/call-graph="lbr"/}" -- sleep 1
>>>
>>> The reason is that a lbr event are placed in non lbr group. And the
>>> previous implememtation cannot force the leader to be a lbr event in 
>>> this
>>> case.
>> Perf should only force the LBR leader for the branch counters case, so
>> perf only needs to reset the LBRs for the leader.
>> I don't think the leader restriction should be applied to other cases.
>
> Yes, the commit message should be updated.  The code implementation only
>
> restricts the leader to be an LBRs.
>
>>> And is_branch_counters_group will check if the group_leader supports
>>> BRANCH_COUNTERS.
>>> So if a software event becomes a group_leader, which
>>> hw.flags is -1, this check will alway pass.
>> I think the default flags for all events is 0. Can you point me to where
>> it is changed to -1?
>>
>> Thanks,
>> Kan>
>
> The hw_perf_event contains a union, hw.flags is used only for hardware 
> events.
>
> For the software events, it uses hrtimer. Therefor, when 
> perf_swevent_init_hrtimer
>
> is called, it changes the value of hw.flags too.
>
>
> Thanks,
>
> Gengkun


It seems that using union is dangerous because different types of 
perf_events can be
placed in the same group. Currently, a large number of codes directly 
access the hw
of the leader, which is insecure. This part of the logic needs to be 
redesigned to void
similar problems. And I am happy to work for this.


Thanks,
Gengkun
>>> To fix this problem, using has_branch_stack to judge if leader is lbr
>>> event.
>>>
>>> Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
>>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>>> ---
>>>   arch/x86/events/intel/core.c | 14 +++++++-------
>>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/x86/events/intel/core.c 
>>> b/arch/x86/events/intel/core.c
>>> index 09d2d66c9f21..c6b394019e54 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -4114,6 +4114,13 @@ static int intel_pmu_hw_config(struct 
>>> perf_event *event)
>>>               event->hw.flags |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>>>       }
>>>   +    /*
>>> +     * Force the leader to be a LBR event. So LBRs can be reset
>>> +     * with the leader event. See intel_pmu_lbr_del() for details.
>>> +     */
>>> +    if (has_branch_stack(event) && 
>>> !has_branch_stack(event->group_leader))
>>> +        return -EINVAL;
>>> +
>>>       if (branch_sample_counters(event)) {
>>>           struct perf_event *leader, *sibling;
>>>           int num = 0;
>>> @@ -4157,13 +4164,6 @@ static int intel_pmu_hw_config(struct 
>>> perf_event *event)
>>>                 ~(PERF_SAMPLE_BRANCH_PLM_ALL |
>>>                   PERF_SAMPLE_BRANCH_COUNTERS)))
>>>               event->hw.flags  &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>>> -
>>> -        /*
>>> -         * Force the leader to be a LBR event. So LBRs can be reset
>>> -         * with the leader event. See intel_pmu_lbr_del() for details.
>>> -         */
>>> -        if (!intel_pmu_needs_branch_stack(leader))
>>> -            return -EINVAL;
>>>       }
>>>         if (intel_pmu_needs_branch_stack(event)) {

