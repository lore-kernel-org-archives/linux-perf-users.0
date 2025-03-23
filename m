Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808AA148850;
	Sun, 23 Mar 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742762255; cv=none; b=elCu6jGJ5ApvMsJBt7ADXSv58nXI4pDoGCRCsXZhIzTynD2I6y7xsSniIKnchTI4Zt8O/FP5Y+RShs5n9wzLixAnwRRFeiKO8D/UV4oI5rkfB3EGpfDdUX857jrthADZKlycdWKxIu/CBokQSm9s35th31IMTY7sZHO7Q/bdVO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742762255; c=relaxed/simple;
	bh=GP9xa7lfr8JpWWvxyWG7SC//k6fiIUlFu9DYb0/mzyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImQcKQPuG8EUlfJamnVPEQx6dED42CNpcipVvgewrTg5R1fF2hCzu3/ywhfQTpnkP4qMK7P9rOJikcYghVK43qA/XrzQcXXreG7SYS4Li0uuMShgIomLIkes5Yrq/bhYoBukApuQbjRgCvRZW/yR6XDHq1MG+QggBiDvoTqti/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1twS4W-00AEpU-34;
	Sun, 23 Mar 2025 20:37:28 +0000
Received: from ben by deadeye with local (Exim 4.98.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1twS4W-00000004EBL-2JtU;
	Sun, 23 Mar 2025 21:37:28 +0100
Date: Sun, 23 Mar 2025 21:37:28 +0100
From: Ben Hutchings <benh@debian.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf docs: Fix perf-check manual page built with
 asciidoctor
Message-ID: <Z-BxCE8WrcRmR_5f@decadent.org.uk>
References: <Z-Bw0XbCBfn7yrcs@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b7ognxY+oNbO/qWL"
Content-Disposition: inline
In-Reply-To: <Z-Bw0XbCBfn7yrcs@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--b7ognxY+oNbO/qWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

asciidoctor is more picky than asciidoc about the length of heading
underlines, and currently mis-parses perf-check.txt:

  ASCIIDOC perf-check.1
asciidoctor: ERROR: perf-check.txt: line 1: non-conforming manpage title
asciidoctor: ERROR: perf-check.txt: line 1: name section expected
asciidoctor: WARNING: perf-check.txt: line 2: unterminated example block
asciidoctor: WARNING: perf-check.txt: line 5: unterminated listing block

Fix the length of the title underline so it works properly.

Fixes: 98ad0b77323c ("perf check: Introduce 'check' subcommand")
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/perf/Documentation/perf-check.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documenta=
tion/perf-check.txt
index a764a4629220..80eb1de4eee0 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -1,5 +1,5 @@
 perf-check(1)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----

--b7ognxY+oNbO/qWL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfgcQgACgkQ57/I7JWG
EQkP0g/+P25Iop3qxSdxOT/l7whdOMsUPRRA0QqUhTzFchA96XDekOHV3X5FkU/5
nr5NAtj9gn/p7Ug6BDYlw7DZg0XuegYeyPi3v27+NhV3OV10CrnbZl6UaAQZmdRL
9Lydhf5OsjaVBf0WXCgl7johMTDE5lrWhzG9uSNiBgygzXFq56T5un2PK0WKRRTV
vu59jDaMitfgVqZcP3AC4+wH4Ig2LXz7v4e4JZdcThwApjyciH85s/pO0+vTE02V
yu9VpoyWnDWCLMkCVzGzV1N6BKEbzG5dTRtwUMZhSaPWplcZ7qpw14tTfy+uIhUd
WpBYmBU3KO8K5XRiGXzvzpJk99A9Y3DBC7aOLqASIKeQ1e50LYRlKrb0cmqyzmCX
5gqg6jGMfGbQwQyQZJE/6902qZ2PiEKQ69FdfDugPIjoDYRfelmeUnlI8c6VcQaB
Wd5qDUtsffXbn0gVU+50VYUj2bwzVBSRsUYQT++ApSbbYstK84LGshfKK9rYKfeo
07oBBSqyzeFuS8Q/kiFmzc0zVv+lFkETfkapyFDIdEKHTbKNJgH38ILScMcyY38R
xExdmQmKL/l+AeXiw0jkXjhCvPJcY53B2Soajz/uv7/qHUg7ffgkEWYi7ENoM8+p
aCLGNpcVYjqCQ0ynloYoOBDxE4W4Fqgh/Li1tgfgxhIZqb8wW+8=
=NugA
-----END PGP SIGNATURE-----

--b7ognxY+oNbO/qWL--
