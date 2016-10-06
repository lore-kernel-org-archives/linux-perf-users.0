From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Tracing sched_switch events for client application when process
 is switched back in
Date: Thu, 6 Oct 2016 13:21:25 -0300
Message-ID: <20161006162125.GB4809@kernel.org>
References: <10618911.8qrkJBTkNF@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942180AbcJFQVh (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2016 12:21:37 -0400
Content-Disposition: inline
In-Reply-To: <10618911.8qrkJBTkNF@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Em Thu, Oct 06, 2016 at 05:52:51PM +0200, Milian Wolff escreveu:
> Hey all,
> 
> when you have an application like this:
> 
> ~~~~~~
> #include <unistd.h>
> 
> int main()
> {
>    for (int i = 0; i < 100; ++i) {
>        usleep(10);
>    }
> }
> ~~~~~~
> 
> Then record sched:sched_switch events for it:
> 
> ~~~~~~
> $ perf record -e sched:sched_switch ./a.out 
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.031 MB perf.data (100 samples) ]
> ~~~~~~
> 
> Note how it's only 100 samples, instead of 200 for both, the switch-out and 
> switch-in events. Apparently we only get the switch-out events:
> 
> ~~~~~
> $ perf script -F trace | uniq -c
>      99 a.out:3994 [120] S ==> swapper/7:0 [120]
>       1 a.out:3994 [120] S ==> swapper/7:0 [1
> ~~~~~
> 
> Doing a global trace, or using LTTNG, we also see the switch-in events:
> 
> ~~~~~
> $ perf record -e sched:sched_switch -a ./a.out 
> $ perf script -F trace | grep a.out | sort | uniq -c
>     100 a.out:11570 [120] S ==> swapper/4:0 [120]
>       1 a.out:11570 [120] x ==> swapper/4:0 [120]
>     100 swapper/4:0 [120] R ==> a.out:11570 [120]
> ~~~~~
> 
> Is there any way I can get both sched switch events, i.e. not only the one 
> with prev_tid=$client_tid, but also the one with next_tid=$client_tid? One way 
> that seems to work is the following:

Have you considered using PERF_RECORD_SWITCH?

[acme@jouet linux]$ perf record --switch-events sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.020 MB perf.data (7 samples) ]
[acme@jouet linux]$ perf script --show-switch-events
  sleep 20679  5578.172409:          1 cycles:u:      7fb4e5a51c80 _start+0x0 (/usr/lib64/ld-2.23.so)
  sleep 20679  5578.172411:          1 cycles:u:      7fb4e5a51c80 _start+0x0 (/usr/lib64/ld-2.23.so)
  sleep 20679  5578.172412:         12 cycles:u:      7fb4e5a51c80 _start+0x0 (/usr/lib64/ld-2.23.so)
  sleep 20679  5578.172413:        397 cycles:u:      7fb4e5a51c80 _start+0x0 (/usr/lib64/ld-2.23.so)
  sleep 20679  5578.172414:      13936 cycles:u:  ffffffffb77ee7a0 page_fault+0x0 (/usr/lib/debug/lib/modules/4.7.5-200.fc24.x86_64/vmlinux)
  sleep 20679  5578.172431:     330542 cycles:u:      7fb4e5a5301f dl_main+0x6cf (/usr/lib64/ld-2.23.so)
  sleep 20679  5578.172700: PERF_RECORD_SWITCH OUT
  sleep 20679  5579.172821: PERF_RECORD_SWITCH IN 
  sleep 20679  5579.172838:     802931 cycles:u:      7fb4e5a6122e _dl_fini+0x8e (/usr/lib64/ld-2.23.so)
[acme@jouet linux]$ 
 
> ~~~~~
> $ perf record -e sched:sched_switch --filter 'prev_comm=="a.out" || 
> next_comm=="a.out"' -a ./a.out 
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.499 MB perf.data (201 samples) ]
> $ perf script -F trace | grep a.out | sort | uniq -c
>       1 akonadi_notes_a:2160 [120] S ==> a.out:14710 [120]
>       3 a.out:14710 [120] S ==> swapper/2:0 [120]
>      97 a.out:14710 [120] S ==> swapper/6:0 [120]
>       1 a.out:14710 [120] x ==> swapper/6:0 [120]
>       1 ksoftirqd/6:47 [120] S ==> a.out:14710 [120]
>       1 mysqld:14707 [120] S ==> a.out:14710 [120]
>       1 QDBusConnection:2140 [120] S ==> a.out:14710 [120]
>       1 QDBusConnection:2213 [120] S ==> a.out:14710 [120]
>       2 swapper/2:0 [120] R ==> a.out:14710 [120]
>      93 swapper/6:0 [120] R ==> a.out:14710 [120]
> ~~~~~
> 
> The above workaround will not work for more complex applications, with 
> secondary threads that can have different comm names. So:
> 
> Where is the "default" filtering done, which simply drops all events from 
> sources that do not match the pid of the created process? I assume this 
> happens in kernel space? Could it be adapted to also include switch_switch 
> events when next_tid belongs to the pid we use for filtering?
> 
> Thanks
> -- 
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
