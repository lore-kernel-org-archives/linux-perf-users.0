Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A4413797
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194534; cv=none; b=SkTutWT2RpCmezfS2WbcE9/34BSysp2CIw6NaXwUDWUYUOXCBz1CaV+DIbeiaZMs3q0daSGCwk3J54K0uGcr7digaBTcQRPCikInmKbf7bbKHXGwiJT5qB55AIKs5Pi/EtOtb2nybRnG6SAc+YLTpXh1a5mcWniCTYrz3Bmz6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194534; c=relaxed/simple;
	bh=YHW6dfgfllfonm6Y+FsRJZCAnVu571rI8r0xRBqjD1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lEftkaJ0N0xShJ4T71dWMMBpJmo5yF8NGtXKZta0cBFWKcm22hEbt5pmsgzQzbbVnZv44t6s7CBQWgNNrMZort9wejLPtWmQWoCoLjHrNUKeMhM+0LmCSy6ZVo3J3d/nwZJWC59cWOc73iwHOugRtb8E8AYKKeg27HuNKFTMm9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0HRZshO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0HRZshO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500291F000E9;
	Sat,  8 Aug 2026 13:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786194529;
	bh=hK5gm46EtdH41t+WfCHQZplWAhUkvYHHP3I7LV2kCKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0HRZshO4AG6mMmkE3FVtNDuxRj51onEl9b80pAAIcNBaYyPVXHRYh41prJOUSFI+
	 IZSdDESSYGpgnFnB/87Zr3qBOOj+3EKFxFaSXuM5OYye0s0QJkpn430zQDm7R9DoRA
	 lTJqqUArstpxE9kcMUdyzssHMbNPxra59SDILWCY/B62DVcs4/Rox/8Mcg4JW1LuV3
	 5dl7lONq73ClZR+L9PlTDcMhC8ZFkLJti4YReneLppiJ3sk4iFGwlapIVqISu7s+fD
	 B49ZpPYRFw+ooIi2zD6KXUjnr/8c27rIkdNzubkFTDUg1qxTxxN2zzR04HwsnDoaIL
	 VEyu2LOUeijWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/23] perf annotate-arm64: Support load instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-15-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-15-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:08:48 +0000
Message-Id: <20260808130849.500291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] `update_load_insn_state` incorrectly uses the newly loaded type =
as the base pointer for the second register in `ldp` instructions when the =
base register overlaps with the first destination register (e.g., `ldp x0, =
x1, [x0]`).
- [Medium] `update_insn_state_arm64` blindly invalidates the base pointer t=
ype state for store instructions because it fails to check `!dst->mem_ref` =
before invalidating `dst->reg1` for non-load instructions.
- [Medium] Incorrect memory offset calculation for the second register in `=
LDPSW` (Load Pair of Signed Words) instructions due to reliance on the dest=
ination register prefix for size calculation.
- [Medium] Incomplete register recognition in `arm64__is_reg()` prevents pr=
ocessing or defensive invalidation of the second destination register in `l=
dp` instructions involving zero registers (`xzr`) or SIMD registers.
- [Medium] `arm64_ldst__parse` incorrectly parses PC-relative memory loads =
if an end-of-line comment contains a bracket (`[`), improperly interpreting=
 the comment as the memory operand.
--

--- Patch [14]: [PATCH v4 14/23] perf annotate-arm64: Support load instruct=
ion tracking ---
commit d3c58ddf95c5da043aecdd1f99723182e79fd318
Author: Tengda Wu <wutengda@huaweicloud.com>
Subject: perf annotate-arm64: Support load instruction tracking

This commit extends update_insn_state_arm64() to handle LDR and LDP
instructions. It tracks register state changes when data is loaded from
memory into registers by propagating the data type of the base register
to the destination register, handling various addressing modes.

> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -358,11 +358,152 @@ static int extract_op_location_arm64(const struct =
arch *arch,
>  }
> =20
>  #ifdef HAVE_LIBDW_SUPPORT
> +static int arm64__reg_size(const char *reg)
> +{
> +	if (!reg || !*reg || !arm64__is_reg(reg))

[Severity: Medium]
Since arm64__is_reg() does not recognize zero registers like xzr or SIMD
registers, can this cause us to incorrectly skip processing the second
destination register in ldp instructions?

If the first register is unrecognized (for example, in ldp xzr, x19, [sp]),
arm64__check_multi_regs() might evaluate multi_regs to false. This would
cause update_load_insn_state() to skip the second register entirely, leaving
its stale type state intact.

> +		return -1;

[ ... ]

> +static void update_load_insn_state(struct type_state *state,
> +				   struct disasm_line *dl,
> +				   struct annotated_op_loc *src,
> +				   struct annotated_op_loc *dst)
> +{
> +	int reg_offset =3D get_reg_index_offset(src);
> +	const char *insn_name =3D dst->multi_regs ? "ldp" : "ldr";
> +
> +	if (!has_reg_type(state, dst->reg1) ||
> +	    (dst->multi_regs && !has_reg_type(state, dst->reg2)))
> +		goto out_err_adjust;
> +
> +	/* Handle the first destination register */
> +	if (propagate_load_reg_state(state, dl, dst->reg1, src,
> +				     reg_offset, insn_name))
> +		goto out_err_adjust;

[Severity: Medium]
Can this inadvertently corrupt the type tracking state when the base regist=
er
and the first destination register overlap?

If we process an instruction like ldp x0, x1, [x0], the first call to
propagate_load_reg_state() updates state->regs[dst->reg1] (which is x0).

When the second call to propagate_load_reg_state() runs for the second
destination register:

	if (dst->multi_regs) {
		int reg_size =3D arm64__reg_size(dl->ops.target.raw);
		...
		propagate_load_reg_state(state, dl, dst->reg2, src,

it will read from src->reg1 (which is also x0). Because the state for x0
was already overwritten in the first call, the second call would use the
newly loaded type as the base pointer instead of the original base pointer
type.

> +
> +	/* Handle the second destination register (ldp only) */
> +	if (dst->multi_regs) {
> +		int reg_size =3D arm64__reg_size(dl->ops.target.raw);

[Severity: Medium]
Does arm64__reg_size() return the correct memory offset for ldpsw
instructions?

For a Load Pair of Signed Words (ldpsw), the instruction loads two 32-bit
values from memory into 64-bit registers. Using arm64__reg_size() on the
destination register (which starts with 'x') returns 8, but the memory
spacing should be 4 bytes.=20

This would result in passing reg_offset + 8 instead of reg_offset + 4 to
propagate_load_reg_state() for the second register, leading to an incorrect
struct field offset lookup.

> +
> +		if (reg_size < 0 ||
> +		    propagate_load_reg_state(state, dl, dst->reg2, src,
> +					     reg_offset + reg_size, insn_name))
> +			goto out_err_adjust;
> +	}

[ ... ]

> @@ -418,7 +559,8 @@ static void update_insn_state_arm64(struct type_state=
 *state,
>  	 * Invalidate destination register(s) for unsupported instructions to
>  	 * prevent stale type info from propagating to subsequent instructions.
>  	 */
> -	if (has_reg_type(state, dst->reg1)) {
> +	if (has_reg_type(state, dst->reg1) &&
> +	    strncmp(dl->ins.name, "ld", 2)) {

[Severity: Medium]
Should we check if the destination is actually a memory reference before
invalidating the register?

For store instructions (like str x0, [x1, #16]), arm64_ldst__parse() revers=
es
the operands so that dst becomes the memory operand and dst->reg1 is the
base pointer (x1).=20

By unconditionally invalidating dst->reg1 for any instruction that doesn't
start with "ld", we would erroneously destroy the type state of the base
pointer used in the store.

>  		pr_debug_dtp("%s [%x] invalidate reg%d",
>  			     dl->ins.name, insn_offset, dst->reg1);
>  		invalidate_reg_state(&state->regs[dst->reg1]);

[ ... ]

> +	/* Memory to register transfers */
> +	if (!strncmp(dl->ins.name, "ld", 2))
> +		update_load_insn_state(state, dl, src, dst);
>  }
>  #endif

[Severity: Medium]
Could PC-relative memory loads end up with missing operands here if their
end-of-line comments contain a bracket?

In arm64_ldst__parse(), which runs before we reach this point, strchr()
searches for a bracket. If a PC-relative load lacks brackets in its operands
but contains one in the comment (for example, ldr x0, 1234 <sym> // [foo]),
the parser matches the comment bracket and parses backwards.

This drops the actual PC-relative target entirely, which would prevent
update_load_insn_state() from successfully tracking the type when evaluated
here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D14
