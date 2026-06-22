Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7435E93E
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782110616; cv=none; b=dBmmx1krvov2SdQDbiNxtcDOw53y7xW6q/7EWj/oHKgdju2/rVloZqWPf7Y90TTtCmLoSs4fkzoz312yzvsyMfZ9Hek/QnGKlxkaiVc4mBUYxYbn98JnKaUKl3V+MQ3/6XtUQp8a/icsPw7uhxLuESunuNQh94HZpmBAvtHfZmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782110616; c=relaxed/simple;
	bh=9xwpQ9qDlVLz2n4sU3njBUuAeEnwns3BdMtbXCU0Gyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkjDQKJC4+UqQFegwjGT55hbyAWtFY3jNLwCHgBFzxgsjVq+CNEChoxiVj5b+OT2UUI+EXIFlTq/uU1rxU97eSub8yjpNaHFUOZwhvFcz6EHg1Me6hLmDi6mB7zMCGnp/XEreXGWs3tnYXEqd4I0Wro5xAd3mH97eyIVN8LLT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0hhIiah; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0hhIiah"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1390f75d8bbso2416201c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 21 Jun 2026 23:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782110613; x=1782715413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/ijfEBLG2GDgKYljJEgtRrqYXmGeXk+QfQobYUMazc=;
        b=K0hhIiahXu2uqpC4oAljyqq4Vq2E3/uITi+8O6AP2vds0S940WDEfdQsm5GkXHZ69Q
         GaLvo53+eX7ashiMiRm9gIBrLRmHTgrkSRGi2/haeR3vp3UCt9Tb92eZhGO7+ciGKhl2
         RLZUnSa8KyBa+t2DSBh2U7if9c8jYuleDHIQc96DFxmXiSM91dF+QmdugfBpXQMlWJnJ
         4ghksQ4c3NAdeBGhYjtkDqLszuR6yLtcPeWyFeq5oMyKRi1Rt8BGssf/XA+kmVY0ZNBD
         gh3ZZMRMPfhYAK9LWjEkNj2euMTuWQLfeDsi0UjSKXEDErumaPNzwSrmawYCqFBVFtRj
         84MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782110613; x=1782715413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/ijfEBLG2GDgKYljJEgtRrqYXmGeXk+QfQobYUMazc=;
        b=cprGlLKR58i0uSuQucff6f4JNmaklUO9ARFJM88KAvCBSz1T5U30d6R5KQWnhS6I/G
         OQvV0YTsQGHXRsu+nhTT5QQEB9Wu0XYW8NxwxR1lbS0zWLIgaDIALaEE4vl0qjs9KPau
         qQM5xgQPxrN9oNnu9PmyJXEziq9FkMIYTwoxUaCjukloN41Z2hxUQqXhxt5oN5YOJjl6
         2CS4YjWjddSzrhn7Z/15cFIYB7mAQwhR27wFLWtXyKrIbQ1LymhuAl1BOzofsmjK1Gcq
         ZI6dYmobqWaz08pkUzWtLi1wjYEszkpcOhiU0ZMD/HYNicji6Li9ao/aNakxKX/TGsWy
         60VQ==
X-Forwarded-Encrypted: i=1; AFNElJ98HGD0jPpuitjQGO42m63WtlvETX1N1gCz+j9TZk9u8GUsgC8ulJ3L5GvYukjtEJYH4i0F3LxGse378LXhwqi8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5z9gtx5KCSl8YgQzxLPLx1ec3lHVAmMxjlYO4T8cIXDZV3NXE
	TG0yaHITXQXtfz6QHr0cLQ0+EzVj0VKOZRNEquUp0g+WJz3F5/rllTAQ
X-Gm-Gg: AfdE7ckTWhzRZ01qEpg58nNvijisk6ekPmIxkUyakE9JmTYrAXLEUjT/9HyBoAJH0Oc
	pP8aDI3/2BVHpGWUOtie6idTybqo32c5KUAuwgNvFNORdbB5tFf2uQ2OcURqlv5ccNQwLP+OCyX
	FBhIi0SVPUV06n0T3lYykBPIAZFV0kTgjq075bd9cwGKB1x+mY9c2OBEgntBLU/LKkLDgcxZ/MA
	kxr/HH2bsu+FcE/gbFtmhwlZX6GBFLBiF9Qyet5huY6Ou5Wv7CRdBHXyGlvFBZ290ABCroOuX+M
	sYnaK+NUzbTqFY+SOze4C3fDXad5dwUeKrqN+Iw5Dn9S+t/PFLtE1eBQ94Abnju4QUfgvqfRMhy
	/T9Bc/unIF2MQWAZJ+ec72UhqMRykB979nQDeUske1jHetQvPUGegwKXujIMLyNQfUxnUbPg+y+
	b2
X-Received: by 2002:a05:7022:f689:b0:12d:b993:c68f with SMTP id a92af1059eb24-139a4eb3fe3mr6345562c88.4.1782110612828;
        Sun, 21 Jun 2026 23:43:32 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add73a44sm6680306c88.13.2026.06.21.23.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:43:32 -0700 (PDT)
Date: Sun, 21 Jun 2026 23:43:29 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anup Patel <anup@brainfault.org>,
	Namhyung Kim <namhyung@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 07/21] RISC-V: Add Sscfg extension CSR definition
Message-ID: <ajjZkRxoh2F3vUAS@blinky>
References: <20260608-counter_delegation-v6-0-285b72ed65a9@meta.com>
 <20260608-counter_delegation-v6-7-285b72ed65a9@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608-counter_delegation-v6-7-285b72ed65a9@meta.com>

On Mon, Jun 08, 2026 at 11:01:21PM -0700, Atish Patra wrote:
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
> 
> This adds the scountinhibit CSR definition and S-mode accessible hpmevent
> bits defined by smcdeleg/ssccfg. scountinhibit allows S-mode to start/stop
> counters directly from S-mode without invoking SBI calls to M-mode. It is
> also used to figure out the counters delegated to S-mode by the M-mode as
> well.
> 
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> Reviewed-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index b4551a6cf7cb..26cb78dee2fd 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -241,6 +241,31 @@
>  #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
>  #define SMSTATEEN0_SSTATEEN0_SHIFT	63
>  #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
> +/* HPMEVENT bits. These are accessible in S-mode via Smcdeleg/Ssccfg */
> +#ifdef CONFIG_64BIT
> +#define HPMEVENT_OF			(BIT_ULL(63))
> +#define HPMEVENT_MINH			(BIT_ULL(62))
> +#define HPMEVENT_SINH			(BIT_ULL(61))
> +#define HPMEVENT_UINH			(BIT_ULL(60))
> +#define HPMEVENT_VSINH			(BIT_ULL(59))
> +#define HPMEVENT_VUINH			(BIT_ULL(58))
> +#else
> +#define HPMEVENTH_OF			(BIT_ULL(31))
> +#define HPMEVENTH_MINH			(BIT_ULL(30))
> +#define HPMEVENTH_SINH			(BIT_ULL(29))
> +#define HPMEVENTH_UINH			(BIT_ULL(28))
> +#define HPMEVENTH_VSINH			(BIT_ULL(27))
> +#define HPMEVENTH_VUINH			(BIT_ULL(26))

Since these are rv32 bits for a 32-bit register, I think these should be
BIT() instead of BIT_ULL()

> +
> +#define HPMEVENT_OF			(HPMEVENTH_OF << 32)
> +#define HPMEVENT_MINH			(HPMEVENTH_MINH << 32)
> +#define HPMEVENT_SINH			(HPMEVENTH_SINH << 32)
> +#define HPMEVENT_UINH			(HPMEVENTH_UINH << 32)
> +#define HPMEVENT_VSINH			(HPMEVENTH_VSINH << 32)
> +#define HPMEVENT_VUINH			(HPMEVENTH_VUINH << 32)

These definitions are identical to the rv64 ones, can these be removed
and can you move the rv64 definitions to be global?

- Charlie

> +#endif
> +
> +#define SISELECT_SSCCFG_BASE		0x40
>  
>  /* mseccfg bits */
>  #define MSECCFG_PMM			ENVCFG_PMM
> @@ -322,6 +347,7 @@
>  #define CSR_SCOUNTEREN		0x106
>  #define CSR_SENVCFG		0x10a
>  #define CSR_SSTATEEN0		0x10c
> +#define CSR_SCOUNTINHIBIT	0x120
>  #define CSR_SSCRATCH		0x140
>  #define CSR_SEPC		0x141
>  #define CSR_SCAUSE		0x142
> 
> -- 
> 2.53.0-Meta
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
