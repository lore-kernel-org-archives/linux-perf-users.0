From: Saumil Merchant <msaumil@gmail.com>
Subject: Re: perf trace timestamps
Date: Tue, 20 Nov 2012 11:33:56 +0000 (UTC)
Message-ID: <loom.20121120T122816-305@post.gmane.org>
References: <loom.20121116T140608-755@post.gmane.org> <50A6502C.9030900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60833 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab2KTLeN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Nov 2012 06:34:13 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1Tam5t-0006HM-AL
	for linux-perf-users@vger.kernel.org; Tue, 20 Nov 2012 12:34:21 +0100
Received: from 122.248.161.59 ([122.248.161.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Nov 2012 12:34:21 +0100
Received: from msaumil by 122.248.161.59 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Nov 2012 12:34:21 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

David Ahern <dsahern <at> gmail.com> writes:

> 
> >
> > My original impression was that this timestamp (eg, 1746678.550895) would
> > with time reported clk_gettime(MONOTONIC,...) function, but it does not. My
> > function above prints out timestamps from clk_gettime(MONOTONIC,..)  
> > and there is a delta of >15 mins.
> >
> > Here is the printout on console:
> > CLKTIME (MONOTONIC):  1748132.102228068
> 
> At one time many, many releases ago perf timestamps did align with the 
> monotonic clock. I have tried (unsuccessfully) to get an option into 
> perf to correlate perf events with time-of-day stamps.
> 


Since clk_gettime and perf timestamps do not align, I tried synchronizing 
timestamps at start my code. I used a syscall that I can track in the perf
trace.  I can then normalize perf trace output timestamps using the delta 
between perf timestamp and clk_gettime timestamp for the syscall.  I chose to 
use nanosleep for this.  While doing this I realized that this normalizing 
delta between the perf and clk_gettime timestamps linearly increases with 
time.  Here is a simple C code that I used to check this behavior:

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int ITERATIONS=600;
struct timespec sleepy, t1, t2;

int main(int argc, char **argv) {
    int i;

    sleepy.tv_sec=0;
    sleepy.tv_nsec=1000000;

    for(i=0; i<ITERATIONS; i++) {
        clock_gettime(CLOCK_MONOTONIC,&t1);
        nanosleep(&sleepy,NULL);
        clock_gettime(CLOCK_MONOTONIC,&t2);
        printf("%d.%09d, %d.%09d\n",
               t1.tv_sec,t1.tv_nsec,t2.tv_sec,t2.tv_nsec);
    }

    return(0);
}

I correlated entry (t1) clk_gettime timestamps with entry nanosleep timestamps
from perf.  Same with he exit timestamps.  
i.e. two arrays of "entry_clk_gettime - entry_perf" and 
"exit_clk_gettime - exit_perf". 

On plotting these two arrays against the iterations I got a plot which is
straight line linearly increasing with slope 0.00000095.  The difference 
between the first and the last sample of these arrays is almost 0.6 msecs over
just 600 iterations.  I was expecting variations when I plotted these two
arrays, but was expecting random variations and not a linearly increasing 
straight line.  This tells me that perf is inflating the timestamps over time 
with probably a constant value. 

Is this an expected behavior or a bug?

I didn't want to bombard the list with a big spreadsheet file detailing the
experiment outcomes, but I can email it separately to whoever wants to take a
look at it.



> >
> > This delta has been varying from 5 mins to 15+ mins.  My objective is to
> > correlate events in a kernel trace with the execution of our user program.  
> > understanding is that both perf and clk_gettime functions on newer x86 
> > use TSC as the clock source and hence I was confused why they do not align.
> >
> > Can someone please help?
> 
> See John's explanations in this thread:
> https://lkml.org/lkml/2012/10/16/173
> 
> David
> 
