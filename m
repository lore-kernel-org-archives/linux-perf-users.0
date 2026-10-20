Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792508210;
	b=Bni8oMIwbRNRoQFYvjWkI+ltG3s8KtzqfirdAOn+5CDR950XCVI7Bp+Fx4mjpg7UtfSn
	 oJLysPsd3sOfnGaTuoSYYocTtUggKmxULZ3xbwKvCm1ZHf6rXyI56PiGHunJSIj8cVmAa
	 JR2tO/6F28Cd+RgFiAyMoAy7Wd8x+03uVV4gKX8+vfF/lUv6SzRIh6KrTPJTGhxmUgIF8
	 MfqPrpis/1n1faVVEIpdH5+xIy7vrgd1fsA2z43vRL1TVa4vlLkRxAfV/ZW2vE/2GyKF+
	 bmnVYIQI9/5DZTC77ErAmri2aawmiyyrp4+GzwMWViLSbwb+I6jG1Ydvk0mCuorbbTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508210;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=z7hyor3V7NCkDXhpjIsj0qXch5Yd0OS9KGAsliCZzWs=;
	b=Jagup4zttIGYjshg8H9kAYoWs5JGL4+XO2cJ6IfIFoWTZsof6r7Mu53fFXO+ViCsRtUm
	 lb3o2gLz8x/pBNwLYlYVz+ggpvPjV53CI5hWT9JNXgmVbI/OZ1Stn+GvLbvPZsOR+PaOf
	 CXIfjO/Xxf6DJZ44dq/VPNs73+plNo7uDuy/mcOYu3jr8rL87pEgrhHfZO9E7dUehWdbW
	 r9DA7qcxlwUswjBv0pIGol9bjwh1GMDEyBvo2fmiMMZzkuLzJa+Z+oxxRWmHmd+dm+CX6
	 aGwGc2+Uro9SmvnR7fyNnyVWCl4xQUHCav0ViBt4V1m+uWcoZBrNpY362mLXP45bLqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NWbVFZu6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E205606A31B;
	Tue, 20 Oct 2026 14:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E205606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NWbVFZu6
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0E3DB200758;
	Tue, 20 Oct 2026 16:56:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792508201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z7hyor3V7NCkDXhpjIsj0qXch5Yd0OS9KGAsliCZzWs=;
	b=NWbVFZu6ByMcnPNP3lGEY0dEi3jYwNh4jmk+MGYrYBo6zjJR2gM/LT25svNVoIde0CpLsj
	l9L13HcP+zcRjbj6wUnaqkA04E6N3Se0wb6zaU2pfUdsUBlRZr4qEs146B9SETWnDzCz8A
	fRqrJ8cADsA8HNzkW4ZjGW89mSIJpVzXTLnTZl9SgsFE4jkiaC3XSKjHVzurAB8WCAYAyZ
	7Limwu3oDvwa4fGVv1IZxQlOsBHRXd9cM3dTLqnkPVbvcclVThprxP13KCc8foLokDuarH
	5elDwyzoMstD1wZ1FuDAPbAktwsKVDgmwL0JFuA2cj2HID+AVyzcMugGEOmGFg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792508201; a=rsa-sha256;
	cv=none;
	b=SY4dis5RcNkjPa5nzJtfoaTnSSaa9OIp4zUGYyZGQaJv7UfRrEOT+rBp5sdAFlL81sh432
	wdPEr1GFulc7kavizHSLBvoOvjn6H1VSsAFsgFIFWyvguG5YxutCQawNSd75IFk3tTu+ZM
	xC4ZVHWx0uJ+k2HIyLneZfEg9qiygFw2w+dJmH15NfG7Zt+6fS1WVbduU/ds54bjXwd9Sv
	eRIvlGN3PriXRqJaViSgeHsdd5xGKE9E9c3aFjy4lAHCqKpAeX3nVyRPCN2ve5IngdVJi/
	IXDH+5vx0YhaSyDajEI24322QifTdJb8RghKCMLJdaGPWwk8iW+ROy1HOkXpGg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792508201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z7hyor3V7NCkDXhpjIsj0qXch5Yd0OS9KGAsliCZzWs=;
	b=FM4ZunsJ+kQMsi+yFxiQ+RXrFkHfMJ67hEmsaqmCc51hippijRy8KvIPZUMhUm2XUK1zUV
	fRSleIPQRnNuzj5FmikWEJE1sL+g4EBOTvhMiGNNIDXLYuL29/hiNVAJYiITPUpDPDwbcm
	McNEsEIamCkVuloEqfZiLqyaAa5jdUhZHkQh8ETIfpsskVpLs2vYw1SvrxcTH8lU6o+cEN
	3sB8MbdDM/XV88jWyc5mSIYaDxmeUq5fGiHtVWPesEyooyB4IXEAFwedVjeoFRM+JC+2G9
	/GXNB/8s3Hl9AStY7XWHWE6SmtgQNfTW+mjIm8mUgXHvfsCwiY1GWMVFOXg6Sg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJBGa-000O3o-2y;
	Tue, 20 Oct 2026 16:56:40 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 941D05CA33F;
	Tue, 20 Oct 2026 14:56:40 +0000 (UTC)
Date: Tue, 20 Oct 2026 16:56:40 +0200
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
Message-ID: <20261020-nice-turquoise-dinosaur-3079bc-mkl@pengutronix.de>
References: <20261019201257.3805356-1-irogers@google.com>
 <31fe09f6-0a14-40fc-8ad8-c03998fb1f5c@app.fastmail.com>
 <20261020-succinct-zebu-of-vigor-6cb2cd-mkl@pengutronix.de>
 <d2afb4cb-145e-488b-8f6e-c83e38735526@app.fastmail.com>
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
	protocol="application/pgp-signature"; boundary="rnutmabie7k5dfoc"
Content-Disposition: inline
In-Reply-To: <d2afb4cb-145e-488b-8f6e-c83e38735526@app.fastmail.com>


--rnutmabie7k5dfoc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option for
 ARMv5
MIME-Version: 1.0

On 20.10.2026 10:24:51, Arnd Bergmann wrote:
> > FYI: there is the kconfig Symbol HAVE_EFFICIENT_UNALIGNED_ACCESS. Can we
> > make use of it?

Just noticed that sashiko's review contained the same remark, but the
bot only posts to the linux-perf-users@vger.kernel.org list, where I'm
not subscribed:

https://lore.kernel.org/all/sashiko-outbox-178182@kernel.org/

> That would be better, but I still hope we can just get back to the
> portable code across all architectures for the in-kernel version.
>
> I have one more request for you: can you check /proc/cpu/alignment
> on the system that shows the performance regression with and without
> the patch?

When booted via NFS-root to the login prompt, we have about 570k System
alignment fixups, all in the IP stack: :/

__udp4_lib_rcv+0x78/0xc6c
icmpv6_echo_reply+0x160/0x504
ip_send_unicast_reply+0xf0/0x3f8
ndisc_send_skb+0x15c/0x40c
rawv6_recvmsg+0x114/0x3b4
tcp_rcv_established+0x3ec/0xba0
tcp_v4_fill_cb+0x70/0xec
tcp_validate_incoming+0x540/0x868

Comparing v7.0.12 with mainline "unaligned.h" and reverting commit
a339671db64b ("vdso: Switch get/put_unaligned() from packed struct to
memcpy()") brings no difference with respect to alignment problems. But
I see the increase in I/O performance (measured with "fio" [1]) on a
UBIFS/NAND file system:

- v7.0.12 NFS root
  User:           0
  System:         573956 (tcp_measure_rcv_mss+0xe4/0x1e0)
  Skipped:        0
  Half:           4
  Word:           573940
  DWord:          0
  Multi:          34
  User faults:    0 (ignored)

  WRITE: bw=3D272KiB/s (278kB/s), 272KiB/s-272KiB/s (278kB/s-278kB/s), io=
=3D32.0MiB (33.6MB), run=3D120532-120532msec

- v7.0.12 NFS root, reverted
  User:           0
  System:         574214 (tcp_measure_rcv_mss+0xe4/0x1e0)
  Skipped:        0
  Half:           4
  Word:           574183
  DWord:          0
  Multi:          27
  User faults:    0 (ignored)

  WRITE: bw=3D343KiB/s (352kB/s), 343KiB/s-343KiB/s (352kB/s-352kB/s), io=
=3D32.0MiB (33.6MB), run=3D95439-95439msec


Booting from UBIFS, so only the lab background IP noise...

- v7.0.12 UBIFS/NAND root, reverted
  User:           0
  System:         164 (rawv6_recvmsg+0x114/0x3b4)
  Skipped:        0
  Half:           0
  Word:           127
  DWord:          0
  Multi:          37
  User faults:    0 (ignored)

regards,
Marc

[1] fio --name=3Drw \
    --filename=3D/var/stat/testfile \
    --size=3D8M \
    --rw=3Drandwrite \
    --bs=3D4k \
    --direct=3D0 \
    --fsync=3D1 \
    --numjobs=3D4 \
    --group_reporting

FYI: disabling CONFIG_FTRACE brings +8% compared to v7.0.12, reverted:

- v7.0.12 NFS root, reverted, w/o tracers

  WRITE: bw=3D371KiB/s (380kB/s), 371KiB/s-371KiB/s (380kB/s-380kB/s), io=
=3D32.0MiB (33.6MB), run=3D88411-88411msec

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rnutmabie7k5dfoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCateBJQAKCRDMOmT6rpmt
0qTQAQD+0twXiBtm1f5Q8GEjWr6s/qMbOE4NjyU64PTPctEesgEAusLAAUW3w6kB
9ec4joMn0P2OvGy5LAayPT1yehDe5wM=
=0UGb
-----END PGP SIGNATURE-----

--rnutmabie7k5dfoc--
