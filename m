Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8F225761;
	Thu, 30 Oct 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847674; cv=none; b=F3mwyx2+dwJ4Xz07L171wm0y2GJKL2oYy48nI4TVPIFpSSsovgvMZ/qPEXJBfD2no0vCBX9VAdNP+eOkKe/IeARkf6fOKBmBsN2MrLK9tVlcFTQiDvfuW4jZkBC0f0faNP1lZzDcojM01LQcxbO6iqTfNMA5HXCIOWTbFEaa0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847674; c=relaxed/simple;
	bh=d4YBjSediQsxkiPhR4oIzNv3wOxsjTnymXN3KVEOxoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCrcvE5xUubNTCNLarzDCAsPvWT4SI9g3Nl5BnuV7TLk3MJiGLJ9byIbwv1lAfiA2bwVCCC0hfMzgYAwi9e4eX1zvCoy5D1imHopI5xBtN0b4lry1umFTqq/t+CQ3+NDOB2BlJhQFt+AdasYdPvNic90vJciAxq8+CU4jaSGrVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7fU4zUK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7fU4zUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416B0C4CEF8;
	Thu, 30 Oct 2025 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761847673;
	bh=d4YBjSediQsxkiPhR4oIzNv3wOxsjTnymXN3KVEOxoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7fU4zUKWaJ3miGs8cpUJJbqcB3At+7D9FJDVUKgaSoQkOwU7n8FTb9XJNl6tqX3x
	 zHm/DG0EYk4029sPp6bwtP3eBtmm3Fa8/1Czzm1xbolvsd8ne/syWt003sV5YA44rs
	 5jxAsXRMsANGXz9m8fIG8BsOQ5HOfdE9wRHCYLt6ULFJGQfdPgEDu7bf5uMJnsrns5
	 6tM1s1wsFLol8C3x1/zvFUWSrTHuiBTfvaJgf2/R4fYM1FzRdfNdnqPJODIcd+W1gZ
	 rxozXQ5UUH2EQtZWiDtrKOQaSrbJFS4fFY93eZNJVHHF7vDKOtn3JBxQ7wPAH0pr2L
	 Pt7x5TNWy4lTg==
Date: Thu, 30 Oct 2025 18:07:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Fangrui Song <maskray@sourceware.org>,
	linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Concerns about SFrame viability for userspace stack walking
Message-ID: <bdda89a7-ff60-46b0-8ce3-28ffec1fac2a@sirena.org.uk>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
 <87zf982s52.fsf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GoW7l/VHTumaJv7Z"
Content-Disposition: inline
In-Reply-To: <87zf982s52.fsf@linux.intel.com>
X-Cookie: Be different: conform.


--GoW7l/VHTumaJv7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:53:13AM -0700, Andi Kleen wrote:

> IMNSHO the whole sframe effort is misguided because all the major ISAs do=
 have
> shadow stack hardware support now which is generally a better option.=20
> It would be better to invest effort in deploying that widely.

It's going to take a *considerable* time for the hardware support to
become standard.

--GoW7l/VHTumaJv7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkDqXQACgkQJNaLcl1U
h9AA6wf/fPlJ3ZZiRfquQVNzY+ew+cYxeWDCikXzsRlhgaI9QtgyOYuqap9kP6Zm
Q4GtCiSdQlhesTLSCDYlzA47oPaU/kIsqMM2oWFLQpG86P42wcU50nK1pM2xDd03
CTIKCwXaPg9g85BBDJImlUNR4AObyB+aWrVm5zY+ryjFjxgwTWJq+c4Z4BBqvgwq
rBnJIqGYd4gBOSqEq+YoCER52rFc4/o1w5M3huTTXOGDewIOPhEhIIvcUxfk59T5
X+vYoD6cShQP3g4Av2eXzkvp6gaEtql6rlQfwd1sXRRBHpWzVxTlWJlOL8udq2iV
h2fPSgo3sJ/5rwWlavKPjnCpFCN3xg==
=8uFa
-----END PGP SIGNATURE-----

--GoW7l/VHTumaJv7Z--
