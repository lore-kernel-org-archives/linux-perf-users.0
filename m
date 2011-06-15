From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] [perf] Add inverted call graph report support.
Date: Thu, 16 Jun 2011 00:24:05 +0200
Message-ID: <20110615222402.GB18579@somewhere.redhat.com>
References: <BANLkTi=svHgWzyKiEHjMc-j5Hq4y5R8Mow@mail.gmail.com>
 <20110609193300.GA16858@dev1756.snc6.facebook.com>
 <20110614221517.GA20319@dev1756.snc6.facebook.com>
 <BANLkTikcxA53t1ummUG3-3TagFhj==qYjw@mail.gmail.com>
 <20110615081518.GC12496@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110615081518.GC12496@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Sam Liao <phyomh@gmail.com>, Arun Sharma <asharma@fb.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, Jun 15, 2011 at 10:15:18AM +0200, Ingo Molnar wrote:
>=20
> * Sam Liao <phyomh@gmail.com> wrote:
>=20
> > On Wed, Jun 15, 2011 at 6:15 AM, Arun Sharma <asharma@fb.com> wrote=
:
> > > Sam,
> > >
> > > $ perf report -g graph,0.5,caller --sort pid
> > >
> > > is a bit hard to type. Perhaps add a simpler command line option
> > > that has the same effect?
> > >
> > > =A0-Arun
> > >
> > >
> >=20
> > How about perf report -g [caller/callee,][graph,0.1] -s pid
> >=20
> > or remove the order of the options for "-g"
>=20
> We could alias the -G flag to the inverse graph.

Agreed.
-g could map to fine tuning of callchain parameters like it does right =
now
and we can use -G as a shortcut for inverted callchain keeping the defa=
ult
settings.
=20
> Plus it would be nice to allow a .perfconfig flag for people to=20
> configure their desired default reporting parameters.

Yeah.

It would be also nice to have a "caller" sorting mode:

	perf report -G -s caller

This can be useful to get the entire tree of calls for each callers.
