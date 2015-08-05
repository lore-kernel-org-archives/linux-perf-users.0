From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 001/001] perf: let trace write to stderr by default
Date: Wed, 5 Aug 2015 16:52:11 -0300
Message-ID: <20150805195211.GC32553@kernel.org>
References: <3305230.aOMPB1fPqd@milian-kdab2>
 <CA+JHD92yJxikRUQ57Hb+C4pZ12gcFAn6paWenbAY5FbwtgQFDg@mail.gmail.com>
 <3494762.Lck5LtIdUB@milian-kdab2>
 <20150805195006.GB32553@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55214 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbbHETwO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Aug 2015 15:52:14 -0400
Content-Disposition: inline
In-Reply-To: <20150805195006.GB32553@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Em Wed, Aug 05, 2015 at 04:50:06PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> Em Tue, Aug 04, 2015 at 07:14:22PM +0200, Milian Wolff escreveu:
> > On Tuesday 04 August 2015 13:50:14 Arnaldo Carvalho de Melo wrote:
> > > Le 4 ao=FBt 2015 1:46 PM, "Milian Wolff" <mail@milianw.de> a =E9c=
rit :
> > > > See attached trivial patch which brings trace a bit closer to s=
trace.
> > > >=20
> > > > I've never published a patch to the Kernel yet, I hope it's OK =
as-is. I
> > >=20
> > > can
> > >=20
> > > > amend it at will if you have any requests to the style
> > >=20
> > > Start by not using attachments :-)
> >=20
> > :)
>=20
> Second step, read Documentation/email-clients.txt, you are using Kmai=
l
> and it is mangling the patches, I'll apply the patch by hand this tim=
e.

And don't forget to read Documentation/SubmittingPatches, you forgot th=
e
Signed-off-by part as well. It is simple stuff, so I'll not add it, kee=
p
your authorship and sign it off myself.
=20
> - Arnaldo
> =20
> > >From 188476d65bab17ad99f5bdf65294160ef2d5f49b Mon Sep 17 00:00:00 =
2001
> > From: Milian Wolff <milian.wolff@kdab.com>
> > Date: Tue, 4 Aug 2015 18:30:52 +0200
> > Subject: [PATCH] perf: let trace write to stderr by default
> >=20
> > Without this patch, it is cumbersome to read the trace output
> > but ignoring the normal, potentially verbose, output of the debugge=
e.
> > One common example is doing something like the following:
> >=20
> > perf trace -s find /tmp > /dev/null
> >=20
> > Without this patch, the trace summary will be lost. Now, it will
> > still be printed at the end. This behavior is also applied by strac=
e.
> > ---
> >  tools/perf/builtin-trace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.=
c
> > index 39ad4d0..d183d88 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2778,7 +2778,7 @@ int cmd_trace(int argc, const char **argv, co=
nst char=20
> > *prefix __maybe_unused)
> >  			.mmap_pages    =3D UINT_MAX,
> >  			.proc_map_timeout  =3D 500,
> >  		},
> > -		.output =3D stdout,
> > +		.output =3D stderr,
> >  		.show_comm =3D true,
> >  		.trace_syscalls =3D true,
> >  	};
> > --=20
> > 2.5.0
> >=20
> > --=20
> > Milian Wolff
> > mail@milianw.de
> > http://milianw.de
