Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873AF3B1A4;
	Sun, 23 Mar 2025 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742762244; cv=none; b=RAUg9qdPZ9lGGWEQEwRoFPzT5OEfpTRt6HzJGgxJQL4JI/H29Sb59utP4iO/jjCXZ5PHB812pvWRBqcDrKaIeMCppXoZOxuoqGU5yqnAxO/14ow+wUv4CT+oXHl7F/T5d7ywZ3BiSpXrpS0PHsSAZwbvCwflE727760AKqGJCWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742762244; c=relaxed/simple;
	bh=bVMZAKCN31O9G/3lU/RHLkk+vvgTm5Dolkqo8KfoOJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1yocZ/e1tBuPlXck7dEo8EAfhwIMHsfxyqv35LK/+aOFCN7oyz3HXCoOUtY6R6bw/3KPT+Q0v3jWO2rUDNSZ8djxLvBFR0ZqqvKjosF9kZm6L4eJKZtI/TLWKwPRm36pTtMR6GVVyahF1Bt3GymijvfT4+yzfX2MYzZS19z7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1twS4L-00AEpN-1X;
	Sun, 23 Mar 2025 20:37:17 +0000
Received: from ben by deadeye with local (Exim 4.98.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1twS4K-00000004EAw-1t8a;
	Sun, 23 Mar 2025 21:37:16 +0100
Date: Sun, 23 Mar 2025 21:37:16 +0100
From: Ben Hutchings <benh@debian.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf docs: Fix build with asciidoctor
Message-ID: <Z-Bw_LDgzLJD_-Z5@decadent.org.uk>
References: <Z-Bw0XbCBfn7yrcs@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hI5KjP6dU/3Hd09n"
Content-Disposition: inline
In-Reply-To: <Z-Bw0XbCBfn7yrcs@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--hI5KjP6dU/3Hd09n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently we unconditionally add "--unsafe -f asciidoc.conf" to
ASCIIDOC_EXTRA, but asciidoctor doesn't support these options.

Make all the ASCIIDOC_* variable assignments conditional on whether
USE_ASCIIDOCTOR is set.

Fixes: e9cfa47e687d ("perf doc: allow ASCIIDOC_EXTRA to be an argument")
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/perf/Documentation/Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/M=
akefile
index 4407b106d977..f566e3e98c22 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -44,17 +44,11 @@ man1dir=3D$(mandir)/man1
 man5dir=3D$(mandir)/man5
 man7dir=3D$(mandir)/man7
=20
+ifndef USE_ASCIIDOCTOR
 ASCIIDOC=3Dasciidoc
 ASCIIDOC_EXTRA +=3D --unsafe -f asciidoc.conf
 ASCIIDOC_HTML =3D xhtml11
-MANPAGE_XSL =3D manpage-normal.xsl
-XMLTO_EXTRA =3D
-INSTALL?=3Dinstall
-RM ?=3D rm -f
-DOC_REF =3D origin/man
-HTML_REF =3D origin/html
-
-ifdef USE_ASCIIDOCTOR
+else
 ASCIIDOC =3D asciidoctor
 ASCIIDOC_EXTRA +=3D -a compat-mode
 ASCIIDOC_EXTRA +=3D -I. -rasciidoctor-extensions
@@ -62,6 +56,13 @@ ASCIIDOC_EXTRA +=3D -a mansource=3D"perf" -a manmanual=
=3D"perf Manual"
 ASCIIDOC_HTML =3D xhtml5
 endif
=20
+MANPAGE_XSL =3D manpage-normal.xsl
+XMLTO_EXTRA =3D
+INSTALL?=3Dinstall
+RM ?=3D rm -f
+DOC_REF =3D origin/man
+HTML_REF =3D origin/html
+
 infodir?=3D$(prefix)/share/info
 MAKEINFO=3Dmakeinfo
 INSTALL_INFO=3Dinstall-info


--hI5KjP6dU/3Hd09n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfgcPwACgkQ57/I7JWG
EQlc7hAAqdzRLEj/n9PpOxvqkvKkJ3UvTCPqCbrKBGSuCyPjIvCw/MpRIJCHMZku
w8hjPRnjwAR8A5u0xRlwcmII9WTbCFkkiBoaL1dBIQ1O58d0HYzBciWyqPy8J1yF
P/IBOiC7puY7paqunriY1ksOFoJita78pvEUL5T6Ks9G5Q95Kj1Io8CXI7fMoZPu
AQpn3cT78nl+6h28KquUwF6gIGKVVXDIflptLcQ2tGTVN+ShPpjWVnwXZYzc8XYq
bKj0KP0VpdPqsEdSsj9iNu5Dton4q/yE+Yd9LwpcCyF/4QY/uPtNZHZYV+WRZwl+
dIKvopKcNIjoOhYtjk7AJuAbxp0g3Bh64xLYId21fODaUKwKJJn/lh5P9IRcKQXv
7oMThGXx26XyN9MNV7/Phrb6ABGv3jH6FGkMMQF1kwE7+O2mc/6CHr2Y989KO57B
dCKjrp4vJGO2wmEFNLVcu19hxQTBsqxdw7uDe1C1Q2Y08gWb+Ox00VrPKB/eM7qU
NmjRBwsf+IKuoXRkXDHc7U9CGrIx1XzjNfTVR08W+kP8aVnL99P/gTSNtXXw+m/T
VJknTHpA09lGMfF87/gSS5g9SoORrpIxHnsXtImOiz8hTW18ul+9eXZG80tkDGA4
bbADKPwB6WAPHJZkjjG0XVn7XGV5KJiIKpwGZIlZV0MFRjcxjPc=
=Kn2n
-----END PGP SIGNATURE-----

--hI5KjP6dU/3Hd09n--
