From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Fwd: filtering perf itself
Date: Mon, 7 Jul 2014 11:38:43 -0700
Message-ID: <CAE40pdePzcfHfZzuOC6DyFc2H7DQMZ_JzADvx_guDS+Eg4SJtw@mail.gmail.com>
References: <CAE40pdeACbvYJN0BMh9edGGLvdpV_H1Kn5ccgBh7GFuDHiuWGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:54438 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbaGGSio (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Jul 2014 14:38:44 -0400
Received: by mail-qc0-f176.google.com with SMTP id w7so4320732qcr.35
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Jul 2014 11:38:43 -0700 (PDT)
In-Reply-To: <CAE40pdeACbvYJN0BMh9edGGLvdpV_H1Kn5ccgBh7GFuDHiuWGQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

G'Day perf users,

Is there a way to filter perf from tracing itself?

Here's an idle system:

# ./perf record -e syscalls:sys_enter_read -a sleep 5
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.569 MB perf.data (~24864 samples) ]
# ./perf record -e syscalls:sys_enter_write -a sleep 5
[ perf record: Woken up 0 times to write data ]
[ perf record: Captured and wrote 150.381 MB perf.data (~6570251 samples) ]

Note the disparity. perf is capturing its own writes, creating a feedback loop.

I haven't seen a way to filter this. Eg:

# ./perf record -q -e syscalls:sys_enter_write --filter 'comm != perf'
-a sleep 5
  Error: failed to set filter with 22 (Invalid argument)

# ./perf record -q -e syscalls:sys_enter_write --filter 'ppid != '$$ -a sleep 5
  Error: failed to set filter with 22 (Invalid argument)

# ./perf record -q -e raw_syscalls:sys_enter --filter 'comm != perf' -a sleep 5
  Error: failed to set filter with 22 (Invalid argument)

# ./perf record -q -e raw_syscalls:sys_enter --filter 'common_ppid !=
'$$ -a sleep 5
  Error: failed to set filter with 22 (Invalid argument)

This is because comm, ppid, common_ppid, etc, aren't available for
those tracepoints.

I thought there might be a simple way I'm missing. I'm on
linux-3.16-rc2. Thanks,

Brendan

-- 
http://www.brendangregg.com
