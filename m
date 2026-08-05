Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D048481A9E
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946964; cv=none; b=aaeJnlvsJiEMBZcFhn14QfOkY0QG8VKjkhGJ4r0IhRcyNkB1jyLN3v++N7aW0/o1ll45yuZPpRZwGSuIB4arzINRSvMj+WeIlTfz6kz3RbSmhYbFsCe/BGkLurL8yHONLLOW1c3ZfDG9v4aM/kg7afTryqcGah682JEQ3uBCAfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946964; c=relaxed/simple;
	bh=8Ige4WHC7piJGwboPsF49M+zi/fuLLqMwqZuMEtEzBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSw5c837sq9DiIShqcZnM+bAn1VJ5hGouyaaRkO6Q0niNjk27AVOfycip9nqLtGFjHSj/HRPBXCi/RWfQlsQCrYCYZ3wvoqwP1SpenD996hY/9J5xjEbnn4gXKqP9AOsNqx1giLcxBoSYDnolQLrbmqq+FbN8JN7/onAURT6bJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zsgCV6ln; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsgCV6ln"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so12644925e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785946960; x=1786551760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OycghlLmRiKTDv3n0cc0hGkzggQdc2xkQpJfY9zernY=;
        b=zsgCV6lnm2X9BNGUSFt0E36NPxtIAdNXS9p1sj9na+u5lxozZ+YT4/8OZrnI4NDrXx
         ePNp7tjSfkHUHicOqJeNSAMWVs/bxA21+3ECvpk2XNBCpbyezP3YWJimts4gcRBZaonv
         LX0PArZZ1qoqqnJWcIG6cuAC+6t62jNelF0QbfBg8xKSDWt3H2DR6qCJas2MzpO1VMQU
         I495svsRDrv06fIBjuUYuYgT0YH9VdgN4zs3fdfXaMsxtXsCgezw6UdBIlwhlEWuR1pE
         7fH3HiQ7yMZzkhGM32x+hBun/SoZbj3xLwUHitUUkI8zj2lNfAarA7VVM8i2TJnxCFL2
         3ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946960; x=1786551760;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OycghlLmRiKTDv3n0cc0hGkzggQdc2xkQpJfY9zernY=;
        b=ERLwMU0YZR+yMjAldfvkqzMUCphb2ZbShTCl+dGmwU1FFP/abjSEGgvlHf5GiPoqr3
         oSSkd2+NYxor1aEDh6bCux/sKR3Ej1uwbGCrxP5+NrJHZCuVjsF6GBCWsnwk5lQgeLnn
         OQWdr8zzXUA/Ed/7IzUsmOuMS/72V9VQwMJbLCTAoWQNmn2o7VwN7A187lr8XZSGir03
         aI8+DiPlNPEDUmyIanXhm+fG+L9P5foHod0jBCa4puz5QYORlsROU9jpKacIxJ6OV4NR
         5ZcGy/4Ckys83IZ5WGhPTH4cvg2V74ezo92hAWjMDIvI8wfctU25JxISRtHFwh75JePE
         /kAA==
X-Gm-Message-State: AOJu0YxjrXKEb/+53zUJCY0VTouWH1HMZUMpSo4MamH50OkVCKnqqPpG
	mX/ocQTTcP4y2WkcCnX1QfQk8nAf93rL0WCwfl1KB04Vt4O9zLBKXg2+u9ipOEOUxi/akYJkpai
	JUcJuUqXQ7w==
X-Gm-Gg: AR+sD11lni7xQebOqUYzmxrFM3d9DaiZMawXZKQNcBozWt8Hs6jgqkuSGU97bm7km4d
	PTvdfLzhg+3lCnmh/imxb3EVscAx3nsnp+Rt+ymby044dLPm7YomVtSQnbOxyEvb4EuP97uBqFW
	E24CF7qszfsRm9+2NlERwut06K6R8O6bjvp90I9fqdmZqRH2TQWM1+8dsg1hObEwSg9s+UlpNpm
	/zOULbZc98VMfOe+q4b/RimkoQhj/DQpqucZlFtGrRDIH40u04rFkza7AwNoQzE3dN1AnhN6f1p
	AYYfpSH73MM6KANIC/z/7IQy/I4xt9Z2bLDlm8x26+xd/S8CCISdRaSX1Vvq2/mnPTwRJm8Z98y
	jkRhCgEwclsr0rnYc8453+EtCTxsNKURLMAYyw8ZkchHkNYRF6fAjwigok9TbjgTQOXLHsZMJ7I
	tSGjXGPvgrJ19hQhACn/b2llEGer+1FOa6lHmdTAooOKH1g3UKxepPt04CkSM0wGNriw==
X-Received: by 2002:a05:600c:198f:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-4994e7cc5a4mr101401865e9.15.1785946959866;
        Wed, 05 Aug 2026 09:22:39 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fd4bbcsm193952535e9.7.2026.08.05.09.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 09:22:39 -0700 (PDT)
Message-ID: <240515b0-a711-46d0-b09e-65103b2e0118@linaro.org>
Date: Wed, 5 Aug 2026 17:22:38 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf: arm_spe: Add support for a 'software' discard
 mode
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Al Grant <Al.Grant@arm.com>
References: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
 <20260805-james-spe-software-discard-v1-3-0ff0e44c4c92@linaro.org>
 <20260805155810.7E2A11F000E9@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260805155810.7E2A11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/08/2026 16:58, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Writes to control-plane system registers (`SYS_PMBPTR_EL1` and `SYS_PMBLIMITR_EL1`) lack an immediate `isb()` synchronization barrier, violating ARM64 architectural invariants.
> - [Medium] User-triggerable allocations for the software discard buffer lack `__GFP_ACCOUNT`, allowing a user to bypass memory cgroup limits.
> --
> 
> --- Patch [3]: [PATCH 3/3] perf: arm_spe: Add support for a 'software' discard mode ---
> commit af3311701234ae1a3b87d9c00cb9f6f3748862b7
> Author: James Clark <james.clark@linaro.org>
> 
> perf: arm_spe: Add support for a 'software' discard mode
> 
> This patch implements a software discard mode for ARM SPE. It falls back
> to writing to a single driver-allocated page and not emitting aux records
> when hardware discard support is unavailable.
> 
>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
> 
> [ ... ]
> 
>> +static int arm_spe_pmu_alloc_discard_buf(struct perf_event *event)
>> +{
>> +	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
>> +	int nr_pages = ARM_SPE_DISCARD_BUF_SIZE / PAGE_SIZE;
>> +	struct arm_spe_pmu_sw_discard_buf *buf;
>> +	struct page **pglist;
>> +	int i;
>> +
>> +	if (event->parent) {
> 
> [ ... ]
> 
>> +		return 0;
>> +	}
>> +
>> +	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, node);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	buf->page = alloc_pages_node(node, GFP_KERNEL, 0);
>> +	if (!buf->page)
>> +		goto out_free_buf;
>> +
>> +	pglist = kvmalloc_array(nr_pages, sizeof(*pglist), GFP_KERNEL);
> 
> [Severity: Medium]
> Should these GFP_KERNEL allocations include __GFP_ACCOUNT?
> 
> Since this memory is allocated on behalf of a user process creating an
> SPE event, omitting __GFP_ACCOUNT could allow a container to allocate
> kernel memory without being charged, potentially bypassing memory limits.
> 

I can't find any examples of __GFP_ACCOUNT being used in a similar way. 
Even the existing arm_spe_pmu_setup_aux() doesn't use it. So I'm not 
sure what the precedent is.

>> +	if (!pglist)
>> +		goto out_free_page;
> 
> [ ... ]
> 
>> @@ -617,10 +698,26 @@ static u64 arm_spe_pmu_next_off(struct perf_output_handle *handle)
>> -static void arm_spe_pmu_begin_discard(struct perf_output_handle *handle,
>> -				      struct perf_event *event)
>> +static void arm_spe_pmu_begin_discard(struct perf_output_handle *handle,
>> +				      struct perf_event *event)
>>   {
>> -	u64 limit;
>> +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
>> +	struct arm_spe_pmu_sw_discard_buf *discard_buf = event->pmu_private;
>> +	u64 base, limit;
>> +
>> +	if (spe_pmu->features & SPE_PMU_FEAT_HW_DISCARD) {
>> +		limit = FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
>> +		limit |= PMBLIMITR_EL1_E;
>> +	} else {
>> +		base = (u64) discard_buf->base;
>> +		limit = base + ARM_SPE_DISCARD_BUF_SIZE;
>> +		limit |= PMBLIMITR_EL1_E;
>> +		write_sysreg_s(base, SYS_PMBPTR_EL1);
>> +
>> +		/*
>> +		 * Track the event so we can access the discard buffer through
>> +		 * event->pmu_private. perf_aux_output_begin() normally handles
>> +		 * this, but we can do it manually if that's not being used.
>> +		 */
>> +		handle->event = event;
> 
> [Severity: High]
> Does this write to SYS_PMBPTR_EL1 require an immediate isb() synchronization
> barrier?
> 
> Without it, the subsequent memory store (handle->event = event) might execute
> while the CPU pipeline is operating under an architecturally undefined state.
> 
>> +	}
>>   
>> -	limit = FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
>> -	limit |= PMBLIMITR_EL1_E;
>> +	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
>> +}
> 
> [Severity: High]
> Is an isb() barrier also missing after this write to SYS_PMBLIMITR_EL1?
> 
> Because it is at the very end of arm_spe_pmu_begin_discard(), the function
> return and any subsequent conditional branches in the caller will execute
> before the pipeline state is synchronized.
> 

The register write orderings are identical to the old 
arm_spe_perf_aux_output_begin(). So this would be an existing issue if 
it even was an issue.

