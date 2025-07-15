Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079472D8790
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Jul 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585024; cv=none; b=qlpSrGkW88NVv4nc2YCcspOzWaIe2TnMFI7wGjRc5D1FYnl0+Qjs4ujVx8MUW2CgVp/RrkR3Qmep0hTUAiTz2fHjynFEgfErJfIOZA5gm5RCJwSTGkDqzywdNCS5VigNA5uu4K+y0mUKpZBiX+emchSraYc5a27qYOwWrG7IeAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585024; c=relaxed/simple;
	bh=DHGtu4HwP1LgM2IMWFzTtkDx34BllDYI/W2+QZldCzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EoaWAYWCbIWWHh/Buo2mk9tqwtlwOYbAVB9SLW9I5r/2Kn6sz4hWEIAmiGjEvQNMCwxWVafkoTJ+VAC6Op11ZprG+iolRAqXaDM5TDY16GWng1JGVe3w9cLZBlIg+DKyYTKidZ+sspX8yAPXVmpO8fiaF02kwXNutyTV7NuG4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEl4XVD1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEl4XVD1"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a51481a598so2772807f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Jul 2025 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752585020; x=1753189820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLie5zOVyoKUjA33oPyC/WGRzvoFygYuppsebPS2FNA=;
        b=mEl4XVD14MO1nfdjWt4JCOVbSCTujFDcM+zfnjma1mwgyk9+RK+sW6dKwY2wkOP9aK
         KknmyInPBkmneEUNpkb4tmjX5Zl3ecyLYHzDrWyVXF1f5iBRiX+G/b/GSTW2v+L/5hH5
         AaCGbRE5e82AKA3PkM5B7JYmdWirKAicJ4IHFC5hGTpAmPi2gM/dcQxnoAW6qDeRoQnO
         +l4uI/kA+6ygSkcEPtKx9HgtznrHp8pibIaS1pnBZ0RBdVJSL0UI47rch5ilSSYcSLpw
         DhQysSJeagdRFBU7/k+P9mPHIuzEXKew71Sy2RmOogaekESDaTTsuMyat3c3AqVUHoxd
         VFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585020; x=1753189820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLie5zOVyoKUjA33oPyC/WGRzvoFygYuppsebPS2FNA=;
        b=T4YE1E/p1IFdmwOsuNu/A2qCKiU27xsjIN2P++xGcz9m4pwVt1VIGuiUWi26anGRTM
         7GMcGFz3lwFg/6ID2n8YSCWd+y/pA66mKjEO6sbqnnO6fn1MICVhRwBbdWEV02uTgE8g
         T5f5Ga/yz02j84u4MX8x6QbnfyKUZTiZCTPsn7dR2zVcoHKKW6fGmSk/rP2/f9avmmft
         fBRIomCa6JxTwQBsUqpqrcSDSlQWenJtSVdVHT+Wmu4Es71+dft9edyzCs1Ywkez+OnU
         MO63/6GZo/PJVIngwm9ngNHQd/7RauetpO1KoiTEa0GxpiVzM0qU7cl5WSAVDNSP6A1r
         hI+g==
X-Forwarded-Encrypted: i=1; AJvYcCXovzJVIiCA3A2wpHDWuXjyPlPFtO4iL1/oVJ5FfzEx2p9ooV6kI1p6WHE1EKYiv1UmrSQxTxoLy6f+WvRUlfDp@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgT7bBUcRzgM29roojWxjTaP7IBy9lxMVOtN0hrhU9m1getr9
	m0ekvHZHMRlUaP+JXzFpBHpVmmhynGkEkuYnc7WXetTvGF1jl6/ThG3vspdYko130Vw=
X-Gm-Gg: ASbGncts/5a3V4QjOJ9yZosmgpBI+jc3ccqq2Cj6sUEak0cP7uxruCDaXJPDOhzv3Ib
	A3nRvPUsMxSCvmHx3/K7Fc5kaTs5GQl4cfvVwe1g0GpP4JuG1/IcZj3vIEAqaUtPo2bih1QuUBF
	dany9vke/GmB91VS8N2krdeOFoQZ7HQkPPD9fKHttsiHlCUBbKncCucZbKy6cASxlNxd1zo3Sdw
	hFXkQOb1vti7vRUveii1zqbG44xPn45OHCYtIknJ+hFf9zwP+UghcRacZET30EIELQx24F1V4QK
	Pe3PiUF+DhttU9iXsUgsX95tuUUdj4wxW5AlRLv0FEhiYz7ZmRqJNKS+vCK3bEhpGiadAIR3C+q
	2XbwMdddQ6J8AKCOuCi5FMt24j0M=
X-Google-Smtp-Source: AGHT+IFe4r8KriuNAFHXNYf/4cwh/PGYuzAM7nUnVEwSGtbr0UTcF5cgzYyzCdphFsVFvt+3gZMD1g==
X-Received: by 2002:adf:9d82:0:b0:3a4:f5f6:b4ab with SMTP id ffacd0b85a97d-3b5f2dfd6f7mr10433427f8f.30.1752585020307;
        Tue, 15 Jul 2025 06:10:20 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560733e736sm104730995e9.29.2025.07.15.06.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:10:19 -0700 (PDT)
Message-ID: <e1210c84-69d1-4fb2-88c2-a6a1bcb179c5@linaro.org>
Date: Tue, 15 Jul 2025 14:10:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev
References: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
 <20250605-james-perf-feat_spe_eft-v3-4-71b0c9f98093@linaro.org>
 <aHUMMk9JUdK6luLN@willie-the-truck>
 <04d52182-6043-4eaf-a898-9f8ccc893e5f@linaro.org>
 <aHZQH7QGhi5pbXU8@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aHZQH7QGhi5pbXU8@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/07/2025 1:57 pm, Will Deacon wrote:
> On Tue, Jul 15, 2025 at 01:48:03PM +0100, James Clark wrote:
>>
>>
>> On 14/07/2025 2:54 pm, Will Deacon wrote:
>>> On Thu, Jun 05, 2025 at 11:49:02AM +0100, James Clark wrote:
>>>> SPE data source filtering (optional from Armv8.8) requires that traps to
>>>> the filter register PMSDSFR be disabled. Document the requirements and
>>>> disable the traps if the feature is present.
>>>>
>>>> Tested-by: Leo Yan <leo.yan@arm.com>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    Documentation/arch/arm64/booting.rst | 11 +++++++++++
>>>>    arch/arm64/include/asm/el2_setup.h   | 14 ++++++++++++++
>>>>    2 files changed, 25 insertions(+)
>>>>
>>>> diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
>>>> index dee7b6de864f..abd75085a239 100644
>>>> --- a/Documentation/arch/arm64/booting.rst
>>>> +++ b/Documentation/arch/arm64/booting.rst
>>>> @@ -404,6 +404,17 @@ Before jumping into the kernel, the following conditions must be met:
>>>>        - HDFGWTR2_EL2.nPMICFILTR_EL0 (bit 3) must be initialised to 0b1.
>>>>        - HDFGWTR2_EL2.nPMUACR_EL1 (bit 4) must be initialised to 0b1.
>>>> +  For CPUs with SPE data source filtering (FEAT_SPE_FDS):
>>>> +
>>>> +  - If EL3 is present:
>>>> +
>>>> +    - MDCR_EL3.EnPMS3 (bit 42) must be initialised to 0b1.
>>>> +
>>>> +  - If the kernel is entered at EL1 and EL2 is present:
>>>> +
>>>> +    - HDFGRTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
>>>> +    - HDFGWTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
>>>> +
>>>>      For CPUs with Memory Copy and Memory Set instructions (FEAT_MOPS):
>>>>      - If the kernel is entered at EL1 and EL2 is present:
>>>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>>>> index 1e7c7475e43f..02b4a7fc016e 100644
>>>> --- a/arch/arm64/include/asm/el2_setup.h
>>>> +++ b/arch/arm64/include/asm/el2_setup.h
>>>> @@ -279,6 +279,20 @@
>>>>    	orr	x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
>>>>    	orr	x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
>>>>    .Lskip_pmuv3p9_\@:
>>>> +	mrs	x1, id_aa64dfr0_el1
>>>> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>>>> +	/* If SPE is implemented, */
>>>> +	cmp	x1, #ID_AA64DFR0_EL1_PMSVer_IMP
>>>> +	b.lt	.Lskip_spefds_\@
>>>> +	/* we can read PMSIDR and */
>>>> +	mrs_s	x1, SYS_PMSIDR_EL1
>>>> +	and	x1, x1,  #PMSIDR_EL1_FDS
>>>> +	/* if FEAT_SPE_FDS is implemented, */
>>>> +	cbz	x1, .Lskip_spefds_\@
>>>> +	/* disable traps to PMSDSFR. */
>>>> +	orr	x0, x0, #HDFGRTR2_EL2_nPMSDSFR_EL1
>>>
>>> Why is this being done here rather than alongside the existing SPE
>>> configuration of HDFGRTR_EL2 and HDFGWTR_EL2 near the start of
>>> __init_el2_fgt?
>>>
>> I thought everything was separated by which trap configs it writes to,
>> rather than the feature. This SPE feature is in HDFGRTR2 so I put it in
>> __init_el2_fgt2 rather than __init_el2_fgt.
> 
> That's fair; __init_el2_fgt isn't the right place. But the redundancy of
> re-reading PMSVer from DFR0 is a little jarring.
> 
>> I suppose we could have a single __init_el2_spe that writes to both HDFGRTR
>> and HDFGRTR2 but we'd have to be careful to not overwrite what was already
>> done in the other sections.
> 
> Right, perhaps it would be clearer to have trap-preserving macros for
> features in a specific ID register rather than per-trap configuration
> register macros.
> 
> In other words, we have something like __init_fgt_aa64dfr0 which would
> configure the FGT and FGT2 registers based on features in aa64dfr0. I
> think you'd need to have a play to see how it ends up looking but the
> main thing to avoid is having duplicate ID register parsing code for
> setting up FGT and FGT2 traps.
> 
> Will

I'll give it a go but that could end up being fragile to something that 
is dependent on two different ID registers in the future. Then we'd end 
up in the same situation for a different reason.

