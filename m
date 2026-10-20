Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509376;
	b=a71YklB+bjZgwsXU2giI3v1Y9IMsfJ5WA9Oiarmlfohwn/rTADxZhKTPdJfGDbEeNMsJ
	 6kWSqEKgtSqOkWGHFR5w7kfnr+63EaEH25ocToDqAh4Ldgfe5qctAWSPrm7wR2hyBvvLB
	 5ZVjdDnRSOAJ+D6UaTA9mRAdJpHfvQKeoJZPRbRWn/j5YBjB7FgmxJsXuBbVvQ5e0fcAM
	 uVSJDNgjGGP1uI3n95tA+4Ye5NJLphJE+Hxwxcz2j8pqh+x3HYH8NBZ6ksnedmOX/m1wd
	 QHYwBP2mV81+0DrqjEl1d6LPjNjArWVSJTT+Gh7TlMJhfEnRW1aEkK244GG4eqXmQ3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509376;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=avOMSACe1CuaHEqr15JkJk3BKCN3i+sPouoP8tCWVa4=;
	b=Ma7TcmTUgmpOOcLc+gtYN/SdUTJXNwGS/xLUhf8yEIqai39arTOW5g9Ta7GMr6Flc6X1
	 pyirgeLF8CEAggoyfk1QI3UC8sh5Xqho0zSh+Jre89zACAUPXwHsaLDXuh5RwzvlRmr77
	 jarHDNr3O2J3i2m0JNWkxs002O1MvgJxMx3CFtKsmxxk/b5i1UIVs8rOxmVgAzQR+otae
	 gbKSaGUx5kinO9Nn3N1R3rw2UBO8O0OPGMn+h4yBcJq11PfB4S0tVN4S8hcMGdeE6QbXn
	 bbaHjkwqOV2LL8SIYbHAM07MDXZBoLL7Ew4uoUVfDhw5FnRaES/qceJuqy6WkqXJT4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D236E606A319
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 15:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884371F000C4;
	Tue, 20 Oct 2026 15:16:15 +0000 (UTC)
Message-ID: <sashiko-outbox-179232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/15] perf annotate-arm64: Support 'adrp'
 instruction to track global variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <145ac934f72c090987c2e6d0be28b28972f843c7.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <145ac934f72c090987c2e6d0be28b28972f843c7.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 15:15:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf annotate-arm64: adjust_reg_index_state() drops global addr =
writeback
--

commit 329d013c0c7d0b8be3fe8f0ec1e0f669451e6cbd
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support 'adrp' instruction to track global variables

This commit extends arm64 data type profiling to track global variable
addresses calculated via page-relative adrp instructions. It introduces
TSR_KIND_GLOBAL_ADDR to store the page-aligned base address and resolves
the symbol address and DWARF type on subsequent add or load instructions.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 61df9c4f48776..bd060a823b765 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> @@ -722,6 +722,33 @@ static int propagate_load_reg_state(struct type_stat=
e *state,
>  		return 0;
>  	}
> =20
> +	/* Or check if it's a global variable */
> +	if (src_tsr->kind =3D=3D TSR_KIND_GLOBAL_ADDR) {
> +		u64 ip =3D dloc->ms->sym->start + dl->al.offset;
> +		u64 addr =3D src_tsr->imm_value + reg_offset;
> +		int offset;
> +
> +		if (!get_global_var_type(cu_die, dloc, ip, addr, &offset, &type_die) ||
> +		    !die_get_member_type(&type_die, offset, &type_die))
> +			return -1;
[ ... ]
> @@ -991,14 +1018,16 @@ static void update_add_insn_state(struct type_stat=
e *state,
>  	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offse=
t))
>  		goto add_non_regoff;
> =20
> -	if (src_tsr.kind =3D=3D TSR_KIND_CONST) {
> +	if (src_tsr.kind =3D=3D TSR_KIND_CONST || src_tsr.kind =3D=3D TSR_KIND_=
GLOBAL_ADDR) {
>  		tsr->kind =3D src_tsr.kind;
> +		/* For 'adrp + add' pair: resolve the full global variable address. */
>  		tsr->imm_value =3D src_tsr.imm_value + reg_offset;
>  		tsr->offset =3D 0;
>  		tsr->ok =3D src_tsr.ok;

[Severity: Medium]
What happens when a pre-indexed or post-indexed load or store instruction
(for example, ldr x0, [x19, #0x40]! or ldr x0, [x19], #8) uses a
TSR_KIND_GLOBAL_ADDR register as its base?

Both update_load_insn_state() and update_store_insn_state() call
adjust_reg_index_state(), which adds the writeback offset to tsr->offset:

tools/perf/util/annotate-arch/annotate-arm64.c:adjust_reg_index_state() {
	...
	if (arch_get_reg_offset(dloc->arch, op_loc, reg, state, true, &offset)) {
		invalidate_reg_state(tsr);
		return;
	}

	tsr->offset +=3D offset;
	...
}

However, TSR_KIND_GLOBAL_ADDR stores the base address in tsr->imm_value,
and all consumers =E2=80=94 propagate_load_reg_state(), update_add_insn_sta=
te(),
and check_matching_type() in tools/perf/util/annotate-data.c =E2=80=94 comp=
ute the
target address from imm_value + reg_offset while ignoring tsr->offset (and
update_add_insn_state() resets tsr->offset to 0).

Should adjust_reg_index_state() update tsr->imm_value (or should the
consumers include tsr->offset) so that pre/post-index writeback updates on
global address registers are not lost on subsequent instructions?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D13
