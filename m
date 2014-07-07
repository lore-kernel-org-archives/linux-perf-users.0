From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: Fwd: filtering perf itself
Date: Mon, 7 Jul 2014 12:00:52 -0700
Message-ID: <CAE40pdev5Y5KRsftgNCy67ScXeF7G4JGG_zu5EqDjp=2e4APiQ@mail.gmail.com>
References: <CAE40pdeACbvYJN0BMh9edGGLvdpV_H1Kn5ccgBh7GFuDHiuWGQ@mail.gmail.com>
	<CAE40pdePzcfHfZzuOC6DyFc2H7DQMZ_JzADvx_guDS+Eg4SJtw@mail.gmail.com>
	<53BAEA99.7050602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:41863 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbaGGTAy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Jul 2014 15:00:54 -0400
Received: by mail-qg0-f49.google.com with SMTP id f51so3969581qge.22
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Jul 2014 12:00:54 -0700 (PDT)
In-Reply-To: <53BAEA99.7050602@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Mon, Jul 7, 2014 at 11:44 AM, David Ahern <dsahern@gmail.com> wrote:
> On 7/7/14, 12:38 PM, Brendan Gregg wrote:
>>
>> G'Day perf users,
>>
>> Is there a way to filter perf from tracing itself?
>>
>> Here's an idle system:
>>
>> # ./perf record -e syscalls:sys_enter_read -a sleep 5
>> [ perf record: Woken up 2 times to write data ]
>> [ perf record: Captured and wrote 0.569 MB perf.data (~24864 samples) ]
>> # ./perf record -e syscalls:sys_enter_write -a sleep 5
>> [ perf record: Woken up 0 times to write data ]
>> [ perf record: Captured and wrote 150.381 MB perf.data (~6570251 samples)
>> ]
>>
>> Note the disparity. perf is capturing its own writes, creating a feedback
>> loop.
>
>
> Not a filter, but works around the problem using mmap'ed output file:
>
> https://github.com/dsahern/linux/commit/ae2d7010256f5a5b247fb4df9f764a911a34a2f3
>

Ah, thanks David, that should work! Looking forward to having this
patch included.

Brendan

-- 
http://www.brendangregg.com
