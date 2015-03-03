From: Yuanfang Chen <cyfmxc@gmail.com>
Subject: address output in 'perf script' does not work for addr2line
Date: Tue, 3 Mar 2015 11:07:18 -0500
Message-ID: <CAJh9x3pz1aLQP_vvfN_Y_BwF4ekcU1mqvZFJz7x7X6QqLkK1jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:45440 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755713AbbCCQHU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Mar 2015 11:07:20 -0500
Received: by wesp10 with SMTP id p10so38619677wes.12
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2015 08:07:19 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I'm using perf 3.19.0 on Archlinux

[arch@t440s-arch ~/Trash]$ uname -a
Linux t440s-arch 3.18.6-1-ARCH #1 SMP PREEMPT Sat Feb 7 08:44:05 CET
2015 x86_64 GNU/Linux

Recently after updating perf package, I found the 'ip' in 'perf
script' like below is shorter than before. Also feeding that address
(like 57e below) to addr2line does not output filename:lineno
information anymore.  How do I fix this issue? Is this a bug?

a.out 26620 [000] 314643.350007:    6825289 cycles:
                     57e main (/home/arch/Trash/a.out)
                   20800 __libc_start_main (/usr/lib/libc-2.21.so)
        13d6258d4c544155 [unknown] ([unknown])

thank you,
Yuanfang
