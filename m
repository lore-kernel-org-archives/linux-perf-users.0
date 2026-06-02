Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891230100E
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382498; cv=none; b=N+fS5tsLe0XUyxHY3rZjHVVr3s9SjAD4n/N3kMYhso3Ffjq9x6QaOsJRBeEgeolwM0X2fwWm+s0RvV0KAMWMBojSur9ijh7ZLgtz5iBfNJL5dQcVXEr5s8p0aYkNMeFpn0KZQHRiIDdDLxYsoAy/IjXzKgrKYiHwmpuRRLg/EgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382498; c=relaxed/simple;
	bh=waDchXoDnNPg9b/wVZyBhj16FVcqfl3gbk5mD2i100o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hlx0PZW3eSdgXYR1U7xxJsyZK+Lv5FI5LB6X117oq5WittH1U2sBc2SbbH0W7ZAm2uNjRF3LInXtPgLOuFbIuhAi5bCNxiZ2tPgiybUvTIIyXsHbHUhvUuE2DJAyZa1EVhho+L/KPThxMkCsxRlnj+rGOffevU3A32FBgjL1jZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5Kc9Faq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5Kc9Faq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47541F00893;
	Tue,  2 Jun 2026 06:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780382496;
	bh=EmmNjBZkovGSciGihiBdeeYzO6+zV1boNEoUQ2wdlNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H5Kc9FaqjkPWeUGgjz16bNNwhbpyMZpXRGzXIjkuQuMKlJ0ndVagDhbWGSoacuTrq
	 WPP2Cf8/IV1icLgDEAR2FsUxiAMH+RVlSnQklw+8DBly4gRaYl4fG8896KyzWOBUxC
	 8Wm07O3CsghN3uDwkLo3mg9y+v2SOUD3+EpkVRzp1j0mKGuPBt4MC5NQxRfs+rPMnF
	 JdZOrhrPO6GhnN7WUn4oSPXYAkU47KRp2Bvc4/g4iLGJWfIBTdM4qN7aj3uF8F90lT
	 ftW/NBiSsnnjpAB87iWUaT1UQ3iX4VeCG9sQRHUXMqPIQRPLsIPCZUDJIREsdsze9L
	 pXuVY7qzjG+MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 06/19] perf symbol: Avoid use of machine__is
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602062452.2583619-7-irogers@google.com>
References: <20260602062452.2583619-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 06:41:36 +0000
Message-Id: <20260602064136.B47541F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Cross-platform analysis regression due to machine_or_dso_e_machine=
 falling back to the host architecture when perf_env is missing.
--

commit 06f9fc725d46994e8315f16f6c305b978381b444
Author: Ian Rogers <irogers@google.com>

perf symbol: Avoid use of machine__is

This commit switches from string comparisons against the perf_env arch
to using the ELF machine value from the dso or running machine.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 714b6e6048fa2..2ce512f08a1d6 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c

[ ... ]

> @@ -851,6 +851,23 @@ static int maps__split_kallsyms_for_kcore(struct map=
s *kmaps, struct dso *dso)
>  	return count;
>  }
> =20
> +static uint16_t machine_or_dso_e_machine(struct machine *machine, struct=
 dso *dso)
> +{
> +	uint16_t e_machine =3D EM_NONE;
> +	/* DSO should be most accurate */
> +	if (dso)
> +		e_machine =3D dso__e_machine(dso, machine, /*e_flags=3D*/NULL);
> +
> +	if (e_machine !=3D EM_NONE)
> +		return e_machine;
> +
> +	/* Check the global environment next. */
> +	if (machine && machine->env && machine->env->e_machine !=3D EM_NONE)
> +		return machine->env->e_machine;
> +
> +	return perf_env__e_machine(machine ? machine->env : NULL, /*e_flags=3D*=
/NULL);

[Severity: High]
When machine->env is NULL (such as in pipe mode before perf_env is fully
initialized), perf_env__e_machine() falls back to evaluating the host
architecture via uname().

If we are on an x86_64 host analyzing a non-x86_64 perf.data file without
an environment, will this silently return EM_X86_64 and break cross-platform
analysis?

Previously, machine__is() safely returned false if the environment was NULL.

> +}
> +
>  /*
>   * Split the symbols into maps, making sure there are no overlaps, i.e. =
the
>   * kernel range is broken in several maps, named [kernel].N, as we don't=
 have

[ ... ]

> @@ -925,7 +941,7 @@ static int maps__split_kallsyms(struct maps *kmaps, s=
truct dso *dso, u64 delta,
>  			 */
>  			pos->start =3D map__map_ip(curr_map, pos->start);
>  			pos->end   =3D map__map_ip(curr_map, pos->end);
> -		} else if (x86_64 && is_entry_trampoline(pos->name)) {
> +		} else if (e_machine =3D=3D EM_X86_64 && is_entry_trampoline(pos->name=
)) {

[Severity: High]
Could this erroneously discard symbols resembling entry trampolines on
foreign architecture data when parsed on an x86_64 host, due to the
host fallback behavior in machine_or_dso_e_machine() described above?

>  			/*
>  			 * These symbols are not needed anymore since the
>  			 * trampoline maps refer to the text section and it's

[ ... ]

> @@ -1428,7 +1444,7 @@ static int dso__load_kcore(struct dso *dso, struct =
map *map,
>  		free(new_node);
>  	}
> =20
> -	if (machine__is(machine, "x86_64")) {
> +	if (machine_or_dso_e_machine(machine, dso) =3D=3D EM_X86_64) {

[Severity: High]
Does this similarly risk executing x86_64-specific trampoline logic on
non-x86_64 data if run on an x86_64 host without a perf_env?

>  		u64 addr;
> =20
>  		/*

[ ... ]

> @@ -1716,7 +1732,7 @@ int dso__load(struct dso *dso, struct map *map)
>  			ret =3D dso__load_guest_kernel_sym(dso, map);
> =20
>  		machine =3D maps__machine(map__kmaps(map));
> -		if (machine__is(machine, "x86_64"))
> +		if (machine && machine_or_dso_e_machine(machine, dso) =3D=3D EM_X86_64)

[Severity: High]
Does this incorrectly map x86_64 entry trampolines for foreign architecture
data if the machine environment is missing and we fall back to the host arc=
h?

>  			machine__map_x86_64_entry_trampolines(machine, dso);
>  		goto out;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602062452.2583=
619-1-irogers@google.com?part=3D6
