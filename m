Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D62BE02A;
	Mon, 22 Jun 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125627; cv=none; b=Wd7MzIODYl0eM3v5Ci/f9b6AFIMMqXUR8uApiS2+rLzELZTHyt9lxH0KlDJvbLhtd4avYivbpM/5Tb5EK9+YUT+x5HlWP5joIT3yiUbE+ltH/FUgdX66gtIr7ctg653iQYhgJ6yZKXbatLnv6lCs0pqN8BpNhophmhXsEeCLJVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125627; c=relaxed/simple;
	bh=cUIRBx1eWFVlX6QDKNebm2yGk1UXdcJeAaY+Re8zrJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGOlHLTySZdxOQRyesXiQ0ky78/QmhyJZO1ag3pqadwl6vYHOELOnqTU3jJKrR4v16Nvetpb7MyONCgdYhOJuDI1toKAhGXVqxqTwR77kip/w7wUo9wy8mTjTqUa8jilTMsB4MX8Ce8Mms31+tfUlhfqTVT4cmLpg0DdzVDpx+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyp1l7it; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyp1l7it"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479E71F000E9;
	Mon, 22 Jun 2026 10:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125626;
	bh=7oh2pArXlZ7RI0k84khGxLSedN+uhzyD/9U5BqE5BLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iyp1l7ittnJ5NbVj+npvXrpKugdG0+lbeZUA/i7INu16PmxwaY5LAiHwJs5AnOvob
	 xYy+8LKwAg91dPd4qzugia/uSTUmBPpZMYprfOvNzDjpXcrS99qS+SR1g5lIO0ZgVA
	 HMdAXcU/k4xbaF4LLQktBKn1+GqcW+PO/gnQ5jN3MOuKPXfJK4zPf2eiE4JyNm5kHu
	 txjCyGefoWWzLh/O0seeJaP2v3LbHSObAuZ2hwtaRvxOpsLj2mdibCR1XVV5VBveSo
	 LEEkWqbW3dH0Bl29ky17InKUOgRI9Ty2J0vstMQdJynw33ziRvBHAR9Z6j27A02Lyq
	 LSTNUSeMRA65g==
Date: Mon, 22 Jun 2026 11:53:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH perf] perf: Fix btf_vlen() signedness errors
Message-ID: <ffdbf003-5f08-4db8-b633-7ed053a738f1@sirena.org.uk>
References: <20260622103418.579115-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4VvRBQcMeiGWmdwc"
Content-Disposition: inline
In-Reply-To: <20260622103418.579115-1-alan.maguire@oracle.com>
X-Cookie: Now I am depressed ...


--4VvRBQcMeiGWmdwc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 11:34:18AM +0100, Alan Maguire wrote:
> Commit f7a6b9eaff3e6 ("bpf: Extend BTF UAPI vlen, kinds to use unused bit=
s")
>=20
> extended the return value for btf_vlen() to __u32, triggering
> errors for cases where an int was used to store return value.
> Fix these cases for perf as was done for other libbpf consumers.

I already sent:

  https://lore.kernel.org/r/20260617130038.34534-1-broonie@kernel.org

which I have been using as a fixup since I originally reported the issue
since Linus' tree is broken, Arnaldo said he'd applied it to the
perf-tools-next branch but it has not yet appeared in Linus' tree (and
it looks like he forgot to push it so his copy isn't getting picked up
in the merge either, the last update was on the 15th).

--4VvRBQcMeiGWmdwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmo5FDMACgkQJNaLcl1U
h9A2Hwf4sx441S8wLC7+sUkNiLTT3tl7HkkAr1PY5yGy/mxAFZjnnfKdrHZVqxc3
z8wG2RZCtx9nY4WpPXGBrtqonOgTeW28KFI3xGf2AMiL2QVPjfFomH1wrgopoQ4Z
8x6LtMd4dC2K6K+8biJZ/Co3O6SjlsHq4WFHr09AVoWwUEMxw8Q387cXorcDpdfj
AaSUWH+8dg+z4g/O8m9Ses1i8HuqYFEYi5DarcDI4upnOcoMSPweP7SJiqShNc+x
dzrokPxczpkSnJnM4ftamyFDKnCdAWjJyddcBTkhTq1gP06v4/KKzJi5JViG2ah0
tu6Raj+2vWDsTqUQTbLPs1qFXijw
=bmp2
-----END PGP SIGNATURE-----

--4VvRBQcMeiGWmdwc--
