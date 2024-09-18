Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E4178CF6;
	Wed, 18 Sep 2024 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726698390; cv=none; b=JB595Rn44QGsDzvFrSzuqEKJJsgtqVWKfJ4EgIYvdACvXoKz9KjwyGRjnMT1IncF3Iq11Wbyhh+UPcuD85j4CQQ+MO8PzXDhFrwXxCxxkkMuq5Zk/0oLjCxKvWQQipUWI/PWUciYqY8ofHHhzlbU5934bF7EqY5M5ChQt2VOeik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726698390; c=relaxed/simple;
	bh=OhYI+MNoOFaYPiFXE26XcNL5YfvUyP5sjGy/ntvdgV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loR+vjLXddQYfFqwkN2gfRLjyVUAL/Uoz0OqXBv2ntOw1siNww28Y92nN4N4nTHqt0pwDhV575/heqtm0azSH8i1OH1VTXTm4kWkWCkcnsWXSv8s4YU4Dbp24kgbbjWFqKdCqNK6522uZug0xFRGBIprSxkeamjQaq1PE3JPD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=N2xjtGrD; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N2xjtGrD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1726698385;
	bh=NfEv9d3LU+LUqcR27zMivHL1FEOXtWuNMUA2OR0jp08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N2xjtGrD2fuzZJf2Z6fmQdUfiCeUfvwHY+P4vB19ZyAhcvg3NnB7Gc6j4+Q3PS/BC
	 nZWuXbYT2l1KQbp0pINqOBcml8wq3yGJGQC3qYJCtliAgjTwX1XUMVFMMH1J6H8sSI
	 fHL6teFf0iGu42csvi/qGsbjSqpcr76uTgCWFbUmo2WCmxwSp+FuXxXoo5XmE2/xc1
	 bXvDPUzvQkcrf8Vdc19A1TqqaEMfZomOMrTc3gOuk+DGBHhDF9aLibbu588e8/1Hio
	 XYAAdijRVRnNuFYCNBpjgickFas1Ncpa4SRyjcxeF7LnzWmyTw8jKxeKsbSffVbZI2
	 CaNBwUPtryCJQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X8Ct90FGjz4xVV;
	Thu, 19 Sep 2024 08:26:25 +1000 (AEST)
Date: Thu, 19 Sep 2024 08:26:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland
 <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] Performance events changes for v6.12
Message-ID: <20240919082624.05ca5fd6@canb.auug.org.au>
In-Reply-To: <ZurLc9qEjBH9MkvK@gmail.com>
References: <ZurLc9qEjBH9MkvK@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/smY3BmHj5Ku=0u/jB1puZt+";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/smY3BmHj5Ku=0u/jB1puZt+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 18 Sep 2024 14:45:39 +0200 Ingo Molnar <mingo@kernel.org> wrote:
>
> Please pull the latest perf/core Git tree from:
>=20
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-20=
24-09-18
>=20
>    # HEAD: 5e645f31139183ac9a282238da18ca6bbc1c6f4a Merge branch 'perf/ur=
gent' into perf/core, to pick up fixes

>       perf: Generic hotplug support for a PMU with a scope

This commit introduces a (reported) build warning in some configurations:

https://lore.kernel.org/all/20240911153854.240bbc1f@canb.auug.org.au

That turns into a build failure for some configurations :-(

A suggested fix was posted a few days ago.

--=20
Cheers,
Stephen Rothwell

--Sig_/smY3BmHj5Ku=0u/jB1puZt+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbrU5AACgkQAVBC80lX
0GzKJAf9GT3d8pjycXjf+9AP3bwANR/y/tjabxwDQJHWoRuKoWnodYiQxwu6iVdf
QEgI+KCH+NfwXVNIP4/zVaBsXL2BFCyoOrr9ZWzLOOrLBnoCWvMzC2+f0TW3YG3I
MVAH507r0Ygb/VtxaieIgCluXuGg0nTlFrjHo3Ul/COAp2WY1GcYB1eTppfTWdWu
wfIIKGZ7ByHJp5GUw7nlBmmkSMfN1OFeJfO6BBfzfMUJmt0bTIojhw+tYRiObAXX
7ISaSbVzdJyZ/6sdDfN8pzzfJsTxLzl3ON9gDBunk2MD8gAo1ZHApeEjB+8xbHsm
7xWIDaXo23MrJ//sR66smsO5/vc92A==
=rAW0
-----END PGP SIGNATURE-----

--Sig_/smY3BmHj5Ku=0u/jB1puZt+--
