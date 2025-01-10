Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ED7206F3E
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736548658; cv=none; b=W3COIe4OMLKaRwijHbLCytzK4hnzbkl/cfk1A1fVUJX+tEhJ12qBIeuyr3IE4Vl6Zq3ujVtjQUdoHxBtkfGzJS6Uda4zBbDcVSKwJ6edFjg1pnJIE8LzkGCD6LE+Xygw9itWD5olqOl1UbglqfEwKOzOr+Hd+wMD+sJBcyrUfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736548658; c=relaxed/simple;
	bh=ncMeCvm69LYCcYXCpOm23nEqhzYMcHT4byBJHzv9bZY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhpTSQNB5UfdcxhElNlB9fwdO8txtHZ16Bj0X+lU3k9W93CGVRDv5PnN1n4hvPjykEtn8mNRt8fdLkX9PUR+co7KPL0QBevQ29mQhV9xUyd5eIS1OiRJuRgzBwEY6ES8qYyYlJYUe3Y0roagdzQ6AhaPMTnB2y+H4Cqv3PtUEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=IxOEY+qI; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="IxOEY+qI"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YVGkN0B32z9v9n;
	Fri, 10 Jan 2025 23:37:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	s=MBO0001; t=1736548652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ncMeCvm69LYCcYXCpOm23nEqhzYMcHT4byBJHzv9bZY=;
	b=IxOEY+qIvGRZhwXgmPaNzXYlwp1JL/hhE5H4kWEnytGKlcSeopKDc3puCch5VYRE8TYoxC
	6Dy8Lw8e/UIvVqSgaIJkjqIvtWmAEErVw/+DqKnExirHvg8JvPnaBGXrmsmxvSum8NLk/Y
	8UBvIhjwoJa0qrCRUa13ht2eFiaVgxSLCM7jczsNaTkq3NV+CXhqwbDon6xRtQ8/Y5Qh3k
	3A2aVmua2Bq9AIO4E6Sq7gCkoZCn87BhrNFYc1eCWXH2YESOnJTMGvqt3PfcM8t93D8xJy
	Dv7zhz6ByP3/QyHnaTy37S3Iul7pSl3LHCLvmcUJ7Y/KgVIl3TroQSgMgfuUpA==
Message-ID: <8b6e4382cad6a98461863454a8405fa78ed3b591.camel@michel-slm.name>
Subject: Re: [PATCH 1/1 perf-tools] perf MANIFEST: add license files
From: Michel Lind <michel@michel-slm.name>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users
	 <linux-perf-users@vger.kernel.org>
Date: Fri, 10 Jan 2025 16:37:23 -0600
In-Reply-To: <CA+JHD93YcNEaLgasSsjAmo7fWe4gy-5d90NCdxYUwPdgRuPL2A@mail.gmail.com>
References: <Z0Zcx0WRqtlUYpgw@hyperscale.parallels>
	 <2fe55e73d3ef64ec3bfc683446e3f1f8b9e8c9e8.camel@michel-slm.name>
	 <Z4BFcA0L3IfsmtbZ@x1>
	 <2a25433033c3b31f5c61b84ffb4efd51267ce3e5.camel@michel-slm.name>
	 <CA+JHD904E19iDzZ8HqcTwe61Wzp57_mkPuWz5miEztdd8jbVhA@mail.gmail.com>
	 <6c81d671fc8e9f72ec1823eb0dd091a17cc7eefb.camel@michel-slm.name>
	 <CA+JHD93YcNEaLgasSsjAmo7fWe4gy-5d90NCdxYUwPdgRuPL2A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-GrP/jo3qsXdWQ91+2tWv"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4YVGkN0B32z9v9n


--=-GrP/jo3qsXdWQ91+2tWv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-01-10 at 18:06 -0300, Arnaldo Carvalho de Melo wrote:
>=20
>=20
> On Fri, Jan 10, 2025, 5:22=E2=80=AFPM Michel Lind <michel@michel-slm.name=
>
> wrote:
> > On Fri, 2025-01-10 at 16:51 -0300, Arnaldo Carvalho de Melo wrote:
> > >=20
> > >=20
> > > On Fri, Jan 10, 2025, 3:59=E2=80=AFPM Michel Lind
> > > <michel@michel-slm.name>
> > > wrote:
> > > > On Thu, 2025-01-09 at 18:53 -0300, Arnaldo Carvalho de Melo
> > > > wrote:
> > > > > On Thu, Jan 09, 2025 at 12:55:16PM -0600, Michel Lind wrote:
> > > > > > Happy holidays all!
> > > > > >=20
> > > > > > On Tue, 2024-11-26 at 17:41 -0600, Michel Lind wrote:
> > > > > > > The standalone tarballs should include the license files
> > > > > > > -
> > > > > > > both
> > > > > > > the
> > > > > > > COPYING declaration as well as the text of GPLv2.
> > > > > > >=20
> > > > > > Just making sure this does not fall through the crack -
> > > > > > does
> > > > > > this
> > > > > > look
> > > > > > good to merge, or are there any issue with it?
> > > > >=20
> > > > > Applied, thanks for the reminder!
> > > > >=20
> > > > Thanks! I don't see it in the perf-tools-next branch, but see
> > > > the
> > > > other
> > > > MANIFEST update - I wonder if I'm looking in the wrong place.
> > >=20
> > > When I say "applied" it doesn't mean it will straight away appear
> > > in
> > > a public repo, I do some tests that take some time before making
> > > all
> > > public, which I did after you checked:=C2=A0
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/commit/?h=3Dperf-tools-next&id=3D74c033b6aa650ea7280221a9e57b7318a12097=
8c
> > >=20
> > Ah, no, I do see that one. I meant the "perf MANIFEST: add license
> > files" patch that from the timeline should have gone in before the
> > bpf_perf_event.h one.
>=20
> Indeed, I though it was there as well, will make sure it gets there,
> thanks for pointing it out.=C2=A0
>=20
Thanks again! If it no longer applies cleanly, I'm happy to redo it.


Best regards,

--=20
 _o) Michel Lind
_( ) identities:
https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc04f2

--=-GrP/jo3qsXdWQ91+2tWv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iI0EABYKADUWIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCZ4GhIxccbWljaGVsQG1p
Y2hlbC1zbG0ubmFtZQAKCRCLIp0vfMwE8jeqAP4u0+krp79+uaWcsGpXZ0gN1DBJ
vJCuac9zWVE/5+V2VAEAxqVUYmttl61H5cxBYu76HNXo9pCsfROeBo3Hfl6hhgI=
=O3PB
-----END PGP SIGNATURE-----

--=-GrP/jo3qsXdWQ91+2tWv--
