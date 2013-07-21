From: Milian Wolff <mail@milianw.de>
Subject: Re: Reusable data analysis/parser library?
Date: Sun, 21 Jul 2013 23:57:26 +0200
Message-ID: <1570240.AOWUWmZr1e@minime>
References: <1435472.kqSja2FelP@minime>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1675150.VUJQQP4fmt"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd24202.kasserver.com ([85.13.143.162]:50708 "EHLO
	dd24202.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab3GUWE7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 21 Jul 2013 18:04:59 -0400
Received: from minime.localnet (dslb-178-005-158-050.pools.arcor-ip.net [178.5.158.50])
	by dd24202.kasserver.com (Postfix) with ESMTPSA id 739A9A02001
	for <linux-perf-users@vger.kernel.org>; Sun, 21 Jul 2013 23:57:29 +0200 (CEST)
In-Reply-To: <1435472.kqSja2FelP@minime>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


--nextPart1675150.VUJQQP4fmt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 27 December 2012 15:42:32 Milian Wolff wrote:
> Hey there,
> 
> I found [1] and [2] but not a reusable shared library which one could use to
> write custom analyzers for perf.data files. Are you still working on this
> or should one rather stick to parsing the output of "perf script"?
> 
> As a start I would like to integrate a parser into KCacheGrind to seamlessly
> open perf.data files with it.
> 
> Thanks
> 
> [1]: https://openlab-mu-internal.web.cern.ch/openlab-mu-> internal/03_Documents/3_Technical_Documents/Technical_Reports/2011/Urs_Fassl
> er_report.pdf [2]:
> http://article.gmane.org/gmane.linux.kernel.perf.user/974/match=kcachegrind

Ping, is there anything available which I can use to write a perf.data parser 
for KCacheGrind? This would be highly benefitial for many people using perf.

Otherwise, is there at least a solid documentation of the binary format which 
I might then use to write a custom external library?

Cheers
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart1675150.VUJQQP4fmt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iEYEABECAAYFAlHsWUgACgkQDA6yEs0dE5NzMgCgvN0bxohi/7VggMsPnbRxxcKx
vgsAn2WC2sSIDZXH3fUDFQX/ayFot4bg
=zLy0
-----END PGP SIGNATURE-----

--nextPart1675150.VUJQQP4fmt--
