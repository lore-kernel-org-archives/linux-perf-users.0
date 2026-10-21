Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792565126;
	b=Y6ni+6U/ZLcbBZp9GO1AJcl5sBNQx4dPzczCSv8MN3qjybaxdCWZzpGf3qpndqNOq/yG
	 w3lr7LN79ArU7exTTWJ0zYcDcG7UHYo508A57dHFo5y7UBs+cCO5y39Lpq8RpYnPrU8e5
	 QhUtO8S30EB9k+TPliaXJ4jpPdBGOnGxMhM7q76L2NGlxRXFE9P6JoLhgD0wIzc4bclMt
	 USir6gk6ve1IFdkleuFrOdIQHtIHXwcoEri2nS70oCPZBnWbNj6KzyShYVNTs48vvGkeE
	 gDY5hEcIP5T2DLukP0ZeEH9RibrWI7LHx7YCUqeJk8C/r3NJmI7sw/Xzq7jfR4SDMag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565126;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bK22br5gUxVkzFqqNv2xUfxvigTGevWZC5+h9zTzvM4=;
	b=fLQgLYt/QvStfBFDv+1aagg5mGKyMZDJ5kyFlWLGqIX96Rk/yGya+eaPb+r+niqFFs+o
	 uslGalXS2YI8YOanxxXtmt0uTt1quoXLgn4gsGmmoHWuDK+iHtIsVCI5d4rPu0LMqSA5b
	 VxH60Yw4yqNJbDpowfaCF/JJHYlVjvR9/R1T8e0ystUmb1UevyyML+Q/ipxCXBqR6Ha3/
	 IdvfkwK6E261GBZ4z55PF7OKx6XGAUDshREctta76ObPWgLg2hNxFoyY+M5/RB0MLz0aJ
	 SfaZW7tRoXnCW1sff4guoVwcGzFiAiUusk6pPSV93ZznPTiwxpYefurwp+4rVts96sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=BG1ECo7a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909E606A31B;
	Wed, 21 Oct 2026 06:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3909E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=BG1ECo7a
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5490F2022D8;
	Wed, 21 Oct 2026 08:45:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792565122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bK22br5gUxVkzFqqNv2xUfxvigTGevWZC5+h9zTzvM4=;
	b=BG1ECo7a/eUGPHyzUDzpCIueDb20L/00R6W3OjQBPK79ljMYmwzIcfF/iyZnisj3mEunJF
	edV7kmLFrKtZpJEsxMRfCelBPAFbu5KX+IWGufI2l2XukAxQwHW3uZ50vlTJSQf35j6Xp/
	5SEQRGk0NBge/YiJ0DnY1ZnB9nY/b0fA2qJsUv+RCkfip/CkC4fWGJHrJCiP+ipOEMLhpp
	b0NWcZkw+FNid20dGDT8FOc2vGG9XUd1EGNsWB/SzzarVjJp2H9GAUp2muMOkLpiTNR1tx
	vdAf3eyOJduRAaMScf4nI4fhDelaC+4gYdYrUdERP5PPJc0nw9WPB3faRqIqOg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792565122; a=rsa-sha256;
	cv=none;
	b=UOyKV9kBE2PBMI0vpumPT7RSFX1Hxg1DhyN0epBwXEwSt3Cz2YgDhxwzbrOBEjVvrBSxU2
	50yZcESH58Sl/3PojrLDm6XMK4nQtg6Co5CWkI7Rl+7R1QejbKggmicCPzU0kb4o5NVXGE
	J60jUvgQJGOvWsqiD8Cgfduq+U4dBrwSnXC9n91q78Z6p9S3e9f8iaQlLDyQVaSuXdUhf8
	33NGEHVmBPK6dPhVsncHe+sMfL6AZyE4KrnuR0TmyJnd6F1z2ehbeqmUMI7Po4I1GeCvt/
	sdvtIDI6cYyk3mIV/Fc7oIdIylfEVGfMhVAPZklC6f7XKpiYIXUKCzR2YsRe+g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792565122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bK22br5gUxVkzFqqNv2xUfxvigTGevWZC5+h9zTzvM4=;
	b=d96X3CdYWS/PSFREaAqdpJtOuk4Xow16CQ/cfuAz4y9+zZK0jntOllrrtO91c1dtT646dz
	flCfe7hzGw4RWhJq4CU2AzFbfRApt1kbyB4UpXNn6cyx3ZMYFZgnbY5tbjNgSlgEacZ0nS
	e5QumnMgF53RnjlNwaDx7aDaUryF9ceWAj+hQXTXlGpaIFhG4or00G9QraWrpmgfHEG/5C
	8ZT3AFxd/CYeRFfHNPwfNIzmaiGUi88959Ij2QIXzvqQlx8qWG+mBKq3WqJAinvf8xQ9G+
	bqt21GwL1MxVBzwJ9kvW62l++JTLyo7h6AEoDwX2KUi1/ziT6+jKUX83FSeduQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJQ4g-000WDV-0k;
	Wed, 21 Oct 2026 08:45:22 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DBACD5CAC5C;
	Wed, 21 Oct 2026 06:45:21 +0000 (UTC)
Date: Wed, 21 Oct 2026 08:45:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ian Rogers <irogers@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Stefan Kerkmann <s.kerkmann@pengutronix.de>, Christophe Leroy <chleroy@kernel.org>, 
	David Laight <david.laight.linux@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Eric Biggers <ebiggers@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option for
 ARMv5
Message-ID: <20261020-groovy-chimpanzee-of-exercise-8a9174-mkl@pengutronix.de>
References: <20261019201257.3805356-1-irogers@google.com>
 <31fe09f6-0a14-40fc-8ad8-c03998fb1f5c@app.fastmail.com>
 <20261020-succinct-zebu-of-vigor-6cb2cd-mkl@pengutronix.de>
 <d2afb4cb-145e-488b-8f6e-c83e38735526@app.fastmail.com>
 <20261020-nice-turquoise-dinosaur-3079bc-mkl@pengutronix.de>
 <a34133df-224e-4cea-b574-097ad37a791a@app.fastmail.com>
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
	protocol="application/pgp-signature"; boundary="ber3bezd7mvhap2o"
Content-Disposition: inline
In-Reply-To: <a34133df-224e-4cea-b574-097ad37a791a@app.fastmail.com>


--ber3bezd7mvhap2o
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option for
 ARMv5
MIME-Version: 1.0

On 20.10.2026 17:54:55, Arnd Bergmann wrote:
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
>
> That is usually a bug in the ethernet driver, which should take care of
> aligning the IP header in the rx skb. Many drivers do this using
> netdev_alloc_skb_ip_align(), but I see that fec has its own buffer
> management, so it may not be that easy to address here but would
> boost performance quite a bit if you do.

Thanks for the pointer - different topic though.

> > Comparing v7.0.12 with mainline "unaligned.h" and reverting commit
> > a339671db64b ("vdso: Switch get/put_unaligned() from packed struct to
> > memcpy()") brings no difference with respect to alignment problems. But
> > I see the increase in I/O performance (measured with "fio" [1]) on a
> > UBIFS/NAND file system:
    ^^^^^^^^^^

> >
> > - v7.0.12 NFS root
> >   User:           0
> >   System:         573956 (tcp_measure_rcv_mss+0xe4/0x1e0)
> >   Skipped:        0
> >   Half:           4
> >   Word:           573940
> >   DWord:          0
> >   Multi:          34
> >   User faults:    0 (ignored)
> >
> >   WRITE: bw=3D272KiB/s (278kB/s), 272KiB/s-272KiB/s (278kB/s-278kB/s),
> > io=3D32.0MiB (33.6MB), run=3D120532-120532msec
> >
> > - v7.0.12 NFS root, reverted
> >   User:           0
> >   System:         574214 (tcp_measure_rcv_mss+0xe4/0x1e0)
> >   Skipped:        0
> >   Half:           4
> >   Word:           574183
> >   DWord:          0
> >   Multi:          27
> >   User faults:    0 (ignored)
> >
> >   WRITE: bw=3D343KiB/s (352kB/s), 343KiB/s-343KiB/s (352kB/s-352kB/s),
> > io=3D32.0MiB (33.6MB), run=3D95439-95439msec
>
> Ok, so about the same improvement that you saw on ubifs.

That test actually was running on the same UBIFS on NAND file system as
Stefan's original test. Although I bootet the system by NFS root.

> > Booting from UBIFS, so only the lab background IP noise...
> >
> > - v7.0.12 UBIFS/NAND root, reverted
> >   User:           0
> >   System:         164 (rawv6_recvmsg+0x114/0x3b4)
> >   Skipped:        0
> >   Half:           0
> >   Word:           127
> >   DWord:          0
> >   Multi:          37
> >   User faults:    0 (ignored)
>
> At least it seems fairly safe to assume that your original
> finding is correct and my worry about adding more faults is
> unfounded.

Yes.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ber3bezd7mvhap2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCathffwAKCRDMOmT6rpmt
0tIAAP0dKhet7X01pv6Jrm8ojsxhxHRzlNFV5ftP9JAjAHmXVAEA7IQKE1OYnHIX
RUf2A3flqLg1uXT4ilqnaAw0Jhg+3As=
=eOTV
-----END PGP SIGNATURE-----

--ber3bezd7mvhap2o--
