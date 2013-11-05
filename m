From: wufei <at.wufei@gmail.com>
Subject: Re: Found unknown events
Date: Tue, 5 Nov 2013 14:44:56 +0800
Message-ID: <CAGTy5_T8QRCXR_JxDn35288zMS4CF5Juj0zSze6iSAVx83w1Aw@mail.gmail.com>
References: <CAGTy5_T+8sY4s+Lp6WhNwjtodqRJs2imd8i6_+7PvvnUf_zQnA@mail.gmail.com>
	<52787C58.7030100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:51167 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab3KEGo6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 5 Nov 2013 01:44:58 -0500
Received: by mail-la0-f42.google.com with SMTP id ep20so1554289lab.15
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2013 22:44:56 -0800 (PST)
In-Reply-To: <52787C58.7030100@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Tue, Nov 5, 2013 at 1:04 PM, David Ahern <dsahern@gmail.com> wrote:
> On 11/4/13, 7:40 AM, wufei wrote:
>>
>> Hello All,
>>
>> I am using perf to measure a multi-threaded program on kernel 3.2.23,
>> the system has 40 cores and there are lots of context switches during
>> the test. The command is:
>>    # perf record -e sched:sched_stat_sleep -e sched:sched_switch -e
>> sched:sched_process_exit -g -r 0 -p 39249 sleep 5
>> It generates a ~1GB size perf.data. `perf report` got 2 issues:
>>
>> 1. A lot of this warning message:
>>       Warning: Timestamp below last timeslice flush
>
>
> What's the NUMA make up? multiple sockets?
>
There are 4 nodes, each one with 10 cores.

>
>>
>> 2. No useful output, but this:
>>       Found 32117 unknown events!
>
>
> Try increasing the mmap size. e.g., -m 2048. Does it decrease or remove this
> stat?
>
It helps. There is no such problem again with this option if I only
trace it in 2 seconds,
but if it's 5 seconds, this problem is still there and another error message:
   "failed to mmap file"

Thanks,
Wufei.

> David
>
