Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707742;
	b=3D2MzolPRg74QGrw2H/CCras/p8LzzEkC56dzvaXOgMV8CIfV+7tNzieaUbGqBXmSfys
	 MHeJfpCy02ETjuO2icP4MO/mhp8RU6y7s8m8/+0KLx1CzvnNd1Z9kLZGBTMyT7BPSySy+
	 MYz9pzMSX4iegMk7rJ99KcfNtJ2HDCpGXTtRFNaQmNUbxg75muZ/T2ICVjsBnQ0ebUmfS
	 ze4Wy0dwgtt97IaZJMomxXbOVBxMoeQFuoTSTmdNqsauUr5Qq7HxppUA3RYVzHB1HK1pK
	 ndEt+RBVKIfEkS3rik1xcaKV6OVEiby0Zh1Z8L/e6mUP/l0rD0UKKxuKVehGb/9UDkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707742;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0ypacaVShcGQu4bRC+h/XF+0l0Eih8bGiUXjKdtGxfA=;
	b=H+S+B+Lfl1Uk84cPdiGd7GHaS0EiE0vtWAvfBxJx5CiVqvvwzQYIhYe2s8wm7jETX5DL
	 aW2Fi+0s4MrUXRGSQl7/Y9F/VKy0SLGl7CRdh4X47m9GpJo9gs55pACXMinDjl3naLxIy
	 YoawP3fhos8TS8GNbZmn3MHEe4602A3nzeaGAn9e79zmki9xkDi3JXSPwQIGPHXQiLLSn
	 dq14MvgoKaWDBTl27ZoYPw3Iwr2X+vslqxfwslF5KEm2yg6Hz+lkJaUwfPou1/aFWKC+m
	 6YSoBFgv6/vMyQpq97mwupP0A/stHEpMH1QDV7JkE1W7H5HRxe/X2CDup+rQCC32F+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=go2BAf8M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C0606A327
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=go2BAf8M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E6C1F000C4;
	Sun, 15 Nov 2026 01:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707741;
	bh=0ypacaVShcGQu4bRC+h/XF+0l0Eih8bGiUXjKdtGxfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=go2BAf8M3ne99fLxGENHSDtGGFd5yLHqKDsaMHzYNYJBMIm8XlOmTABAq3PFEMb+w
	 l2zNMKJTH9B4T191TSjifklFjaGTu13JuZbvPuE+TkK3HpDw53Ec2nDjrRRqPl2eq1
	 uc/5fnMBr3EnHkWUwWNt75YJqD6qLubG852odHODONpd4vqIJYx8FpnejZ1jHroRwK
	 ObHRaiHfH/I/EVU5ZQwEzs9dsAybaz8OJ8pS62jGwAlNeUsAuoniEw3u8T5vxYi3/l
	 q2JS4i/ny9oA7WSsUFxJ1HiG5MbrydTaxGejeCoivSHZTjIJ7MXmcJVgQMzFbSLYMl
	 P2s8KvIq+fAJQ==
Message-ID: <sashiko-outbox-215179@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/12] perf annotate: Handle absolute addressing in
 data type profiling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115014102.2879372-3-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
 <20261115014102.2879372-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 01:55:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf annotate: unhandled zero address in
  __hist_entry__get_data_type()
--

commit 4e70868608c9afc77ab4fffa4bb7f6aa84106803
Author: Arnaldo Carvalho de Melo <acme@kernel.org>

perf annotate: Handle absolute addressing in data type profiling

This commit adds support for bare numeric operands as absolute memory
addresses in x86 data type profiling and guards frame-base register
comparisons in instruction tracking against -1.

> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/ut=
il/annotate-arch/annotate-x86.c
> index e38a4e7a54d55..297f2fe9bec79 100644
> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> +++ b/tools/perf/util/annotate-arch/annotate-x86.c
[ ... ]
> @@ -960,6 +988,11 @@ static void extract_op_location_x86(const struct arc=
h *arch,
>  			op_loc->offset =3D strtol(s + 1, &p, 0);
>  			if (p && p !=3D s + 1)
>  				op_loc->imm =3D true;
> +		} else if (isdigit(*s) && !ins__is_jump(&dl->ins) &&
> +			   !ins__is_call(&dl->ins)) {
> +			/* Absolute address, as used by 32-bit code */
> +			op_loc->mem_ref =3D true;
> +			op_loc->offset =3D strtoull(s, NULL, 0);
>  		}
>  	}
>  }
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 86a4beec6528e..56fffe598634c 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2605,6 +2605,19 @@ int arch__dwarf_regnum(const struct arch *arch, co=
nst char *str)
>  	return reg < 0 ? -1 : reg;
>  }
> =20
> +bool annotated_op_loc__is_abs(const struct annotated_op_loc *op_loc)
> +{
> +	return op_loc->mem_ref && op_loc->reg1 =3D=3D -1 && op_loc->reg2 =3D=3D=
 -1 &&
> +	       op_loc->segment =3D=3D INSN_SEG_NONE && op_loc->offset !=3D 0;
> +}
[ ... ]
> @@ -2894,6 +2907,11 @@ __hist_entry__get_data_type(struct hist_entry *he,=
 const struct arch *arch,
>  			dloc.var_addr =3D annotate_calc_pcrel(ms, dloc.ip,
>  							    op_loc->offset, dl);
>  		}
> +		/* Absolute addressing, as used by 32-bit code */
> +		else if (annotated_op_loc__is_abs(op_loc)) {
> +			dloc.var_addr =3D annotated_op_loc__abs_addr(op_loc, map__dso(ms->map=
));
> +			op_loc->reg1 =3D DWARF_REG_PC;
> +		}
> =20
>  		/* This CPU access in kernel - pretend PC-relative addressing */
>  		if (dso__kernel(map__dso(ms->map)) && arch__is_x86(arch) &&

[Severity: Medium]
Can an unrelocated bare 0x0 operand cause an out-of-bounds read of
state->regs[-1] in check_matching_type()?

extract_op_location_x86() sets op_loc->mem_ref =3D true even when the parsed
address is 0, so the early !op_loc->mem_ref check in
__hist_entry__get_data_type() no longer skips the operand.  Because
annotated_op_loc__is_abs() requires op_loc->offset !=3D 0, op_loc->reg1 is
left as -1 when __hist_entry__get_data_type() calls find_data_type(&dloc).

In find_data_type_die(), is_fbreg =3D (reg =3D=3D fbreg) is unguarded and
matches (-1 =3D=3D -1) when fbreg is -1, and if no scope variable matches,
find_data_type_block() -> find_data_type_insn() -> check_matching_type()
is reached with reg =3D=3D -1:

tools/perf/util/annotate-data.c:check_matching_type() {
    ...
	int reg =3D dloc->op->reg1;
    ...
	pr_debug_dtp("chk [%x] reg%d offset=3D%s%#x ok=3D%d kind=3D%d ",
		     insn_offset, reg, offset_sign, abs(offset),
		     state->regs[reg].ok, state->regs[reg].kind);

	if (!state->regs[reg].ok)
		goto check_non_register;
    ...
check_non_register:
	if (reg =3D=3D dloc->fbreg || reg =3D=3D state->stack_reg) {
    ...
}

This reads state->regs[-1] before struct type_state on the stack (passing
&state->regs[-1].type to DWARF helpers if the adjacent byte is non-zero)
and otherwise matches reg =3D=3D dloc->fbreg (-1 =3D=3D -1) at check_non_re=
gister.

Only setting op_loc->mem_ref =3D true in extract_op_location_x86() when the
parsed offset is non-zero (or skipping mem_ref operands with reg1 =3D=3D -1=
 in
__hist_entry__get_data_type()) would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115014102.2879=
372-1-acme@kernel.org?part=3D2
