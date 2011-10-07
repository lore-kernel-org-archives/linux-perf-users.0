From: "avagin@gmail.com" <avagin@gmail.com>
Subject: Re: Profiling sleep times?
Date: Sat, 08 Oct 2011 03:16:28 +0400
Message-ID: <4E8F884C.8010209@gmail.com>
References: <4E8A0F53.7020408@fb.com> <1317673027.20367.41.camel@twins>   <4E8A2EC5.1030901@fb.com> <1317717291.25926.13.camel@twins>  <4E8E2417.2000903@fb.com> <1317951036.9813.12.camel@twins> <4E8F3DD2.9000807@fb.com>
Reply-To: avagin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56739 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab1JGXQj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 7 Oct 2011 19:16:39 -0400
Received: by bkbzt4 with SMTP id zt4so5374302bkb.19
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Oct 2011 16:16:38 -0700 (PDT)
In-Reply-To: <4E8F3DD2.9000807@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, Stephane Eranian <eranian@google.com>, Frederic Weisbecker <fweisbec@gmail.com>

Hello Arun,

> Andrew: what do you think about generalizing my patch to accept a
> command line option(s) to specify which fields to use for the purpose of
> computing the histogram?
I have no objection, but I don't think, that we really need that.

Now we have not got a real use case. All events which I've seen have not 
more than one parameters, which may be used as weight and for this one 
we already have parameter "period".

I already said, that you have trouble with sched_stat_sleed due to some 
issues in kernel.

The first issue is that __perf_cout doesn't work and I sent the patch, 
which fixes it. ([PATCH] perf: fix counter of ftrace events)

And the second issue is that the trace events are divided on some perf 
events and their number is restricted by sysctl_perf_event_sample_rate/HZ.
I don't sure, that we should generate more than one "perf" event on each 
"trace" event. I think the better way to use SAMPLE_PERIOD and now I 
think in this direction.

If you want to fix the bug with sched_stat_sleep, you need to fix the 
second issue. I found workaround for your case:

#./perf record -age sched:sched_stat_sleep --filter="comm == foo" -c 
100000 -F 100000 -- ~/foo
# ./perf report
# Events: 5K sched:sched_stat_sleep
#
# Overhead  Command      Shared Object  Symbol
# ........  .......  .................  ......
#
     99.98%      foo  [unknown]          [k] 0
                 |
                 --- schedule
                    |
                    |--80.20%-- schedule_hrtimeout_range_clock
                    |          schedule_hrtimeout_range
                    |          poll_schedule_timeout
                    |          do_select
                    |          core_sys_select
                    |          sys_select
                    |          system_call_fastpath
                    |
                     --19.80%-- do_nanosleep
                               hrtimer_nanosleep
                               sys_nanosleep
                               system_call_fastpath


>
> For static tracepoints, TP_perf_assign() could act as a hint on which
> field to default to.
>
> -Arun
