From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: attr inherit vs inherit_stat
Date: Fri, 07 Sep 2012 10:20:55 +0900
Message-ID: <87fw6ud3wo.fsf@sejong.aot.lge.com>
References: <alpine.DEB.2.00.1208071544240.16260@cl320.icl.utk.edu>
	<871uiie0q4.fsf@sejong.aot.lge.com>
	<alpine.DEB.2.00.1209061116560.10268@cl320.icl.utk.edu>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:65505 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab2IGB2W (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Sep 2012 21:28:22 -0400
In-Reply-To: <alpine.DEB.2.00.1209061116560.10268@cl320.icl.utk.edu> (Vince
	Weaver's message of "Thu, 6 Sep 2012 11:19:21 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vweaver1@eecs.utk.edu>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>

(Adding peterz in case he has a time to answer)

On Thu, 6 Sep 2012 11:19:21 -0400, Vince Weaver wrote:
> On Tue, 4 Sep 2012, Namhyung Kim wrote:
>> 
>> AFAIK the "inherit" field determines whether the event is inherited to a
>> child process/thread.  The "inherit_stat" is only meaningful when the
>> "inherit" field is also set and it'll preserve (saved) event counts
>> between context switch of the inherited processes/threads.
>
> Thank you for taking the time to answer!
>
> I'm still trying to construct a test case that shows the difference but 
> I'm failing.

Please note that my understanding of perf core code is not firm enough
so there might be some mistakes. ;-)


>
> Aren't the stats *always* saved on context switch?

If both of them are cloned from the same parent event context and
there's no event added in the meantime.

Please see perf_event_context_sched_out() calling perf_event_sync_stat.


>
> Does this affect what happens when you read the perf_event fd in the 
> inherited threads, or only from the master thread?

It might.  But I guess the master thread doesn't get affected from that.


>
> What is the expected behavior if you set inherit_thread but do not set 
> inherit?

You meant inherit_stat, right?  If so, it looks it'd be a nop since
there's no inherited events.  Maybe the perf tools can be changed to
warn about that.

Thanks,
Namhyung
