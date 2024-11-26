Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF1189B94
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664536; cv=none; b=MwVzAEvWJYXXpmh+1a1298vI5I1kuElFEROyIV14gTq24WkArc6KT5MhiBhIeFYmFufl/Yt3PvOzopxbY009snH2R9neLeeJMd42ZvtmOZiEl9NjphTi3IbQoRTTxG4Ypz53b0R+GC0LUV8WP8HlkBe+P28PXoaOOxc00up/j6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664536; c=relaxed/simple;
	bh=VcnRfviN+xwzE1CH/P0DTksJare4J713gntptUuqVdU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LnsmbPWWI9HBroKMAQdA0kSvWR3MLcyZg8nES8KjuaBjL6A71OvtOw60wUPbBvgbVRnzyt4ug5R4YiGZ/ZASEqXSomSrOysmeCZdn5NaJs65v/ak7FUQYtKt+lABIcP6bzhWtllitnoBaCLebLKTv4GBSgpxICxRgkJarQj9Yds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=Prr5WqK6; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="Prr5WqK6"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XyfHZ6k8Fz9sjF
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Nov 2024 00:42:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	s=MBO0001; t=1732664523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=VcnRfviN+xwzE1CH/P0DTksJare4J713gntptUuqVdU=;
	b=Prr5WqK66tYm+cW9am4Ersx2kVXG4oj0arT5GaNUUxvkHuQddP+Vd+G1ysywevHpFFVlWG
	0HHBB+XyVulhrPcTtr8RgD8VPZMqA27t3hQPS2CC68qY39sOKyQIsysPcDdPgBz90QSp9y
	2fS7c71lD3VVYev/z+DjLRsTicS+xYEIaUisPHplML0OojCXDTkcD8kwSrYZzpLqxey9Se
	gKYqq0iGSgY9Tzk3GucMHEo2beSaGDZg5hDNFbZIfUJpdpajG3UXQI+We93yx4ZGIlB6aB
	iYC++d6UlH78Qm/lidJJg8/ejMDtd+bmlKEj9kRSIMUS9G+A/QFRKBfYLLLWrA==
Date: Tue, 26 Nov 2024 17:41:59 -0600
From: Michel Lind <michel@michel-slm.name>
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: [PATCH 1/1 perf-tools] perf MANIFEST: add license files
Message-ID: <Z0Zcx0WRqtlUYpgw@hyperscale.parallels>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bmgqJYyrvcSetD3U"
Content-Disposition: inline


--bmgqJYyrvcSetD3U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The standalone tarballs should include the license files - both the
COPYING declaration as well as the text of GPLv2.

Signed-off-by: Michel Lind <michel@michel-slm.name>
---
 tools/perf/MANIFEST | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index dc42de1785ce..47b7a12f5780 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -1,3 +1,5 @@
+COPYING
+LICENSES/preferred/GPL-2.0
 arch/arm64/tools/gen-sysreg.awk
 arch/arm64/tools/sysreg
 tools/perf
--=20
2.47.0

--bmgqJYyrvcSetD3U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCZ0ZcxwAKCRCLIp0vfMwE
8g8mAP4uGV9uzh9yb7PCMl6AuvTxT1NeHFLheIgsIFEMx1lWmgEAgml/GaVpwxc0
5wpSXGT9GsYWJDuXSVbVBRtzcxCZUgg=
=tA1U
-----END PGP SIGNATURE-----

--bmgqJYyrvcSetD3U--
