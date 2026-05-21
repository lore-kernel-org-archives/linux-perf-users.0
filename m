Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD5407CD3;
	Thu, 21 May 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374081; cv=none; b=ah8VFRKN31dYFW+FmSq21OKUmPND18ClzFMupiGgxBevYByyOPr/LJ79BmXS/Tou50eoE5IxkjvdqybZAT7cZcbsj3ieVYKolhOJCtHwGQe781NZxDWMGoJsWtkwBQF9ekLxQAkTEztHOozpPWFo8yS1XAjzJ0YGxg8vHwB/9Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374081; c=relaxed/simple;
	bh=w1f7y3XysUNleSo1ou/h/TLa1N9vX9QMKWt+y6VvJ40=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g/TaNJomMswgxfbisx5S5/3r40db43sVFgdyIuDbn0BdCQYkLOz+Iq5bgznuQlAcu70aqbfvirLZj3AV2zTeJrqSlbW/W3xBj+4pmjQ1XaYHWIDEPosCg/dH3G+m83MolBIF0rX8iaUB/COMF2ofKmyv/eZwZrSHSFlxZa+62BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fDLo09Q2; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="fDLo09Q2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=J+eMdppU3NMLB/YoHA39VPZ8vaqrO/rEg99DwJusCL4=; b=fDLo09Q2lsLvUJA/EgYdpQ1YKS
	bpW0n3uKxF/Z0XdbbiJtPXedJh8vBk8PZoWq0YTxT2aoNCZpm9Qv3hU6LvyaYXDSunYRecViahMuD
	PL2yAwtjSkoznaDTNRA0+Obqr41g3quRTvRp15vRofGbJuIGrBOaqVZQxNyQxdEL7bgkP+iue2mRZ
	14TcCMQngrp5xONihw1ZT+DGMYmj3gBIUXJq+vAx7/Hfyx+KIlgDKliuh+kjbe6Grh2H28R9262/E
	neCgn6Xzzgv2zVjY5DdWXLlPWc2c0254R8OH1rtRcFMiSWI66RkmSb6FjtxIcezgjeEK5cQS1DZRp
	YS6LOCVQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wQ4Th-003x4K-12;
	Thu, 21 May 2026 14:34:25 +0000
Date: Thu, 21 May 2026 16:34:22 +0200
From: Ben Hutchings <benh@debian.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/3] Fix out-of-tree build of some tools
Message-ID: <ag8X7gcDw6jpJsLq@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bu6Rtf6ZDIvQKd3X"
Content-Disposition: inline
X-Debian-User: benh


--Bu6Rtf6ZDIvQKd3X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

perf and rtla currently don't fully support out-of-tree builds, as
they may still create files in their source directory.  This series
fixes all the instances of this problem that I have found.

Ben.

Ben Hutchings (3):
  rtla: Fix output files in source tree
  perf tools: Put Python egg info in output directory
  perf tools: Put Python bytecode in output directory

 tools/perf/Makefile.perf            |  9 ++++++++-
 tools/tracing/rtla/Makefile         | 31 ++++++++++++++++++-----------
 tools/tracing/rtla/tests/timerlat.t |  4 ++--
 3 files changed, 29 insertions(+), 15 deletions(-)


--Bu6Rtf6ZDIvQKd3X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoPF+kACgkQ57/I7JWG
EQklqRAAvNJIAfEgUyYTf3ncR/JmU+ITfmBFBn6+0MUqNVkOTpSz0GX7zxmv/rO1
NFu0P+GGBkMfj9q8VrxxlKbLh3I/pvfrqQd5rVtaFpgQslWZSENl8sCn5ihhNvFr
YqKDwMhRUly9riQBFAH7ocTTqUHIXyNYE+2kfE+VKUkc+vqJUeHrYmqvtX/DtqzG
y8wSp6SbcvrG9X3YnPWGKuJIuyTZndWfLb/ytQ0AJ4EjEJbeBmy0rIdA/iX0giNr
drVrr18ZLIV02OaAm74hkJapguuBftfBdhWpfN+uzOhyVbUJv3c9uOhOKnhtQJmM
7FN6pxCDGshr+4xQ7Sf78K1Cz8nriq96Wow8pjGpZS2ME2ykrXSGA/QVAyhRATsk
HyYoDIWxo+SWistqpcZTg4kfkxnNk0liWJc03mpqQF9vyjCldcu4j8/DN/PFrLtu
8qj+C9Ad+mBwHWQ6wKz0JTy8XFMkkNC1g+QmDxENQ7T2fry0GM6fHCNhD70vgS1z
3yCNVqD2X2iNuw0rXGXlI4DD4IGolZVCvV/8VdXPDD4iUwjcIIPaANJdjTXUh7mE
u8hOZgIJksMAaUQ2Q+HncDwgqpl+I91COX5GqQHBCVn18e0/egphgeAR4FPofaV0
emyyJc4ubnTd9k4ypKtGc5IZl/vLUjv4maxHkrg05F6o/uQ2E2c=
=IRnM
-----END PGP SIGNATURE-----

--Bu6Rtf6ZDIvQKd3X--
