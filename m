From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Tracing sched_switch events for client application when process
 is switched back in
Date: Mon, 10 Oct 2016 21:36:55 -0300
Message-ID: <20161011003655.GP4809@kernel.org>
References: <10618911.8qrkJBTkNF@milian-kdab2>
 <20161006162125.GB4809@kernel.org>
 <4514930.f3mZKdtDhX@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753376AbcJKOeH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Oct 2016 10:34:07 -0400
Content-Disposition: inline
In-Reply-To: <4514930.f3mZKdtDhX@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Em Thu, Oct 06, 2016 at 06:38:28PM +0200, Milian Wolff escreveu:
> On Thursday, October 6, 2016 1:21:25 PM CEST Arnaldo Carvalho de Melo wrote:
> > Em Thu, Oct 06, 2016 at 05:52:51PM +0200, Milian Wolff escreveu:
> > > Hey all,
> > > 
> > > when you have an application like this:
> > > 
> > > ~~~~~~
> > > #include <unistd.h>
> > > 
> > > int main()
> > > {
> > > 
> > >    for (int i = 0; i < 100; ++i) {
> > >    
> > >        usleep(10);
> > >    
> > >    }
> > > 
> > > }
> > > ~~~~~~
> > > 
> > > Then record sched:sched_switch events for it:
> > > 
> > > ~~~~~~
> > > $ perf record -e sched:sched_switch ./a.out
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.031 MB perf.data (100 samples) ]
> > > ~~~~~~
> > > 
> > > Note how it's only 100 samples, instead of 200 for both, the switch-out
> > > and
> > > switch-in events. Apparently we only get the switch-out events:
> > > 
> > > ~~~~~
> > > $ perf script -F trace | uniq -c
> > > 
> > >      99 a.out:3994 [120] S ==> swapper/7:0 [120]
> > >      
> > >       1 a.out:3994 [120] S ==> swapper/7:0 [1
> > > 
> > > ~~~~~
> > > 
> > > Doing a global trace, or using LTTNG, we also see the switch-in events:
> > > 
> > > ~~~~~
> > > $ perf record -e sched:sched_switch -a ./a.out
> > > $ perf script -F trace | grep a.out | sort | uniq -c
> > > 
> > >     100 a.out:11570 [120] S ==> swapper/4:0 [120]
> > >     
> > >       1 a.out:11570 [120] x ==> swapper/4:0 [120]
> > >     
> > >     100 swapper/4:0 [120] R ==> a.out:11570 [120]
> > > 
> > > ~~~~~
> > > 
> > > Is there any way I can get both sched switch events, i.e. not only the one
> > > with prev_tid=$client_tid, but also the one with next_tid=$client_tid? One
> > > way
> > > that seems to work is the following:
> > Have you considered using PERF_RECORD_SWITCH?
> > 
> > [acme@jouet linux]$ perf record --switch-events sleep 1
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.020 MB perf.data (7 samples) ]
> > [acme@jouet linux]$ perf script --show-switch-events
> >   sleep 20679  5578.172409:          1 cycles:u:      7fb4e5a51c80
> > _start+0x0 (/usr/lib64/ld-2.23.so) sleep 20679  5578.172411:          1
> > cycles:u:      7fb4e5a51c80 _start+0x0 (/usr/lib64/ld-2.23.so) sleep 20679 
> > 5578.172412:         12 cycles:u:      7fb4e5a51c80 _start+0x0
> > (/usr/lib64/ld-2.23.so) sleep 20679  5578.172413:        397 cycles:u:     
> > 7fb4e5a51c80 _start+0x0 (/usr/lib64/ld-2.23.so) sleep 20679  5578.172414:  
> >    13936 cycles:u:  ffffffffb77ee7a0 page_fault+0x0
> > (/usr/lib/debug/lib/modules/4.7.5-200.fc24.x86_64/vmlinux) sleep 20679 
> > 5578.172431:     330542 cycles:u:      7fb4e5a5301f dl_main+0x6cf
> > (/usr/lib64/ld-2.23.so) sleep 20679  5578.172700: PERF_RECORD_SWITCH OUT
> >   sleep 20679  5579.172821: PERF_RECORD_SWITCH IN
> >   sleep 20679  5579.172838:     802931 cycles:u:      7fb4e5a6122e
> > _dl_fini+0x8e (/usr/lib64/ld-2.23.so) [acme@jouet linux]$
> 
> First time I read about it, and the documentation is scarce, to not say non-
> existing. It seems to record cycles for the switch events. But why does it 



> only find 7, whereas tracing sched_switch finds all 100 that actually take 
> place?

This is looking only for the sched switches for the monitored workload,
which in this case is 'sleep 1', this wasn't a system wide session.

add -a and you'll get those other switches, if I got what you described.
 
> The reason why I want sched_switch is that I want to build a "better" sleep 
> time profiler. The existing script [1] is cumbersome to use, and only shows 
> parts of what is going on:
> 
> - only looks at sched_stat_sleep, ignores sched_stat_iowait or sched_stat_wait
> - requires one to enable the sched_stat tracepoints in newer kernels 
>   $ echo 1 | sudo tee /proc/sys/kernel/sched_schedstats
> - as a user-space developer, I actually care about the time between getting 
> switched out and getting switched in, so using that in perf would actually 
> give me the duration I got switched out
> 
> If I could do something like this:
> 
> $ perf record -e cycles:ppp,sched:sched_switch <my app>
> 
> And have both switch-in and switch-out traced, than a GUI could visualize this 
> together and show me both, CPU hotspots as well as sleep/io/blocked time where 
> I got switched out
> 
> [1] https://perf.wiki.kernel.org/index.php/Tutorial#Profiling_sleep_times
> 
> -- 
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
