Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039EC1547CA
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738916042; cv=none; b=eMmw6TMmid66ALODUztGIAPpv7rVCTHauwi0GOn7wlmjWXazVH5soRZK5w5Di8miF0EwrpyOsf3VZbzuaE9zHxB2xEHzoc78I9jvwzFbLM1kP6R1EtFQgv7BTzjV8s5jCaiNF4dnNqj0Ccemd7COndHtjrR72tG2fDegrU4F1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738916042; c=relaxed/simple;
	bh=DzRl7T8sIjvlyYTMPc+CcYOkIjrhZ4zBf6aWJ7k8aKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7UnSKkhN9UBTDrUA0IUAkPvodeOH/V1FvrdBStulkXWT7AcbDbpDMKF2nBKGDDLvq8gy6BUCaJShpCwem9pvZni8kVHEXFfPDCE9xtSENnxf9OBZymnVt71oSMBZIp9wNWY9PxB+030PGWDNqyp+2Rd/PfAS8JqbX3FRtj20Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Bq6YVLY5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Bq6YVLY5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso11549545e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 00:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738916038; x=1739520838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffr0OMCgv5rw2MLpHSX7E1qg3OY60t4awxWCHQtHUac=;
        b=Bq6YVLY5jlP5t/oj0RASV7dDXvJI2VBVua8urckQG+4Wlf0Tt/V5efn95XhxZGexDE
         WZFL5H38mPJqGQvc+ntjj5eXih/0rQJc3aK8gKHRnLRvrlc+tiB+kKEd7+0C7M1NDeul
         /iKtRz2V1okrSOpp48WFWHGORBxA2izRX4e0G81JSPxs1IBc++v8Ylr69bqxEK8zy4tn
         O44grSmOc61ZgTf1+aUL+qrnUYV4BmrOFNjXmOmGWR8AM5O8RzEVgmTnnwRGPL/4GG7k
         IR1o0uh2ggftfP7+l9G38PEMtvKbQW6coufUU1XCJv2MtvkVhDY9EyAbyBChW+FTqUIS
         i2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738916038; x=1739520838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffr0OMCgv5rw2MLpHSX7E1qg3OY60t4awxWCHQtHUac=;
        b=LI3ye6ozNYjHF1AdS0STJTO2Rf2yA11JrWknQ8bBoM/L7whnb1rrsBsCuH43GcH/g9
         tfFUt+N+ajCR00le1kpIYjNc8bYdSbcai24gl1B9EltidmNI1gmBpeIeX+cx9cbME+HD
         ijuQNowYqAspSfJjWzQyPp3vC8CtR5py1MGDXGQbaeb77FsrkG1tZ32awSp5NADOp5u2
         1D2ty5ISWPKeVYx2/rW2XzgCuQ8g0TmViVZCe1cMzHFe4/zsMO0xcCFFU75bF9N23tc9
         WCvLiO+CT9PtkjEX8+424qU2ja65H4W85dqYh4fRACHEeKn9mg90jCIS6/NusjwFxuyK
         Su+g==
X-Forwarded-Encrypted: i=1; AJvYcCWHkn5IL8L6Vh+GLQz5raFCrTmPmWOYRryTElaY9X8RRKXO1vcntg/sGPEx3nvK/6NfNV6euO+GQvEWh+VL58pH@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDSFJMZ4l9NB/7jUVa+1u83rqx1lS6o7su3cQ7ZEicTpbe0Fx
	7FjdrxdB6CVfton0rIPYlg3TJOKyxrTllOekRCuZL2V3hvDohWsdKiFr5EzOvsg=
X-Gm-Gg: ASbGncsP8TOo2lEhJVFi5dPzhiRmsDRnTnUbBLHjBmvbbhj9XcjwO5As/hQtliHOfvD
	GoT79VVZVvNs0l8WSGCZuENZCaSo8Fp4fqSTNUY/9Q8xx3nvMfpquk1Bq5LNuKtvxDpVkehCGf9
	rfPS3xmZbnyBTqm7oLPQ3aq8IAq19XIGHzWHJo6u1tuhYU3HPjrdwYkwfPrTXf0qMgvSaqrq20+
	8L477KDZ94CXckPkHI7Da3n5hPX9BEVLA13dx9PsIVGA8x+jYshjSYjTX8DwB2OPuydDXqmKWvO
	TqFhcE8Qg7bFIxOia88vAvoYzQrr7G/0DnlM2Ghpx/IMxwkoEEDiMBHSEP/A
X-Google-Smtp-Source: AGHT+IEGr/YRTYNXaAzVLspq4nx30yqY6bs6EtU6OBmGn64/zPMRjPnpKtSGL4mxDnpbYdH0c6ehyw==
X-Received: by 2002:a05:600c:35c5:b0:438:e231:d35e with SMTP id 5b1f17b1804b1-439248b6ebamr20948965e9.0.1738916038069;
        Fri, 07 Feb 2025 00:13:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc09fc2d9sm3167994f8f.6.2025.02.07.00.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 00:13:57 -0800 (PST)
Message-ID: <d03581a9-495d-47df-99f2-96065b06ee8f@rivosinc.com>
Date: Fri, 7 Feb 2025 09:13:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/21] RISC-V: Add Ssccfg ISA extension definition and
 parsing
To: Atish Patra <atishp@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
References: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
 <20250205-counter_delegation-v4-9-835cfa88e3b1@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250205-counter_delegation-v4-9-835cfa88e3b1@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/02/2025 08:23, Atish Patra wrote:
> Ssccfg (‘Ss’ for Privileged architecture and Supervisor-level
> extension, ‘ccfg’ for Counter Configuration) provides access to
> delegated counters and new supervisor-level state.
> 
> This patch just enables the definitions and enable parsing.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 2 ++
>  arch/riscv/kernel/cpufeature.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index b4eddcb57842..fa5e01bcb990 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -103,6 +103,8 @@
>  #define RISCV_ISA_EXT_SSCSRIND		94
>  #define RISCV_ISA_EXT_SMCSRIND		95
>  #define RISCV_ISA_EXT_SMCNTRPMF         96
> +#define RISCV_ISA_EXT_SSCCFG            97
> +#define RISCV_ISA_EXT_SMCDELEG          98
>  
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 8f225c9c3055..3cb208d4913e 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -390,12 +390,14 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
>  	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> +	__RISCV_ISA_EXT_DATA(smcdeleg, RISCV_ISA_EXT_SMCDELEG),

Hi Atish,

based on your dt-binding commit, if smcdeleg depends on Sscsrind, Zihpm,
Zicntr, then you could add a validation callback here:

static int riscv_smcdeleg_validate(const struct riscv_isa_ext_data
*data, const unsigned long *isa_bitmap)
{
	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_SSCSRIND) &&
	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZIHPM) &&
	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZICNTR))
		return 0;

	return -EPROBE_DEFER;
}

__RISCV_ISA_EXT_DATA_VALIDATE(smcdeleg, RISCV_ISA_EXT_SMCDELEG,
riscv_smcdeleg_validate),

>  	__RISCV_ISA_EXT_DATA(smcntrpmf, RISCV_ISA_EXT_SMCNTRPMF),
>  	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
>  	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
>  	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
>  	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> +	__RISCV_ISA_EXT_DATA(ssccfg, RISCV_ISA_EXT_SSCCFG),

Ditto for this one with Smcdeleg, Sscsrind, Zihpm, Zicntr, Sscofpmf,
Smcntrpmf.

Thanks,

Clément

>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),
>  	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
> 

