From: David Ahern <dsahern@gmail.com>
Subject: Re: --mmap-pages option seemingly has no effect to help with LOST
 samples
Date: Wed, 13 Jun 2012 09:48:17 -0600
Message-ID: <4FD8B641.9040907@gmail.com>
References: <4FD7ACB9.70205@us.ibm.com> <4FD7AF0C.1030300@gmail.com> <4FD8B32C.60608@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38675 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab2FMPsV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 13 Jun 2012 11:48:21 -0400
Received: by dady13 with SMTP id y13so1221671dad.19
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Jun 2012 08:48:20 -0700 (PDT)
In-Reply-To: <4FD8B32C.60608@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Maynard Johnson <maynardj@us.ibm.com>
Cc: linux-perf-users@vger.kernel.org

On 6/13/12 9:35 AM, Maynard Johnson wrote:
>> I think you are killing your box with NMIs based on the low period (-c
>> arg). I suggest increasing the period.
> OK, I'll buy that, as I think I only saw these messages when using the
> highest sampling rate. But at the mid-level sampling rate that I used
> (which would have been 100,000), where I still see a lot of LOST samples
> . . . any thoughts on why bumping up the --mmap-pages didn't help?

The default is 128 pages = 512k of RAM per CPU. If you look at pmap 
$(pidof perf) you will see a 516k map per CPU. My primary box is a dual 
socket, quad core with HT, so I have 16 of these:
00007f7655186000    516K rw-s-    [ anon ]

If you bump the number of pages, those segments should increase. e.g., 
using -m 512 I get 16 segments of 2M:
00007f804a9dd000   2052K rw-s-    [ anon ]

This is using latest perf source, not RHEL6, but I do not recall many 
changes for the mapped pages.

>
> By the way, in digging into question #2 below, it appears kernel
> throttling *did* occur (seeing this in the raw report data), but
> probably not until after some samples were already lost.

Throttling is based on interrupt rate, so it will be independent of lost 
samples. Default throttling kicks in at 100k:

$ cat /proc/sys/kernel/perf_event_max_sample_rate
100000

For my box that is too high - I've seen the PMU reset because of too 
many nmis.

David
