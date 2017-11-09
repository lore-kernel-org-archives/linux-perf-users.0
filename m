From: Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@redhat.com>
Subject: Re: perf utility question: "Sky high iTLB-load-misses"
Date: Thu, 9 Nov 2017 19:50:48 +0100
Message-ID: <20171109185047.GC10004@redhat.com>
References: <20171108163440.GA10004@redhat.com>
 <alpine.DEB.2.20.1711081152280.1975@macbook-air>
 <20171109135325.GJ4333@kernel.org>
 <20171109143838.GY2482@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752517AbdKISuv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Nov 2017 13:50:51 -0500
Content-Disposition: inline
In-Reply-To: <20171109143838.GY2482@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Vince Weaver <vincent.weaver@maine.edu>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09/11/17 06:38 -0800, Andi Kleen wrote:
> On Thu, Nov 09, 2017 at 10:53:25AM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Nov 08, 2017 at 11:55:02AM -0500, Vince Weaver escreveu:
>>> On Wed, 8 Nov 2017, Jan Pokorn=C3=BD wrote:
>>>=20
>>>> Is iTLB-load-misses > 100% reported because of some deficiency
>>>> of the platform, a bug in perf, or an expected behaviour?
>>>=20
>>> If you look into the kernel, the two events being measured are
>>> 	[ C(RESULT_ACCESS) ] =3D 0x2085,  /* ITLB_MISSES.STLB_HIT */
>>> 	[ C(RESULT_MISS)   ] =3D 0xe85,   /* ITLB_MISSES.WALK_COMPLETED */
>>>=20
>>> If you look this up in Intel Vol3b you can see that the "access" metric
>>> measures First level ITLB misses that hit in the Second-level TLB
>>>=20
>>> Wheras the miss metric is a list of accesses from any level that caused=
 a=20
>>> walk of the page tables.
>>>=20
>>> So the events don't necessarily sound like they match up very well, so=
=20
>>> it's beleivable you will get odd results when trying to calculate=20
>>> percentages based on them.
>>=20
>> Andi, is this something you can help in figuring out a fix? Peter?
>=20
> See "perf list itlb"
>=20
> itlb access could be replaced with instructions retired,
> but I suspect that is also not what you're looking for.

Not sure I am getting the exact events right, but there are some
results concentrating just on these 3:

$ perf stat -r 100 -e itlb_misses.stlb_hit \
  -e frontend_retired.itlb_miss -e itlb_misses.walk_completed \
  --log-fd=3D1 ./log_callsite_bench_sectionless 2>/dev/null

> [...]
>          115,178      itlb_misses.stlb_hit                               =
           ( +-  2.53% )
>           46,199      frontend_retired.itlb_miss                         =
            ( +-  1.93% )
>          291,411      itlb_misses.walk_completed                         =
            ( +- 37.72% )
> [...]

but the ratio is flapping for particular runs, from three subsequent ones:

>           86,124      itlb_misses.stlb_hit
>           31,595      frontend_retired.itlb_miss
>            5,509      itlb_misses.walk_completed

vs.

>           97,578      itlb_misses.stlb_hit
>           33,673      frontend_retired.itlb_miss
>           15,961      itlb_misses.walk_completed

vs.

>          121,994      itlb_misses.stlb_hit
>           43,408      frontend_retired.itlb_miss
>          124,473      itlb_misses.walk_completed

I am by no mean knowledgeable in this field, didn't meant to make any real
conclusions based on the results, and I now suspect there's a reason behind
hiding iTLB-load-misses behind doubled -dd switch of the default execution
mode.  Was mainly curious why such obvious outliers on this Skylake machine
were observed.

> Only other alternative would be to disable the events.

Perhaps depends on the target audience, whether it's rather amateurs like m=
e or
hardware-literate (I mean down to archicture manuals' level) experts that c=
an
finely reason about all these metrics :)

(Nevertheless, I think keeping the basic mode easily consumable by the form=
er
group is a noble goal.)

--=20
Jan (Poki)

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaBKOHAAoJEGG7sjqej43iEogP/2skEwJ51Q5fj8TFhuOF5c6c
WNwk8pRY+CF1ceWX5mkFaiWKGO8lBbcft60ONFihEzOZ9FW8oLYTm2hKpBVkiORw
Xc7ivcy6+gtw29Eu32Nb8W3USCuY4bjcZabH8/QLVQ+TH5gcyqC9mxwl+ABY+od0
hZKqW3yYFOwSlfVC1yYUvN5F2/frEMJM1143u+gYaFEyHYBp3CxBTzqq8BPIYnSR
Q3XM8Z/oC5o7v8v9qeYtFNKhXSeCRfiirYRVfSREDRd8ctXo36OlqDyOqIH3jwUi
aW3m0S9ZzyjMoYOuWAgeQ5oRF27gbOwQQNSor0cRqilSecEqh76MsCnkBpr7UQ/F
6XjKerCdBWqUp4DH4XIjtZbO+sV2RaUMpRliX3sgd7gfTjuAFtnwhEFcj+liRQLV
MiYWHhdRe46dfdLfPgmYUNXcmNmINxccPsyGF/5ZBFXoKRRpkah9LPk87HVcrfYU
HOUpq3URq7m/b6+N4rY4ZafhG4qSgra2pT+LLP3pWNzsdJpyurJK8R2YnsJnIVx8
WDLBBtsPdtVliwd45fypukmZJiwrlVm27QQLOaoqIEIj5uoMjU3z/gTEz8d+HKzy
yg8RsjWkmQlSwrADLNuG4hnx7HOYmMfO8vhYV+8xoXegsH5mYTZ7uYcG8yTm/siF
URITzKzSHffEQol3x+QR
=hj+u
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
