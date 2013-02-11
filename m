From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf record premature termination
Date: Mon, 11 Feb 2013 12:05:50 -0700
Message-ID: <5119410E.1010908@gmail.com>
References: <1360608612.17632.193.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:54517 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758302Ab3BKTF7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 11 Feb 2013 14:05:59 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so3241230pad.16
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Feb 2013 11:05:58 -0800 (PST)
In-Reply-To: <1360608612.17632.193.camel@schen9-DESK>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Tim Chen <tim.c.chen@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, ak <ak@linux.intel.com>

On 2/11/13 11:50 AM, Tim Chen wrote:
> David,
>
> When I am doing a profiling of kernel compile with 32 threads on a 4
> socket westmere machine, I found that perf record terminated right away
> for the version of perf in 3.7 kernel source tree.
> There's no profile data recroded and the compile is running in
> background.
>
> $ make -j32 &
> then
> $ sudo /test/perf record -a -g -f sleep 5
> sleep: Terminated
>

Race condition collecting the initial thread data:
$ su -c '/tmp/perf-3.7/perf record -a -g -f -o /tmp/perf.data -v sleep 5'
Password:
couldn't open /proc/22518/status
couldn't open /proc/22518/task
couldn't open /proc/22518/maps
sleep: Terminated

David
