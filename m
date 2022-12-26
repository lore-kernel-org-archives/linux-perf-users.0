Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB6C4167B
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Dec 2022 19:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiLZTzX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Dec 2022 14:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLZTzW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Dec 2022 14:55:22 -0500
X-Greylist: delayed 2406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Dec 2022 11:55:21 PST
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AED81176
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Dec 2022 11:55:21 -0800 (PST)
Received: from 213.219.160.184.adsl.dyn.edpnet.net ([213.219.160.184] helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1p9swI-0006KO-0B; Mon, 26 Dec 2022 20:15:10 +0100
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1p9swH-000vWG-1J;
        Mon, 26 Dec 2022 20:15:09 +0100
Message-ID: <62af20e156e799350b0281b7769442c4f1d414a3.camel@decadent.org.uk>
Subject: Re: Getting the latest and greatest Linux perf features on every
 Debian kernel
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ian Rogers <irogers@google.com>
Cc:     debian-kernel@lists.debian.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        waldi@debian.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 26 Dec 2022 20:15:00 +0100
In-Reply-To: <CAP-5=fUzHV765DqcTZpqCKC1Ve1H91tUfoxQE7Z2KcK5yq021A@mail.gmail.com>
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
         <YY58idSor+lJ84KF@kernel.org>
         <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
         <f59da80e6b4d053246fec4ef263ae4ca7aa1277f.camel@decadent.org.uk>
         <Ydx+mtl1c7L/bbGJ@kernel.org>
         <CAP-5=fUzHV765DqcTZpqCKC1Ve1H91tUfoxQE7Z2KcK5yq021A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-58MGJ4CSzUXisgTU/9/2"
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.160.184
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


--=-58MGJ4CSzUXisgTU/9/2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-12-22 at 17:43 -0800, Ian Rogers wrote:
[...]
> I had a few things to ask wrt this thread and getting the best
> possible Debian experience:
>  - in Linux 6.2 the libtraceevent will need to become an external
> library dependency

This shouldn't be a problem; it's already packaged separately in Debian
and we can build-depend on that.

>  - are there issues with debuginfod/zstd enablement? libbfd has
> licensing issues. libcrypto is only used by the JIT support, but still
> may be nice to enable.

- debuginfod is licensed under GPLv3+, so has the same issue as libbfd
- libzstd is licensed under GPLv2 (with most of its code also
permissively licensed)
- libcrypto is now licensed under Apache 2.0, which is not compatible
with GPLv2

So I think only libzstd can be enabled in official packages.

[...]
>  - are there some residual wrapper artifacts in the package, for example:
> ```
> $ dpkg -L linux-perf
> /.
> /usr
> /usr/bin
> /usr/bin/perf
> package diverts others to: /usr/bin/perf.wrapper
> ...
> package diverts others to: /usr/share/bash-completion/completions/perf.wr=
apper
> ...
> package diverts others to: /usr/share/man/man1/perf.wrapper.1.gz
> ...
> ```
[...]

These diversions are present to avoid conflicts with the wrappers in
older versions of linux-base.  We can remove them after the next stable
release.

Ben.

--=20
Ben Hutchings
Klipstein's 4th Law of Prototyping and Production:
                               A fail-safe circuit will destroy others.

--=-58MGJ4CSzUXisgTU/9/2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmOp8rQACgkQ57/I7JWG
EQlN7w//QFOk9H7e5+4Ai0zsxPAikPuU607ftTAC/+8yDSTIv/9tlw8SNK3Jznpz
rlLgI21DNnNG6hYgPQH2FZtusZY1MrfBUnFf/AfhZVp+LfT6JjA9NjvIiH/mORDM
uer4UrGKM+dgk6WSzSd7eU7pe458fYOZzV+hTMGXk+96mYuztvf2LUYmPUQOKs+m
fwJg/ECedU2TZoIodf9JjK/us/KrMT8wMsmCJylbRVYS0P37d0/j7TmoKTzfBmWI
TgU8LhlFOBI6LxsuJSwQkXt7OuVofco0m02BAoD0uljmkkjmWO/KJ5EcFuf2vstp
14S5si76HzxXxCQIGKQ/8HaKqDC17w5CXYonj34Hw+D/r8kzAgvDJVA7MHMJwkCH
10MZMiPBDwTwNvLFZc8RWr6NIHw1U9ZtgNUTBWK/a6dJg+8UTu/CpDzS5QyEsmUY
AQlCeETmWjfuxLiDGhkDZJoeRm6710tw5CxyKwiYGhEFox5ndmzawojMf11afFge
ODwiRigpoS4JIYaX1gL9Xwv2Krsam/tKQIAmZ9xBJUtZyaK7gxB0mMfvqIUyuMl+
b5r/zZ3EKNT6I647rMbsIcDozrNv9FE4HyPtfCLp8SdSEAZQHUhK+DxCf5KghMgf
pwMb2GjQ1lzIh14fRf1vG/f/2RB5hEFgLwTXwb9wo8y9m65lgvQ=
=d44Z
-----END PGP SIGNATURE-----

--=-58MGJ4CSzUXisgTU/9/2--
