From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf sampling frequency drops after some record rounds?
Date: Tue, 11 Apr 2017 20:07:52 -0700
Message-ID: <87shlegw6v.fsf@firstfloor.org>
References: <14226027.icvnRACTdJ@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:16651 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751686AbdDLDHy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Apr 2017 23:07:54 -0400
In-Reply-To: <14226027.icvnRACTdJ@milian-kdab2> (Milian Wolff's message of
        "Tue, 11 Apr 2017 15:49:06 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Perf Users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Nate Rogers <nate.rogers@kdab.com>

Milian Wolff <milian.wolff@kdab.com> writes:

> a colleague of mine (CC'ed) is encountering a strange issue with perf from 
> Ubuntu 16.04 running on a Thinkpad P50 with Intel(R) Core(TM) i7-6700HQ CPU @ 
> 2.60GHz on 4.4.0-72-generic with perf version 4.4.49.
>
> For him, the sampling frequency drops dramatically after some successful 
> records, making perf record essentially unusable afterwards:

I see that regularly too, especially on larger systems.

You can see how long the perf nmis take by enabling the nmi trace
tracepoint

echo 1 > /sys/kernel/debug/tracing/events/nmi/enable
... run perf ...
cat /sys/kernel/debug/trace

I debugged a few
cases some time ago, and the two most common causes were:
- there was an old case where there was a lot of cache line contention
on struct page reference counts hurting larger systems. That was fixed
eventually.
- too many page faults while stack walking. The old atomic copy user
did multiple page faults even for a single page fault, just to find out
where exactly the page fault was occurring (even though nothing cares
about the exact location). This was fixed a few kernels ago, but it will
still do a single page fault, which may be slow.
- sometimes when the perf ring buffer is full there is a very long
delay. I have seen it in traces, but no fixes so far.
- there may be more problems.

Usually the way to debug it is using ftrace function tracer, but you
have to enable ftrace for perf first (remove the lines from the makefile
that disable it). Then

T=/sys/kernel/debug/tracing
echo default_do_nmi > $T/set_graph_function
echo function_graph > $T/current_tracer
cat $T/events/nmi/nmi_handler/trigger
echo 'traceoff if delta_ns > 20000' > $T/events/nmi/nmi_handler/trigger
echo 1 > $T/events/nmi/enable

... run perf ...

and look at what the long NMI did in the $T/trace

Of course you can also disable the limiter sysctl
(echo 0 > /proc/sys/kernel/perf_cpu_time_max_percent) 
but then there is no protection of the perf NMI using up all your CPU
and hanging the system.

-Andi
