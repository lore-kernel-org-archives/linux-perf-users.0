Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CFD3BADBC
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044577; cv=none; b=NaVn5LMDKmCdeb7350Zs5/iOi7aMEmWWBi3UYUq4bs1qNq5Lw5w81NaVvpqrBX2sxsl/yL4GskzFFw/padYw9ei/+24PZf1FMxA7rObxjYDnuOq5Ga/eblmm0yU2uUdDxhmnp6reY7sGq3Aft0GANzVNYy2QMoPZPZW8RCkBoYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044577; c=relaxed/simple;
	bh=nBadDP8XRwvngRIIJJnll9bqqn9p5BblwPxiL68QvTU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rVP2njen7nkWPllFkvfME6uP8RYY/VuqHnVgEMmXISxQyheubvx2tda8H7tqkrm8cVHHDXqUNz94VAy3XU2Zic7Ei8fHZX+EX/+5Bc4F4LhulLPdDY2+g6jD1tcgmbGctAcG4/sSUZUgD47cRjFeUpWEC5Sy7X7/CY4vBQi52/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLLaPKPp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLLaPKPp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73AE1F00893;
	Fri, 29 May 2026 08:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780044576;
	bh=3KfibRGY2fJyCZA0lC0pyhWcFEXNRT0gKe42YqkdddM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aLLaPKPpz3Qi8Q5Ofqlg8KZD8dKix/UF/L0ZgDX6HKg1mbENJqDm7bTcvPOIqEWSo
	 YI3UVqmkc7S+tcKdT+7CC7GQk/Sjp8V9WHjXmrVi0QpU12HdhuroEiPMuUxU2MTWU4
	 Zlv274gbqouzrBDfKecKWyeTblc9i5mIlMFLpvGOggjAgh0uFSIj7y27LmptvEiQgr
	 98mKU3o060+exvMy1Fwt66IfRWFzecPZBS43oxLlRKTZHDa5K4ldbwX+VekqyiUptE
	 kiDg5SG3R6bH23bzfjbrlIglap9E18lD7f5B/TcHG+yOC8nIcJdAGPQQ90gPrbdCta
	 gdNnAXtRQ42YQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 13/23] perf/x86: Support XMM sampling using
 sample_simd_vec_reg_* fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-14-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-14-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 08:49:35 +0000
Message-Id: <20260529084935.C73AE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The validation logic in `perf_simd_reg_validate()` strictly ch=
ecks unused, flag-gated syscall parameters outside of their respective flag=
 scopes, breaking ABI compatibility.
--

commit aeb4cf15401ade404bfd333c1c769dd23251abf8
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Support XMM sampling using sample_simd_vec_reg_* fields

This patch adds support for sampling XMM registers using the new
sample_simd_vec_reg_* fields. It introduces ABI tracking for perf_regs
on x86 and implements validation logic for SIMD registers.

> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index 81204cb7f7239..7b9b38c189de2 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
[ ... ]
> @@ -74,6 +77,71 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
[ ... ]
> +int perf_simd_reg_validate(u16 simd_enabled, u16 vec_qwords,
> +			   u64 vec_mask_intr, u64 vec_mask_user,
> +			   u16 pred_qwords, u32 pred_mask_intr,
> +			   u32 pred_mask_user)
> +{
> +	u64 size;
> +
> +	if (!simd_enabled) {
> +		if (vec_qwords || vec_mask_intr || vec_mask_user ||
> +		    pred_qwords || pred_mask_intr || pred_mask_user)
> +			return -EINVAL;

[Severity: Critical]
Are we unconditionally validating syscall parameters outside their flag sco=
pes
here?

If userspace sets PERF_SAMPLE_REGS_USER but does not set
PERF_SAMPLE_REGS_INTR, the vec_mask_intr and pred_mask_intr parameters
could contain uninitialized stack garbage. Because userspace is not required
to zero-fill unused arguments, returning -EINVAL for garbage in these unused
masks could break ABI compatibility for programs recompiled against newer
kernel headers.

> +		return 0;
> +	}
> +
> +	if (!vec_qwords) {
> +		if (vec_mask_intr || vec_mask_user)
> +			return -EINVAL;
> +	} else {
> +		if (vec_qwords !=3D PERF_X86_XMM_QWORDS)
> +			return -EINVAL;
> +		if ((!vec_mask_intr && !vec_mask_user) ||
> +		    (vec_mask_intr & ~PERF_X86_SIMD_VEC_MASK) ||
> +		    (vec_mask_user & ~PERF_X86_SIMD_VEC_MASK))
> +			return -EINVAL;

[Severity: Critical]
Similarly, could checking these masks cause false -EINVAL errors
if only one of the sampling flags (INTR or USER) is enabled?

If PERF_SAMPLE_REGS_USER is enabled but PERF_SAMPLE_REGS_INTR is disabled,
vec_mask_intr might contain random bits that fail the PERF_X86_SIMD_VEC_MASK
check. Should these validation checks be gated behind the presence of their
respective flags in the sample_type to prevent regressions?

> +	}
> +
> +	if (pred_qwords || pred_mask_intr || pred_mask_user)
> +		return -EINVAL;
> +
> +	size =3D ((vec_qwords * hweight64(vec_mask_intr)) +
> +		(vec_qwords * hweight64(vec_mask_user)) +
> +		(pred_qwords * hweight32(pred_mask_intr)) +
> +		(pred_qwords * hweight32(pred_mask_user))) * sizeof(u64);
> +	if (size > U16_MAX)
> +		return -EINVAL;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D13
