From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf trace report with time consumed
Date: Wed, 30 Mar 2016 18:58:33 -0300
Message-ID: <20160330215832.GG3420@kernel.org>
References: <1894563.GPSC8z33rH@agathebauer>
 <20160330145314.GE3420@kernel.org>
 <4785655.UdtHu7qvlx@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59150 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977AbcC3V6h (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 30 Mar 2016 17:58:37 -0400
Content-Disposition: inline
In-Reply-To: <4785655.UdtHu7qvlx@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

Em Wed, Mar 30, 2016 at 11:24:17PM +0200, Milian Wolff escreveu:
> On Mittwoch, 30. M=E4rz 2016 11:53:14 CEST Arnaldo Carvalho de Melo w=
rote:
> > Em Tue, Mar 29, 2016 at 10:39:36PM +0200, Milian Wolff escreveu:
> > > with "perf trace record --call-graph dwarf" I get a nice data fil=
e with
> > > potentially everything required to find slow syscalls in user spa=
ce
> > > applications. But I'm missing a way to rewrite the data file to l=
et "perf
> > > report" attribute samples with the time spent as cost, instead of=
 the raw
> > > number of syscalls, i.e. samples.

<SNIP>

> > There is even:
> >=20
> > [root@jouet ~]# trace --duration 1000 -i perf.data
> >   1000.423 (1000.056 ms): sleep/1139 nanosleep(rqtp: 0x7ffebed266c0=
) =3D 0
> > [root@jouet ~]#
> >=20
> > Having that with callgraph from userspace is what you're asking for=
, no?
> >=20
> > 'trace' here is just an alias for 'perf trace'.
>=20
> Yep, I think having the individual trace entries annotated with their=
=20
> backtrace would be a useful addition and also brings perf trace close=
r to=20
> strace, cf. it's -k option.

Humm, I was unaware of that:

       -k          Print the execution stack trace of the traced
		   processes after each system call (experimental).
		   This option is available only if strace is built with
		   libunwind.

Which is not the case in fedora23 :-\

> But I still think that this would be useful to have as well:
>=20
> > > Is this functionality there already? Or do I have to write anothe=
r "perf
> > > inject" command, similar to "perf inject --sched-stat"?
>=20
> That would allow one to browse the aggregated call stacks in bottom-u=
p/top-
> down manner with `perf report`. `perf trace` allows the aggregation b=
y syscall=20
> via `--summary`, but I don't see a good way to add a call stacks visu=
alization=20
> there in any decent way. `perf inject` + `perf report` could solve th=
at=20
> nicely, no?

Probably, try it :-)

- Arnaldo
