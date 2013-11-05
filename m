From: David Ahern <dsahern@gmail.com>
Subject: Re: Found unknown events
Date: Mon, 04 Nov 2013 22:04:24 -0700
Message-ID: <52787C58.7030100@gmail.com>
References: <CAGTy5_T+8sY4s+Lp6WhNwjtodqRJs2imd8i6_+7PvvnUf_zQnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:58920 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab3KEFE0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 5 Nov 2013 00:04:26 -0500
Received: by mail-pd0-f172.google.com with SMTP id w10so7759634pde.31
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2013 21:04:26 -0800 (PST)
In-Reply-To: <CAGTy5_T+8sY4s+Lp6WhNwjtodqRJs2imd8i6_+7PvvnUf_zQnA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: wufei <at.wufei@gmail.com>, linux-perf-users@vger.kernel.org

On 11/4/13, 7:40 AM, wufei wrote:
> Hello All,
>
> I am using perf to measure a multi-threaded program on kernel 3.2.23,
> the system has 40 cores and there are lots of context switches during
> the test. The command is:
>    # perf record -e sched:sched_stat_sleep -e sched:sched_switch -e
> sched:sched_process_exit -g -r 0 -p 39249 sleep 5
> It generates a ~1GB size perf.data. `perf report` got 2 issues:
>
> 1. A lot of this warning message:
>       Warning: Timestamp below last timeslice flush

What's the NUMA make up? multiple sockets?

>
> 2. No useful output, but this:
>       Found 32117 unknown events!

Try increasing the mmap size. e.g., -m 2048. Does it decrease or remove 
this stat?

David
