Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4ADC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun,  9 Jan 2022 23:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiAIXyp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 9 Jan 2022 18:54:45 -0500
Received: from maynard.decadent.org.uk ([95.217.213.242]:55168 "EHLO
        maynard.decadent.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbiAIXyo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 9 Jan 2022 18:54:44 -0500
X-Greylist: delayed 772 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jan 2022 18:54:44 EST
Received: from 168.7-181-91.adsl-dyn.isp.belgacom.be ([91.181.7.168] helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1n6i1I-0004bV-5g; Mon, 10 Jan 2022 00:54:40 +0100
Received: from ben by deadeye with local (Exim 4.95)
        (envelope-from <ben@decadent.org.uk>)
        id 1n6i1H-001kAx-Jd;
        Mon, 10 Jan 2022 00:54:39 +0100
Message-ID: <f59da80e6b4d053246fec4ef263ae4ca7aa1277f.camel@decadent.org.uk>
Subject: Re: Getting the latest and greatest Linux perf features on every
 Debian kernel
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ian Rogers <irogers@google.com>, debian-kernel@lists.debian.org,
        waldi@debian.org
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 10 Jan 2022 00:54:31 +0100
In-Reply-To: <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
         <YY58idSor+lJ84KF@kernel.org>
         <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-SDK+hqj1bfisnpMJ++hp"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.181.7.168
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


--=-SDK+hqj1bfisnpMJ++hp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2021-11-21 at 18:18 -0800, Ian Rogers wrote:
> Hi,
>=20
> I'd love to package Linux perf as per Arnaldo's prepared tarball for
> Debian. If I could get help on the Debian side it would be great! The
> actions that are needed are:
>=20
> 1) package Arnaldo's tarball for Debian, presumably the build in the
> sources for linux-perf-5.10 will be a good starting point. The package
> will be linux-perf and replace the current metapackage of the same
> name.

I don't think this buys us anything over building from the kernel tree
(i.e. the linux source package), but will wait to see what Arnaldo
says.

> 2) create an updated linux-base that removes /usr/bin/perf
>=20
> 3) upload the updated linux-base and linux-perf packages for
> maintainer approval to https://mentors.debian.net/

linux-base is maintained by the kernel team on salsa.debian.org, where
you can send merge requests.  If linux-perf is to be a separate source
package, I think it should be maintained in the same way.

> 4) some how get the previous Debian linux-perf-[45].* packages removed
[...]

They will be removed from the Debian archive through a periodic
cleanup.

Ben.

--=20
Ben Hutchings
I say we take off; nuke the site from orbit.
It's the only way to be sure.

--=-SDK+hqj1bfisnpMJ++hp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmHbdbcACgkQ57/I7JWG
EQmZNA//RS7bzn2FrEDAB6aRzWSzFnpZdNRuAs4jEe7GH45rX3M7e17m+Pmnx07i
F9J2bP0C457FkNff5Rf1EAzeThot+vvxy1JXzMowNa7BXYVUTOPK4Wdh+2q54ezf
ksj8jLVXu5M8iUwK3kMKihhL9rbOUTFErCVE/pI0ll+zFre7/5pHp+GCz4ErfLms
z6tipuc+r92gHW+b5B7K5knc7AdP28HlHBotWELv5RlZ/L4kl3O9cwVMdy8ZQG7t
+olwjhzm7PgD2JR4xGVtXCDKzjpWRfcSpfOleopswfQ5aXXb/d3bxe6YCbjWYRBC
LhQsCtOAYMkMFSca1RimeUUddKoLjbNPoGJQ039seAJTiuErFsrsC1yQlj6K1xD6
x7or6WuBjaZC7ylc0oSq9dCBaA8Nh6tSp/lNStmzGfp/boV/clThagccW3fyqiak
Wgvd0fJM9sGE653LALaA+QOQOLOTu0jpj3aR3Z3aD0Vrw+kf1iLP4j+u4K4EXFyl
9Ovc4dL8ZxZyXSUTUpBfII7nDxKblkGxF4LefYC2b+27RjW4HerGnA3ZLPlAtwA6
TwXib6JAGXqxnHALSriK1UlPhpZWdCZG0bNVm+UEy1ZUEF9kZLPsavwkGFOhWy9N
Gtk6aIGASBTudDbvo8pyJQyqJEJh3njtBuEHKfWt5hQWtjNjobA=
=4jvu
-----END PGP SIGNATURE-----

--=-SDK+hqj1bfisnpMJ++hp--
