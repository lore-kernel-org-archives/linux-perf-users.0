Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2DA365A13
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879292; cv=none; b=cphGevFWnd1ChSrkSLNfhkPEwjnytXppz//pTGHlnqyU5g/liFlWNLf7qstAGzcPnnFCqf/jFqGgtTnGRG8gldWj2W8KSdCJNlcnP0aWex1IifmX1t1GvQKT8RZ6+qpSNzR1hADiLFlevEoxJYC06EgY1oVh0o/nXcvvBIA6gDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879292; c=relaxed/simple;
	bh=Df8NKL/TpJVdIp4feFFMtvuRA104Bis2ygZIs7pEmqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sOX9mvb16VV/FzZCLePaNs3eQqAx7QJOUo14jewuwTq+fPaTBu6czzKYKVS75Xt8YYSE08HIxAY2MceIra5na4JnV8wKoa7ct0UVAvUtGR86vr/nv9+El7Nk3pUTM7vYKBCQu01qET4j6ckFr2NhwEX4a6Fp+GVW58ay3nsSbMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArIgU3Ro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArIgU3Ro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091681F000E9;
	Wed,  1 Jul 2026 04:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782879285;
	bh=7RLjhALOkip1lVVDaMmVUo0K7QOov84owyC2D9LuZRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ArIgU3Ro3x7B7cv4K7NJlWWcCDRwuVwjFCdK6FyF8QnIKMtUj/jM6vYKcv9rh6uiM
	 b4c/wuZCmyefWdnrj/aJIgB+nYSanI4TP3vm23OxP/ocuu31XwvrBoxjIpCA6XeXxv
	 CZ8d893jnsXj40HPeKA4tQqMHrrmn7wm1AuuON2iw5O+w3gIQJEon8zGPuBQ8FdHvf
	 DQb+PjU92/IJWpCyG1qhMscWa9qZ+9ZimgXs8BJhsD4ESoYynYvGwEcJBj39N962XL
	 a/cSIpOygija6yTubi6G5VbRxMwsUw5st+3EbcBijnvQrYAJYiQqQeoR3wOzIPcEyQ
	 z4xsd69njDRpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/21] perf annotate-arm64: Support load instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-15-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-15-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:14:44 +0000
Message-Id: <20260701041445.091681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing invalidation of the destination register on type resolut=
ion failure during load instruction tracking.
- [Medium] The data type profiling logic ignores the second destination reg=
ister of load pair (ldp) instructions, leading to stale state retention.
--

commit 579f01582f34ef50d993c4cb489f025353f8dbcc
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support load instruction tracking

This commit extends update_insn_state_arm64() to handle LDR instructions.
It tracks register state changes when data is loaded from memory to registe=
rs,
supporting signed offset, pre-index, and post-index addressing modes.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 48b1c94273eb6..b48545f35620c 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> +static void update_load_insn_state(struct type_state *state,
> +				   struct disasm_line *dl,
> +				   struct annotated_op_loc *src,
> +				   struct annotated_op_loc *dst)
> +{
> +	struct type_state_reg *tsr;
> +	struct type_state_reg src_tsr;
> +	Dwarf_Die type_die;
> +	u32 insn_offset =3D dl->al.offset;
> +	int reg_offset;
> +	int sreg =3D src->reg1;
> +	int dreg =3D dst->reg1;

[Severity: Medium]
Does this ignore the second destination register for load pair (ldp)
instructions?

If the instruction writes to two destination registers (e.g.,
ldp x0, x1, [x2]), it seems dst->reg2 is not checked or invalidated here,
which could leave it with stale type information. Does the parsing logic in
arm64_ldst__parse() also need to set ops->target.multi_regs for this to be
properly tracked?

> +
> +	if (!has_reg_type(state, dreg))
> +		goto out_adjust;
> +
> +	tsr =3D &state->regs[dreg];
> +	tsr->copied_from =3D -1;
> +
> +retry:
> +	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
> +		invalidate_reg_state(tsr);
> +		return;
> +	}
> +
> +	src_tsr =3D state->regs[sreg];
> +	reg_offset =3D get_reg_index_offset(src);
> +
> +	/* Dereference the pointer if it has one */
> +	if (src_tsr.kind =3D=3D TSR_KIND_TYPE &&
> +	    die_deref_ptr_type(&src_tsr.type,
> +			       src_tsr.offset + reg_offset, &type_die)) {
> +		tsr->type =3D type_die;
> +		tsr->kind =3D TSR_KIND_TYPE;
> +		tsr->offset =3D 0;
> +		tsr->ok =3D true;
> +
> +		if (src->multi_regs) {
> +			pr_debug_dtp("ldr [%x] %#x(reg%d, reg%d) -> reg%d",
> +				     insn_offset, reg_offset, src->reg1,
> +				     src->reg2, dreg);
> +		} else {
> +			pr_debug_dtp("ldr [%x] %#x(reg%d) -> reg%d",
> +				     insn_offset, reg_offset, sreg, dreg);
> +		}
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +	}
> +	/* Or try another register if any */
> +	else if (src->multi_regs && src->reg1 !=3D src->reg2 && sreg !=3D src->=
reg2) {
> +		sreg =3D src->reg2;
> +		goto retry;
> +	}

[Severity: Medium]
If the type resolution fails and execution bypasses both of these if/else
blocks, it falls through to out_adjust.

Should the destination register be invalidated here?

It looks like tsr->ok could remain true from its previous state, leaving it
with incorrect type information.

> +
> +out_adjust:
> +	adjust_reg_index_state(state, src, "ldr", insn_offset);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D14
