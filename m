Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A8238E12B
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194431; cv=none; b=mMv7llwyEfayf0Ph+dRanWykH14usGRWzRftDvlF6ug0quuWAARyUIEy+GILeUl25suRh/F1Is7b5XJm8ke/nTjW772UJP2qUpOQfTlINR5qJ9hCv7P9vDNih1cag1mMLlvYfTct+/V1PtaBkBLjAc9Y7d5y0OlomFKuUZ7KUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194431; c=relaxed/simple;
	bh=fymUOzxfInfcYFaLnCFeiwjAEgCfTU82y0l9239JgAo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E2W3s78NZPBRcQGGZVFgjM8i/gN+sSgSiqDMs83uaXK1zkQjmRunJoc4yEan3LwAHvoWcF/BWVZa6/qjLJJEf6M2I83azL9hWtt/sK4GUZKZMkIs1S6tiXdSIAKsxEdG5g/JJoFSrg0fXqpZ+1cMD+XWyWV7aPkCvkUYg10zyTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcKyBVcE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcKyBVcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749031F000E9;
	Sat,  8 Aug 2026 13:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786194428;
	bh=2MAQL0dtXYgRbSod4P23/LJ+bezTpgbsHLqqvjSX1pM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kcKyBVcEaRcNAP/BOGUirBPkB7/a1EEkIWW3axy/JZdK1INWM9TJHA2G3DxRCqhXH
	 qHptMMBEhJEVJTjPigFudDjdGzMGgfz7Z5Z9bXr4UQQivLXZlCnsue+a/pVe4Y/+HC
	 1GjH83C0VeJFZFn/6N2hoF8TSGHVDhgsiQCDR9KFrfgJSvNMh/fkzKiSDMEePWNlDj
	 3BCZ4A2zirczeUOODvMNPD3HVkw3iJYbUvE42Dc2kLdJt4LxMu2C95OZALaEc6z6Ol
	 1Ct3l2WQU/N379w4yOQm71bhV63OKHEhotwt/DupRMKdciCqBN/rWXNcwhPmtPGkPw
	 C6SwHEiI9yzAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/23] perf annotate: Adapt arch__dwarf_regnum() for
 arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-7-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-7-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:07:08 +0000
Message-Id: <20260808130708.749031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch's fix to enable arm64 register parsing is unreachable =
and ineffective because the callers still unconditionally require a registe=
r prefix.
- [Medium] The new optional prefix logic in `arch__dwarf_regnum()` fails to=
 strip the opening bracket from memory operands.
--

--- Patch [6]: [PATCH v4 06/23] perf annotate: Adapt arch__dwarf_regnum() f=
or arm64 ---
commit 1ed2e0e5199a9033fdb64817a106aecaa0871796
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate: Adapt arch__dwarf_regnum() for arm64

This commit makes the register prefix check in arch__dwarf_regnum() optional
to support arm64 assembly syntax. It also extends the delimiter set in
strpbrk() to handle bracketed memory operands and removes the static
qualifier from arch__dwarf_regnum().

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index df70e95a84704..9d8b4d6b859b8 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c

[ ... ]

> @@ -2472,21 +2472,23 @@ int annotate_check_args(void)
>  	return 0;
>  }
> =20
> -static int arch__dwarf_regnum(const struct arch *arch, const char *str)
> +int arch__dwarf_regnum(const struct arch *arch, const char *str)

[Severity: Medium]
Does this change fully enable arm64 register parsing?

Looking at the callers of arch__dwarf_regnum(), they appear to still
unconditionally enforce the presence of a register prefix character.

For example, extract_reg_offset() checks:

    if (arch->objdump.register_char =3D=3D 0)
        return -1;

And annotate_get_insn_location() strictly requires a match:

    if (*s =3D=3D arch->objdump.register_char) {
        op_loc->reg1 =3D arch__dwarf_regnum(arch, s);
    }

Will these un-updated callers prevent arm64 registers from actually being
parsed?

>  {
> -	const char *p;
> +	const char *p =3D str;
>  	char *regname, *q;
>  	int reg;
> =20
> -	p =3D strchr(str, arch->objdump.register_char);
> -	if (p =3D=3D NULL)
> -		return -1;
> +	if (arch->objdump.register_char) {
> +		p =3D strchr(str, arch->objdump.register_char);
> +		if (p =3D=3D NULL)
> +			return -1;
> +	}
> =20
>  	regname =3D strdup(p);
>  	if (regname =3D=3D NULL)
>  		return -1;
> =20
> -	q =3D strpbrk(regname, ",) ");
> +	q =3D strpbrk(regname, ",)] ");

[Severity: Medium]
Since the prefix check is now optional, will p point to the opening bracket
for arm64 memory operands like [x2, #8]?

This strpbrk() strips the closing bracket ], but is there logic to strip the
leading [ before the string is passed to get_dwarf_regnum()? Can this pass
[x2 as the register name and cause it to be rejected?

>  	if (q)
>  		*q =3D '\0';
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D6
