From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFD] perf: events defined contexts (was Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect)
Date: Mon, 06 Aug 2012 10:41:02 +0900
Message-ID: <87zk68ztjl.fsf@sejong.aot.lge.com>
References: <501121D3.3060700@mentor.com> <20120727072647.GA3965@gmail.com>
	<20120727115633.GL1173@somewhere.redhat.com>
	<20120727124538.GB917@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:51051 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286Ab2HFBrK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 5 Aug 2012 21:47:10 -0400
In-Reply-To: <20120727124538.GB917@krava.brq.redhat.com> (Jiri Olsa's message
	of "Fri, 27 Jul 2012 14:45:38 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>, Iegorov Oleg <oleg_iegorov@mentor.com>, linux-perf-users@vger.kernel.org, mingo@elte.hu, a.p.zijlstra@chello.nl, acme@ghostprotocols.net, Arnaldo Carvalho de Melo <acme@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

Hi,

On Fri, 27 Jul 2012 14:45:38 +0200, Jiri Olsa wrote:
> On Fri, Jul 27, 2012 at 01:56:36PM +0200, Frederic Weisbecker wrote:
>> The problem is more general than that I think.
>> We need to be able to define finer grained contexts than just
>> "task" and/or "CPU".
>> 
>> And reusing events themselves would be a nice interface.
>> 
>> For example create 3 events:
>> 
>> A = irq entry tracepoint
>> B = irq exit tracepoint
>> C = cpu-cycles
>> 
>> And say: I want to count cpu-cycles when event A fires and stop counting
>> when B fires.
>> 
>> With that you can count cpu cycles on irqs.
>> 
>> You could use any event you want to define your contexts: lock, functions, etc...
>> 
>> And even uprobes to define areas in userspace to profile. Would that solve
>> the initial problem in the thread? Like hook on function library entry/exit?
>> 
>> I talked about that to Jiri Olsa several times. May be he would be interested
>> in implementing this. I posted some patchets one year ago but got sidetracked.
>> 
>> This can give you an idea from where we can start: https://lkml.org/lkml/2011/3/14/346
>> 
>> Jiri, would you be interested in working on this?
>
> yep, I remember also talking about A/B being functions entry/exit
>
> I think that was also the initial push for having ftrace perf events
> support, which already got in.
>
> I'll check ;)
>

Very cool. :) I'm also interested in the feature although my background
knowledge is not firm enough yet. Please let me know if there's anything
I can help you on this.

Thanks,
Namhyung
