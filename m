Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B0235045;
	Thu, 30 Oct 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849925; cv=none; b=epkbxJOJN7EjdpAq7hnoe0q/2zak2HAea9EpL5eOii+lWDk+xM7J/PZHFgP5NEbcc0yfxXbi0X9oOTAlarKlxje+I092H1RN45SGa6pHpORBfMej++MYPdmdRFNpcYkO53VxMz/iueAVeEEfhSPoOELV+t0hHDL0EtCk22HL2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849925; c=relaxed/simple;
	bh=BbMYj1xZMJWLc6sE0DW/ebo8EtBBBZO43DKONzeNGt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDK1Uzwp0cQb7sVsPtMTic3hf6t4HzWuzFbzRI1yWjSkCuDUBEp7MYDgCw23swGeB6dsQyuuegH2+Inu0iK7Z8BGuKD5XYwgIU5j0IuOOp8AN8iRJY+unJbOOSkVtKHPb4TxwZkuOCOfUu0W9tkFLTvsi/27GoE+C5/KLVRUBQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksC+4ICD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksC+4ICD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE39DC4CEF1;
	Thu, 30 Oct 2025 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761849925;
	bh=BbMYj1xZMJWLc6sE0DW/ebo8EtBBBZO43DKONzeNGt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksC+4ICDIR8me8naoquP6mG7gjKi8nXs2IKIwVEWnagaZa1z+wVhuhE7n26ip61+v
	 lfFY32Q+ktjLEkXXaaZ4RDHJU7kdrjiA6gd/WqUDrXWlcnlwu/dB86dzsdyP1lbzMJ
	 W+RRPF3VAtUlIPUIDE36H0ATgUkNPDs7DnZT0Qho/lAR+mQl7b6nXgGB4w0jfsuMS/
	 bWJyLe7G35+Cmz9HdajDzuTCyLaWsNkA+hYlg23xYojIUhF9c5VhZ2zar5+oX1P7BG
	 W/VNspGWMYbRbwXganCqCvjV7AJlnSG0kvGuQxHeKbqKhmWMkbwsXTDuifUHH3Pxr5
	 DVgObX2L42/Xw==
Date: Thu, 30 Oct 2025 18:45:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Fangrui Song <maskray@sourceware.org>,
	linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Concerns about SFrame viability for userspace stack walking
Message-ID: <baf2665c-49aa-4b8a-be26-69dc23876bee@sirena.org.uk>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
 <87zf982s52.fsf@linux.intel.com>
 <bdda89a7-ff60-46b0-8ce3-28ffec1fac2a@sirena.org.uk>
 <aQOvCugzYe/2DcNW@firstfloor.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DKdy9nJaHxHxbOQ7"
Content-Disposition: inline
In-Reply-To: <aQOvCugzYe/2DcNW@firstfloor.org>
X-Cookie: Be different: conform.


--DKdy9nJaHxHxbOQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2025 at 11:31:38AM -0700, Andi Kleen wrote:
> On Thu, Oct 30, 2025 at 06:07:49PM +0000, Mark Brown wrote:

> > It's going to take a *considerable* time for the hardware support to
> > become standard.

> Optimizing for the past instead of the future?

On arm64 no currently available hardware has shadow stack support, and
once systems start becoming available it'll take a very long time for
that to filter down to even being all newly shipping systems, let alone
all systems that people care about running new software on.

> Not on x86 at least. All my x86 systems have it, except for a few old
> skylakes.

My experience trying to find a system to test changes on was somewhat
different :(  I did eventually get something.

--DKdy9nJaHxHxbOQ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkDsj8ACgkQJNaLcl1U
h9A/ngf9H0X/BPRKtJc8r+4OmY18k4MVtcGwXACHC+6euBouQpz5bE253JhOn59w
bIvP5jCXHURZNPCXbWpxY+4h+Rj9fH3b89S29xHoepg36yfoNzP4OaIb2Ut6hnkM
eUyml6sRI+en1KyKBtTQmoKfau65V1H/UEwRX6sjxF/gVVv2YhE+0BSyZJIWLvug
wU9nfwJGLpAQRMXuavkCRtX0ddROWfwr7uN+DXD/eURoJUleCwDegxuKMUfumyG0
kTD8HO6eYEmW0i4hSWvaVr18Hk1DW+zGMisdIP68kzSth28U/P/fPgwkuNuSnS7E
1qht8Kw5xym1QN74qgIn/GihnBR1mw==
=eZn6
-----END PGP SIGNATURE-----

--DKdy9nJaHxHxbOQ7--
