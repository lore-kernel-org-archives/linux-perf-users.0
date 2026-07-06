Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6431D384CFD
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306643; cv=none; b=teiRA8c1qzxRUclXBTjgR0xZOuUPhsL/Xp38uBhkL6vjPtOmXiVTrNo6Smrg3UKObVetRa58JgjGP1BL53UYmiAgw5igHwSt/t5eIg4IPhchgXdAz/aCUFDFiH+ogmIDObi0w5D5ajWH4xRkrdJmlAhSfnkvxuX6Tr42HUWS6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306643; c=relaxed/simple;
	bh=+umkQI7ouS2yCf419U+V71zxzQKmp/2HucHA95jA75U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S7/oDWCKVlbgrq8Zqr17NjRzz1o2Zv+OV2gtF2J1hcb9R01wWECpCZLho7ftNlhaZOhNgNuoL5MEL0l1Jj/0/21Dyd3yHBAXgfYZ9YnEc6yr4W1aCX2tEAzpaP046PpxhLm4yT0/zR8H0dbEu2rWeRMHGbqBh+LyDnBOHiVZxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfUBPhK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfUBPhK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D231F000E9;
	Mon,  6 Jul 2026 02:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783306642;
	bh=bE4DWCMQwKKKJpoDpUo93seP1/U8Ims0vaE9qH9FbpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EfUBPhK1ClaWSxsKIJgfRPBrcowcYB5scbN9/UEmcfYF1HDNCAkpQnvku7JZh5VMs
	 zv7r33UPU6cjsdKYW3MZjojHgiNiROfm52Q98QjGEpLC3a3K54cwSkXkJNneMzicBV
	 CQA5DBU8DR9bqSXOaCcckaMDwRxlTSBXB57vkbgU2DCbhXVszW5y0hRK1cdmsip/Nk
	 NcfFnpabXAApUf9Tp7LBD4VjCxQsBT3O9y0MtgLAuR6CibZBcTeGse+SX2zOfCcCfJ
	 iKJEBVuqiTpyEdlLYWdj1zU/HEasCe/Y27mJr7yUfPAEqCXyTkjSXQMabcuV1PwCU5
	 Yo9DrJLXYzuTg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 22/24] perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706015439.3040804-23-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-23-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:57:20 +0000
Message-Id: <20260706025721.A7D231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The `XSAVES` instruction writes PMU extended register state ou=
t-of-bounds due to incorrect buffer sizing in `reserve_ext_regs_buffers()`.
- [Low] Fragile bitmask comparison using the strictly greater-than operator=
 (`>`).

Pre-existing issues:
- [High] Pre-existing type confusion in `perf_reg_value` allowing out-of-bo=
unds stack memory read/dereference via software PMUs.
--

commit 9750372940712500ad29f87f143032cba6ffbe36
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS capability

This commit enables the PERF_PMU_CAP_SIMD_REGS capability when XSAVES suppo=
rt
is available for extended registers. It simplifies validation logic by tying
the capability to XSAVES and architectural PEBS support.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 15962a3457eeb..56997731dc83a 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

[ ... ]

> @@ -6303,14 +6303,37 @@ static inline void __intel_update_pmu_xregs_caps(=
struct pmu *pmu)
>  	 */
>  	x86_pmu.ext_regs_mask |=3D XFEATURE_MASK_SSE;
> =20
> +	if (boot_cpu_has(X86_FEATURE_AVX) &&
> +	    cpu_has_xfeatures(XFEATURE_MASK_YMM, NULL))
> +		x86_pmu.ext_regs_mask |=3D XFEATURE_MASK_YMM;
> +	if (boot_cpu_has(X86_FEATURE_APX) &&
> +	    cpu_has_xfeatures(XFEATURE_MASK_APX, NULL))
> +		x86_pmu.ext_regs_mask |=3D XFEATURE_MASK_APX;

[Severity: Critical]
Can modifying this mask cause an out-of-bounds write during an NMI?

When extended registers like APX are requested, the PMU allocates ext_regs_=
buf
using xstate_calculate_size(x86_pmu.ext_regs_mask, compacted) in
arch/x86/events/core.c:reserve_ext_regs_buffers(). This calculation omits t=
he
sizes of non-PMU active states like AMX.

However, when xsaves_nmi() executes the XSAVES instruction in
x86_pmu_sample_xregs(), the hardware determines compacted offsets based on =
ALL
active CPU features (XCR0 | IA32_XSS). For a CPU with AMX enabled, XSAVES w=
ill
write the APX state at an offset exceeding the allocated buffer size.

Does this mismatch lead to a heap buffer overflow when XSAVES executes?

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
>  	/* PEBS supported case */
> -	if ((x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_XMM)) ||
> -	    (x86_pmu.intel_cap.pebs_format >=3D 4 && x86_pmu.intel_cap.pebs_bas=
eline))
> +	if (x86_pmu.intel_cap.pebs_format >=3D 4 && x86_pmu.intel_cap.pebs_base=
line)
>  		dest_pmu->capabilities |=3D PERF_PMU_CAP_EXTENDED_REGS;
> +	if (x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_EXT)) {
> +		dest_pmu->capabilities |=3D PERF_PMU_CAP_EXTENDED_REGS |
> +					  PERF_PMU_CAP_SIMD_REGS;
> +	}

[Severity: High]
This is a pre-existing issue, but does enabling these capabilities expose a
type confusion bug in software PMUs?

In arch/x86/kernel/perf_regs.c:perf_reg_validate(), the PERF_REG_X86_RESERV=
ED
mask only covers bits 16-31. When simd_enabled is false, this allows a user
requesting extended register bits (>=3D 32) to bypass validation.

When a tracepoint fires, perf_output_sample_regs() passes a raw
stack-allocated pt_regs pointer to perf_reg_value(). The perf_reg_value()
function incorrectly casts it to a larger struct x86_perf_regs using
container_of(), which reads the abi and xmm_regs fields from uninitialized
adjacent stack memory and dereferences them.

Can a user trigger this out-of-bounds stack read by creating a tracepoint or
software PMU event with PERF_SAMPLE_REGS_INTR and requesting extended bits?

> =20
>  	/* PEBS unsupported case (e.g., guest) */
> -	if (!x86_pmu.intel_cap.pebs_format)
> +	if (!x86_pmu.intel_cap.pebs_format) {
>  		dest_pmu->capabilities |=3D PERF_PMU_CAP_EXTENDED_REGS;
> +		if (x86_pmu.ext_regs_mask > XFEATURE_MASK_SSE)

[Severity: Low]
Is it safe to use a strictly greater-than operator here?

If a new feature using bit 0 is ever added to ext_regs_mask, the mask
value would become 3. The condition 3 > 2 evaluates to true, incorrectly
enabling PERF_PMU_CAP_SIMD_REGS even if no SIMD extended features are
supported.

Could this use a bitwise comparison like (mask & ~XFEATURE_MASK_SSE) !=3D 0
instead?

> +			dest_pmu->capabilities |=3D PERF_PMU_CAP_SIMD_REGS;
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706015439.3040=
804-1-dapeng1.mi@linux.intel.com?part=3D22
