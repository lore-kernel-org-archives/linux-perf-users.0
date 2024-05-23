Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66841446AE
	for <linux-perf-users@vger.kernel.org>; Thu, 23 May 2024 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456700; cv=none; b=Vme6eTWQITGuHCy92KUVMIPww/U6tDnCsLVFoVRbhkRHR2eD+gdWXNo1FRHmc2GrztdG5MwiaUEeNqaIKwZPgb2R/Ax2xtI7MpUjamguJcyijflFnewiD4o4GEXiVVU0FItOmGUXpJz2k9DRozY0OszgvQxndJVBB2mBcw1CqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456700; c=relaxed/simple;
	bh=o+RAWYICtXRzmeLIsPu+n5xyyzxrGhZlfuOMpdIgj8s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OxgTa3W605W2CUDo8prg6VMTuDkVK/BHcJfpRqZV7WX4dS8Rg+XwO0pT8FhUce5g55ivoBwSbdXQxSDiIsOVCOmHlObrU/YngW0uEZwjlxFR5aOpnhb8I2ZGY+z3wInSF2VMEfeIaNJ6K4Z0Lv1OPnOUTnhdEFCOgbjVRs4zKm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1sA4nP-0003wo-2G; Thu, 23 May 2024 11:31:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1sA4nO-002dqo-KN; Thu, 23 May 2024 11:31:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1sA4nO-00AeAc-1m;
	Thu, 23 May 2024 11:31:34 +0200
Date: Thu, 23 May 2024 11:31:34 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-perf-users@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: perf script -i ... -k ... report flamegraph
Message-ID: <u3pton5jobtjoaym2zahds6r6xtewry75asyiebwyeqdp5ivee@a5ffx2g2r2ib>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cjxmbhhusczu5q7l"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-perf-users@vger.kernel.org


--cjxmbhhusczu5q7l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm trying to generate a flamegraph for a perf.data/kernel from an arm
machine on x86_64.

$ perf version
perf version 6.9.gc760b3725e52

For that I do:

	$ perf script -i $rootdir/root/perf.data -k $rootdir/../build-target/linux=
-6.9-build/vmlinux report flamegraph

however that reports

	failed to open perf.data: No such file or directory  (try 'perf record' fi=
rst)

which is unexpected to me given that I pass a perf.data using -i and a
plain

	$ perf script -i $rootdir/root/perf.data -k $rootdir/../build-target/linux=
-6.9-build/vmlinux

works fine using the specified perf.data.

If I do

	$ ln -s $rootdir/root/perf.data .
	$ perf script -k $rootdir/../build-target/linux-6.9-build/vmlinux report f=
lamegraph

to workaround that issue, I get:

	No kallsyms or vmlinux with build-id d1f71a2e9aec6ff7ef1d5dc544d5a76033496=
b70 was found

despite

	$ file $rootdir/../build-target/linux-6.9-build/vmlinux
	$rootdir/../build-target/linux-6.9-build/vmlinux: ELF 32-bit LSB executabl=
e, ARM, EABI5 version 1 (SYSV), statically linked, BuildID[sha1]=3Dd1f71a2e=
9aec6ff7ef1d5dc544d5a76033496b70, with debug_info, not stripped

(so the right build-id) and again

	$ perf script -k $rootdir/../build-target/linux-6.9-build/vmlinux

is happy resolving the symbols.

Is this a bug or do I hold perf just wrong?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cjxmbhhusczu5q7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZPDPUACgkQj4D7WH0S
/k7z0ggAgkzdUU7mVGnFrhUimCe7F7FIBCLZcKWtk/tubTGb6q3D89Bd2g5id8+g
6nwLKh2OGNn1+TteMPp/pj9tUQlJaRylnkpWoADU50mzVu67YNtvZ5bcXt09rRxb
aIBKG2/TAPaSRkbuG3XKaQZuRxiAu0Z+ivdij2fNqSEwwVK/n+Calgv5LMZAJLNx
Nz/a7BrypN7t3JjkEE1Mf0mo1OAWGvYPMLA14CH/H3exwwFpECtywvWtS2pIwkm7
SueJ7qCbkeUHcn0K6Sus95VprBIxaDHJuNCfUQIEUDiMNYNSdqkSk/+UOC4DiZ/l
svNIN3XgbpHg/POHxudk+YwuxVXeYg==
=7iwx
-----END PGP SIGNATURE-----

--cjxmbhhusczu5q7l--
