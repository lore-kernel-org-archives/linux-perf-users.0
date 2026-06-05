Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76FD3CFF55
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623375; cv=none; b=SSbSqJZumldMLnTfX/r4Q6hca3ESm03XKq1RNITGt2FkBG8e7QCQGvZbj0z89OAit4z74zg5NWVc9C26rORknDJ0woNecsfq24KlbyZ0Z8TjHRNy89aXuQeZWVCf7Hhn4QA5MW09puH31cpoRb78kiJelKOXqvn39wsxdscOBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623375; c=relaxed/simple;
	bh=4TddvqQj1yoJYvvKzgma1Dfl3o6WmztaTrNRp3WdnLY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HyDtHur6odgskF3OOwY51RGVAoyXB4ckprf3lgdF/AjvrQwjfAoX4Cmwr8wkGwRfR/3H1QT4N5m041arNiTzQdBP7jOA6FjiVei/WEBaDqB1UUgW7xoG0dH4ub1BuEKmHFUq3AgnHyalToaOl+/xmBPssAh/p668aPG0ABD0PW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3X8L0RL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3X8L0RL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A451F00893;
	Fri,  5 Jun 2026 01:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623369;
	bh=bqcz1pEh1Xc2p+Z0URtuTQP/3uzF0ELqpvSYhwTMAXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D3X8L0RLfiImREdaoLhig/OYBGzWkDtquLzXPdSF09C8NiuUMXOOgYOFDSB2uUTu/
	 dhrwOJ1bQaPL0ZQO7tD4qUryKcktZbXmToQIPiGbceEfeMp+QAyTxLs6aAnVWSdkAm
	 flfJuopx/wbkLhxuDoL04BHs8LExIgQ3YLghAaZHji+IC9RDGPFzt4nAfBjeQYeuc9
	 UrZFfpj1WUj20t81tM5UT0a+EIoviNLm6lcdXwO9JZb1cc1b8wrDWhlT4f78/Mt9+k
	 9YeezJraOFTF+LbZgzDyJHU4jRwDcm3Dk4LkL/uM1uVbFYGIFoZ0GSxohsnt6AGN3y
	 dd4JBFeeXwoBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] perf/x86/intel: Validate return value of
 intel_pmu_init_hybrid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605011136.2043393-7-dapeng1.mi@linux.intel.com>
References: <20260605011136.2043393-7-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 01:36:08 +0000
Message-Id: <20260605013609.38A451F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unnecessary error handling and dead cleanup code for early boot mem=
ory allocation failure.
--

commit e6fc94eb7f63fa466e8e1aeaed9a0d18231a88dc
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Validate return value of intel_pmu_init_hybrid()

This commit validates the return value of intel_pmu_init_hybrid() to prevent
attempts to access the uninitialized x86_pmu.hybrid_pmu[] array due to
allocation failure. It adds error paths that destroy the task_ctx_cache when
an error occurs.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index ea3ab3050a3b1..efd9caa3502c5 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -8539,7 +8540,9 @@ __init int intel_pmu_init(void)
>  		 *
>  		 * Initialize the common PerfMon capabilities here.
>  		 */
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret =3D intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret < 0)
> +			goto err;

[Severity: Low]
Is this error handling necessary for an early boot function?

Since intel_pmu_init() in arch/x86/events/intel/core.c is marked with __ini=
t,
it executes only during early boot. At this stage, if a physical memory
allocation fails, the system typically cannot boot anyway. Handling memory
allocation failures and returning -ENOMEM here is likely dead code.

[ ... ]

> @@ -8885,6 +8900,10 @@ __init int intel_pmu_init(void)
>  	intel_aux_output_init();
> =20
>  	return 0;
> +
> +err:
> +	kmem_cache_destroy(x86_get_pmu(smp_processor_id())->task_ctx_cache);

[Severity: Low]
Will this cleanup code in intel_pmu_init() actually free anything?

If the allocation fails during intel_pmu_init_hybrid() and we jump to the e=
rr
label, task_ctx_cache has not been allocated yet. It is only allocated later
in the function via intel_pmu_lbr_init() or intel_pmu_arch_lbr_init().

This guarantees task_ctx_cache is NULL when this error path is taken, meani=
ng
this call to kmem_cache_destroy() acts as a no-op.

> +	return ret;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605011136.2043=
393-1-dapeng1.mi@linux.intel.com?part=3D6
