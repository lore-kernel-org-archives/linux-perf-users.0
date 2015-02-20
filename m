From: Paul Clarke <pc@us.ibm.com>
Subject: Re: uprobe symbols with @GLIBC...
Date: Fri, 20 Feb 2015 11:57:58 -0600
Message-ID: <54E775A6.8000704@us.ibm.com>
References: <54E752BF.50309@us.ibm.com> <54E76CDC.2090904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:47418 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbbBTR7A (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Feb 2015 12:59:00 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <pc@us.ibm.com>;
	Fri, 20 Feb 2015 10:58:59 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8C0C419D803E
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Feb 2015 10:50:05 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1KHwmIQ53411936
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Feb 2015 10:58:56 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1KHwNoV025511
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Feb 2015 10:58:23 -0700
In-Reply-To: <54E76CDC.2090904@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

On 02/20/2015 11:20 AM, David Ahern wrote:
> On 2/20/15 8:29 AM, Paul Clarke wrote:
>> How does one set a dynamic tracepoint for user-mode symbols with "@"
>> qualifiers?
>>
>> # perf probe -F -x /lib/libpthread.so.0 --filter='pthread_create*'
>> pthread_create@@GLIBC_2.1
>> pthread_create@GLIBC_2.0
>
> one of many reasons I proposed an option to let users specify an address.
>
> https://lkml.org/lkml/2013/12/1/126
> https://lkml.org/lkml/2013/12/2/324
>
> It was not picked up.

I presume then, that I'm not doing something obviously wrong, and this 
is the current state of affairs?

Given that, I would argue that a better resolution would be to:

1. Support setting probes using the name of the symbol as reported by 
"--funcs".  For example, the following should work:

# perf probe -x /lib/libpthread.so.0 pthread_create@GLIBC_2.0

-- AND / OR --

2. Go ahead and just set probes at all functions which match the base 
function name.  For example, the following:

# perf probe -v -x /lib/libpthread.so.0 pthread_create

Would set probes at both known "pthread_create" entry points:
- pthread_create@@GLIBC_2.1
- pthread_create@GLIBC_2.0

>> # perf probe -v -x /lib/libpthread.so.0 pthread_create@GLIBC_2.0
>> probe-definition(0): pthread_create@GLIBC_2.0
>> symbol:pthread_create file:GLIBC_2.0 line:0 offset:0 return:0 lazy:(null)
>> 0 arguments
>> Failed to open debuginfo file.
>>    Error: Failed to add events. (-2)
>>
>> # perf probe -v -x /lib/libpthread.so.0 pthread_create
>> probe-definition(0): pthread_create
>> symbol:pthread_create file:(null) line:0 offset:0 return:0 lazy:(null)
>> 0 arguments
>> Could not open debuginfo. Try to use symbols.
>> no symbols found in /usr/lib/libpthread-2.18.so, maybe install a debug
>> package?
>> Failed to find symbol pthread_create in /usr/lib/libpthread-2.18.so
>>    Error: Failed to add events. (-2)
>>
>> Symbols without such qualifiers work fine:
>>
>> # perf probe -F -x /lib/libpthread.so.0 --filter='pthread_detach*'
>> pthread_detach
>>
>> # perf probe -v -x /lib/libpthread.so.0 pthread_detach
>> probe-definition(0): pthread_detach
>> symbol:pthread_detach file:(null) line:0 offset:0 return:0 lazy:(null)
>> 0 arguments
>> Could not open debuginfo. Try to use symbols.
>> Opening /sys/kernel/debug/tracing/uprobe_events write=1
>> Added new event:
>> Writing event: p:probe_libpthread/pthread_detach
>> /usr/lib/libpthread-2.18.so:0x8b30
>>    probe_libpthread:pthread_detach (on pthread_detach in
>> /usr/lib/libpthread-2.18.so)
--
PC
