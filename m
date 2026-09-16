Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692419644B
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523522; cv=none; b=pNfpXcDilgAfVEcmk8VuM6CKPojtbPcqY5/0OGqJ3TtvMxX1g3fJ0zUFI+s55QpHymBUoJ/zV7lget9XwzIGO0rQcS8i/lUOusmeRSgU2FQcWs9IZvgbFkMBEvun3dXSy+7UcqKlVGFtpLCaYQxuDKg5d6dpLNV1+l+eBwwJ9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523522; c=relaxed/simple;
	bh=IL6Sxr7SiWXXIbckyWND7JWhDb6NfSyZYxa50dEhvuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g36Nl5PojfUjTJHm3l4Tt5i/V4DlDJ5t8O5E1eCTwCMykO9cftNcQ5xp5sln8jUADq5pdY2JqZ2jyZKMhyBPVJK5FN/l+a3jwMKKOnGRiFiiGq2wZujhEsXrMlvWwZdK9oSTxZ0OYYp946FP0JCGWyiduNNLTa0MbKSExrgk7qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/utAYYQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/utAYYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53C01F000FF;
	Wed, 16 Sep 2026 01:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523506;
	bh=V6YZ6VIs/U78RCSjOyjsK8je7C1xpS/bL7yeytk1frQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/utAYYQ9pTN93twBcUj+WhHKbJeLY6/MLiWJVFZQqCrkUxKA16CRlfKq5jwxnJAd
	 V+KXSGwtDhGx2V5DC7z3+4G8KiH7Rg4FrPmmqxelMCGJmd58zyKNYkfG6HwKOd7Cob
	 CzFAWfR+mJNPDHiNlSu+/WL9kyJtCL1Amgfab50JQFc4EnX2T3lmeDVB4iSiCbcQ0b
	 /U6UHZf1IGt97/SPelDNoGZ/+6BCDPYtwtO6uOGee1Yz8BFPRkQVoTb7vNCNlzbhtO
	 DBuwolJUYhwW+D+dF8VrvMOgJkqvxQUobIP8jtBj0wrZfDw23o7IHU1JqLTOA6KxvP
	 vAvYgM20cCDWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/26] perf annotate-arm64: Support load instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f95afe942520e925f209a2cd20c5f55d28c272b9.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <f95afe942520e925f209a2cd20c5f55d28c272b9.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:51:46 +0000
Message-Id: <20260916015146.B53C01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf annotate: stale lifetime metadata retained on load
- [Medium] perf annotate: incorrect type propagation for TSR_KIND_POINTER l=
oads
--

commit 9763211f6135d1b6c3e44acf4ac681c34ac60395
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support load instruction tracking
   =20
Extend update_insn_state_arm64() to handle load instructions, tracking
register state changes when data is loaded from memory to registers.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index d3d994a22cf92..11b2bdceaacb1 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> @@ -461,11 +461,210 @@ static bool is_readonly_branch_or_cmp(const char *=
name)
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
> +
> +retry:
> +	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offse=
t))

[Severity: Medium]
When acquiring the destination register state here, shouldn't the lifetime
metadata be cleared (e.g., via tsr->lifetime_active =3D false;)?

If the register previously held a variable with an active DWARF lifetime, t=
he
newly loaded value inherits this stale lifetime. During function calls,
caller-saved registers with active lifetimes are preserved rather than
invalidated. This causes the register's new type to incorrectly survive the
call, leading to stale type tracking downstream.

> +		goto load_non_regoff;
> +
> +	reg_offset +=3D mem_spacing;

[ ... ]

> +	/* Handle dereference of TSR_KIND_POINTER registers */
> +	if (src_tsr->kind =3D=3D TSR_KIND_POINTER &&
> +	    die_get_member_type(&src_tsr->type,
> +				src_tsr->offset + reg_offset, &type_die)) {
> +		tsr->type =3D src_tsr->type;
> +		tsr->kind =3D TSR_KIND_TYPE;
> +		tsr->offset =3D src_tsr->offset + reg_offset;
> +		tsr->imm_value =3D 0;
> +		tsr->ok =3D true;

[Severity: Medium]
Does this incorrectly assign the parent struct's type (src_tsr->type) inste=
ad
of the member's type (type_die), corrupting type tracking for the loaded
value?

If the destination register is subsequently used as a base address,
check_matching_type() will fail because it expects a TSR_KIND_TYPE register
to hold a pointer type, whereas it now holds a struct type. This breaks
downstream type inference for the loaded value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D16
