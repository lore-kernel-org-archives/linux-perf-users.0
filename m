Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E4E3EC687
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541527; cv=none; b=AS7BBBBT0Yjd/yZ+HKQGoEhlJ00IszF9qQm9CEzcqWsSiqXmMrEfV1knygWtyhJbUC1gaSiXQOn+NXv+sg/9NyLZQU44MO3fnjfCgPf4H/hlP39H0n/2Ct1pNPoPdK/RW7KoqX3SLUiO4Xfh6s5vUMD7ETXSuh/oSlFThZ/+QII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541527; c=relaxed/simple;
	bh=FaBWp9WH07T2wfLg61Lf6I1y0G0sRc3NtnX/0krccV0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bf+vy/kztvOSeFr3oN4JayNHzC/T9WLJN/nqkLLuIImfrpzK1ljUuOednTFGa4+gNRB2X0KsGaCTciDVQye8jcSBjwZguAb7OmQLeBlPF8liaqCvSsA/hhHzC2SOa6zughN7IdXV2y/lfSJQMz8xDMsp+KYw08HREvn7oUvI9s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJZq5HnK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJZq5HnK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5F51F000FF;
	Wed, 16 Sep 2026 06:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541526;
	bh=MP11S2x04ww82sCwiOLpNCZ6o4u+VZVIH/wIDsDxNrg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RJZq5HnKR/jBHamIOQ6mDVBEv34UZ2Ms7gXe/1UFW1SjK6e1L7c0U1TRWT/Xmd9sL
	 SO3Yi3yoQlHVmDxygCHwtupLTLR/097Uhb3/3Cmc5tu5eVWLnxyH2Hb5Uh4V3/PFoD
	 0p9ztALgYbTNHirkdxGyuvPiI+/L7uEjnDZrvDk2HoumvP9hQ4TrmJcPTrNByEw/Bf
	 0oSHCr7CE0SUjQb5zUyPw0GrVefSVG/JHBhUJaeo2szQsWARJgIdjEmMALv0v8hmyr
	 etTXHCwaNEVpOebx7Qkw1EGp92RmptGodJxp4nPyoElNjoYwmRI2F7ocvWis6i2LHP
	 BsXCN5fSv88pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf libdw: Fix Dwfl discovery with split files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916063545.3103314-2-irogers@google.com>
References: <20260914170759.1992947-1-irogers@google.com>
 <20260916063545.3103314-1-irogers@google.com>
 <20260916063545.3103314-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:52:05 +0000
Message-Id: <20260916065206.0F5F51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf libbfd: TOCTOU race populating cache with stale dso_name
--

commit 6a983b5d3f6eb6250b40233e72f23d9a6454ca97
Author: Ian Rogers <irogers@google.com>

perf libdw: Fix Dwfl discovery with split files

This commit updates Dwfl initialization to use the symsrc filename when
available, falling back to the long name. It drops the cached Dwfl and
addr2line cache when the symsrc filename is set, using the dso lock to
safely handle concurrent teardown and access.

> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -226,7 +226,10 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
>  		      struct symbol *sym)
>  {
>  	int ret =3D 0;
> -	struct a2l_data *a2l =3D dso__a2l(dso);
> +	struct a2l_data *a2l;
> +
> +	mutex_lock(dso__lock(dso));
> +	a2l =3D dso__a2l(dso);
> =20
>  	if (!a2l) {
>  		a2l =3D addr2line_init(dso_name);
>  		dso__set_a2l(dso, a2l);
>  	}

[Severity: Medium]
Is there a Time-of-Check-to-Time-of-Use race here when populating the a2l
cache?

In __get_srcline(), dso_name is fetched before the lock is acquired in
libbfd__addr2line():

tools/perf/util/srcline.c:__get_srcline() {
    ...
    dso_name =3D srcline_dso_name(dso);
    if (dso_name =3D=3D NULL)
        goto out_err;

    if (!addr2line(dso_name, addr, &file, &line, dso, ...
}

If another thread calls dso__set_symsrc_filename(), which updates the
debuginfo file and clears the cache, before libbfd__addr2line() acquires
its mutex:

Thread 1
dso__set_symsrc_filename()
    dso__free_a2l(dso);

Thread 2 would see a NULL cache in libbfd__addr2line() and populate it using
the stale dso_name argument:

    if (!a2l) {
        a2l =3D addr2line_init(dso_name);
        dso__set_a2l(dso, a2l);
    }

Could this permanently poison the cache with a BFD instance for a file
lacking debuginfo by not verifying it against the current symsrc_filename
under the lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916063545.3103=
314-1-irogers@google.com?part=3D1
