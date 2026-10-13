Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55B395273
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912676; cv=none; b=SzMOZvMe3TN6cxGeIGyX5X+iq55CDAsCyc20LhxNsrACvRSEjAUFOgmgMBqa2VPEDwwzCKNIGnBgZX4ZcwoqhWSZ3N1laWfXab2Lq2VjeByEcI3QJLNDCmU2/Rhk7aNMFaZF4IYJx5oL/8xDdyYGgyNrP2T6/3QmFWP44p41k/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912676; c=relaxed/simple;
	bh=NH8DXgc1ASLtCyDpPE03caICn/oAqATX5zBExFLXa1g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=k+KD95Hi0Vq5/vK56QD0jNe2irwzd8uSwLQcHW547HyPUE2zszKMatgV1up7PCW0JgZLYSpTH80bpkVQMawaj8CsQyIjky1A7mcUR1ZJp7axf4mqIwkYlkMcG534Fk9clWHrnjQjnsvh+MG3W0yBbIuAO9mRJwLQYH6Hbe0Evfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFUlNViB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFUlNViB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9511F000FF;
	Tue, 13 Oct 2026 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912674;
	bh=cmQjVdK0fnn0dPT42+sub650NZV/N1TrPs8ERh79GoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nFUlNViBhBkGEfYxXksfFUE6u1R9W+e+VIqizqPmc3Z+HYqe2FVsRt3/iDlEf3HXO
	 sOnx3eBpb6KAb9CNgx58f4eruzXs5F9Lr2mGllXzI3io/v4pLqNaVcc3RrfkR2ztJJ
	 kpw9si61FzWeaDPxEO8NzJ3J7u77SCi9fJb+Xl8JA6lw93we25EJNaPkZ3gbv6yN0h
	 K6cE336H20ydx7wxgXmIGoMHVUAbzHrBrvskRA43Yh+TG8zvFWG084z9v74NGiyoVa
	 RbbZ05WCNeyXBKf+RLu/8mnC57EJHZn6X50/27YbQIHec01V7NxtSE+BWyGziFazmf
	 VCMNyd3M0PXlA==
Message-ID: <sashiko-outbox-170233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/11] perf tools: Check ELF section type with name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013172155.160869-3-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:31:14 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf symbol-elf: uninitialized memory read on gelf_getshdr failu=
re
--

commit f2750bf0f2a1c49778b5a9d0173f02f48eb9e193
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Check ELF section type with name

This commit updates filename__has_section() to verify that a section
has the SHT_PROGBITS type instead of just checking its name. This prevents
empty sections with SHT_NOBITS from being incorrectly identified as present.

> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -228,7 +228,8 @@ bool filename__has_section(const char *filename, cons=
t char *sec)
>  	if (gelf_getehdr(elf, &ehdr) =3D=3D NULL)
>  		goto elf_out;
> =20
> -	found =3D !!elf_section_by_name(elf, &ehdr, &shdr, sec, NULL);
> +	found =3D !!elf_section_by_name(elf, &ehdr, &shdr, sec, NULL) &&
> +		shdr.sh_type =3D=3D SHT_PROGBITS;

[Severity: Medium]
Can this lead to an uninitialized memory read of shdr.sh_type if the ELF
file is malformed?

Looking at elf_section_by_name(), it does not check the return value of
gelf_getshdr():

tools/perf/util/symbol-elf.c:elf_section_by_name() {
    ...
    gelf_getshdr(sec, shp);
    str =3D elf_strptr(elf, ep->e_shstrndx, shp->sh_name);
    ...
}

If gelf_getshdr() fails, it returns NULL and leaves the shp struct unmodifi=
ed.
Because shp points to the stack-allocated shdr in filename__has_section(),
a failure in gelf_getshdr() leaves shdr potentially uninitialized.

Since this patch adds a direct read of shdr.sh_type after elf_section_by_na=
me()
returns, does this new check risk reading uninitialized stack memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013172155.1608=
69-1-namhyung@kernel.org?part=3D2
