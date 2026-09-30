Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3342CAE7
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802674; cv=none; b=GwfcFf3NMF5a85FpmRnln3CUFRF5TCbLDAopl6hhdcmKpGei++F7ZlsobROehVI8JRsuxUPKbSZUDlUIxr2O0wftpSZgqoXvlVifQXjmIouUy6arLjQD0vxeDnbqLgdYD/VzwZycWGbdhExLTOjgICI9xDvKpq2oATq0wIXAwFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802674; c=relaxed/simple;
	bh=y9MKqmaD9DvLSNFZsgYY2c/5Pyu4M7HNtYQFXgYWtMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vx/Usy9DWOs+CcAbU2s5ffDhGHK1sF/Cv6CHnSmkvWznh8u6NLJVvjnSk99bood2G5H+Sp1WjWuqBZPNWvHlBbJGMma7VfXw5z7j/KpJkTuxJbipqTjYLJrQmTFd+OaNCVWuQk61YZ6X8yUyIkgM02z8XoFzR6YCf54ggrwF0tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVqCay0M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVqCay0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A431F000FF;
	Wed, 30 Sep 2026 21:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790802672;
	bh=H9yAGJiHnu5QIbmcOfYsfnFr0jzDzW7NQsQ1t80fsyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVqCay0MATvKBT+Hp+onT5hsvSXiNUSge0bRayKTZKp0OC8raw97QdiC7PheVjpOn
	 l0gBQ6Y+r8U5CiYZQC4T6aCYDGO+iUYiVsTj48eMnxxGuQ+vxUigBCVcBXbtMzvQJ+
	 PDZy9Lw5Ufii+U3jLPWn42xgL+sJZesfjYlMi58seXYsz+S6/OQpadK3yjxDxl0K1o
	 0QpEemHC337bBFhW6MOmO/EtGsfHcDXvYfZjLs1Ag7Yq74Q+/XPADXZfP8FfgJQmms
	 1kVVtq8VVdY4TtNwmOisDkXyKzDXMIDtmXM/fFKL7p0oNTM/Jo/FRDBj0hUt46TZ7n
	 RmOG7dTGMQnTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf annotate: Resolve C++ virtual function
 calls in x86 insn tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930210038.196928-4-yzhao62@ncsu.edu>
References: <20260930210038.196928-1-yzhao62@ncsu.edu>
 <20260930210038.196928-4-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:11:12 +0000
Message-Id: <20260930211112.B2A431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf: cross-platform analysis broken by hardcoded host pointer s=
ize
- [Medium] perf: vtable pointer load ignores multi-register index
--

commit a71181b28893b295ef8ae1558faf7b1c66e3593b
Author: Yanbo Zhao <yzhao62@ncsu.edu>

perf annotate: Resolve C++ virtual function calls in x86 insn tracking

This commit introduces tracking of C++ virtual function calls by resolving
vtable pointer loads and virtual function calls through the vtable in x86
instruction state tracking. It enhances update_insn_state_x86() to handle
TSR_KIND_VTABLE_PTR and TSR_KIND_VFUNC_PTR register states.

> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/ut=
il/annotate-arch/annotate-x86.c
> index 1acf31a2c7597..d21192b74b6bf 100644
> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> +++ b/tools/perf/util/annotate-arch/annotate-x86.c

[ ... ]

> @@ -216,6 +216,29 @@ static void invalidate_reg_state(struct type_state_r=
eg *reg)
>  	reg->copied_from =3D -1;
>  }
> =20
> +/*
> + * Get the return type of the C++ virtual function at the @offset in the
> + * vtable of @class_die.  Returns false if it's not found or the function
> + * returns void.
> + */
> +static bool vtable_get_rettype(Dwarf_Die *class_die, int offset,
> +			       Dwarf_Die *type_die)
> +{
> +	Dwarf_Die func_die;
> +	int index;
> +
> +	if (offset < 0)
> +		return false;
> +
> +	/* TODO: arch-dependent pointer size */
> +	index =3D offset / sizeof(void *);

[Severity: Medium]
Will dividing the target's vtable byte offset by the host's sizeof(void *)
compute an incorrect slot index when analyzing data from an architecture
with a different pointer size?

Relying on host execution details like sizeof(void *) breaks
cross-platform analysis (e.g., analyzing 32-bit x86 perf.data on a
64-bit host).

> +
> +	if (die_find_virtual_func(class_die, index, &func_die) =3D=3D NULL)
> +		return false;
> +
> +	return die_get_real_type(&func_die, type_die) !=3D NULL;
> +}
> +
>  static void update_insn_state_x86(struct type_state *state,

[ ... ]

> @@ -622,13 +669,38 @@ static void update_insn_state_x86(struct type_state=
 *state,
>  			}
>  			pr_debug_type_name(&tsr->type, tsr->kind);
>  		}
> +		/* Load a function pointer from the vtable (for 'call *%reg') */
> +		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
> +			 state->regs[sreg].kind =3D=3D TSR_KIND_VTABLE_PTR &&
> +			 vtable_get_rettype(&state->regs[sreg].type, src->offset,
> +					    &type_die)) {

[Severity: Medium]
Does this query the wrong vtable slot by ignoring the index register when
src->multi_regs is true?

If the operand is an indexed memory reference using multiple registers
(e.g., mov 0x8(%rbx, %rcx, 8), %rax), src->offset contains only the
static displacement part, not the dynamic index. Should this verify
!src->multi_regs before querying the DWARF vtable with src->offset?

> +			tsr->type =3D type_die;
> +			tsr->kind =3D TSR_KIND_VFUNC_PTR;
> +			tsr->offset =3D 0;
> +			tsr->ok =3D true;
> +
> +			pr_debug_dtp("mov [%x] %#x(reg%d) -> reg%d",
> +				     insn_offset, src->offset, sreg, dst->reg1);
> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +		}
>  		/* And then dereference the pointer if it has one */

[ ... ]

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 8a9d3f2eec4dc..e9bf76cc28633 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c

[ ... ]

> @@ -715,8 +723,11 @@ void set_stack_state(struct type_state_stack *stack,=
 int offset, u8 kind,
>  			    Dwarf_Die *type_die, int ptr_offset)
>  {
>  	Dwarf_Word size;
> +	bool is_pointer =3D (kind =3D=3D TSR_KIND_POINTER ||
> +			   kind =3D=3D TSR_KIND_VTABLE_PTR ||
> +			   kind =3D=3D TSR_KIND_VFUNC_PTR);
> =20
> -	if (kind =3D=3D TSR_KIND_POINTER) {
> +	if (is_pointer) {
>  		/* TODO: arch-dependent pointer size */
>  		size =3D sizeof(void *);
>  	}

[Severity: Medium]
Like the vtable_get_rettype() issue above, will hardcoding the host's
pointer size here corrupt the stack state tracking for the target
architecture?

[ ... ]

> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 5478c134e7e3b..5d96ee4c866b6 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c

[ ... ]

> @@ -300,6 +300,11 @@ static int call__parse(const struct arch *arch, stru=
ct ins_operands *ops, struct
>  	if (tok !=3D NULL) {
>  		endptr++;
> =20
> +		/* Save the operand (without '*') to extract register and offset */
> +		ops->target.raw =3D strdup(tok + 1);

[Severity: Low]
This is a pre-existing issue, but this file calls strdup() without
explicitly including <string.h>.

Can we add the explicit <string.h> include? The perf subsystem guide states
that POSIX standard headers should be explicitly included to prevent musl
compilation failures from missing implicit inclusions.

> +		if (ops->target.raw =3D=3D NULL)
> +			return -1;
> +
>  		/* Indirect call can use a non-rip register and offset: callq  *0x8(%r=
bx).
>  		 * Do not parse such instruction.  */
>  		if (strstr(endptr, "(%r") =3D=3D NULL)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930210038.1969=
28-1-yzhao62@ncsu.edu?part=3D3
