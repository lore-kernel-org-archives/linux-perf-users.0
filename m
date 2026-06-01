Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70393806CD
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297688; cv=none; b=UhmjUGHeai8V9L+rBggoCPAwe3R8d4Z6TwoSjDQiAqjbF9gocBds7fGk8QHaif2ZtjoTBPA/L+9Fw3h0bbdE6no2sRf8OAoWwmCtlMqBFLzujDGpF9T2aiZJgew0OzPftwKffdNlT0lfg94zOP4VnU0YBVvPGQvVkPP2eaQ/LZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297688; c=relaxed/simple;
	bh=J4WuCVKXxp78Uer4HSwLvMUHJG6ZFAvypJkWQhsvptg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jn5Z6xKtOfci0M+GelxFnzBUfy5mx8kvGVrq4KlrDAfK3kkMZxZZwdx5jHc3t5+Mt8S0cz/tEzEXD60K1P+64ZPV0BEgBrtMbeazOOwghWxdnDE4pGV1+GT0Ey+ngVpYeJg3SOgfk+t2v4rqwyJIE5xFD2AdeICwmj3DOH93nd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+j+N1d4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+j+N1d4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11F11F00898;
	Mon,  1 Jun 2026 07:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780297687;
	bh=ZC6x+NpY2OaUr91seTiH95Y3U/cwIq2+e0z6BLLdIHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+j+N1d4ngi3dCqZiI149iXhj/2eV34xYDp3GF8MycDogwrzdfYJ8YS2AyPSp2Iol
	 xLG8MisRoNfGk0AgdrlxzxtfWruSV3xSQufnwmrBXGGv1DswvCDN5Q4w9Je5DciioM
	 OxUlTEpNTen95pYQWz7BT4Bf30+JEVCGEyCm1Z1MCxXjvucUoK+mtAt6hHa3vG5PJQ
	 tcIWGmRhXfjXxgw2e9fzAPMlAvl0LpnEWe6isNrhHzd8JzdzcUxnKXVnM1BAOt8kkq
	 yzdL8bJ47Rm2rdCWkEndrjt8b+JFAi3nJu9yD4aEgky528rcvPQ8Je0/f2pALSoGcw
	 b9O9xBsxmelXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/18] perf arch common: Use perf_env e_machine
 rather than arch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601065407.1597927-11-irogers@google.com>
References: <20260601065407.1597927-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 07:08:07 +0000
Message-Id: <20260601070807.A11F11F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `perf_env__single_address_space()` incorrectly drops the `s390` ex=
clusion, returning `true` for `EM_S390` and breaking s390 address resolutio=
n.
--

commit c962da7ad2b7e7b1d31d8f31f86699358bb75c4b
Author: Ian Rogers <irogers@google.com>

perf arch common: Use perf_env e_machine rather than arch

This commit refactors architecture matching in the perf tools to use the ELF
machine constant (e_machine) instead of string matching on the architecture
name.

> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index ad0cab830a4da..805a15ed99bcf 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c

[ ... ]

> @@ -237,7 +283,7 @@ int perf_env__lookup_objdump(struct perf_env *env, ch=
ar **path)
>   */
>  bool perf_env__single_address_space(struct perf_env *env)
>  {
> -	const char *arch =3D perf_env__arch(env);
> +	uint16_t e_machine =3D perf_env__e_machine(env, /*e_flags=3D*/NULL);
> =20
> -	return strcmp(arch, "s390") && strcmp(arch, "sparc");
> +	return e_machine !=3D EM_SPARC && e_machine !=3D EM_SPARCV9;

[Severity: High]
Does this unintentionally drop the s390 exclusion?

The original code returned false for both "s390" and "sparc", but the updat=
ed
logic omits a check for EM_S390, causing it to return true for s390 targets.

Because s390 uses overlapping address spaces for user and kernel space,
treating it as a single address space causes machine__addr_cpumode() to
misclassify user-space addresses as kernel-space (PERF_RECORD_MISC_KERNEL)
if they happen to overlap with kernel memory maps.=20

Could this break symbol resolution, callchains, and event attribution for
s390 workloads?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601065407.1597=
927-1-irogers@google.com?part=3D10
