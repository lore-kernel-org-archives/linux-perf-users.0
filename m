Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D613815F0
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777086494; cv=none; b=SJvLU5Qf9eok51sbYvrSkuJKCWgPZG4GQ6Z1Oksod/yj7EYtFhkRBp/tS+42l9l8wRobPj/jHQiCN3cgfDzGzwwKCuXTnL9tmXf9RC7GDD3yv+MDfgUJpVa4L6nJIfc7DCQLHgGGnAcwX1P9J5rFDGIAJ65HDUN2MMQxRz4enTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777086494; c=relaxed/simple;
	bh=GGuXdeTY232yrjGJNzR+eVkDw/g3Ix2RIlFb47SIo2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OSwrAW9GJkEw7JLeb8ds6Uxs/gSnWaxNOFxtF6XfxRyp2lGkUal7eXoELdu1R1V8sLgrEULKDG1m/3qgCWN536psRHJi/NTqUZfFZnWZd8FWwIA/Pc6txLiIbjrQIC/Ve2B8IGsLw3RfwDDtbKvxAxqejstTrAXB6GNdGZsQJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTrSKnbQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTrSKnbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A75EC19425;
	Sat, 25 Apr 2026 03:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777086494;
	bh=GGuXdeTY232yrjGJNzR+eVkDw/g3Ix2RIlFb47SIo2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gTrSKnbQHSgd0kDvGkC4kks6sHgWdh2gduuyRn/Xxa9TBqXjvH0vt4XJqwqhLvZ4D
	 NCizH+982LY7igV5gU1jQD/PGjSSsVdltoyK3WYMUj2ihX7Vpe6JVFomd/R06t1trj
	 4cIj9Z4iMZnCaKuuR6s2dfxNuZwve69svxB3/w7oeam7XP7uz0ZMnm11M929VjqTM8
	 zOzrlYm1rpRr1MLWfqrDEFhuWlPRumFPT6nWx1i8yqN/MUhZwm5hZ5Q974mdeZxJwr
	 O/YhnR2Cs8XgrKe/cm3L88NGKPZ8J1c7EAx7Syyx5o4NZWZ/jEiEDn5oJdMGAuk2I3
	 cvGCH1YoqRYBw==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 22/24] perf/x86/intel: Enable arch-PEBS based
 SIMD/eGPRs/SSP sampling
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260324004118.3772171-23-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-23-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 03:08:13 +0000
Message-Id: <20260425030814.0A75EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Leaking stale per-CPU FPU/extended register state to user spac=
e when a PEBS event triggers in kernel mode and requests PERF_SAMPLE_REGS_U=
SER.
- [High] Incorrect bitwise AND with a raw u64 bitmask in `intel_pebs_suppor=
t_regs` permanently disables large PEBS for XMM registers on arch-PEBS plat=
forms.
--

commit 7ad07fe08e2e0b394952e6f0ccf5f040f99870e3
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Enable arch-PEBS based SIMD/eGPRs/SSP sampling

This patch enables arch-PEBS based SIMD/eGPRs/SSP registers sampling
using the XSAVE-Enabled Registers (XER) group.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 3d64f28b7e9ac..b280a39f68bca 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

[ ... ]

> @@ -4416,6 +4431,34 @@ static void intel_pebs_aliases_skl(struct perf_eve=
nt *event)
>  	return intel_pebs_aliases_precdist(event);
>  }
> =20
> +static inline bool intel_pebs_support_regs(struct perf_event *event, u64=
 regs)
> +{
> +	struct arch_pebs_cap cap =3D hybrid(event->pmu, arch_pebs_cap);
> +	int pebs_format =3D x86_pmu.intel_cap.pebs_format;
> +	bool supported =3D true;
> +
> +	/* SSP */
> +	if (regs & PEBS_DATACFG_GP)
> +		supported &=3D x86_pmu.arch_pebs && (ARCH_PEBS_GPR & cap.caps);
> +	if (regs & PEBS_DATACFG_XMMS) {
> +		supported &=3D x86_pmu.arch_pebs ?
> +			     ARCH_PEBS_VECR_XMM & cap.caps :
> +			     pebs_format > 3 && x86_pmu.intel_cap.pebs_baseline;
> +	}

Will this permanently disable large PEBS for XMM registers?

Because supported is a boolean (initially 1), ARCH_PEBS_VECR_XMM & cap.caps
evaluates to BIT_ULL(49). The bitwise AND operation 1 &=3D 0x2000000000000U=
LL
strictly yields 0.

Should this bitmask be normalized to a boolean value, perhaps using
!!(ARCH_PEBS_VECR_XMM & cap.caps) inside the ternary operator?

[ ... ]

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 560f178d7ac92..61d72c58f9a25 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c

[ ... ]

> @@ -2708,15 +2719,69 @@ static void setup_arch_pebs_sample_data(struct pe=
rf_event *event,
>  					   meminfo->tsx_tuning, ax);
>  	}
> =20
> -	if (header->xmm) {
> +	if (header->xmm || header->ymmh || header->egpr ||
> +	    header->opmask || header->zmmh || header->h16zmm) {
> +		struct arch_pebs_xer_header *xer_header =3D next_record;
>  		struct pebs_xmm *xmm;
> +		struct ymmh_struct *ymmh;
> +		struct avx_512_zmm_uppers_state *zmmh;
> +		struct avx_512_hi16_state *h16zmm;
> +		struct avx_512_opmask_state *opmask;
> +		struct apx_state *egpr;
> =20
>  		next_record +=3D sizeof(struct arch_pebs_xer_header);
> =20
> -		ignore_mask |=3D XFEATURE_MASK_SSE;
> -		xmm =3D next_record;
> -		perf_regs->xmm_regs =3D xmm->xmm;
> -		next_record =3D xmm + 1;
> +		if (header->xmm) {
> +			ignore_mask |=3D XFEATURE_MASK_SSE;
> +			xmm =3D next_record;
> +			/*
> +			 * Only output XMM regs to user space when arch-PEBS
> +			 * really writes data into xstate area.
> +			 */
> +			if (xer_header->xstate & XFEATURE_MASK_SSE)
> +				perf_regs->xmm_regs =3D xmm->xmm;
> +			next_record =3D xmm + 1;
> +		}

Is it possible for this code to leak stale per-CPU FPU/extended register
state to user space?

When a PEBS event triggers in kernel mode and requests PERF_SAMPLE_REGS_USE=
R,
this code processes the PEBS data and sets the corresponding bits
(e.g., XFEATURE_MASK_SSE) in ignore_mask. It then calls
x86_pmu_setup_regs_data(), which assigns data->regs_user.regs to the
static per-CPU x86_user_regs.

If x86_user_regs is never fully cleared, its extended register pointers
(like xmm_regs) still point to the per-CPU ext_regs_buf from prior samples.
Because XFEATURE_MASK_SSE is excluded via ignore_mask, xsaves_nmi() and
x86_pmu_update_xregs() skip updating x86_user_regs.xmm_regs.

Consequently, the xmm_regs pointer remains pointing to the stale data in
ext_regs_buf. When the perf core outputs the user registers, could it
read the stale FPU state from ext_regs_buf and leak it across processes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324004118.3772=
171-1-dapeng1.mi@linux.intel.com?part=3D22
