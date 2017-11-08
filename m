From: Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@redhat.com>
Subject: perf utility question: "Sky high iTLB-load-misses"
Date: Wed, 8 Nov 2017 17:34:40 +0100
Message-ID: <20171108163440.GA10004@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752675AbdKHQeq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Nov 2017 11:34:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29A0E25C2B
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Nov 2017 16:34:46 +0000 (UTC)
Received: from redhat.com (dhcp129-43.brq.redhat.com [10.34.129.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FC3B5D9C9
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Nov 2017 16:34:45 +0000 (UTC)
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I was recently comparing the effect of using orphan section offloading
of some data in the libqb project[*] and basically run into the
same rather strange reports by perf as asked on StackOverflow:
https://stackoverflow.com/q/47107255
(except that I'm on Skylake processor).

Is iTLB-load-misses > 100% reported because of some deficiency
of the platform, a bug in perf, or an expected behaviour?

Thanks and cheers.
Please, keep me in the loop, I am not subscribed to the list.

[*] comparing log_callsite_bench_section{full,less} from
https://github.com/ClusterLabs/libqb/pull/266/commits/a2b96193ec9a677e18824=
736c363df35ee0c68dd   =20

--=20
Jan (Poki)

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaAzIgAAoJEGG7sjqej43iAtsP/3so30FsWOEzjBlqsNR0/dOI
7rWtV4AbF1acPF/2HqUJpM2wURBaL/CYg2hYfSMdaajMupd/4JHbOCJVmYSVD8UK
+ZWHTWk83ewRfG2bVYHA4eoQgdR1sbTZla3Jd9kqVM8LvAEU65qJPNSI/iOYLEZL
51C6EI8OQT3tDnQTPySoV8Ap2UzcIRZuN2cEPWOKXAW62vU/Gtn4e2+FHGrfHGkj
psAkb/Byz84xNC9jEphxbf0L17PbCbVa0vRq0sQpdMuVa+3DGtp9QM9EXP9WfUa+
W2EX34mxfcQfv+JoWMNAZJgtwpz09BWZxqOuRA8EFF1iedKFgrsb0gjfhaCWD2j2
WAK8lzo19U+GrP/VQrspbnwFXFPTjQbBzqsXPpFsbNVQM0AuiMOom1yjblB+XPLI
wv1US5mlvY6OhYNR9aqAgWCxRwu884ut1HvBGsfv7ETmiFX5uIVRrggIdsBH6dg1
4RMfYFXH6ex1qNTUQUdo6nu+pcsMLbalm6QrKCVIGVJHWKqK71Tm1Dlg87l7GyW0
aBWcoM9GJrHAO+MTmJbIJ1k52qkkiVWJIaXQczVVCfole9hpTvEK2zphwOprevFC
BY7Bctqmw5qLKlAk9zp4jq55XsCfJ/QXmOMWe3dYYBIb9C+QrK68xfSSSmJlNzN+
TyFvWj33fW1e4HDlfLA2
=7u5M
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
