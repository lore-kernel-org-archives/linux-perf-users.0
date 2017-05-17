From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] perf report: fix off-by-one for non-activation frames
Date: Wed, 17 May 2017 14:12:21 +0900
Message-ID: <20170517051221.GD32691@danjae.aot.lge.com>
References: <20170516085951.4056-1-milian.wolff@kdab.com>
 <20170516143829.GA12886@danjae.aot.lge.com>
 <3048427.F5Pep8qUR7@agathebauer>
 <3393633.IVaOaPmc4x@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36504 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdEQFMg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 May 2017 01:12:36 -0400
Content-Disposition: inline
In-Reply-To: <3393633.IVaOaPmc4x@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Tue, May 16, 2017 at 06:26:47PM +0200, Milian Wolff wrote:
> On Dienstag, 16. Mai 2017 18:17:26 CEST Milian Wolff wrote:
> > On Dienstag, 16. Mai 2017 16:38:29 CEST Namhyung Kim wrote:
> > > On Tue, May 16, 2017 at 10:59:51AM +0200, Milian Wolff wrote:
> > > > As the documentation for dwfl_frame_pc says, frames that
> > > > are no activation frames need to have their program counter
> > > > decremented by one to properly find the function of the caller.
> > > > 
> > > > This fixes many cases where perf report currently attributes
> > > > the cost to the next line. I.e. I have code like this:
> > > > 
> > > > ~~~~~~~~~~~~~~~
> > > > 
> > > >   #include <thread>
> > > >   #include <chrono>
> > > >   
> > > >   using namespace std;
> > > >   
> > > >   int main()
> > > >   {
> > > >   
> > > >     this_thread::sleep_for(chrono::milliseconds(1000));
> > > >     this_thread::sleep_for(chrono::milliseconds(100));
> > > >     this_thread::sleep_for(chrono::milliseconds(10));
> > > >     
> > > >     return 0;
> > > >   
> > > >   }
> > > > 
> > > > ~~~~~~~~~~~~~~~
> > > 
> > > It'd be nice if the test program has a signal frame for verification.
> > 
> > I have pretty much zero experience about signals. Would it be enough to add
> > a signal handler for, say, SIGUSR1 to my test application and then trigger
> > a sleep when that signal is delivered? If that should be enough, I'll write
> > and test it out.
> 
> ~~~~~~~~~~~~~~~
> #include <thread>
> #include <chrono>
> #include <signal.h>
> 
> using namespace std;
> 
> volatile bool run_loop = true;
> 
> void my_handler(int signum)
> {
>     this_thread::sleep_for(chrono::milliseconds(1000));
>     this_thread::sleep_for(chrono::milliseconds(100));
>     this_thread::sleep_for(chrono::milliseconds(10));
>     run_loop = false;
> }
> 
> int main()
> {
>     signal(SIGUSR1, my_handler);
> 
>     while (run_loop) {}
> 
>     return 0;
> }
> ~~~~~~~~~~~~~~~
> 
> This does not properly unwind neither before nor after this patch. I only ever 
> get:
> 
>    100.00%  core.c:0
>             |
>             ---__schedule core.c:0
>                schedule
>                do_nanosleep hrtimer.c:0
>                hrtimer_nanosleep
>                sys_nanosleep
>                entry_SYSCALL_64_fastpath .tmp_entry_64.o:0
>                __nanosleep_nocancel .:0
>                std::this_thread::sleep_for<long, std::ratio<1l, 1000l> > 
> thread:323
> 
> So... should this work? Please tell me how to test this properly.

How did you send the SIGUSR1 to the process?

Anyway it does nothing to do with inlining, right?  I just wrote a
test code below to burn a cpu with or without a signal frame.

  $ nl -ba frame-addr.c
     1	#include <stdio.h>
     2	#include <stdlib.h>
     3	#include <signal.h>
     4	
     5	#define __noinline  __attribute__((noinline))
     6	
     7	__noinline void bar(void)
     8	{
     9	  volatile long cnt = 0;
    10	
    11	  for (cnt = 0; cnt < 100000000; cnt++);
    12	}
    13	
    14	__noinline void foo(void)
    15	{
    16	  bar();
    17	}
    18	
    19	void sig_handler(int sig)
    20	{
    21	  foo();
    22	}
    23	
    24	int main(void)
    25	{
    26	  signal(SIGUSR1, sig_handler);
    27	  raise(SIGUSR1);
    28	
    29	  foo();
    30	  return 0;
    31	}

  $ gcc -O2 -g -fno-optimize-sibling-calls -o frame-addr frame-addr.c

  $ perf record --call-graph dwarf ./frame-addr

  $ perf report -q -g srcline | head -15
      99.88%  frame-addr  frame-addr        [.] bar
              |
              ---bar frame-addr.c:11
                 foo frame-addr.c:16
                 |          
                 |--51.12%--main frame-addr.c:29
                 |          __libc_start_main
                 |          _start
                 |          
                  --48.76%--sig_handler frame-addr.c:21
                            0x33a8f
                            raise .:0
                            main frame-addr.c:29       <--- bad
                            __libc_start_main
                            _start

Note that 'raise' was called at line 27.  It seems that simply
checking current frame fixes it.

Thanks,
Namhyung
