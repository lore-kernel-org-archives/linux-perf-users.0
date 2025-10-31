Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE5324B3F;
	Fri, 31 Oct 2025 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911191; cv=none; b=OjbnqruT2eGzpOeRrD+iDgVm9l7mEuCICisGcuWbZ+cpX6m9HJ6vD1vavlE0VZjFTThHi6p0bfIEcq02TXeCwEut41WYEKfBXMelw+hdG1WFqkoIbZMGU8Ed0tBvrso7Lt4qYzBSf3xUL3GdJ0tGsqWcm+yFodEugc80XpUjn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911191; c=relaxed/simple;
	bh=NLFzf6aPiYEzRec8z/0NkGaBACsCjAMeR7C+nc1kYYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8ks9xW9EnB34XI1g9VwtyGTDJWyE0HedSBJKu4Nxry5yYWTNyHWZTE0c1JFJGrD/9KnLYF2SgdQjvKG7wUcf7T65RGwFXu9PhonM1CJ9hx4aia3W+ZopUaGxKAdR8P+enSUavRPHDEjshV1QhzT9M2Iq5WmQ+pwBPiHGtzyZVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQafsZb6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQafsZb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93807C4CEFB;
	Fri, 31 Oct 2025 11:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761911190;
	bh=NLFzf6aPiYEzRec8z/0NkGaBACsCjAMeR7C+nc1kYYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQafsZb6H+v0XImQycAa728kqkG+QlVUsyWFlIhAG0Tsec2GLKSi67gFWdCCOlPqH
	 luQXgXfz2uuGRSUwt81cfxDA/XTjuQqajZUWRs9KsKml6vz2AqhNRU4S6uFIotb7kO
	 ZuozQbVajWHgbyIwifIhzuLAcQBmgfO/4b5hBVRHDpvmu7xymy2vd6Wv8UrJ0sH+f1
	 9Z94M5yGHMw1srPwca1dj6TzL0JcwbtZeDX89bw/XOM5YdYDOxiWAYI5gV9d+ln2R5
	 vbix9Vs8OYTgK+MQQOVwjplDtPE05hOGHUmLv2H+4ajG02JVu80pjiHeuCH24b4NOR
	 YegCNdqouaODw==
Date: Fri, 31 Oct 2025 11:46:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi@firstfloor.org>, Fangrui Song <maskray@sourceware.org>,
	linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Concerns about SFrame viability for userspace stack walking
Message-ID: <23a87719-2672-493e-9d84-9b4c0438c029@sirena.org.uk>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
 <87zf982s52.fsf@linux.intel.com>
 <bdda89a7-ff60-46b0-8ce3-28ffec1fac2a@sirena.org.uk>
 <aQOvCugzYe/2DcNW@firstfloor.org>
 <20251030185725.GC2989771@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9HfAOuIILsLihKI4"
Content-Disposition: inline
In-Reply-To: <20251030185725.GC2989771@noisy.programming.kicks-ass.net>
X-Cookie: Byte your tongue.


--9HfAOuIILsLihKI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2025 at 07:57:25PM +0100, Peter Zijlstra wrote:
> On Thu, Oct 30, 2025 at 11:31:38AM -0700, Andi Kleen wrote:

> > Not on x86 at least. All my x86 systems have it, except for a few old
> > skylakes.

> About half of my systems have CET, but I just checked, none of them
> seem to actually use userspace shadow stacks.

> AFAICT Debian hasn't build their packages with this stuff on.

It hasn't - they're starting to roll it out now in the development
distro, an actual release is a couple of years away at this point.

--9HfAOuIILsLihKI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkEoZAACgkQJNaLcl1U
h9Dsrgf8C2XPXL0I7OVWPeVC8p9yzGl1Ezfjci16TbgBUEOu3fZ87e595HqvTmQr
jFMLXBBIR7h5X99LeYr874y/C2wR0ZX7+4cnJb7spb3XLJFD0IdcZAxRaE6EVOHJ
KMvNUWvLIfv2Ryv3vahTfWPG6BRPlWca7whA9IxTu+vXQbv7QU4/Bm9b7IdGxnGQ
KzBJpNEwyxskJstK7ldQEX2w1a0JDwNBV6BOvsrvzRio6ttPxzJRi4+hiuKB6rUh
F2QyIkTrs/7c/BMI8DMsOnq2grcLn1hdbYTgr3KGlgbpgwEMQViob7uGKbAWZ1MY
0SUf7LAgAZQWk7Q2kAMGf7/N1kYpSQ==
=JAkR
-----END PGP SIGNATURE-----

--9HfAOuIILsLihKI4--
