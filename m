Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B35D3CAA55
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899853; cv=none; b=tP0lD5kmDiQsOQI+LD4vMyMCOHCznpRAYLrW3K1JZfQuRyyD/wQR2cb9VsG4SvM5QqrgT8xZA01tb2yVFnIEIEVaijP5uO2Jsp6HQGwZ1+YzBPo8hUkAlEJWKQlY/3caB/QS49tFIkq0XTKq02SBxK4/MZ398oG8c1CJUL3lHiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899853; c=relaxed/simple;
	bh=/Vq5ChmRsKXmYVGzQl5C1kKLDXczGps5OigbDDDIaBk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XhWinD7PMEHd+LQ+VIz3XjpG6GdCDhwvD5UCgf6iRWwjY5PwsYdoy4+1Ypx8zXeF9FIchvUnVWuNAC13gRKr6Iu00q3S6lugLce4FFbosXbzbwxIhS5rKlcwvcKsmghcMHz2XpiplxBlj7CNlztnT83JbDMTBlOwPPyLgcubjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6VdI3sf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6VdI3sf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3271F000FF;
	Tue, 13 Oct 2026 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899852;
	bh=cNg3hlWZ0B622z9La+HfkOOMFyjGkaNu/1dA+1aNYdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k6VdI3sfv1jJfwDF8trpvylLKYWmoJtehw6na97wFra35ti3QSZi4BM7uylPUv2xD
	 O1a/fFDxs23ELqXYL+coDO5ZQaqrzxmW/EhMZU1SorKYRzH8rLeu0tyRFQHw1bTDgk
	 x1/6EWWmGzeuoxAIc/y8+vUfVRyC8FTVF2ldvs9LwnMQDtWOluW/hcWSrGI3LUJOUZ
	 cq/1+Ypin3Pz+9YgEcpwstfu+80wzoS96jkroUNCnbobn9Tpo4MOSNFXOD88BYUvzj
	 r7Xx2Z1PecrtTYE8uBRSQfILazP1fCUGpUasq5oxB+hXHUCxUremXjxDQZLSBOE9Ee
	 OR0Np3/Bs8WKQ==
Message-ID: <sashiko-outbox-169874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/15] perf annotate-arm64: Support 'adrp'
 instruction to track global variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b4fd436fc48e085ae95e06f0cc41107b99a62df7.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <b4fd436fc48e085ae95e06f0cc41107b99a62df7.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:57:31 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: Stale DWARF lifetime metadata preserved in update_adrp_ins=
n_state
--

commit e2010b4bef31520f5bbfd7a86530f7efd90eacaa
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support 'adrp' instruction to track global variables

Extend update_insn_state_arm64() to track global variable types calculated
via page-relative addressing by introducing TSR_KIND_GLOBAL_ADDR.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index e27ba26f3b8ab..f34b944dd285d 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> @@ -945,6 +974,39 @@ static void update_add_insn_state(struct type_state =
*state,
>  	invalidate_reg_state(tsr);
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
> +	/*
> +	 * Stores a partial page-relative address. The full absolute address
> +	 * of the global variable will be resolved when a subsequent 'add' or
> +	 * 'ldr' instruction consumes this register.
> +	 */
> +	tsr->imm_value =3D dl->ops.source.addr;
> +	tsr->offset =3D 0;
> +	tsr->ok =3D true;

[Severity: Medium]
When assigning the new state to the target register, does this code leak
stale DWARF lifetime metadata?

If the register was previously tracking a local variable with an active DWA=
RF
lifetime, the new global address state inherits this stale metadata because
lifetime_active and lifetime_end are not cleared.

When a subsequent function call instruction is encountered, caller-saved
registers are incorrectly preserved if the stale metadata evaluates to true=
 for
reg->lifetime_active and call_addr < reg->lifetime_end. This can poison type
propagation if the register is accidentally reused in subsequent instructio=
ns.

Should invalidate_reg_state() be called before assigning the new state, or
should the lifetime fields be manually cleared?

> +
> +	pr_debug_dtp("adrp [%x] global addr=3D%#"PRIx64" -> reg%d\n",
> +		     insn_offset, tsr->imm_value, dreg);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D13
