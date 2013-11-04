From: David Ahern <dsahern@gmail.com>
Subject: Re: Information regarding the perf tool
Date: Mon, 04 Nov 2013 10:53:21 -0700
Message-ID: <5277DF11.7080601@gmail.com>
References: <5266A57F.2000201@bsc.es> <87y55krw6f.fsf@tassilo.jf.intel.com> <52727B0C.5040402@bsc.es> <527287A7.3050908@gmail.com> <5272922E.20007@bsc.es> <52729FE5.3090109@gmail.com> <5277D8E1.9000009@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:51023 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab3KDRxY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 4 Nov 2013 12:53:24 -0500
Received: by mail-pd0-f175.google.com with SMTP id g10so6957016pdj.34
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2013 09:53:24 -0800 (PST)
In-Reply-To: <5277D8E1.9000009@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>
Cc: linux-perf-users@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>

[added Pawel, author of the patches]

On 11/4/13, 10:26 AM, Harald Servat wrote:
> On 31/10/13 19:22, David Ahern wrote:
>> On 10/31/13, 11:23 AM, Harald Servat wrote:
>>> Which is the relation between perf_clock() (or local_clock()) and
>>> clock_gettime (CLOCK_MONOTONIC, ). Are they the same? If not, is there a
>>> way to correlate them? Or alternatively, is it possible to call
>>> local_clock() from the userland?
>>
>> We still do not have a means of correlating perf_clock to time-of-day,
>> monotonic or any other clock source. Still trying.
>>
>> Pawell Moll has a couple of patches posted -- one uses an ioctl to get
>> perf_clock timestamps the other makes perf_clock accessible through
>> clock_gettime. See attached.
>>
>> David
>
> Hello,
>
>    thank you David! Those patches are great! I decided to access perf
> clock through clock_gettime because I'm more used to this call since I
> used it before.

My long term preference as well with a hook into vdso page.

>    I understand that the patches are a bit hardcoded, right? I tried to
> #include "/usr/include/linux/time.h" after #include <time.h> but they
> seem to conflict. If I just extract the interesting bits (#define
> CLOCK_PERF) it seems to work. Is there a cleaner way to use this right now?

They should just work. I seem to have misplaced my test case; I don't 
recall having problems with it.

>
>    JFTR, I have written a very small app that demonstrate the usage of
> this clock_gettime + perf (attached). It is very interesting to see that
> the difference between the monotonic and the perf clock is rather
> similar. However, as time goes by, at least in my machine, perf clock
> seems to advance at a faster pace than the monotonic clock.

that's why we would like to get a perf_clock/trace_clock time source 
exported by the kernel.

David
