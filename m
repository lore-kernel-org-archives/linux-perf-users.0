From: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: --mmap-pages option seemingly has no effect to help with LOST
 samples
Date: Wed, 13 Jun 2012 10:35:08 -0500
Message-ID: <4FD8B32C.60608@us.ibm.com>
References: <4FD7ACB9.70205@us.ibm.com> <4FD7AF0C.1030300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:42582 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453Ab2FMPfZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 13 Jun 2012 11:35:25 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <maynardj@us.ibm.com>;
	Wed, 13 Jun 2012 11:35:24 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7ACED38C806A
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Jun 2012 11:35:20 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5DFZIK1213704
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Jun 2012 11:35:19 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5DFZIFJ013874
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Jun 2012 09:35:18 -0600
In-Reply-To: <4FD7AF0C.1030300@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 06/12/2012 04:05 PM, David Ahern wrote:
> On 6/12/12 2:55 PM, Maynard Johnson wrote:
>> Hi,
>> On my Intel Core 2 Duo with RHEL 6.2 with the watchdog timer 
>> disabled, I'm using perf to collect a CPI profile as follows:
>>
>>      perf record -e cycles 100000 -e instructions -c 50000 ./memcpyt 
>> 500000000
>
> Confused by that command line '-e cycles 100000' is not valid. Missing 
> a -c? If so, -c 100000 followed by -c 50000 means the interval is 
> 50000 for both events; the second one overrides the first.
>
Yeah, right, typo.  And I guess I forgot that the "-c" option is for 
*all* events, not per-event.  Thanks for the reminder.
>
>> where 'memcpyt' is a test program that simply does a LOT of memcpy's 
>> -- takes about 20 seconds of real time to complete.
>>
>>     This fails roughly half the time with:
>>
>>     [ perf record: Woken up 11 times to write data ]
>>     [ perf record: Captured and wrote 4.540 MB perf.data (~198348 
>> samples) ]
>>     Processed 0 events and LOST 872662!
>>
>>     Check IO/CPU overload!
>
>
>>
>> I've seen some postings on this list in the past about the LOST 
>> events and the suggestion to try the --mmap-pages option.  I see from 
>> the perf source that the default number of pages to use for mmap'ing 
>> the kernel's perf_events data is '8'.  I tried going up to 64 pages 
>> with little noticeable effect.  Additionally, sometimes when I get 
>> the LOST samples message, I'll also see the following junk pop up in 
>> all of my terminal sessions:
>>
>>     Message from syslogd@oc3431575272 at Jun 12 15:21:52 ...
>>      kernel:Uhhuh. NMI received for unknown reason 00 on CPU 1.
>>
>>     Message from syslogd@oc3431575272 at Jun 12 15:21:52 ...
>>      kernel:Do you have a strange power saving mode enabled?
>>
>>     Message from syslogd@oc3431575272 at Jun 12 15:21:52 ...
>>      kernel:Dazed and confused, but trying to continue
>
> I think you are killing your box with NMIs based on the low period (-c 
> arg). I suggest increasing the period.
OK, I'll buy that, as I think I only saw these messages when using the 
highest sampling rate.  But at the mid-level sampling rate that I used 
(which would have been 100,000), where I still see a lot of LOST samples 
. . . any thoughts on why bumping up the --mmap-pages didn't help?

By the way, in digging into question #2 below, it appears kernel 
throttling *did* occur (seeing this in the raw report data), but 
probably not until after some samples were already lost.

Thanks.
-Maynard
>
>
> David
>
>
>>
>> (Not sure, but these syslogd messages may have occurred only when I 
>> was running as root.)
>>
>> I tried decreasing my sampling rate for both events by half (200000 
>> for cycles and 100000 for instructions), but still got LOST samples, 
>> with or without the "--mmap-pages=64" option.  Decreasing sampling 
>> rate by half again finally did get rid of the LOST samples.
>>
>> Questions:
>> 1) Why doesn't the number of mmap pages seem to have the expected 
>> beneficial effect?
>> 2) Why doesn't the kernel's throttle capabilities prevent the LOST 
>> events in the first place?
>> 3) What's up with the weird syslogd messages?  heh.
>>
>> I realize none of these may be perf userspace issues, but may be 
>> perf_events kernel issues instead.  But I thought I'd start out here 
>> on this list instead of wading neck-deep into LKML land.
>>
>> Thanks.
>> -Maynard
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
