Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF5719D880
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Jul 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751888402; cv=none; b=VOYOHTDHRveP71hZnznzKLXFYvdtjl/TpWrbBfPlDhK3EES1h0XiTE2TGDSsmqIvvqTnncNcrtYhD8Yf15Gi0xnHc1Wdiv96uqqBqq5MQmg+sC3WvswFiw04lPdncNkz7KL3APoGSV5m4U1h5e8+4EkDVeOIjpbw5qGLfyt+kH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751888402; c=relaxed/simple;
	bh=feYWE7Jisq/VyH466HOj3sDaALjgny/+B4AiiKp/mZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eulVk6yqX2hhecgF5K+2cmrRPsBjzcIgLCx5sf50X7WFMagPTJDy0DtIvOrntyE3o0GawYMaO6t6X62VYvKwfC98hC7tfmg8OuXruafz2fKT+3DEJxCEeP/FrZ46aWJ1d2DxXzH5HJ+BmBXAcMZpPMu1AWmum2ryjcpvGSwYEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AjecRlxk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjecRlxk"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so1849337f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Jul 2025 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751888398; x=1752493198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tuqC9beYeXQDyom1+KuHCuf6wqm7fyMn+vwlhFtjQHU=;
        b=AjecRlxkVFPddaGVkUR5QwlPlNFevwdFLUGwADxxTh8wT2Kw95fMyIK8YO4/PFRzrz
         bTn5YNbjLw+rZLs79KQZF8JBt3kgdoeP2SYUdKkL1OnAgkiuhPOzfjNusI0ZnCJAwjfw
         XuEjjyATnkveBmHKeT2CJ1/Jf/PIrTJaIzBqZwmtqgVrsGgFI2D9m7ZRVlDyM1rFNp6N
         QZlY+EN8kpRZlOjjnBDC14VecK3rhONvMmHamLopca87B8QQKG+yXMODEQ9RIkx9nPcq
         aO4+HQ/EsoSN/8kL8BFM7CllmoOTBQJO+JJYaaLDeOEaqYYbrp5V5qTbmFCJr04z+anM
         2r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751888398; x=1752493198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuqC9beYeXQDyom1+KuHCuf6wqm7fyMn+vwlhFtjQHU=;
        b=aDIIglXFW/cmzypnCx49I3Ls/Tb76lNWYd3nHour0Sk4uEj4i/2JQ5XIzC98RUKYb0
         PK9uV6W4H6keDDp1YNomqqzI780/YvW1aU2k9g+Qxtki90hOxlmZBPVI1GCN79NJ1Pj6
         GANbD+pe1Q0r1Cx34CWGmKWtfn5Z2+gRjZELYNWU5aWAGoApVywQ0ZJ2x5/B/1EncLoy
         jlVRUtfBBOgnOE4nb+8lAW21KZzpsok86pmXNJ5U7uhkFKVb79we1Y20rUQLS6d03iGR
         7fbRCCajveH9YPMvmhuIq58KsvKNAzV8sW2JgFf7k3wA2U6FJcZkQViR4Ybon2vNntZw
         MSBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYTdduCU0OyJ1mq9BlslliUuKte0TNXJcUxJNXpwYtkwnuR4H6hWFGJzdQP+Ln21jVvf8qkAva+be2XyxjecB1@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+h0G98wcsi9nZhv89X7PfaLqwWeB1afUH01WOoaLo+NUkBb8
	+Aj8g5wDVbIkZW8BToPrpj2LCm5UJVWm4ydxbXpnl0EkrvpLZIHay4ia3D+9ySsgPis=
X-Gm-Gg: ASbGncso1PIyUQXyGqj9oN63zXEndnyig1fli/kHRgvQrMq0RhHzM7XeX2+usCoobmV
	x6VInkrz5jAs8lUrLMKlJERl9tM64sf6OEede0XBwiNHnT9mM4tStkCq5Ogcrx2peO6fd/30cEZ
	xkDfet6P/Ko/KcJIcSLCs+zPu0R9xFa1KdOeBiiGdQ2lIvvGE/FJEXgN2fC3eT+SGSy/JY7xW8U
	Rtv3M5LezLvU/sPF3X2JGwo3Dty4YZclZyYnT4AgQiz2j4e9dhOBXCIlrYU6vFTxeYaPg6y3ctC
	dpJZxxSuKG4Rl4k+X1PNQSS1TuWUwBRHGUiKd3qxlL5WY3UxeJTswoQEtlHxZ+UcnAE=
X-Google-Smtp-Source: AGHT+IGDItNt/gQIylGSzRr2n2QM8HyI4XMr7tCVaXbrsZo7Z/t7OtW5bunomLUqBKEeZpRqJk5pSA==
X-Received: by 2002:a05:6000:208a:b0:3a5:2698:f65d with SMTP id ffacd0b85a97d-3b4964dedf7mr8422836f8f.27.1751888398358;
        Mon, 07 Jul 2025 04:39:58 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b16865c2sm108604675e9.19.2025.07.07.04.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 04:39:57 -0700 (PDT)
Message-ID: <b77f12e7-ea3f-4c57-9706-ff8e32721cc8@linaro.org>
Date: Mon, 7 Jul 2025 12:39:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf: arm_spe: Disable buffer before writing to
 PMBPTR_EL1 or PMBSR_EL1
To: Leo Yan <leo.yan@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Alexandru Elisei <Alexandru.Elisei@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>
 <20250704155016.GI1039028@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250704155016.GI1039028@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/07/2025 4:50 pm, Leo Yan wrote:
> On Tue, Jul 01, 2025 at 04:31:58PM +0100, James Clark wrote:
> 
> [...]
> 
>> @@ -661,16 +666,24 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>>   	 */
>>   	irq_work_run();
>>   
>> +	/*
>> +	 * arm_spe_pmu_buf_get_fault_act() already drained, and PMBSR_EL1.S == 1
>> +	 * means that StatisticalProfilingEnabled() == false. So now we can
>> +	 * safely disable the buffer.
>> +	 */
>> +	write_sysreg_s(0, SYS_PMBLIMITR_EL1);
>> +	isb();
>> +
>> +	/* Status can be cleared now that PMBLIMITR_EL1.E == 0 */
>> +	write_sysreg_s(0, SYS_PMBSR_EL1);
>> +
> 
> An important thing is about sequence:
> As described in arm_spe_pmu_disable_and_drain_local(), should we always
> clear ELs bits in PMSCR_EL1 before clear PMBLIMITR_EL1.E bit? As a
> reference, we could see TRBE always clear ELx bits before disable trace
> buffer.
> 
> And a trivial flaw:
> 
> If the TRUNCATED flag has been set, the irq_work_run() above runs the
> IRQ work to invoke the arm_spe_pmu_stop() to disable trace buffer, which
> clear SYS_PMBLIMITR_EL1.E bit. This is why the current code does not
> explictly clear SYS_PMBLIMITR_EL1.E bit.
> 
> With this patch, the interrupt handler will clear SYS_PMBLIMITR_EL1.E
> bit twice for a trunacated case.
> 
> 

I suppose that's a rarer case that we don't necessarily have to optimize 
for. I don't think it will do any harm, but is it even possible to avoid?

There are already some other duplications in the driver, for example in 
arm_spe_pmu_stop() we call arm_spe_pmu_disable_and_drain_local() which 
drains, and then arm_spe_pmu_buf_get_fault_act() which also drains again.

>>   	switch (act) {
>>   	case SPE_PMU_BUF_FAULT_ACT_FATAL:
>>   		/*
>> -		 * If a fatal exception occurred then leaving the profiling
>> -		 * buffer enabled is a recipe waiting to happen. Since
>> -		 * fatal faults don't always imply truncation, make sure
>> -		 * that the profiling buffer is disabled explicitly before
>> -		 * clearing the syndrome register.
>> +		 * To complete the full disable sequence, also disable profiling
>> +		 * at EL0 and EL1, we don't want to continue at all anymore.
>>   		 */
>> -		arm_spe_pmu_disable_and_drain_local();
>> +		write_sysreg_s(0, SYS_PMSCR_EL1);
>>   		break;
>>   	case SPE_PMU_BUF_FAULT_ACT_OK:
>>   		/*
>> @@ -679,18 +692,14 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>>   		 * PMBPTR might be misaligned, but we'll burn that bridge
>>   		 * when we get to it.
>>   		 */
>> -		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
>> +		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED))
>>   			arm_spe_perf_aux_output_begin(handle, event);
>> -			isb();
> 
> I am a bit suspecious we can remove this isb().
> 
> As a reference to the software usage PKLXF in Arm ARM (DDI 0487 L.a),
> after enable TRBE trace unit, an ISB is mandatory. Maybe check a bit
> for this?
> 
> Thanks,
> Leo
> 

Wasn't this isb() to separate the programming of the registers with the 
status register clear at the end of this function to enable profiling?

But now we enable profiling with the write to PMBLIMITR_EL1 in 
arm_spe_perf_aux_output_begin() and the last thing here is the ERET. 
That's specifically mentioned as enough synchronization in PKLXF:

   In the common case, this is an ERET instruction that returns to a
   different Exception level where tracing is allowed.

>> -		}
>>   		break;
>>   	case SPE_PMU_BUF_FAULT_ACT_SPURIOUS:
>>   		/* We've seen you before, but GCC has the memory of a sieve. */
>>   		break;
>>   	}
>>   
>> -	/* The buffer pointers are now sane, so resume profiling. */
>> -	write_sysreg_s(0, SYS_PMBSR_EL1);
>>   	return IRQ_HANDLED;
>>   }
>>   
>>
>> -- 
>> 2.34.1
>>
>>

