Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8365B38E8B8
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879421; cv=none; b=SeBR/Y8HdvMAbekF5BrTrV22wq5sOAQ9cI98BC1W+IYb+81NClOtq/2fNdi8S8CDyjpeoKerBhSTeVeovxpWwrr5bejcCREtRDNvEv3cFNUPp8Ut6DAIEeit/C5OGRXpivh81fW710eDUtAsE2w0YAApJHO+juDCKzEIxgi8Ono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879421; c=relaxed/simple;
	bh=AzQNsp81hFDN+By5aS+ZE5I1Et0U+H6ZGxU1fhJ/QZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W7ALaa2/YUIZDDePGmrD3I++l30idUkhl8/cNsviNohnvJoKwvPRCjHos3oA/AlHjvS2qyl2KhePhCn4pDjg/KWMpwrytSj2V6vMq9afVGTOpjgm1eSQJQgBWB8xWreiCt5UCxdoL/CQNFWMEa8WI98KCwwc8Uw1j+GO8eSySBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2ONUKiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2ONUKiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6F41F00A3A;
	Wed,  1 Jul 2026 04:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782879414;
	bh=B9Bt+VcYj98u6KiFJXCAq8fK3tR0sTcm8AXcBDwjWcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y2ONUKiKwZfZflpGSnjI+F3264LbJqAYj60hhWKRplkDzZCCKEELjl99DLjq077bp
	 In6y2Zne5Wu6o5PoFMVwmev6zE2Lk51PYAetssDGFmfnzmt1JTVM2Lky3jJoH84lIf
	 aW+LVfAIFywBnwUSqx6x2UOB7my7bFZ7/900iSG69wsquJlyiU5BxWO3Nrm3A3O8CL
	 wFyMZ/PzotddOyh9gJflSwLrH+tsKAfQCPRj6a2SHHc6r0/PGiua1km6qrCvF4ED96
	 F3Nhvqw6b97Ok6PTUgCrJIuraJ4nAkOn4oqi0XtMPtF5ULstxP3CV/mDDtsxVkCK8j
	 QDiLkT0+0yvjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/21] perf annotate-arm64: Support 'add' instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-19-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-19-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:16:53 +0000
Message-Id: <20260701041654.AD6F41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing register invalidation when source registers are known no=
n-pointer types, causing the destination register to incorrectly retain sta=
le type information.
--

commit 5b1d520539dfc4b7d2f19958225cafb067fd8ce1
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support 'add' instruction tracking

Extend update_insn_state() for arm64 to track 'add' instructions for
structure member address calculation, which commonly appear as:

  add  dreg, base, #offset
  add  dreg, base, reg2     (reg2 holds a constant)

For such instructions, determine the final offset value from either the
immediate or the constant in reg2.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index be07a85057c8c..1fed188117192 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> +static void update_add_insn_state(struct type_state *state,
> +				  struct disasm_line *dl,
> +				  struct annotated_op_loc *src,
> +				  struct annotated_op_loc *dst)
> +{
[ ... ]
> +	/* Handle calculation of a register holding a typed pointer */
> +	if (src_tsr.kind =3D=3D TSR_KIND_POINTER ||
> +	    (src_tsr.kind =3D=3D TSR_KIND_TYPE &&
> +	     dwarf_tag(&src_tsr.type) =3D=3D DW_TAG_pointer_type)) {
[ ... ]
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +	}
> +	/* Or try another register if any */
> +	else if (src->multi_regs && src->reg1 !=3D src->reg2 && sreg !=3D src->=
reg2) {
> +		sreg =3D src->reg2;
> +		goto retry;
> +	}
> +}

[Severity: Medium]
When the source registers are not tracked pointers or valid types, the code
falls through the if/else if chain and returns implicitly here without call=
ing
invalidate_reg_state(tsr).

Since update_insn_state_arm64() specifically exempts "add" instructions from
generic register invalidation (as seen below), won't dreg incorrectly retain
its previous stale type information?

[ ... ]
> @@ -589,7 +673,7 @@ static void update_insn_state_arm64(struct type_state=
 *state,
>  	 * the destination register itself to prevent incorrect type propagatio=
n.
>  	 */
>  	if (has_reg_type(state, dst->reg1) &&
> -	    strcmp(dl->ins.name, "mov") &&
> +	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
>  	    strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {
>  		pr_debug_dtp("%s [%x] invalidate reg%d\n",
>  			     dl->ins.name, insn_offset, dst->reg1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D18
