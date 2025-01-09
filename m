Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7AD19995B
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448933; cv=none; b=pOqN08nNSkLY+0q3CF/RwWVxpxT6mDYaOQO6GjvQHoP0U4QYzntLPPgrruHYvKwlOba+i6xhko0J2VJlQJmKsK9UhzxqhS8lQhxTOs/NjdQb1Hp4QBKxw5bbHkazZk/A7RuyLAvxEyGeKqBydp79vsQeTRwFlPSkaUQgb6N5pos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448933; c=relaxed/simple;
	bh=EfcD7S6eGSTR18MxQzfD/LYLkKvBN2PW+5aD6vQXmOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CeY70mwKCbb0iSmWkwZuVC2UK7jACaSg2SzJyWtimw8dOKn/MKnHILqDi+GqTbd84BkVu57Op+/sDhFDIuZQ5VPBojrJUMIgJeJc9cmxxLfWR2u50MEAXJuK4EYuqDJsHFDtV+vhxg+OImUV/YbY3ABb4KdkDo79/8q95vgZwAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=Yqd2Vye7; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="Yqd2Vye7"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YTYrY6Kllz9shp;
	Thu,  9 Jan 2025 19:55:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	s=MBO0001; t=1736448926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EfcD7S6eGSTR18MxQzfD/LYLkKvBN2PW+5aD6vQXmOI=;
	b=Yqd2Vye7skWQlCd1jEJO1vIVjirKBHz1t6bFmam5h3pJfTrPydfD+lMplDukSWs7lvdF4i
	61LDgO3ExmB6HwlIJXnI6/xdXINMRW92cXOtQoEUDWsaf0+KdHJuC1eJFon9eITIWOPqyA
	4Gi0kwFjk8YZntEptp6v9FRf8RVCpEY5fpli6wHrkbRlNVYFEV0r+YuGcbb60C9c247rDe
	wDFoEkO2W5mjY2d7NBSKBcYz+4s/b6nB8z0l9yppXqm4TOb55BEYyXcAi2JFHWgm2LcP2U
	wqzSBm3S/IzDUKqc981JlNNFz2ZvEQ2XYlv9hCpX9YMnW1aNZcBtxpovSwK76Q==
Message-ID: <2fe55e73d3ef64ec3bfc683446e3f1f8b9e8c9e8.camel@michel-slm.name>
Subject: Re: [PATCH 1/1 perf-tools] perf MANIFEST: add license files
From: Michel Lind <michel@michel-slm.name>
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Date: Thu, 09 Jan 2025 12:55:16 -0600
In-Reply-To: <Z0Zcx0WRqtlUYpgw@hyperscale.parallels>
References: <Z0Zcx0WRqtlUYpgw@hyperscale.parallels>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-u8TbdHhMN37c959e7OL+"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4YTYrY6Kllz9shp


--=-u8TbdHhMN37c959e7OL+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Happy holidays all!

On Tue, 2024-11-26 at 17:41 -0600, Michel Lind wrote:
> The standalone tarballs should include the license files - both the
> COPYING declaration as well as the text of GPLv2.
>=20
Just making sure this does not fall through the crack - does this look
good to merge, or are there any issue with it?

Thanks,

--=20
 _o) Michel Lind
_( ) identities:
https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc04f2

--=-u8TbdHhMN37c959e7OL+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iI0EABYKADUWIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCZ4AblBccbWljaGVsQG1p
Y2hlbC1zbG0ubmFtZQAKCRCLIp0vfMwE8mMmAP4wk6e+/dTFTucUtRIuFshk3Omx
xfsg5kEKzjCAC0G0tQEAtWLQzZ2zCWMcqzOtpPYOTy4+LIKqKQiDwoN63G9t+AE=
=EXpR
-----END PGP SIGNATURE-----

--=-u8TbdHhMN37c959e7OL+--
