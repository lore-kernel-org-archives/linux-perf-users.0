From: Arun Sharma <asharma@fb.com>
Subject: Re: Profiling sleep times?
Date: Mon, 17 Oct 2011 18:07:00 -0700
Message-ID: <4E9CD134.60106@fb.com>
References: <4E8A0F53.7020408@fb.com> <1317673027.20367.41.camel@twins>  <4E8A2EC5.1030901@fb.com> <1317717291.25926.13.camel@twins>  <4E8E2417.2000903@fb.com> <4E8FAB3A.2040801@gmail.com>  <4E933E65.1090207@fb.com> <20111012074113.GK18618@elte.hu>  <4E98A75E.3010000@fb.com>  <20111015170044.GB29782@elte.hu>  <1318706522.2664.8.camel@laptop> <1318706959.11898.1.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51742 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751125Ab1JRBHb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Oct 2011 21:07:31 -0400
In-Reply-To: <1318706959.11898.1.camel@laptop>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, avagin@gmail.com, linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, Stephane Eranian <eranian@google.com>, Frederic Weisbecker <fweisbec@gmail.com>

On 10/15/11 12:29 PM, Peter Zijlstra wrote:
> On Sat, 2011-10-15 at 21:22 +0200, Peter Zijlstra wrote:
>
>>> Sleep time should really just be a different notion of 'cost of the
>>> function/callchain' and fit into the existing scheme, right?
>>
>> The problem with andrew's patches is that it wrecks the callchain
>> semantics. The waittime tracepoint is in the wakeup path (and hence
>> generates the wakee's callchain) whereas they really want the callchain
>> of the woken task to show where it spend time.
>
> We could of course try to move the tracepoint into the schedule path, so
> we issue it the first time the task gets scheduled after the wakeup, but
> I suspect that will just add more overhead, and we really could do
> without that.

Do we need to define new tracepoints? I suspect we could make the 
existing ones:

trace_sched_stat_wait()
trace_sched_stat_sleep()

work for this purpose. The length of time the task was not on the cpu 
could then be computed as: sleep+wait. The downside is that the 
complexity moves to user space.

perf record -e sched:sched_stat_sleep,sched:sched_stat_wait,...

Re: changing the semantics of tracepoint callchains

Yeah - this could be surprising. Luckily, most tracepoints retain their 
semantics, but a few special ones don't. I guess we just need to 
document the new behavior.

  -Arun
