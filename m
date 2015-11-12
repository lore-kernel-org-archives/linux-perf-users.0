From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: timing information with perf
Date: Thu, 12 Nov 2015 18:57:28 -0300
Message-ID: <20151112215728.GD7160@kernel.org>
References: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50465 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbbKLV5e (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 16:57:34 -0500
Content-Disposition: inline
In-Reply-To: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Cc: linux-perf-users@vger.kernel.org

Em Thu, Nov 12, 2015 at 09:07:20PM +0000, Kornievskaia, Olga escreveu:
> Hi,=20
>=20
> Can somebody tell me if perf can do =E2=80=9Ctiming-of-operation=E2=80=
=9D type of measurement? By that I mean, say there are two tracepoints =
=E2=80=9Cfoobar_enter=E2=80=9D and =E2=80=9Cfoobar_exit=E2=80=9D. Each =
tracepoint logs a timestamp. I=E2=80=99d like to be able to say that on=
 average it takes that many time-units between =E2=80=9Center=E2=80=9D =
and =E2=80=9Cexit=E2=80=9D tracepoints. I haven=E2=80=99t been able to =
find something like that with =E2=80=9Cperf=E2=80=9D.

Well, you can do:

  # perf record -a -e sched:*waking*,sched:*wakeup* sleep 2
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.199 MB perf.data (156 samples) ]
  # perf script -g python
  generated Python script: perf-script.py
  # grep '^def ' perf-script.py=20
  def trace_begin():
  def trace_end():
  def sched__sched_wakeup_new(event_name, context, common_cpu,
  def sched__sched_wakeup(event_name, context, common_cpu,
  def sched__sched_waking(event_name, context, common_cpu,
  def trace_unhandled(event_name, context, event_fields_dict):
  def print_header(event_name, cpu, secs, nsecs, pid, comm):
  #

The prototype for sched__sched_wakeup(), for instance is:

def sched__sched_wakeup(event_name, context, common_cpu,
        common_secs, common_nsecs, common_pid, common_comm,
        common_callchain, comm, pid, prio, success,
        target_cpu):

Then do some minimal coding for what you want, because you need
to match it using some key, i.e. same pid is enough for some cases, for
others you need pid + fd, etc.

	If you prefer perl, just use 'perf script -g perl' instead.

	If all you want is for syscalls, then 'perf trace' does get
enter+exit and does the math for you:

  # perf trace usleep 1 2>&1 | head -10
     0.083 ( 0.003 ms): usleep/5487 brk(                               =
                                   ) =3D 0x560cf53db000
     0.100 ( 0.003 ms): usleep/5487 mmap(len: 4096, prot: READ|WRITE, f=
lags: PRIVATE|ANONYMOUS, fd: -1    ) =3D 0x7f38f3617000
     0.108 ( 0.005 ms): usleep/5487 access(filename: 0xf3415270, mode: =
R                                  ) =3D -1 ENOENT No such file or dire=
ctory
     0.118 ( 0.005 ms): usleep/5487 open(filename: 0xf3413b92, flags: C=
LOEXEC                             ) =3D 3
     0.122 ( 0.003 ms): usleep/5487 fstat(fd: 3, statbuf: 0x7ffeaa0ad9a=
0                                  ) =3D 0
     0.126 ( 0.003 ms): usleep/5487 mmap(len: 111605, prot: READ, flags=
: PRIVATE, fd: 3                   ) =3D 0x7f38f35fb000
     0.128 ( 0.001 ms): usleep/5487 close(fd: 3                        =
                                   ) =3D 0
     0.139 ( 0.004 ms): usleep/5487 open(filename: 0xf360c37c, flags: C=
LOEXEC                             ) =3D 3
     0.142 ( 0.002 ms): usleep/5487 read(fd: 3, buf: 0x7ffeaa0adb30, co=
unt: 832                           ) =3D 832
     0.145 ( 0.001 ms): usleep/5487 fstat(fd: 3, statbuf: 0x7ffeaa0ad9d=
0                                  ) =3D 0
  #=20

And you can specify, just like with strace, what are the syscalls you w=
ant (or
the ones you don't, prefixing with !):

  # perf trace -e nanosleep sleep 1
  1000.744 (1000.239 ms): sleep/5661 nanosleep(rqtp: 0x7ffc4dce2960    =
                                    ) =3D 0
  #=20

You can also mix it with any other tracepoint, including any you have c=
reated
with 'perf probe', for kernel or userspace:

  # perf trace --event sched:*exit,sched:*switch,kmem:kmalloc -e nanosl=
eep sleep 1 2>&1 | tail -5
     0.343 (           ): kmem:kmalloc:(perf_event_mmap+0xc7) call_site=
=3Dffffffff81194617 ptr=3D0xffff88022a4ad000 bytes_req=3D4096 bytes_all=
oc=3D4096 gfp_flags=3DGFP_KERNEL)
     0.484 (   0.006 ms): sleep/6081 nanosleep(rqtp: 0x7ffdbcc9b6e0    =
                                    ) ...
     0.484 (           ): sched:sched_switch:sleep:6081 [120] S =3D=3D>=
 tail:6080 [120])
  1000.664 (1000.186 ms): sleep/6081  ... [continued]: nanosleep()) =3D=
 0
  1000.800 (           ): sched:sched_process_exit:comm=3Dsleep pid=3D6=
081 prio=3D120)
  #

- Arnaldo
