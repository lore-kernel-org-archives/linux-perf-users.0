Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86F2EDD51
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Sep 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729366; cv=none; b=iRMY/Fl4jZonNurD930hjmrecquE8vH9uM+pDa6WyOTEEOiLRwEnkkzJSGFaRG69p3iSsV7CuX7feulb0xwM2DCYXxVwQNEQcm4yrfLFR5mnpgskbhNRhACkWAxNTK9K2t9a3+TKNsQ0zUcUUFX0+RRUxebjdBJtdwWla9ZlsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729366; c=relaxed/simple;
	bh=VxC6+65N7fwjuQSBZWaB2FdQLsbh1mR1wNFbx5IdIN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmMk8U8ve9YCAlv/FaqIOjUEI2v3XLKng/hKK8cM2xODx76GG1pxKSz6qL2mk5sL92mzcvAph5fXrLpJLoPxHSFImphwN5ZqhIIPGqQ2O2St9Pfm9HhRxgIy7VCy1x+M/+DSIDWgF467awoOCXl9KW6SGYoGzr1Kuq/CQ7rkzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gkZhwX4f; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkZhwX4f"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b883aa3c9so9307475e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Sep 2025 05:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756729363; x=1757334163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LoSJIL4KWhDGVADj7RHQlobVtqqX19ExJc3z0hs3VMY=;
        b=gkZhwX4f67XZycM8iNmC/aDa18Yx6W5g5tRRPmFMIS480yTP8VgwFHAgPC+XgaAuYI
         mdFg7nR6Z9QX/1KdLf1cmIlalyJe0NliyufIUCFH2egk43pZLeKvRVZ7hW0wwiURV0NN
         RbtQwnHcIGIdJgNHsHY60/I2OYZygHuoZ29Ph3UtWFM3tsv/PvcSBSt0enlyBUPElGMk
         7a/lpBQH4uYoc2auMEMm9Vud2MBI1pcijg2TLU2JZ1tuZMqwt5TnakgjwCSylNyCp10i
         129dWclu3yVpIdnDV/vrGuo2QQdvLTmaRBqNSJYBrChp8/YbDP4d0ySR2oDYhF0Lwiiu
         HzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729363; x=1757334163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoSJIL4KWhDGVADj7RHQlobVtqqX19ExJc3z0hs3VMY=;
        b=hZp/LmY0UfWoz49M79x5zKx53dTCgUgvn1wFr2bTkQM0oC47GYfAcjOOM4qETJkN+k
         6/+wFpsGjKQFXSKZIsb9tGaMsIZ2CwTCLyhQIZ8s/S0Wn+akprImfJ9se41WiMv4FZwF
         IxzGRlCLMgIqY47A5wqgktjX0xUMSL81+I3ROqZGabkSrE7eEhGrJ5vujpn5kz40bGWY
         UPIo6Qv7JOghP/GILhOJ0dx+v1lauIleqaY0lSNo95Guw7B+RNMyLHGvNHkZ6CK2mXtD
         zfOaYNyAClCmLPaRnrucNiHBl+uzmgOsOnyIoxFYmUcWpFzPGvOyf0E7/HKc+OUojxE3
         Jn9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLhyjjHRJEj2QCdWmIBKSNWDX+ldwhIeEiG0ATQ8gLYro624vELirV/3NIg3wQYK05iy8BBt0zhXKcFhxc8COB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5fD+sP+QW09sroJ5f+lJ3DrsAIxiI8Nz9UcCfw7TlWHNywb6u
	8PeGrN0LBi4eNJsPxCSQDazEzqS6HD/8AbXHFnHBybAg1eBrZ6sHm6LE2ZZhcbHFTJU=
X-Gm-Gg: ASbGncuCt0GllI7ckdpLxNXvFUp7zC7wSJLbEdjOU7ywFMnJHIY20Qt0857J3OORQhh
	gKgLwtPqvUTu/5GhgmMuE139YyHltEWVuUbrzv4ipjyM+9edUAg2xUpDWYyaXummp0WwYNG4QUX
	g6+tW7QicErseL5J3s1tvGOtTYwhvlg/dGLwhQ6npSEeXYC+n1VHpEFn91kKlC6SY8S0zD96owm
	2aF3PiXlWFyUxeGGlpjo2BiZLZa9eab9KVRVm/T1vmSWz+Yo9yClXqbqEIjbKiG71kCae7mF/qP
	BQfLjeDTTzsQQobvcgHTm/9V8OuYiWTWxzy2PUDCEMIcOlwX+HJv/gxZkbKi/1bjEovekVh+oem
	w7t7hpy4fxrZzpmjNE/gbd18Z2/+rIIZgZC9JLaayH/E5qTse
X-Google-Smtp-Source: AGHT+IEUYIop2eCnZ9cDKO0ghaVfpBEoRkqiBiGK9LUPFsTbQpLi8gzA5x26B8+fFer989zfNL4Sag==
X-Received: by 2002:a05:600c:4f41:b0:45b:8b3e:9f7c with SMTP id 5b1f17b1804b1-45b8b3ea0e1mr33370165e9.19.1756729362553;
        Mon, 01 Sep 2025 05:22:42 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b87abc740sm88325035e9.7.2025.09.01.05.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 05:22:42 -0700 (PDT)
Message-ID: <e759f728-2a77-42a7-ba92-0d5f8afe2273@linaro.org>
Date: Mon, 1 Sep 2025 13:22:40 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/12] arm64/boot: Factor out a macro to check SPE
 version
To: Leo Yan <leo.yan@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev
References: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
 <20250814-james-perf-feat_spe_eft-v7-5-6a743f7fa259@linaro.org>
 <20250901100558.GJ745921@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250901100558.GJ745921@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/09/2025 11:05 am, Leo Yan wrote:
> On Thu, Aug 14, 2025 at 10:25:27AM +0100, James Clark wrote:
>> We check the version of SPE twice, and we'll add one more check in the
>> next commit so factor out a macro to do this. Change the #3 magic number
>> to the actual SPE version define (V1p2) to make it more readable.
>>
>> No functional changes intended.
>>
>> Tested-by: Leo Yan <leo.yan@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   arch/arm64/include/asm/el2_setup.h | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>> index 46033027510c..3a4ca7f9acfb 100644
>> --- a/arch/arm64/include/asm/el2_setup.h
>> +++ b/arch/arm64/include/asm/el2_setup.h
>> @@ -103,8 +103,7 @@
>>   	csel	x2, xzr, x0, eq			// all PMU counters from EL1
>>   
>>   	/* Statistical profiling */
>> -	ubfx	x0, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>> -	cbz	x0, .Lskip_spe_\@		// Skip if SPE not present
>> +	__spe_vers_imp .Lskip_spe_\@, ID_AA64DFR0_EL1_PMSVer_IMP, x0 // Skip if SPE not present
>>   
>>   	mrs_s	x0, SYS_PMBIDR_EL1              // If SPE available at EL2,
>>   	and	x0, x0, #(1 << PMBIDR_EL1_P_SHIFT)
>> @@ -255,6 +254,14 @@
>>   .Lskip_brbe_\@:
>>   .endm
>>   
>> +/* Branch to skip_label if SPE version is less than given version */
>> +.macro __spe_vers_imp skip_label, version, tmp
>> +    mrs    \tmp, id_aa64dfr0_el1
>> +    ubfx   \tmp, \tmp, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>> +    cmp    \tmp, \version
>> +    b.lt   \skip_label
>> +.endm
>> +
> 
> Just wondering if we need to move the macro to the beginning of the
> file, so that we can define it first and call it afterwards.
> 
> Otherwise, LGTM:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 

It's not required, but all the other macros are defined before use and 
it looks a bit weird to not do it, so I can move it.

>>   /* Disable any fine grained traps */
>>   .macro __init_el2_fgt
>>   	mrs	x1, id_aa64mmfr0_el1
>> @@ -263,10 +270,8 @@
>>   
>>   	mov	x0, xzr
>>   	mov	x2, xzr
>> -	mrs	x1, id_aa64dfr0_el1
>> -	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>> -	cmp	x1, #3
>> -	b.lt	.Lskip_spe_fgt_\@
>> +	/* If SPEv1p2 is implemented, */
>> +	__spe_vers_imp .Lskip_spe_fgt_\@, #ID_AA64DFR0_EL1_PMSVer_V1P2, x1
>>   	/* Disable PMSNEVFR_EL1 read and write traps */
>>   	orr	x0, x0, #HDFGRTR_EL2_nPMSNEVFR_EL1_MASK
>>   	orr	x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK
>>
>> -- 
>> 2.34.1
>>

