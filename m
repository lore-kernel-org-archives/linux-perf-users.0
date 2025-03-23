Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70986131E2D;
	Sun, 23 Mar 2025 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742762211; cv=none; b=Fe3rmWvu45+fTmVpkUQYAzuyFbpFbJdasgytMn8xqvwUb0lSDsQbI12Y1WieSZQrH9JNqnMBLyZ5b4fSlxDUCfH92633PPZQ4EVCa5oFz+JqMHto/UueCAjULwf80hjM+ZQiCf6BgBVUYrkMjIx5eBVHL00bJGbcHXl0EBFfsXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742762211; c=relaxed/simple;
	bh=nhg7jXSYXSE41ZdL6I2M8YCT5HxW+asa9RIQ6PNECwc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g3KXjYtADFZHsAAalMWFkMK+8DNZ040/u7BOm0TI0pLmTWJNUMOsQX5llKjHcjD2qH74rM2ZZS4FwnIjxxL2NvpdPn++hBVzC/0b6imYT2HgipN9t/2V9rORWJz3+gv9NQ18YOQPIzYSsrmXr8Q3QGszOOdf3Ssllylx5XvrTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1twS3e-00AEp2-1q;
	Sun, 23 Mar 2025 20:36:34 +0000
Received: from ben by deadeye with local (Exim 4.98.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1twS3d-00000004EA6-2zgz;
	Sun, 23 Mar 2025 21:36:33 +0100
Date: Sun, 23 Mar 2025 21:36:33 +0100
From: Ben Hutchings <benh@debian.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf docs: Fix build with asciidoctor
Message-ID: <Z-Bw0XbCBfn7yrcs@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5b5Mme7HoN5MOMdF"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--5b5Mme7HoN5MOMdF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Although I made a minor fix in 2023 for asciidoctor builds, I missed
an earlier regression from 2020 that had been fixed locally in the
Debian package but not upstream.  I'm sending 2 more fixes that should
make all manual pages build properly with asciidoctor.

However, given that asciidoctor support has been broken upstream for
nearly 5 years now, it might make more sense to remove it instead.  We
only moved to asciidoctor in Debian to remove a Python 2 dependency.
Since asciidoc was ported to Python 3 that's no longer a concern.

Ben.

Ben Hutchings (2):
  perf docs: Fix build with asciidoctor
  perf docs: Fix perf-check manual page built with asciidoctor

 tools/perf/Documentation/Makefile       | 17 +++++++++--------
 tools/perf/Documentation/perf-check.txt |  2 +-
 2 files changed, 10 insertions(+), 9 deletions(-)


--5b5Mme7HoN5MOMdF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfgcM0ACgkQ57/I7JWG
EQlSAxAAunKk6y4UFrl8EPBvw6G1PMDKz17cS2zTvmzQnsW6TsnyfYMJf+KVuhP+
uoSsa9YN1sYKYMp2WJzkHqg1eF7g9YWETUvQkT3N1LlVqTBoDTKwvBBfYhHC751M
utAbWXTC9DxlhfH8z8N5md5VopbIqAU0zGbKYX8dzOFbEvlJ2wPZVA8APMW2/UD/
sLGq9vKLDK8tuQ95s2349Oz6+w7BlMFN4lbhBSo5jR09uhwxUi0xyEAVGlOypmz4
Ljm0k5f3Ip1z2SO1OOscAy0jb07TgtcqBeQ5rp5vPU/0MKCRhoDJ4HDkGcOyOM9G
kC6fzhhsSePGDwCO3ZJ9YbML+bzt3q4347Pp+C7JV8IiIJIbrQeDFkqhJDyI+Jse
YtCCtnifhWkTvzA6sHQON1WkrGsg6chSr2qjm1xTcauN10Md3aqNVFS9A4o1MrGA
NYwQhIFOIROZe9O6OOJKeHQSjNyxpd3KhDKsRqxJGfVDSX4UVGmLMUpMu6BHQstZ
S2tIW1mP8PyBe2c35g+uwRUYy1pEd3IOFHabRWCCpsG8apgfnkHiqr3C3GNtodlx
9LQS9cO8hoKQMQzrqxN6DqMFQl3lzJhhEYjJWf54eI0xyVEZk7mfXumISofPR9Of
D+DxvPx95OSrmVDKAZx/X5GXctlCG+/lNUjpl+/1bkuKLOgxTrA=
=zGTd
-----END PGP SIGNATURE-----

--5b5Mme7HoN5MOMdF--
