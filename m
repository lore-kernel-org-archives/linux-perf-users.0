From: Andrew Wagin <avagin@gmail.com>
Subject: Re: Profiling sleep times?
Date: Sat, 22 Oct 2011 09:22:17 -0700
Message-ID: <CANaxB-yh8gsUi3E_fuH_ZPkgJvsNxc+QtXBtrGn-+-av7N+rbQ@mail.gmail.com>
References: <1317717291.25926.13.camel@twins>
	<4E8E2417.2000903@fb.com>
	<4E8FAB3A.2040801@gmail.com>
	<4E933E65.1090207@fb.com>
	<20111012074113.GK18618@elte.hu>
	<4E98A75E.3010000@fb.com>
	<20111015170044.GB29782@elte.hu>
	<1318706522.2664.8.camel@laptop>
	<1318706959.11898.1.camel@laptop>
	<4E9CD134.60106@fb.com>
	<20111022104947.GB2811@somewhere.feld.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38928 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab1JVQWS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 22 Oct 2011 12:22:18 -0400
Received: by ggnb1 with SMTP id b1so4670562ggn.19
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Oct 2011 09:22:17 -0700 (PDT)
In-Reply-To: <20111022104947.GB2811@somewhere.feld.cvut.cz>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Arun Sharma <asharma@fb.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, Stephane Eranian <eranian@google.com>

Hi, All.

Sorry for late response. I have vacation.

I see the miscomuniction. You explained me, that remote callchains was
not a good idea and now I think the same. I added plugin to "perf
inject".

The example of usage:
#./perf record -ag -e sched:sched_switch --filter "prev_state == 1" -e
sched:sched_process_exit -e sched:sched_stat_sleep --filter "comm ==
foo" ~/foo

#./perf inject -s -i perf.data -o perf.data.d

#./perf report -i perf.data.d

I'm going to send patches soon.

2011/10/22 Frederic Weisbecker <fweisbec@gmail.com>:
> On Mon, Oct 17, 2011 at 06:07:00PM -0700, Arun Sharma wrote:
>> On 10/15/11 12:29 PM, Peter Zijlstra wrote:
>> >On Sat, 2011-10-15 at 21:22 +0200, Peter Zijlstra wrote:
>> >
>> >>>Sleep time should really just be a different notion of 'cost of the
>> >>>function/callchain' and fit into the existing scheme, right?
>> >>
>> >>The problem with andrew's patches is that it wrecks the callchain
>> >>semantics. The waittime tracepoint is in the wakeup path (and hence
>> >>generates the wakee's callchain) whereas they really want the callchain
>> >>of the woken task to show where it spend time.
>> >
>> >We could of course try to move the tracepoint into the schedule path, so
>> >we issue it the first time the task gets scheduled after the wakeup, but
>> >I suspect that will just add more overhead, and we really could do
>> >without that.
>>
>> Do we need to define new tracepoints? I suspect we could make the
>> existing ones:
>>
>> trace_sched_stat_wait()
>> trace_sched_stat_sleep()
>>
>> work for this purpose. The length of time the task was not on the
>> cpu could then be computed as: sleep+wait. The downside is that the
>> complexity moves to user space.
>>
>> perf record -e sched:sched_stat_sleep,sched:sched_stat_wait,...
>>
>> Re: changing the semantics of tracepoint callchains
>>
>> Yeah - this could be surprising. Luckily, most tracepoints retain
>> their semantics, but a few special ones don't. I guess we just need
>> to document the new behavior.
>
> That's not only a problem of semantics although that alone is a problem,
> people will seldom read the documentation for corner cases, we should
> really stay consistant here: if remote callchains are really needed, we
> want a specific interface for that, not abusing the existing one that would
> only confuse people.
>
> Now I still think doing remote callchains is asking for troubles: we need to
> ensure the target is really sleeping and is not going to be scheduled
> concurrently otherwise you might get weird or stale results. So the user needs
> to know which tracepoints are safe to perform this.
> Then comes the problem to deal with remote callchains in userspace: the event
> comes from a task but the callchain is from another. You need the perf tools
> to handle remote dsos/mapping/sym etc...
>
> That's a lot of unnecessary complications.
>
> I think we should use something like a perf report plugin: perhaps something
> that can create a virtual event on top of real ones: compute the sched:sched_switch
> events, find the time tasks are sleeping and create virtual sleep events on top
> of that with a period weighted with the sleep time.
> Just a thought.
>
