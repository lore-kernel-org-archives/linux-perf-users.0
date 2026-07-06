Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3150429825
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320371; cv=none; b=E15f/l7yDwg1wk5Pg66t401hw6l7nMP0XzdoI3x3qofaFPjKG2aOdDLfJtbKA1eVnK86stSUVldybMOwmThX5x8XVEjTTXQuKJZDrJ1zKJ2TnAFSZa/847Er/SP6Dr2yMhdzYnAHDpOifQAt3TJfn/WRcT2oz1sEa9HpWZiHP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320371; c=relaxed/simple;
	bh=+V7abC0ANRLQsskLQSLJY+vhuVTJzwL5N88DyOSiBBc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p1ALoLvsl5S6LdcZraG7sNfPwYyEG6c78XdwGlmstpRIzQxBp+SkdOvQ51BZVUBNKmDQWOdvG42xXKIFSxJ6sjrVNYz0n/5lXqBvfmEPxA6x01VwjDyXsr/734qUo2NjEqSRcKXfunicWD2/TMk+WWMTz9wq0pwN0J5t62elhEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaubzlue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaubzlue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7BA1F000E9;
	Mon,  6 Jul 2026 06:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783320360;
	bh=bykGrkNlIk0OiLoWbOCLgBumRnHA9JNlwk74gu4Zhlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gaubzlueZXOSKC5aGY8OwvE9YUi9UT3dVDRKBayU6j9MCTouxhOxmlNwNW4qewFYW
	 pBdm0aTGpz5vhVyJr3e8ya5Km0lCHed754wZN68QbG0q6hJTlRV92hHEfSkG7kCmbx
	 4wmpaIoNKeRgCyj03BcKy45xvfsN9ZMwi9Fq7xLmBCVy84JBgMHFUuqUZlI5kBeTHa
	 6NIROA8v5pG6hd0tq9CeuipgnSgHZfSP3t2K80IHK7JBq3ok5soplyCN8rfqmxKEof
	 djTCSO55e0gv2/AI8NWqTyW3gxPFeg/j+bqF59RCLv1+iG3rKCkQxHDIN5QzQuQNMj
	 kXWJy6VgrB8EQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 14/24] perf/x86: Support XMM sampling using
 sample_simd_vec_reg_* fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706015439.3040804-15-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-15-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 06:45:59 +0000
Message-Id: <20260706064600.6D7BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Validation logic unconditionally evaluates flag-gated syscall pa=
rameters (`vec_mask_user`, `pred_mask_user`) without checking their respect=
ive flag gates, leading to validation bypasses due to uninitialized garbage.

Pre-existing issues:
- [Critical] The functions `perf_reg_value` and `perf_simd_reg_value` unsaf=
ely assume the provided `pt_regs *` is always embedded within an `x86_perf_=
regs` structure, leading to out-of-bounds reads and arbitrary pointer deref=
erences for software events and `PERF_SAMPLE_REGS_USER`.
--

commit 9c74aceec4401218b750679a5b08ba8009aa85a3
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Support XMM sampling using sample_simd_vec_reg_* fields

This commit adds support for sampling XMM registers by introducing a new ABI
field and extracting XMM values through the sample_simd_vec_reg_* fields. It
adds a new perf_simd_reg_value function to retrieve the values and updates
the SIMD registration validation logic.

> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index 81204cb7f7239..8514baefb400e 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c

[ ... ]

> @@ -63,6 +63,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
> =20
>  	if (idx >=3D PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
>  		perf_regs =3D container_of(regs, struct x86_perf_regs, regs);
> +		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
> +		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)

[Severity: Critical]
This isn't a bug introduced by this patch, but evaluating perf_regs->abi
here relies on an unsafe cast.

For tracepoints and PERF_SAMPLE_REGS_USER, regs points to a bare pt_regs
instance rather than an embedded x86_perf_regs struct. The container_of()
cast accesses memory outside the bounds of the pt_regs struct.

Could this allow an attacker to control the out-of-bounds pointers (like
xmm_regs) and read arbitrary kernel memory into the perf ring buffer?

> +			return 0;
>  		if (!perf_regs->xmm_regs)
>  			return 0;
>  		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];

[ ... ]

> @@ -74,6 +77,77 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>  	return regs_get_register(regs, pt_regs_offset[idx]);
>  }
> =20
> +u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
> +			u16 qwords_idx, bool pred)
> +{
> +	struct x86_perf_regs *perf_regs =3D
> +			container_of(regs, struct x86_perf_regs, regs);
> +
> +	if (!(perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))

[Severity: Critical]
This is a pre-existing issue, but this new code copies the same unsafe
container_of() cast pattern.

Since regs is not actually embedded in an x86_perf_regs struct when
called for PERF_SAMPLE_REGS_USER, reading perf_regs->abi reads
out-of-bounds memory.

> +		return 0;
> +
> +	if (pred)
> +		return 0;

[ ... ]

> +int perf_simd_reg_validate(u64 sample_type, u16 simd_enabled,
> +			   u16 vec_qwords, u64 vec_mask_intr,
> +			   u64 vec_mask_user, u16 pred_qwords,
> +			   u32 pred_mask_intr, u32 pred_mask_user)
> +{
> +	u64 size =3D 0;
> +
> +	if (!(sample_type &
> +	      (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
> +		return 0;
> +
> +	if (!simd_enabled)
> +		return 0;
> +
> +	if (vec_qwords) {
> +		if (vec_qwords !=3D PERF_X86_XMM_QWORDS)
> +			return -EINVAL;
> +		if (!vec_mask_intr && !vec_mask_user)
> +			return -EINVAL;

[Severity: Medium]
Does this logic evaluate flag-gated parameters without checking their
respective flag gates?

PERF_SAMPLE_REGS_INTR and PERF_SAMPLE_REGS_USER are independent flags. If a
user sets INTR but not USER, vec_mask_user is outside its flag gate and
can contain arbitrary garbage from userspace.

If vec_mask_intr is 0 (an invalid configuration), but the garbage in
vec_mask_user is non-zero, this check passes and the validation is bypassed.

Should these masks be validated against their respective sample_type flags
before checking if they are both empty?

> +		if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
> +		    (vec_mask_intr & ~PERF_X86_SIMD_VEC_MASK))
> +			return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706015439.3040=
804-1-dapeng1.mi@linux.intel.com?part=3D14
