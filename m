From: Pavel Machek <pavel@ucw.cz>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Thu, 7 Mar 2019 00:09:53 +0100
Message-ID: <20190306230953.GC7915@amd>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190125160056.GG6118@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190125160056.GG6118@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, eranian@google.com, vincent.weaver@maine.edu, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-01-25 08:00:56, Andi Kleen wrote:
> > [Fri Jan 25 10:28:53 2019] perf: interrupt took too long (2501 > 2500),=
 lowering kernel.perf_event_max_sample_rate to 79750
> > [Fri Jan 25 10:29:08 2019] perf: interrupt took too long (3136 > 3126),=
 lowering kernel.perf_event_max_sample_rate to 63750
> > [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (4140 > 3920),=
 lowering kernel.perf_event_max_sample_rate to 48250
> > [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (5231 > 5175),=
 lowering kernel.perf_event_max_sample_rate to 38000
> > [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (6736 > 6538),=
 lowering kernel.perf_event_max_sample_rate to 29500
>=20
> These are fairly normal.

Unfortunately, they are. Could we set up our defaults so that they
don't normally happen?

pavel@amd:~/g/unicsy_demo$ dmesg | grep "took too"
[  761.507893] perf: interrupt took too long (2516 > 2500), lowering
kernel.perf_event_max_sample_rate to 79250
[ 4736.674595] perf: interrupt took too long (3209 > 3145), lowering
kernel.perf_event_max_sample_rate to 62250
pavel@amd:~/g/unicsy_demo$


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyAU0EACgkQMOfwapXb+vJTEQCghbIoqocOdk1rDwJsoRb7+0Jp
IbMAoL+bib41Od+R688k6MrE2rLmkTxQ
=14SK
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
