Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065952264B6
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Sep 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339676; cv=none; b=cZ1mJnkhKgsyVwecyDaq1KtKblbtRSsyKuCfS3gIlFyut4qMD3mZxJD6rAgIX3TZ4s0PgCvVQxCSSEchTWn8uXB1kQmknyKiQhI5GcCXVGCvk5KR4AF0M8wjpbExXU0oQ/H7oL92RedoyJknu4fh9A+Utpd51G6NQTK4kh3RCac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339676; c=relaxed/simple;
	bh=dJu5haeXP/GbMsCGjaEPTCUARkEEutJkdZ6n7JJnInk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnjDqQkxPXkWCYeh+mQKq0R4OTHyNzO05NnIKcfzZtZ9GPDieeON7OPKzEok91qhLpZKtmwz+exrMVW5NLUC4l0/zCRdXhqQWoplTQ2JEfbCLbqisG5yQvW5XTy+wmQWxTMzigz5EfK8ODD+WBApeYuDryoqGGll30K7RC9kPzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XryH/dZC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XryH/dZC"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45de1f2cdeeso8564795e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Sep 2025 06:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757339673; x=1757944473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCHpJvxz6Qb8QBxhEywwqTxUHZsPubTDT4UbMJARa5E=;
        b=XryH/dZCrAly1hwlkUGNZGOzB1js/FPdmgTvwc6IEhWYxXHjY4WoEDEhgOxhwK/6QR
         jz3TjiXMTLAymKFIKdAGPSnShY5Gj1P28H8hfh4bM8OMdQiI6ylQPvVvi1OrBrWSuaMf
         1Lo+NE7rJfD7ohljBuasx+4+L/m9C7JuFVv4MpaN5/DH6sbBuPYUT9mjNv/wd33t7glD
         qZhJZtwgzJaTvKpBpPB8zLFTtUEdxc6PgbfVB1fNR0BAsrMjjFZRX8QyEOYInJrr0RCr
         UH9dw90cXhIPKYKYPvdPCC94DDvTdpk7akFsnOhk2pOBXKruha3+xRKD34DZVSkHqghF
         F0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757339673; x=1757944473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCHpJvxz6Qb8QBxhEywwqTxUHZsPubTDT4UbMJARa5E=;
        b=KS3EfjXus4e/kql6h/mB1W6EW+ZGGSrgOER4N0ue3KN7oQT51sNHrxWjxpDFmG7mSK
         avY559dvhS3gNhlGxUw9c9J8aRv+0yHWo9UTPZJuvuf7FhrKdFJgpdbd+G7aVeTFO1fj
         XqNotT2Qo7FmnSygW/F5WNXOHIYECPwEXT3qIBom4Phu02qzV/mV7XlTstIyCOEh0TfJ
         c2DkdRlbAbntAHq76Go2SveRR8nJW7I9D04/joF1Z51hzkuvxEPNJgbHsv7g5vetnZqb
         Jij4K2Gq9rho17szsGfCeczgzf0DdkG5pLITfpAPtgcmZBsRlyCnXTI2tInH3nL2KoT3
         45Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUf8EIzODBjCWC7WN9We/zb/y+NBXWFn221W+WxZY+F3OVf1wMls0hEqz8jMZ9A3CfgF3pSVq0UxP/NiHl/Cfk/@vger.kernel.org
X-Gm-Message-State: AOJu0YxtIWUquVx+B4yYchS2LM7X/Bx+XVvXvmQA7AZDymK/CaLK7XdF
	QPSuFYIBE6uCkwGiejiEKsvP8JzyYIvZjSAerHD6A6FuKpAIWbrDlCn1NcJ0vTCSyg4=
X-Gm-Gg: ASbGncv0gRxVEp4XWtypnDEp1+sTRNrREbOIfSaPn2WrfizV7xGuMcG9C3fShJLCmU/
	W8jCfoYWHxSek18ZO1yyATl7MudrcHcoaGN7GnYGwxic8Z3Lkf38yWya9hb/RaKxyuTYFrcryI8
	HECRu8XCmxbH0WSQBPpDGfIIYTCsUGmN42CfGOLeSlo0/nw+po+7wZb+i4OHyeN95LwbKBcHyqq
	q4JhqDxLU5Zh5LsgYfcwT8NzmqUKL1Ay2V3Vw5lswGodTV6PwFFqwK5l5S+FQ9OJaTzyOdLoExJ
	pOYUyleOUpeSvDUirztFlCZlwOa6M6q0njpVaeit3KSY8ovQlrHxV5eHqL3fBdrym5nL0dnrivq
	fHjziJwOEUDfrcQpDOCIMMtoRZXA=
X-Google-Smtp-Source: AGHT+IF+ypPVfQCAEOxwFI3Zr/SauvJzp3o2msqjq7oBAEzx5/Zdo6XXLDnm5bhPV93Qax8SeMujHg==
X-Received: by 2002:a05:600c:4f8b:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45dddecd860mr67247425e9.20.1757339673359;
        Mon, 08 Sep 2025 06:54:33 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd296ed51sm189909035e9.3.2025.09.08.06.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:54:33 -0700 (PDT)
Message-ID: <b4bcb7cf-da03-4263-9101-feec6d0e0d8d@linaro.org>
Date: Mon, 8 Sep 2025 14:54:32 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf: arm_spe: Add barrier before enabling profiling
 buffer
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Alexandru Elisei <Alexandru.Elisei@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-1-52a2cd223d00@linaro.org>
 <aL7dFIzEgiEETcIb@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aL7dFIzEgiEETcIb@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/09/2025 2:41 pm, Will Deacon wrote:
> On Tue, Jul 01, 2025 at 04:31:57PM +0100, James Clark wrote:
>> DEN0154 states that PMBPTR_EL1 must not be modified while the profiling
>> buffer is enabled. Ensure that enabling the buffer comes after setting
>> PMBPTR_EL1 by inserting an isb().
>>
>> This only applies to guests for now, but in future versions of the
>> architecture the PE will be allowed to behave in the same way.
>>
>> Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/perf/arm_spe_pmu.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>> index 3efed8839a4e..6235ca7ecd48 100644
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
>> @@ -537,6 +537,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
>>   	limit += (u64)buf->base;
>>   	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
>>   	write_sysreg_s(base, SYS_PMBPTR_EL1);
>> +	isb();
> 
> 
> Hmm.
> 
> arm_spe_perf_aux_output_begin() is only called in two places:
> 
> 1. From arm_spe_pmu_start()
> 2. From arm_spe_pmu_irq_handler()
> 
> For (1), we know that profiling is disabled by PMSCR_EL1.ExSPE.
> For (2), we know that profiling is disabled by PMBSR_EL1.S.
> 
> In both cases, we already have an isb() before enabling profiling again
> so I don't understand what this additional isb() is achieving.
> 
> Will

It's to prevent PMBPTR_EL1 from being written to after the PMBLIMITR_EL1 
write than enables the buffer again. So you're right it's already 
disabled up to this point, which is why we didn't need to add another 
isb(). This change is only for the re-enabling bit.

If the instructions were reordered you could get this ordering at the 
end of arm_spe_perf_aux_output_begin():

   write_sysreg_s(limit, SYS_PMBLIMITR_EL1); // Enables buffer

   write_sysreg_s(base, SYS_PMBPTR_EL1);  // Invalid write to PMBPTR

Instead of the new version with the barrier where PMBPTR must come before:

   write_sysreg_s(base, SYS_PMBPTR_EL1);
   isb()
   write_sysreg_s(limit, SYS_PMBLIMITR_EL1);

Thanks
James

