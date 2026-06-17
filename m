Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9BEEA8;
	Wed, 17 Jun 2026 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700829; cv=none; b=Dc65QylJlg0Hfc57oO+rgGpBCrgE3SlNehBV9LPSvdRoNsjL+srJtXR4+EiXHaXEw/u0KXVVdiH7dBkb/dKjifpx/AYAsFrQ+ob54cY3kxX24Mxq5/9ViOBWivP4ZiROS0GUUhGI1M4ns9+B+cH2ov4+68lVJM2hKzWbxnYu/bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700829; c=relaxed/simple;
	bh=8gAsGCiR+ik0EyGHrya/ZZ1ZphI8HG4AVduukFGfXV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r34Mb8BowBnDlvtEQ4vHwS0WIESo/akDcDj7mYzTHmGnf6O1QYU0pAeP2JOwM6RjdpNwdelBDFsr1W5j6oEDQqjT3qwiovNT/rJ6hTBSNpbhA6WzR4QMyiWlslulNPdQgKCzTQmY9+mvxtAXE8c7dQc81Z3OTQTGBRIrVEiq2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdlGTRKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdlGTRKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872571F000E9;
	Wed, 17 Jun 2026 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781700827;
	bh=wXFBzyoPgmkzJ3Jr2y3pGHJMrgpAjpvkc/yYS80g3S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mdlGTRKEFvXC4DcmPN22DOKk8uxm+f/h86K5BpHAWrPjqGsn6bzAsxgXj5k5nrL4y
	 FfzGLKRqaBDT4KkHbp4xhl0MMOo9fRQDhr4XNeLIvatrneND27Mbqk0gjTSz38UPTw
	 I7VJSXY/ZpGy5aRChm7iirc7vX+RXPrTnSSSZPyBnBZf+5IHuCfRmkgz0L6blEkx17
	 DX0xL4n0p8lxLMWpuoaG9EzFrQ59L89rc25bM6IOpAgsdieQZ+GCyVl+Nebkybi7Oi
	 B8B9H5a9R9vKFYl53J1ortwAR4J/oUw1zDpe56Yxsto4/WuabmZ/R0hHRKaWRK68OZ
	 Z9Gno9jAosrVg==
Date: Wed, 17 Jun 2026 13:53:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] perf: Fix up build failure due to bpf changes
Message-ID: <fa7c44b4-a76e-41eb-a2a2-2c2c79df6528@sirena.org.uk>
References: <20260617124554.33182-1-broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n5xHC6/+j/cWuzyk"
Content-Disposition: inline
In-Reply-To: <20260617124554.33182-1-broonie@kernel.org>
X-Cookie: Absence makes the heart go wander.


--n5xHC6/+j/cWuzyk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 01:45:54PM +0100, Mark Brown wrote:
> Fix
>=20
> util/btf.c: In function '__btf_type__find_member_by_name':
> util/btf.c:19:43: error: comparison of integer expressions of different s=
ignedness: 'int' and '__u32' {aka 'unsigned int'} [-Werror=3Dsign-compare]
>    19 |         for (i =3D 0, m =3D btf_members(t); i < btf_vlen(t); i++,=
 m++) {
>       |                                           ^

Gah, there's another one which I will also fix up - I'll send a v2 in a
minute.

--n5xHC6/+j/cWuzyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoymNcACgkQJNaLcl1U
h9A8eAf+JJbLjxlwR5Sbv0OWEbX0+DBIZsFz9FYfbb33Tl2SmHYRE3+5vMj3DC+w
nEEV9xGiCdJP39orHKXVZ7FbQwUfHTtvyUvsM8CNLfw3CsWd0uFpvLg/wRYEh1/z
gI5rIy+WuH/h2Lh4ivYOKZpOdvha/sG+UV3JlKK5WD9TlL1hio6xTU93paj9RlCA
nvgqEpdc4QITkjiZtocQreLLoUTZDiJdbVdeZ8bJ2yvK8IlF33LtPFLvZzDbzF1o
dniL11Zit1SE0DdIyrbm8bomP6dSiVMEX1gjnoAikhsds2KNXY9LIQ85ghjrTn8s
M90LBh6V+gGxFTeS2XWISpL/bqwp5A==
=KiVx
-----END PGP SIGNATURE-----

--n5xHC6/+j/cWuzyk--
