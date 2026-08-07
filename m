Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF841A918
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097162; cv=none; b=pTmCsOCGWptonnGt6fNiHtTO7jtjhQotigb3eGIVGD/yqYm7HvH/mrQm/GKJmOt57A4rfeWOoj/rQ2LRrkIuBigg4VeZrPwrrDf0iZGqGQtF0qtVP16KfzRhZHFZrRCwHprQo+t9UDQK1YyJ99Npqa2lzljHXmnF4Jr/BUY5Yn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097162; c=relaxed/simple;
	bh=sA5sKBqdjln4LVJdf4f3i0ubipaw/kZhUE3epTeGjs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5OFjmCZ4Lj3NjcsMe2q774HAmddlmWyjDrpsderkbPCcz3+oL9xzC/SlQeW6wOOiHuNN70yVBpl89IVSRT3pJr+ZS3ot/YShBLTXh7rpSQFJHMM5DRHqzVEYvCD1PDJejvogwfuR7ahcNuvp27jDtTJVsEckp8F+/ns4FkHigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I+CjA3yY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+CjA3yY"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso20510945e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 03:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786097158; x=1786701958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mFR8Iq7ncoeZFQXhT5aZNy4pslkhJ7M0UmwQblvHi8k=;
        b=I+CjA3yYbPhvW5fkbKXqPMVZULWJahfZdeaysCsyK0IG4tQR0bkR8W297y/y0U/p4D
         kUwsND0gl/Sk7jbfl5fhKJTxNx3JxJ3giv1R6ia68sV+v6O5q2sGbr3u6kdi2oAHl3qi
         Qi4bYzGEO91Q6ymTBj+Lp2gRC7BvjKb/bbJMrLysdhejjDnNUffvNGqCke/o+7PSrD8m
         pkGYjnpyY/rHwU8ecSPAKHEwhcNIRGBZE5BcMFrS8ugVWc06jLAgcMQ7FUEQxpP/nOxL
         +m8tQ8X4KiZLhAX2JvIhWmlF5uRhVuAOG52X/49Ro7hB946FEEQQDU2XylRKpmDb4yr8
         eX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097158; x=1786701958;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mFR8Iq7ncoeZFQXhT5aZNy4pslkhJ7M0UmwQblvHi8k=;
        b=Hw3WULHmdr3k07pvEvC1fMoOcLeCEDZKrmFFZsGZf06Q5bNKaycje7gKR1pgc4mFcJ
         itDc0xGzHu2kB3DwCV0gcb5xGoM7420qShciduoeOcqw4s1/KcWmWZXk7g5MlvYktodA
         3k5G6y/Owm3oS5OjlFL+DsiP5f2UQpJloV2E0VXxXpc5WO/u5ZYLPlqVpIezustyImdy
         HYiASnqzdnnlGL5xJbsBveLI+4q8fDj3lovI4b2RVtchZCCZlWBXtbuqkOlHV3IdqixW
         y2Tb0OOuCScBlNXGb/jeXg1C6KZvzxdJmNRgATh8WNsmmOj0hUhuuVzltXr7lBnLqexI
         h6KQ==
X-Gm-Message-State: AOJu0YyRcPq7gV7/6v5bX5dy3aia3ge36r4UcxDdFplkYrNG+YaxzdD7
	mV+uNhk5E3hMQQ42sKnEWCsHCAdMXeEiFglgQ/26bjwikebzS7QNuGbFeUCJHaMu0nM=
X-Gm-Gg: AR+sD109MzDs3JzKw+cSb85f+ay/nSQwwsu3pzS/umuWP22aNqEE5axHK4wEnlJL2bD
	WSQo4fTO8OERF0KVqkaGv/dotCKQjvM5mk3xMI8539WAQ2iN+EAT3YHvwfH76Qn9lV9FwYtBITT
	YWvqKjZMEQUu4xTqmpxiWIklaCV0M+uA84DsEQpD8MDZPePWNgyCeJYgjd18AoVUjgZ8H+qPJgd
	XPAvd3eRUksZnXCC0GfjR9+RV0uVYiIkFXyB9gX39AjnRtCTDksB+tFuNk0iSZHbqq3utpm8hYf
	6FES3rpnCO9kOQgWe6aM0ozvOsQ0swFqIMumo9L7NJ44Hhzt9x1le5IAK7+XUQywMjWG93uHO6A
	8JScDbMbc3n+UenZHooVF1z/0LdQ75Kl9bReWcsLVQ/L+l6eFMp1udMJgMcHL54plXvxgbGNvG6
	+kfDgqnWZzxKXqRgvmcrKaFpMadcWbFSDR8Jpfv3s3l8JMC6WQYQaDMBlpDdAtoCQX8A==
X-Received: by 2002:a05:600c:c046:b0:499:491e:4b0d with SMTP id 5b1f17b1804b1-4994e7d1ccdmr238405765e9.19.1786097158525;
        Fri, 07 Aug 2026 03:05:58 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f8f33sm4885059f8f.27.2026.08.07.03.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 03:05:58 -0700 (PDT)
Message-ID: <c925f9ef-b9e7-41cd-8809-d330283fed3a@linaro.org>
Date: Fri, 7 Aug 2026 11:05:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_pmuv3: Zero initialize hw_id branch stack field
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260807-james-brbe-init-hw-idx-v1-1-009d1843960a@linaro.org>
 <20260807092755.CDF991F000E9@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260807092755.CDF991F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/08/2026 10:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing initialization of `new_type` and `priv` fields in `perf_clear_branch_entry_bitfields()` allows cross-sample metadata leakage and KASLR bypass.
> --
> 
> --- Patch [1]: [PATCH] perf: arm_pmuv3: Zero initialize hw_id branch stack field ---
> commit 9362aa7ec453c50e757449959540fd185a720850
> Author: James Clark <james.clark@linaro.org>
> 
> perf: arm_pmuv3: Zero initialize hw_id branch stack field
> 
> This patch modifies the allocation of the BRBE branch_stack to use kzalloc
> instead of kmalloc. This ensures that the hw_id field, and any future fields,
> are safely zero-initialized upon allocation to comply with documentation.
> 
>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -1361,7 +1361,7 @@ static int branch_records_alloc(struct arm_pmu *armpmu)
>>   		struct pmu_hw_events *events_cpu;
>>   
>>   		events_cpu = per_cpu_ptr(armpmu->hw_events, cpu);
>> -		events_cpu->branch_stack = kmalloc(size, GFP_KERNEL);
>> +		events_cpu->branch_stack = kzalloc(size, GFP_KERNEL);
> 
> [Severity: High]
> This is a pre-existing issue, but since we are fixing uninitialized branch
> stack fields on allocation, does the per-sample reuse of these entries later
> leak previous metadata?
> 
> The perf_clear_branch_entry_bitfields() helper zeroes most bitfields, but
> misses the new_type and priv fields:
> 
> include/linux/perf_event.h:perf_clear_branch_entry_bitfields() {
>      br->mispred = 0;
>      br->predicted = 0;
>      ...
>      br->reserved = 0;
>      // new_type and priv are not cleared
> }
> 
> In the ARM BRBE driver, the per-CPU branch_stack buffer entries are reused
> and cleared using this helper. If a hardware branch record is source-only,
> entry->priv is not explicitly set:
> 
> drivers/perf/arm_brbe.c:perf_entry_from_brbe_regset() {
>      perf_clear_branch_entry_bitfields(entry);
>      ...
>      if (!brbe_record_is_source_only(brbinf))
>          entry->priv = brbinf_get_perf_priv(brbinf);
> }
> 
> If the previous sample in that slot was a user-space branch, entry->priv
> retains PERF_BR_PRIV_USER. When filter_branch_privilege() later checks
> entry->priv, could this allow kernel source addresses to be exposed to
> unprivileged users and bypass KASLR?
> 
>>   		if (!events_cpu->branch_stack)
>>   			return -ENOMEM;
>>   	}
> 

Fixed by "[PATCH v6 3/3] perf/core: Clear the whole branch entry in 
perf_clear_branch_entry()" on the list.

