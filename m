From: Benjamin King <benjaminking@web.de>
Subject: Re: Failure to parallelize
Date: Thu, 18 Aug 2016 20:50:48 +0200
Message-ID: <20160818185048.GA2242@localhost>
References: <20160817135528.GA13652@localhost>
 <21975224.qTVBMiFlMz@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:59265 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754510AbcHSBxB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Aug 2016 21:53:01 -0400
Content-Disposition: inline
In-Reply-To: <21975224.qTVBMiFlMz@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, Aug 18, 2016 at 11:56:45AM +0200, Milian Wolff wrote:
>> Is there some way to make the difference [between threaded and non
>> threaded code] more visible in perf?
>
>I think that won't even be detected by perf's way of doing sleep time
>profiling, e.g.:
>
>https://github.com/milianw/shell-helpers/blob/master/perf-sleep-record
>
>Because there is no contention - it's simply Amdahl's law that's tripping you
>up. Having a look at the CPU utilization is very important when writing
>(supposedly) parallel code.

Yes, I should have looked at CPU utilization more closely right away. But
even now that I know this, it seems awkward that I am unable to demonstrate
with my trusty old profiler which part of my program just took longer in terms
of wall clock time. I don't have VTune at my disposal, but it could be that I
am using the wrong tool for the job.

Still, I dabbled a bit with "perf record -s ...; perf report -T", but I find the
output a little confusing. To wit:

-----8< noppy1.c
#include <omp.h>
void foo() { int i; for ( i = 0; i < 900; ++i ) asm("nop;nop;nop;nop;"); }
void bar() { int i; for ( i = 0; i < 100; ++i ) asm("nop;nop;nop;nop;"); }
int main() {
  long i;
#pragma omp parallel for
  for ( i = 0; i < 1000000; ++i ) foo();
  for ( i = 0; i < 1000000; ++i ) bar();
}
-----8< noppy2.c
#include <omp.h>
void foo() { int i; for ( i = 0; i < 900; ++i ) asm("nop;nop;nop;nop;"); }
void bar() { int i; for ( i = 0; i < 100; ++i ) asm("nop;nop;nop;nop;"); }
int main() {
  long i;
#pragma omp parallel for
  for ( i = 0; i < 1000000; ++i ) foo();
#pragma omp parallel for
  for ( i = 0; i < 1000000; ++i ) bar();
}
-----8< gcc noppy1.c -g -fopenmp -o noppy1;perf record -s ./noppy1;perf report -T
    92.15%  noppy1   noppy1              [.] foo
     7.08%  noppy1   noppy1              [.] bar
    ...
#  PID   TID  cycles:pp   cycles:pp  cycles:pp
  3853  3856          0  1492046281          0
  3853  3854          0    57482400          0
  3853  3855          0           0          0
-----8< gcc noppy2.c -g -fopenmp -o noppy2;perf record -s ./noppy2;perf report -T
    88.97%  noppy2   noppy2            [.] foo                   
    10.27%  noppy2   noppy2            [.] bar                   
    ...
#  PID   TID        cycles:pp  cycles:pp  cycles:pp
  3869  3870                0   56778112          0
  3869  3871       2180814133   57030240          0
  3869  3872  139866901929176          0          0
-----8<


So, there is some difference in cycles:pp but I totally don't get what this
table in the end of perf report -T is supposed to mean. The large value for TID
3872 looks broken.


I had more luck with 'perf report --per-thread':

-----8< perf record --per-thread ./noppy1;perf report
  68.90%  noppy1   noppy1            [.] foo
  29.79%  noppy1   noppy1            [.] bar
...
-----8< perf record --per-thread ./noppy2;perf report
  87.18%  noppy2   noppy2            [.] foo
  10.35%  noppy2   noppy2            [.] bar
...
-----8<

So, noppy1 looks different and I can see that the effort between foo and bar
shifted. Adding a '--show-nr-samples' or a '--show-total-period' is then
telling me that the effort for foo() stays the same, but bar() gets more
expensive.

Unfortunately, I still do not understand what exactly '--per-thread' is doing.
The manpage is a little brief and I did not look in the code yet.
But it's a start!

Cheers,
  Benjamin
