From: Milian Wolff <mail@milianw.de>
Subject: understanding power usage numbers
Date: Wed, 22 Jul 2015 20:26:41 +0200
Message-ID: <2910739.Pa3ssLDFhr@agathebauer>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1882300.L30qdQgjAz"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:37960 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbGVS0s (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 22 Jul 2015 14:26:48 -0400
Received: from agathebauer.localnet (ip5b406d2a.dynamic.kabel-deutschland.de [91.64.109.42])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id CA0F56280DD9
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2015 20:26:45 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Perf Users <linux-perf-users@vger.kernel.org>

--nextPart1882300.L30qdQgjAz
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hey all,

I tried to look at the power consumption numbers as reported by perf today.=
 I=20
found https://lwn.net/Articles/573602/ and used this locally:

 perf stat -a -e power/energy-pkg/,power/energy-cores/,power/energy-
gpu/,power/energy-ram/ -I 1000 sleep 1000
#           time             counts   unit events
     1.000124684               2.36 Joules power/energy-pkg/         =20
(100.00%)
     1.000124684               0.21 Joules power/energy-cores/       =20
(100.00%)
     1.000124684               0.00 Joules power/energy-gpu/         =20
(100.00%)
     1.000124684               1.17 Joules power/energy-ram/       =20
     2.000292827               2.32 Joules power/energy-pkg/       =20
     2.000292827               0.18 Joules power/energy-cores/     =20
     2.000292827               0.00 Joules power/energy-gpu/       =20
     2.000292827               1.16 Joules power/energy-ram/       =20

The LWN article says:=20
=2D power/energy-cores: power consumption of all cores on socket
=2D power/energy-pkg  : power consumption of all cores + LLC cache

Does this mean that the total power consumption can be all of the numbers=20
above summed up, excluding the power/energy-cores value? For the above, tha=
t=20
gives me roughly 3.5 J. Now how to get the Watt value? My naive assumption=
=20
would be 3.5W, as I'm sampling over one second. The LWN article says:

W =3D C * 2.3 / (1e10 * time)

This equation is only valid when reading the values directly, right? But wh=
en=20
I compare the Watt value obtained with my naive approach above it is much=20
lower than the value reported by powertop. I assume it's because no values =
are=20
obtained for the display and other hardware? Is that correct?

Thanks
=2D-=20
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart1882300.L30qdQgjAz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlWv4GEACgkQDA6yEs0dE5OVswCeLmukdCorwC7GPVW91gsswn1Q
BX8AoJf59VXul9xHSGlWbDe5J1CsYQDw
=6Wh2
-----END PGP SIGNATURE-----

--nextPart1882300.L30qdQgjAz--
