Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2FB1A3A8D
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920085; cv=none; b=WL167nxouPHQj9VekZxovrSPQd8kCAGlWrhBbcQxTjrnWzjKKcgu89nSA4jODmlnfGeKnbko/YVL0jFerM6gBJuzyW1XK6EPtaT4XERYqpDSV8MVCobzWHPu+QVwZLobT/aSk/x3Ql7HA1M87Cid224qTcVRG+IKtpDCnhcDx50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920085; c=relaxed/simple;
	bh=I+m5NFphToaBU7KuM1MYybzmSrg3x16TgEyyHHWiTQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZlifrOetZIxBEPgNNh+bOb14OwNh0o/O34fDR5VJ9LkpthCS8u/tJrCltK4Xh+mHCT2bgJcbF2nGsOjYGrjYYWFVPmqPU6Xmq+RqVQ6iPpWbe4kBU/QP8mAm/FkhBpRe1LEtVVtW/MAkRCPzITSC4vKYHswxGw3de8fVlXXBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qvkOU91T; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qvkOU91T"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43690d4605dso12345815e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 01:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738920082; x=1739524882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9tiH9b+H/9t/xpf0NWHkN82z4SsEthrDvr6Ide4MKv0=;
        b=qvkOU91TKwXhl3wwXeHbSANaUwtiNtlRtC+UiUeWYkITOEGsdrleTAPtqmKkTqD7EG
         8OKunAgQ/SgTNK1MY6uJR2OE20OgZYo15aCnb7UH8o9+eQIIpVUwIIyrEJ/Wz129x7sV
         BVKbugM0+qYln6USEdUnyuosGvUTKp2kDhrYlw7VGFnnF8h7XX0nmPa/XYxIGb4e6Bn/
         gE4EvuSIHLs+zv1B//il1qSjWwTjZKPhfpdDjsMmXwjcLWtC+gY8MNPio3f/VFAvPnt8
         OAjIu5rHmJ/2up3i97w7OPMjf1Fgo7Yw1u8/JX1BmSzqmUUE8/9J1JSZys+EiUs6RLcy
         8g6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738920082; x=1739524882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tiH9b+H/9t/xpf0NWHkN82z4SsEthrDvr6Ide4MKv0=;
        b=Of1TgT/fvsio4+ROk7yD8PMnGt2cczyeB0q1qMMjO4cWEd7UKihA6+dilUbIqetRiT
         qpdAeTYF4tIiQigkAyUdDmjHWvcuBVM+3mGGpiTQzUATgvHExJOcpFWoQxZfgaRYZDxe
         07YFp0j+u/rsTzsO9ALqoH/8X4rVI11tCEAY3zKzsUtyXj16Fmviy5qxjfGmyLfI3Xmn
         x3/Fgg2MGXUPaqnX0IOcldVk2w2l2lpqnrsz/DsPeSYn+hYQ1aJ2a++A8Rs+mZFSonxe
         WGGguMrYCNrS0MmNDpQDxJygM7HcNJcw+HGZwRILD/vwEpexboWtAq0e1ky3cdK/wz02
         1nig==
X-Forwarded-Encrypted: i=1; AJvYcCXbTuySwwAHWvLBjxNMzp80bnXPIa3aqHG1Y7Xh/ZlX1KoDBhsp5JXsHKcTvDXLhXXb0tr2C8PyuHP7B6rr6N4W@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3xI7eKJ+Nfm1iw1INGxPYLswONgYksMC7X7zsHoTOTyfaZPMH
	p3teqUHIOIs9zs5sgRrdQFetTlzlX4cmbhSnQl0khMmdGw/pW1pSaCAnMAHr5+o=
X-Gm-Gg: ASbGncvl+yLNKiOnoFDU9Ft294DQpO+WRW0utDNvqF8fzIx1S8bsNU/gMJqBg56bXjf
	G31uQOiburZN7+BKllqcdbQEKsc+/o5RVvNP3V70zcaTUI8iIbFbJFpatP6pvQXZbdj7UrbTuzZ
	HVPZoGDM104fXtpRiz+q0T5Ar1UrJeVclJ0Zcl4lMADy9nSiJ4hx4T3qfJAugbEL+oPrv+uNHUL
	7q8EoMZZbx85Z5+khPBl20yB1qbexHuMSEInRiHm5bYLSz88ao9dG458B2yk4ioJsXpbsWdO9zl
	9vxsDaK/h6Jze6uaNKb+zNnHVdjmgmAKuR3AQmFfUF7ePdl5X4VBNaID1ElV
X-Google-Smtp-Source: AGHT+IECWFH7U0mArd280iuB70Vnw8HZQHKBAtWHAu5Pk2zNKD95w0WIBx5nMCf9e60ecld/9uOCGw==
X-Received: by 2002:a05:600c:3c9b:b0:436:5fc9:30ba with SMTP id 5b1f17b1804b1-439249c385cmr21219595e9.29.1738920082212;
        Fri, 07 Feb 2025 01:21:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439069290c7sm87180725e9.0.2025.02.07.01.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 01:21:21 -0800 (PST)
Message-ID: <7aace8a9-0e62-4156-9c50-f7b399c4eba2@rivosinc.com>
Date: Fri, 7 Feb 2025 10:21:20 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/21] RISC-V: Add Smcntrpmf extension parsing
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
 <20250205-counter_delegation-v4-6-835cfa88e3b1@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250205-counter_delegation-v4-6-835cfa88e3b1@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/02/2025 08:23, Atish Patra wrote:
> Smcntrpmf extension allows M-mode to enable privilege mode filtering
> for cycle/instret counters. However, the cyclecfg/instretcfg CSRs are
> only available only in Ssccfg only Smcntrpmf is present.
> 
> That's why, kernel needs to detect presence of Smcntrpmf extension and
> enable privilege mode filtering for cycle/instret counters.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 1 +
>  arch/riscv/kernel/cpufeature.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 3d6e706fc5b2..b4eddcb57842 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -102,6 +102,7 @@
>  #define RISCV_ISA_EXT_SVADU		93
>  #define RISCV_ISA_EXT_SSCSRIND		94
>  #define RISCV_ISA_EXT_SMCSRIND		95
> +#define RISCV_ISA_EXT_SMCNTRPMF         96
>  
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index c6da81aa48aa..8f225c9c3055 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -390,6 +390,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
>  	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> +	__RISCV_ISA_EXT_DATA(smcntrpmf, RISCV_ISA_EXT_SMCNTRPMF),
>  	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
>  	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
>  	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
> 

Looks good to me.

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément
