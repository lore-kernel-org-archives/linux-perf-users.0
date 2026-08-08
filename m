Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC793B2FC7
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786195555; cv=none; b=tNASIIKFI2WyuFC/lRcxFdUUxlxvUJJ+mNz/MBI36Gbt/JapTzwca/Gfwcy1GQxd0v8quE3xMQjGmsGjnYiZtyYfihDvn2c2iB62BKUjuv2UqHH57rOcwL3+4ooz70OaQj1AM+WSio8SsAMUt0akXl3Om7rH7g66aYCqlAzXEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786195555; c=relaxed/simple;
	bh=R5SEogExJDFNsKwU6ZxROWdrjNvkjWtRg8pE1NTKXhs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A+7JKxl2gvA3GFdSBgHanY1kL6JlGhNUQHn9279L4TA9diJjmA/z15qjHjWCGsatWlCaN6dfHDyi5XlGG7mba0ztX/ivMVb+LpzPNiqhtCKaE1RDsxHa5+p5yx2HiQ821rvHriH4AG3dC6ahPXUpi2TQSpZFnlNG6LHfyfcaZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KO+rOSs+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO+rOSs+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524351F000E9;
	Sat,  8 Aug 2026 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786195552;
	bh=e86b5nkeyQ1HZpg4OxTG8VbQRN2HlrGP88SzfvHNxj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KO+rOSs+CrPqqYTshR/KgrkfnhbuLlGrHYIbqcPIkhiticpA/9J3sJzwkQVS8YTse
	 oEHuBAvaeqsg7aGZSkbhALETrbZfhkqgdikgwscx0fnfDJJbitzLFLJAh6DfMMR+oV
	 Z10Wfk7bBag8KWpJfE3sNYyXcfULGxnN6vGSKUbXhjS7LBuSM/FsjDME/SxTdUloQ8
	 PbN4PpxWcjHZ3HlkiKDHw3tY2vA1RdFLcp7aMfBhXHvfQRtO053Jkh4fPbyPMd63fX
	 SaUk4qxQ2fjfQ3pM7QA+nUOiZiumpDlaRe5YDnk4ZjSMyZfJxtl9Bql8V/8EqO1ux2
	 Oe7MXxgsYWuvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/23] perf annotate-arm64: Support stack variable
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-19-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-19-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:25:51 +0000
Message-Id: <20260808132552.524351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incorrect register mapping and stack state propagation for exclu=
sive store instructions (stxr, stxp).
- [Medium] Failure to invalidate stack state when storing an unknown regist=
er type.
--

--- Patch [18]: [PATCH v4 18/23] perf annotate-arm64: Support stack variabl=
e tracking ---
commit af17741623908e66e62f48c13604a02748d39721
Author: Tengda Wu <wutengda@huaweicloud.com>
Subject: perf annotate-arm64: Support stack variable tracking

Extend update_insn_state() for arm64 to track data types stored on the
stack. This allows 'perf annotate' to maintain type information for
local variables that are spilled to or loaded from stack slots.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index ed0f0ef2877d0..6e09e97072568 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> @@ -498,6 +547,100 @@ static void update_load_insn_state(struct type_stat=
e *state,
>  	goto out_adjust;
>  }
> =20
> +/*
> + * For store insns: propagate type from @sreg to the memory location
> + * referenced by @dreg, applying @reg_offset to the destination memory o=
ffset.
> + */
> +static int propagate_store_reg_state(struct type_state *state,
> +				     struct data_loc_info *dloc,
> +				     struct disasm_line *dl, int sreg, int dreg,
> +				     int reg_offset, const char *insn_name)
> +{
> +	struct type_state_reg *tsr;
> +	u32 insn_offset =3D dl->al.offset;
> +	int fbreg =3D dloc->fbreg;
> +	int fboff =3D 0;
> +
> +	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok)
> +		return -1;

[Severity: Medium]
Will this early return fail to invalidate the stack state when storing an
unknown register type?

If a register without a known type is stored to a stack location that
previously held a known type, this early return appears to bypass stack
invalidation. This would leave stale type information intact for that
stack offset, causing subsequent loads from that slot to erroneously
propagate the old type. While similar logic exists in the x86
implementation, does it need to be corrected here to prevent stale types?

[ ... ]
> +static void update_store_insn_state(struct type_state *state,
> +				    struct data_loc_info *dloc,
> +				    struct disasm_line *dl,
> +				    struct annotated_op_loc *src,
> +				    struct annotated_op_loc *dst)
> +{
> +	int reg_offset =3D get_reg_index_offset(dst);
> +	const char *insn_name =3D src->multi_regs ? "stp" : "str";
> +
> +	/* Handle the first source register */
> +	propagate_store_reg_state(state, dloc, dl, src->reg1, dst->reg1,
> +				  reg_offset, insn_name);
> +
> +	/* Handle the second source register (stp only) */
> +	if (src->multi_regs) {
> +		int reg_size =3D arm64__reg_size(dl->ops.source.raw);
> +
> +		if (reg_size >=3D 0)
> +			propagate_store_reg_state(state, dloc, dl, src->reg2,
> +						  dst->reg1, reg_offset + reg_size,
> +						  insn_name);
> +	}

[Severity: Medium]
Does this logic correctly handle exclusive store instructions like stxr or
stxp?

When the instruction tracker parses arm64 exclusive store instructions, it
appears arm64__check_multi_regs() sets src->multi_regs to true because of
the comma-separated registers.

Would update_store_insn_state() then incorrectly assume the instruction is
stp, and propagate the type of the status register to the base memory
offset, while assigning the true source register to the offset + reg_size?

> +
> +	adjust_reg_index_state(state, dst, insn_name, dl->al.offset);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D18
