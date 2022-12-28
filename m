Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3C5C10F1B
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Dec 2022 01:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiL1B6y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Dec 2022 20:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiL1B6m (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Dec 2022 20:58:42 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E23B7292;
        Tue, 27 Dec 2022 17:58:41 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 401901106;
        Wed, 28 Dec 2022 02:58:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672192721;
        bh=T0xNNhCSq7eox6ZW7rwjelLQ+yuE6npQ6iDEXXXfl30=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=ZTOnaPXuT3XIbwLeV/42cgze1icACWTRw/6Do4cHQZC4rcrCOSV2oMLKDwCxsnnDi
         NBMFkQz8nQ59zuEpTcREVFSJfbUGOmgjfSJQbCJdCgxEQIGGMvUNeRR0fV7vIowW0F
         QL9aIXvtp6LeZF2ALe5CKE/+wdHg54VVOMKbHTHMaB6OJet1RX4imW18Bm0FHL+yYe
         i5sivRv4tNE8thKMZJiZAAp4gh31nT1CqwKeuvWgPzq/0oRxjHTlP89F3EcVOQgZWA
         yte3vIWy86KQbZuNYSnatvL3sKSYXxVQSjKPs6LC+K9NiluMWhiTlPIBVbeZIZoIGa
         U8ZGz7PGac86g==
Date:   Wed, 28 Dec 2022 02:58:40 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 4/4] perf python: only check for the clang features we
 care about removing
Message-ID: <9756370bbcf53781b073dfc7953b76db0b69a08b.1672192591.git.nabijaczleweli@nabijaczleweli.xyz>
References: <44bb9a29bd7a0385c25ebfd69abd0a41ac2d753b.1672187710.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vyuwmpmjt5cojxm7"
Content-Disposition: inline
In-Reply-To: <44bb9a29bd7a0385c25ebfd69abd0a41ac2d753b.1672187710.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


--vyuwmpmjt5cojxm7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Instead of checking for all 6 flags every time for both fields,
only check for the ones we already know are in there.

This means instead of running 2*6 processes, we run, on my Bullseye system,
just one (for -fstack-protector-strong)! This reduces the run-time by
appx. (2*6-1)*.05=3D550ms (or, without the -c patch, 1.1s).

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 tools/perf/util/setup.py | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 0a557f2bf357..f4b94c0f9055 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -14,18 +14,9 @@ if cc_is_clang:
     vars =3D get_config_vars()
     for var in ('CFLAGS', 'OPT'):
         vars[var] =3D sub("-specs=3D[^ ]+", "", vars[var])
-        if not clang_has_option("-mcet"):
-            vars[var] =3D sub("-mcet", "", vars[var])
-        if not clang_has_option("-fcf-protection"):
-            vars[var] =3D sub("-fcf-protection", "", vars[var])
-        if not clang_has_option("-fstack-clash-protection"):
-            vars[var] =3D sub("-fstack-clash-protection", "", vars[var])
-        if not clang_has_option("-fstack-protector-strong"):
-            vars[var] =3D sub("-fstack-protector-strong", "", vars[var])
-        if not clang_has_option("-fno-semantic-interposition"):
-            vars[var] =3D sub("-fno-semantic-interposition", "", vars[var])
-        if not clang_has_option("-ffat-lto-objects"):
-            vars[var] =3D sub("-ffat-lto-objects", "", vars[var])
+        for opt in ("-mcet", "-fcf-protection", "-fstack-clash-protection"=
, "-fstack-protector-strong", "-fno-semantic-interposition", "-ffat-lto-obj=
ects"):
+            if vars[var].find(opt) !=3D -1 and not clang_has_option(opt):
+                vars[var] =3D vars[var].replace(opt, "")
=20
 from setuptools import setup, Extension
=20
--=20
2.30.2

--vyuwmpmjt5cojxm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOros8ACgkQvP0LAY0m
WPHFHhAArFjDykBA0LHZzcLMo3iyNVhQA9VFtxQMepwy+xju3KtPQmhhAzv8xPxU
9G6I9L7wgc+Z3D0SbQc4hY+KMDSvDQHUIVp+tZZwOz05uBVbBa/36o4F/eVzWnnO
eYeLuEYPrXxPeQq6DPk7gEonqNrprwWnTSTFcsJ99Qur10ge819FAkqPxbMYyVsM
aIn5JyDky95YNc0qrx+cUba33TKDAAL6u3NROe2s9VXgjq3Rx6/6p1OOBrcOS0xD
DfOqeQXosNJ+cKE27AhR3XAjdkZbLWC1cdomqNz2xSua6K8fuvzjTG4Ui9uwicCS
+XHpEcJjmGMDEOfU7B5WkibQIG+lP7VTfdjK+BqacQOqGK17x2gYllUvWeRUaTYA
fpVkYJduCk3B3umgWrJujBC1zl8sfCjLLUrh1tYaCMY6LI+vsT47hpYnfgoLVtdS
xrAeH0y5Ia9PobukkdYuYVV4lqVUhz8i/u2pJ5wBx6kLvgnAuoKfF5LHC/NVsdnf
ZqzkvLAMCxqanJ19eqeUfP92jZxujhT7uczTt82mBST3YCwKKKPEgQFUXTBWQk+u
OXtiwVWDM/MV0do95T3I8Xf8LobnuD8JtMgbXY4ZXhxXd2CrV5iCu1U2UbRCeMf4
sDPcKFMi8DhX0CVZMlPCAJHAcHMPpAA1Zk6ERPaM8oGuhSlbCfQ=
=VJVc
-----END PGP SIGNATURE-----

--vyuwmpmjt5cojxm7--
