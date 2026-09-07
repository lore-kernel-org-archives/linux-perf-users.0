Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125022425B
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759034; cv=none; b=PHfbcaMgpxqyTgSww4EPY5gDoLsTDzIudocIL/hTpEmol431+/RBOh7gjITH8XmIkcGZSf5mRFWqeajcidRALV3wMkE4YAznNiHy+bMuhReTUVHStG+k9AGoDTmHfSk5kuC4aoxWMLU/CBc0nFqj8wEOAwij76KlYVgDdZjM0wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759034; c=relaxed/simple;
	bh=ixggOU2pPVpuUXLl3zsspU975SffDkhsaOZXD1bXtdY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sjH/7aaj6Wma/LPR2DhLXZ2xEiMnnr+QD1ahQbRuWfJ7/nSXbGBNGCpoI6YLjZQ/EzgizIwplP8lYNZ+yzZy7VN3TKGht0BWTkVKgnRJs9hpIxJQedBfIoi0Wlygh2Uy8BlF7w5EOvA8vKniEEwMflcYHVN1aYO2OLCWp9HGJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9bsRuz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9bsRuz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AE31F00A3A;
	Mon,  7 Sep 2026 05:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788759032;
	bh=JMGRhQstaQ2Lfzn9ayyUgxMVgkoCCayGf3TPwYnEH4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m9bsRuz0W4M2HAZ5tWhZsfu0CyxBZ6Qr99xGfwKHxKxGT15hru/3gTY1CNHRRNTaR
	 JptYVEEXw5XoA1NPeH/9ps6k/lUgwULQcPG6BmWrPUuropO9gHCMMTKyR9IIGuGlzU
	 OAhDny1KGdJL13ut5fuJW8hvVZadq58/29b6IsSl+Ph1yqcLfC5mRr9gX6h/pHntaE
	 ukVLP2WnAjC4coapDQb5QIC7HmjYUIdBAjvNIFbjZu/VMwUj6Jl16XO1muC+Ab8q+3
	 mg/hABQsYkZkIL9DIjUooM32qqhbu8ND+nxDaMug3dQfMduAQWmCcrzJWX+UYGIRDb
	 ApAlQTcP4D53w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf disasm powerpc: handle Power10 prefixed
 instruction continuation lines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260907051429.29080-1-atrajeev@linux.ibm.com>
References: <20260907051429.29080-1-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 05:30:31 +0000
Message-Id: <20260907053032.45AE31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Undefined behavior and potential NULL pointer dereference when for=
matting Power10 prefix continuation instructions because `dl->ops.raw` is u=
ninitialized.
- [Medium] Memory leak of the dynamically allocated empty string mnemonic o=
n continuation lines.
- [Medium] Missing NULL check for strdup() return value leading to NULL poi=
nter dereference on OOM.

Pre-existing issues:
- [High] Freeing a static string literal `""` in the `!disasm` case leads t=
o an immediate crash.
--

commit a4f2ef8864fcf25d6aff270970e42d7988cba27e
Author: Athira Rajeev <atrajeev@linux.ibm.com>

    perf disasm powerpc: handle Power10 prefixed instruction continuation l=
ines
   =20
    Power10 introduces prefixed instructions that are 8 bytes wide. objdump
    emits these as two lines, stopping annotation when an empty mnemonic
    is encountered. Fix this by treating empty mnemonics as valid cases in
    disasm_line__parse_powerpc().

> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 6cfdbabbb8c7d..dbf5bd54d54b2 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -884,10 +884,24 @@ static int disasm_line__parse_powerpc(struct disasm=
_line *dl, struct annotate_ar
>  	if (name_raw_insn[0] =3D=3D '\0')
>  		return -1;
> =20
> -	if (disasm)
> -		ret =3D disasm_line__parse(name, namep, rawp);
> -	else
> +	if (disasm) {
> +		/*
> +		 * Power10 prefixed instructions are 8 bytes and objdump emits
> +		 * the second word on its own line with raw bytes but no
> +		 * mnemonic, e.g.:
> +		 *   1020900c:  0b 00 10 06  pla  r31,757280
> +		 *   10209010:  20 8e e0 3b
> +		 *
> +		 * Treat a missing mnemonic as an empty instruction name rather
> +		 * than a parse failure, so that parsing continues past it.
> +		 */
> +		if (name[0] !=3D '\0')
> +			ret =3D disasm_line__parse(name, namep, rawp);
> +		else
> +			*namep =3D strdup("");

[Severity: High]
Does this code leave *rawp uninitialized? By skipping the call to
disasm_line__parse() when encountering a continuation line, *rawp
(which points to dl->ops.raw) is never set, so it remains NULL.

Later, in tools/perf/util/annotate-arch/annotate-powerpc.c:check_ppc_insn()=
, if
the instruction matches certain categories, arithmetic__scnprintf() passes =
this
NULL pointer to a %s format specifier, which can cause a segfault on musl
libc, or (null) pollution on glibc:

	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
			ops->raw);

[Severity: Medium]
Will this leak the memory allocated by strdup()? When parsing a continuation
line, dl->ins.name gets an empty string. Then ins__find() calls
check_ppc_insn(), which evaluates !strlen(dl->ins.name) and does this:

	if (!strlen(dl->ins.name)) {
		sprintf(name_insn, "%d", opcode);
		dl->ins.name =3D strdup(name_insn);
	}

This overwrites the pointer without freeing the original empty string
allocation.

[Severity: Medium]
Does this code handle out of memory conditions safely? If strdup("") fails =
and
returns NULL, *namep (and thus dl->ins.name) becomes NULL. Execution then
proceeds to check_ppc_insn(), which calls strlen(dl->ins.name), leading to a
NULL pointer dereference on OOM.

> +	} else {
>  		*namep =3D "";

[Severity: High]
This is a pre-existing issue, but can this lead to an immediate crash?

When !disasm is true (e.g. in symbol__disassemble_raw during PowerPC data t=
ype
profiling), *namep is assigned a static string literal. When the annotation
line is later freed via disasm_line__free(), it tries to free the static st=
ring
literal:

	zfree(&dl->ins.name);

This results in a deterministic crash (free(): invalid pointer) from glibc.

> +	}
> =20
>  	tmp_raw_insn =3D strndup(name_raw_insn, 11);
>  	if (tmp_raw_insn =3D=3D NULL)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907051429.2908=
0-1-atrajeev@linux.ibm.com?part=3D1
