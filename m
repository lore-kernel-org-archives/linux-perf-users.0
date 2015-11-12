From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: timing information with perf
Date: Thu, 12 Nov 2015 19:04:17 -0300
Message-ID: <20151112220417.GE7160@kernel.org>
References: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com>
 <20151112215728.GD7160@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50714 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbbKLWEV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 17:04:21 -0500
Content-Disposition: inline
In-Reply-To: <20151112215728.GD7160@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Cc: linux-perf-users@vger.kernel.org

Em Thu, Nov 12, 2015 at 06:57:28PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> Em Thu, Nov 12, 2015 at 09:07:20PM +0000, Kornievskaia, Olga escreveu=
:

> > Can somebody tell me if perf can do =E2=80=9Ctiming-of-operation=E2=
=80=9D type of
> > measurement? By that I mean, say there are two tracepoints
> > =E2=80=9Cfoobar_enter=E2=80=9D and =E2=80=9Cfoobar_exit=E2=80=9D. E=
ach tracepoint logs a timestamp.
> > I=E2=80=99d like to be able to say that on average it takes that ma=
ny
> > time-units between =E2=80=9Center=E2=80=9D and =E2=80=9Cexit=E2=80=9D=
 tracepoints. I haven=E2=80=99t been
> > able to find something like that with =E2=80=9Cperf=E2=80=9D.
=20
> Well, you can do:
>=20
>   # perf record -a -e sched:*waking*,sched:*wakeup* sleep 2
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.199 MB perf.data (156 samples) =
]
>   # perf script -g python
>   generated Python script: perf-script.py
>   # grep '^def ' perf-script.py=20
>   def trace_begin():
>   def trace_end():
>   def sched__sched_wakeup_new(event_name, context, common_cpu,
>   def sched__sched_wakeup(event_name, context, common_cpu,
>   def sched__sched_waking(event_name, context, common_cpu,
>   def trace_unhandled(event_name, context, event_fields_dict):
>   def print_header(event_name, cpu, secs, nsecs, pid, comm):
>   #
>=20
> The prototype for sched__sched_wakeup(), for instance is:
>=20
> def sched__sched_wakeup(event_name, context, common_cpu,
>         common_secs, common_nsecs, common_pid, common_comm,
>         common_callchain, comm, pid, prio, success,
>         target_cpu):
>=20
> Then do some minimal coding for what you want, because you need
> to match it using some key, i.e. same pid is enough for some cases, f=
or
> others you need pid + fd, etc.

If you do not change that script, then running it will produce:

  # perf script -s perf-script.p
  in trace_begin
  sched__sched_waking 2 09156.170326579 16181 perf comm=3Dperf, pid=3D1=
6182, prio=3D120, success=3D1, target_cpu=3D3
  sched__sched_wakeup 2 09156.170329797 16181 perf comm=3Dperf, pid=3D1=
6182, prio=3D120, success=3D1, target_cpu=3D3
  sched__sched_waking 3 09156.170446653 16182 perf comm=3Dmigration/3, =
pid=3D28, prio=3D0, success=3D1, target_cpu=3D3
<SNIP>
  in trace_end
=20
- Arnaldo
