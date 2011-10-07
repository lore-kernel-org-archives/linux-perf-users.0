From: "avagin@gmail.com" <avagin@gmail.com>
Subject: Re: Profiling sleep times?
Date: Fri, 07 Oct 2011 09:42:26 +0400
Message-ID: <4E8E9142.1030103@gmail.com>
References: <4E8A0F53.7020408@fb.com> <1317673027.20367.41.camel@twins>   <4E8A2EC5.1030901@fb.com> <1317717291.25926.13.camel@twins>  <4E8E2417.2000903@fb.com> <1317951036.9813.12.camel@twins>
Reply-To: avagin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34150 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab1JGFm3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 7 Oct 2011 01:42:29 -0400
Received: by bkbzt4 with SMTP id zt4so4423303bkb.19
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Oct 2011 22:42:28 -0700 (PDT)
In-Reply-To: <1317951036.9813.12.camel@twins>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arun Sharma <asharma@fb.com>, linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, Stephane Eranian <eranian@google.com>, Frederic Weisbecker <fweisbec@gmail.com>

On 10/07/2011 05:30 AM, Peter Zijlstra wrote:
> On Thu, 2011-10-06 at 14:56 -0700, Arun Sharma wrote:
>>             foo 15516 [006]  2291.187831: sched_stat_sleep: comm=foo
>> pid=15516 delay=4054262 [ns]
>>                foo 15516 [006]  2291.187832: sched_stat_sleep: comm=foo
>> pid=15516 delay=4054262 [ns]
>>                foo 15516 [006]  2291.188895: sched_stat_sleep: comm=foo
>> pid=15516 delay=1053565 [ns]
>>                foo 15516 [006]  2291.188896: sched_stat_sleep: comm=foo
>> pid=15516 delay=1053565 [ns]
>>                foo 15516 [006]  2291.188897: sched_stat_sleep: comm=foo
>> pid=15516 delay=1053565 [ns]
>
> But the idea of the __perf_count() thing:
__perf_count() doesn't work now and I have sent the patch, which fixes 
it. Could you commit it? It's subject:
[PATCH 1/4] perf: fix counter of ftrace events

but it's not all.
By default perf doesn't use SAMPLE_PERIOD, it bases on events count.
Each "trace" event is divided on some "perf" events in 
perf_swevent_overflow().

The number of perf events should be proportional __perf_count(), but the 
number of perf events restricted by sysctl_perf_event_sample_rate / HZ. 
In my case it's 100 events.

....
if (hwc->interrupts != MAX_INTERRUPTS) {
     hwc->interrupts++;
     if (HZ * hwc->interrupts > (u64)sysctl_perf_event_sample_rate) {
....


So Arun Sharma probably has perf.data which contains packages of events 
and each package contains 100 events irrespective of "delay".

>
> DECLARE_EVENT_CLASS(sched_stat_template,
>
> 	TP_PROTO(struct task_struct *tsk, u64 delay),
>
> 	TP_ARGS(tsk, delay),
>
> 	TP_STRUCT__entry(
> 		__array( char,	comm,	TASK_COMM_LEN	)
> 		__field( pid_t,	pid			)
> 		__field( u64,	delay			)
> 	),
>
> 	TP_fast_assign(
> 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
> 		__entry->pid	= tsk->pid;
> 		__entry->delay	= delay;
> 	)
> 	TP_perf_assign(
> 		__perf_count(delay);
> 	),
>
> 	TP_printk("comm=%s pid=%d delay=%Lu [ns]",
> 			__entry->comm, __entry->pid,
> 			(unsigned long long)__entry->delay)
> );
>
>
> is that the counter is incremented with the delay, so the event should
> get weighted right.
>
> So having to get the delay out of the raw tracepoint data shouldn't be
> needed.
