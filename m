Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122C37B40A
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786195226; cv=none; b=Evsmbq0Km7Cfgln59uxqbGxNzA6k+KvOysHvi6J7C958gacnY6j4U/lg2EMRm9CI59+WHNhJCfWMOwERq10a9xz6krd4PWaflnkAOYrVZLzw9tKGxLvvkGlqpuhfXF5ibj/HTtgB4Tx5DVnDL/5DAXZUNqiZqRFaTFcVllejMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786195226; c=relaxed/simple;
	bh=61cNJ7Bv/TNIl6/KdmsePma5n/JqbBx/HLll16EaVXI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N1APHMsIFSZALwnISvckD1leAfwW11FGXS5GF3vakBpULXlJSL2HrXG7vzUiPT6g7cbiSkoXOjoNBtKrPBvWvm6qqOSj7svxcC7BDPBDm8X2AQEq+volI2QnpcoJKjO9FeQnKteEGRGlTuGujdhoToTBHX7g17brgXzk1pHMGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TneBVA1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TneBVA1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515831F000E9;
	Sat,  8 Aug 2026 13:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786195225;
	bh=+LsKehzvpwimXYROogUFl6vKw6fEnjxL3EzmS4/4RNA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TneBVA1ZbZlPxpxkulh3/7l6Ys104ujPPl6SEBr78Srut0RIcYeRd0mupHDtasGHj
	 /S2j9vbd2nIYfn5eBrArDk0yS2S3FvbkAjAJukVG+HsmRudxfMPwDI99BgfAfH3sRX
	 +pRrjl5ymE6M7ViQYxGwuoGX1aDcqpB8gbGKuAQq2X7LU+116F7u8JrzLjj8DVb6J5
	 Mxh/578duyfHTm07g0NiIX0Kxv9BrMXnUui6e1yQB00geWwMbloxMdZ70HHWn1M7N7
	 XvC5ednhiKzMq0I1scQKReAoRPQOUkXXospWNZh/9yYJY1ToJ0Nl+KMGMCeQ2U5O8y
	 vXeVUUmAbTvFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/23] perf annotate-arm64: Support 'mov' instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-20-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-20-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:20:24 +0000
Message-Id: <20260808132025.515831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Conservative register invalidation incorrectly drops data types =
for comparison instructions like 'cmp', 'cmn', 'tst', and 'teq'.
- [Medium] Missing DWARF register lifetime propagation and clearing in ARM6=
4 `mov` instruction tracking.
--

--- Patch [19]: [PATCH v4 19/23] perf annotate-arm64: Support 'mov' instruc=
tion tracking ---
commit 16c512fdcea449b7238a3bf5f1a3afbffde8144e
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support 'mov' instruction tracking

Extend update_insn_state() for arm64 to support register-to-register and
immediate-to-register 'mov' instructions. This propagates data types and
constant values to improve subsequent instruction inference.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 6e09e97072568..7b780bad8c070 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> +static void update_mov_insn_state(struct type_state *state,
> +				  struct disasm_line *dl,
> +				  struct annotated_op_loc *src,
> +				  struct annotated_op_loc *dst)
> +{
> +	struct type_state_reg *tsr;
> +	u32 insn_offset =3D dl->al.offset;
> +	int sreg =3D src->reg1;
> +	int dreg =3D dst->reg1;
> +
> +	if (!has_reg_type(state, dreg))
> +		return;
> +
> +	tsr =3D &state->regs[dreg];
> +	tsr->copied_from =3D -1;
> +
> +	if (src->imm) {
> +		tsr->kind =3D TSR_KIND_CONST;
> +		tsr->imm_value =3D src->offset;
> +		tsr->offset =3D 0;
> +		tsr->ok =3D true;

[Severity: Medium]
Does this code need to clear lifetime_active for the destination register?

If an immediate value overwrites a register, failing to clear lifetime_acti=
ve
might incorrectly protect the new constant from being invalidated across
function calls.

> +
> +		pr_debug_dtp("mov [%x] imm=3D%#"PRIx64" -> reg%d\n",
> +			     insn_offset, tsr->imm_value, dreg);
> +		return;
> +	}
> +
> +	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
> +		invalidate_reg_state(tsr);
> +		return;
> +	}
> +
> +	tsr->type =3D state->regs[sreg].type;
> +	tsr->kind =3D state->regs[sreg].kind;
> +	tsr->imm_value =3D state->regs[sreg].imm_value;
> +	tsr->offset =3D state->regs[sreg].offset;
> +	tsr->ok =3D state->regs[sreg].ok;

[Severity: Medium]
Does this code miss propagating the DWARF register lifetime?

If lifetime_active is not propagated from state->regs[sreg] to tsr during a
register-to-register move, a valid type state might be prematurely invalida=
ted
across function calls.

> +
> +	if (tsr->kind =3D=3D TSR_KIND_TYPE || tsr->kind =3D=3D TSR_KIND_POINTER)
> +		tsr->copied_from =3D sreg;
> +
> +	pr_debug_dtp("mov [%x] reg%d -> reg%d", insn_offset, sreg, dreg);
> +	pr_debug_type_name(&tsr->type, tsr->kind);
> +}

[ ... ]

> @@ -703,6 +750,7 @@ static void update_insn_state_arm64(struct type_state=
 *state,
>  	 * prevent stale type info from propagating to subsequent instructions.
>  	 */
>  	if (has_reg_type(state, dst->reg1) &&
> +	    strcmp(dl->ins.name, "mov") &&
>  	    strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {
>  		pr_debug_dtp("%s [%x] invalidate reg%d",
>  			     dl->ins.name, insn_offset, dst->reg1);
>  		invalidate_reg_state(&state->regs[dst->reg1]);

[Severity: Medium]
Does this conservative register invalidation incorrectly drop data types for
comparison instructions like cmp, cmn, tst, and teq?

Because comparison instructions are not explicitly exempted alongside mov,
ld, and st, their first operand (which can be parsed as a target register)
will be unconditionally invalidated. This causes data type profiling to
silently fail for subsequent uses of a register after it's checked with a
comparison instruction.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D19
