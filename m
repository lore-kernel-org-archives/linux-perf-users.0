Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507010;
	b=j6EjbWXrPvGREJrIx2t/bFcL85M1aqh3AS/aEWLsJ0vCEvYSZ8TqQiFm29iryhimgqAm
	 +UvxfwfVXZwFZs+uVzAHaUKrn+IDZeIm6knuXA8qpQ6NxXeNt3RnsXLp+LTBr/i0Ll4Xh
	 SIK28GsQVw/g9+0ddwqu+6sKm2NgIYpg9WLNwmPMLu2GrRLq1cfAUHPIpRkf9sQ/EUrbk
	 1FGfbRgj7sS2YVL0ASZCJQOSCjOZemcyyDkdeU+x1j2A4E6M4ZOGzZUJi9xASvV2Lg/Dy
	 QcYQcuaYxwW2GYDfbXL8uvW8t+jeDewxCFJitvkH8EbAVY7jBq8eu1xRLN/Y2uYKwvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507010;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oHTMAbSWIJI4Zt/X9LmU8+AQqistdFpW3mH0+siWvag=;
	b=3IsP46A65uZcUzFVz9NwtccBW/Swjh13GWvfyMUQo3oIIFUH8d3d4b3XJdUL8UoaEROf
	 urauEO3lmn0La6OF3LSDgsUwOYs8KdXXIkoajtdkLlYBapkVPWF+qN/fPW+rnowgNjZEc
	 /ibaqjeABVWdp8iqdKskU5MmsapUVsk9ykyOqkywRxz1ImBfmuE+kimUmqSXjXkcLO4lP
	 zyEJ+E2VP2Euul3TnJlo+6fBPcZHGm6fMcG0hqVu6eAYdyUxTvzoaXxmNZQUANSy4Rxzj
	 oCZVtP8jAgyKOEyAXoEaXp3F49hSxJlFoCl76yZrf775izZ1AIHW1lR5SR9PaukhOGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkzWgggi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5E606A31A
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkzWgggi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A12F1F000C6;
	Tue, 20 Oct 2026 14:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792507009;
	bh=oHTMAbSWIJI4Zt/X9LmU8+AQqistdFpW3mH0+siWvag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hkzWgggi0JQuOSmrf+c+iSGPG7l2qhXTfyzbgqWOSFtczz30+B25XcdcxFgjtqYhE
	 5jq52WSWXnzJaWwoCXdOt083Gn0j/lus2DImci84NW5WQX2wSLI0sMemejWYaVYcay
	 Y3Y1RhwUQAXWpz2ZGASKLukw9jnkOoXlLMNzoM+n1PY/OVDfcBJBRI98aFmXQrQbM6
	 60iaz2kEh3htX5V2FRH92q/ENBk7cyCr0ohKglABo9wIPoUl9fXgS8aeGul+bBPFhW
	 zXnuOgiRdPyUTrbywHD3HGtcQ7wygQsAcWY4Wk/b3efB/W2qmHYa1eDCvEN7bJZkxQ
	 IUPbdJyIBS+sQ==
Message-ID: <sashiko-outbox-179159@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/15] perf annotate-arm64: Support load instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a6085b6f08ba2ed533208ebe9227968770cd58ca.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <a6085b6f08ba2ed533208ebe9227968770cd58ca.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:36:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf annotate-arm64: unused type_die in propagate_load_reg_state=
()
- [Medium] perf annotate-arm64: missing reg2 extraction in ldp when reg1 is=
 xzr/wzr
--

commit d4331cee155820a433821da388de2a7297699e0e
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support load instruction tracking

This commit extends update_insn_state_arm64() to track register state
changes across standard load and load-pair instructions, including
pre-index and post-index addressing modes.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index c4cc8bca85cc0..0b5d1abbc5755 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -527,11 +527,212 @@ static void invalidate_unhandled_insn_regs(struct =
type_state *state,
>  	/* TODO: Extend invalidation support to more special instructions. */
>  }
> =20
> +static int arm64__reg_size(const char *reg)
> +{
> +	if (!reg || !*reg || !arm64__is_reg(reg))
> +		return -1;
> +
> +	if (reg[0] =3D=3D 'w')
> +		return 4;
> +
> +	if (reg[0] =3D=3D 'x' || !strncmp(reg, "sp", 2))
> +		return 8;
> +
> +	return -1;
> +}

[ ... ]

> +static int propagate_load_reg_state(struct type_state *state,
> +				    struct data_loc_info *dloc,
> +				    struct disasm_line *dl, int dreg,
> +				    struct annotated_op_loc *src,
> +				    struct type_state_reg **src_states,
> +				    int mem_spacing)
> +{
> +	struct type_state_reg *tsr;
> +	struct type_state_reg *src_tsr =3D src_states[0];
> +	Dwarf_Die type_die;
> +	u32 insn_offset =3D dl->al.offset;
> +	int sreg =3D src->reg1;
> +	int reg_offset;
> +
> +	if (!has_reg_type(state, dreg))
> +		return -1;
> +
> +	tsr =3D &state->regs[dreg];
> +	tsr->copied_from =3D -1;
> +	tsr->lifetime_active =3D false;
> +	tsr->lifetime_end =3D 0;
> +
> +retry:
> +	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offse=
t))
> +		goto load_non_regoff;
> +
> +	reg_offset +=3D mem_spacing;
> +
> +	if (!src_tsr || !src_tsr->ok)
> +		return -1;
> +
> +	/* Dereference the pointer if it has one */
> +	if (src_tsr->kind =3D=3D TSR_KIND_TYPE &&
> +	    die_deref_ptr_type(&src_tsr->type,
> +			       src_tsr->offset + reg_offset, &type_die)) {
> +		tsr->type =3D type_die;
> +		tsr->kind =3D TSR_KIND_TYPE;
> +		tsr->offset =3D 0;
> +		tsr->ok =3D true;
> +
> +		pr_debug_dtp("%s [%x] %#x(reg%d) -> reg%d",
> +			     dl->ins.name, insn_offset, reg_offset, sreg, dreg);
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +		return 0;
> +	}
> +
> +	/* Handle dereference of TSR_KIND_POINTER registers */
> +	if (src_tsr->kind =3D=3D TSR_KIND_POINTER &&
> +	    die_get_member_type(&src_tsr->type,
> +				src_tsr->offset + reg_offset, &type_die)) {
> +		tsr->type =3D src_tsr->type;
> +		tsr->kind =3D TSR_KIND_TYPE;
> +		tsr->offset =3D src_tsr->offset + reg_offset;

[Severity: Medium]
Should tsr->type be assigned type_die and tsr->offset set to 0 here?

When DWARF describes a struct variable via a register-based memory
location (where var->is_reg_var_addr is true), update_var_state() sets
the base register to TSR_KIND_POINTER with reg->type set to the struct
DIE.

When a load instruction reads a member from that struct into dreg,
update_insn_state_arm64() -> update_load_insn_state() ->
propagate_load_reg_state() calls die_get_member_type() to resolve the
loaded member's type into type_die.

However, type_die is left unused, and tsr->type is set to src_tsr->type
(the outer struct DIE) with tsr->offset set to src_tsr->offset +
reg_offset and tsr->kind set to TSR_KIND_TYPE. When a subsequent
instruction dereferences dreg, check_matching_type() or
die_deref_ptr_type() inspects dreg->type, sees the outer struct type
instead of the member's pointer type, and fails with PERF_TMR_NO_POINTER.

> +		tsr->imm_value =3D 0;
> +		tsr->ok =3D true;
> +
> +		pr_debug_dtp("%s [%x] addr %#x(reg%d) -> reg%d",
> +			     dl->ins.name, insn_offset, reg_offset, sreg, dreg);
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +		return 0;
> +	}
> +
> +load_non_regoff:
> +	/* Try another register if any */
> +	if (src->multi_regs && src->reg1 !=3D src->reg2 && sreg !=3D src->reg2 =
&&
> +	    !(src->extend_type || src->shift_type)) {
> +		sreg =3D src->reg2;
> +		src_tsr =3D src_states[1];
> +		goto retry;
> +	}
> +
> +	return -1;
> +}
> +
> +static void update_load_insn_state(struct type_state *state,
> +				   struct data_loc_info *dloc,
> +				   struct disasm_line *dl,
> +				   struct annotated_op_loc *src,
> +				   struct annotated_op_loc *dst)
> +{
> +	struct type_state_reg snapshots[2];
> +	struct type_state_reg *src_states[2] =3D {};
> +	int mem_spacing =3D 0;
> +
> +	if (!src->mem_ref ||  /* exclude PC-relative loads */
> +	    !has_reg_type(state, src->reg1)) {
> +		/* Invalidate tracked destination registers */
> +		if (has_reg_type(state, dst->reg1))
> +			invalidate_reg_state(&state->regs[dst->reg1]);
> +		if (dst->multi_regs && has_reg_type(state, dst->reg2))
> +			invalidate_reg_state(&state->regs[dst->reg2]);
> +		goto out_adjust;
> +	}
> +
> +	/*
> +	 * Snapshot source register states before updating destination register=
s.
> +	 * This preserves the original source state for aliased loads (e.g.,
> +	 * ldp x0, x1, [x0]), where updating the first destination may overwrite
> +	 * the source register.
> +	 */
> +	snapshots[0] =3D state->regs[src->reg1];
> +	src_states[0] =3D &snapshots[0];
> +	if (src->multi_regs && has_reg_type(state, src->reg2)) {
> +		snapshots[1] =3D state->regs[src->reg2];
> +		src_states[1] =3D &snapshots[1];
> +	}
> +
> +	/* Handle the first destination register */
> +	if (has_reg_type(state, dst->reg1)) {
> +		if (propagate_load_reg_state(state, dloc, dl, dst->reg1,
> +					     src, src_states, mem_spacing))
> +			invalidate_reg_state(&state->regs[dst->reg1]);
> +	}
> +
> +	if (!dst->multi_regs || !has_reg_type(state, dst->reg2))
> +		goto out_adjust;

[Severity: Medium]
What happens here when an ldp instruction uses the zero register (xzr or
wzr) as its first destination operand, such as "ldp xzr, x19, [sp], #16"
or "ldp xzr, x1, [x0]"?

In update_load_insn_state(), dst->reg1 is guarded by has_reg_type(state,
dst->reg1) without returning early, and arm64__reg_size() recognizes
xzr/wzr via arm64__is_reg() so dst->reg2 can still be updated or
invalidated.

However, when update_insn_state_arm64() calls
annotate_get_insn_location() -> extract_op_location_arm64(),
arch__dwarf_regnum() returns -1 for xzr and wzr, and
extract_op_location_arm64() returns before parsing reg2:

tools/perf/util/annotate-arch/annotate-arm64.c:extract_op_location_arm64() {
	...
	/* Extract the primary register */
	op_loc->reg1 =3D arch__dwarf_regnum(arch, s);
	if (op_loc->reg1 =3D=3D -1)
		return;

	s =3D next_operand_field(s);
	if (s =3D=3D NULL)
		return;

	/* Extract secondary register or immediate offset */
	if (op_loc->multi_regs) {
		op_loc->reg2 =3D arch__dwarf_regnum(arch, s);
	...
}

Doesn't this leave dst->reg2 as -1, causing update_load_insn_state() (and
invalidate_unhandled_insn_regs()) to skip the second register instead of
propagating its type or invalidating its previous state?

> +
> +	/* Handle the second destination register */
> +	if (!strcmp(dl->ins.name, "ldpsw"))
> +		mem_spacing =3D 4;  /* ldpsw loads two 32-bit signed words (4-byte spa=
cing) */
> +	else
> +		mem_spacing =3D arm64__reg_size(dl->ops.target.raw);
> +
> +	if (mem_spacing < 0 ||
> +	    propagate_load_reg_state(state, dloc, dl, dst->reg2,
> +				     src, src_states, mem_spacing))
> +		invalidate_reg_state(&state->regs[dst->reg2]);
> +
> +out_adjust:
> +	adjust_reg_index_state(state, dloc, dl, src);
> +}

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D5
