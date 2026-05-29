Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD5F3C454F
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051391; cv=none; b=Wg1oZy1rEb62s1yK2itThCHaAHzu1AjEUKMOksdYN0wGVXdS9F65oCdM1cUh0eCTF0R2B4lxMV1k+BSpzYH91GQ9oRJtdXT9i/U+tsiaK4ufMH5rgAV/C26PlopVQ7/GD7NvZYRORX/9xSGU7DIuyxdlFAd4InKUdZ6y1tufW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051391; c=relaxed/simple;
	bh=QgJviAXydJBdbfmpNMUnSOFusfiTWKA89lOK2qSmvfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o4VS451yiNDLFJF+KtM0vmrZE/bbOCZdSz/Q97HG5/DnAzsZdHOSsTXcGXXjVeQTGpS3OhQGO93scRMOkCEGlXUHGWOsVafTs+W0SjvzIpWAUR7vJDppA2SRz+E2DxWzUEAp7eCz4oieWrfEFbgrE0Et9caJnXdDziIlkklTbtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBG3r9N6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBG3r9N6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69DB1F00893;
	Fri, 29 May 2026 10:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780051389;
	bh=efS4mjcno9sUywRg2nZEkpWBCWvzKh7rq3v4BR1JtsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XBG3r9N68obxclsL4JaYm8s/XbqyzJMK8IbHFFNnJzbQM45317+Ib1lfJ6rZrFkOI
	 ZK/OakvQ+uGuvBqwlGDg0/1+T+z9GNJi9XuasF77gZ4BPWlpfuxnio2OhAM4NHs9VE
	 JH9h1n+z7N8jHSjVd7DTWIuCiVsJ5e6Mke6QM/Be4Fm+6ny20HrQaXzPcAq+3joRK0
	 b1B8N7rxGt/K2vR392yZknnkefENCWD/q8b81HXpraPMMqWmYFozmAYGjB2E9b5vRe
	 nRnqzPQKxW3F7gp8zlmIhfqfdQDOZbRw92EHSLNTj3AqqDLfF7RBmq8/41AoP2zhlZ
	 SownSOLeNq3QQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 21/23] perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-22-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-22-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 10:43:09 +0000
Message-Id: <20260529104309.C69DB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The new SIMD registers capability and mask initialization are skip=
ped for older PEBS V4+ architectures (like Icelake, Sapphire Rapids, Alder =
Lake, and Raptor Lake), leaving them without support for YMM, ZMM, eGPRs, a=
nd SSP sampling.
- [Medium] The logic to enable PERF_PMU_CAP_SIMD_REGS incorrectly couples t=
he capability to the presence of non-SIMD extended features like CET_USER (=
SSP) and APX (eGPRs).
--

commit f179abf9419fef51aa84e8c413e619d7004c64c2
Author: Kan Liang <kan.liang@linux.intel.com>

perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS capability

Enable the PERF_PMU_CAP_SIMD_REGS capability if XSAVES support is
available for YMM, ZMM, OPMASK, eGPRs, or SSP.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 679781519f8cf..eef5d116aa068 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6316,6 +6316,26 @@ static void intel_extended_regs_init(struct pmu *p=
mu)
>  	 */
>  	x86_pmu.ext_regs_mask |=3D XFEATURE_MASK_SSE;
>  	dest_pmu->capabilities |=3D PERF_PMU_CAP_EXTENDED_REGS;

[Severity: High]
Does this skip the new SIMD capabilities on older PEBS V4+ architectures?

The initialization for YMM, ZMM, eGPRs, and SSP is only added to
intel_extended_regs_init(). Since intel_extended_regs_init() is called
by update_pmu_cap(), which is guarded by X86_FEATURE_ARCH_PERFMON_EXT,
architectures like Sapphire Rapids and Alder Lake appear to bypass this.

Should this logic also be replicated in intel_ds_pebs_init(), or should
intel_extended_regs_init() be called for those processors so they can
also support the new SIMD capabilities?

> +
> +	if (boot_cpu_has(X86_FEATURE_AVX) &&
> +	    cpu_has_xfeatures(XFEATURE_MASK_YMM, NULL))
> +		x86_pmu.ext_regs_mask |=3D XFEATURE_MASK_YMM;
> +	if (boot_cpu_has(X86_FEATURE_APX) &&
> +	    cpu_has_xfeatures(XFEATURE_MASK_APX, NULL))
> +		x86_pmu.ext_regs_mask |=3D XFEATURE_MASK_APX;
> +	if (boot_cpu_has(X86_FEATURE_AVX512F)) {
> +		if (cpu_has_xfeatures(XFEATURE_MASK_OPMASK, NULL))
> +			x86_pmu.ext_regs_mask |=3D XFEATURE_MASK_OPMASK;
> +		if (cpu_has_xfeatures(XFEATURE_MASK_ZMM_Hi256, NULL))
> +			x86_pmu.ext_regs_mask |=3D XFEATURE_MASK_ZMM_Hi256;
> +		if (cpu_has_xfeatures(XFEATURE_MASK_Hi16_ZMM, NULL))
> +			x86_pmu.ext_regs_mask |=3D XFEATURE_MASK_Hi16_ZMM;
> +	}
> +	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		x86_pmu.ext_regs_mask |=3D XFEATURE_MASK_CET_USER;
> +
> +	if (x86_pmu.ext_regs_mask !=3D XFEATURE_MASK_SSE)
> +		dest_pmu->capabilities |=3D PERF_PMU_CAP_SIMD_REGS;

[Severity: Medium]
Does this incorrectly couple the SIMD capability to non-SIMD features here?

If a processor supports SSE and CET_USER (SSP), ext_regs_mask will not equal
XFEATURE_MASK_SSE, and PERF_PMU_CAP_SIMD_REGS will be enabled.

However, if a processor only supports SSE, this condition evaluates to fals=
e,
and PERF_PMU_CAP_SIMD_REGS is omitted.

Could this regression force userspace tools to fall back to a separate lega=
cy
path to sample XMM registers on SSE-only processors, rather than using the
unified sample_simd_regs interface?

>  }
> =20
>  #define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_I=
DX_FIXED))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D21
