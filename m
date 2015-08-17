From: Andi Kleen <andi@firstfloor.org>
Subject: Announcing simple-pt -- a simple Processor Trace implementation for
 Linux
Date: Mon, 17 Aug 2015 06:31:30 +0200
Message-ID: <20150817043130.GI1747@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:48298 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbbHQEbd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Aug 2015 00:31:33 -0400
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org


Modern Intel Core CPUs (5th and 6th generation) have a Intel Processor =
Trace (PT) feature
to trace branch execution with low overhead. This is useful for perform=
ance analysis and debugging.

simple-pt is a simple standalone driver and decoder tool to implement P=
T on Linux.

Starting with Linux 4.1 Linux has an integrated PT implementation in pe=
rf
(see https://lwn.net/Articles/648154/).
simple-pt is an alternative implementation. It has many disadvantages o=
ver the perf PT
implementation, such as:
- needs to run as root
- no long term tracing or sampling with interrupts
- no support for interactive debugging (use gdb 7.10 on perf for that)
- no support for histograms
- somewhat experimental
- not as well supported as perf

On the positive side simple-pt is:
- simple
- standalone. No kernel changes needed. Could be ported to older kernel=
s or other operating systems
- easy to modify and experiment with
- more ftrace like decoding tool
- support for kprobes based triggers
- modular =E2=80=9Cunix style=E2=80=9D design with simple tools that do=
 only one thing each
- BSD licensed

Example output:


        % sptcmd  -c tcall taskset -c 0 ./tcall
        cpu   0 offset 1027688,  1003 KB, writing to ptout.0
        ...
        Wrote sideband to ptout.sideband
        % sptdecode --sideband ptout.sideband --pt ptout.0 | less
        TIME      DELTA  INSNs   OPERATION
        frequency 32
        0        [+0]     [+   1] _dl_aux_init+436
                          [+   6] __libc_start_main+455 -> _dl_discover=
_osversion
        ...
                          [+  13] __libc_start_main+446 -> main
                          [+   9]     main+22 -> f1
                          [+   4]             f1+9 -> f2
                          [+   2]             f1+19 -> f2
                          [+   5]     main+22 -> f1
                          [+   4]             f1+9 -> f2
                          [+   2]             f1+19 -> f2
                          [+   5]     main+22 -> f1
        ...

Available from https://github.com/andikleen/simple-pt

--=20
ak@linux.intel.com -- Speaking for myself only.
