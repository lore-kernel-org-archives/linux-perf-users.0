Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D642D9797;
	Wed, 22 Jul 2026 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784703844; cv=none; b=BtRNRb8/kGIFMgNlCx0VvE1ZuMPBx0Mn35W9YTaDTiGPIlt6g+FGroMPnAznziOvIm6g04Qh7BIWVEI5SjfO/AQ87Ika7401hBmQ/CPSLJlTSDQy9LkVj+2Gyic4k9IpzufrOkfvSNOhDoK/GM8sQS8rz0HbrtrUvhrIBbzgTgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784703844; c=relaxed/simple;
	bh=Cx5Za+uFef9to29zdOxCBbySLp0sY8AOg0ZnTvsETLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/cecRscKV63YxtUJ66kpja8WLtNDd0ro2nl8VK2LG9g92UK8PkHJYSD7Y9GGBblRW4KN/UfRkjD5RgYRNfyQUPQYp1vsvisHa1mDXwwtBRjJHUf5vGOCq25Qpgxh+kKowFxCVfoe9/ykNjfEDQCzeME98Jk2BRYJJVOdEC7HUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h4lZq3yH1zKHMXR;
	Wed, 22 Jul 2026 15:03:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D31EA40802;
	Wed, 22 Jul 2026 15:03:58 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgAH7Shda2BqTZGBCA--.6081S2;
	Wed, 22 Jul 2026 15:03:58 +0800 (CST)
Message-ID: <e0ecd619-80b2-4d40-8472-a2944705e83d@huaweicloud.com>
Date: Wed, 22 Jul 2026 15:03:57 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/21] perf auxtrace: Set default period to 1 for
 PERF_ITRACE_PERIOD_INSTRUCTIONS type
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Ian Rogers <irogers@google.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-12-wutengda@huaweicloud.com>
 <07c8c780-5eeb-4310-80cd-3ff18952a688@intel.com>
 <f7a94138-e29f-4b1a-948d-ef4933e7d0c5@huaweicloud.com>
 <8fa4da51-6fee-450d-915a-eb4c4de03961@intel.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <8fa4da51-6fee-450d-915a-eb4c4de03961@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAH7Shda2BqTZGBCA--.6081S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXryxZw1DZw13JF15tw15CFg_yoW5XFW3pr
	nFqayftr4kJry8Kr1xtr4Uu3Wayw42qF1UW34rJrWjy3Wq9F18tF47tr15C3y8Gr1rCr17
	JFWqqry7uryUJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/22 14:32, Adrian Hunter wrote:
> On 21/07/2026 14:39, Tengda Wu wrote:
>> Hi Adrian,
>>
>> On 2026/7/21 16:08, Adrian Hunter wrote:
>>> On 01/07/2026 06:53, Tengda Wu wrote:
>>>> When using --itrace=M for data type profiling on arm64, the 'Percent'
>>>> values in perf annotate output are all zero:
>>>>
>>>> Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
>>>> ============================================================================
>>>>  Percent     offset       size  field
>>>>     0.00          0       0x10  struct mmu_gather_batch  {
>>>>     0.00          0        0x8      struct mmu_gather_batch*    next;
>>>>     0.00        0x8        0x4      unsigned int        nr;
>>>>     0.00        0xc        0x4      unsigned int        max;
>>>>     0.00       0x10          0      struct encoded_page*[]      encoded_pages;
>>>>                                 };
>>>>
>>>> However, adding the -n option reveals non-zero sample counts:
>>>>
>>>> Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
>>>> ============================================================================
>>>>  Samples     offset       size  field
>>>>       15          0       0x10  struct mmu_gather_batch  {
>>>>       13          0        0x8      struct mmu_gather_batch*    next;
>>>>        2        0x8        0x4      unsigned int        nr;
>>>>        0        0xc        0x4      unsigned int        max;
>>>>        0       0x10          0      struct encoded_page*[]      encoded_pages;
>>>>                                 };
>>>>
>>>> The root cause is that when period is not explicitly specified in the
>>>> --itrace option, it remains zero after itrace_do_parse_synth_opts().
>>>> The zero period then flows through annotated_data_type__update_samples()
>>>> where h->period accumulates to zero, and print_annotated_data_type_value()
>>>> calculates the 'Percent' as zero.
>>>
>>> The period is for instructions samples i.e. options 'i' or 'y'.  Why is
>>> it being used in the 'M' case?  What samples are being synthesized in
>>> that case?
>>>
>>
>> The 'M' case is just one example. On arm64, 't' and 'f' also have the
>> same percent-zero issue.
>>
>> How ARM SPE synthesizes events:
>>
>> ARM SPE can synthesize multiple event types from a single instruction.
>> For example, the 'M' case targets instructions that cause memory
>> interaction events, while the 't' case targets instructions that trigger
>> TLB access/miss events. Users can specify the desired event types via
>> the itrace option to obtain corresponding data type profiling results.
>>
>> How data type computes Percent:
>>
>> Data type profiling computes Percent based on the period. The flow is as
>> follows:
>>
>> arm_spe_prep_sample():
>>         sample->period = spe->synth_opts.period;
> 
> It seems like only arm-spe has the unusual period handling.
> Please make the period non-zero when it is set up in
> arm_spe_process_auxtrace_info() and add a comment explaining why.
> 

Okay, I'll handle it this way.

Thanks,
Tengda

