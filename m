Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E803EB819
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900201; cv=none; b=NltO5DqhBa+c0hHRca+yGzpxHcF0solaue0edvHNNATubeIq25MC73bM1bhN59QbnBD/8wDVZ2jFTm9u8Lz9Hyt6JRJnlylGnFfA32TplcqOhYBHc1+xnNMhdLYNCP9pXs1AGiFJEbBsF4gYWgu+nCVeEWqXtPTgodYm4j+le4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900201; c=relaxed/simple;
	bh=0csidmcJHabXvg7LAuSucrVHfrrrn68bn04MFXtKcbI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=m/4qacBXpUOMK8vBiGntkOsORTGPkOiEKvZCNy3ojV4Q8B8UL1IGxFbWx4bkoxfbV+igNkcHHEPVPtlrHOliypyCJBJEkwtzWRkFDDQlmVN3ookwroETsOXO/1jJ32dSykNTE+iHfh5IXpc2bvavjZWNXVzC4tTV+NvSElc8Uf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPbvSXxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPbvSXxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D4F1F000FF;
	Tue, 13 Oct 2026 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791900199;
	bh=r2iF9lIESHNjLIAJ/aTn5dlVzijdSc0keYGL+WXHEII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bPbvSXxmSwj4AcNVPjXInv/6f7MI0rUUFI4D93te9I5LFlIyWa2pdAwCG11OudR18
	 1juDl0EaiwhsUd8QR/6oiAQYH4bUqXAI33xRQOaWyIG/ygd7iG1Ify3V7UZ13fR3zI
	 8QFlzKGZ3QkkY9uRnWYxK/eCnu1FoEUi1rnrFyHnk/CgGF5DlwZlAqu1f222xiNauh
	 gsMAVCLno28vaiA5b4XeXLLD/WpAQE5yc98e8f4OnR8cFBmUmBTpvF6r8giaevJpjf
	 xESMHS+ddsX6sJzluS7SurAWerOyq6FfyAssu0V2Aroz2VCjV4xMZ0IUICU2GXIb5E
	 QnUFS7P+AdbpA==
Message-ID: <sashiko-outbox-169878@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/15] perf annotate-arm64: Support 'mrs' instruction
 to track 'current' pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <0615c314accfce4f3db561db1b1e02efcc5fd66b.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <0615c314accfce4f3db561db1b1e02efcc5fd66b.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 14:03:17 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf annotate-arm64: missing lifetime cleanup in update_mrs_insn=
_state()
--

commit 084f7875323701c8124c43b96de264a478df7634
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer

This patch extends update_insn_state_arm64() to handle the mrs instruction.
It enables tracking the current task pointer in the kernel, which is
typically accessed via the sp_el0 system register.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 5683215f07708..6da558f7e8648 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> @@ -1030,6 +1032,71 @@ static void update_adrp_insn_state(struct type_sta=
te *state,
>  		     insn_offset, tsr->imm_value, dreg);
>  }
> =20
> +static void update_mrs_insn_state(struct type_state *state,
> +				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
> +				  struct disasm_line *dl,
> +				  struct annotated_op_loc *dst)
> +{
> +	struct type_state_reg *tsr;
> +	Dwarf_Die type_die;
> +	u32 insn_offset =3D dl->al.offset;
> +	int dreg =3D dst->reg1;
> +	Dwarf_Die func_die;
> +	Dwarf_Attribute attr;
> +	u64 ip, pc;
> +	struct strbuf sb;
> +	char *type_name;
> +
> +	if (!has_reg_type(state, dreg))
> +		return;
> +
> +	tsr =3D &state->regs[dreg];
> +	tsr->copied_from =3D -1;
> +
> +	/* Handle case difference: LLVM (SP_EL0) vs objdump (sp_el0) */
> +	if (!dso__kernel(map__dso(dloc->ms->map)) ||
> +	    strcasecmp(dl->ops.source.raw, "sp_el0")) {
> +		invalidate_reg_state(tsr);
> +		return;
> +	}
[ ... ]
> +	if (!type_name || strcmp(type_name, "struct task_struct*")) {
> +		invalidate_reg_state(tsr);
> +		goto out_free;
> +	}
> +
> +	tsr->type =3D type_die;
> +	tsr->kind =3D TSR_KIND_TYPE;
> +	tsr->offset =3D 0;
> +	tsr->imm_value =3D 0;
> +	tsr->ok =3D true;

[Severity: Medium]
Are we missing a cleanup of the previous lifetime state for the destination
register here?

If the target register previously held a variable with an active Dwarf
lifetime, the lifetime_active flag remains true. Upon a subsequent function
call, the register tracking logic skips invalidating caller-saved registers
that have an active lifetime.

This could cause the target register (e.g., x0 holding current) to
incorrectly survive the function call in the analysis state, even though
the hardware register is clobbered by the callee.

Should this path clear tsr->lifetime_active and tsr->lifetime_end, or
perhaps call invalidate_reg_state() earlier before assigning the new
properties?

> +
> +	pr_debug_dtp("mrs [%x] sp_el0 -> reg%d", insn_offset, dreg);
> +	pr_debug_type_name(&type_die, tsr->kind);
> +
> +out_free:
> +	free(type_name);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D15
