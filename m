Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792565451;
	b=R2V4B04QhwIVh9Yeb0BbhglpDcqTJBB1zW5WpZwFGjaG51SM1CsYmqvJN4inZUo6TDRt
	 csD3QBBCKFQkQcowOmeJmVvppSrUKmq4LyU+WSpjHvnNAfCxlfKZCjZXtQgcSekYrlTpC
	 NsxeFSrsAIrXe09JZG5ekQvMIsiZah0gW8qsn/xzVhRpKXfrYwoG65oZ2ZVeEVf+t+0hL
	 ISLJzn6IgINR0S6T85Bi2flsrVW87l3340QXggaOPfkBmF6gj4fS78n/LhOusHOwsh7qM
	 zu4bLKvx1l4fsR9h8gJ4/lpkdCyuk+xN/W3UWnw6UutrsWLRzynQFS2oT555wn9jkBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565451;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=b28PeOVx01PEPWf7+OjZT39YwbUWJM0RbZunVa/5h6c=;
	b=Mg+6vWE65uj+gIRa/MS56Yt8QRSzvzoHmJNX8U3Pibxb4WreGvVfkCvrDooe9aMX18bd
	 Ca/xwkLCCgONL2RuhRbq5CVwSJmHTdKvFCWpv7pwb83Hg+ixjiL4b3TT6p998iPkRqfba
	 DWMMn+HYl1deG6/oqV3j9iTaCwqTu03xRm8vMf+O92KeBQzHKrjZTtYXcNb+0C37gXCb3
	 sVLprms1u2kVPZdBGGXuRVthV1LEj/bDOKbGYh+JAS4RSddrXvCJgeTlgumGUwpOHj8FF
	 gF1YWHWBTfBgo+DJmpg8s4CfEtK6lH5ctzxIxjIEiaytRKuOCG5ykGcMo/7OjXojszg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Pk9KJj6N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987C8606A319;
	Wed, 21 Oct 2026 06:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 987C8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Pk9KJj6N
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D17DC201EFE;
	Wed, 21 Oct 2026 08:50:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792565447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b28PeOVx01PEPWf7+OjZT39YwbUWJM0RbZunVa/5h6c=;
	b=Pk9KJj6NNTAyBumlBwrGQFh3IwFu/KUMFkVLpCocWI45So8ANtmvL1qpI/3Nzlgk78jgsN
	XUyJDYOSlUQ6/Cx5BLlsHQgK2fBmdpMCJcqxEgrxn+Z8XN7YTzYNI39jALrqSdaW2JGXHp
	M0V7WV/gV1y/zdhj2uJonptmzAKLR+GOsEK+S69JONbfW8XFp/9m5VKTZi4HVLIc9SYMBQ
	1i0af+u4KaY07Ixiym8So6G+kGlvLfG/ChR6lp5yk4YJBvOIXIgfwaulNF6SDKpMExJPoM
	JAjmbVjFJizGGrK2x6ck/eYyykNXan1GoOiBpOkGF7P7J8Cow+nqjYKM06aBGw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792565447; a=rsa-sha256;
	cv=none;
	b=R7f1MoC+ztM8Xe0ZhyAqK6v9lhBzvumacSn6+vnFdkTuQvdfO1KMdczao588PvAfT0pG/m
	mWalfb/llEk4plY6vEUJs9zuI4vCtqbwhVAbh40loO3MOz22pii7C4IRakqlkfLIEK/FKj
	8odS/5ZwnYjl6QLEE/LlTIlXJJE+4W4Q/2ch7QV6G7kETcfnao9/36kYvA0Z6oBjlex7Ku
	HwAZwOg5a2DP4gPldK9iFfUMFCvEeGt7Ovc/TO4X8HftMs3t2YFwOs2KCu21pX8tlPXNg9
	xPS3QhYTQHGdXrFgHhM7Hd43cIleJ3Yey9y1SwFD5oFqa70CI1zL18Key+vwqA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792565447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b28PeOVx01PEPWf7+OjZT39YwbUWJM0RbZunVa/5h6c=;
	b=LLi20wFyflKJ8hKz9Z41kxY804TAFuBpx16hva2N+MpiUIvd7tPUTM/EqhpQwKY6QjI8Si
	yGgpfmNlllt6TM9bJyPSTKGoOMb/9cqHoFLTt2x0Wr+JeJUU2pBPdaOyW2uVysxgsdBpn5
	HygSNQhP7fRC3qVpmIqenZwZfDTn0lwQVJY7/cFkZCbpjY/WHo+503ENAcIEfcWkmcy7Ew
	ACtY8LWZnhBLzAMkZcQJXCMSaVvLmFqgjAu52Ty42uw9C2LhvZgDi6FlSu2hQxsNr7+axo
	ZdrkPIkdmXo+13TxxrRXEm2GouW3g7fNR78Esfy/cHawuvSkvTYJ1WJC8us6eQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJQ9v-000WDb-2R;
	Wed, 21 Oct 2026 08:50:47 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6995A5CAC6F;
	Wed, 21 Oct 2026 06:50:47 +0000 (UTC)
Date: Wed, 21 Oct 2026 08:50:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Laight <david.laight.linux@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ian Rogers <irogers@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Stefan Kerkmann <s.kerkmann@pengutronix.de>, 
	Christophe Leroy <chleroy@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Eric Biggers <ebiggers@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option for
 ARMv5
Message-ID: <20261020-orthodox-positive-heron-e20628-mkl@pengutronix.de>
References: <20261019201257.3805356-1-irogers@google.com>
 <31fe09f6-0a14-40fc-8ad8-c03998fb1f5c@app.fastmail.com>
 <20261020-succinct-zebu-of-vigor-6cb2cd-mkl@pengutronix.de>
 <d2afb4cb-145e-488b-8f6e-c83e38735526@app.fastmail.com>
 <20261020-nice-turquoise-dinosaur-3079bc-mkl@pengutronix.de>
 <20261020165101.5e74ab2d@pumpkin>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nxslrybgurijn4zy"
Content-Disposition: inline
In-Reply-To: <20261020165101.5e74ab2d@pumpkin>


--nxslrybgurijn4zy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option for
 ARMv5
MIME-Version: 1.0

On 20.10.2026 16:51:01, David Laight wrote:
> On Tue, 20 Oct 2026 16:56:40 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> > On 20.10.2026 10:24:51, Arnd Bergmann wrote:
> > > > FYI: there is the kconfig Symbol HAVE_EFFICIENT_UNALIGNED_ACCESS. C=
an we
> > > > make use of it?
> >
> > Just noticed that sashiko's review contained the same remark, but the
> > bot only posts to the linux-perf-users@vger.kernel.org list, where I'm
> > not subscribed:
> >
> > https://lore.kernel.org/all/sashiko-outbox-178182@kernel.org/
> >
> > > That would be better, but I still hope we can just get back to the
> > > portable code across all architectures for the in-kernel version.
> > >
> > > I have one more request for you: can you check /proc/cpu/alignment
> > > on the system that shows the performance regression with and without
> > > the patch?
> >
> > When booted via NFS-root to the login prompt, we have about 570k System
> > alignment fixups, all in the IP stack: :/
> >
> > __udp4_lib_rcv+0x78/0xc6c
> > icmpv6_echo_reply+0x160/0x504
> > ip_send_unicast_reply+0xf0/0x3f8
> > ndisc_send_skb+0x15c/0x40c
> > rawv6_recvmsg+0x114/0x3b4
> > tcp_rcv_established+0x3ec/0xba0
> > tcp_v4_fill_cb+0x70/0xec
> > tcp_validate_incoming+0x540/0x868
> >
> > Comparing v7.0.12 with mainline "unaligned.h" and reverting commit
> > a339671db64b ("vdso: Switch get/put_unaligned() from packed struct to
> > memcpy()") brings no difference with respect to alignment problems. But
> > I see the increase in I/O performance (measured with "fio" [1]) on a
> > UBIFS/NAND file system:
>
> So the nand fs is hit by the memcpy() but there are misaligned transfers
> in the network stack.

Yes, I came to the same conclusion.

> > - v7.0.12 NFS root
> >   User:           0
> >   System:         573956 (tcp_measure_rcv_mss+0xe4/0x1e0)
>
> I can't find __udp_lib_rcv(), but that looks like it could be from expand=
ing
> tcp_flag_word(tcp_hdr(skb)).

yes

> Which would rather imply that the network driver isn't correctly aligning
> all receive packets (honouring NET_IP_ALIGN).

ACK

> When I were a lad the kernel just paniced and userspace core dumped :-)

I still remember the good old days with OABI, without driver model, nptl
and git :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nxslrybgurijn4zy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCathgxQAKCRDMOmT6rpmt
0jDRAQDdKivpD4Ek6H8Y5pc2nAnk6NZG0qLUVYsEy7vIcCQVnQD/bUYp632Mtjg0
/gMM5WjrAcuwtNLp9usZ6SRndk/o7QE=
=Ktqs
-----END PGP SIGNATURE-----

--nxslrybgurijn4zy--
