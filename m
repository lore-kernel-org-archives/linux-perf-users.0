Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527CA35
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Nov 2024 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732578644; cv=none; b=my6czC0wRSalJlI3l29kc0vLcvIKyr26N4exUJ2rleRfZpp5994tkjEXz7CfQSolWe+j51zJINWseynsVigaPCPdBenn0DkjUuldW4rPYNV1UYv0nXOx+/5xESxn2cvU6m9B2/cpUVOXSHZSxV+yTmetmh/f6kymhUavQg3vvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732578644; c=relaxed/simple;
	bh=9BkJm0rwPC+SuURjmQNoGI8a6NPd2Rj/iAsViHxTO9c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXBCd+9dnY1bqjcg6saMkSuw6oXfl7W+04GLAjBrorkB7VITyNT/gr+u2fSiPBYDUtrCs5xffFuhED53KIwXq+xri+yIMvN0eefV9UczOMYx/c1A0YpfVCQXXVDog0aTV1+4VeiwzlYYr9ZeWqpgQOBEV5yLeC9z9VU+cL09Oq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=rhyy1U4s; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="rhyy1U4s"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Xy2Wr1SFlz9smB
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 00:50:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	s=MBO0001; t=1732578632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5fmi5F6Y+vG9noplfTh4EAeBCgBT1OYeytV7ek6lnNU=;
	b=rhyy1U4sKEmkwTneLi5teBNFokIovJCXIAbTfumgzoLwD2KPeg+NVGjmX5jDmCrWqy8ZiM
	MRCb6PgSCbyBfYZvmszVF6Ik+5rUHt9LkQKhSvltb3Zuf+Stl6DLQHAQsi1mDh82OSN7RT
	JuvZ4SweoBskAPASatzGyRH8UWxGW2JOFSLFS2kPyq5CfiCNkk272RvRSvpWBBU2f8KTy9
	Jz4nMZEFW9JD8yPOpYIc4aO9kqyLqoRVJFpcHY6t4dJevn3YwW/WY3UM6a207itezRlbiP
	M2+Yxk7/V/HbV3nyES3jLgADI2715ItTR+Jmqa0s7uYMPhaiEW5kgHrDQnRRHg==
Date: Mon, 25 Nov 2024 17:50:28 -0600
From: Michel Lind <michel@michel-slm.name>
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Recent tarballs missing some files
Message-ID: <Z0UNRCRYKunbDYxP@hyperscale.parallels>
References: <Z0S9HCQ0Z2d/I+Uh@hyperscale.parallels>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KXUFu5kL7Z0KgGI3"
Content-Disposition: inline
In-Reply-To: <Z0S9HCQ0Z2d/I+Uh@hyperscale.parallels>
X-Rspamd-Queue-Id: 4Xy2Wr1SFlz9smB


--KXUFu5kL7Z0KgGI3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 12:08:28PM -0600, Michel Lind wrote:
> Hello all,
>=20
> Per discussions with acme back at LPC, I'm working on packaging a
> standalone perf RPM, initially for the CentOS Hyperscale SIG and
> potentially for Fedora later on.
>=20
> I noticed that, while perf 6.9.0 builds fine from the source tarball,
> more recent versions (at least 6.11 and 6.12) fails due to a missing
> header:
>=20
> ```
> In file included from /builddir/build/BUILD/perf-6.12.0/tools/include/uap=
i/linux/bpf_perf_event.h:11,
>                  from libbpf.c:36:
> /builddir/build/BUILD/perf-6.12.0/tools/include/uapi/asm/bpf_perf_event.h=
:2:10: fatal error: ../../arch/arm64/include/uapi/asm/bpf_perf_event.h: No =
such file or directory
>     2 | #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> ```
>=20
> I can submit a patch to fix this (and any other missing files), if
> someone could point me to where the script is that generates the perf
> tarballs.
>=20
Update - on digging in this only happens on aarch64 (probably why this
was not caught earlier). And it also affects 6.9.0. In all cases the
alternatives are either copying in that one header *or* passing
NO_LIBBPF=3D1

Once I know which script to update, the other thing I want to do is make
it bundle a copy of the COPYING file, since we ideally have that for
standalone distribution

perf now built for Hyperscale experimental and facebook repos - the only
difference is the facebook build has Perl support disabled

https://cbs.centos.org/koji/packageinfo?packageID=3D11475

I'll promote it to an official Hyperscale package once I figure out how
to build with the standard optimization flags in addition to the ones
perf overrides.

Best regards,

--=20
 _o) Michel Lind
_( ) identities: https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc0=
4f2

--KXUFu5kL7Z0KgGI3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCZ0UNPwAKCRCLIp0vfMwE
8m1XAQCdxdYe3tBkttBUhEWH3MxQII2tWsKK5WK/278dQiQXLQD/c7qGLUQCY9oz
GXVd7ZZrWHoVYOWsIB2RYjpGSLtxgQA=
=ZHYs
-----END PGP SIGNATURE-----

--KXUFu5kL7Z0KgGI3--
