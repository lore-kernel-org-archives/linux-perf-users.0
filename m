From: John Stultz <john.stultz@linaro.org>
Subject: Re: perf trace timestamps
Date: Mon, 26 Nov 2012 17:37:05 -0800
Message-ID: <50B41941.9030803@linaro.org>
References: <loom.20121116T140608-755@post.gmane.org> <50A6502C.9030900@gmail.com> <loom.20121120T122816-305@post.gmane.org> <50ACF94E.5010508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:37447 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680Ab2K0BhM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 26 Nov 2012 20:37:12 -0500
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <john.stultz@linaro.org>;
	Mon, 26 Nov 2012 18:37:11 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 450BA3E4003C
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Nov 2012 18:37:06 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id qAR1b7NR256010
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Nov 2012 18:37:07 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id qAR1b7go010537
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Nov 2012 18:37:07 -0700
In-Reply-To: <50ACF94E.5010508@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Saumil Merchant <msaumil@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>

On 11/21/2012 07:54 AM, David Ahern wrote:
> On 11/20/12 4:33 AM, Saumil Merchant wrote:
>> David Ahern <dsahern <at> gmail.com> writes:
>>>>
>>>> My original impression was that this timestamp (eg, 1746678.550895) 
>>>> would
>>>> with time reported clk_gettime(MONOTONIC,...) function, but it does 
>>>> not. My
>>>> function above prints out timestamps from clk_gettime(MONOTONIC,..)
>>>> and there is a delta of >15 mins.
>>>>
>>>> Here is the printout on console:
>>>> CLKTIME (MONOTONIC):  1748132.102228068
>>>
>>> At one time many, many releases ago perf timestamps did align with the
>>> monotonic clock. I have tried (unsuccessfully) to get an option into
>>> perf to correlate perf events with time-of-day stamps.
>>>
>>
>>
>> Since clk_gettime and perf timestamps do not align, I tried 
>> synchronizing
>> timestamps at start my code. I used a syscall that I can track in the 
>> perf
>> trace.  I can then normalize perf trace output timestamps using the 
>> delta
>> between perf timestamp and clk_gettime timestamp for the syscall.  I 
>> chose to
>> use nanosleep for this.  While doing this I realized that this 
>> normalizing
>> delta between the perf and clk_gettime timestamps linearly increases 
>> with
>> time.  Here is a simple C code that I used to check this behavior:
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <time.h>
>>
>> int ITERATIONS=600;
>> struct timespec sleepy, t1, t2;
>>
>> int main(int argc, char **argv) {
>>      int i;
>>
>>      sleepy.tv_sec=0;
>>      sleepy.tv_nsec=1000000;
>>
>>      for(i=0; i<ITERATIONS; i++) {
>>          clock_gettime(CLOCK_MONOTONIC,&t1);
>>          nanosleep(&sleepy,NULL);
>>          clock_gettime(CLOCK_MONOTONIC,&t2);
>>          printf("%d.%09d, %d.%09d\n",
>>                 t1.tv_sec,t1.tv_nsec,t2.tv_sec,t2.tv_nsec);
>>      }
>>
>>      return(0);
>> }
>>
>> I correlated entry (t1) clk_gettime timestamps with entry nanosleep 
>> timestamps
>> from perf.  Same with he exit timestamps.
>> i.e. two arrays of "entry_clk_gettime - entry_perf" and
>> "exit_clk_gettime - exit_perf".
>>
>> On plotting these two arrays against the iterations I got a plot 
>> which is
>> straight line linearly increasing with slope 0.00000095.  The difference
>> between the first and the last sample of these arrays is almost 0.6 
>> msecs over
>> just 600 iterations.  I was expecting variations when I plotted these 
>> two
>> arrays, but was expecting random variations and not a linearly 
>> increasing
>> straight line.  This tells me that perf is inflating the timestamps 
>> over time
>> with probably a constant value.
>>
>> Is this an expected behavior or a bug?
>
> Perhaps John or Thomas can explain what is going on. cc'ed. Added 
> Stephane as well given his recent thread on the topic.

I suspect this is expected behavior, as to my understanding perf uses 
sched_clock, not CLOCK_MONOTONIC for its timestamps.

CLOCK_MONOTONIC is frequency corrected for accuracy by NTP (thus after 
NTP converges, one second is really one second long), sched_clock has no 
such correction.

So if you either disable NTP or compare with CLOCK_MONOTONIC_RAW (which 
also has no frequency correction, so one second may not be actually one 
second, given any initial calibration error or hardware drift), I 
suspect you'll not see the linear slope.

Another possible source for this slope/drift could be if the clocksource 
hardware being used for time (CLOCK_MONOTONIC) is different the the 
hardware used for sched_clock.  For instance, on x86 sched_clock is 
usually based on the TSC (which is calibrated at boot, which introduces 
accuracy errors). The TSC may not be stable on the cpu, so it could halt 
or may not be consistent between cores, so we may use something like the 
HPET or ACPI PM hardware (which we are given the freq by the hardware) 
for the timekeeping clocksource. Thus there may be either calibration or 
hardware drift (or both) between the different clocks.

There was some discussion recently on lkml about either exposing the 
perf clock to userland, or possibly reworking perf so the timestamps is 
exports are based on CLOCK_MONOTONIC instead, but that hasn't come to 
any resolution yet.

thanks
-john
