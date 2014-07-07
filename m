From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: Fwd: filtering perf itself
Date: Mon, 7 Jul 2014 12:16:01 -0700
Message-ID: <CAE40pddousTpz0-RzehG=Dg7+TKTQYKUXfErqg9QuBU=fzUyGw@mail.gmail.com>
References: <CAE40pdeACbvYJN0BMh9edGGLvdpV_H1Kn5ccgBh7GFuDHiuWGQ@mail.gmail.com>
	<CAE40pdePzcfHfZzuOC6DyFc2H7DQMZ_JzADvx_guDS+Eg4SJtw@mail.gmail.com>
	<53BAEA99.7050602@gmail.com>
	<CAE40pdev5Y5KRsftgNCy67ScXeF7G4JGG_zu5EqDjp=2e4APiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:42011 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbaGGTQC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Jul 2014 15:16:02 -0400
Received: by mail-qc0-f178.google.com with SMTP id c9so4262470qcz.9
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Jul 2014 12:16:01 -0700 (PDT)
In-Reply-To: <CAE40pdev5Y5KRsftgNCy67ScXeF7G4JGG_zu5EqDjp=2e4APiQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Mon, Jul 7, 2014 at 12:00 PM, Brendan Gregg
<brendan.d.gregg@gmail.com> wrote:
> On Mon, Jul 7, 2014 at 11:44 AM, David Ahern <dsahern@gmail.com> wrote:
>> On 7/7/14, 12:38 PM, Brendan Gregg wrote:
>>>
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
>>> [ perf record: Captured and wrote 150.381 MB perf.data (~6570251 samples)
>>> ]
>>>
>>> Note the disparity. perf is capturing its own writes, creating a feedback
>>> loop.
>>
>>
>> Not a filter, but works around the problem using mmap'ed output file:
>>
>> https://github.com/dsahern/linux/commit/ae2d7010256f5a5b247fb4df9f764a911a34a2f3
>>
>
> Ah, thanks David, that should work! Looking forward to having this
> patch included.
>

While this should help a lot of cases, I realized I am using stdout
from time to time as well (similar to the "perf script" framework),
where I don't think mmap() is going to work. Eg:

# perf record -e raw_syscalls:sys_enter -a -o - sleep 5 | perf script
-i - | stuff...

Maybe perf should skip itself by-default, unless asked (eg, -I to
include perf's own events). Or some way to filter it would also work,
eg, common_ppid.

Brendan
-- 
http://www.brendangregg.com
