Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD292EC081
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 03:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270612; cv=none; b=DTx+WyEr/3+KmfzrZordMkXv0gVEerUIre0zCcqgI0EITsR23J/6ETjLa9+464uWOsb+xgZK9tdMUEmkBLg+6Tcw8dzd8F5D5Q9SHCiE8fSa/r0gmJbNFUQ0xKyR3FKUYwBJLE48mvt9lPqr+/e/1YPSn01rntIfiZhFOH/i1rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270612; c=relaxed/simple;
	bh=a3i0lrNcseLSdqG/zFZuAFMU1WINqm0WXqHIwD0k45w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=khd4KaH8OVtLW1NbcFxpZ7F7DwvRI/dkzawW6PIYxy6yvy9ReYODWjzu1LMKMJJUkOFMidMNkDiFa5TNAMIshUiduH3KeSaqXpTPOgavPkVPw7UnKCQetpVGAFz0sazzimPGx8IUYdbGfRYzEMd50oW4pTWxvoEDWcIMSFp7sY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJpsu2MH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJpsu2MH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94751F000FF;
	Sun, 13 Sep 2026 03:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270610;
	bh=2A61qLG/JJQmMPXAHffiR4BZPA2jRdhO7Bi9LLX/pQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XJpsu2MHpoLVGlJC4Bz0D/gfS+VE0VSZNkyKdu2pmCBKfCUwbNr6DxraYZIpzrFVl
	 AqNKCWbvHPrZJ05iyVTnssWf8elgf+PXyvXaeC2FyruKGv+bwiFAs+iBj8uOebTNif
	 5ZOcRt0NASRxBIzoyJELOkvr04ovyugNxpPPUU2bdR9k+QFSPe/37kIb9jayTGgDh2
	 gyDuWjEjRxts9+r6uyL0rezPeNioB533PKa8MkcKtF22Uw/jDr9wW7QweuNczp7PjL
	 VrfD6Q9oYK4KDQ4rji7+AWuKXD5WNjr9uA8fCCD/jL5Sj4oGnE7n6HJoSW9QBuKSW5
	 +ZQgBvrLa9F8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] perf symbol: Fall back to fetching the vmlinux
 by build ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913032632.116277-4-acme@kernel.org>
References: <20260913032632.116277-1-acme@kernel.org>
 <20260913032632.116277-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 03:36:50 +0000
Message-Id: <20260913033650.A94751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Holding `dso->lock` across a blocking debuginfod network fetch c=
auses lock starvation.
--

commit 0a14099ecb356d49e5d4b366cbd27b6a6caf40b8
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf symbol: Fall back to fetching the vmlinux by build ID

This commit adds a fallback mechanism to fetch the vmlinux keyed by its bui=
ld
ID using the debuginfod client when local kernel symbols cannot be found.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> +static int dso__load_vmlinux_build_id(struct dso *dso, struct map *map)
> +{
> +	char *path =3D NULL;
> +
> +	if (!dso__has_build_id(dso))
> +		return -1;
> +
> +	if (debuginfo__find_build_id(dso__bid(dso), &path))

[Severity: Medium]
Does holding the dso lock across this debuginfod network fetch cause lock
starvation?

When a perf profile is missing local kernel symbols, dso__load() acquires
dso->lock and subsequently calls dso__load_kernel_sym(), which then calls
dso__load_vmlinux_build_id(). This results in the blocking call to
debuginfo__find_build_id() executing while dso->lock is still held.

Could a slow network fetch or timeout stall all concurrent accesses to the
same kernel DSO by other threads, potentially impacting tool responsiveness
(such as in perf top) or parallel processing?

> +		return -1;
> +
> +	/* Takes ownership of 'path' even when it fails */
> +	return dso__load_vmlinux(dso, map, path, true);
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913032632.1162=
77-1-acme@kernel.org?part=3D3
