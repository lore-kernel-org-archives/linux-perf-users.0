Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B63BA23F
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044483; cv=none; b=AC/Xk5v2ov3L7PDzS2clx2Inr5XDRvWussvWTVBMnVaHXyxRfURkj6WprEAIg16XhUZvNAhEkdoU6laILC/5o24NK8lBX7ZFGl1lEXrlMYxoKoHwAhfF01vPOT8JCkXsaSoV56pdpA0HpoCaTWfEUmPKJMA7nXIZMPG9W3F5stQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044483; c=relaxed/simple;
	bh=6IVaznAVXjlgJ+yA5SiF2dZdI7nh3KZXmX0IpOCVGaw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aKPEIPMUmm6JQyCyD5e1do0/nPEzY9mzLYKQDkqeEPr67mCA4rTcrPw13ZRkz623fi2WljihBbTen+j7RMvswL1/i3AEh4dDp0n2iWMqUUFHGH64U20gbbKb6HLgXP8a0AQ5vl0KR6dolBbRDdWedO3GrFRT2+v3omkBFFFuXPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkL3kl1b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkL3kl1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F051F00893;
	Fri, 29 May 2026 08:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780044479;
	bh=6PI4Lq8vDRB9Gm9LfdWqmRVZ/GlnxSdIyLcUXTpUBLw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EkL3kl1bb5e+vYzi48BniDeEpJhygtu0G0fI3JCJInULLm/a2hIhp+jM7T8eTH93G
	 aGatS+dc1RIX4QTwrGtv68fPvphUHVMyE5nIoG3RwQSKOtJmif4LBPEA4Qfp5HzNQy
	 ZHVgAKU7nXaphXXu7f2AdXaCHJ7pJntWhR7KGw8wepM9jp+Hh1wj7naHS0ns4w31B2
	 lWqYegmFOoBgisZNXqpuFkNIMyu8ks66x7F0fthCSAOdrOsTv5r0BuTmUl48VmipaW
	 ElSjx/drA4ABSP+A0WQjkkIw6O1W6sXAIUALQtRVPf4VBLk+Oyuq9m1O0qY575CSvp
	 PcB4MyNhktHWA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 14/23] perf/x86: Support YMM sampling using
 sample_simd_vec_reg_* fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-15-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-15-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 08:47:59 +0000
Message-Id: <20260529084759.A4F051F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The `event_needs_ymm()` function evaluates flag-gated syscall pa=
rameters outside their corresponding flag gate (`PERF_SAMPLE_REGS_USER` / `=
PERF_SAMPLE_REGS_INTR`).

Pre-existing issues:
- [High] The function `perf_simd_reg_validate` improperly returns an error =
when unused, flag-gated parameters are not zero-filled, breaking ABI compat=
ibility.
--

commit f738764532819a2044a1239c400d83c8404d4843
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Support YMM sampling using sample_simd_vec_reg_* fields

This patch introduces support for sampling YMM registers via the
sample_simd_vec_reg_* fields. It updates the perf_simd_reg_value function
to assemble the XMM and YMMH halves into a complete YMM register and
sets the sample_simd_vec_reg_qwords to 4 for YMM sampling.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
[ ... ]
> @@ -1967,6 +1973,8 @@ static void x86_pmu_sample_xregs(struct perf_event =
*event,
> =20
>  	if (event_needs_xmm(event))
>  		mask |=3D XFEATURE_MASK_SSE;
> +	if (event_needs_ymm(event))
> +		mask |=3D XFEATURE_MASK_YMM;
> =20
>  	mask &=3D x86_pmu.ext_regs_mask;
>  	if (sample_type & PERF_SAMPLE_REGS_USER) {

[Severity: Medium]
Does this evaluate flag-gated syscall parameters outside their flag gate?

According to the syscall parameter trust boundaries, userspace is not
required to zero-fill unused fields, so they may contain arbitrary garbage
when their flag is absent.

The event_needs_ymm() helper checks event->attr.sample_simd_regs_enabled
and event->attr.sample_simd_vec_reg_qwords.

However, in x86_pmu_sample_xregs(), this check happens before we verify if
the sample type actually includes PERF_SAMPLE_REGS_USER or
PERF_SAMPLE_REGS_INTR.

Could this cause the kernel to read uninitialized userspace values when
those sample_type flags are not set?

> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
[ ... ]
> @@ -121,7 +128,8 @@ int perf_simd_reg_validate(u16 simd_enabled, u16 vec_=
qwords,
>  		if (vec_mask_intr || vec_mask_user)
>  			return -EINVAL;
>  	} else {
> -		if (vec_qwords !=3D PERF_X86_XMM_QWORDS)
> +		if (vec_qwords !=3D PERF_X86_XMM_QWORDS &&
> +		    vec_qwords !=3D PERF_X86_YMM_QWORDS)
>  			return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but does the surrounding
validation code in perf_simd_reg_validate() inappropriately reject legal
syscalls?

When simd_enabled is 0, the function checks if vec_qwords, vec_mask_intr,
and other parameters are zero, returning -EINVAL if they are not.

Since userspace isn't required to zero-fill unused arguments outside their
flag gate, these parameters could contain garbage.

Is it possible that enforcing zero-fill on these unused arguments
functionally breaks ABI compatibility by failing requests that should be
valid under the trust boundary rules?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D14
