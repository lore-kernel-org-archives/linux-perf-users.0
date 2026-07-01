Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CEB38B7A1
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879401; cv=none; b=fuGh3IXD1Sf+CIlIrIjcVKltfGFf8oB6ullCuPDj7y+cYNUAzq8ZAY903DH6wt64QC5gCYGjj3uTW9RzcOtpcNbBja1uKT2q5Bt9jhVFvYSmk9XW84A3vsszHrd0A3t9lxARW3XcfLcMvTTBz4pSN/LFWaioSWt3MyIAT8qkQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879401; c=relaxed/simple;
	bh=l+b+lx4IGV/fW/ExFIyQRHDeNzgSq04I4kj3rb/lzS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JFdjZcG7V4gYGsrvu9x1A19PTT2rhxiUCmafR30n+Tqz0HS9um/QYEBIqnLSSdLm4xy3oq5QpIMZaveguRxyFG2V/ysk7MzspzRxhrvhIF1PtJr4sdfEegCJ1OeQst0itVoB4v63mD/On50xL00BS0mvJrJxFQHYB50D51lAw4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHy5tDxP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHy5tDxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEDC1F000E9;
	Wed,  1 Jul 2026 04:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782879396;
	bh=shECaDoqBN0RnQtAHAsoR0yHlXxyAqLZfPsXTVm2T20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IHy5tDxPwMInw2zyCcOGWMd2Iu7FQVcCUwpFT4n3S21OhGscbvxbdzLr2Qqk7I4s3
	 I+AbqFP5TqfNJkb76RJw5K2CTiextwPUipodGrzG08lERa1BkLlERSTSeVxVHmepPp
	 8/vjvwDvGOd63wsH9rI4RqH2N6RsclsUzcxpRxXBrgKAibFhIv86HthysDFxsQyC+/
	 iz0+NVh5idaWty15SfrFtLxEdNC6VBvCs1tnMkgFQWQ4dAZQDqzcfDv6Rj+hmGFYYM
	 Wkf/L4DRigkH25HBrf7DFuqMnUNTVlXdKdU5wtyaKzJzmsxZ/D8KyJzu1LkjEAAL8G
	 H7wejwUBkzLYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 21/21] perf annotate-arm64: Support 'mrs' instruction
 to track 'current' pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-22-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-22-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:16:36 +0000
Message-Id: <20260701041636.7FEDC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Memory leak of the dynamically allocated `type_name` string obta=
ined from `strbuf_detach()`.
- [Medium] Cross-DSO contamination and potential type confusion due to glob=
ally caching a DWARF offset (`task_struct_dieoff`).
--

commit 0f7d6f3c161448b3cb967b47ee3887be3d974dc1
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer

This commit adds support for parsing the 'mrs' instruction on arm64 in
'perf annotate' to track the 'current' task pointer. It dynamically queries
the DWARF debug information for the 'get_current()' inline function's
return type to find 'struct task_struct', caching the DWARF offset for
subsequent lookups.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index ec6fd59d51a27..89e3997f6721b 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> @@ -787,6 +789,81 @@ static void update_adrp_insn_state(struct type_state=
 *state,
>  		     insn_offset, tsr->addr, dreg);
>  }
> =20
> +static Dwarf_Off task_struct_dieoff;
> +
> +static void update_mrs_insn_state(struct type_state *state,
> +				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
> +				  struct disasm_line *dl,
> +				  struct annotated_op_loc *dst)
> +{
[ ... ]
> +	/* Handle case difference: LLVM (SP_EL0) vs objdump (sp_el0) */
> +	if (!dso__kernel(map__dso(dloc->ms->map)) ||
> +	    strcasecmp(dl->ops.source.raw, "sp_el0")) {
> +		invalidate_reg_state(tsr);
> +		return;
> +	}
> +
> +	ip =3D dloc->ms->sym->start + dl->al.offset;
> +	pc =3D map__rip_2objdump(dloc->ms->map, ip);
> +
> +	if (!task_struct_dieoff ||
> +	    !dwarf_offdie(dloc->di->dbg, task_struct_dieoff, &type_die)) {

[Severity: Medium]
Since DWARF offsets are local to their .debug_info section, if perf annotate
processes a symbol in a different kernel module (where dso__kernel() is sti=
ll
true), couldn't this global task_struct_dieoff be applied to the module's
Dwarf * handle?

Would this result in type confusion or returning an arbitrary, unrelated DIE
across different DSOs?

> +		struct strbuf sb;
> +		char *type_name;
> +		/*
> +		 * Find the inline function 'get_current()' Dwarf_Die
> +		 * and obtain its return value data type, which should
> +		 * be 'struct task_struct*'.
> +		 */
> +		if (!die_find_inlinefunc(cu_die, pc, &func_die) ||
> +			!dwarf_attr_integrate(&func_die, DW_AT_type, &attr) ||
> +			!dwarf_formref_die(&attr, &type_die)) {
> +			invalidate_reg_state(tsr);
> +			return;
> +		}
> +
> +		strbuf_init(&sb, 32);
> +		die_get_typename_from_type(&type_die, &sb);
> +		type_name =3D strbuf_detach(&sb, NULL);
> +
> +		if (!type_name || strcmp(type_name, "struct task_struct*")) {
> +			invalidate_reg_state(tsr);
> +			return;
> +		}

[Severity: Medium]
Does this code leak the type_name string?

strbuf_detach() allocates and transfers ownership of the string to type_nam=
e,
but it appears to never be freed on either the success path or the error pa=
th
returning here.

> +
> +		/*
> +		 * Cache the 'struct task_struct*' die offset globally.
> +		 * This allows us to resolve stack canary accesses even
> +		 * in CUs that lack a full task_struct definition (e.g.,
> +		 * compiler-generated entry/exit code).
> +		 */
> +		task_struct_dieoff =3D dwarf_dieoffset(&type_die);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D21
