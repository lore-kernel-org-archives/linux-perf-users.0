From: Yilong Li <yilongl@cs.stanford.edu>
Subject: Re: Need help in tracking down OS jitters using Intel PT
Date: Thu, 23 Mar 2017 23:16:04 -0700
Message-ID: <CAPJB79Sggb46q0_-R9p+hLW9S5N0=w3J3JAYyh66wVXGa-LaZw@mail.gmail.com>
References: <CAPJB79SqGQY-jb455rJXsyzF7cEkrLE653rwG+rPy6F4+-VQEA@mail.gmail.com>
 <6ccea408-bf0e-e730-5375-e6cba55f6540@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp2.cs.stanford.edu ([171.64.64.26]:60118 "EHLO
        smtp2.cs.Stanford.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdCXGQH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Mar 2017 02:16:07 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33068)
        by smtp2.cs.Stanford.EDU with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.88)
        (envelope-from <yilongl@cs.stanford.edu>)
        id 1crIW5-00061E-Fg
        for linux-perf-users@vger.kernel.org; Thu, 23 Mar 2017 23:16:06 -0700
Received: by mail-pf0-f180.google.com with SMTP id o190so3209340pfo.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Mar 2017 23:16:05 -0700 (PDT)
In-Reply-To: <6ccea408-bf0e-e730-5375-e6cba55f6540@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

I have tried the hw latency detector but it's not enough to pin point
the problem for me because the current implementation only outputs the
maximum jitter observed. Here is the example output:

# tracer: hwlat
#
# entries-in-buffer/entries-written: 64/64   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
           <...>-2512  [000] d...  2584.575347: #1
inner/outer(us):  165/223   ts:1490333353.666940246 nmi-total:9
nmi-count:1
           <...>-2512  [001] dn..  2585.586994: #2
inner/outer(us):  185/200   ts:1490333354.678950385
           <...>-2512  [002] dn..  2586.610779: #3
inner/outer(us):  173/209   ts:1490333355.702960161
           <...>-2512  [003] d...  2587.634763: #4
inner/outer(us):  229/210   ts:1490333356.718969641
           <...>-2512  [004] d...  2588.658749: #5
inner/outer(us):  181/234   ts:1490333357.750979263
           <...>-2512  [005] d...  2589.682887: #6
inner/outer(us):   17/236   ts:1490333358.758988675
           <...>-2512  [006] dn..  2590.706737: #7
inner/outer(us):  211/172   ts:1490333359.798998395
           <...>-2512  [007] dn..  2591.730706: #8
inner/outer(us):   20/238   ts:1490333360.823007948
           <...>-2512  [000] dn..  2592.754690: #9
inner/outer(us):  153/231   ts:1490333361.847017517
[snip]

In addition, I also tried reading msr 0x34 before and after my test
program. I found that the delta of the readings, which I believe
should be the number of SMI fired during my run, matched the number of
jitters that take > 300000 cycles (~150us). So I am ruling out SMI for
my 15us jitters.

Is it safe to say that only hardware and firmware induced jitters are
invisible to Intel PT? If so, why isn't Intel PT aware of them? Also,
does anyone have any suggestion on how to identify the sources of
hardware/firmware jitters? Thanks.

Best,
Yilong

On Thu, Mar 23, 2017 at 8:30 AM, David Ahern <dsahern@gmail.com> wrote:
> On 3/23/17 3:28 AM, Yilong Li wrote:
>> What am I missing? Where does the 15us go? The program and the scripts
>> I used in the experiment can be found here:
>> https://github.com/yilongli/OSJitterTest.
>
> have you tried the hw latency detector? kernel/trace/trace_hwlat.c and
> config HWLAT_TRACER
