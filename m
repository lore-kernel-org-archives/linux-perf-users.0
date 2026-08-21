Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A8C3F8ED3
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787290014; cv=none; b=ty8SCteAcWeArr42qAqafTIAg2U/KmV7qPbnt8LwHF3KyAXMDmwNDzPJ+H1dxQ4vBc+ye4sAZ4rB/v68p0vyJzZ4PqNlnR7Wu/He0aak2vWE5HNaSRKPBizk2LDgnADJpM0/1BuTHnsGcs10Lj6cEdBC7Q5i33ROW82CoyGBFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787290014; c=relaxed/simple;
	bh=fxYbGiaL4PbBSJD9uPaYI8To2MrnK+r9T16UIVQF24E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tIyOB4v29Y6Upi+85wGQXErn1pCZvae7vW9X/mTkoz+86JPfMGh9HS2s0gg3uGaE2O8jycpqbACjc9jNq/+bFurVN2QpwT+c3+TUfB/9aIxdlbiwaBxuPSCmDseM7rMkKTFLUtkevkinFEfsW8JvU4FAILiq3GUH5au0QRcx2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivxIuyMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivxIuyMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883241F000E9;
	Fri, 21 Aug 2026 05:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787290012;
	bh=Y0PqTicnJv7fgcojn0fzLmDoWBpBmS2W14qKwjINIR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ivxIuyMvT21qpZhaEdsaiHBqx1tfHLIMNvzwBU53cwt5WFSuWVajmU+IkvLLsnaaQ
	 JxsjimTx/w8eBBh07NzBTSZejNaBqEv/L3y8Y5s5QuTQuZyfd3j4spFFB3aMqST5Tr
	 bgJLdSDqQjfdOGLzUfjwdGupv5j6NmVDA7woJroG3E77YfViJdo79sE1IXnPuSZDP0
	 W3TPTV6mfbj0+fAIlmT722X/A9B2qdb+emu4W6tJrSUfvKbB2e7dzxgUxit33f173/
	 Gyiz+FE5RVyZsCS7hV0ZFYDjpqekehCBq2yWYOzaAb0Gl/LaKbBAZXG6Wwtl3wrvJA
	 viLNGi0QpqM6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf disasm & annotate x86: Track C++ vptr and
 resolve virtual function calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821050207.4517-4-yzhao62@ncsu.edu>
References: <20260821050207.4517-1-yzhao62@ncsu.edu>
 <20260821050207.4517-4-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 05:26:52 +0000
Message-Id: <20260821052652.883241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Dead code and conceptually flawed receiver type tracking for C++=
 virtual calls
- [Medium] Indirect calls through registers (e.g., `*%rax`) bypass operand =
extraction logic
- [Medium] Virtual functions returning `void` silently abort receiver track=
ing
--

--- Patch [3]: [PATCH 3/3] perf disasm & annotate x86: Track C++ vptr and r=
esolve virtual function calls ---
commit 5fa55e70aac42c5267a1e3215b8634a1d2a5ae9b
Author: Yanbo Zhao <yzhao62@ncsu.edu>

perf disasm & annotate x86: Track C++ vptr and resolve virtual function cal=
ls

This commit implements disassembler and type profiling support in perf for
C++ virtual dispatch and indirect call resolution on x86. It introduces
tracking for vtable pointers, resolves virtual function calls via DWARF
information, and updates register states for the receiver pointer upon
virtual call resolution.

> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/ut=
il/annotate-arch/annotate-x86.c
> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> +++ b/tools/perf/util/annotate-arch/annotate-x86.c

[ ... ]

> @@ -234,6 +236,11 @@ static void update_insn_state_x86(struct type_state =
*state,
>  		struct symbol *func =3D dl->ops.target.sym;
>  		const char *call_name;
>  		u64 call_addr;
> +		Dwarf_Die target_func_die;
> +		bool resolved_statically =3D false;
> +		Dwarf_Die class_die;
> +		bool has_class_die =3D false;
> +		struct annotated_op_loc *target_op;
> =20
>  		/* Try to resolve the call target name */
>  		if (func)
> @@ -245,12 +252,42 @@ static void update_insn_state_x86(struct type_state=
 *state,
>  		if (call_name && !strcmp(call_name, "__fentry__"))
>  			return;
> =20
> +		/*
> +		 * 1. Resolve target statically (virtual call fallback) FIRST
> +		 * (before invalidation)
> +		 */
> +		target_op =3D &loc.ops[INSN_OP_TARGET];
> +
> +		if (target_op->mem_ref && has_reg_type(state, target_op->reg1)) {
> +			struct type_state_reg *reg =3D &state->regs[target_op->reg1];
> +
> +			if (reg->ok && reg->kind =3D=3D TSR_KIND_VTABLE_PTR) {
> +				/* TODO: handle multiple inheritance (non-primary vtables) */
> +				int vtable_index =3D target_op->offset / 8;
> +				Dwarf_Die target_class_die =3D reg->type;
> +
> +				if (die_find_virtual_func(&target_class_die, vtable_index,
> +							  &target_func_die) &&
> +				    die_get_type(&target_func_die, &type_die)) {

[Severity: Medium]
Will die_get_type() return NULL for virtual functions returning void since
they lack a DW_AT_type attribute?

If it returns NULL, it seems this would leave resolved_statically as false =
and
completely bypass the subsequent block that tracks the receiver's C++ class
type.

> +					resolved_statically =3D true;
> +					class_die =3D target_class_die;
> +					has_class_die =3D true;
> +				}
> +			}
> +		}

[ ... ]

> -		/* Invalidate caller-saved registers after call */
> +		/* 2. Invalidate caller-saved registers after we read them for resolut=
ion */
>  		call_addr =3D map__rip_2objdump(dloc->ms->map,
>  					      dloc->ms->sym->start + dl->al.offset);
>  		for (unsigned i =3D 0; i < ARRAY_SIZE(state->regs); i++) {
> @@ -264,8 +301,8 @@ static void update_insn_state_x86(struct type_state *=
state,
>  			invalidate_reg_state(reg);
>  		}

[ ... ]

> @@ -275,6 +312,20 @@ static void update_insn_state_x86(struct type_state =
*state,
>  			pr_debug_dtp("call [%x] return -> reg%d",
>  				     insn_offset, state->ret_reg);
>  			pr_debug_type_name(&type_die, tsr->kind);
> +
> +			/* Update receiver ('this' pointer) register if C++ */
> +			if (has_class_die && cu_is_cplusplus(cu_die)) {
> +				struct type_state_reg *recv_tsr =3D &state->regs[state->arg0_reg];
> +
> +				if (recv_tsr->ok &&
> +				    (recv_tsr->kind =3D=3D TSR_KIND_TYPE ||
> +				     recv_tsr->kind =3D=3D TSR_KIND_POINTER)) {

[Severity: Medium]
Is it possible for recv_tsr->ok to be true here?

Since arg0_reg (%rdi) is a caller-saved register, the loop right before this
block unconditionally invalidates all caller-saved registers, setting reg->=
ok
to false. This appears to make the condition structurally impossible to mee=
t.

Additionally, does it make sense to update the receiver type of a caller-sa=
ved
register after the call? Since the callee could have clobbered it per the A=
BI,
wouldn't the tool end up tracking a garbage value instead of the 'this'
pointer?

> +					recv_tsr->type =3D class_die;
> +					pr_debug_dtp("call [%x] update receiver reg%d to C++ class",
> +						     insn_offset, state->arg0_reg);
> +					pr_debug_type_name(&class_die, recv_tsr->kind);
> +				}
> +			}
>  		}
>  		return;
>  	}

[ ... ]

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2486,6 +2486,10 @@ static int extract_reg_offset(const struct arch *a=
rch, const char *str,
>  	if (arch->objdump.register_char =3D=3D 0)
>  		return -1;
> =20
> +	/* Skip leading '*' for indirect call/jmp operands (e.g. *%rax) */
> +	if (*str =3D=3D '*')
> +		str++;
> +

[Severity: Medium]
Is this logic reachable for direct register indirect calls like *%rax?

Looking at annotate_get_insn_location() where this gets called:

	} else if (strchr(insn_str, arch->objdump.memory_ref_char)) {
		op_loc->mem_ref =3D true;
		op_loc->multi_regs =3D multi_regs;
		extract_reg_offset(arch, insn_str, op_loc);
	} else {

Since *%rax lacks a memory reference character (like '('), it seems it
would bypass extract_reg_offset() entirely and fall into the else block.
This would fail to track the target register type because the '*' prefix
is not expected by the fallback code.

>  	/*
>  	 * It should start from offset, but it's possible to skip 0
>  	 * in the asm.  So 0(%rax) should be same as (%rax).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821050207.4517=
-1-yzhao62@ncsu.edu?part=3D3
