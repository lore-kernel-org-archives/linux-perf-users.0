Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA1199254
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738915693; cv=none; b=qoLLWGTl0t7GNEYpvovpoUllfSzqehYZtG0KCuuZazYnPEVtsVmCux3DE6l6elh+PjAGwjcL8SNpc/KDnF1aY8iXHdozymLN2ZWFvyVap8VN+xzP/uNWg4V633qA5U+BlbkJc3KsUHVhbKidY48z+MKc/s9DOvlnaGVT056NewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738915693; c=relaxed/simple;
	bh=mGnLpccjRRFhssRkLpnaUDhik6CTmCZ9AVgqJcR8GI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKhm0qTQJxLVwDatg9VFMI5RcPw1KTkMywbVcfHpRopV8DIF5dAlmWL1w9GdgjsdFzcUjDywAxFWb/vegrrfCu5x11YZRueAcC3HEpzfWARDWOHa1MtmCnfFDQ5gEGgpL8TzHZG/I8ovFjbfvLTwC11+50k4xJzXVtvHENn3HYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SxlRlTHK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SxlRlTHK"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361815b96cso11667335e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 00:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738915689; x=1739520489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7+57nAAv8QP4u/IKjzXqebMrcWsPnCBFtc7wCFJPUQ=;
        b=SxlRlTHK5KEuGx22XbO1QgpCu9KBjqonBUDaMKQNMoeJJ6uhMgwwnuUnJrm/KHL8Nv
         K/A0AyYSu4O7rdH3A3qA7RzUV7D8anZQKQKY764GI08FGxsemgZ5s4z3oXoAdYhxxpiO
         oqClhT/TdJc4GvJK/lWy1U7ZySknNDSLQviKcgT+2qkXTxvpQwONmzFvcCBxmZ4Gap3N
         APJMHeaBgtW6DdgQNT0OMFafuhvHu7SB1tfLjfYtlIqwUCfZN25DQ59r+Fqpxh/kRc/q
         WrC+GtsBcNT9eY+SNJxDsH+hHn95SIR5I/CxY9VPcSdFfQ2dQ163BriAOGriQQ7wJNpL
         MHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738915689; x=1739520489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7+57nAAv8QP4u/IKjzXqebMrcWsPnCBFtc7wCFJPUQ=;
        b=qTTKdLeLoKSjnKdWGifS1m75W4/PNYHYnEx3xf4zHI1Q55WJ8IFKnMb4MY0s1LhF+q
         CGFS6r6MKkPMkTbzGbUbrCZtLKFHs/vLPAD9FAPk54wcOqVcWolq67BH5RmNM0doObxo
         nU8JdatzsxQKFchOeCq9CuIvXj71S6N/lr8SSaiGkIzB9CVC6RMxIzniAHtbYC0WrCRH
         q6JEoHvTkw5rr0yhvbn4m+3iDae6UCeuPbhEQPQd4oMUuCMA40AznMjUdk+dKwipjfsD
         t3mMXqQV88n2073a7+glZ/9yp//kk0WNTGF2YJzCrFtGLRUDLOPk7X9eLY8cDTHF26/a
         yDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlAdDWZ3dV6og8C8SFaIkAiFtYHAgLjRrtFbFzM/y9+j58q3vVeYdUUKY+G62sOPC01QtsutF3v4Zoyi7+slxy@vger.kernel.org
X-Gm-Message-State: AOJu0YwxxfMLWc2nuTNTtYqOZ/CGOCphFshTmbIsC05hupOgcdl2EQGx
	EWSKpQ/motkMVVaZjSGZFZ6ZHn9vq0c0uT4BWdo4uertL7SCRFQZ+dFu18NrkBE=
X-Gm-Gg: ASbGncvVCJG60OVRJ07koNF4pr/Is2n1nL+xz0xGacpnBDYelQGKqgBrO35FP7jkDfi
	pMhUOlb3yMBLRMb4zI95f2DdxUmkyqxQyxgP6Piu54NrhWQk7ReBSHrk2g0hGXVZixtZ8EV/F1d
	3Yg5ifhZu2TMQUVrBN1z96Ct1WTR/JOXA0n6hC5TAedcKpqLxRXul7a7xYsEA7AhOJ5ObyuRm47
	8iXvIG8Suy+rXMnYQ5ASR5z5nNnDEaXbIa8jEtQPysrUSExYjwIEOoBmCNy+QA+83U2OwGRc5Qe
	qNC8dSIqYVbTgxdytbF4tP9KHBNPPA7mvK8pXVSwvLNNePIzZrmuFFUQP64A
X-Google-Smtp-Source: AGHT+IEpCAnzMJ9gzxKx250V5bllvFofCg+NZdnX2FF6QiB0L9kNIhtil4j6rsAH/g8Ai7a/4f4w3g==
X-Received: by 2002:a05:600c:6c52:b0:434:f335:83b with SMTP id 5b1f17b1804b1-43924a27b10mr19870375e9.5.1738915689136;
        Fri, 07 Feb 2025 00:08:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca004esm45229805e9.13.2025.02.07.00.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 00:08:08 -0800 (PST)
Message-ID: <d5138234-b0c3-4f78-af9e-33e0d5039ea3@rivosinc.com>
Date: Fri, 7 Feb 2025 09:08:07 +0100
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

Hi Atish,

The spec seems to primarly use Smcdeleg rather than Ssccfg. This commits
adds both but only mention Ssccfg in the commit title/description. Maybe
it could be nice to mention both as well.

Thanks,

Clément

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
>  	__RISCV_ISA_EXT_DATA(smcntrpmf, RISCV_ISA_EXT_SMCNTRPMF),
>  	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
>  	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
>  	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
>  	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> +	__RISCV_ISA_EXT_DATA(ssccfg, RISCV_ISA_EXT_SSCCFG),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),
>  	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
> 

