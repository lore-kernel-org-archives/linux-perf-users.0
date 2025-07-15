Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C1231A4D
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Jul 2025 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583689; cv=none; b=CQs3MFsaXiCnV9kA0r22OSqZruw2TWV+VzgPttJrlwVWxT9Qc3J6k0LiBjCyGpmnq/opNRsKQhCR9QdGeNGYM69yQ08RCEAX/V2UXoDPfn0K6w2R10TDASmvNEvLBvfMVYjgOcnnugGaaH+sZfcYU+52cv5gVPpejdUgBVCkFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583689; c=relaxed/simple;
	bh=EPw4dQ8dfonq0P3aVNF8vSgP2GKEr/WhL3SjzkV20GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XK2ZHJ+BKmrvDSCL+UL9f3XLXYGEg2gei2RAjnvpCt2LxwByWqqSEtPvDoq35hauJoHDbbSFRXO2CxbqD3njwIJt9xaEh/s1ASbKQtAEdcdFhExl4Y7FLmjwOmIv9qkN3vDrRDbpS+zuAEJBYKqDiPvunIh2g2G+IdX3djCFco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qB0U8wgK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qB0U8wgK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so49742425e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Jul 2025 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752583686; x=1753188486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iqo4mhXycGD6rw4UTAUbadK3TxDOKrzOub9ByVVv0xc=;
        b=qB0U8wgKfVafmrdK4SZntgzOzE/kz1dySTTGLPRY+cRfUl+WrBt/VwC2m6FYNU1yH7
         Vh5BLKy73qAclnLkaZjE/fXOjsRaiS/LP4k3CVN1eFuAAlmSk98KJ6ARpQwnDoA7xveM
         OoqV1+X1vjz/ioplbVCKh6qNdpaOY8hji45gbqObDErGAKeuEh8ysJKs8m1bschPqrf/
         owuYOAwLVuJPWGHB7ULe4Co9G7QC+wuMLsztuA5lc2PoBFbi1ZzJut1uySvsfMELl3sQ
         OGr+fmEXoAxqLkign944o2Adn8eacojfmhP7KQ/K+B0S3jc9f1fu06kOC4VgvsogcF64
         RwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752583686; x=1753188486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iqo4mhXycGD6rw4UTAUbadK3TxDOKrzOub9ByVVv0xc=;
        b=sn1dTzGhSydL7YRt9IZbD0xQa/rMsEMvuI6U08qceTRqvvxpKVHazpCxqOdt3VRL2/
         McfjI7+g9njmZtkSZ9UExQv2sDtuRtW/o1KXSwJs+M/aYEJFVGyU3WF0LYJP+KjnlJnc
         SGm2XoG8LMlNPPLVzCRKoqKWsgHVPo4bMT0CJsS5FborxVdO+mp0HsYlCGwPY/qqB/dh
         zlhi/GNJ2y8Zh0wgVbarKqiqFFRvE56onJX+gao34dutlqcwA8LB9gHB0Q71S2u4uQbG
         TLIf80CQKcOm0vsaRayb3QE4cwvkO/KuCT8+5sXX20wrEEFMUIly0Xb6DKTuly/UhzYC
         6dSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuhUz7xeEiqTuYxIOnHWWuLQxjXt9eaMqOHcggwicj1mD4mZqekmYeC6dvZmEn616Y5ILZ5gb9CHGHlKvzigFR@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCSfPB2gINCfcY0jX+n4xn0cNIsbsaVn0XRYW2Pk+BaZti1G7
	xSrINvynTrbspZTu+ZzezQFiNcwdrApzKbu4B8mbUygmsic21S+apkZ2nEeVHEZV4Jk=
X-Gm-Gg: ASbGncs5knUxHEivwq8U7qmvnwP5CdIQa2PLsdtoVVBbWeF9tTb0m9/brRj+hagCMAv
	HCRonftsVrBZnr+1v6144fjHvFJMtw2det0/05rbEpqEO1yaBxpRPUiy5hKmwVTEuroMT1Bb9Us
	MYfAjh62Qjcctg/27DbYY/nAJwGqE1ICMUB39VbuC9R7swU3MY+ZFWej8YkgA+3GzrU3pumscEx
	fWU996KG94tE9tOidPkx7HTaV1bnpxG6acA64omSCPeeZ/ETLXq4LgvOh6o+ukED763PBxtXpsb
	EJfL9gVr93OSPMSY8HEYAly8gUn2CIYnm/N1zIB1daFLoqf1jbZ6L9lIPoGKwEBOKin94zHdTNw
	KxRXyrOkDSbiXclKOyZLSpPcOooU=
X-Google-Smtp-Source: AGHT+IHksQQexPF9xeIAPmAN5RQVQtwJAwRE0OCzaS0bMryNoBsPAdHpgVxKs40ogsxaKO2X4QSDVw==
X-Received: by 2002:a05:600c:8483:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-455bd87a4a2mr140606855e9.4.1752583685607;
        Tue, 15 Jul 2025 05:48:05 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45610c518e9sm84882505e9.17.2025.07.15.05.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 05:48:05 -0700 (PDT)
Message-ID: <04d52182-6043-4eaf-a898-9f8ccc893e5f@linaro.org>
Date: Tue, 15 Jul 2025 13:48:03 +0100
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aHUMMk9JUdK6luLN@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/07/2025 2:54 pm, Will Deacon wrote:
> On Thu, Jun 05, 2025 at 11:49:02AM +0100, James Clark wrote:
>> SPE data source filtering (optional from Armv8.8) requires that traps to
>> the filter register PMSDSFR be disabled. Document the requirements and
>> disable the traps if the feature is present.
>>
>> Tested-by: Leo Yan <leo.yan@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   Documentation/arch/arm64/booting.rst | 11 +++++++++++
>>   arch/arm64/include/asm/el2_setup.h   | 14 ++++++++++++++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
>> index dee7b6de864f..abd75085a239 100644
>> --- a/Documentation/arch/arm64/booting.rst
>> +++ b/Documentation/arch/arm64/booting.rst
>> @@ -404,6 +404,17 @@ Before jumping into the kernel, the following conditions must be met:
>>       - HDFGWTR2_EL2.nPMICFILTR_EL0 (bit 3) must be initialised to 0b1.
>>       - HDFGWTR2_EL2.nPMUACR_EL1 (bit 4) must be initialised to 0b1.
>>   
>> +  For CPUs with SPE data source filtering (FEAT_SPE_FDS):
>> +
>> +  - If EL3 is present:
>> +
>> +    - MDCR_EL3.EnPMS3 (bit 42) must be initialised to 0b1.
>> +
>> +  - If the kernel is entered at EL1 and EL2 is present:
>> +
>> +    - HDFGRTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
>> +    - HDFGWTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
>> +
>>     For CPUs with Memory Copy and Memory Set instructions (FEAT_MOPS):
>>   
>>     - If the kernel is entered at EL1 and EL2 is present:
>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>> index 1e7c7475e43f..02b4a7fc016e 100644
>> --- a/arch/arm64/include/asm/el2_setup.h
>> +++ b/arch/arm64/include/asm/el2_setup.h
>> @@ -279,6 +279,20 @@
>>   	orr	x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
>>   	orr	x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
>>   .Lskip_pmuv3p9_\@:
>> +	mrs	x1, id_aa64dfr0_el1
>> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>> +	/* If SPE is implemented, */
>> +	cmp	x1, #ID_AA64DFR0_EL1_PMSVer_IMP
>> +	b.lt	.Lskip_spefds_\@
>> +	/* we can read PMSIDR and */
>> +	mrs_s	x1, SYS_PMSIDR_EL1
>> +	and	x1, x1,  #PMSIDR_EL1_FDS
>> +	/* if FEAT_SPE_FDS is implemented, */
>> +	cbz	x1, .Lskip_spefds_\@
>> +	/* disable traps to PMSDSFR. */
>> +	orr	x0, x0, #HDFGRTR2_EL2_nPMSDSFR_EL1
> 
> Why is this being done here rather than alongside the existing SPE
> configuration of HDFGRTR_EL2 and HDFGWTR_EL2 near the start of
> __init_el2_fgt?
> 
> Will

I thought everything was separated by which trap configs it writes to, 
rather than the feature. This SPE feature is in HDFGRTR2 so I put it in 
__init_el2_fgt2 rather than __init_el2_fgt.

I suppose we could have a single __init_el2_spe that writes to both 
HDFGRTR and HDFGRTR2 but we'd have to be careful to not overwrite what 
was already done in the other sections.

