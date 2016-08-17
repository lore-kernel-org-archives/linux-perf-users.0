From: Benjamin King <benjaminking@web.de>
Subject: Failure to parallelize
Date: Wed, 17 Aug 2016 15:55:28 +0200
Message-ID: <20160817135528.GA13652@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:49223 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbcHQNzc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 17 Aug 2016 09:55:32 -0400
Received: from localhost ([77.23.102.81]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MQeqb-1bk4zd3Oft-00U38N for
 <linux-perf-users@vger.kernel.org>; Wed, 17 Aug 2016 15:55:28 +0200
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I recently had a performance regression where the program mysteriously became
20% slower without executing more instructions or burning more cycles. It
turned out that a loop lost an openmp pragma and wasn't parallel afterwards.
This was a tiny part of a larger diff and missed during code review.

I was struggeling to find this with perf. "perf record" did show me mostly
identical values. "perf stat" also was mostly the same, including "task-clock
(msec)".

Eventually, I had noticed the lower number for "CPUs utilized", but I had no
idea, where in my code this would be.

In the following sample code, I am always getting ~10% reported by perf for
the function bar(), regardless of whether I am calling it in parallel or not.

Is there some way to make the difference more visible in perf? 

Cheers,
  Benjamin King

----- 8< -----
// gcc -g -fopenmp noppy.c -o noppy; perf record ./noppy; perf report
#include <omp.h>
#include <stdio.h>

void foo() // ~90% of "work" is done here
{
  int i;
  for ( i = 0; i < 900; ++i )
    asm("nop;nop;nop;nop;");
}

void bar() // ~10% of "work" is done here
{
  int i;
  for ( i = 0; i < 100; ++i )
    asm("nop;nop;nop;nop;");
}

int main()
{
  int s;
  for ( s = 0; s < 1; ++s )
  {
    long i;
#pragma omp parallel for
    for ( i = 0; i < 1000000; ++i )
      foo();
    // Whoops, I accidently deleted the following pragma
//#pragma omp parallel for
    for ( i = 0; i < 1000000; ++i )
      bar();
  }
}
----- 8< -----
