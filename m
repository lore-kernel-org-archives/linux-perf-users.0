Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF90E1B87E3
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Nov 2024 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558122; cv=none; b=RhjmsjH6GHQghdTkuY4d14eMqhD+82kPZOh6ahwdOYqgPwhgE5qAHC6pfxlqGgHf0QSl5r1NQAurUmkTwmDBpH3hfVcyAOjiW5udY5WOJmL0tpC2R1TFILVRO2nKpcIjKIYjAdLdL7UVUS1n9PXc0NgfmFPG8HB/mxwpSsrWxRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558122; c=relaxed/simple;
	bh=11zjLNQRBrRqXz8Fdnz4HA4WTCkdXVIGkEO5YqTF+ek=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hi9uCgJOZegMZYsmoqWNjM3GTB87V/gXzK9bLwvgtAbTbCMEpUdvSvi0DeqvEM+BerHuI/NUY+Orcd+Fd9gLKef8DvDdmJP7kc9BALG/9k2f5fm7AgKqClf1EqvpWRfbRuUZGF+NAp5bvTZucRczEI2rhi9N+D38AHW0ZL7dves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=P8DDlp0i; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="P8DDlp0i"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XxtxD5QLWz9srv
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Nov 2024 19:08:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	s=MBO0001; t=1732558112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ybUIq0RCMI2RaKcEEe3I0eR8zUY7n212T8NIt88xDsA=;
	b=P8DDlp0iQJ/s+teanXjQ5R3AoQFQ1L5yiJlCf+RGrEYrWhDW1+JAF4ZGsEKHInmAfGsHD7
	zylT8JJwD/7fp9082j2GvE8DlqcycJVNqniLea2TH9xWtUmKgQzW7Djcddf2/lQ+g4SARk
	y0m2k8hoyDFtgGRJsN8VDOK/jyF4yxZauJ/bFXm3F2KbNFjv487Ik5Drm3zqvLCawPuaAH
	XYSNOKlne5TLwXoUQLI5+WaAou9+VWE7nv5pdYzh1IcIZEDdgZYuK09VwxJqBab6QqYxFJ
	oc7QmH7mP7wR9z9lnSBEgbKk+H6Lyl9JvYx+ztBI4EsMBwuBtz7cilMi2YRPNw==
Date: Mon, 25 Nov 2024 12:08:28 -0600
From: Michel Lind <michel@michel-slm.name>
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Recent tarballs missing some files
Message-ID: <Z0S9HCQ0Z2d/I+Uh@hyperscale.parallels>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RgzxVy1xX82dH90t"
Content-Disposition: inline
X-Rspamd-Queue-Id: 4XxtxD5QLWz9srv


--RgzxVy1xX82dH90t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

Per discussions with acme back at LPC, I'm working on packaging a
standalone perf RPM, initially for the CentOS Hyperscale SIG and
potentially for Fedora later on.

I noticed that, while perf 6.9.0 builds fine from the source tarball,
more recent versions (at least 6.11 and 6.12) fails due to a missing
header:

```
In file included from /builddir/build/BUILD/perf-6.12.0/tools/include/uapi/=
linux/bpf_perf_event.h:11,
                 from libbpf.c:36:
/builddir/build/BUILD/perf-6.12.0/tools/include/uapi/asm/bpf_perf_event.h:2=
:10: fatal error: ../../arch/arm64/include/uapi/asm/bpf_perf_event.h: No su=
ch file or directory
    2 | #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
```

I can submit a patch to fix this (and any other missing files), if
someone could point me to where the script is that generates the perf
tarballs.

Thanks,

--=20
 _o) Michel Lind
_( ) identities: https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc0=
4f2

--RgzxVy1xX82dH90t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCZ0S9HAAKCRCLIp0vfMwE
8peCAP9DwTdrEujcB5ilzdegzy04y/b6Ye+LHQXSM0JgblGtigEA5TY13/197nX+
UwMuMXYH1tcSymvzqEpa/vvjz1sU9QM=
=4QBi
-----END PGP SIGNATURE-----

--RgzxVy1xX82dH90t--
