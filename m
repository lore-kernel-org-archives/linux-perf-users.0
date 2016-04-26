From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Missing stack symbols with perf_event's perf report, despite
 -fno-omit-frame-pointer compilation
Date: Mon, 25 Apr 2016 22:03:58 -0300
Message-ID: <20160426010358.GD16708@kernel.org>
References: <loom.20160419T015612-712@post.gmane.org>
 <57157965.4020506@gmail.com>
 <1704384.MQzPvE4Oa5@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52881 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbcDZBEH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 25 Apr 2016 21:04:07 -0400
Content-Disposition: inline
In-Reply-To: <1704384.MQzPvE4Oa5@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: David Ahern <dsahern@gmail.com>, Mark Davis <markdavisinboston@gmail.com>, linux-perf-users@vger.kernel.org

Em Mon, Apr 25, 2016 at 11:01:54AM +0200, Milian Wolff escreveu:
> On Monday, April 18, 2016 6:18:45 PM CEST David Ahern wrote:
> > On 4/18/16 6:07 PM, Mark Davis wrote:
> > >     Auto-detecting system features:
> > >      ...                     backtrace: [ on  ]
> > >      ...                         dwarf: [ OFF ]
> > >      ...                fortify-source: [ on  ]
> > >      ...                         glibc: [ on  ]
> > >      ...                          gtk2: [ on  ]
> > >      ...                  gtk2-infobar: [ on  ]
> > >      ...                      libaudit: [ OFF ]
> > >      ...                        libbfd: [ OFF ]
> > >      ...                        libelf: [ OFF ]

> > Install those 2 development packages.
=20
> And if that is still not helping, you may run into the case where the=
 samples=20
> are recorded in a library (like libstdc++, libc,...) which was provid=
ed by=20
> your distribution without frame pointers. In such a case, the backtra=
ce will=20
> still be broken.
=20
> If you want to use frame pointers, and operate on user space code, my=
 advise=20
> is to recompile all dependencies with frame pointers. On Yocto/Gentoo=
 that is=20
> easily doable, elsewhere you'll have a hard time and waste a ton of t=
ime.
> I suggest you simply use Dwarf unwinding.

Please try '--call-graph lbr' to check if your hardware has LBR, will b=
e
much cheaper than callchains.

=46or instance:

[acme@jouet linux]$ perf record --call-graph lbr usleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.018 MB perf.data (9 samples) ]
[acme@jouet linux]$ perf evlist -v
cycles:ppp: size: 112, { sample_period, sample_freq }: 4000,
sample_type: IP|TID|TIME|CALLCHAIN|PERIOD|BRANCH_STACK, disabled: 1,
inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1,
precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec:
1, branch_sample_type: USER|CALL_STACK|NO_FLAGS|NO_CYCLES
[acme@jouet linux]$

-   59.69%  usleep   [kernel]  [k] vma_interval_tree_insert
    =E2=86=92vma_interval_tree_insert  [kernel]
     vma_adjust                [kernel]
     __split_vma.isra.31       [kernel]
     split_vma                 [kernel]
     mprotect_fixup            [kernel]
     sys_mprotect              [kernel]
     entry_SYSCALL_64_fastpath [kernel]
     mprotect                  ld-2.22.so
     _dl_relocate_object       ld-2.22.so
     memcpy@GLIBC_2.2.5        libc-2.22.so
     _dl_relocate_object       ld-2.22.so
     __gettimeofday            libc-2.22.so
     _dl_vdso_vsym             libc-2.22.so
     _dl_lookup_symbol_x       ld-2.22.so=20

This was done on a Broadwell system (ThinkPad t450s).

I now need to continue investigation why this doesn't seem to work from
tracepoints...

- Arnaldo
