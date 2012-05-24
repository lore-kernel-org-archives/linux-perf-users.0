From: Namhyung Kim <namhyung.kim@lge.com>
Subject: Re: Perf 2.6.32-220.el6.x86_64 problem when recording 2 counters
Date: Thu, 24 May 2012 09:44:55 +0900
Message-ID: <87bole1k6w.fsf@sejong.aot.lge.com>
References: <14480_1337789222_4FBD0B26_14480_3035_2_932AC94CE5A51243A6F091BAFB3EE3E0028AB9506D@THSONEA01CMS01P.one.grp>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:49587 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab2EXAqx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 May 2012 20:46:53 -0400
In-Reply-To: <14480_1337789222_4FBD0B26_14480_3035_2_932AC94CE5A51243A6F091BAFB3EE3E0028AB9506D@THSONEA01CMS01P.one.grp>
	(HUMMEL Michel's message of "Wed, 23 May 2012 18:06:59 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: HUMMEL Michel <michel.hummel@thalesgroup.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi,

On Wed, 23 May 2012 18:06:59 +0200, HUMMEL Michel wrote:
> Hello,
> I am testing the perf command of my new centos 6.2 server, and I don't understand something.
> My Conf :
> ################################################################
> $ grep name /proc/cpuinfo
> model name      : Intel(R) Xeon(R) CPU           E5620  @ 2.40GHz
> $ uname -a
> Linux xxxxxxxx 2.6.32-220.el6.x86_64 #1 SMP Tue Dec 6 19:48:22 GMT 2011 x86_64 x86_64 x86_64 GNU/Linux
> $ perf --version
> perf version 2.6.32-220.el6.x86_64.debug
> $ perf test
>  1: vmlinux symtab matches kallsyms: FAILED!
>
>  2: detect open syscall event: Ok
>  3: detect open syscall event on all cpus: Ok
>  4: read samples using the mmap interface: Ok
> ################################################################
>
> I wrote a simple test case which is calling two functions.
> The first one "good_perfo"  does the same as the second "bad_perfo" but more efficiently (lesser cache miss ...).
>
> Gprof profile confirms this :
> ################################################################
> $ gprof -p ./test_perfo
> Flat profile:
>
> Each sample counts as 0.01 seconds.
>   %   cumulative   self              self     total
>  time   seconds   seconds    calls   s/call   s/call  name
>  76.14     38.75    38.75        1    38.75    38.75  bad_perfo
>  23.70     50.81    12.06        1    12.06    12.06  good_perfo
> ################################################################
>
> but perf don't want to give me the good answer when I asking for two events : cycles and instructions  :
> ################################################################
> $ perf record -e  cycles,instructions  -o perf.data.cycles.instructions ./test_perfo
> $ perf report -i perf.data.cycles.instructions --stdio
> # Events: 5K cycles
> #

One thing I noticed is the number of events in this run is much smaller
than others (5K to 51K). Probably it can be a reason of the inaccuracy,
but I'm not sure. Maybe increasing sampling freq (-F) or adding the 'u'
modifier on events can help.

Thanks,
Namhyung


> # Overhead  Command      Shared Object                      Symbol
> # ........  .......  .................  ..........................
> #
>     99.35%  test_perfo  test_perfo         [.] good_perfo
>      0.14%  test_perfo  [kernel.kallsyms]  [k] clear_page_c
>      0.08%  test_perfo  [kernel.kallsyms]  [k] page_fault
>      0.05%  test_perfo  [kernel.kallsyms]  [k] hrtimer_interrupt
>
>
> # Events: 5K instructions
> #
> # Overhead  Command      Shared Object                     Symbol
> # ........  .......  .................  .........................
> #
>     99.93%  test_perfo  test_perfo         [.] good_perfo
>      0.02%  test_perfo  [kernel.kallsyms]  [k] __run_hrtimer
>      0.02%  test_perfo  [kernel.kallsyms]  [k] inode_has_perm
>      0.02%  test_perfo  [kernel.kallsyms]  [k] update_wall_time
>
> ################################################################
>
> The bad_perfo function is not appearing in the profile (and I am sure that it should !) 
> Now if I do 2 separate records, one for the cycles and one for the instructions, the profile seems to be good :
>
> ################################################################
> $ perf record -e  cycles  -o perf.data.cycles ./test_perfo
> $ perf report -i perf.data.cycles --stdio
> # Events: 51K cycles
> #
> # Overhead  Command      Shared Object                      Symbol
> # ........  .......  .................  ..........................
> #
>     76.20%  test_perfo  test_perfo         [.] bad_perfo
>     23.36%  test_perfo  test_perfo         [.] good_perfo
>      0.03%  test_perfo  [kernel.kallsyms]  [k] apic_timer_interrupt
>      0.02%  test_perfo  [kernel.kallsyms]  [k] do_softirq
>      0.02%  test_perfo  [kernel.kallsyms]  [k] avc_has_perm_noaudit
>
> $ perf record -e  instructions  -o perf.data.instructions ./test_perfo
> $ perf report -i perf.data.instructions --stdio
> # Events: 45K instructions
> #
> # Overhead  Command      Shared Object                    Symbol
> # ........  .......  .................  ........................
> #
>     49.95%  test_perfo  test_perfo         [.] bad_perfo
>     49.94%  test_perfo  test_perfo         [.] good_perfo
>      0.01%  test_perfo  [kernel.kallsyms]  [k] raise_softirq
>      0.01%  test_perfo  [kernel.kallsyms]  [k] hrtimer_interrupt
>      0.01%  test_perfo  [kernel.kallsyms]  [k] kmem_cache_alloc_notrace
> ################################################################
>
> Is I missed something with the perf command or this is a bug ?
>
>
> I found a Quick&Dirty solution :
> Using the -D ( Collect data without buffering ) option give me the good profile :
> ################################################################
> $ perf record -D -e  cycles,instructions  -o perf.data.cycles.instructions ./test_perfo
> $ perf report -i perf.data.cycles.instructions --stdio
> # Events: 51K cycles
> #
> # Overhead  Command      Shared Object                      Symbol
> # ........  .......  .................  ..........................
> #
>     76.20%  test_perfo  test_perfo         [.] bad_perfo
>     22.99%  test_perfo  test_perfo         [.] good_perfo
>      0.10%  test_perfo  [kernel.kallsyms]  [k] _spin_lock
>      0.05%  test_perfo  [kernel.kallsyms]  [k] hrtimer_interrupt
>   
> :
> # Events: 51K cycles
> #
> # Overhead  Command      Shared Object                      Symbol
> # ........  .......  .................  ..........................
> #
>     76.20%  test_perfo  test_perfo         [.] bad_perfo
>     22.99%  test_perfo  test_perfo         [.] good_perfo
>      0.10%  test_perfo  [kernel.kallsyms]  [k] _spin_lock
>      0.05%  test_perfo  [kernel.kallsyms]  [k] hrtimer_interrupt 
> ################################################################
>
> Thank for any help,
> Michel Hummel
