From: Milian Wolff <mail@milianw.de>
Subject: Reusable data analysis/parser library?
Date: Thu, 27 Dec 2012 15:42:32 +0100
Message-ID: <1435472.kqSja2FelP@minime>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1503613.g8mumDdmRl"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd24202.kasserver.com ([85.13.143.162]:46863 "EHLO
	dd24202.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab2L0OwV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 27 Dec 2012 09:52:21 -0500
Received: from minime.localnet (dslb-094-223-151-207.pools.arcor-ip.net [94.223.151.207])
	by dd24202.kasserver.com (Postfix) with ESMTPSA id 0796ACFC111
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Dec 2012 15:42:36 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


--nextPart1503613.g8mumDdmRl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey there,

I found [1] and [2] but not a reusable shared library which one could use to 
write custom analyzers for perf.data files. Are you still working on this or 
should one rather stick to parsing the output of "perf script"?

As a start I would like to integrate a parser into KCacheGrind to seamlessly 
open perf.data files with it.

Thanks

[1]: https://openlab-mu-internal.web.cern.ch/openlab-mu-
internal/03_Documents/3_Technical_Documents/Technical_Reports/2011/Urs_Fassler_report.pdf
[2]: 
http://article.gmane.org/gmane.linux.kernel.perf.user/974/match=kcachegrind
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart1503613.g8mumDdmRl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlDcXlsACgkQDA6yEs0dE5PmYgCfahcRXTd/saEpi1GpJ6t+atSl
8WwAn0sGhLXMdSOJCfzTzwOLnus3nXdM
=YS4y
-----END PGP SIGNATURE-----

--nextPart1503613.g8mumDdmRl--
