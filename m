Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA39310771
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770371431; cv=none; b=tnFw8llFCQDXC/jsLmXfxVvOua8gQ0haWQSr3QsfeDsrizK8FeCAnVBoeeY5rk59OAAisW7OsJqrdl1qVLtde57hPOYB1TUzIQgzL+nWK/ExrhOPVTY0dhzoCfv/vzvn/6zyBuBI7hQ0Wd48OtE/8KqRD4PnZm7HV04uCPxd3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770371431; c=relaxed/simple;
	bh=KL35tDLUXt+MeQlE0IHaGqWoW/V3SwV1poY6EEFCY2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYSq4Sd2wahq9fhf8m3h18AUFl3xHozX2UycV6tasWtTRa9/K1rgZArte7klDK/sDUTAKNB+4XHqOlkfvUimvybiIciLMWRLhs9DB2j9mE6VmZ0tvFz3QmxmWxrd22zVL6gMYzjsaeYorAp2olp1JfkeFLfsVwMMeKN5BYK+L2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f208nwAB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f208nwAB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4807068eacbso17443405e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 01:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770371430; x=1770976230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vq4afyB4nOZV3ntLdfaJ1K/gi8ayC5ysivYWyKh2NcY=;
        b=f208nwABx6D+bsH3Maf8GUtSC703kZokrekAs+oyl8xgPY9xMVnkR0PYLJvy0hkmur
         DHkKf1m0EIMpMZYQ8MRhwe94MgnMHZ9hVBnPG/9pf5fKDCXaw0oekg8y5Y8COEEQVuv9
         SrZkKKbofemkULl1N9SY45+WW4DFnUEcJfDrl4wtmtEOOncGX3OdJB5nw0OpG8YM9Y31
         QKqQ+8GrnUjlyMFaRDxR0WaKo9yZCkWByK/VUelt5ZGgLIfRgPTcBsST5QaweR5vOr/i
         IPH+25WSZGk25+wyS+SYEcwBD+P5pk0RlbrIn3+uxZRRuhORbTBo2Io+WKD1QgtyLT7l
         RseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770371430; x=1770976230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vq4afyB4nOZV3ntLdfaJ1K/gi8ayC5ysivYWyKh2NcY=;
        b=bFBDwSxEunOh7rqW+dLy/6OI4Y3N2nl+zghNaK7GZo1RWRv/48OKCRoZS6RnALtsFE
         JcYQEF1Vw0a6rp3uCWuuO9jabKAUyW4fa6XuCf6bos1LyE5DqnrlQ0t5KeEfJ81dwB52
         e1dJ5JoqXADxVSYokJSI1YGLLvA20GqtYVnL3BreHE//haDfTcuFpb2L0gJy9OJVD6Uh
         95xC2ib4SHLYgG4I5CWktC+fd2n4Pe96AFvoEig0TyZ8UHWToDVMc7NbvkbrnAU4t2ni
         TZx/eIIawO+kgy2zPbpDahLcI23eAAqs9tpUXbwNn2Ku42/aB0lGFPbWw6ecX7o2kRYO
         DMAg==
X-Forwarded-Encrypted: i=1; AJvYcCUxD9COwVQ2xfsyO5Vx4QK88G0nMrfd4m8PaCWWuyUcRFFGG17SVfZTIS5qYFJv2T1x5N7jEKjyCl98A7NBnyyM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr909LFNH3mvGicZG+52vyovZDPMLUtiGkfYxdSAYagW2NsEV6
	qsPFH4hmEo4TwtFPIt6Sh42omNb58mHXLPqtPk/JC+apLZrGLuaf3dGr+AZWiVCsrCQ=
X-Gm-Gg: AZuq6aL6EsgZdzgLxAKVRUYmPGBfnvavjDtlMNHbm+9ZfnTEgwZDqlCuzfFZmpxY8HF
	wPpjXxR9KHZ4chCgwk/m9eCAp+Gx3Shk1wLIx84oJZiE164inHASuSa84kmJjsCrcPCs9rYwFEk
	iAa7Qnbrlz3CNG9daUYOsr3K5hXqpbZiH7+E0psC6Qtxk7Sv7xQpTO7VT+WKZltozmC830mTWO7
	AZI/KUU4qIn8pe/RmRB3vSGCZac47NiM4tAumAQwfnEpmxYEH6pFG1R44Y/Ku2zi0co4dD58ETq
	NfyumNvuCDBVNFAIFmkbuPAxYq1z9soJZLTWF4ycXVvuEEmWUZ3Oi0Md5h4iPHjVVQNUsotC6C6
	q/yrnEyj4b4tYkyMZ43wE2tNx13z3ZxS+zHsd8UCKk/z3YzuShU1NzArryHwnB4Bv+hwbbmvCZz
	lXzcaPVZLxboJLDhB0
X-Received: by 2002:a05:600c:34d1:b0:47a:7fd0:9eea with SMTP id 5b1f17b1804b1-483201dadccmr27868905e9.3.1770371429302;
        Fri, 06 Feb 2026 01:50:29 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483179dbdcfsm147954785e9.0.2026.02.06.01.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 01:50:28 -0800 (PST)
Message-ID: <e7d53952-59f6-4990-83fb-1182641af29f@linaro.org>
Date: Fri, 6 Feb 2026 09:50:27 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_spe: Add barrier before enabling profiling
 buffer
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Alexandru Elisei <Alexandru.Elisei@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
 <aYD08d42SewAAQCB@willie-the-truck>
 <aebe99ad-1189-4372-83e3-385f33829bd2@linaro.org>
 <aYHXCkFZcVm1L_25@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aYHXCkFZcVm1L_25@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/02/2026 11:07 am, Will Deacon wrote:
> On Tue, Feb 03, 2026 at 10:46:37AM +0000, James Clark wrote:
>>
>>
>> On 02/02/2026 7:03 pm, Will Deacon wrote:
>>> On Fri, Jan 23, 2026 at 04:03:53PM +0000, James Clark wrote:
>>>> The Arm ARM known issues document [1] states that the architecture will
>>>> be relaxed so that the profiling buffer must be correctly configured
>>>> when ProfilingBufferEnabled() && !SPEProfilingStopped() &&
>>>> PMBLIMITR_EL1.FM != DISCARD:
>>>>
>>>>     R24557
>>>>
>>>>     While the Profiling Buffer is enabled, profiling is not stopped, and
>>>>     Discard mode is not enabled, all of the following must be true:
>>>>
>>>>     * The current write pointer must be at least one sample record below
>>>>       the write limit pointer.
>>>>
>>>> The same relaxation also says that writes may be completely ignored:
>>>>
>>>>     When the Profiling Buffer is enabled, profiling is not stopped, and
>>>>     Discard mode is not enabled, the PE might ignore a direct write to any
>>>>     of the following Profiling Buffer registers, other than a direct write
>>>>     to PMBLIMITR_EL1 that clears PMBLIMITR_EL1.E from 1 to 0:
>>>>
>>>>     * The current write pointer, PMBPTR_EL1.
>>>>     * The Limit pointer, PMBLIMITR_EL1.
>>>>     * PMBSR_EL1.
>>>
>>> Thinking about this some more, does that mean that the direct write to
>>> PMBPTR_EL1 performs an indirect read of PMBLIMITR_EL1 so that it can
>>> determine the write-ignore semantics? If so, doesn't that mean that
>>> we'll get order against a subsequent direct write of PMBLIMITR_EL1
>>> without an ISB thanks to table "D24-1 Synchronization requirements"
>>> which says that an indirect read followed by a direct write doesn't
>>> require synchronisation?
>>>
>>> There's also a sentence above the table stating:
>>>
>>> "Direct writes to System registers are not allowed to affect any
>>>    instructions appearing in program order before the direct write."
>>>
>>> so after all that, I'm not really sure why the ISB is required.
>>>
>>> Will
>>
>> We were under the impression that this was required for the SPU as it is
>> treated as a separate entity than the PE.
>>
>> In "D17.9 Synchronization and Statistical Profiling" there is:
>>
>>    INDWCG
>>
>>    A Context Synchronization event guarantees that a direct write to a
>>    System register made by the PE in program order before the Context
>>    synchronization event are observable by indirect reads and indirect
>>    writes of the same System register made by a profiling operation
>>    relating to a sampled operation in program order after the Context
>>    synchronization event.
>>
>> That specifically mentions an indirect read following a direct write, which
>> seems to contradict D24-1. Although I thought this is a special case for
>> SPE.
> 
> My reading of the the text above is that it is covering the direct write
> -> indirect read case, whereas I think the case in the SPE driver that
> we're considering for your patch is when we have an indirect read
> followed by a direct write.
> 
> Will

Yeah, and that text also only applies to "profiling operations", not 
writes to PMBPTR and PMBLIMITR.

Upon further investigation you are correct about the isb() not being 
required, even with the new relaxation. Seems like we just accepted that 
the relaxation required some change to the driver without really 
thinking about it. But yeah thanks for looking in detail and catching it.

So we can drop this now. Sorry for the noise.

James

