From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Perf event for Wall-time based sampling?
Date: Sat, 20 Sep 2014 00:50:57 +0900
Message-ID: <1411141857.1680.23.camel@leonhard>
References: <2221771.b2oSN5LR6X@milian-kdab2>
	 <874mw4m9pg.fsf@sejong.aot.lge.com> <20140919143340.GB32694@kernel.org>
	 <38149799.gZAnD74qWP@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:51817 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682AbaISPvD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 19 Sep 2014 11:51:03 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so183184pdj.6
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Sep 2014 08:51:03 -0700 (PDT)
In-Reply-To: <38149799.gZAnD74qWP@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

2014-09-19 (=EA=B8=88), 16:53 +0200, Milian Wolff:
> On Friday 19 September 2014 11:33:40 Arnaldo Carvalho de Melo wrote:
> > Em Fri, Sep 19, 2014 at 02:59:55PM +0900, Namhyung Kim escreveu:
> > > Hi Arnaldo and Millan,
> > >=20
> > > On Thu, 18 Sep 2014 16:17:13 -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > > Em Thu, Sep 18, 2014 at 06:37:47PM +0200, Milian Wolff escreveu=
:
> > > >> That would indeed be very welcome. There are multiple "default=
s" in
> > > >> perf which I find highly confusing. The --no-children above e.=
g.
> > > >> could/should probably be the default, no? Similar, I find it e=
xtremely
> > > >> irritating that `perf report -g`> >=20
> > > > It was, this is something we've actually been discussing recent=
ly: the
> > > > change that made --children be the default mode. That is why I =
added
> > > > Namhyung and Ingo to the CC list, so that they become aware of =
more
> > > > reaction to this change.
> > >=20
> > > Yeah, we should rethink about changing the default now.  Actually=
 I'm
> > > okay with the change, Ingo what do you think?
> > >=20
> > > >> defaults to `-g fractal` and not `-g graph`.
> > > >>=20
> > > >> 100% foo
> > > >>=20
> > > >>   70% bar
> > > >>  =20
> > > >>     70% asdf
> > > >>     30% lalala
> > > >>  =20
> > > >>   30% baz
> > > >>=20
> > > >> is much harder to interpret than
> > > >>=20
> > > >> 100% foo
> > > >>=20
> > > >>   70% bar
> > > >>  =20
> > > >>     49% asdf
> > > >>     21% lalala
> > > >>  =20
> > > >>   30% baz
> > >=20
> > > I also agree with you. :)
> > >=20
> > > > But the question then is if this is configurable, if not that w=
ould be a
> > > > first step, i.e. making this possible via some ~/.perfconfig ch=
ange.
> > >=20
> > > Yes, we have record.call-graph and top.call-graph config options =
now so
> > > adding a new report.call-graph option should not be difficult.  H=
owever
> > > I think it'd be better being call-graph.XXX as it can be applied =
to all
> >=20
> > No problem, with sourcing being supported in ~/.perfconfig, we can =
have
> > as many #include call-graph.XXX as needed, multiple levels of inclu=
des
> > and all.
> >=20
> > > other subcommands transparently.
> > >=20
> > > What about like below?
> > >=20
> > > [call-graph]
> > >=20
> > >   mode =3D dwarf
> > >   dump-size =3D 8192
> > >   print-type =3D fractal
> > >   order =3D callee
> > >   threshold =3D 0.5
> > >   print-limit =3D 128
> > >   sort-key =3D function
> >=20
> > Milian, does this provide what you expect? How would we call this
> > specific call-graph profile?
>=20
> print-type should be graph, not fractal. Otherwise it sounds good to =
me. But=20
> how would one use it? I tried putting it into ~/.perfconfig, but appa=
rently my=20
> 3.16.2-1-ARCH Perf does not support this feature yet? How/when would =
that=20
> config be used? As soon as one does "perf record -g" (for mode and du=
mp-size)=20
> or "perf report" (for a perf.data with call graphs)? That would be ve=
ry=20
> useful!

This is a proposal for new config items which can be included into the
~/.perfconfig file.  You can change it as you want later and it should
apply to default behavior of perf record -g and perf report.

Thanks,
Namhyung=20
