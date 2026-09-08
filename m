Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58655C31A
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874035; cv=none; b=qx5yxFhbiFHAPv9XJSgrni1vzuA21DgVmk0NNvmeUfhvhcYggQ/vLKHUxNSM+eC2rKWSMRvHyu7tk2BfDHhVCKYGk+ixPybAmSyJyaB1uulch9mGxa7WOGmT8dpUieslxz/S+/kqpQaJczi/iwsZfe6lJHoxPnJQL0KPAURK1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874035; c=relaxed/simple;
	bh=yWGLmDbAyu6R8BbF1QtCo36vrNZuVr/W6tOSWKGeyH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kegp07RtF7dWxtELDLO+GoAeYBGtd7RPnpnBWO0XgEt4TwN9iON+55fuKqlU8JYshTt40yLlcYrwRo1/ZkRiYdJG/m0cUrtGHM0PQl4lhm+nS2EUi30erxtwfStMg4vDzQVovnp40ADkpKoZkWcd/QkIN3VmCC4RVKjEDXRyrpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQZtxD5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQZtxD5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E341F00A3A;
	Tue,  8 Sep 2026 13:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788874027;
	bh=z8riA5ldvOZOgNrwmFwXxTjCalzDivUUJZUiXYBg9tI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KQZtxD5GrnqcyPwvLGv2LktfCKyCKy99mI807+fdM9VjeJNfEjDV6jeB3UDCGvvb5
	 e8ZO8Mm13PImT1el+ZbclzjIVP0qWeFrUMLpZP4L0mim0sWd3rgG3A7hKNkXwbukM/
	 ZKoDRGCkK5XEK8b6XJWAW6lWgydzlVMv5x/Zjv+Gs5mE9MmQIOlLshx6vFVIJfMzv1
	 6SrPLXXtl2vz8k+/cc6wKKnrNrC1DzXPCIgDK96UlfgYZz8PW790FpF0ICNsWIo2s9
	 DaSyEZva/3uxVVXuf81/ojgVPABUvmavN6lzhtTq0vaWkYP8LjfvrggL5oP3pKYk2S
	 vEMOmqn89Iieg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 22/26] perf annotate-arm64: Support 'mov' instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <6516a18b5618a169c2e180c296632e12c7f6697a.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <6516a18b5618a169c2e180c296632e12c7f6697a.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:27:06 +0000
Message-Id: <20260908132707.00E341F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Destination register's DWARF lifetime state is improperly preser=
ved during register-to-register 'mov' instruction tracking.
--

commit e7b1d4e72b07c94aacdc6e7221ef41f56b7b017c
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support 'mov' instruction tracking

Extend update_insn_state_arm64() to support register-to-register and
immediate-to-register 'mov' instructions. For register-to-register 'mov',
it propagates data type information from the source to the destination.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index d520975c59363..2f8bedf583c1a 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> @@ -810,6 +812,58 @@ static void update_store_insn_state(struct type_stat=
e *state,
>  	adjust_reg_index_state(state, dloc, dl, dst);
>  }
> =20
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

[ ... ]

> +	tsr->type =3D state->regs[sreg].type;
> +	tsr->kind =3D state->regs[sreg].kind;
> +	tsr->imm_value =3D state->regs[sreg].imm_value;
> +	tsr->offset =3D state->regs[sreg].offset;
> +	tsr->ok =3D state->regs[sreg].ok;
> +	/*
> +	 * lifetime_active and lifetime_end represent DWARF variable lifetime
> +	 * ranges tied to the source register. Copying them risks incorrectly
> +	 * invalidating the destination register after a call instruction,
> +	 * so intentionally omit them.
> +	 */

[Severity: Medium]
While avoiding copying the source's lifetime, does this leave the
destination register's existing lifetime values stale?

If the destination register (dreg) previously had an active DWARF lifetime
tracking state (lifetime_active =3D true), those fields are not cleared
here since invalidate_reg_state() isn't called for this valid register
transfer path.

Should lifetime_active be set to false and lifetime_end set to 0?

Otherwise, the destination register might falsely survive caller-saved
register invalidations during subsequent call instructions and corrupt
downstream type inference.

> +
> +	if (tsr->kind =3D=3D TSR_KIND_TYPE || tsr->kind =3D=3D TSR_KIND_POINTER)
> +		tsr->copied_from =3D sreg;
> +
> +	pr_debug_dtp("mov [%x] reg%d -> reg%d", insn_offset, sreg, dreg);
> +	pr_debug_type_name(&tsr->type, tsr->kind);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D22
