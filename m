Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4212168BD;
	Thu, 19 Sep 2024 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742589; cv=none; b=CGmE7Y5iSLD3lFIaOSZAeuUaA+LQdTbKM/ctowepWDLr2YX5F+ClkpGTOKxb2kMsS0x7v4i5GKGLe+CRWgxFSf9Ih92nXVBxZGrsZkUN7oyi+oZJ6fJrtcoGaUT3T9Brp1TpYHppZT6mkx7kaWbhp4xPjc0KnfA8c1vqKIe1ab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742589; c=relaxed/simple;
	bh=6axibghGWXnK0cm5vXDImFDbKRCElFsoUa7lpol6vJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2CSEZaP+1ST4UXzzuczXNhSCw87/2sr1sIZzpbwZ7/2aGVRy36qpRLAnl5GLQA9b5Z8Z2Sg8wpSl2sJUFLbg/XhtDks3lDjEG92vs/mtgsQ0cl2a6WdP0fUbNDoeaWh5herSo3sJqKaIu7LQ0UpNmRx60NFHj1NzZ/+E2TfocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Oee0lfBa; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Oee0lfBa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1726742582;
	bh=6axibghGWXnK0cm5vXDImFDbKRCElFsoUa7lpol6vJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oee0lfBaZwbiKRb+fb9McJIF5rAXlgqsNoGO1JMGVHKCI4qffUdGYUDT4RDWe8wBP
	 C22mm+1R3S9DT7n07qlj8ksBiXiNnb3Oklyreaqof3gLh6LybNqJQfrUzzOTJ88o4Z
	 SuPJRpoqDmVNKHd13+T3pcO6puntRF5vajv2k4jRU+1gLSKpAOZdeTcxk6Quk88Gq2
	 edUMEk0qBbbFxSSep2WkkNn8GR0urGP3ThNfb0lgZ9p9GfgrjjyC6eHPfx0QjBkNTs
	 J/bJGgByToxQyetGzZGdaC76ato2lbS4gJZLMsrA4U87trllYHIMRkdDy2fxl7t763
	 0RZz8PW7y2jrw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X8XD43PKYz4wbr;
	Thu, 19 Sep 2024 20:43:00 +1000 (AEST)
Date: Thu, 19 Sep 2024 20:42:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] Performance events changes for v6.12
Message-ID: <20240919204259.3d19a6b9@canb.auug.org.au>
In-Reply-To: <Zuv0kA-um9ZT-Tjd@gmail.com>
References: <ZurLc9qEjBH9MkvK@gmail.com>
	<20240919082624.05ca5fd6@canb.auug.org.au>
	<Zuv0kA-um9ZT-Tjd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.6AQDKVlYLiDpuNqFc13f1X";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/.6AQDKVlYLiDpuNqFc13f1X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Thu, 19 Sep 2024 11:53:20 +0200 Ingo Molnar <mingo@kernel.org> wrote:
>
> Thanks: I've queued up the fix for this ARM warning in perf/urgent and wi=
ll=20
> get it to Linus later today.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/.6AQDKVlYLiDpuNqFc13f1X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbsADMACgkQAVBC80lX
0GwPowf/brfJY12Xscub4zL+fzY9hwiTvUhAY8mC+OX55U5eCq3Q3Pfpug1QsYCG
mS6nuP+YbmuFTS+n4U9x0z9aRvOGRjmE7v1w4fqqMdk0cEsxbm+0HUnSiCHnHtGk
sq/beRORrnYzI6IxVaADqhYzW1LDHmveh1bGHkQSdfGZQ0YXx8zMKFaQhrkiqE/n
tsmLiaMwkVAbvuyEZnJoIEhmkRKzgYP8s7sC851pYyOik4uOJrluA0Jy2nDlG8Oq
deZyp5FKDz2YNJ/HOv7g8jDJC9f0Y8uUoZXeuJWZHukIuy2JalrKQ0k47dJ7YNQI
i8xCqLORnZWrMDrumngrEA9I4nyB6A==
=cXph
-----END PGP SIGNATURE-----

--Sig_/.6AQDKVlYLiDpuNqFc13f1X--
