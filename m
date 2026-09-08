Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3755C33E
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874103; cv=none; b=o50kS12fE4mt7r65HGslgb6SAY+LlYq8K43PcE+lNK8OhG/HZrbcSFMySIOt58jE8e+kFTMLy+rH4mrIui1P3ERweIGQS1Xa1NzS7iN6FIYnpA6oHVCjiRpyk6W0Ibkud6ApAAZkK7XKIWl8CZ4RHZTWk5h/+tjTf4I1tKiYZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874103; c=relaxed/simple;
	bh=cJuFCJxFq9C1vs3yQjxW0brTYSxHw0EvSUB9xmmwg7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VweHJ5xqtA1BfW9O0zmhKDG2+h/qmsUbzz4LUya7P3a/8lJ9/C8xR6x4XBqbMBJR4ksjJxPVe9i1cY7X5FtqodfHusYJL8wEUc7VNMhGjYZKjxFJUetIYyNEn2TZrDNNcGMecmG7gmSRxwBRe0uoRMA9lZ7NcoOmMD6t2v5SelI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azr2zVwZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Azr2zVwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFEE1F00A3A;
	Tue,  8 Sep 2026 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788874090;
	bh=YTLOcs4qnNfa0y/qhnXuqU8/eGpUaMBYkScLW18qSu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Azr2zVwZS1gdAktYOBSAYf+E+i5i2LEJq/95Hs7kODN/2IjfZg/fOzsyEZxedBKDf
	 IexB/Hh3jQr3J4S920Ozhgzr1+ZUc3si86fMpNwPoVvOjpYkkERsQaRMU29Iadzlum
	 fTK7XKMnjVwgJw/v9AoZCuaKU2+mf0d/rP4YZd/k+w9fR4wkafrg4quAHty4LDPcp6
	 EP1hJWIJMW/eZxFX2Tt2Co+q9YQ+cKKyYfd1dkIx4HuLix2b+1eRnYAH8N6Z2IaFyY
	 o+ogEIP5ez5p0CN73LaaEdLCPf+L3KsnliBfT+RwSnlQb6qW3qL9ottvKrH3GRn+o5
	 eCfuIIn+PyGKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 23/26] perf annotate-arm64: Support 'add' instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f562a5e0bf612867a6ddcde891f1582b4fcf61eb.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <f562a5e0bf612867a6ddcde891f1582b4fcf61eb.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:27:57 +0000
Message-Id: <20260908132810.4DFEE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Failure to clear `lifetime_active` and `lifetime_end` in `update=
_add_insn_state` for the destination register.
--

commit 1ca68e83139c25b5687ab59598c804f32ea92afb
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support 'add' instruction tracking

This commit extends update_insn_state_arm64() to track 'add'
instructions for structure member address calculation. It enables the
data type tracker to follow member address calculations and propagate
types correctly instead of dropping type info on 'add'.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 2f8bedf583c1a..e237b91426849 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -864,6 +864,72 @@ static void update_mov_insn_state(struct type_state =
*state,
>  	pr_debug_type_name(&tsr->type, tsr->kind);
>  }
> =20
> +static void update_add_insn_state(struct type_state *state,
> +				  struct data_loc_info *dloc,
> +				  struct disasm_line *dl,
> +				  struct annotated_op_loc *src,
> +				  struct annotated_op_loc *dst)
> +{
> +	struct type_state_reg *tsr;
> +	struct type_state_reg src_tsr;
> +	u32 insn_offset =3D dl->al.offset;
> +	int sreg =3D src->reg1;
> +	int dreg =3D dst->reg1;
> +	int reg_offset;
> +
> +	if (!has_reg_type(state, dreg))
> +		return;
> +
> +	tsr =3D &state->regs[dreg];
> +	tsr->copied_from =3D -1;

[Severity: Medium]
Does this code need to clear lifetime_active and lifetime_end on the
destination register?

When the add instruction overwrites a destination register that previously
tracked a variable with an active DWARF lifetime, it looks like the stale
DWARF lifetime bounds are incorrectly retained on the destination register.
Could this cause caller-saved registers to incorrectly survive function call
invalidation and corrupt data type tracking during profiling?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D23
