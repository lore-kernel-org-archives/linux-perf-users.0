From: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: --mmap-pages option seemingly has no effect to help with LOST
 samples
Date: Fri, 22 Jun 2012 10:59:31 -0500
Message-ID: <4FE49663.7000908@us.ibm.com>
References: <4FD7ACB9.70205@us.ibm.com> <4FD7AF0C.1030300@gmail.com> <4FD8B32C.60608@us.ibm.com> <4FD8B641.9040907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:41718 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670Ab2FVP7j (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 22 Jun 2012 11:59:39 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <maynardj@us.ibm.com>;
	Fri, 22 Jun 2012 11:59:38 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B375A38C808C
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Jun 2012 11:59:33 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5MFxXTt185562
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Jun 2012 11:59:33 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5MFxXaB016681
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Jun 2012 11:59:33 -0400
In-Reply-To: <4FD8B641.9040907@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 06/13/2012 10:48 AM, David Ahern wrote:
> On 6/13/12 9:35 AM, Maynard Johnson wrote:
>>> I think you are killing your box with NMIs based on the low period (-c
>>> arg). I suggest increasing the period.
>> OK, I'll buy that, as I think I only saw these messages when using the
>> highest sampling rate. But at the mid-level sampling rate that I used
>> (which would have been 100,000), where I still see a lot of LOST samples
>> . . . any thoughts on why bumping up the --mmap-pages didn't help?
> 
> The default is 128 pages = 512k of RAM per CPU. If you look at pmap $(pidof perf) you will see a 516k map per CPU. My primary box is a dual socket, quad core with HT, so I have 16 of these:
> 00007f7655186000    516K rw-s-    [ anon ]
> 
> If you bump the number of pages, those segments should increase. e.g., using -m 512 I get 16 segments of 2M:
> 00007f804a9dd000   2052K rw-s-    [ anon ]
> 
> This is using latest perf source, not RHEL6, but I do not recall many changes for the mapped pages.
Hi, David,
Finally getting back to this issue after some distractions.  Thanks for the pointing out my error regarding the default number of mmap pages.  Switching back and forth between my laptop and an IBM POWER7 in testing perf, I got the value of '8' from the POWER7 and incorrectly assumed it would be the same on all architectures.  Since the default number of mmap pages for my laptop is, as you said, 128, I re-ran the testcase as follows (using a lower sampling rate to avoid the:

   perf record -e cycles -e instructions -c 500000 -m 256 ./memcpyt 500000000
and it failed with:
   Fatal: failed to mmap with 22 (Invalid argument)

Evidently, you need to either set /proc/sys/kernel/perf_event_paranoid to '-1' or run perf as root to ask for more than the default number of mmap pages.  Running the test as root *without* the "-m" option, I verified that I still see the "LOST" samples message (again, perhaps about half the time).  So then I tried different values for '-m', up to 512, and still occasionally (but not as often, I think) see the "LOST" samples.

The 'perf record' tool can easily handle a sampling rate of one sample per 100,000 cycles *or* instructions (i.e., one at a time), so I would have expected it to be handle one sample per 500,000 events when profiling on both events?  Am I missing something?

Another related issue is the number of samples being recorded varies wildly when profiling on multiple events.  For example, profiling on just cycles with --count=500000, 'perf report -n' reports ~87k samples.  And profiling on just instructions with the same rate, I get ~102k.  When profiling with both events, I get cycles/instruction sample counts ranging from a low of 6k/7k to a high of 88k/102k.  Usually, I get counts around 12k/15k.  The higher the count seen with 'perf report' (i.e., the closer to true values), the more likely that perf record fails with the "LOST" samples message.

Thanks in advance for any help.

-Maynard

> 
>>
>> By the way, in digging into question #2 below, it appears kernel
>> throttling *did* occur (seeing this in the raw report data), but
>> probably not until after some samples were already lost.
> 
> Throttling is based on interrupt rate, so it will be independent of lost samples. Default throttling kicks in at 100k:
> 
> $ cat /proc/sys/kernel/perf_event_max_sample_rate
> 100000
> 
> For my box that is too high - I've seen the PMU reset because of too many nmis.
> 
> David
> 
