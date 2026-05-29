Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02DD33A00C
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049172; cv=none; b=AM7GRYzjvkS38LOtS8v9c+yQhTQ0PRCW+hGX2Kic59cRg5Xd7lPtEWF4gLMsMUTgbikUHAQWQkIzT6U1YCPBwsqMPYSQU6eNfp09pLifXZ/FeIY9gB0fA/tDDkIlQZhlp//1FJmAQMh9Dzf47Tv+2oklJo79owswq55Dwv1HiFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049172; c=relaxed/simple;
	bh=mR/8/Kiim8oWOiZ7BKEZOZI6He+SgkmY0uo8Gb/QMgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q0pArrqJB/WrKos4tSN4/thqIq7+Fg7KwxvAMwkL+PeMBQHF024EPTV8uZPpAlP7cMrVkWXexz4KT82rJfesBguTS/TmztQDORaJ4bYpLRIiw3fJN6Vz7G6VApObX+JBudwo4F9vID/ewcEvhVNHKmda3P6xrqJRhQrBR5yE/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe4O9ihI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe4O9ihI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E84C1F00898;
	Fri, 29 May 2026 10:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780049170;
	bh=/JB8yrP9mqy7rEjG+T1MkU2LwoPlr90/q2ltr0RbILs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qe4O9ihIpRSd7CMyG3nsM0Bf7molthYF1QpuZ/VxrtXmSEntqx39hUuVGE1WUvwVI
	 EHZ6WkNgAjhr5mEwWicoiwSSmC2/MyEgIu3eDwpCucs6UiagLdh4tONx3hE0wtqcIo
	 CBlB5P/X5dkIMX5oyTTyqXRX5LN0AsvpJ6cVnGqVQ6Wm5xXv2S6nTn/XTTIfUUDt7p
	 rDxz7PDxRYSfhBa7pXrk38xVeIT2l7ZWsYmGjkO5VtwSYcTdjCLPhlr2ml1/sTPUoi
	 9m8If7uOARFR3830SEBuy0bvm964AA7L9uwMFI0T71/ej7XwzvYm9Q2Ra8M5r1lL8Z
	 NMVyI0g/lDkTQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 2/5] perf regs: Support x86 eGPRs/SSP sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529082451.591783-3-dapeng1.mi@linux.intel.com>
References: <20260529082451.591783-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 10:06:09 +0000
Message-Id: <20260529100610.5E84C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Intel PT PEBS register synthesis is silently disabled on SIMD-ca=
pable machines.
- [Medium] Requesting legacy XMM registers (e.g., `-I XMM0`) fails with an =
'Unknown register' error on modern CPUs, breaking backwards compatibility.
--

commit a0d7b85bb399d047c94284c24c34805466f84209
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: perf regs: Support x86 eGPRs/SSP sampling

This commit adds support for sampling x86 extended GP registers (R16-R31) a=
nd
the shadow stack pointer (SSP) register. It reclaims the original XMM regis=
ters
space in sample_regs_user/sample_regs_intr to represent the eGPRs and SSP w=
hen
SIMD sampling is supported, using a new abi argument to distinguish layouts.

> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index fc9eec8b54b82..2729ad8c6d263 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -2470,6 +2470,7 @@ static int intel_pt_do_synth_pebs_sample(struct int=
el_pt_queue *ptq, struct evse
>  	}
> =20
>  	if (sample_type & PERF_SAMPLE_REGS_INTR &&
> +	    !evsel->core.attr.sample_simd_regs_enabled &&
>  	    (items->mask[INTEL_PT_GP_REGS_POS] ||
>  	     items->mask[INTEL_PT_XMM_POS])) {
>  		u64 regs_mask =3D evsel->core.attr.sample_regs_intr;

[Severity: Medium]
Does this completely disable PEBS register synthesis on SIMD-capable machin=
es?

Since PERF_SAMPLE_REGS_ABI_SIMD is set by default on supported platforms in
__perf_reg_mask_x86(), opts->sample_simd_regs_enabled will be set to 1 for
any register request (like -I ax).

Could this cause basic GPR synthesis to be silently skipped here, resulting=
 in
a functional regression for userspace tooling?

[ ... ]

> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/=
util/perf-regs-arch/perf_regs_x86.c
> index b6d20522b4e8f..ae26d991cdc9f 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> @@ -276,13 +276,38 @@ uint64_t __perf_reg_mask_x86(bool intr)
[ ... ]
> +uint64_t __perf_reg_mask_x86(bool intr, int *abi)
> +{
[ ... ]
> +	if (mask !=3D PERF_REGS_MASK) {
> +		*abi |=3D PERF_SAMPLE_REGS_ABI_SIMD;
> +	} else {
> +		mask |=3D __arch__reg_mask(sample_type, PERF_REG_EXTENDED_MASK,
> +					 false);
>  	}
> =20
> -	return PERF_REGS_MASK;
> +	return mask;
>  }
[ ... ]
> +const char *__perf_reg_name_x86(int id, int abi)
> +{
> +	const char *name;
> +
> +	name =3D __arch_reg_gpr_name(id);
> +	if (name)
> +		return name;
> +
> +	if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +		name =3D __arch_reg_egpr_name(id);
> +	else
> +		name =3D __arch_reg_xmm_name(id);
> +
> +	return name;
> +}

[Severity: Medium]
Does this break backwards compatibility for legacy XMM register requests?

When the CPU supports eGPRs/SSP, PERF_SAMPLE_REGS_ABI_SIMD is set and the
legacy XMM registers (PERF_REG_EXTENDED_MASK) are excluded from the returned
mask because they share the same bit space.

If __perf_reg_name_x86() maps these overlapping IDs exclusively to eGPR nam=
es
(for instance, mapping ID 32 to R16), will name_to_perf_reg_mask() fail to
resolve legacy requests like -I XMM0 and throw an unknown register error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529082451.5917=
83-1-dapeng1.mi@linux.intel.com?part=3D2
