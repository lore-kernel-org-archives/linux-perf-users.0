From: Milian Wolff <mail@milianw.de>
Subject: Re: Chronogram with pref ?
Date: Wed, 23 Jan 2013 14:17:03 +0100
Message-ID: <1898984.QcIki0Uqq8@minime>
References: <1358934288.36342.YahooMailNeo@web171503.mail.ir2.yahoo.com> <1358934556.33108.YahooMailNeo@web171501.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2350719.OKHB0KAUDo"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd24202.kasserver.com ([85.13.143.162]:49680 "EHLO
	dd24202.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab3AWNRJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Jan 2013 08:17:09 -0500
Received: from minime.localnet (g230112109.adsl.alicedsl.de [92.230.112.109])
	by dd24202.kasserver.com (Postfix) with ESMTPSA id 53E92CFC212
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jan 2013 14:17:07 +0100 (CET)
In-Reply-To: <1358934556.33108.YahooMailNeo@web171501.mail.ir2.yahoo.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>


--nextPart2350719.OKHB0KAUDo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 23 January 2013 09:49:16 dark_footix wrote:
> Hello All,
> 
> 
> Is there some workshop about timestamping the enter / exit of all the
> functions ?

Perf is sampling based, so you won't get *all* enter/exit functions - see e.g. 
http://en.wikipedia.org/wiki/Profiling_%28computer_programming%29#Statistical_profilers

> Is it possible to have the info of timestamp on the enter / exit of each
> function with the backtrace info, and the sub-functions called ?  and the
> thread id .

Recording that should be possible with "perf record -g -s -T" I think.

> If I am interested to start a development of an graphic interface to visual
> the result, do you have some result of log which one I could parse ? which
> could be the formalism of the result ?
> 
> What is the best way to develop this kind of feature ?
> Does it already exist ?

I think what we need is a proper public perf library to parse its generated 
data. That would then allow one to integrate Perf into KCacheGrind or similar 
which would give one a really nice GUI. Though a timeline GUI similar to what 
VTune offers would be very interesting as well. Afaik it does not exist yet.

Cheers
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart2350719.OKHB0KAUDo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlD/4tEACgkQDA6yEs0dE5P3EgCePhaQK6eFqq5v07a3ktAzQMLY
x4cAoJswxmdabd0ceLCxnBWJ5lAIIVNZ
=QyY7
-----END PGP SIGNATURE-----

--nextPart2350719.OKHB0KAUDo--
