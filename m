Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A371CC6379F
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Jan 2023 22:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjAMWHH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Jan 2023 17:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjAMWHF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Jan 2023 17:07:05 -0500
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EC311826
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Jan 2023 14:07:05 -0800 (PST)
Received: from 213.219.160.184.adsl.dyn.edpnet.net ([213.219.160.184] helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1pGSCS-00026y-Bm; Fri, 13 Jan 2023 23:07:00 +0100
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1pGSCR-005GnZ-2O;
        Fri, 13 Jan 2023 23:06:59 +0100
Message-ID: <0b1c5f9af241327786a996a3ddd61602b5a15987.camel@decadent.org.uk>
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
Date:   Fri, 13 Jan 2023 23:06:55 +0100
In-Reply-To: <CAP-5=fUcc-SmxqgNCnqNAc=adGdzK31eQtv8XKQLt8v4EtLguQ@mail.gmail.com>
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
         <YY58idSor+lJ84KF@kernel.org>
         <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
         <f59da80e6b4d053246fec4ef263ae4ca7aa1277f.camel@decadent.org.uk>
         <Ydx+mtl1c7L/bbGJ@kernel.org>
         <CAP-5=fUzHV765DqcTZpqCKC1Ve1H91tUfoxQE7Z2KcK5yq021A@mail.gmail.com>
         <62af20e156e799350b0281b7769442c4f1d414a3.camel@decadent.org.uk>
         <CAP-5=fUcc-SmxqgNCnqNAc=adGdzK31eQtv8XKQLt8v4EtLguQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-MGs+hGlSyn8/TupYzuEN"
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.160.184
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


--=-MGs+hGlSyn8/TupYzuEN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2023-01-09 at 17:32 -0800, Ian Rogers wrote:
[...]
> Thanks again Ben! With the releases, the plan is to follow the kernel
> releases? We could potentially be more aggressive with the perf tool
> given its backward compatibility. That would benefit people using
> older kernels who want the latest perf tool bug fixes and features.
>=20

Yes, we continue to build perf from the same source package as our
kernel images.  Users of a stable release can still install newer
versions of perf and/or the kernel from the corresponding -backports
suite without upgrading everything elese.

Ben.

--=20
Ben Hutchings
The program is absolutely right; therefore, the computer must be wrong.

--=-MGs+hGlSyn8/TupYzuEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmPB1f8ACgkQ57/I7JWG
EQnWDw/+PO9lufUD4+Zz2S1eJS58fvRlU8M9qMHtZlTkg3yjW+KD62pJrhbQrAoR
Sms1OA9EmKB4DXiGPPPgZKigIjjubeFXxmsNdLd4hxcXK7yX+YV5SN9RwLEyAEXC
/CVkknZ1Vg2SFkWGSID/nRE/Z3Exxpihq4glxtZvsfkokKnYp6m5AUf5njJdrwtF
A/KKA0rTR/RphwzHlyD49vC55ql00Tzi+qx1EibZyWaDIKukC+TP2r5dFjYW/u20
DZYjWt7KRTPfmi7zMm2vfuU61oiA19v+0hkMNJM/uS2J3Kz+TKUOs9KftxlfmREN
e3KRqbSfbd0XvsiDS66r7ALwBxv5qqMTktYOKQqY9KtBEU56qQWvOem8F0ui0VrX
TV5ksI20K/OqsFR1/1DXC3Nl/nr7bTo/1F0bnUmZ6nLnw5bHWIoyvwPljtYkOILs
buLtOOP369rQzyQZJV6c5f8JqFdAiwootMktVUYtoDfIYsPFnlzPy9u0SaRfxisU
RTVaZnoWRDuVfZzRD9SrXLbiawSx4+Hd++IuEMh5uHwZQKP8Zib/VubqmuxJG4NC
p2D/AWHrD9FEnlSGOCd0V2eQuoNCgw8l4I+aOHbtAccQYIAAFJI86rlU98yoAVhL
FSJ8wwMDEahjkp3q8pXn07o+o1g4DqM8B0kPmRq04/CkugTy70Q=
=jBTn
-----END PGP SIGNATURE-----

--=-MGs+hGlSyn8/TupYzuEN--
