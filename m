Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007737C103;
	Thu, 21 May 2026 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374145; cv=none; b=rMi8xO1tzi3rEBqMIWKuwYW/gmwbdNXG2+40+0nfto0S1tyyLZtKHJe5zF9gvbKYKug3WqZJ6thDz9UnahiX6nU23uQ9ho6wNb4V/SxyauF4+sMbIWn6SC8QqHcotCzOOiD/F1zH1KOTpjiTx7D66VvdPpdYXczZhV0Lm7Z+dOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374145; c=relaxed/simple;
	bh=xPXw1vzFKTeYtQbXRkjL8qrqiJU6grw/IwlMQTgFj5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0H+qNpNr/QJSYZqeXm5kf+DcxkZFPNuhEquqHXpvHhSRNxjXB/cMidhtwjlN29pO1TF8v4WPXBcAqlDTPNuaJ6R42ZAJjXC77mQ+YmiC9hr6yPIn07I0PTaXt4n0Mz30m+SvUQ+urjCUPbqeea5mfBfLRGYsnTGfT2vQdkkzDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=eSgbL18D; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="eSgbL18D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uqsfNEcME3t9ZjhwIax1YLuUg7aAF1jh4J6MeMbyuoM=; b=eSgbL18DB8ME9dcx8ca8fREkI+
	p7xdK9lMPOGRHR73DMypg1K5iFUt20yLi/Ac8pAye8MUU1IIRLk4qUq9SP9CQOG8+a4pC/tr8LwWO
	sLdogPIGxCUIEy4SBEYF2hjRkNhlf1D0/vVsQZD1IiRjNYMTBdss40GFVm03pTjwrVoVlA3v01hnS
	IlZ2i+BtMxQ0UFY7g2034pDInBKx6jAj8JdcmHA1OzRLLjuMMKTkyrXTtLRz2bWEtC5I+eiF1dC7k
	RrR6QFb48l2XS9BlDH3DucxoRfQXKzNQbwg2YsxHAvVWc3Rta3Hv9iKzeMlkE0a7iQSsXAbKDe3Vi
	jk8wAySw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wQ4Ur-003x5W-38;
	Thu, 21 May 2026 14:35:38 +0000
Date: Thu, 21 May 2026 16:35:36 +0200
From: Ben Hutchings <benh@debian.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf tools: Put Python egg info in output directory
Message-ID: <ag8YOLn1tFuFAxaI@decadent.org.uk>
References: <ag8X7gcDw6jpJsLq@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WIBbJ7KQs5jD+pYe"
Content-Disposition: inline
In-Reply-To: <ag8X7gcDw6jpJsLq@decadent.org.uk>
X-Debian-User: benh


--WIBbJ7KQs5jD+pYe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Installing the Python extension currently creates an egg-info
directory in the source tree, preventing a fully out-of-tree build.

Add the necessary runes to the setup.py comamnd line to relocate the
egg-info directory in an out-of-tree build.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/perf/Makefile.perf | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index cee19c923c06..899a4249a42f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1152,7 +1152,9 @@ install-bin: install-tools install-tests
 install: install-bin try-install-man
=20
 install-python_ext:
-	$(PYTHON_WORD) util/setup.py --quiet install --root=3D'/$(DESTDIR_SQ)'
+	$(PYTHON_WORD) util/setup.py --quiet \
+		$(if $(OUTPUT),egg_info --egg-base $(OUTPUT)) \
+		install --root=3D'/$(DESTDIR_SQ)'
=20
 # 'make install-doc' should call 'make -C Documentation install'
 $(INSTALL_DOC_TARGETS):


--WIBbJ7KQs5jD+pYe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoPGDgACgkQ57/I7JWG
EQmE2g//Z9OHWz1IM02S04ZwsP9FySSZMDU8skgJ4PyzC4zMA5semFoSDddUihn1
KGBsg6EOyVr4eTUYUkUdh9rmmkjHzSrH/4xefHKyMHZSlvhChJK2VBI1lakgaOFo
IzxF7FgN7VHoglG1X3E0MV1ZxPBrAi66CfHD+yZfW8D6YinV6bsXYW49+9Dc65jl
XckkD47o5URBW8Rp9NrusM99SF8sR95EVi+zkAD60rJAipMQQi1UjMJhSecowK+w
xDQyZCbyM/bjQ7NdOxfXPuhxdfy1gI00B/d6WdTyqhCNcntAdisdYiDD4JDx11Xv
rSzinewQt/+GITy8KX+7x3pvqRFB6Pkp+WdFkp5PIELTMiAXVVTVQWAMa89NjdFo
OrRxijy+o7CpbQHWTWDspxxJgGlnGxhgQkUHwM0JccvqnhUps5SDXsP4bOaQ4MY3
D801JezedcCGw0MYZaUVxUC0pIk1+/3r4T+SNRBOoDfNdlCPDSKn8PQ2PHjNavaD
J7Y4tft900QwEdNgyuU3+TzXQBPcN0Su7vpXLZzl+FWt/Opg2Ae2nP8aq8grdm1a
E/6M6MyTioti48m0EClaKnIt1sBaehf/gdBEERVwYijA/sebN7oSXy/NihjUNkrs
EInkI8rfWHlLNE2g/yi62nECH7UlYfI62O8cMhynQ85yHV+/K00=
=tOQT
-----END PGP SIGNATURE-----

--WIBbJ7KQs5jD+pYe--
