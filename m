From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Announcing simple-pt -- a simple Processor Trace implementation
 for Linux
Date: Mon, 17 Aug 2015 15:09:33 +0200
Message-ID: <CAFTL4hwfk4ezi=MVpvURmW=hKdXX6mJQYabwisHejd77CW3Sjg@mail.gmail.com>
References: <20150817043130.GI1747@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37473 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036AbbHQNJe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Aug 2015 09:09:34 -0400
In-Reply-To: <20150817043130.GI1747@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: LKML <linux-kernel@vger.kernel.org>, perf group <linux-perf-users@vger.kernel.org>

2015-08-17 6:31 GMT+02:00 Andi Kleen <andi@firstfloor.org>:
>
> Modern Intel Core CPUs (5th and 6th generation) have a Intel Processo=
r Trace (PT) feature
> to trace branch execution with low overhead. This is useful for perfo=
rmance analysis and debugging.
>
> simple-pt is a simple standalone driver and decoder tool to implement=
 PT on Linux.
>
> Starting with Linux 4.1 Linux has an integrated PT implementation in =
perf
> (see https://lwn.net/Articles/648154/).
> simple-pt is an alternative implementation. It has many disadvantages=
 over the perf PT
> implementation, such as:
> - needs to run as root
> - no long term tracing or sampling with interrupts
> - no support for interactive debugging (use gdb 7.10 on perf for that=
)
> - no support for histograms
> - somewhat experimental
> - not as well supported as perf
>
> On the positive side simple-pt is:
> - simple
> - standalone. No kernel changes needed. Could be ported to older kern=
els or other operating systems
> - easy to modify and experiment with
> - more ftrace like decoding tool
> - support for kprobes based triggers
> - modular =E2=80=9Cunix style=E2=80=9D design with simple tools that =
do only one thing each
> - BSD licensed
>
> Example output:
>
>
>         % sptcmd  -c tcall taskset -c 0 ./tcall
>         cpu   0 offset 1027688,  1003 KB, writing to ptout.0
>         ...
>         Wrote sideband to ptout.sideband
>         % sptdecode --sideband ptout.sideband --pt ptout.0 | less
>         TIME      DELTA  INSNs   OPERATION
>         frequency 32
>         0        [+0]     [+   1] _dl_aux_init+436
>                           [+   6] __libc_start_main+455 -> _dl_discov=
er_osversion
>         ...
>                           [+  13] __libc_start_main+446 -> main
>                           [+   9]     main+22 -> f1
>                           [+   4]             f1+9 -> f2
>                           [+   2]             f1+19 -> f2
>                           [+   5]     main+22 -> f1
>                           [+   4]             f1+9 -> f2
>                           [+   2]             f1+19 -> f2
>                           [+   5]     main+22 -> f1

Nice. So I guess +x is the address offset. How hard would it be to
translate to file lines?

Thanks.

>         ...
>
> Available from https://github.com/andikleen/simple-pt
>
> --
> ak@linux.intel.com -- Speaking for myself only.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
