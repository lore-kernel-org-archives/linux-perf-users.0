Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F550442372
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105151; cv=none; b=hR463DsSVjxRcHPrCx6QZUmQ2RlWn3bhyrJpSpJKu5gYn/u6tknAOvbPGae4BTjd2N3xvr7143oBozQCngEDoymZVEybk/a1I5cfE8/uVUSZQ4nPqgweMd5rXsZQ21GLncRET3eZ1Z1SH1qznY32TpPzo5BHOpz+POTniKu1NgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105151; c=relaxed/simple;
	bh=q9kUnINnzM2h1qOmbQdjZo4Rw0F8JxCi2/foS2zgXWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFVj+9vthotBXZRvnyBD0D7JkkNaL6qhwYGVmljgeJ050KiWX16DBmUL7VaN0vtHKxIiltOG1qG38BZMArxfQgP0AqAFMkfmtmKPVjBUHbaLjMv9WNw99kni/Gtr34cUCH5JNXQupsRPbkMHGjA7VR0X3e2unpMFQadqzyYvK7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fpHij9fd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpHij9fd"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so2136632f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 05:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786105141; x=1786709941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6ARJxBgnBxK+6NZln3mP3Z60UK181/qnNyKgABn96o=;
        b=fpHij9fd/n1vvKu2ltWtxpzd1ntXCE1fCNezIas5V2lXQXANM14dGxAsLqRr+dAYxn
         Iw1RiQmEsRdEDj+UOOU5QtjeqtqKJLjQ/jBWJNGk/jxjnRdqHbEulWuw2fM3zPeDr7j6
         rNLPA37yK8BLrdi/aSz82b7AICpIrSs+DIx3J354eIqhYwMpdcfe8Pxpeeyw3q3lk/0x
         tAwML/8+gU+oHtBfkcJi1NyZxBoCFDgBkwb9QfcWEqa2GDB40co79YH8Js3OskIX1UNQ
         g56pIG0ABk8/H3bIhLAWCnPCLCMczDxae1++GDZvnZzFAIYfvoIdtXQgdLB8XJ4ngjaZ
         FjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105141; x=1786709941;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b6ARJxBgnBxK+6NZln3mP3Z60UK181/qnNyKgABn96o=;
        b=Jx85CJIPLnSMn8KGL23S26U0fybBTrI772xRRkXyz32Lmvgy6WFaJeEudJZ/MjS9Hz
         IzTF+rk4bu315iFaed79ygGBRbJtpNeSr8ktf41TPIqVyVOGfnWALCY1uSWsWdwd8OcP
         fL/VMvEUit+FxoTnS/o/VTEOlGGuVyOO/6xYYoYqdDy0dTG6OX0kcmCtJHOCxRnjJ/Qr
         M8NzHHJGJbVzvQnFLx2OPAbFj0+PWo2ScTMFq6ioXIvzSMFzpq1N2V0WfAO8cSXun7Dx
         rbGkdHIhuh2xOx2gBZF/oE896+Ko/pMeWiuTte35jwL6onNzThIEzZdh+w4ozCa9J3jM
         ISUw==
X-Forwarded-Encrypted: i=1; AHgh+RqN1LPjHV+PbS2lGpoKrMuVtUxNep1LpJpkUGjrD7FwFCJgAa9JNzCCZrC8eEUbDJIALpR6o6hgJ7nhRIM8Kirz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6AtVZryHssVlYX9H6mBLdLj90t43OL6ddsrgn3pgcfd4kw/7o
	TfI5z11lEFCdw8U3B2V/PDXMWrw8ouudxvX8uaSA6CkX/kZqu/niFh5kIUPCKpvFqoE=
X-Gm-Gg: AR+sD13A2Uxcz2w8DzU1li37++aqCEe9qT+QTQ1Vj2IWhGCL8qmbf9ofH8ZuHcGqD0w
	P4wE4E0yPq/YYs+0K7tsE0k/2kbneJjUGOUKl0njo75eKnC/qh/HoAcNJHn11ptRfqENkzF7HAi
	sgl/bAOwA12ohv2aW+xGG6CfAwBk8ZDQWdKLDKqC4bMz/QJt2t9dxVgz+kG/aikVOST+ATJRm/h
	GgRVzSIK7jZD8EVe6KMneFRR5+TmGz/V1CI+1Qy0u3acSN+tj15becdsctg7aBWTgx1HWZZR3pW
	aZLALHIAIpjTKoGHcbtF/lOH41+JrQudCxJFoy4R3yeOKIIFb9ekQj6e0V1b2HJRcnUohu0S7vY
	kSWzKQ0znwNILrntJezYznHJwyqq10JITfqQrBGmjoHoG9Oq37P/V2Dd2JSUFDlot7tdA/PZHNr
	ht9TrCvWVTI5J/ROCJcQg+tMICA94HBanYwlWEwrv2tdFAivXWsHHEoJHsBCl8SOUe3Q==
X-Received: by 2002:a05:6000:4715:b0:47f:9752:3277 with SMTP id ffacd0b85a97d-47fec509a9fmr38796349f8f.2.1786105140913;
        Fri, 07 Aug 2026 05:19:00 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f8b9bsm6038188f8f.25.2026.08.07.05.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 05:19:00 -0700 (PDT)
Message-ID: <66590828-a571-45eb-8e67-a55bebea1b97@linaro.org>
Date: Fri, 7 Aug 2026 13:18:59 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_pmuv3: Zero initialize hw_id branch stack field
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, "Rob Herring (Arm)" <robh@kernel.org>,
 Leo Yan <leo.yan@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>
References: <20260807-james-brbe-init-hw-idx-v1-1-009d1843960a@linaro.org>
 <a985a304-b399-4e84-99e3-0c6200ae518a@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <a985a304-b399-4e84-99e3-0c6200ae518a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/08/2026 11:44, Anshuman Khandual wrote:
> On 07/08/26 2:44 PM, James Clark wrote:
>> PERF_SAMPLE_BRANCH_HW_INDEX is supported by BRBE so hw_id is passed to
>> userspace, but it's never set by the BRBE driver. Zero initialize it as
>> it should be according to the docs:
>>
>>     * For the architectures whose raw branch records are
>>     * already stored in age order, the hw_idx should be 0.
> 
> The in code documentation while defining perf_branch_stack.
> Probably a good idea to specify the same above.
> 
>   * For the architectures whose raw branch records are
>   * already stored in age order, the hw_idx should be 0.
>   */
> struct perf_branch_stack {
> 	u64				nr;
> 	u64				hw_idx;
> 	struct perf_branch_entry	entries[];
> };
> 

I found it easily enough. I wouldn't want to put the same comment in two 
places and risk one of them going stale. And if I take it away from one 
place and move it to the struct then it's just missing from somewhere 
else instead. So I think I'd rather leave this one.

>>
>> It's probably too risky to remove PERF_SAMPLE_BRANCH_HW_INDEX from BRBE
>> now in case anyone is setting it and reading the value, but zero
>> initializing the whole struct also protects against the same issue with
>> new fields that are added in the future.
> 
> Agreed. Because PERF_SAMPLE_BRANCH_HW_INDEX is supported in BRBE,
> hw_idx pushed to the userspace should be zero if HW never updates.
> This is definitely better than dropping PERF_SAMPLE_BRANCH_HW_INDEX
> flag all together to avoid breaking current users (if any).
>>
>> Fixes: 58074a0fce66 ("perf: arm_pmuv3: Add support for the Branch Record Buffer Extension (BRBE)")
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 

Thanks

>> ---
>> Very small fix spotted by Sashiko. It was probably always zero during
>> testing or never looked at.
>> ---
>>   drivers/perf/arm_pmuv3.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> index 8014ff766cff..b9a8592bf112 100644
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -1361,7 +1361,7 @@ static int branch_records_alloc(struct arm_pmu *armpmu)
>>   		struct pmu_hw_events *events_cpu;
>>   
>>   		events_cpu = per_cpu_ptr(armpmu->hw_events, cpu);
>> -		events_cpu->branch_stack = kmalloc(size, GFP_KERNEL);
>> +		events_cpu->branch_stack = kzalloc(size, GFP_KERNEL);
>>   		if (!events_cpu->branch_stack)
>>   			return -ENOMEM;
>>   	}
>>
>> ---
>> base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
>> change-id: 20260807-james-brbe-init-hw-idx-53dec54fe266
>>
>> Best regards,
>> --
>> James Clark <james.clark@linaro.org>
>>
> 

