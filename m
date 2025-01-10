Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B99206F1D
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540540; cv=none; b=osZWH5F9E8DGiD9vtD4o+tGZBRQGfrw8MwaS1yiAPlFckGUdSYwAG27M0zd0BMXm0+1V4XMFRa9iEQEEvTatKGrnxfTSj8piSWNhRLln8WFcefGLt1Muw4QGO3vIKfmUENpwzi9IcE+CThYdgxH4kSb8ymNVqCEqOMtr3K7Xd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540540; c=relaxed/simple;
	bh=X2r2zjBF27YbotUwfP/xNStnIXfpxoAr3T0wJFokBtU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gTb/iwVQ1Hgjf6Kbi1dl2NfkSk9dc26kQMgjGXewUv3f2i93/2RKXPCD375z+AypO7TeOnmTIFZsPBCATCh7Mc7faU24RF8QohHjoBYaENnUDTMkkhEab32qmyFUO3OJElsrnT0WRHr/whUMgp0Th+jey9aJskqNuZZCD5DMW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=GIxMxLai; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="GIxMxLai"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YVCkD2s2Cz9tJB;
	Fri, 10 Jan 2025 21:22:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	s=MBO0001; t=1736540532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2r2zjBF27YbotUwfP/xNStnIXfpxoAr3T0wJFokBtU=;
	b=GIxMxLaiol0pN3/3MqUx3VjJ86jFBtggeTLJsZo8Tddep+GwEqP/YHlrQl6NgEm2dgaVHy
	8bVw8iNpob6c0IRKsRCYoybOGZfQLhYjPXBblQJz9LMj/GmgAcQuY2lMTtqjY39rplB3Gj
	2jykWTZk5ZsVQtQJnnN5LS1yYGOZA18AH5fhriUJyGNtDh0NRVhaPxGj42n1IVpsHBsbGI
	JVJtVixX6lKFgH2BMgwGA9juIhqgKhIONFBTR1L5RD3KHy3PyV0/e31jB+yWZ0zSbhzZ0I
	UrqKkHPZMfI2CJD8JZ8vpP3tN4e8OchmaKOYgjvFJVx2zfQsSJEVnwE7mnFPpQ==
Message-ID: <6c81d671fc8e9f72ec1823eb0dd091a17cc7eefb.camel@michel-slm.name>
Subject: Re: [PATCH 1/1 perf-tools] perf MANIFEST: add license files
From: Michel Lind <michel@michel-slm.name>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users
	 <linux-perf-users@vger.kernel.org>
Date: Fri, 10 Jan 2025 14:22:03 -0600
In-Reply-To: <CA+JHD904E19iDzZ8HqcTwe61Wzp57_mkPuWz5miEztdd8jbVhA@mail.gmail.com>
References: <Z0Zcx0WRqtlUYpgw@hyperscale.parallels>
	 <2fe55e73d3ef64ec3bfc683446e3f1f8b9e8c9e8.camel@michel-slm.name>
	 <Z4BFcA0L3IfsmtbZ@x1>
	 <2a25433033c3b31f5c61b84ffb4efd51267ce3e5.camel@michel-slm.name>
	 <CA+JHD904E19iDzZ8HqcTwe61Wzp57_mkPuWz5miEztdd8jbVhA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-c6Gh7ujqIrgMB18iOC7Y"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-c6Gh7ujqIrgMB18iOC7Y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-01-10 at 16:51 -0300, Arnaldo Carvalho de Melo wrote:
>=20
>=20
> On Fri, Jan 10, 2025, 3:59=E2=80=AFPM Michel Lind <michel@michel-slm.name=
>
> wrote:
> > On Thu, 2025-01-09 at 18:53 -0300, Arnaldo Carvalho de Melo wrote:
> > > On Thu, Jan 09, 2025 at 12:55:16PM -0600, Michel Lind wrote:
> > > > Happy holidays all!
> > > >=20
> > > > On Tue, 2024-11-26 at 17:41 -0600, Michel Lind wrote:
> > > > > The standalone tarballs should include the license files -
> > > > > both
> > > > > the
> > > > > COPYING declaration as well as the text of GPLv2.
> > > > >=20
> > > > Just making sure this does not fall through the crack - does
> > > > this
> > > > look
> > > > good to merge, or are there any issue with it?
> > >=20
> > > Applied, thanks for the reminder!
> > >=20
> > Thanks! I don't see it in the perf-tools-next branch, but see the
> > other
> > MANIFEST update - I wonder if I'm looking in the wrong place.
>=20
> When I say "applied" it doesn't mean it will straight away appear in
> a public repo, I do some tests that take some time before making all
> public, which I did after you checked:=C2=A0
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
commit/?h=3Dperf-tools-next&id=3D74c033b6aa650ea7280221a9e57b7318a120978c
>=20
Ah, no, I do see that one. I meant the "perf MANIFEST: add license
files" patch that from the timeline should have gone in before the
bpf_perf_event.h one.

Thanks,

--=20
 _o) Michel Lind
_( ) identities:
https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc04f2

--=-c6Gh7ujqIrgMB18iOC7Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iI0EABYKADUWIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCZ4GBaxccbWljaGVsQG1p
Y2hlbC1zbG0ubmFtZQAKCRCLIp0vfMwE8sO5AQDykjCPWhU4n2imS8fTV2EUtNWt
Q0wMRZp9dx6BUrQ00QD+PdWzI/ykzCU7zibdCcqLwg2YdPxLiNyttyvni543kg8=
=xKlD
-----END PGP SIGNATURE-----

--=-c6Gh7ujqIrgMB18iOC7Y--
