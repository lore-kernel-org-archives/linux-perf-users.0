Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B963B9
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 00:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781311072; cv=none; b=kQ3rzwnwFHdZ1sgypVHHYvJ4TeV+ydFUKJr4Id0C4wSy4YU+Z2N0w06UdeBIcUgzEqhcGkHiiUVqWO8zrWkMuHPPuoaJpLuPrmPzws7XESB7Jk1hRih6marvIFmcGB9ynyBtv4jYHgVOGDYenMaFysnUMYcxBNeKmObzoCdkPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781311072; c=relaxed/simple;
	bh=3TPCADIvt3H8tRkBO9pkbvFpi4SvGCRa6wcihiBElF0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IrzAvClLEj3jk1LEDjoUCiJrIxcN4n2kcAgdA4Vk6TZYbN4m13nKxo0wOaw3POWmuCT6KYmn/LtFEH+9wQEqbdlItMpWiLH4VrOyfnkCbiiyaFrugZXHH3f7Avu41+b967Yav4x7bszimvssWK4MF9Vgynantv82cQM++fMxgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eejQq4vz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eejQq4vz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAA81F000E9;
	Sat, 13 Jun 2026 00:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781311070;
	bh=+kkIWdtP2cRhryMnuGprs/YllitRMdVA3kAD6NQ/2hY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eejQq4vzf7TnavLFhwgo6ukTghwhWZeKKwzqzn8d5Isaa6c41O4EYcL9WOwbc/Uz6
	 l7tHzzZFMLEqaQ5oITEe//kdR9EUJvCK+kNTQ4PThkaucUb7T4kYHNyce/M3G5dTQF
	 FjcOOnj3c6am0c9JhVo3q0j28LR3xiujUd+FOkps7tR3MYQePyMbHwnQWoY2R3En2k
	 u/QUgIQmc//Nw2RXfnyCGqnIYIiH5ZKLL1N/SvPCeYzgSaFXjCy8x26RVnW5e/CrhI
	 cm2XQxg9qxNJsbqkccqSXEIBf2dSkd6d+DAW5ZSZaYZAomEap/LX3tylOdnoNOA7cJ
	 hlhdnv4J7gI9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] perf tools: Use snprintf() for root_dir path
 construction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612222413.40791-7-acme@kernel.org>
References: <20260612222413.40791-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 00:37:50 +0000
Message-Id: <20260613003750.ACAA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix / Stack Buffer Overflow in `machines__findnew` and =
`machines__create_guest_kernel_maps`
- [High] Logic Error: Masked initialization failure in `machine__init` lead=
s to crashes.
--

commit b6a579801b54628696ffab3ceae15b03107d3093
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

    perf tools: Use snprintf() for root_dir path construction
   =20
    get_kernel_version() in machine.c and dso__load_guest_kernel_sym() in
    symbol.c use sprintf() to construct paths by prepending root_dir to
    "/proc/version" and "/proc/kallsyms" respectively. Both write into
    PATH_MAX stack buffers, but root_dir comes from --guestmount or KVM
    configuration and is not length-checked.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index da1ad58758afd..58fa57e3d1a15 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1336,7 +1336,7 @@ static char *get_kernel_version(const char *root_di=
r)
>  	char *name, *tmp;
>  	const char *prefix =3D "Linux version ";
> =20
> -	sprintf(version, "%s/proc/version", root_dir);
> +	snprintf(version, sizeof(version), "%s/proc/version", root_dir);

[Severity: High]
This isn't a bug introduced by this patch, but the fix appears to be
incomplete. While this replaces sprintf() with snprintf() for root_dir,
there are two other unpatched sprintf() calls in this file that write
the unchecked symbol_conf.guestmount into a char path[PATH_MAX] buffer:

In machines__findnew():
    sprintf(path, "%s/%d", symbol_conf.guestmount, pid);

In machines__create_guest_kernel_maps():
    sprintf(path, "%s/%s/proc/kallsyms",
            symbol_conf.guestmount,
            namelist[i]->d_name);

Could these also overflow the PATH_MAX stack buffer if a very long string
is provided to the --guestmount option?

[Severity: High]
This is a pre-existing issue, but I noticed a potential logic error in
machine__init() in this file regarding the error path. If an allocation
fails (e.g., strdup(root_dir)), the code jumps to the 'out' label:

out:
	if (err) {
		zfree(&machine->kmaps);
		zfree(&machine->root_dir);
		zfree(&machine->mmap_name);
	}
	return 0;

Does this intentionally return 0 instead of err? It appears this masks
the initialization failure from callers like machines__add(), leading
to crashes later when they use the partially uninitialized machine struct.

>  	file =3D fopen(version, "r");
>  	if (!file)
>  		return NULL;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612222413.4079=
1-1-acme@kernel.org?part=3D6
