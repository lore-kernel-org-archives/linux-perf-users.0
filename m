From: David Ahern <dsahern@gmail.com>
Subject: Re: perf trace timestamps
Date: Wed, 21 Nov 2012 08:54:54 -0700
Message-ID: <50ACF94E.5010508@gmail.com>
References: <loom.20121116T140608-755@post.gmane.org> <50A6502C.9030900@gmail.com> <loom.20121120T122816-305@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44834 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab2KUPzE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Nov 2012 10:55:04 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so2169448pad.19
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Nov 2012 07:55:03 -0800 (PST)
In-Reply-To: <loom.20121120T122816-305@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Saumil Merchant <msaumil@gmail.com>, john.stultz@linaro.org, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>

On 11/20/12 4:33 AM, Saumil Merchant wrote:
> David Ahern <dsahern <at> gmail.com> writes:
>>>
>>> My original impression was that this timestamp (eg, 1746678.550895) would
>>> with time reported clk_gettime(MONOTONIC,...) function, but it does not. My
>>> function above prints out timestamps from clk_gettime(MONOTONIC,..)
>>> and there is a delta of >15 mins.
>>>
>>> Here is the printout on console:
>>> CLKTIME (MONOTONIC):  1748132.102228068
>>
>> At one time many, many releases ago perf timestamps did align with the
>> monotonic clock. I have tried (unsuccessfully) to get an option into
>> perf to correlate perf events with time-of-day stamps.
>>
>
>
> Since clk_gettime and perf timestamps do not align, I tried synchronizing
> timestamps at start my code. I used a syscall that I can track in the perf
> trace.  I can then normalize perf trace output timestamps using the delta
> between perf timestamp and clk_gettime timestamp for the syscall.  I chose to
> use nanosleep for this.  While doing this I realized that this normalizing
> delta between the perf and clk_gettime timestamps linearly increases with
> time.  Here is a simple C code that I used to check this behavior:
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <time.h>
>
> int ITERATIONS=600;
> struct timespec sleepy, t1, t2;
>
> int main(int argc, char **argv) {
>      int i;
>
>      sleepy.tv_sec=0;
>      sleepy.tv_nsec=1000000;
>
>      for(i=0; i<ITERATIONS; i++) {
>          clock_gettime(CLOCK_MONOTONIC,&t1);
>          nanosleep(&sleepy,NULL);
>          clock_gettime(CLOCK_MONOTONIC,&t2);
>          printf("%d.%09d, %d.%09d\n",
>                 t1.tv_sec,t1.tv_nsec,t2.tv_sec,t2.tv_nsec);
>      }
>
>      return(0);
> }
>
> I correlated entry (t1) clk_gettime timestamps with entry nanosleep timestamps
> from perf.  Same with he exit timestamps.
> i.e. two arrays of "entry_clk_gettime - entry_perf" and
> "exit_clk_gettime - exit_perf".
>
> On plotting these two arrays against the iterations I got a plot which is
> straight line linearly increasing with slope 0.00000095.  The difference
> between the first and the last sample of these arrays is almost 0.6 msecs over
> just 600 iterations.  I was expecting variations when I plotted these two
> arrays, but was expecting random variations and not a linearly increasing
> straight line.  This tells me that perf is inflating the timestamps over time
> with probably a constant value.
>
> Is this an expected behavior or a bug?

Perhaps John or Thomas can explain what is going on. cc'ed. Added 
Stephane as well given his recent thread on the topic.

David

>
> I didn't want to bombard the list with a big spreadsheet file detailing the
> experiment outcomes, but I can email it separately to whoever wants to take a
> look at it.
>
>
>
>>>
>>> This delta has been varying from 5 mins to 15+ mins.  My objective is to
>>> correlate events in a kernel trace with the execution of our user program.
>>> understanding is that both perf and clk_gettime functions on newer x86
>>> use TSC as the clock source and hence I was confused why they do not align.
>>>
>>> Can someone please help?
>>
>> See John's explanations in this thread:
>> https://lkml.org/lkml/2012/10/16/173
>>
>> David
>>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
