From: Milian Wolff <mail@milianw.de>
Subject: Haswell LBR call stacks
Date: Sun, 14 Jun 2015 13:02:57 +0200
Message-ID: <1682663.JO3lAz5bZo@agathebauer>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2850007.FIAUfH0zbU"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:48465 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbbFNLMQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 14 Jun 2015 07:12:16 -0400
Received: from agathebauer.localnet (dslb-094-222-031-046.094.222.pools.vodafone-ip.de [94.222.31.46])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id 474126280814
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2015 13:02:59 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

--nextPart2850007.FIAUfH0zbU
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hey all,

Some time ago I read this interesting article:=20

http://article.gmane.org/gmane.linux.kernel/1809078

It mentions a new call stack unwinding for perf, based on Haswell LBR=20=

facility. I now have a new Laptop with a Broadwell i7-5600U CPU, but my=
 perf=20
version 4.0.3 running against a Linux 4.0.4 kernel (all vanilla Archlin=
ux=20
versions) does not seem to support this feature. Was it ever included i=
n the=20
mainline? Is a special compiler flag required to enable this feature? A=
nything=20
else I'm missing?

callchain: Unknown --call-graph option value: lbr

 usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

        --call-graph <mode[,dump_size]>
                          setup and enables call-graph (stack chain/bac=
ktrace)=20
recording: fp dwarf

Thanks
=2D-=20
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart2850007.FIAUfH0zbU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlV9X2EACgkQDA6yEs0dE5P2/QCgnP0wEklCM/n1VUArXJpL7Y3r
8+gAoIMHnGLrSf6BAsuWUa8O71KquxBN
=1gfy
-----END PGP SIGNATURE-----

--nextPart2850007.FIAUfH0zbU--
