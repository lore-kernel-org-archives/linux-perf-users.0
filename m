From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 04/15] perf tools: Add map_groups to 'struct
 addr_location'
Date: Fri, 29 Nov 2019 20:09:21 +0100
Message-ID: <20191129190921.GC26903@krava>
References: <20191112183757.28660-1-acme@kernel.org>
 <20191112183757.28660-5-acme@kernel.org>
 <20191129134056.GE14169@krava>
 <20191129151733.GC26963@kernel.org>
 <20191129160631.GD26963@kernel.org>
 <20191129180354.GB26903@krava>
 <20191129185914.GE4063@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191129185914.GE4063@kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Nov 29, 2019 at 03:59:14PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 29, 2019 at 07:03:54PM +0100, Jiri Olsa escreveu:
> > On Fri, Nov 29, 2019 at 01:06:31PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > Em Fri, Nov 29, 2019 at 12:17:33PM -0300, Arnaldo Carvalho de Melo es=
creveu:
> > > > Em Fri, Nov 29, 2019 at 02:40:56PM +0100, Jiri Olsa escreveu:
> > > > > > +++ b/tools/perf/util/callchain.c
> > > > > > @@ -1119,8 +1119,8 @@ int fill_callchain_info(struct addr_locat=
ion *al, struct callchain_cursor_node *
> > > > > >  =09=09=09goto out;
> > > > > >  =09}
> > > > > > =20
> > > > > > -=09if (al->map->groups =3D=3D &al->machine->kmaps) {
> > > > > > -=09=09if (machine__is_host(al->machine)) {
> > > > > > +=09if (al->mg =3D=3D &al->mg->machine->kmaps) {
> > >=20
> > > > > heya, I'm getting segfault because of this change
> > >=20
> > > > > perf record --call-graph dwarf ./ex
> > >=20
> > > > > =09(gdb) r report --stdio
> > > > > =09Program received signal SIGSEGV, Segmentation fault.
> > > > > =09fill_callchain_info (al=3D0x7fffffffa1b0, node=3D0xcd2bd0, hid=
e_unresolved=3Dfalse) at util/callchain.c:1122
> > > > > =091122            if (al->maps =3D=3D &al->maps->machine->kmaps)=
 {
> > > > > =09(gdb) p al->maps
> > > > > =09$1 =3D (struct maps *) 0x0
>=20
> > > > > I wish all those map changes would go through some review,
> > > > > I have no idea how the code works now ;-)
>=20
> > > > ouch, I did tons of tests, obviously some more, and reviewing, woul=
d
> > > > catch these, my bad, will try and fix this...
>=20
> > > > And yeah, I reproduced the problem, working on a fix.
>=20
> > > Can you try with this one-liner?
>=20
> > yep, it fixes the issue for me
>=20
> Thanks, I'm taking that as a Tested-by: you, in addition to the
> Reported-by,
>=20

sure, thanks

jirka
