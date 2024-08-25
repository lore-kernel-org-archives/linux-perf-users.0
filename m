Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202F71B52;
	Sun, 25 Aug 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724595723; cv=none; b=emUVbFe6ab1uKR/c3fwJZWwF0zXz8BrFBNtRhCc76HYIE/GMy16KZNdGTFcbDQkGGmxTFvdkNH0dY2HIw5iCvT1gvcgvsFkK/fXJbzYedd4tMxfX94to/vMBWRqprfDt520gk6Irc4gCKUfCfguHlhRw5htBFHYwSOdT0QBOZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724595723; c=relaxed/simple;
	bh=e0iw2xtI/mwAKMKY497OI/t8+LpcSAu36z+VbR1UVqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gUuRpfKEZNcPZPiJSJ6X/Xh6mpwD5jkIxRq922ZaaAIbOax2TIV1738pDhbtWEUOWTwtS4N7UWqbWSvGXvufvmut9aSAOQpLQ/XLeHmM6S1VZQ16JvSfVcyQr36YVeyD4YUpIxYwsfKlhly+il18/38HAK1hWp2/Kf+amsFO558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1siE7P-0065s5-2E;
	Sun, 25 Aug 2024 14:21:23 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1siE7N-0000000BWXb-3VLT;
	Sun, 25 Aug 2024 16:21:21 +0200
Message-ID: <d94d995e476a5c014e1ce4d75d36f8667acd3316.camel@decadent.org.uk>
Subject: Re: [PATCH v2] perf python: include "util/sample.h"
From: Ben Hutchings <ben@decadent.org.uk>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Xu Yang <xu.yang_2@nxp.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
  irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 linux-perf-users@vger.kernel.org, imx@lists.linux.dev
Date: Sun, 25 Aug 2024 16:21:11 +0200
In-Reply-To: <ZsOEifE05otnUtdV@x1>
References: <20240819023403.201324-1-xu.yang_2@nxp.com>
	 <ZsOEifE05otnUtdV@x1>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-tqde9DlczuBkfLqrZ6nk"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-tqde9DlczuBkfLqrZ6nk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-08-19 at 14:44 -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Aug 19, 2024 at 10:34:03AM +0800, Xu Yang wrote:
> > The 32-bit arm build system will complain:
> >=20
> > tools/perf/util/python.c:75:28: error: field =E2=80=98sample=E2=80=99 h=
as incomplete type
> >    75 |         struct perf_sample sample;
> >=20
> > However, arm64 build system doesn't complain this.
> >=20
> > The root cause is arm64 define "HAVE_KVM_STAT_SUPPORT :=3D 1" in
> > tools/perf/arch/arm64/Makefile, but arm arch doesn't define this.
> > This will lead to kvm-stat.h include other header files on arm64 build
> > system, especially "util/sample.h" for util/python.c.
> >=20
> > This will try to directly include "util/sample.h" for "util/python.c" t=
o
> > avoid such build issue on arm platform.
> >=20
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >=20
> > ---
> > Changes in v2:
> >  - include "util/sample.h" in "util/python.c"
>=20
> Thanks, applied to perf-tools-next,
[...]

This is a regression in 6.11, so the fix should go into the current
release cycle, not the next one.

Ben.

--=20
Ben Hutchings
Any smoothly functioning technology is indistinguishable
from a rigged demo.


--=-tqde9DlczuBkfLqrZ6nk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmbLPdgACgkQ57/I7JWG
EQlU6w/+KyrwrhLL0DMERUAWsHkM+7KOLfh/ecFrTfLJm5EuR8du2urGI3g0QQ9+
8Qi84ZWvTr2yFK4HKL+RxPSVDXzs+Q3132CeAgwOIKrWDYPcBwQ9XMqAuCg58Kku
6bUAO7sgN5J0bVgCrGvgGl+tdcyb2/xCRkrahcIkDrTrm4rYNksVKWYDFXJ0cUAX
m5zBuHtq/+uwzhBjOUehHBpTxt4vwKWIatLpN5REJlYtglpUe9LHzckNy68gjh7B
Jho3lUmzZDVr8GVg3khB6nAR4ZMKmfFJE+IV0xaYV/OStAqLKYdZDC4Yj6AAEhJO
Rrme0Oy8xV3ou4mDjEO9J1gf/1QfZh90tJMHkt2mt6AIKk1n/t1yW6aPO1+B9nN9
/smS61vNAS4vE63gMQFnNLX+OybQ1Dh8X85r1VjD9TgfBzE8LpXqoFN65bjGWNa+
9hiP9BMh7b/YjFHpixMZMVjuyc3nXmqUCoGZKDJSIwMvn/LF46DrdyXADhY1jZvo
yKPDyqoOMY5Riw+Bx8rYbO5FUsNycaJJcmtF+zD9k0xup+F+5XuzrVFqC5EMq032
ZGPAAR0qntQSjIM8UBy6Ndl1ncOUrCy/qLryAhKnw2d8LzTH9RF1pDKbryfNoF+Q
yAd7gJL1ApNcwNJeIYqtTOfk6u30OAZ2BpIWXJ81TWBdCaoQb5Q=
=3VSg
-----END PGP SIGNATURE-----

--=-tqde9DlczuBkfLqrZ6nk--
