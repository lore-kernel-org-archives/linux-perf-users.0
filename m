Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08388BEE
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104020; cv=none; b=mDzE1gIzpFZ84gOs1WvmI9y/6N0Bwfw4m21RswULVJ5/5qr2SuLdm4w1z+opM/BqeIerY32PfTcQtvv9QZMAihGk+WE+e29zKb93ViS8NtrcJcTJMtSGXG+3af0O5PpoDvjkuI82AaJ4R5awCTIbn391mUHaFvExaDsCXEgR/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104020; c=relaxed/simple;
	bh=vFYsACjf+wWImBMqFRsLGjZ2g5T9qvVJqCKa1lGxxgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0ehmI4FK/CmSjBbbQ7B1eXWWD/5hNdhvo2jmxYqVC5QvfODvBMGTSFWHU7rz0UIxl88BctSQ9bnWwgycdTJ8s6FNz1Du9nhqSagFvrhSWa2nK8ECONYUrhHdpJ5oO2HcPcelBUEnY3vIeDSTRSFyDloOxXd9hseEBhmWeK1ZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vFGGbJfr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vFGGbJfr"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso33562955e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753104017; x=1753708817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrn9rE6UkF/v98BJ3Qu5cq8UrY7vJ2riZbgUi0l0lcs=;
        b=vFGGbJfr1jf4m2Un99pCCWR2wFDwIJbrMohaPirrvrr1Evc+kstuO6fhRd+mDI5P8G
         x9BM5namDDZeDUnlY+yMiPJpFwqyM9bX1mfnZ4h/8OVG/ueeaGByHQZZEiiyo2nYXJNQ
         LCwgSn/LLBu3vcSkGRwmxTYKu+/nYL5XMYUImq4m378UODgnAPY6tfSGAlzpZBYP/hCv
         ++OPnQY+BHWuhwvZiBsfRobVJ1sqmqjyzC0gP0Ttc5iTtPmLN57nuNtT3bewMXAKdqdQ
         GhcDPhm8eovcSoRYu7101W2/Fcyxyg32kjAvsqm7QRGAJItNqZXjSgaRdUdsgypVeuxF
         8aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753104017; x=1753708817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrn9rE6UkF/v98BJ3Qu5cq8UrY7vJ2riZbgUi0l0lcs=;
        b=aLATo4O0MvuCkFxh3EFGeUSK3zTwd2ED0RPnmlm2pRDUPnenKG7jTorvGGUW0vB4/Q
         jn9Opz2kNHv1J66fHQZZYfaIRgKly+Ya3D7MY0GGuBMeM6TYrvVNZsbZZUp65PsfKyWu
         8EBfpjgJmj65e5bPNNsA+CR6DD5DaPNqji2qSZHVONZk4+KoSoFzq5FZHxwzsAy9+nHP
         01I5FmlMsCKs2DqvFvYe+Gp9LuAyE+3UbWOXRNb7v6dney18uusz24VNjZkbFgBcS0Jl
         aAaET16cUeoUIQgj3MB6Mkl+Uyf8Un4/Z4vjXRHD9k3/aYuwK2haDJcqMk8ildCjXmkc
         EuEw==
X-Forwarded-Encrypted: i=1; AJvYcCWZQDRtaWnqt+FMMaJSt8r2hztt9KBvbC6m3adR5a7Ztabfn97W+aNMeymIRLi8LjEVVq49ijcbDkF5Y5yEPekY@vger.kernel.org
X-Gm-Message-State: AOJu0YyiRvs/guOxr11Hlu/tiNUu8XpwO6EKwEyomZajaVdNCg4nJABV
	nuHSqmOf/S844Iu/a1ZLiAU1SdKtXIf7Eg4SUqrplwQFj/ztSJ+723fHWVgkl0fazQg=
X-Gm-Gg: ASbGncsb2H/nky5Q/FMZ5r2L31IkJukd0qf8b26nCGiKsvXhLW1+Mz0u4x/cUrqlUBx
	UoXuENNm4YmawqTeki61F8AWRFyvAS0KyNXF40ZgCXzEYSMMqC68JwU626WrFZBp6A4rkkd/22l
	dWEls1U1gdXnFGToM0hk58bmsfvMkLqE5XXkGZCCB62KvyePKCVWen6SdGootPUAnAJU19dydMm
	7btREjb1xkdtgWSgsubLq5rDRiOWtQJZL2AzkTpz7b9k6tbtVznrOaVQNwBYOYcMFGTHc3tEsLK
	+ZNgv7kdBFhT8+Ca9xvb0oLqnrVwJ4XNiDCA0nuV4G/X8AEf3ljFNmgW87FxnsIUfMcxN6Bj8AZ
	Uj3aeivKWwzVTpfdpYIK8rGnoO8c3lrw38tl1pw==
X-Google-Smtp-Source: AGHT+IH+iH70+HX8sNgyQja7zJIW/pG4ctsn+z4ohiQa3kbUyjxssWONPs/1WpQT4zINE1WNbLE7Uw==
X-Received: by 2002:a05:6000:992:b0:3a4:f663:acb9 with SMTP id ffacd0b85a97d-3b61b0ec0dbmr9587918f8f.9.1753104016864;
        Mon, 21 Jul 2025 06:20:16 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b75baa7072sm3489845f8f.2.2025.07.21.06.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 06:20:16 -0700 (PDT)
Message-ID: <0c53164a-306a-4cb7-9085-bba8985c32e7@linaro.org>
Date: Mon, 21 Jul 2025 14:20:15 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf: arm_spe: Disable buffer before writing to
 PMBPTR_EL1 or PMBSR_EL1
To: Leo Yan <leo.yan@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>
 <20250704155016.GI1039028@e132581.arm.com>
 <b77f12e7-ea3f-4c57-9706-ff8e32721cc8@linaro.org>
 <20250707153710.GB2182465@e132581.arm.com> <aG4_uYJgpMXo3QHQ@raptor>
 <20250714085849.GC1093654@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250714085849.GC1093654@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/07/2025 9:58 am, Leo Yan wrote:
> Hi Alexandru,
> 
> On Wed, Jul 09, 2025 at 11:08:57AM +0100, Alexandru Elisei wrote:
> 
> [...]
> 
>>>>>>    	case SPE_PMU_BUF_FAULT_ACT_OK:
>>>>>>    		/*
>>>>>> @@ -679,18 +692,14 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>>>>>>    		 * PMBPTR might be misaligned, but we'll burn that bridge
>>>>>>    		 * when we get to it.
>>>>>>    		 */
>>>>>> -		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
>>>>>> +		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED))
>>>>>>    			arm_spe_perf_aux_output_begin(handle, event);
>>>>>> -			isb();
>>>>>
>>>>> I am a bit suspecious we can remove this isb().
>>>>>
>>>>> As a reference to the software usage PKLXF in Arm ARM (DDI 0487 L.a),
>>>>> after enable TRBE trace unit, an ISB is mandatory. Maybe check a bit
>>>>> for this?
>>>>
>>>> Wasn't this isb() to separate the programming of the registers with the
>>>> status register clear at the end of this function to enable profiling?
>>>
>>> Enabling profiling buffer followed an isb() is not only for separating
>>> other register programming.
>>>
>>> As described in section D17.9, Synchronization and Statistical Profiling
>>> in Arm ARM:
>>>
>>>    "A Context Synchronization event guarantees that a direct write to a
>>>    System register made by the PE in program order before the Context
>>>    synchronization event are observable by indirect reads and indirect
>>>    writes of the same System register made by a profiling operation
>>>    relating to a sampled operation in program order after the Context
>>>    synchronization event."
>>>
>>> My understanding is: after the ARM SPE profiling is enabled, the
>>> followed ISB is a Synchronization to make sure the system register
>>> values are observed by SPE. And we cannot rely on ERET, especially if
>>> we are tracing the kernel mode.
>>
>> Thought about this some more.
>>
>> Before:
>>
>> arm_spe_pmu_buf_get_fault_act:
>>    <drain buffer>
>>    ISB
>> arm_spe_perf_aux_output_begin:
>>    PMBLIMITR_EL1.E = 1
>> ISB
>> PMBSR_EL1.S = 0
>> ERET
>>
>> Now:
>>
>> PMBLIMITR_EL1 = 0
>> ISB
>>
>> PMBSR_EL1.S = 0
>> arm_spe_perf_aux_output_begin:
>>    ISB
>>    PMBLIMITR_EL1.E = 1
>> ERET
>>
>> I don't see much of a difference between the two sequences - the point after
>> which we can be sure that profiling is enabled remains the ERET from the
>> exception return.  The only difference is that, before this change, the ERET
>> synchronized clearing the PMBSR_EL1.S bit, now it synchronizes setting the
>> PMBLIMITR_EL1.E bit.
>>
>> Thoughts?
> 
> To make the discussion easier, I'll focus on the trace enabling flow
> in this reply.
> 
> My understanding of a sane flow would be:
> 
>    arm_spe_pmu_irq_handler() {
>      arm_spe_perf_aux_output_begin() {
>            SYS_PMBPTR_EL1 = base;
> 
>            ISB // Synchronization between SPE register setting and
>                // enabling profiling buffer.
>            PMBLIMITR_EL1.E = 1;
>      }
>      ISB // Context synchronization event to ensure visibility to SPE
>    }
> 
>    ... start trace ... (Bottom half, e.g., softirq, etc)
> 
>    ERET
> 
> In the current code, arm_spe_perf_aux_output_begin() is followed by an
> ISB, which serves as a context synchronization event to ensure
> visibility to the SPE. After that, it ensures that the trace unit will
> function correctly.
> 

But I think Alex's point is that in the existing code the thing that 
finally enables trace (PMBSR_EL1.S = 0) isn't followed by an isb(), only 
an ERET. So the new flow isn't any different in that regard.

> I understand that the Software Usage PKLXF recommends using an ERET as
> the synchronization point. However, between enabling the profiling
> buffer and the ERET, the kernel might execute other operations (e.g.,
> softirqs, tasklets, etc.).

Isn't preemption disabled? Surely that's not possible. Even if something 
did run it wouldn't be anything that touches the SPE registers, and 
we're sure there's an isb() between setting up the buffer and the final 
PMBLIMITR_EL1.E = 1

> 
> Therefore, it seems to me that using ERET as the synchronization point
> may be too late. This is why I think we should keep an ISB after
> arm_spe_perf_aux_output_begin().
> 
> Thanks,
> Leo

Wouldn't that make the ERET too late even in the current code then? But 
I think we're agreeing there's no issue there?

James

