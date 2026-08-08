Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0A2BFC60
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786195129; cv=none; b=Sr3dQZ5a4IFgL7WzgRKthPxoRWvOvUWuPbYHxhUikT0hYSEa4wG3TAJpVk8rhveS58CvYAfVIMFttjBL5NCEts2BBIiqsiUmhxETO/2afPMfLUVeyTDB2WzKJ8QEYAxjMKNFCiarOVZf1CD+nBRjA713WQxaMHf8pjiWRvL0yq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786195129; c=relaxed/simple;
	bh=WGQOwcGqKhajaw3B/CZ6WSjJxjIln50c+fPKFkVhe/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FlHh7FaFFiU2kNwso1gy0WhAa8P1TIhxRrxNVLa/BpShkT5rWAV7OVugvCpy+Fp3rQZwyLqiwJCplDTndWvb2ayHiym/IJ1m6x4bEBaX7pxdlxp38c0JALbGp7NGPV9/pHqoDE9USzoKvLc+b9fnQ5G3OV29ACEhpc+L9ZjfX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9Hn/+zm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9Hn/+zm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DEF1F000E9;
	Sat,  8 Aug 2026 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786195128;
	bh=pq4AUd+mlwwcA8xd8GfFjC+ttw8a7Ar+nLvWI+g//Qw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O9Hn/+zm65dmuLgWBMRFuXbpqtHKuSMh+UMMNfDEinu2tQKyHKuMsII+Mij8glQuJ
	 y8ecI5jcmRX2evW47EBvGNExnrlElwbXw1Bkyu1rgLaDrP+FtDrpDHv0/R+39Y1Qnp
	 q5Nr6idzfK8a1YBj1CsXeyOYzMH00flwMQVF/iSRIow98s0ljGSFfMbIzTBTnWQwK8
	 QUCnK9c1nvbpfSH7v5Um2xg4BjWZfy7p2G3hELfl3BGImcWQF+s7LccclFHuCW1LBE
	 1dfTfYsee4Xl9DQRdsyOBn2JEKpNWncj2G8ZzkrMWSQmgisIshs5V1eCUkLNA4OUpA
	 86zk9CGcpH2mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 22/23] perf annotate-arm64: Support per-cpu variable
 access tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-23-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-23-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:18:47 +0000
Message-Id: <20260808131848.43DEF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete offset calculation for multi-register memory operands=
 causes inaccurate type resolution.
--

--- Patch [22]: [PATCH v4 22/23] perf annotate-arm64: Support per-cpu varia=
ble access tracking ---
commit d7e10ade80ba3983e6d311e1ab11f19b4af2d53e
Author: Tengda Wu <wutengda@huaweicloud.com>
Subject: perf annotate-arm64: Support per-cpu variable access tracking

This commit extends update_insn_state() for arm64 to handle per-cpu variable
addressing. It identifies per-cpu base initialization and propagates type
information to subsequent instructions. This allows the tracker to correctly
resolve the actual variable type in per-cpu flows.

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 7fe5b979563f7..8b0584486cce9 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1253,11 +1253,33 @@ static enum type_match_result check_matching_type=
(struct type_state *state,
>  	}
> =20
>  	if (state->regs[reg].kind =3D=3D TSR_KIND_PERCPU_BASE) {
> -		u64 var_addr =3D dloc->op->offset;
> +		u64 var_addr;
>  		int var_offset;

[ ... ]

> +		var_addr =3D dloc->op->offset;
> +
>  		if (dloc->op->multi_regs) {
>  			int reg2 =3D dloc->op->reg2;

[Severity: Medium]
Does the TSR_KIND_GLOBAL_ADDR handling later in check_matching_type() need
similar logic for multi-register operands to ensure accurate type resolutio=
n?

Currently, for TSR_KIND_GLOBAL_ADDR, the logic does not consider multi-regi=
ster
operands:

	if (state->regs[reg].kind =3D=3D TSR_KIND_GLOBAL_ADDR) {
		u64 var_addr =3D state->regs[reg].imm_value + dloc->op->offset;
		int var_offset;

This calculation omits adding state->regs[reg2].imm_value for multi-register
operands, unlike the TSR_KIND_PERCPU_BASE logic in the same function. The
omission also appears to apply to TSR_KIND_TYPE and TSR_KIND_POINTER.

Can this incomplete offset calculation cause incorrect type resolution in
tools/perf/util/annotate-data.c:check_matching_type() when perf processes a
memory instruction where op->multi_regs is true, the primary register is
TSR_KIND_GLOBAL_ADDR (or TYPE/POINTER), and the secondary register is
TSR_KIND_CONST?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D22
