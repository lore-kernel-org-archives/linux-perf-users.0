Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879E14F70
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082490; cv=none; b=b1ijg7bVBGJiae/AWN0iJNeE1VLCc7/u40qW6GJmhFdn5FlQ8Uh/S2Nz8sYSbQtFZEllUM7ip/vAWpQ3NXlRt20vZMvk3lPXNYNON48D0QOsLLvgRnFUWhX1CBWyzQTU5dauHXY9N1v/QXtclXWydVOcaZKc8sdOBs8z7iExPJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082490; c=relaxed/simple;
	bh=1viSUqJwCsSjfLzVmCk8mQjAAMKbP72k2v0bT6B2EJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gM/WVdYEnyL+hexAp8FS9bHsEUVEP34TwNxAJcLfwm7FIL2PKvVSfQuyLQYS+4hwyMT+3qVXX8YyycJGAqll3e1KmdbCvGgKu4gFvkhbTeCE5N8HQZzhl+u+XKZMSLESja9NjOvuApWnvhfKwh4ouoV8gZrob0oFaOAUmiwpDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvqtVL/b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvqtVL/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77518C19425;
	Sat, 25 Apr 2026 02:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082489;
	bh=1viSUqJwCsSjfLzVmCk8mQjAAMKbP72k2v0bT6B2EJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NvqtVL/bPIrnmxOfnj9TCs/2v5Paz3Xj+bZHdMVdNcR920dVoiu9e1x6dW5guXTDA
	 Gz/wPZQDijy35Qi9MyrHR0YvQvTUqMtTaKvFmIesu2228dQqO7cIYWAQoK34yyvr3n
	 nOlcWOV04QFghoVYIIQs/shxe9ct2VFqSCDbNeBA/zFsfNae2Frn4UhrDf5p1CT3Ut
	 Db9S6nhgeNOtnbPooJ5cpXlq5oH7/5GXmRlTCRb2MHjp5+0WyukFytTbkiM4/7tO05
	 /0ap9Ug5YsDLBk/MJ9vInMo6dsPWZXrKSyT/t9u8RQAvmonlQ4m0T6FRboYWfQz8Me
	 VHE2yIJT5lY7A==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 21/24] perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS
 capability
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260324004118.3772171-22-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-22-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 02:01:28 +0000
Message-Id: <20260425020129.77518C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] When sample_simd_regs_enabled is true, large PEBS incorrectly re=
mains enabled if unsupported legacy standard registers (such as segment reg=
isters) are requested.
--

commit add2d25bc2536ced31489740914a43c7ed8e02eb
Author: Kan Liang <kan.liang@linux.intel.com>

perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS capability

This commit enables the PERF_PMU_CAP_SIMD_REGS capability when XSAVES
support is available. It also temporarily disables large PEBS sampling
for these new registers until arch-PEBS sampling support is added.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4424,11 +4424,33 @@ static unsigned long intel_pmu_large_pebs_flags(s=
truct perf_event *event)
>  		flags &=3D ~PERF_SAMPLE_TIME;
>  	if (!event->attr.exclude_kernel)
>  		flags &=3D ~PERF_SAMPLE_REGS_USER;
> -	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
> -		flags &=3D ~PERF_SAMPLE_REGS_USER;
> -	if (event->attr.sample_regs_intr &
> -	    ~(PEBS_GP_REGS | PERF_REG_EXTENDED_MASK))
> -		flags &=3D ~PERF_SAMPLE_REGS_INTR;
> +	if (event->attr.sample_simd_regs_enabled) {
> +		u64 nolarge =3D PERF_X86_EGPRS_MASK | BIT_ULL(PERF_REG_X86_SSP);
> +
> +		/*
> +		 * PEBS HW can only collect the XMM0-XMM15 for now.
> +		 * Disable large PEBS for other vector registers, predicate
> +		 * registers, eGPRs, and SSP.
> +		 */
> +		if (event->attr.sample_regs_user & nolarge ||
> +		    fls64(event->attr.sample_simd_vec_reg_user) > PERF_X86_H16ZMM_BASE=
 ||
> +		    event->attr.sample_simd_pred_reg_user)
> +			flags &=3D ~PERF_SAMPLE_REGS_USER;
> +
> +		if (event->attr.sample_regs_intr & nolarge ||
> +		    fls64(event->attr.sample_simd_vec_reg_intr) > PERF_X86_H16ZMM_BASE=
 ||
> +		    event->attr.sample_simd_pred_reg_intr)
> +			flags &=3D ~PERF_SAMPLE_REGS_INTR;

When sample_simd_regs_enabled is true, nolarge is used to disable large PEBS
if eGPRs or SSP are requested. However, it looks like the pre-existing
~PEBS_GP_REGS check was dropped in this branch.

If unsupported legacy registers like segment registers (e.g. PERF_REG_X86_C=
S)
are requested alongside SIMD sampling, will this bypass the check and
incorrectly leave PERF_SAMPLE_REGS_USER or PERF_SAMPLE_REGS_INTR enabled?

Since PEBS hardware batches samples and does not natively capture segment
registers, wouldn't the delayed PMI overflow populate these missing segment
registers using the interrupt context?

Could this result in stale or delayed segment register values being provided
for the entire batch instead of precise per-sample values?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324004118.3772=
171-1-dapeng1.mi@linux.intel.com?part=3D21
