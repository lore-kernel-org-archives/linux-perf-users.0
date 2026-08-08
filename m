Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BEB3F54C5
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194881; cv=none; b=lFGmKmI5bJbvp2LKle6wmNGTKWoqMVscbnSrcswixUZRi6nibzuH7drzPGEFfV5Sy7HRiOgRXQ9gLZq2fvyY2btCyFQfPXXXoKaf+9SIwjB0FLHYjOAc4eArTKDJIpFisiL3IGwgKZ4UpbvCQ0Gn0CWtIpVyJzg4IcVHFuUsSfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194881; c=relaxed/simple;
	bh=8ywxNSw25EbeWCc8u8PliXLHbiZ9L4ktVQW4JNM5xdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=axjuiN/MzweN0dJUDhU3wG9bAXSHK02MwEuvTlKWvXgRY6aZhYvNY6/IJSylDAodEncWULwbnrSgz18H91OE17fxpOxWpfbiB+3sEk66YA1FneA1iYsu3Ngw+YWQbw+FRCv4d4BO7qBpKsbqF8QetruMZ0YjZMUDcoDhODuz51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCBlQ0tI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCBlQ0tI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446831F000E9;
	Sat,  8 Aug 2026 13:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786194880;
	bh=QkQ5Py3cHdzAyk0M0GlLMaHVMWVWHOUFH2njPuNshd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lCBlQ0tItuzS+aeavDldO1s1D4QzpkkgRGXNrJnft3ZuLhxgSs8Hui5+uknoVd6zf
	 FxtuulSkF8GomTEqgnYiBQezRXjfHcWG+Qqj7tsX12qphQL0v3ndtdhg6S59MU66kg
	 iWZnzqETHH6yP9HAYiHjAtNaNnRoerumRrFsbKQHXxUmpGPGyVoQ4hSSzPUbvS5CWX
	 oA5tCPsnjChZZX86BxHJwtwiEw2awytm1Mbl+bnMJ9BOwd15mNGpcAt8cBl42SrXj8
	 k4BpSNauGZMwpw+WJ0WvHERv4kj7ugfUfwZEr6CUgl/fNNUGABclsgQynchOs4Q7+o
	 7RFUIqlOBiGcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 20/23] perf annotate-arm64: Support 'add' instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-21-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-21-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:14:39 +0000
Message-Id: <20260808131440.446831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing state invalidation when adding a non-constant dynamic vari=
able to a pointer causes the type tracker to silently assume an offset of 0.
- [High] Incorrect offset calculation for scaled ADD instructions due to ig=
nored shift and extend modifiers.
- [Medium] Pointer type tracking is dropped for commutative ADD instruction=
s when the first operand is a constant, due to a premature early return.
--

--- Patch [20]: [PATCH v4 20/23] perf annotate-arm64: Support 'add' instruc=
tion tracking ---
commit 8c78c99c0185c9b7a385f10b087f345530162939
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support 'add' instruction tracking

Extend update_insn_state() for arm64 to track 'add' instructions for
structure member address calculation.

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/ut=
il/annotate-arch/annotate-arm64.c
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> +static void update_add_insn_state(struct type_state *state,
> +				  struct disasm_line *dl,
> +				  struct annotated_op_loc *src,
> +				  struct annotated_op_loc *dst)
> +{

[ ... ]

> +	/*
> +	 * Handle 'add' instructions of the form:
> +	 *   add  dreg, base, #offset     (immediate offset)
> +	 *   add  dreg, base, reg2        (reg2 holds a constant)
> +	 *
> +	 * For case 2, retrieve the constant value from reg2
> +	 * and use it as the offset.
> +	 */
> +	imm_value =3D src->offset;
> +	if (src->multi_regs) {
> +		int reg2 =3D (sreg =3D=3D src->reg1) ? src->reg2 : src->reg1;
> +
> +		if (!has_reg_type(state, reg2) || !state->regs[reg2].ok) {
> +			/* Unable to resolve type for dst, bail out */
> +			invalidate_reg_state(tsr);
> +			return;
> +		}
> +		if (state->regs[reg2].kind =3D=3D TSR_KIND_CONST)
> +			imm_value =3D state->regs[reg2].imm_value;
> +	}

[Severity: High]
If reg2 is dynamic (not TSR_KIND_CONST), does this code fail to invalidate
the destination tracking state?

It looks like imm_value will silently remain set to its previous value=20
(src->offset), which could cause the type tracker to assume an incorrect
offset of 0 instead of properly invalidating the tracking state.

[Severity: High]
Does this offset calculation ignore shift and extend modifiers for scaled
ADD instructions?

For example, if the instruction is "add x0, x1, x2, LSL #3", it appears we
will add the unscaled raw imm_value of reg2 to the struct offset, mapping
subsequent memory accesses to the wrong struct field or array index.

> +
> +	if (src_tsr.kind =3D=3D TSR_KIND_CONST) {
> +		tsr->kind =3D src_tsr.kind;
> +		tsr->imm_value =3D src_tsr.imm_value + imm_value;
> +		tsr->offset =3D 0;
> +		tsr->ok =3D src_tsr.ok;
> +
> +		pr_debug_dtp("add [%x] imm %#"PRIx64"(reg%d) -> reg%d\n",
> +			     insn_offset, imm_value, sreg, dreg);
> +		return;
> +	}

[Severity: Medium]
For commutative ADD instructions where the first operand is a constant,
does this early return drop the pointer type tracking?

If the instruction is "add rd, const_reg, ptr_reg", it looks like sreg will
evaluate to TSR_KIND_CONST and trigger this return before the pointer
register (ptr_reg) can be evaluated via the "goto retry" logic below.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D20
