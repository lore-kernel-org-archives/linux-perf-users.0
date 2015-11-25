From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: bogus values of variables in userspace probes
Date: Tue, 24 Nov 2015 23:24:44 -0300
Message-ID: <20151125022444.GN18140@kernel.org>
References: <1448363902.24573.18.camel@redhat.com>
 <20151124150819.GD18140@kernel.org>
 <1448389839.24573.21.camel@redhat.com>
 <50399556C9727B4D88A595C8584AAB375262F4C3@GSjpTKYDCembx32.service.hitachi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54962 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755337AbbKYCYu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 Nov 2015 21:24:50 -0500
Content-Disposition: inline
In-Reply-To: <50399556C9727B4D88A595C8584AAB375262F4C3@GSjpTKYDCembx32.service.hitachi.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>
Cc: 'Michael Petlan' <mpetlan@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, David Ahern <dsahern@gmail.com>, Wang Nan <wangnan0@huawei.com>

Em Wed, Nov 25, 2015 at 01:03:47AM +0000, =E5=B9=B3=E6=9D=BE=E9=9B=85=E5=
=B7=B3 / HIRAMATU=EF=BC=8CMASAMI escreveu:
> From: Michael Petlan [mailto:mpetlan@redhat.com]
> >On Tue, 2015-11-24 at 12:08 -0300, Arnaldo Carvalho de Melo wrote:
> >> Em Tue, Nov 24, 2015 at 12:18:22PM +0100, Michael Petlan escreveu:
> >> > I have been playing with perf-probe tool and I found out that so=
me bogus
> >> > values of a function argument are obtained by perf-record.
> >> >
> >> > How to reproduce:
> >> >
> >> > gcc -O0 -g -o dummy dummy.c
> >> > perf probe -x ./dummy --add 'isprime a'
> >> > perf record -e probe_dummy:isprime ./dummy
> >> > perf script
> >> >
> >> > The actual output looks like the following:
> >> >
> >> > dummy 32476 [000] 3534401.838454: probe_dummy:isprime: (400530) =
a=3D32767
> >> > dummy 32476 [000] 3534401.838504: probe_dummy:isprime: (400530) =
a=3D32714
> >> > dummy 32476 [000] 3534401.838513: probe_dummy:isprime: (400530) =
a=3D3
> >> > dummy 32476 [000] 3534401.838519: probe_dummy:isprime: (400530) =
a=3D4
> >> > dummy 32476 [000] 3534401.838525: probe_dummy:isprime: (400530) =
a=3D5
> >> > dummy 32476 [000] 3534401.838531: probe_dummy:isprime: (400530) =
a=3D6
> >> > dummy 32476 [000] 3534401.838537: probe_dummy:isprime: (400530) =
a=3D7
> >> > dummy 32476 [000] 3534401.838543: probe_dummy:isprime: (400530) =
a=3D13
> >> > dummy 32476 [000] 3534401.838561: probe_dummy:isprime: (400530) =
a=3D17
>=20
> Hmm, very odd.
>=20
> Could you try to use ftrace with user stacktrace on that event?
>=20
> # echo 1 > (debugfs)/tracing/options/stacktrace
> # echo 1 > (debugfs)/tracing/options/userstacktrace
> # echo 1 > events/probe_dummy/isprime/enable
> # ./dummy
> # cat trace
>=20
> And decode the stack address by using (eu-)addr2line ?

[root@zoo tracing]# cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 27/27   #P:4
#
#                              _-----=3D> irqs-off
#                             / _----=3D> need-resched
#                            | / _---=3D> hardirq/softirq
#                            || / _--=3D> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
         isprime-21965 [001] d... 199755.374474: isprime: (0x400536) a=3D=
0
         isprime-21965 [001] d... 199755.374487: <stack trace>
 =3D> exit_to_usermode_loop
 =3D> prepare_exit_to_usermode
 =3D> retint_user
         isprime-21965 [001] d... 199755.374488: <user stack trace>
 =3D>  <0000000000400536>
 =3D>  <00007f6a29883fe0>
         isprime-21965 [001] d... 199755.374561: isprime: (0x400536) a=3D=
32618
         isprime-21965 [001] d... 199755.374567: <stack trace>
 =3DG> exit_to_usermode_loop
 =3D> prepare_exit_to_usermode
 =3D> retint_user
         isprime-21965 [001] d... 199755.374568: <user stack trace>
 =3D>  <0000000000400536>
 =3D>  <00007f6a29883fe0>
         isprime-21965 [001] d... 199755.374577: isprime: (0x400536) a=3D=
3
         isprime-21965 [001] d... 199755.374583: <stack trace>
 =3D> exit_to_usermode_loop
 =3D> prepare_exit_to_usermode
 =3D> retint_user
         isprime-21965 [001] d... 199755.374583: <user stack trace>
 =3D>  <0000000000400536>
 =3D>  <00007f6a29883fe0>
         isprime-21965 [001] d... 199755.374591: isprime: (0x400536) a=3D=
4
         isprime-21965 [001] d... 199755.374597: <stack trace>
 =3D> exit_to_usermode_loop
 =3D> prepare_exit_to_usermode
 =3D> retint_user
         isprime-21965 [001] d... 199755.374597: <user stack trace>
 =3D>  <0000000000400536>
 =3D>  <00007f6a29883fe0>
         isprime-21965 [001] d... 199755.374604: isprime: (0x400536) a=3D=
5
         isprime-21965 [001] d... 199755.374610: <stack trace>
 =3D> exit_to_usermode_loop
 =3D> prepare_exit_to_usermode
 =3D> retint_user
         isprime-21965 [001] d... 199755.374610: <user stack trace>
 =3D>  <0000000000400536>
 =3D>  <00007f6a29883fe0>
         isprime-21965 [001] d... 199755.374618: isprime: (0x400536) a=3D=
6
         isprime-21965 [001] d... 199755.374624: <stack trace>
 =3D> exit_to_usermode_loop
 =3D> prepare_exit_to_usermode
 =3D> retint_user
         isprime-21965 [001] d... 199755.374624: <user stack trace>
 =3D>  <0000000000400536>
 =3D>  <00007f6a29883fe0>
         isprime-21965 [001] d... 199755.374631: isprime: (0x400536) a=3D=
7
         isprime-21965 [001] d... 199755.374637: <stack trace>
 =3D> exit_to_usermode_loop
 =3D> prepare_exit_to_usermode
 =3D> retint_user
         isprime-21965 [001] d... 199755.374637: <user stack trace>
 =3D>  <0000000000400536>
 =3D>  <00007f6a29883fe0>
         isprime-21965 [001] d... 199755.374644: isprime: (0x400536) a=3D=
13
         isprime-21965 [001] d... 199755.374650: <stack trace>
 =3D> exit_to_usermode_loop
 =3D> prepare_exit_to_usermode
 =3D> retint_user
         isprime-21965 [001] d... 199755.374650: <user stack trace>
 =3D>  <0000000000400536>
 =3D>  <00007f6a29883fe0>
         isprime-21965 [001] d... 199755.374657: isprime: (0x400536) a=3D=
17
         isprime-21965 [001] d... 199755.374663: <stack trace>
 =3D> exit_to_usermode_loop
 =3D> prepare_exit_to_usermode
 =3D> retint_user
         isprime-21965 [001] d... 199755.374664: <user stack trace>
 =3D>  <0000000000400536>
 =3D>  <00007f6a29883fe0>
[root@zoo tracing]#


Tried with 'perf record' to get callchains, but:

[root@zoo ~]# perf record --call-graph dwarf -e probe_isprime:* ~acme/i=
sprime
Error:
The sys_perf_event_open() syscall returned with 4 (Interrupted system c=
all) for event (probe_isprime:isprime).
/bin/dmesg may provide additional information.
No CONFIG_PERF_EVENTS=3Dy kernel support configured?

[root@zoo ~]# perf record -e probe_isprime:isprime ~acme/isprime
Error:
The sys_perf_event_open() syscall returned with 4 (Interrupted system c=
all) for event (probe_isprime:isprime).
/bin/dmesg may provide additional information.
No CONFIG_PERF_EVENTS=3Dy kernel support configured?

[root@zoo ~]#

Doesn't work with or without callchains :-\

Ah, probably that thing was left enabled by the ftrace session?

[root@zoo tracing]# cat events/probe_isprime/enable=20
1
[root@zoo tracing]# echo 0 > events/probe_isprime/enable=20
[root@zoo tracing]#

Lets see with it disabled:

[root@zoo ~]# perf record --call-graph dwarf -e probe_isprime:* ~acme/i=
sprime
2 is prime
3 is prime
4 is not prime
5 is prime
6 is not prime
7 is prime
13 is prime
17 is prime
19 is prime
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.090 MB perf.data (9 samples) ]
[root@zoo ~]#

Yeah, that is something else to fix:

The sys_perf_event_open() syscall returned with 4 (Interrupted system c=
all) for event (probe_isprime:isprime).

Is too cryptic for that :-)

Anyway, back to the perf record with callchains:

[root@zoo ~]# perf report --stdio --no-child
# To display the perf.data header info, please use --header/--header-on=
ly options.
#
#
# Total Lost Samples: 0
#
# Samples: 9  of event 'probe_isprime:isprime'
# Event count (approx.): 9
#
# Overhead  Command  Shared Object  Symbol    =20
# ........  .......  .............  ...........
#
   100.00%  isprime  isprime        [.] isprime
            |
            ---isprime
               main
               __libc_start_main
               _start

#
# (For a higher level overview, try: perf report --sort comm,dso)
#
[root@zoo ~]#

See below the output of the above call in verbose mode, should have the
addresses you asked to resolve using addr2line:

registering plugin: /root/.traceevent/plugins/plugin_function.so
registering plugin: /root/.traceevent/plugins/plugin_mac80211.so
registering plugin: /root/.traceevent/plugins/plugin_scsi.so
registering plugin: /root/.traceevent/plugins/plugin_hrtimer.so
registering plugin: /root/.traceevent/plugins/plugin_sched_switch.so
registering plugin: /root/.traceevent/plugins/plugin_cfg80211.so
registering plugin: /root/.traceevent/plugins/plugin_kmem.so
registering plugin: /root/.traceevent/plugins/plugin_kvm.so
registering plugin: /root/.traceevent/plugins/plugin_xen.so
registering plugin: /root/.traceevent/plugins/plugin_jbd2.so
build id event received for /home/acme/isprime: 597554d0e35bcaf7f1b09a2=
05456baf9fbbadc4a
unwind: reg 16, val 400536
unwind: reg 7, val 7ffc4f77b648
unwind: find_proc_info dso /home/acme/isprime
unwind: access_mem addr 0x7ffc4f77b648 val 4005ea, offset 0
unwind: find_proc_info dso /home/acme/isprime
unwind: reg 6, val 7ffc4f77b690
unwind: access_mem addr 0x7ffc4f77b698 val 7f7fe7a0cfe0, offset 80
unwind: find_proc_info dso /usr/lib64/libc-2.20.so
unwind: access_mem addr 0x7ffc4f77b758 val 400469, offset 272
unwind: find_proc_info dso /home/acme/isprime
Looking at the vmlinux_path (7 entries long)
Using /lib/modules/4.3.0+/build/vmlinux for symbols
unwind: isprime:ip =3D 0x400536 (0x536)
unwind: main:ip =3D 0x4005ea (0x5ea)
unwind: __libc_start_main:ip =3D 0x7f7fe7a0cfe0 (0x1ffe0)
unwind: _start:ip =3D 0x400469 (0x469)
unwind: reg 16, val 400536
unwind: reg 7, val 7ffc4f77b648
unwind: access_mem addr 0x7ffc4f77b648 val 4005ea, offset 0
unwind: reg 6, val 7ffc4f77b690
unwind: access_mem addr 0x7ffc4f77b698 val 7f7fe7a0cfe0, offset 80
unwind: access_mem addr 0x7ffc4f77b758 val 400469, offset 272
unwind: isprime:ip =3D 0x400536 (0x536)
unwind: main:ip =3D 0x4005ea (0x5ea)
unwind: __libc_start_main:ip =3D 0x7f7fe7a0cfe0 (0x1ffe0)
unwind: _start:ip =3D 0x400469 (0x469)
unwind: reg 16, val 400536
unwind: reg 7, val 7ffc4f77b648
unwind: access_mem addr 0x7ffc4f77b648 val 4005ea, offset 0
unwind: reg 6, val 7ffc4f77b690
unwind: access_mem addr 0x7ffc4f77b698 val 7f7fe7a0cfe0, offset 80
unwind: access_mem addr 0x7ffc4f77b758 val 400469, offset 272
unwind: isprime:ip =3D 0x400536 (0x536)
unwind: main:ip =3D 0x4005ea (0x5ea)
unwind: __libc_start_main:ip =3D 0x7f7fe7a0cfe0 (0x1ffe0)
unwind: _start:ip =3D 0x400469 (0x469)
unwind: reg 16, val 400536
unwind: reg 7, val 7ffc4f77b648
unwind: access_mem addr 0x7ffc4f77b648 val 4005ea, offset 0
unwind: reg 6, val 7ffc4f77b690
unwind: access_mem addr 0x7ffc4f77b698 val 7f7fe7a0cfe0, offset 80
unwind: access_mem addr 0x7ffc4f77b758 val 400469, offset 272
unwind: isprime:ip =3D 0x400536 (0x536)
unwind: main:ip =3D 0x4005ea (0x5ea)
unwind: __libc_start_main:ip =3D 0x7f7fe7a0cfe0 (0x1ffe0)
unwind: _start:ip =3D 0x400469 (0x469)
unwind: reg 16, val 400536
unwind: reg 7, val 7ffc4f77b648
unwind: access_mem addr 0x7ffc4f77b648 val 4005ea, offset 0
unwind: reg 6, val 7ffc4f77b690
unwind: access_mem addr 0x7ffc4f77b698 val 7f7fe7a0cfe0, offset 80
unwind: access_mem addr 0x7ffc4f77b758 val 400469, offset 272
unwind: isprime:ip =3D 0x400536 (0x536)
unwind: main:ip =3D 0x4005ea (0x5ea)
unwind: __libc_start_main:ip =3D 0x7f7fe7a0cfe0 (0x1ffe0)
unwind: _start:ip =3D 0x400469 (0x469)
unwind: reg 16, val 400536
unwind: reg 7, val 7ffc4f77b648
unwind: access_mem addr 0x7ffc4f77b648 val 4005ea, offset 0
unwind: reg 6, val 7ffc4f77b690
unwind: access_mem addr 0x7ffc4f77b698 val 7f7fe7a0cfe0, offset 80
unwind: access_mem addr 0x7ffc4f77b758 val 400469, offset 272
unwind: isprime:ip =3D 0x400536 (0x536)
unwind: main:ip =3D 0x4005ea (0x5ea)
unwind: __libc_start_main:ip =3D 0x7f7fe7a0cfe0 (0x1ffe0)
unwind: _start:ip =3D 0x400469 (0x469)
unwind: reg 16, val 400536
unwind: reg 7, val 7ffc4f77b648
unwind: access_mem addr 0x7ffc4f77b648 val 4005ea, offset 0
unwind: reg 6, val 7ffc4f77b690
unwind: access_mem addr 0x7ffc4f77b698 val 7f7fe7a0cfe0, offset 80
unwind: access_mem addr 0x7ffc4f77b758 val 400469, offset 272
unwind: isprime:ip =3D 0x400536 (0x536)
unwind: main:ip =3D 0x4005ea (0x5ea)
unwind: __libc_start_main:ip =3D 0x7f7fe7a0cfe0 (0x1ffe0)
unwind: _start:ip =3D 0x400469 (0x469)
unwind: reg 16, val 400536
unwind: reg 7, val 7ffc4f77b648
unwind: access_mem addr 0x7ffc4f77b648 val 4005ea, offset 0
unwind: reg 6, val 7ffc4f77b690
unwind: access_mem addr 0x7ffc4f77b698 val 7f7fe7a0cfe0, offset 80
unwind: access_mem addr 0x7ffc4f77b758 val 400469, offset 272
unwind: isprime:ip =3D 0x400536 (0x536)
unwind: main:ip =3D 0x4005ea (0x5ea)
unwind: __libc_start_main:ip =3D 0x7f7fe7a0cfe0 (0x1ffe0)
unwind: _start:ip =3D 0x400469 (0x469)
unwind: reg 16, val 400536
unwind: reg 7, val 7ffc4f77b648
unwind: access_mem addr 0x7ffc4f77b648 val 4005ea, offset 0
unwind: reg 6, val 7ffc4f77b690
unwind: access_mem addr 0x7ffc4f77b698 val 7f7fe7a0cfe0, offset 80
unwind: access_mem addr 0x7ffc4f77b758 val 400469, offset 272
unwind: isprime:ip =3D 0x400536 (0x536)
unwind: main:ip =3D 0x4005ea (0x5ea)
unwind: __libc_start_main:ip =3D 0x7f7fe7a0cfe0 (0x1ffe0)
unwind: _start:ip =3D 0x400469 (0x469)
# To display the perf.data header info, please use --header/--header-on=
ly options.
#
#
# Total Lost Samples: 0
#
# Samples: 9  of event 'probe_isprime:isprime'
# Event count (approx.): 9
#
# Overhead  Command  Shared Object       Symbol                        =
 =20
# ........  .......  ..................  ..............................=
=2E.
#
   100.00%  isprime  /home/acme/isprime  0x536              B [.] ispri=
me
            |
            ---isprime
               main
               __libc_start_main
               _start



#
# (For a higher level overview, try: perf report --sort comm,dso)
#
