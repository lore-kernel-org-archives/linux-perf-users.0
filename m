Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5846C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  9 Jan 2022 23:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiAIXz0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 9 Jan 2022 18:55:26 -0500
Received: from maynard.decadent.org.uk ([95.217.213.242]:55174 "EHLO
        maynard.decadent.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiAIXzO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 9 Jan 2022 18:55:14 -0500
Received: from 168.7-181-91.adsl-dyn.isp.belgacom.be ([91.181.7.168] helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1n6hor-0004Ws-Bu; Mon, 10 Jan 2022 00:41:49 +0100
Received: from ben by deadeye with local (Exim 4.95)
        (envelope-from <ben@decadent.org.uk>)
        id 1n6hoq-001k6c-OH;
        Mon, 10 Jan 2022 00:41:48 +0100
Message-ID: <d7b0f5401be0512421c7d02ec38475d1b04f64d2.camel@decadent.org.uk>
Subject: Re: Getting the latest and greatest Linux perf features on every
 Debian kernel
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     debian-kernel@lists.debian.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 10 Jan 2022 00:41:44 +0100
In-Reply-To: <YY58idSor+lJ84KF@kernel.org>
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
         <YY58idSor+lJ84KF@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-kF8dBBefsfM7srs3BpJ6"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.181.7.168
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


--=-kF8dBBefsfM7srs3BpJ6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-11-12 at 11:39 -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 11, 2021 at 10:34:33PM -0800, Ian Rogers escreveu:
> > Hi,
> =20
> > Debian currently tries to match the Linux perf tool to the version of
> > the kernel that it is being run upon. Reaching out to Ben Hutchings,
> > he explained to me that this was done back in 2010 due to kernel and
> > Linux perf incompatibilities. This was likely the case, but it was a
> > bug in the Linux perf tool that should have been fixed.

My understanding at the time was that the perf developers weren't
trying to provide backward compatibility.  If I hadn't though that, I
wouldn't have bothered with the wrapper and would have forwarded any
bug reports we got about compatibility breaks.

> > It is the goal
> > of the tool to be backward compatible. A problem with matching the
> > tool to the kernel version is that users miss out on new features and
> > fixes (this topic came up in a recent interview of the maintainer
> > Arnaldo Carvalho de Melo [1]).
> =20
> > Ben Hutchings informs me that making it so that Debian ships the
> > latest Linux perf tool requires updates both to the linux-base and
> > linux source packages. The Linux perf tool also has many other often
> > optional dependencies, like libunwind, libbpf, libpfm4, libtraceevent,
> > etc. In general, having the dependency will unlock more features.
> > Linux tools has its own copies of libbpf and libtraceevent, and so
> > these may pose some versioning issues.

The libraries themselves are statically linked, so there's no conflict
there, but the libtraceevent plugins have the potential to conflict.

> We can use LIBBPF_DYNAMIC=3D1 to use the distro libbpf-dev package, which
> currently is going thru some growing pains as libbpf is 0.x, with
> several APIs being deprecated, others renamed, and that has been a
> source of friction, but should be past us with v1.0. Till then the perf
> codebase is being adjusted to allow it to be seamlessly built with the
> in-kernel version and with whatever libbpf-devel the distro has.
> =20
> > I think it'd be great to get Debian shipping the latest version of
> > Linux perf for its users. Hopefully we can agree to change how Debian
> > packages perf currently and then work out the best way to package and
> > keep it up-to-date. I look forward to everyone's help and input.
>=20
> I also keep the tarballs available at:
>=20
> https://mirrors.edge.kernel.org/pub/linux/kernel/tools/perf/
>=20
> Where there are instructions on how to build this detached tarball.
>=20
> I regularly build perf on lots of distros, including:
>=20
>   debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0=
 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
>   debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang=
 version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
>   debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210=
110 , Debian clang version 11.0.1-2
>   debian:experimental           : Ok   gcc (Debian 11.2.0-10) 11.2.0 , De=
bian clang version 11.1.0-4
>   debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2=
.0-9) 11.2.0
>   debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-=
6) 10.2.1 20210110
>   debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian =
10.2.1-6) 10.2.1 20210110
>   debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.=
0-9) 11.2.0
[...]

I'm glad to hear that.

But whether perf tools can be built in different environments is
orthogonal to the current questions for Debian's packaging, which are:

- Do they run correctly on older kernel version?  (I think you're
  claiming they do.)
- Is there a reason to prefer building from those separate tarballs,
  rather than from kernel releases?  (I don't think there is.)


Ben.

--=20
Ben Hutchings
I say we take off; nuke the site from orbit.
It's the only way to be sure.

--=-kF8dBBefsfM7srs3BpJ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmHbcrgACgkQ57/I7JWG
EQnyORAA0mhKLczj5q2czzvd2uxk1FIBG20XkKvOxr0YtkI9DmL86CpWi3y4R7cI
uetbE+GeqpbQK/UpHuw1nGMibeFtni4jQSOKBSSHktJXe607SHC0Q0CSD17p+Et/
j1RZAzN6E4F4M7E/UkQ7rHsUBGLHzb/I2oVtNMgXa/AHSOduCRwUjI8qrgUknIX5
FpOZt4tWs7yJSRD0kCBbILX4+tYzKp1TrcwRdlwB3UWChbfPXELnlmI/aURgIKvZ
bFXBsibjCGwxKNih6aEpoRMxFgDlTbzk/jVF+EAX9cdXOJIAD8mvJJmYeGxCv+1p
jdZJ0R1Z9BfDdhmUvgDOJxMWy9wBo5MBd6Co0aBB7B0/2d/zY8Z0LYeZqKnSxYKQ
sRv6afbUBYI22OvTOY6lFqpR4ZCVjAAXyNxotDl835Z40Xpxce36kybzQYx9yqsA
xV4ZSbiGnP+u7H4a9WK8dsmrVkQk406WXC9n3DRkPSc5zvcey0yRhNhH/UDGqsbL
MnmYGQ1lLB0+CRm5kLmKO3mU21y+TaDRPFM0gE8gJPI6DCs6RCUEMKT3Atf/lG0W
rhDDib5XbTrF66HLfLWelxjrpD23mB8lSSZJy6m2p4L8h/RVHeytsFgIdCyc1joq
PaQuitDyWADRVpQCGPJDbuDVtSd3JlM9tRiwQpHagS/2U/A2ZVQ=
=H5Uo
-----END PGP SIGNATURE-----

--=-kF8dBBefsfM7srs3BpJ6--
