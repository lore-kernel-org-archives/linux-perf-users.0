From: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: --mmap-pages option seemingly has no effect to help with LOST
 samples
Date: Fri, 22 Jun 2012 14:20:41 -0500
Message-ID: <4FE4C589.5080802@us.ibm.com>
References: <4FD7ACB9.70205@us.ibm.com> <4FD7AF0C.1030300@gmail.com> <4FD8B32C.60608@us.ibm.com> <4FD8B641.9040907@gmail.com> <4FE49663.7000908@us.ibm.com> <4FE49A6F.7020503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:40772 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759Ab2FVTUr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 22 Jun 2012 15:20:47 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <maynardj@us.ibm.com>;
	Fri, 22 Jun 2012 15:20:46 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 427206E8049
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Jun 2012 15:20:44 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5MJKhad30933024
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Jun 2012 15:20:43 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5MJKhrF005917
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Jun 2012 16:20:43 -0300
In-Reply-To: <4FE49A6F.7020503@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org, suka@us.ibm.com

On 06/22/2012 11:16 AM, David Ahern wrote:
> On 6/22/12 9:59 AM, Maynard Johnson wrote:
>> Hi, David,
>> Finally getting back to this issue after some distractions.  Thanks for the pointing out my error regarding the default number of mmap pages.  Switching back and forth between my laptop and an IBM POWER7 in testing perf, I got the value of '8' from the POWER7 and incorrectly assumed it would be the same on all architectures.  Since the default number of mmap pages for my laptop is, as you said, 128, I re-ran the testcase as follows (using a lower sampling rate to avoid the:
>>
>>     perf record -e cycles -e instructions -c 500000 -m 256 ./memcpyt 500000000
>> and it failed with:
>>     Fatal: failed to mmap with 22 (Invalid argument)
>>
>> Evidently, you need to either set /proc/sys/kernel/perf_event_paranoid to '-1' or run perf as root to ask for more than the default number of mmap pages.  Running the test as root *without* the "-m" option, I verified that I still see the "LOST" samples message (again, perhaps about half the time).  So then I tried different values for '-m', up to 512, and still occasionally (but not as often, I think) see the "LOST" samples.
> 
> Right, I keep forgetting the perf_event_paranoid. I have a development box with that set to -1.
> 
> Try adding the -r option to perf-record. It's quite possible that you are generating events so fast that perf is not getting scheduled often enough. Perhaps it also be getting blocked on disk I/O writing the events to file. Try putting the file into a ramfs or tmpfs (without swapping) mount.
Hi, Dave,
Unfortunately, neither '-r 99' nor ramfs helped.
> 
>>
>> The 'perf record' tool can easily handle a sampling rate of one sample per 100,000 cycles *or* instructions (i.e., one at a time), so I would have expected it to be handle one sample per 500,000 events when profiling on both events?  Am I missing something?
> 
> Have you tried a newer OS? Perhaps a bug/limitation in the RHEL6 implementation.
> 
>>
>> Another related issue is the number of samples being recorded varies wildly when profiling on multiple events.  For example, profiling on just cycles with --count=500000, 'perf report -n' reports ~87k samples.  And profiling on just instructions with the same rate, I get ~102k.  When profiling with both events, I get cycles/instruction sample counts ranging from a low of 6k/7k to a high of 88k/102k.  Usually, I get counts around 12k/15k.  The higher the count seen with 'perf report' (i.e., the closer to true values), the more likely that perf record fails with the "LOST" samples message.
> 
> What type of CPU? And can you send me the command so I can try it on my end? static binary for x86 is fine if you can't/don't want to share the source. I have a Core2 laptop and servers with an E5540 (Nehalem) and E5620 (Westmere) - all of which have a variety of kernel versions available.

I was seeing this on both my Intel Core 2 Duo and an IBM POWER7 server, both running RHEL 6.2.  Also tried on another POWER7 running RHEL 6.3 beta, and got the same results.  I found another POWER server that had RHEL 6.2 but was temporarily booted on a 3.5 kernel and ran the test there -- the counts were good there. :-)  Just to be sure, I rebooted that system to the stock RHEL 6.2 kernel and reproduced the problem.  So it seems there's an upstream fix for this.  Can someone help me find the commit?

Thanks.
-Maynard
> 
> David
> 
