Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EF454654;
	Sat, 19 Apr 2025 02:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745029521; cv=none; b=mBEset6AzC1HpZilLUMAatrw2HvAc3TAAi0Kl/40b5j4S2TZV64tHa1ehUaYiQcPXQ9eFcyVc+6AoNxG8G30n4BQHfgi9MDj6C9rXyx1q5IsSa7P0bPNg64+EJvYsMdNA3f2aFURaWDpZbbFxJKU1n/L/RMJBFPl8Iz9XciRdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745029521; c=relaxed/simple;
	bh=LvUF0hUDUiDHSIMaLZuAHDmZs47+xPNqVYRb+fSFJLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gv+DgSIokLnT4J2TrcaLyoMZs+hfHAGytqXGN+LJiUz96xGdCPnVi1Du10QEGhHB4u3GobVOVhcoZD8XqxiIv0O8jPSURn62mr4M2rb+j0FhW9UDfu4gcLFf7kGza+EihXEMsPxmUQ+rFG5eFvEZ4VCKuMu599rKikTRJTD7Wrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zfb7P3jZWz4f3m7T;
	Sat, 19 Apr 2025 10:24:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D24E11A13FA;
	Sat, 19 Apr 2025 10:25:14 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl+JCQNo+xeeJw--.23807S3;
	Sat, 19 Apr 2025 10:25:14 +0800 (CST)
Message-ID: <7b7642b8-2608-4349-b3cd-3c42eaafcabd@huaweicloud.com>
Date: Sat, 19 Apr 2025 10:25:13 +0800
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
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <342ad7ad-417b-446d-8269-521a1ce9a6c6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl+JCQNo+xeeJw--.23807S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWxCry8Ww13AF1UZFyxZrb_yoW5WrWkp3
	yfJF43KF4jgwn5u3s3tFnrtF4Yvr1vq3Z5G347try3X3Z0vr9xtFWxK345Cr95uw1xAryf
	Xw10vryUCas8Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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


On 2025/4/14 22:29, Liang, Kan wrote:
>
> On 2025-04-12 5:14 a.m., Luo Gengkun wrote:
>> The following perf command can trigger a warning on
>> intel_pmu_lbr_counters_reorder.
>>
>>   # perf record -e "{cpu-clock,cycles/call-graph="lbr"/}" -- sleep 1
>>
>> The reason is that a lbr event are placed in non lbr group. And the
>> previous implememtation cannot force the leader to be a lbr event in this
>> case.
> Perf should only force the LBR leader for the branch counters case, so
> perf only needs to reset the LBRs for the leader.
> I don't think the leader restriction should be applied to other cases.

Yes, the commit message should be updated.  The code implementation only

restricts the leader to be an LBRs.

>> And is_branch_counters_group will check if the group_leader supports
>> BRANCH_COUNTERS.
>> So if a software event becomes a group_leader, which
>> hw.flags is -1, this check will alway pass.
> I think the default flags for all events is 0. Can you point me to where
> it is changed to -1?
>
> Thanks,
> Kan>

The hw_perf_event contains a union, hw.flags is used only for hardware 
events.

For the software events, it uses hrtimer. Therefor, when 
perf_swevent_init_hrtimer

is called, it changes the value of hw.flags too.


Thanks,

Gengkun

>> To fix this problem, using has_branch_stack to judge if leader is lbr
>> event.
>>
>> Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>> ---
>>   arch/x86/events/intel/core.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 09d2d66c9f21..c6b394019e54 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4114,6 +4114,13 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>   			event->hw.flags |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>>   	}
>>   
>> +	/*
>> +	 * Force the leader to be a LBR event. So LBRs can be reset
>> +	 * with the leader event. See intel_pmu_lbr_del() for details.
>> +	 */
>> +	if (has_branch_stack(event) && !has_branch_stack(event->group_leader))
>> +		return -EINVAL;
>> +
>>   	if (branch_sample_counters(event)) {
>>   		struct perf_event *leader, *sibling;
>>   		int num = 0;
>> @@ -4157,13 +4164,6 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>   			  ~(PERF_SAMPLE_BRANCH_PLM_ALL |
>>   			    PERF_SAMPLE_BRANCH_COUNTERS)))
>>   			event->hw.flags  &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>> -
>> -		/*
>> -		 * Force the leader to be a LBR event. So LBRs can be reset
>> -		 * with the leader event. See intel_pmu_lbr_del() for details.
>> -		 */
>> -		if (!intel_pmu_needs_branch_stack(leader))
>> -			return -EINVAL;
>>   	}
>>   
>>   	if (intel_pmu_needs_branch_stack(event)) {

