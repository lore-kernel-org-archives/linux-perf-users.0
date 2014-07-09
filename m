From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: Fwd: filtering perf itself
Date: Wed, 9 Jul 2014 12:27:05 -0700
Message-ID: <CAE40pddYU3-hmtdngCcmg6F3xgjQbdDguH8Bd2Q1mzuSXKMH1Q@mail.gmail.com>
References: <CAE40pdeACbvYJN0BMh9edGGLvdpV_H1Kn5ccgBh7GFuDHiuWGQ@mail.gmail.com>
	<CAE40pdePzcfHfZzuOC6DyFc2H7DQMZ_JzADvx_guDS+Eg4SJtw@mail.gmail.com>
	<53BAEA99.7050602@gmail.com>
	<CAE40pdev5Y5KRsftgNCy67ScXeF7G4JGG_zu5EqDjp=2e4APiQ@mail.gmail.com>
	<53BC423D.7040208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:40348 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756026AbaGIT1H (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Jul 2014 15:27:07 -0400
Received: by mail-vc0-f182.google.com with SMTP id il7so7982506vcb.41
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2014 12:27:06 -0700 (PDT)
In-Reply-To: <53BC423D.7040208@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

G'Day Will,

On Tue, Jul 8, 2014 at 12:10 PM, William Cohen <wcohen@redhat.com> wrote:
> On 07/07/2014 03:00 PM, Brendan Gregg wrote:
>> On Mon, Jul 7, 2014 at 11:44 AM, David Ahern <dsahern@gmail.com> wrote:
>>> On 7/7/14, 12:38 PM, Brendan Gregg wrote:
>>>>
>>>> G'Day perf users,
>>>>
>>>> Is there a way to filter perf from tracing itself?
>>>>
>>>> Here's an idle system:
>>>>
>>>> # ./perf record -e syscalls:sys_enter_read -a sleep 5
>>>> [ perf record: Woken up 2 times to write data ]
>>>> [ perf record: Captured and wrote 0.569 MB perf.data (~24864 samples) ]
>>>> # ./perf record -e syscalls:sys_enter_write -a sleep 5
>>>> [ perf record: Woken up 0 times to write data ]
>>>> [ perf record: Captured and wrote 150.381 MB perf.data (~6570251 samples)
>>>> ]
>>>>
>>>> Note the disparity. perf is capturing its own writes, creating a feedback
>>>> loop.
>>>
>
> What about probing using SystemTap and doing filtering in the probe handler to exclude the monitoring process?

Yes, that works, and in addition I can do custom in-kernel
aggregations with SystemTap, which reduces overheads much further. My
problem is finding the time to check that 2.6 is safe for production
use (I already know that perf_events is).

Brendan

-- 
http://www.brendangregg.com
