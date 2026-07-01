Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888EB22A817
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879326; cv=none; b=Q4ZjKFcbSsab2BjqX/N7hJ47LrJ4XWxE3wvfs6plXeXpLMwMFePqRXQUeI++X8NIIj4hOtP+l9inKwxbtTXVGRRb8FRWcljhF4HqPuq+Gt4X4GgsRWuVLpXob2GCyy90e6WJ8Coid2DyLi/oSXOWoljN29iQMd813rZ0bbBtQt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879326; c=relaxed/simple;
	bh=NuiSsETeO2vG3ljhr7hGniPRSA/kIVmu4fj2TwveGZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f9y9Z1IZgznUwNdBz48uW9gg0Cz/l4xpQnTt+F28yTbMWd75Cvgs8q702GreBsCEB8WkIsw+m3f9kPwamVXBcYMBYGhcu2+mPhq1z5v/d9gFUcyHeCAxVXJ8XVGJ83z+21wxGYqqxBFHYM3ryFIIdXjmRpyGofZWJGAlhx/rTQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAOPoyPb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAOPoyPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585EF1F000E9;
	Wed,  1 Jul 2026 04:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782879317;
	bh=UfbZHIvF+Z9gk8lK2mrVIayci3WMQeQUnKjIqYVBAAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OAOPoyPblobLxqq9oK9P/HEGyWfCDHxxvIxqbU/jg1dr60NrwyLLIcjoduf8SUhYy
	 VVdZfExg4wNE0RLLX/HOuOw+Wbcy3ZTR79vIajk6qbMeLtI90kLgP5IIvhTVzV6sU9
	 PtXhbEuD0E6vdt/XNhmqWi83zTy3N+JcB27a08lDOrAGhOnCo1F++BHXBCJgckBSdY
	 iiTAP4qb2OYDphUlTkta0EruXspnyhAbsmDTC795rcWInF4MG/rie6Vfdwje7/ROqJ
	 d5KJWpCkR5jIk0aYs+tZ2LoOQWI4w69Hz2XpJI7yOMGB0oOcy56zlby36pkl4mBV3O
	 pWSV53evl2Jiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/21] perf annotate-arm64: Support 'adrp'
 instruction to track global variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-20-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-20-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:15:16 +0000
Message-Id: <20260701041517.585EF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Stale `type` field in register state causes `TSR_KIND_GLOBAL_ADD=
R` to be corrupted across stack spills.
--

commit ddfb698eef878cf476210d72e082d8b79c811ecd
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support 'adrp' instruction to track global variables

This patch extends update_insn_state() for arm64 to track global variable
types calculated via page-relative addressing. It introduces
TSR_KIND_GLOBAL_ADDR to represent the partial page-aligned target address
produced by adrp instructions. The address is later combined with the offset
from a subsequent add or ldr instruction to resolve the variable's type.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 1fed188117192..6f96e75d313dd 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> @@ -656,8 +700,37 @@ static void update_add_insn_state(struct type_state =
*state,
>  	}
>  }
> =20
> +static void update_adrp_insn_state(struct type_state *state,
> +				   struct disasm_line *dl,
> +				   struct annotated_op_loc *dst)
> +{
> +	struct type_state_reg *tsr;
> +	u32 insn_offset =3D dl->al.offset;
> +	int dreg =3D dst->reg1;
> +
> +	if (!has_reg_type(state, dreg))
> +		return;
> +
> +	tsr =3D &state->regs[dreg];
> +	tsr->copied_from =3D -1;
> +
> +	if (!dl->ops.source.addr) {
> +		invalidate_reg_state(tsr);
> +		return;
> +	}
> +
> +	tsr->kind =3D TSR_KIND_GLOBAL_ADDR;
> +	/* Partial page-relative address, finalized in next 'add/ldr' */
> +	tsr->addr =3D dl->ops.source.addr;
> +	tsr->offset =3D 0;
> +	tsr->ok =3D true;

[Severity: Medium]
Does this leave tsr->type containing a stale Dwarf_Die?

If the register previously held a structure or union type, the type field
isn't cleared here when switching to TSR_KIND_GLOBAL_ADDR.

If this register is later spilled to the stack, set_stack_state() will
evaluate the stale type_die. Since the type_die tag is DW_TAG_structure_typ=
e,
it will erroneously set stack->compound =3D true.

When the register is loaded back via ldr, update_load_insn_state() will then
branch into the compound type handling (die_get_member_type()) instead of
restoring the TSR_KIND_GLOBAL_ADDR state.=20

Could this destroy the tracking state and cause perf annotate to fail resol=
ving
the global variable's type?

> +
> +	pr_debug_dtp("adrp [%x] global addr=3D%#"PRIx64" -> reg%d\n",
> +		     insn_offset, tsr->addr, dreg);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D19
