Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04525259C9A
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Sep 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342157; cv=none; b=JhstRX32ZFf14i9sBroQb2hsCJRmQ0J/aN+gyXb13yODaeI/QHgLSz3fDQ9g8+GNfoX1IWYtAgQ4rj9ul3Ca4C2YzatXfOh2t5F00i0ZxJbm9JbRFEW3MjVMUh5prUEMjonCcEkYiPh1eQYXJAOTKXu9jqgY5Pxk4RgueCPrcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342157; c=relaxed/simple;
	bh=egs7205Snmd/mw+MEXwwC1Y+k8cNoU3nGHetOuR2saw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nY5Q7Qc2aaCgGpXoWSEPap5zVmogO/9sc266n1MCaR+MbeBImX/tlDkNj0eahYx4IhTXgVAFXhW8EHOnyMvJT8oyuxrcvmMj//7p9WMIiMuzEw9phKgspu3RXsc34CXassb1VZCRdCPwxoXSta8Bn1HQOyta++3EQR08A7M6CMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yVK7olK2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yVK7olK2"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3df35a67434so2786067f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Sep 2025 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757342153; x=1757946953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGYytEnMw+6xuEh78CWcB0+W8fGeyKd2M/PYTH6aJS0=;
        b=yVK7olK2IsFAx9QVo8Q5bM4x+Rrf1UMS6vqBWSn54WXOAw0Jl68ASNquSb7Hxjr4Gs
         W1aRFVIDYFOlojloHP+FciNh5Qq5JVahgIaVnHipmcXjw/BpGTKvfkixQsnug2VnwIjk
         foEWMasaMy7SG86cAULGWKnScwFnezmI65w6XX+k6z2XozqmR/JyjywwO25g9LPHViOD
         VZ/YOxcRfIR4VYZrArjTdUs8gegP0OSRExghJA/TZIcMJLreWuanN4eX9r2qxwodd4e3
         3Bh64hsxQed1iEtKDjQsXEVakfvCDMnLyxg7/ZnaQ2x6PBtH55DeDeL0i3bsNx0nZBc9
         pi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757342153; x=1757946953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGYytEnMw+6xuEh78CWcB0+W8fGeyKd2M/PYTH6aJS0=;
        b=UleAQ8kLJXdJ9J7kYewCXtACbTiNlNWL2rJZJEdsspCAAp4VqwE4beeweBJOzJjY3+
         8r0Ece6CrNA3rfQib/a3mrSiaLFl0MB1zKpBR5UlsP/28JtEp2wRPMgcblU/G+rQnaeL
         0Ikz63u1NWD1BXEo516/khIMq30fHkTkI88wK6bDYKZJzGdU7FtH3vq5VqxS+TVXSktW
         c3IiFvdDe5iCxFI4SoX5ozAa6GimaYg5slUP+Y8KiHEAg6zx6ZEpClY4mw6woFdqsLfU
         KxN376BLGahvgIvIUS4BK/W/2pEiANhpTLRCT/RRlU9hGoss9YKYDp0hmCLkXmTJOF1I
         7H6A==
X-Forwarded-Encrypted: i=1; AJvYcCV30PeB7JSUoWRhEeoMZdx+px4x8SxvJHGrBDTKgyT+Q6/i0TmzmIRCYnW3SpZzLDML96bYtCkJPoZ5UB+QNvQZ@vger.kernel.org
X-Gm-Message-State: AOJu0YytUUjTnq9CdOwlZ/V6zpri5BDZ96OZPz32PeYIlPZMi6ztp8hG
	U/TILZtmMzSV2Sx5lIr2CX6UP7PuW/sM+cyStwsl3zVToUlMJ0Vbn51XMh1a86n6J7Q=
X-Gm-Gg: ASbGnctR4NBqZIAC0mGlYoAzlEDcm5wIovRfU2KcjZnpB4GkTFOrDxkZ65OfxH5MiPq
	8sRzyrTMivsXxdwzk4o2R4EYy6dhRtl5frGwWyS7XDUfJxTtqa00VwjRzR5ZA+TMIhP0iOWwiZ9
	TcxNBjNs6Fy31gxuP4Mju8pqjQPv34Fc356uYOt2/sLsccKlTmsRdWMcfRo4PPUtbDFN7k01qyo
	Xv6ZwRGSOsgDDRvIKO02eGx2tZM0hkKeY+xaD3CY+7JzUDlT9efYcDvh9XGquBjFI6jNBSReOEX
	6VOpzqfze553eqT0DpA80WZuP+CrTnQMqvBm8buSzIKvnIe+Udsnw8NCAKz8f88SWusZgBLolGb
	kKylplsyYzR+B5ikV3/KV+CWxKcHjDzIZHDyXzg==
X-Google-Smtp-Source: AGHT+IHqTDAEvQOt+q1sz1oM/FMn4xs+DKIlODRGS8+cELpR8JABY1klHI4WNO8R4+DbWuABkVVF1g==
X-Received: by 2002:a05:6000:2a85:b0:3e6:b06c:5b2e with SMTP id ffacd0b85a97d-3e6b06c622fmr3645332f8f.57.1757342153210;
        Mon, 08 Sep 2025 07:35:53 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0a1f807f9sm40948664f8f.38.2025.09.08.07.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:35:52 -0700 (PDT)
Message-ID: <ff94b709-2861-445d-81c4-9ed98125fe94@linaro.org>
Date: Mon, 8 Sep 2025 15:35:51 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf: arm_spe: Add barrier before enabling profiling
 buffer
To: Will Deacon <will@kernel.org>, Alexandru Elisei <Alexandru.Elisei@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-1-52a2cd223d00@linaro.org>
 <aL7dFIzEgiEETcIb@willie-the-truck>
 <b4bcb7cf-da03-4263-9101-feec6d0e0d8d@linaro.org>
 <aL7gsXbr_-k4q-i5@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aL7gsXbr_-k4q-i5@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/09/2025 2:57 pm, Will Deacon wrote:
> On Mon, Sep 08, 2025 at 02:54:32PM +0100, James Clark wrote:
>>
>>
>> On 08/09/2025 2:41 pm, Will Deacon wrote:
>>> On Tue, Jul 01, 2025 at 04:31:57PM +0100, James Clark wrote:
>>>> DEN0154 states that PMBPTR_EL1 must not be modified while the profiling
>>>> buffer is enabled. Ensure that enabling the buffer comes after setting
>>>> PMBPTR_EL1 by inserting an isb().
>>>>
>>>> This only applies to guests for now, but in future versions of the
>>>> architecture the PE will be allowed to behave in the same way.
>>>>
>>>> Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    drivers/perf/arm_spe_pmu.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>>>> index 3efed8839a4e..6235ca7ecd48 100644
>>>> --- a/drivers/perf/arm_spe_pmu.c
>>>> +++ b/drivers/perf/arm_spe_pmu.c
>>>> @@ -537,6 +537,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
>>>>    	limit += (u64)buf->base;
>>>>    	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
>>>>    	write_sysreg_s(base, SYS_PMBPTR_EL1);
>>>> +	isb();
>>>
>>>
>>> Hmm.
>>>
>>> arm_spe_perf_aux_output_begin() is only called in two places:
>>>
>>> 1. From arm_spe_pmu_start()
>>> 2. From arm_spe_pmu_irq_handler()
>>>
>>> For (1), we know that profiling is disabled by PMSCR_EL1.ExSPE.
>>> For (2), we know that profiling is disabled by PMBSR_EL1.S.
>>>
>>> In both cases, we already have an isb() before enabling profiling again
>>> so I don't understand what this additional isb() is achieving.
>>>
>>
>> It's to prevent PMBPTR_EL1 from being written to after the PMBLIMITR_EL1
>> write than enables the buffer again. So you're right it's already disabled
>> up to this point, which is why we didn't need to add another isb(). This
>> change is only for the re-enabling bit.
>>
>> If the instructions were reordered you could get this ordering at the end of
>> arm_spe_perf_aux_output_begin():
>>
>>    write_sysreg_s(limit, SYS_PMBLIMITR_EL1); // Enables buffer
>>
>>    write_sysreg_s(base, SYS_PMBPTR_EL1);  // Invalid write to PMBPTR
>>
>> Instead of the new version with the barrier where PMBPTR must come before:
>>
>>    write_sysreg_s(base, SYS_PMBPTR_EL1);
>>    isb()
>>    write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
> 
> ... but my point is that profiling is still disabled after writing to
> PMBLIMITR_EL1.
> 
> Will

Oh I see what you mean, I misunderstood that.

You might be right, but I'm looking at statement SFDXJJ and it only says 
"...PMBLIMITR_EL1.E is 0b1, meaning the Profiling Buffer is enabled...", 
so it's just the buffer rather than "profiling is enabled" which would 
require both bits PMBLIMITR_EL1.E = 1 and PMBSR_EL1.S = 0:

   SFDXJJ

   When PMBLIMITR_EL1.E is 0b1, meaning the Profiling Buffer is enabled,
   software must behave as if the PE can do all of the following:

   * Ignore writes to the Profiling Buffer controls, other than a write
     to PMBLIMITR_EL1.E that disables the Profiling Buffer. The
     Statistical Profiling Unit registers affected are:

    - PMBPTR_EL1.
    - PMBLIMITR_EL1.
    - PMBSR_EL1.
    - If FEAT_SPE_nVM is implemented, PMBMAR_EL1.

I'm trying to read Alex's other reply to this patch with it in mind that 
profiling is still disabled, and it feels like your same point might 
apply. Even if it's incorrectly programmed according to the existing Arm 
ARM it doesn't matter if it's disabled.

We did discuss internally about the difference between just the buffer 
being enabled or profiling altogether being enabled. Looks like I need 
to check again.

James

