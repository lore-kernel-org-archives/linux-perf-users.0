From: Milian Wolff <mail@milianw.de>
Subject: Re: perf mem: invalid or unsupported event: 'cpu/mem-loads/pp'
Date: Sun, 14 Jun 2015 14:06:27 +0200
Message-ID: <4386856.SFWvs8H8rN@agathebauer>
References: <6210395.6gJQB6qfUl@minime> <1374544009.5545.2.camel@concordia>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4718706.Z04hLAqpXL"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:49919 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbbFNMG3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 14 Jun 2015 08:06:29 -0400
In-Reply-To: <1374544009.5545.2.camel@concordia>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linux-perf-users@vger.kernel.org

--nextPart4718706.Z04hLAqpXL
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Tuesday 23 July 2013 11:46:49 Michael Ellerman wrote:
> On Mon, 2013-07-22 at 19:34 +0200, Milian Wolff wrote:
> > Hey there,
> >=20
> > I just found perf mem in the output of perf help and wanted to try =
it:
> >=20
> > $ perf mem record ls
> > invalid or unsupported event: 'cpu/mem-loads/pp'
> > Run 'perf list' for a list of valid events
> >=20
> >  usage: perf record [<options>] [<command>]
> >  ...
> >=20
> > Am I missing a kernel configuration? Or what is going on here?
>=20
> You need a kernel that has mem-loads in
> /sys/bus/event_source/devices/cpu/events
>=20
> Assuming you're on x86 you'll need a 3.10 or later kernel.

Sorry for the long delay. I wanted to try it out again today, but I sti=
ll get=20
the same error message above. This is with a 4.0.5 kernel and perf 4.0.=
3.

What is required to get mem-loads in the path specified above?

Bye
=2D-=20
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart4718706.Z04hLAqpXL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlV9bkMACgkQDA6yEs0dE5M+SQCfVKjHIl1SYkuA8zDAVrh0we9a
6XAAn27NrKS/bohoc4vwkGqkZo26Guas
=EBUA
-----END PGP SIGNATURE-----

--nextPart4718706.Z04hLAqpXL--
