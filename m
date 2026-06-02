Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39603ED3AF
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415033; cv=none; b=BLRQJCpcqk4GuIccfTCjW7aXg9zLosss8/BZWujDSKvlzPy3fXFkfyhzfEytraJ4LaRmOLb9guMPTUXSm4m769/VZSiNBQebpitism94GNwywao+JplyceoN2Bes2aquzZVngswJrt6O5b68NR5aboN6vsfhsOFIEk6HrsJ5FJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415033; c=relaxed/simple;
	bh=Bs9RF74V6MWBO/rgd/ieGJXhhL8NLbqsX0LCqN1mLto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hLzmnEVmvnn2wItBlQNgVoCEMSupWIY+kZgHwaQSOREp1aaqNlXGCTTixTH3Fn1ALMxE27iBod1zjibMnX5VsqozJdNMCeKxSeY2Ojn18lTtYT83PL+yoV7HrdkQmNBYjX+Qb7T0YfQedgAy4w+YeAxIBvCoQ9rjIRjT6Et9Lxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVfdBKlk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVfdBKlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1461F00898;
	Tue,  2 Jun 2026 15:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780415032;
	bh=GTTBHZxpcSrfkLwlB/A36S707A+Z9VmMm+4VtykuZYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eVfdBKlk5LSzHepb770In7TFGptSXQAlmNBkzZztiI32aFKGzXVnpHvoTx/RRQXQ8
	 n/0FOv0Gr4+lCGtVu7oglRIJ9DlrE8sNqkXIJy/E0sRnowXT4f2Cr6mwVBRF7nVamV
	 49cV0Ogst9aaJyD7Qsf2DZYKoargo+bBbRA4dVYaWl8IWnqQDC/HuWXInZHKbPKhQj
	 yT21rc8QwhBpCJ0Z0VeHkRmjadY+tYIBgU4jLtgpg1gz+tYmNApk2BJBxv2TI5dCDm
	 h75qHlTvbXO8KCwb0j8Y9oLN5NdxQgRLvzYBef/e5+LSAwC4tvYka/481JRdTMmc0+
	 RO9uwoS2cHVXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 06/19] perf symbol: Avoid use of machine__is
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602152516.2831152-7-irogers@google.com>
References: <20260602152516.2831152-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:43:51 +0000
Message-Id: <20260602154352.5E1461F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Cross-platform analysis regression due to host architecture fallba=
ck for guest kernels
--

commit 5ffd66d0549571c3b1c8d4a0baf650be921efbdd
Author: Ian Rogers <irogers@google.com>

perf symbol: Avoid use of machine__is

This commit switches from using machine__is() to dynamically checking the
ELF machine type via the DSO or running machine environment. This avoids
imprecise string comparisons and reliance on the perf_env arch string.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 714b6e6048fa2..2ce512f08a1d6 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
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
Does this fallback logic inadvertently break cross-platform analysis for
guest kernels?

When analyzing guest kernels, machine->env is NULL. If dso__e_machine()
returns EM_NONE (e.g. for kernel pseudo-files, where open() fails), this
falls through to call perf_env__e_machine() with a NULL environment.

A NULL environment passed to perf_env__e_machine() delegates to
perf_env__e_machine_nocache(), which invokes uname() to unconditionally
substitute the host's architecture. The previous code using machine__is()
safely returned "unknown" for guests without falling back to the host.

> +}
> +

[ ... ]

> @@ -1716,7 +1732,7 @@ int dso__load(struct dso *dso, struct map *map)
>  			ret =3D dso__load_guest_kernel_sym(dso, map);
> =20
>  		machine =3D maps__machine(map__kmaps(map));
> -		if (machine__is(machine, "x86_64"))
> +		if (machine && machine_or_dso_e_machine(machine, dso) =3D=3D EM_X86_64)

[Severity: High]
If an x86_64 host analyzes a cross-platform non-x86 guest kernel, will the
host fallback cause EM_X86_64 to match here?

Due to the host fallback described above, this appears like it would
mistakenly trigger machine__map_x86_64_entry_trampolines() for the non-x86
guest, potentially injecting bogus memory maps and corrupting the guest's
layout analysis.

>  			machine__map_x86_64_entry_trampolines(machine, dso);
>  		goto out;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602152516.2831=
152-1-irogers@google.com?part=3D6
