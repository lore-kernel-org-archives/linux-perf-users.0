Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792478769;
	b=ReH5O4tlaP8iFkNtOklf41KtAUtRCjnbLlr1vTelgcg/yAagcFbetrFf3E/WKv95ce5n
	 0O6kZqgxqWtEBxrhYxL6M5poKcY+iqv9QID8FSvp5PUBYD8L5PqRuHulcgW0BpDhNIWm0
	 5YCjaZ4MYd4GVvejY+H4RAW1INcDuotKly2eOxt19rxCdUkGrQYDh6lgIEeShtu1VY78j
	 CDfJ9OU0KGijjzcK65+Gzqw+GlTvv6IV/R8x691EmdJhTvzqWpfjyESbKX5/e2wymO9VN
	 aynzdKHUo4PyLCLDayDUdteoW5Qy6GgiBAV586udVNKaTeKofIHX89mtP+xLPJHQ2ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478769;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=DjJ6aF4EEfNV1D/BCrVjMeW97sw80s+KxqGk+wmMMMQ=;
	b=ej7zT9P/JMJylu5itB8YTUsMdJZhMZjBc9X3R6W7g/fuyxNUUiqiZidgUWir/9T72n0E
	 +iyAWNo6qO5ATida4cBnEZjrs15gUmRTmVj+qYuqPeeM7S60CP+Kgg3l4b07+nVq2En8g
	 LE33KinKTjuN2YqX8tRYFa3QSA3BCjZmzHcMiM1+sm8UxbX2h1S8ZupActs0X8qvlF5Kf
	 WPy0kLMPpSAO8lCwR8CjsshAYUI9Csgo2KoOSvT5MVNYQsIge5FjffbBSz3w3Uv7GrGuX
	 u5z5aE/WWyA2v8R/6heCWykV+DxFJLWpYP3CDEUcQ3W/ArgkEsKgVabfYvF9vAXgEYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=A4dqaE0B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA8606A32F;
	Tue, 20 Oct 2026 06:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EFA8606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=A4dqaE0B
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 807A62017C1;
	Tue, 20 Oct 2026 08:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792478763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DjJ6aF4EEfNV1D/BCrVjMeW97sw80s+KxqGk+wmMMMQ=;
	b=A4dqaE0BC406CMyqi1KhvCehlKud1+GI/NyJ4gSCPHaEMReYeqh/9h7GbancwxlmWIECcq
	8PHT5RtYEcpjavaNK9DDNpRQ4fWno2To0kXbAVvPzDYT+0W6poXflHoLlDvUyUC6xMDERq
	UiLfaCc6In6Lqnms6sOfvVrlSl0SAmEjtp+mAk8D7CMfblc5MjGU8fHG9nebqDsAnQ6mA7
	MS0u2rM+DMczgvm8bUUwy1Dn1XJsYGieqT1Q7Kai4f3OWusWXjnGVkIoGW7zwzfi8Gw/MT
	Vwh2EW9tsVl5pfPFA30QmYa2QCke6lh1SXqHJfE61KHAW2TUDfRkyW6x+77AbA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792478763; a=rsa-sha256;
	cv=none;
	b=PFNwBlpd7AofRpN/rO4FPQhyJfd3X4ew5j6h63qfWYJWXylD2TV8zgLH9vgW+5Pf7Y4D5h
	fmNZshb3XO+BySsnnzbbL7rXxBTnJ9sm6KJRySQkpHJPVt0LcPp1bWCAAcYBmYYGGNRU6t
	36F9V5kz7JGw2ItS6yhfGUgUFr/Sn2AaTWZLoBLXONlpikzPOttfBjtDIcXLTqljkpT5Ve
	FYXBZbfgwHQnOY82b9nhAObD4wut40m/p+c9AfIKFmdMVVedWWPIT7gegU/YQh0Rv03622
	LpBMwYZikROg6EMWpE0oeq0ILeP7Z2WJ2z/DMgLoyW318+PZ3/KC+8yYxJCx8w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792478763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DjJ6aF4EEfNV1D/BCrVjMeW97sw80s+KxqGk+wmMMMQ=;
	b=QXin73Z1/KIUpy0eqj0IXU6PiO0NoTvNldx+fnhl93+gW6Jz0yThXy/6OD5HGZMPhG7PDP
	5lXwMonYyK5xdDzuKoZJBsbjq5uUZmXH9zo6vE/OHikUEmoKCZrv5LGI/gi5IaHVnU7dla
	CdRR2O2fyEId3ivxS8WDE47GQbwvt/bbA2tDdelnrHR00yvFxFZLO2NNNHOwhHlSRIc/4+
	cwgbFl6QZ44uwk1SSYiuHdSyJrqlknkgKHUEltC4MZFfmLgmPk254yuoIjvHwOQYlBpFBw
	bS2cpQPAmocby3PLh6QNKitTZcw7/OnkE5tr7rv7dW0IPvLwg6/wQJrynEi5eg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJ3bn-000KgQ-1G;
	Tue, 20 Oct 2026 08:46:03 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E894A5C9BBF;
	Tue, 20 Oct 2026 06:44:18 +0000 (UTC)
Date: Tue, 20 Oct 2026 08:44:18 +0200
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
Message-ID: <20261020-succinct-zebu-of-vigor-6cb2cd-mkl@pengutronix.de>
References: <20261019201257.3805356-1-irogers@google.com>
 <31fe09f6-0a14-40fc-8ad8-c03998fb1f5c@app.fastmail.com>
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
	protocol="application/pgp-signature"; boundary="6qea3f7c45xlx244"
Content-Disposition: inline
In-Reply-To: <31fe09f6-0a14-40fc-8ad8-c03998fb1f5c@app.fastmail.com>


--6qea3f7c45xlx244
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option for
 ARMv5
MIME-Version: 1.0

On 20.10.2026 00:12:57, Arnd Bergmann wrote:
> On Mon, Oct 19, 2026, at 22:12, Ian Rogers wrote:
> > +
> > +config VDSO_UNALIGNED_PACKED
> > +	bool
> > +	default CPU_32v5
> > +	help
> > +	  Use packed structs rather than memcpy() in include/vdso/unaligned.h
> > +	  for unaligned memory accesses. Enabled on ARMv5 where GCC may emit
> > +	  out-of-line memcpy() calls instead of inlining byte accesses.
>
> As explained, I think this misrepresents the problem as Arm specific and
> isn't the correct method for -munaligned-access targets on Arm, which
> include CPU_32v3, CPU_32v4 and CPU_32v4T along with CPU_32v5.
>
> I still hope we can use a version that just produces the intended code
> on both -munaligned-access and -mno-unaligned-access targets like the
> old version did.

FYI: there is the kconfig Symbol HAVE_EFFICIENT_UNALIGNED_ACCESS. Can we
make use of it?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6qea3f7c45xlx244
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatcNvwAKCRDMOmT6rpmt
0jcxAP4+OJR4f1ri/sD2ri5ZdsCmwGcY28sq9qfO2yECm9kV/AD+LrphmAxqvEbJ
Ma0FGykZK475iITqX2YOZ1BLSUr4dAM=
=v2z9
-----END PGP SIGNATURE-----

--6qea3f7c45xlx244--
