Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8416C8E6
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Feb 2026 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771502913; cv=none; b=IAapY43QT+DAr6TBmLaju5exqIDbN0KGAJg/bU/2kvpmcaIhAwr+kKAfnWeNPErHnS2Gaon/wWitUBIpqukLrgGKXwPgekMLAk69+08NNUCY8SJ3newkZ0tMaGLnVM34hpZ4/HvRfAF/8EWCWBvtXiI7WEcfcV0TQwVBzeJOtVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771502913; c=relaxed/simple;
	bh=hm/zLnnlT9cXL0HTYCjSKtblSbCt+VgBaM08yvZq9Hs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B/877rP+An7xABYuJECATOKJlLivphlvdFJDuw6B0f95gu9Xm9sWaQgOggCO+lMYuD87j84/plenB6nPufZeXBi0pF56f8m7I90tnNn2BmLyrw26jwuBVv7/1XOoYboFpBXoURLuFX33DgJnozLY/e9IVRakcVyqwFsmyVktd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pA3QPrzI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pA3QPrzI"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so8118795e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Feb 2026 04:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771502910; x=1772107710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=19hUzouawp/aRIR5i7245sqjFiNHPs9y+KpLGEqgsP0=;
        b=pA3QPrzIsxzOJmAeHVE38koqJF9jrjJOYZtPnDUX//0QkpVDO5K4HD8QJHd/k7x1uc
         xbcOZK75BBzrAb/nThrIrtZzJvl11FcrZ07btY05DavXnGABehRLe+y1Y9cF5AEaTHba
         GCKyBxYNdKqLarJCvGWopr4M/AZk57pMzumWwP8eEcdDH+/y/XuIeNOLBZ/4PQgPNZLV
         WupsgW7pLqtQ5kx6cvx3eVMv7hwIogAqv2KUKd5tr2qFud370PeM1MFjTjBzT2L+28L3
         5ce4LiHKPcWgi/2454Ki6p8h5wBlnc/n+PTKFuymQLBtK8QlLZSZXH+8OsDEYzXlZKhN
         uRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771502910; x=1772107710;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19hUzouawp/aRIR5i7245sqjFiNHPs9y+KpLGEqgsP0=;
        b=fm/wljH06ZSh/BC7xtXxuDJXq6BDG81iLFh3hbjuKTyxsTzIBV76sUV7zF0+lAShTX
         FGZpNyJL/vj9vNefZ1C1njhnQu2Z0+0n5/c1A99Wh3dvlPHriBsEGO4crIfCh2aMmz3z
         5k/H9iZsrPk4UvtKTZHbp4Tpuf2cE29R1LtmWwzCZgINp8xDxs/+dVvt942NLTtxHO22
         8ELDoaB2XXlJetHfEmtHhXgWj0ZyXpq4IiC/vupaflbOI3K41OeS3/kFqgMTwEva7+us
         JVLkfXCz0z8Fo3Aesw/AFtTGMLX07y+Lyzcym3Su8nDEewCFluzuAnySl7WkGIq3esU5
         UMbw==
X-Forwarded-Encrypted: i=1; AJvYcCXyh3rDbnBHUZhxzHr+mLQb4LsHp5XBDMi4ViaC1szfMtaYlejQQ18i4FtsCEv/zjTqHLoAnWXiwt5tWoe8u4Y+@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYPnk4FdmWjFa91vG1LGdI8a0ODfO+VhcvnkILN21IHQfgbdC
	rVMxysL+CXYByB8ymUxaN18PtmPQAaDlAb7Kf6w/ArD2Gucqyj5VLtIFlb2LIXpit3I=
X-Gm-Gg: AZuq6aI0VquP9EJ6vRUv5BMbs5wIDY+pfPNblhvhd8ZV5jj9Pqlgs/UPwndIyuILOeN
	g14k1GfOyFIowM1CknBD8qPdYsUly+QivjofaUevcXADX7PILa5sjqH7swZxyfBLFrLdLnYGB6+
	GBeDaMgMBcIi4yDcwjlzRuj6RKxAG6/11ysaGkedRoKYwNeDemRIBd4kMBFVVEC0PFStGaDFef9
	PAffokR2gGn0N0FxPWMKh8dNK/io0jCPiPlDdz5rcTRCqvmCFwR/b91ee/HE7P9RNR1sKYiinBm
	xxqgNgJVSgPnjAmypbmcNEAV3rMaePQr+8EHmhxmapx375B/xOm8UgZkSu7CqhHyfnhJhf2Q0XD
	zHRem6o4X47v1mnATWQe3hZ10EenRah+07R4Ne9VWD2Cf3JxgQQJ7vwDSvDKwZTs19zcI5u6H8d
	kI6JWjminv3Y5/KXnATjmogs2Z4ndv
X-Received: by 2002:a05:600c:4745:b0:47e:e20e:bbbe with SMTP id 5b1f17b1804b1-48373a4e7dfmr348245485e9.25.1771502909985;
        Thu, 19 Feb 2026 04:08:29 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f9648cbsm20304135e9.8.2026.02.19.04.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 04:08:29 -0800 (PST)
Message-ID: <705acb39-2eef-4e61-aec1-b9503e788299@linaro.org>
Date: Thu, 19 Feb 2026 12:08:27 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_spe: Add barrier before enabling profiling
 buffer
From: James Clark <james.clark@linaro.org>
To: Will Deacon <will@kernel.org>, Michael Williams
 <Michael.Williams@arm.com>, Alexandru Elisei <Alexandru.Elisei@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
 <aYD08d42SewAAQCB@willie-the-truck>
 <aebe99ad-1189-4372-83e3-385f33829bd2@linaro.org>
 <aYHXCkFZcVm1L_25@willie-the-truck>
 <e7d53952-59f6-4990-83fb-1182641af29f@linaro.org>
Content-Language: en-US
In-Reply-To: <e7d53952-59f6-4990-83fb-1182641af29f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/02/2026 9:50 am, James Clark wrote:
> 
> 
> On 03/02/2026 11:07 am, Will Deacon wrote:
>> On Tue, Feb 03, 2026 at 10:46:37AM +0000, James Clark wrote:
>>>
>>>
>>> On 02/02/2026 7:03 pm, Will Deacon wrote:
>>>> On Fri, Jan 23, 2026 at 04:03:53PM +0000, James Clark wrote:
>>>>> The Arm ARM known issues document [1] states that the architecture 
>>>>> will
>>>>> be relaxed so that the profiling buffer must be correctly configured
>>>>> when ProfilingBufferEnabled() && !SPEProfilingStopped() &&
>>>>> PMBLIMITR_EL1.FM != DISCARD:
>>>>>
>>>>>     R24557
>>>>>
>>>>>     While the Profiling Buffer is enabled, profiling is not 
>>>>> stopped, and
>>>>>     Discard mode is not enabled, all of the following must be true:
>>>>>
>>>>>     * The current write pointer must be at least one sample record 
>>>>> below
>>>>>       the write limit pointer.
>>>>>
>>>>> The same relaxation also says that writes may be completely ignored:
>>>>>
>>>>>     When the Profiling Buffer is enabled, profiling is not stopped, 
>>>>> and
>>>>>     Discard mode is not enabled, the PE might ignore a direct write 
>>>>> to any
>>>>>     of the following Profiling Buffer registers, other than a 
>>>>> direct write
>>>>>     to PMBLIMITR_EL1 that clears PMBLIMITR_EL1.E from 1 to 0:
>>>>>
>>>>>     * The current write pointer, PMBPTR_EL1.
>>>>>     * The Limit pointer, PMBLIMITR_EL1.
>>>>>     * PMBSR_EL1.
>>>>
>>>> Thinking about this some more, does that mean that the direct write to
>>>> PMBPTR_EL1 performs an indirect read of PMBLIMITR_EL1 so that it can
>>>> determine the write-ignore semantics? If so, doesn't that mean that
>>>> we'll get order against a subsequent direct write of PMBLIMITR_EL1
>>>> without an ISB thanks to table "D24-1 Synchronization requirements"
>>>> which says that an indirect read followed by a direct write doesn't
>>>> require synchronisation?
>>>>
>>>> There's also a sentence above the table stating:
>>>>
>>>> "Direct writes to System registers are not allowed to affect any
>>>>    instructions appearing in program order before the direct write."
>>>>
>>>> so after all that, I'm not really sure why the ISB is required.
>>>>
>>>> Will
>>>
>>> We were under the impression that this was required for the SPU as it is
>>> treated as a separate entity than the PE.
>>>
>>> In "D17.9 Synchronization and Statistical Profiling" there is:
>>>
>>>    INDWCG
>>>
>>>    A Context Synchronization event guarantees that a direct write to a
>>>    System register made by the PE in program order before the Context
>>>    synchronization event are observable by indirect reads and indirect
>>>    writes of the same System register made by a profiling operation
>>>    relating to a sampled operation in program order after the Context
>>>    synchronization event.
>>>
>>> That specifically mentions an indirect read following a direct write, 
>>> which
>>> seems to contradict D24-1. Although I thought this is a special case for
>>> SPE.
>>
>> My reading of the the text above is that it is covering the direct write
>> -> indirect read case, whereas I think the case in the SPE driver that
>> we're considering for your patch is when we have an indirect read
>> followed by a direct write.
>>
>> Will
> 
> Yeah, and that text also only applies to "profiling operations", not 
> writes to PMBPTR and PMBLIMITR.
> 
> Upon further investigation you are correct about the isb() not being 
> required, even with the new relaxation. Seems like we just accepted that 
> the relaxation required some change to the driver without really 
> thinking about it. But yeah thanks for looking in detail and catching it.
> 
> So we can drop this now. Sorry for the noise.
> 
> James
> 

Hi Will,

I'm back to drag this up again. So I think all of the above discussion 
relies on the ordering given by the indirect read needed for the "might 
ignore a direct write..." part. But it's _might_ ignore a direct write, 
it's possible for an implementation to not do that, so there are two 
possible implementations:

#1 Where there is an indirect read to give the write ignore outcome
#2 Where there is no write ignore outcome so it doesn't require an
    indirect read

For #2 there's nothing to force the ordering. We're writing to two 
different registers (PMBPTR_EL1 and PMBLIMITR_EL1) and we have to have 
the PMBLIMITR_EL1 write come second for the buffer to be considered 
configured correctly. For example if the old value of PMBPTR_EL1 is 
higher than the new PMBLIMITR_EL1 and the write to PMBLIMITR_EL1 happens 
first then it's misconfigured. That's why we think we need the isb() here.

Thanks
James


