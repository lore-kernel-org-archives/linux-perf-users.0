From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Profiling sleep times?
Date: Fri, 07 Oct 2011 03:30:36 +0200
Message-ID: <1317951036.9813.12.camel@twins>
References: <4E8A0F53.7020408@fb.com> <1317673027.20367.41.camel@twins>
	  <4E8A2EC5.1030901@fb.com> <1317717291.25926.13.camel@twins>
	 <4E8E2417.2000903@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:58999 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab1JGBbB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Oct 2011 21:31:01 -0400
In-Reply-To: <4E8E2417.2000903@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, Stephane Eranian <eranian@google.com>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Vagin <avagin@gmail.com>

On Thu, 2011-10-06 at 14:56 -0700, Arun Sharma wrote:
>            foo 15516 [006]  2291.187831: sched_stat_sleep: comm=foo 
> pid=15516 delay=4054262 [ns]
>               foo 15516 [006]  2291.187832: sched_stat_sleep: comm=foo 
> pid=15516 delay=4054262 [ns]
>               foo 15516 [006]  2291.188895: sched_stat_sleep: comm=foo 
> pid=15516 delay=1053565 [ns]
>               foo 15516 [006]  2291.188896: sched_stat_sleep: comm=foo 
> pid=15516 delay=1053565 [ns]
>               foo 15516 [006]  2291.188897: sched_stat_sleep: comm=foo 
> pid=15516 delay=1053565 [ns] 

But the idea of the __perf_count() thing:

DECLARE_EVENT_CLASS(sched_stat_template,

	TP_PROTO(struct task_struct *tsk, u64 delay),

	TP_ARGS(tsk, delay),

	TP_STRUCT__entry(
		__array( char,	comm,	TASK_COMM_LEN	)
		__field( pid_t,	pid			)
		__field( u64,	delay			)
	),

	TP_fast_assign(
		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
		__entry->pid	= tsk->pid;
		__entry->delay	= delay;
	)
	TP_perf_assign(
		__perf_count(delay);
	),

	TP_printk("comm=%s pid=%d delay=%Lu [ns]",
			__entry->comm, __entry->pid,
			(unsigned long long)__entry->delay)
);


is that the counter is incremented with the delay, so the event should
get weighted right.

So having to get the delay out of the raw tracepoint data shouldn't be
needed.
