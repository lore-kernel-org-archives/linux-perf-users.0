From: Milian Wolff <mail@milianw.de>
Subject: perf trace: file names, strace groups
Date: Wed, 15 Jul 2015 15:02:21 +0200
Message-ID: <2853551.Qtj9hFrTSc@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:41891 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbbGONCY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jul 2015 09:02:24 -0400
Received: from milian-kdab2.localnet (unknown [185.28.184.2])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id 2EECF6282A78
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2015 15:02:22 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Perf Users <linux-perf-users@vger.kernel.org>

Hey all,

are there any plans to improve the `perf trace` utility to make it a drop-in 
replacement for `strace`? `man strace` says "A traced process runs slowly.", 
and if I remember correctly, Brendan Gregg said this is due to strace using 
the PTrace subsystem and not the faster alternative that `perf trace` is based 
upon. But, currently, `perf trace` is far from capable of replacing `strace` 
for my common usecases:

$ touch test

$ strace -e file cat test
execve("/usr/bin/cat", ["cat", "file"], [/* 90 vars */]) = 0
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
open("/usr/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
open("/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
open("file", O_RDONLY)                  = 3
+++ exited with 0 +++

$ perf trace -e file cat file
perf: Segmentation fault
Obtained 10 stack frames.
perf(dump_stack+0x32) [0x4d8652]
perf(sighandler_dump_stack+0x29) [0x4d86e9]
/usr/lib/libc.so.6(+0x335b0) [0x7f15bba065b0]
perf(perf_evlist__mmap_read+0x35) [0x487445]
perf(cmd_trace+0xe4b) [0x4582cb]
perf() [0x47b593]
perf(main+0x622) [0x427fe2]
/usr/lib/libc.so.6(__libc_start_main+0xf0) [0x7f15bb9f3790]
perf(_start+0x29) [0x428109]
[(nil)]

Two things to notice: perf version 4.1.0, and every trace call ends with the 
above crash. But the file event group is not known to perf list, and thus 
nothing gets traced. I'd expect an error message instead, i.e.:

$ strace -e asdf cat file
strace: invalid system call 'asdf'

Now, if I instead do this:

$ perf trace -e open cat file
     0.070 ( 0.003 ms): cat/8663 open(filename: 0x7f04b76a4a05, flags: CLOEXEC                         
) = 3
     0.092 ( 0.003 ms): cat/8663 open(filename: 0x7f04b78acef0, flags: CLOEXEC                         
) = 3
     0.245 ( 0.005 ms): cat/8663 open(filename: 0x7f04b7453310, flags: CLOEXEC                         
) = 3
     0.277 ( 0.002 ms): cat/8663 open(filename: 0x7ffdba0902f8, mode: 131072                           
) = 3

This is nice, esp. the time measurements. But why are the file names not 
printed as strings? The pointer address does not help one at all. Also, the 
O_RDONLY flag is not properly handled (compare to the strace output above).

I'd love to see someone working on this gem, as it really promises to be a 
good replacement for strace.

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
