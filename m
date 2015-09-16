From: =?iso-2022-jp?B?GyRCSj8+PjJtTCYbKEIgLyBISVJBTUFUVRskQiEkGyhCTUFTQU1J?=
	<masami.hiramatsu.pt@hitachi.com>
Subject: RE: permissions required for user defined dynamic tracepoints
Date: Wed, 16 Sep 2015 02:05:03 +0000
Message-ID: <50399556C9727B4D88A595C8584AAB3752536726@GSjpTKYDCembx32.service.hitachi.net>
References: <2165133.E7ilaynrlj@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mailx.hitachi.co.jp ([133.145.228.49]:39174 "EHLO
	mailx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbbIPCjS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 15 Sep 2015 22:39:18 -0400
Received: from mail7.hitachi.co.jp (mail7.hitachi.co.jp [133.145.228.42])
	by mailx.hitachi.co.jp (Postfix) with ESMTP id 38451177033A
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2015 11:05:09 +0900 (JST)
In-Reply-To: <2165133.E7ilaynrlj@milian-kdab2>
Content-Language: ja-JP
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: 'Milian Wolff' <milian.wolff@kdab.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

From: linux-perf-users-owner@vger.kernel.org [mailto:linux-perf-users-owner@vger.kernel.org] On Behalf Of Milian Wolff
>
>Hey all,
>
>most "advanced" perf tools can be used as a normal non-root user after
>executing the following commands:
>
>sudo mount -o remount,mode=755 /sys/kernel/debug/
>sudo mount -o remount,mode=755 /sys/kernel/debug/tracing
>echo "-1" | sudo tee /proc/sys/kernel/perf_event_paranoid
>
>The exception here are dynamic tracepoints:
>
>perf probe -x /lib64/libc.so.6 malloc
>Failed to open uprobe_events: Permission denied
>  Error: Failed to add events.

Yeah, since dynamic event interface is under the control of ftrace,
which is related but not the part of perf.

>
>Strace shows that it fails to write to /sys/kernel/debug/tracing/
>uprobe_events. I could workaround this issue with a
>
>sudo chmod a+w -R /sys/kernel/debug/tracing/uprobe_events
>
>Is that "OK", or a very bad idea? Is there a better alternative?

I'd rather like setuid for perf, because uprobe_events can break userspace
completely without checking instruction sequence correctly. "chmod a+w"
for uprobe_events means everyone can put a breakpoint (means modify the
instruction sequence) on anywhere in userspace including fundamental
library code like glibc. That should not be allowed for safety.

> Furthermore,
>I notice that I cannot delete the trace points:
>
>perf probe -l
>probe_libc:malloc    (on __malloc in /usr/lib/libc-2.22.so)
>debug perf probe -d probe_libc:malloc
>Program received signal SIGSEGV, Segmentation fault.
>0x00007ffff5f73160 in feof () from /usr/lib/libc.so.6
>(gdb) bt
>#0  0x00007ffff5f73160 in feof () from /usr/lib/libc.so.6
>#1  0x000000000050c9d3 in probe_file__get_rawlist (fd=<optimized out>) at
>util/probe-file.c:144
>#2  0x000000000050cab1 in __probe_file__get_namelist (fd=<optimized out>,
>include_group=include_group@entry=true)
>    at util/probe-file.c:173
>#3  0x000000000050cd90 in probe_file__get_events (fd=<optimized out>,
>filter=filter@entry=0x1745b50,
>    plist=plist@entry=0x17457b0) at util/probe-file.c:274
>#4  0x000000000046184f in perf_del_probe_events (filter=0x1745b50) at builtin-
>probe.c:386
>#5  __cmd_probe (argc=<optimized out>, argv=argv@entry=0x7fffffffcb90,
>prefix=<optimized out>) at builtin-probe.c:596
>#6  0x0000000000461c8c in cmd_probe (argc=<optimized out>,
>argv=0x7fffffffcb90, prefix=<optimized out>)
>    at builtin-probe.c:627
>#7  0x0000000000486923 in run_builtin (p=p@entry=0x6a9cc0 <commands+384>,
>argc=argc@entry=3, argv=argv@entry=0x7fffffffcb90)
>    at perf.c:371
>#8  0x000000000042cce2 in handle_internal_command (argv=0x7fffffffcb90,
>argc=3) at perf.c:431
>#9  run_argv (argv=0x7fffffffc920, argcp=0x7fffffffc92c) at perf.c:475
>#10 main (argc=3, argv=0x7fffffffcb90) at perf.c:592
>
>Any idea what might be going on here? I get the same crash when trying this as
>root.

OK, I'll check that.

Thanks for reporting!!

>
>Bye
>--
>Milian Wolff | milian.wolff@kdab.com | Software Engineer
>KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
>Tel: +49-30-521325470
>KDAB - The Qt Experts
