From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Adding a recording delay interferes with symbols/call-stack
Date: Tue, 31 Oct 2017 11:25:37 -0300
Message-ID: <20171031142537.GT7045@kernel.org>
References: <CABYXEksdehm6S9-WGO6MV1wQaWHCsk-Ofp-sDaxY+qwQSNPp8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752191AbdJaOZk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Oct 2017 10:25:40 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D149D21869
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Oct 2017 14:25:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CABYXEksdehm6S9-WGO6MV1wQaWHCsk-Ofp-sDaxY+qwQSNPp8Q@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Bram Stolk <b.stolk@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Mon, Oct 30, 2017 at 01:25:08PM -0700, Bram Stolk escreveu:
> If I record with callstacks like this:
> 
> $ perf record --freq 2000 --call-graph dwarf ./bench
> 
> then it works just fine: I see callstacks, and symbols in the report.
> 
> If I delay the recording by 1 second with the --delay flag, like this:
> 
> $ perf record --delay=1000 --freq 2000 --call-graph dwarf ./bench
> 
> Then I lose all callstack information, and even all symbol information
> on my program in the report.
> 
> Is this a known issue, that --delay interferes with symbol resolution?
> 
> Thanks!
> 
>   Bram
> 
> PS: I am on 64b Ubuntu, and perf version 4.4.87

Works for me: :-)

[root@jouet ~]# perf record --delay=1000 --freq 2000 --call-graph dwarf sleep 5
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.050 MB perf.data (4 samples) ]
[root@jouet ~]# perf script
perf 30567 248464.097254:          1 cycles:ppp: 
                  3b233a __perf_event_task_sched_in (/lib/modules/4.14.0-rc3+/build/vmlinux)
                  2be207 finish_task_switch (/lib/modules/4.14.0-rc3+/build/vmlinux)
                  a44d21 __sched_text_start (/lib/modules/4.14.0-rc3+/build/vmlinux)
                  a45368 schedule (/lib/modules/4.14.0-rc3+/build/vmlinux)
                  a49679 do_nanosleep (/lib/modules/4.14.0-rc3+/build/vmlinux)
                  30c816 hrtimer_nanosleep (/lib/modules/4.14.0-rc3+/build/vmlinux)
                  30c96e sys_nanosleep (/lib/modules/4.14.0-rc3+/build/vmlinux)
                  203a41 do_syscall_64 (/lib/modules/4.14.0-rc3+/build/vmlinux)
                  a4ad67 return_from_SYSCALL_64 (/lib/modules/4.14.0-rc3+/build/vmlinux)

perf 30567 248464.097288:          1 cycles:ppp: 
                  20d1d0 intel_bts_enable_local (/lib/modules/4.14.0-rc3+/build/vmlinux)

perf 30567 248464.097302:          3 cycles:ppp: 
                  223111 native_sched_clock (/lib/modules/4.14.0-rc3+/build/vmlinux)

perf 30567 248464.097317:         16 cycles:ppp: 
                  223111 native_sched_clock (/lib/modules/4.14.0-rc3+/build/vmlinux)

[root@jouet ~]# perf -v
perf version 4.14.rc6.gd688d0
[root@jouet ~]# uname -a
Linux jouet 4.14.0-rc3+ #1 SMP Fri Oct 13 12:21:12 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
[root@jouet ~]#
