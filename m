From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: Fwd: filtering perf itself
Date: Wed, 9 Jul 2014 12:47:29 -0700
Message-ID: <CAE40pdfrmXAXk-R-gpubjgCVVRS43frnCmoj-PRXV+1KUYefXw@mail.gmail.com>
References: <CAE40pdeACbvYJN0BMh9edGGLvdpV_H1Kn5ccgBh7GFuDHiuWGQ@mail.gmail.com>
	<CAE40pdePzcfHfZzuOC6DyFc2H7DQMZ_JzADvx_guDS+Eg4SJtw@mail.gmail.com>
	<53BAEA99.7050602@gmail.com>
	<87tx6roa0b.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:64079 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839AbaGITra (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Jul 2014 15:47:30 -0400
Received: by mail-vc0-f173.google.com with SMTP id lf12so8138557vcb.18
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2014 12:47:29 -0700 (PDT)
In-Reply-To: <87tx6roa0b.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

G'Day Andi,

On Tue, Jul 8, 2014 at 1:45 PM, Andi Kleen <andi@firstfloor.org> wrote:
> David Ahern <dsahern@gmail.com> writes:
>
>> On 7/7/14, 12:38 PM, Brendan Gregg wrote:
>>> G'Day perf users,
>>>
>>> Is there a way to filter perf from tracing itself?
>>>
>>> Here's an idle system:
>>>
>>> # ./perf record -e syscalls:sys_enter_read -a sleep 5
>>> [ perf record: Woken up 2 times to write data ]
>>> [ perf record: Captured and wrote 0.569 MB perf.data (~24864 samples) ]
>>> # ./perf record -e syscalls:sys_enter_write -a sleep 5
>>> [ perf record: Woken up 0 times to write data ]
>>> [ perf record: Captured and wrote 150.381 MB perf.data (~6570251 samples) ]
>>>
>>> Note the disparity. perf is capturing its own writes, creating a feedback loop.
>>
>> Not a filter, but works around the problem using mmap'ed output file:
>>
>> https://github.com/dsahern/linux/commit/ae2d7010256f5a5b247fb4df9f764a911a34a2f3
>
> The problem is just getting the perf pid into the filter, right?
>
> Something like this patch should work.
>
> Actually it works most of the time, sometimes there are still EINVALs.

Thanks; this is neat and simple. :) So this will solve many use cases,
where I'm dumping to a perf.data file and then processing later. T(he
mmap() patch is also desirable, to reduce the overheads of doing the
write.) But for when I'm piping perf record into perf script, I need a
way to filter both perf's.

If I'm desperate I can write a C program to perf_event_open() and
mmap() directly, and filter the pid in the same way (gitpid()). But I
think there can be some simple one liners where perf record | perf
script are sufficient, provided I'm not tracing perf.

Brendan
-- 
http://www.brendangregg.com
