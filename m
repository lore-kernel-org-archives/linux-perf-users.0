From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: attr inherit vs inherit_stat
Date: Fri, 07 Sep 2012 17:31:21 +0200
Message-ID: <1347031881.18408.86.camel@twins>
References: <alpine.DEB.2.00.1208071544240.16260@cl320.icl.utk.edu>
	 <871uiie0q4.fsf@sejong.aot.lge.com>
	 <alpine.DEB.2.00.1209061116560.10268@cl320.icl.utk.edu>
	 <87fw6ud3wo.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:56545 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab2IGPb0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 7 Sep 2012 11:31:26 -0400
In-Reply-To: <87fw6ud3wo.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Vince Weaver <vweaver1@eecs.utk.edu>, linux-perf-users@vger.kernel.org

On Fri, 2012-09-07 at 10:20 +0900, Namhyung Kim wrote:
> (Adding peterz in case he has a time to answer)
> 
> On Thu, 6 Sep 2012 11:19:21 -0400, Vince Weaver wrote:
> > On Tue, 4 Sep 2012, Namhyung Kim wrote:
> >> 
> >> AFAIK the "inherit" field determines whether the event is inherited to a
> >> child process/thread.  The "inherit_stat" is only meaningful when the
> >> "inherit" field is also set and it'll preserve (saved) event counts
> >> between context switch of the inherited processes/threads.
> >
> > Thank you for taking the time to answer!
> >
> > I'm still trying to construct a test case that shows the difference but 
> > I'm failing.

inherit && inherit_stat preserves the counts per-task and issues a
PERF_RECORD_READ when a task dies. This allows a per-task stat on an
inherited process hierarchy.

> > Aren't the stats *always* saved on context switch?

No, they're normally swizzled around, the only thing we care about is
the total event count for the entire task-set, not the count of the
individual tasks.

> > Does this affect what happens when you read the perf_event fd in the 
> > inherited threads, or only from the master thread?

read() on an inherited event gives the total count of the entire
hierarchy.

> > What is the expected behavior if you set inherit_thread but do not set 
> > inherit?
> 
> You meant inherit_stat, right?  If so, it looks it'd be a nop since
> there's no inherited events.  Maybe the perf tools can be changed to
> warn about that.

Right that would be a pointless configuration.
