From: Lin Xiulei <linxiulei@gmail.com>
Subject: Re: [PATCH v2] perf/core: Fix installing cgroup event into cpu
Date: Wed, 24 Jan 2018 17:59:20 +0800
Message-ID: <CALPjY3nNy0Lp14uKob_FytTHaMajRAHsob7=hPaUx6LPFQ6MBQ@mail.gmail.com>
References: <20180124075010.83296-1-linxiulei@gmail.com> <20180124082036.GL2228@hirez.programming.kicks-ass.net>
 <CALPjY3mj7--oAmObtECYDw5GaJ3wLroBVrQ5eQztqmYMCm=8Cw@mail.gmail.com>
 <20180124091456.GN2228@hirez.programming.kicks-ass.net> <CALPjY3mZYSs-8Bg0U0kq=jPz+TX8RxfpvBeVs6oxspfwLjOjfA@mail.gmail.com>
 <20180124094636.GP2228@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42380 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932775AbeAXJ7V (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Jan 2018 04:59:21 -0500
In-Reply-To: <20180124094636.GP2228@hirez.programming.kicks-ass.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, Stephane Eranian <eranian@gmail.com>, torvalds@linux-foundation.org, linux-perf-users@vger.kernel.org, Brendan Gregg <brendan.d.gregg@gmail.com>, yang_oliver@hotmail.com, jinli.zjl@alibaba-inc.com, "leilei.lin" <leilei.lin@alibaba-inc.com>

2018-01-24 17:46 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
> On Wed, Jan 24, 2018 at 05:19:34PM +0800, Lin Xiulei wrote:
>> Sure, and I consider this "OK" works for "What goes wrong if we leave
>> it set?". : )
>
> It would be good if you inspect the code for the case of leaving
> cpuctx->cgrp set with no cgroup events left -- AND -- put a blurb about
> what you found in your new Changelog.
>


I have some test cases for this issue, I don't know if it's good to
put those in changelog


reproduction as below

Step 1

Create program for measuring, write below to the file d.py

```
while True:
    sumup = 0
    for i in range(10000000):
        sumup += i
```

Step 2

Create cgroup path and run relative program

```
mkdir /sys/fs/cgroup/perf_event/test1
mkdir /sys/fs/cgroup/perf_event/test2

python d.py &
echo $! > /sys/fs/cgroup/perf_event/test1/cgroup.procs

python d.py &
echo $! > /sys/fs/cgroup/perf_event/test2/cgroup.procs
```

Step 3

```
perf stat -e cycles -G test1 -e cycles -G test2  -a sleep 1
```

You would see output like below

```

 Performance counter stats for 'system wide':

     2,161,022,123      cycles                    test1
       138,626,073      cycles                    test2

       1.001858328 seconds time elapsed
```

The result of test2 is much less than test1, which happens commonly.
Just because of what I mentioned above that a second event couldn't be
activated immediately, that cases some loss

> I suspect it works out and something like perf_cgroup_switch() will fix
> things up for us later, but double check and test.

exactly, the case above wouldn't have any result if no
perf_cgroup_switch()  happened.
