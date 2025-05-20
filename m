Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4B2417E0
	for <linux-perf-users@vger.kernel.org>; Tue, 20 May 2025 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747321; cv=none; b=MMSyT4GkheY3QFU+dv8Nn82VDTuubiu+LEfZZGWs0tU96KUxDEwzYKJ8Wls91mECeFz5QxnxqHb6Ngkx0ZiUuUDMUoWWdQI8ThJ8TuQ2rewJCHhBRMuVmoChOO81+C88NKn5/gPMjRf9Mh0lQLhw4dF50ggz5xOtDmS0Ojvc5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747321; c=relaxed/simple;
	bh=j8nOo9ZgCK2DEIuwn9V867mNRDlvnz48elcUZW9APXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeYPCqeblEuLI9ghfqgXgrCf8qenFp719mThaz2EMmYZJ951X73rXBSmCHGgnJU7ygsa3Sb5gEshel99OZzwUTqBWBLJdZjPsWqTu+fRKDMsoMqUwfjShXsqySMVAR2jBYxg/QH2AY88R5FSDRvq9NrlF7OVAdhpKp/pFZFGdA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CMVNQD7C; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMVNQD7C"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-443a787bd14so24376205e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 May 2025 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747747318; x=1748352118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WjE9NuES4ZYHcQwH+LLDtRp5dcXqipSvO8/PRsW1OSk=;
        b=CMVNQD7CcqXZqstPgV5hu3Tyh/qlzlgXJaRwQVofRLuYHL+eN0gdQPZ6pzebRxNk50
         +/m2RvKAo6fTw5DOjQuQwsJDpwXMW+MtPqJucDyJouLKf6rtzFlSEdX+OEAtsZTPgyfp
         HmlfSH1lyWtvimVsxgAQyovNu8CJeqRSmHf3ZXHgyZqVRAUmevJ89RheUwUwlT2TwaFA
         ZXFsYJWd5oSoaBjutWlWZ7Zm3UyAMw7vutP+xcLsYKU6qo/yqZSFEo/t1dnjj7YrJ48s
         rt3/q33j1sXuYXKaRQSFgcQoYwJvXVCN/7cSlALOMGkRXrT6Xl+oGWWWLfMdMN+8bcyO
         5ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747747318; x=1748352118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjE9NuES4ZYHcQwH+LLDtRp5dcXqipSvO8/PRsW1OSk=;
        b=J+qlk1efVKmH9NtOv0pEuxxLuCXv58nIFnAgbRjmnjvRc3YNv9PEjpn9J5T9SDkVne
         Mm8Qy2KZuuIdPgqoyJeGAxjF9tegPPvI6q/qC540R1SdHFj+HyOOA0RupSRngs3ZUTmo
         tihWhaq0rDicpfIbQJSs2ohnDyo0/kEf8xFBTMjNESz9t+SaXKlRZ5Ojy22+mxUtrt+K
         fm7BOmTA2ei1porWX5NALeG7LYrQqkyOJnk/aH7zpix/11Quo4nWzUdmjfE07gcHuS3d
         JtFH+qOZNQ82M1PwXCh+oJ4MEQ/X5vzkQqCM8Myuk4PeMr4Z2/Wv9vS1Nx7qOTVGKIUv
         aUzw==
X-Forwarded-Encrypted: i=1; AJvYcCVUHFNfR6n6vPr4YBRODIyjFU3g295OKgXPkJ3YfoSKQpC2YQMq1dS1cIzjdYU3m+wfQeR0d8GhexTDNxOy4bMy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw9SWKOyc5I8XsZlPHXnZQPtRxCr1wzdWmWs20V2axlVra1OgK
	slrKLO7O05P2OkPjM6isyYCAUj7phSNAXMxiwt6hG1sFX3Xy2GvunTR37IwAlf0YJNQ=
X-Gm-Gg: ASbGncuKvR53RCuRtdlREoQtQpJ50mzsVIe0JJOid1oaw6EyWQqrcrvthXBYUO8X4+B
	p8C75ksQtwkG4K9EmuJojcLk5jZcgiqwZukMSYyIk7NNKGTFla8iODYkVdAo/FnagVOk2/7I/tz
	MEDqd29L7SiIuSwK8uAvwJP2bvNt0rwtC3OATrT87B115mC4n66S/VuIHb1MsMxL2sqaMzkrvhc
	yVq0AMD2zSPJ4LwK/99jCOcmZcE2/irGGsy3hIHr5aHiSs5Da2vXvfW1+xGOq+A/+M2eZ1cNsAb
	riJ7xAZu7arMZkuUhlxfL6fP98fmqU9G+DplOz1PIsyA9kNZ4VjukJgT
X-Google-Smtp-Source: AGHT+IEfO+pch615avxbBD4lcuwANYfZy4jBF+ULIb5f9fJUkNFZOMIfa+edi4Ii8A7sRlYdjSjFnA==
X-Received: by 2002:a05:600d:19:b0:442:7c40:fda4 with SMTP id 5b1f17b1804b1-442f84c209dmr181938415e9.1.1747747317684;
        Tue, 20 May 2025 06:21:57 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb7fsm29898455e9.26.2025.05.20.06.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 06:21:57 -0700 (PDT)
Message-ID: <4b57da72-7f30-48f7-8458-d1f1e27a28f5@linaro.org>
Date: Tue, 20 May 2025 14:21:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
To: Leo Yan <leo.yan@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev
References: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
 <20250506-james-perf-feat_spe_eft-v1-4-dd480e8e4851@linaro.org>
 <20250520110450.GN412060@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250520110450.GN412060@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/05/2025 12:04 pm, Leo Yan wrote:
> On Tue, May 06, 2025 at 12:41:36PM +0100, James Clark wrote:
>> SPE data source filtering (optional from Armv8.8) requires that traps to
>> the filter register PMSDSFR be disabled. Document the requirements and
>> disable the traps if the feature is present.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   Documentation/arch/arm64/booting.rst | 11 +++++++++++
>>   arch/arm64/include/asm/el2_setup.h   | 14 ++++++++++++++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
>> index dee7b6de864f..8da6801da9a0 100644
>> --- a/Documentation/arch/arm64/booting.rst
>> +++ b/Documentation/arch/arm64/booting.rst
>> @@ -404,6 +404,17 @@ Before jumping into the kernel, the following conditions must be met:
>>       - HDFGWTR2_EL2.nPMICFILTR_EL0 (bit 3) must be initialised to 0b1.
>>       - HDFGWTR2_EL2.nPMUACR_EL1 (bit 4) must be initialised to 0b1.
>>   
>> +  For CPUs with SPE data source filtering (SPE_FEAT_FDS):
> 
> For alignment with Arm ARM:
> 
> s/SPE_FEAT_FDS/FEAT_SPE_FDS
> 
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
>> index ebceaae3c749..155b45092f5e 100644
>> --- a/arch/arm64/include/asm/el2_setup.h
>> +++ b/arch/arm64/include/asm/el2_setup.h
>> @@ -275,6 +275,20 @@
>>   	orr	x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
>>   	orr	x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
>>   .Lskip_pmuv3p9_\@:
>> +	mrs	x1, id_aa64dfr0_el1
>> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>> +	/* If SPE is implemented, we can read PMSIDR and */
>> +	cmp	x1, #ID_AA64DFR0_EL1_PMSVer_IMP
>> +	b.lt	.Lskip_spefds_\@
>> +
>> +	mrs_s	x1, SYS_PMSIDR_EL1
>> +	and	x1, x1, PMSIDR_EL1_FDS_SHIFT
> 
> Should be:
> 
>          and     x1, x1, #(1 << PMSIDR_EL1_FDS_SHIFT)
> 

Nice catch. It was probably always true so I didn't notice it not working.

>> +	/* if FEAT_SPE_FDS is implemented, */
>> +	cbz	x1, .Lskip_spefds_\@
>> +	/* disable traps to PMSDSFR. */
>> +	orr	x0, x0, #HDFGRTR2_EL2_nPMSDSFR_EL1
>> +
>> +.Lskip_spefds_\@:
>>   	msr_s   SYS_HDFGRTR2_EL2, x0
>>   	msr_s   SYS_HDFGWTR2_EL2, x0
>>   	msr_s   SYS_HFGRTR2_EL2, xzr
>>
>> -- 
>> 2.34.1
>>

