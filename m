From: David Ahern <dsahern@gmail.com>
Subject: Re: timing information with perf
Date: Mon, 16 Nov 2015 20:57:34 -0700
Message-ID: <564AA5AE.1020303@gmail.com>
References: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com>
 <y0my4dxx1f4.fsf@fche.csb> <20151117001233.GC11993@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:36352 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbbKQD5f (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 Nov 2015 22:57:35 -0500
Received: by iofh3 with SMTP id h3so6582313iof.3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2015 19:57:35 -0800 (PST)
In-Reply-To: <20151117001233.GC11993@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, "Frank Ch. Eigler" <fche@redhat.com>
Cc: "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 11/16/15 5:12 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Nov 16, 2015 at 01:08:15PM -0500, Frank Ch. Eigler escreveu:
>> Olga.Kornievskaia wrote:
>
>>> [...] say there are two tracepoints ?foobar_enter? and
>>> ?foobar_exit?. Each tracepoint logs a timestamp. I?d like to be able
>>> to say that on average it takes that many time-units between ?enter?
>>> and ?exit? tracepoints. [...]
>
>> For completeness, a complete systemtap implementation of this could look like:
>
>> # stap -e '
>>     global s, t%
>>     probe kernel.trace("foobar_enter") {
>>         t[tid()]=gettimeofday_us()
>>     }
>>     probe kernel.trace("foobar_exit") {
>>         if (tid() in t) { s <<< gettimeofday_us() - t[tid()] }
>>     }
>>     probe timer.s(5),end {
>>         printf("cumulative average us: %d\n", @avg(s))
>>     }
>> '
>
> Is that done syncronously?

Interesting solution. How does it scale with CPUs and tasks?
