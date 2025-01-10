Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30B721516E
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736535545; cv=none; b=esiR8HBosrD30ejJYpo2Pw26hAzbo+YSvo14tfncjdMkPJgnWvMi08zR2RtGQI9jUYdauCd40l+oyhBmhZ5nqRu9aO+6/COahSHaav/rIyTfMtJ1/3FwqzbK7PBjPWT9w/+YBdNvUW9crZqB36DXBLbFzykdLs6vWfxh5fcMYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736535545; c=relaxed/simple;
	bh=NrqfJKFsnqvJuMT7ud2vLyWJdQ6uvGW0sfV/fc8ReGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gRStViO8Rbh2w9RGTqc+OeEeks5J+Y0stNSQqTKnQ562CGXZeCrsP76d1gPc3UaEGUbDq2hAhrKO6burLONDSR2z/PN7Wa8WgDvWfAIA5mFLtJ4+z/GGIraqivr8XekSCIdxztyi5ETyvr5E6mgHPLz9OhB+X6ZkGp0RPVKOhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=PBPlzme9; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="PBPlzme9"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YV9t50kdhz9sc8;
	Fri, 10 Jan 2025 19:58:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	s=MBO0001; t=1736535533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NrqfJKFsnqvJuMT7ud2vLyWJdQ6uvGW0sfV/fc8ReGU=;
	b=PBPlzme9WwbUPQpm6tmQHnJCZNgBd5xle425wMiCXZCWWDLKoC8BrbxFSG3sg1w//dSaRO
	zoNKciNlHm8j1SHFvNtnBvmX9lDW8Rqvu5O3nTdViaXZZr1XbZHvJma5IKFN6tFjaMYIUq
	33VsQ47N84iF5Vtq4dpizqdod7VF4yUnbUWBINJ1uaucLxIgcg70VKtnHAjOm/m9z9zzXW
	GZzVYPLzMQLQGCbph6xhAicJe+akXKMOA316B4EtvzI/NluSRAbCeDZyp1FJpbYDAqvsHy
	slrwqSUwT4MksL1JebMPPt3x+FbpMvhjjq/L+NpGpr1GyUtKOwXBzerzUSxTtQ==
Message-ID: <2a25433033c3b31f5c61b84ffb4efd51267ce3e5.camel@michel-slm.name>
Subject: Re: [PATCH 1/1 perf-tools] perf MANIFEST: add license files
From: Michel Lind <michel@michel-slm.name>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
Date: Fri, 10 Jan 2025 12:58:40 -0600
In-Reply-To: <Z4BFcA0L3IfsmtbZ@x1>
References: <Z0Zcx0WRqtlUYpgw@hyperscale.parallels>
	 <2fe55e73d3ef64ec3bfc683446e3f1f8b9e8c9e8.camel@michel-slm.name>
	 <Z4BFcA0L3IfsmtbZ@x1>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-7iM88pBuuD5S25U3kMns"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4YV9t50kdhz9sc8


--=-7iM88pBuuD5S25U3kMns
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-01-09 at 18:53 -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jan 09, 2025 at 12:55:16PM -0600, Michel Lind wrote:
> > Happy holidays all!
> >=20
> > On Tue, 2024-11-26 at 17:41 -0600, Michel Lind wrote:
> > > The standalone tarballs should include the license files - both
> > > the
> > > COPYING declaration as well as the text of GPLv2.
> > >=20
> > Just making sure this does not fall through the crack - does this
> > look
> > good to merge, or are there any issue with it?
>=20
> Applied, thanks for the reminder!
>=20
Thanks! I don't see it in the perf-tools-next branch, but see the other
MANIFEST update - I wonder if I'm looking in the wrong place.

Best regards,

--=20
 _o) Michel Lind
_( ) identities:
https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc04f2

--=-7iM88pBuuD5S25U3kMns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iI0EABYKADUWIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCZ4Ft4BccbWljaGVsQG1p
Y2hlbC1zbG0ubmFtZQAKCRCLIp0vfMwE8oOKAQCOscqOZRyUjfR+tTE+gvnb2D3m
Mo4kncwhWsFMpI0w4QEA8ZwtCmb/ZeqxOmyAc/0uYORNweNpocCAI0ZZAkoLOQs=
=hPK5
-----END PGP SIGNATURE-----

--=-7iM88pBuuD5S25U3kMns--
