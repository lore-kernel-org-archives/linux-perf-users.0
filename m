Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AF941C6A;
	Fri, 20 Dec 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734701649; cv=none; b=jghU88Jg9fcTQe+CUB1l1cpbvn3PUTVgyaTPnABfE8Lx1COaKvbtyKoXlBpoVnIf0iU1w11SZlCGGFoQNBTHj11zxeQ6VBiE3V5BiPJawKIrc0K68bAiCssSrzQtNAnx/2ebLLCjWFGOmVGO2AlBhzbgWWZEE0ghtIZBv7So86g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734701649; c=relaxed/simple;
	bh=j/kB8DHw+xBUuVqGMVQlKeXR6DbmoiO1yPO8uRLsOqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvZ6W5AOd4WZAhErfv7y1De4808PGTQPAInIhExoxFM4SVcRmQwRv4RwpfiBWJLQhKdt1cxP99kOxT1oJ9l3zQzpw4VEX1j9Tu6f3mbejoH8tbYoR4uX9/eBzZC3RcjiqxFZa6pN2STK115qkkAN9lz1RMHwrT8C/BQiv4qqWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oC6KlHlW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oC6KlHlW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6TrEmfPrxKppPES4ihtmmw0WrFcMWP7hyGiyfnc0OVY=; b=oC6KlHlWIj32L9n75v3bxGlMoj
	ZdWNJ2SchNPWyEZG8Q9+JKbEC/7YNspC2a8v4Q94bB3ZIW9ihyeWg12Bf0yfL2xdDtHSsG0dKTMBU
	BMLtGXbhglr4CfuPcF7rBXAQqJ6ou0Ffgd7mMpRfC+igNMfvw6Yv4dS1+Y/rcOqSd+z+9cdxNrqZL
	aj93xtb+faIm4fTDs8cM5xZ3bWE5R5szecI8yJ1ZCRAfVbOX4uwzVHtiTFoRZ0l3Fbsj47jEP0U38
	ISojZ/7X1ht4E8g8T8QeJA4SUlOPULsu/RDsuBwFJOrGnBZ3MNChf7aes0tWHOL2Kt4stIbD7IPuJ
	aZDZcODQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOd8h-00000000odd-3kSN;
	Fri, 20 Dec 2024 13:34:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 415AE3003FF; Fri, 20 Dec 2024 14:33:59 +0100 (CET)
Date: Fri, 20 Dec 2024 14:33:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] events/core: fix acoount failure for event's
 total_enable_time
Message-ID: <20241220133359.GC17537@noisy.programming.kicks-ass.net>
References: <20241220100202.804062-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220100202.804062-1-yeoreum.yun@arm.com>

On Fri, Dec 20, 2024 at 10:02:02AM +0000, Yeoreum Yun wrote:
> The perf core code fails to account for total_enable_time of event
> when its state is inactive.
> 
> Here is the error case for failure to account for total_enable_time for
> core event:
> 
> sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
> ...
> armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
> armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
                                        ^^^^^

So *that* number is wrong and should have been equal to the number above
it.

> 
>  Performance counter stats for 'stress-ng --pthread=2 -t 2s':
> 
>      1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
>      1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)
> 
> Since above two events are belong to the same task context and
> mutually-exclusive per cpu (they couldn't be active at the same time on the same cpu),
> the total_enable_time should be the same (the 2nd number among 3 numbers)
> and the summation of ratio should be 100%.

So the enable_time for the second event is too low, meaning the ratio
hsould have been ~15% rather than ~43%.

/me goes try and congest the wall of text below for more clues :/

> This account failure of total_enable_time for event could happen in below sequence.
> 
> 1. two event opened with:
>    - first event (e0) is opened with pmu0(p0) which could be added on CPU0.
>    - second event (e1) is opened with pmu1(p1) which could be added on CPU1.
>    - these two event belongs to the same task_ctx.
> 
>    at this point:
>      task_ctx->time = 0
>      e0->total_enable_time = 0
>      e0->total_running_time = 0
>      e1->total_enable_time = 0
>      e1->total_running_time = 0
> 
> 2. the task_ctx is sched in CPU0.
>    - In ctx_sched_in(), the task_ctx->time doesn't updated.
>    - In event_sched_in() e0 is activated so, its state becomes ACTIVE.
>    - In event_sched_in() e1 is activated, but soon becomes !ACTIVE
>      because pmu1 doesn't support CPU1 so it failed in pmu1->add().

This doesn't make sense; e1 should never reach event_sched_in() and it
should already be INACTIVE.

Notable events are created INACTIVE when !attr->disabled.

Also, scheduling should not get beyond merge_sched_in()'s
event_filter_match(), which will find the CPU is a mismatch and stop
right there.

This also means the event (e1) does not get to go on flexible_active
(see below).

> 
>    at this point:
>      task_ctx->time = 0
>      e0->total_enable_time = 0
>      e0->total_running_time = 0
>      e1->total_enable_time = 0
>      e1->total_running_time = 0

Both have the same state, surely that could've been compressed somewhat.

/me deletes giant wall of text

> 7. the task exit and task_ctx is sched out. and suppose scheulded time as t3.
>    - In ctx_sched_out(), the task_ctx->time updated with t1 + t2 + t3.
>    - e0 was ACTIVE, so In event_sched_out(),
>      e0->total_enable_time and e1->total_running_time are updated with t3.
>    - e1 was !ACTIVE, so it doesn't update
>      e1->total_enable_time and e1->total_running_time.
> 
>    at this point:
>      task_ctx->time = t1 + t2 + t3
>      e0->total_enable_time = t1 + t2 +t3
>      e0->total_running_time = t1 + t3
>      e1->total_enable_time = t1 + t2
>      e1->total_running_time = t2
> 
> In step 7, amount of t3 enable time is missing in e1.
> So, the perf prints error ratio for total_running_time/total_enable_time
> for e1.
> 
> Here is the summary of change of time as timeline:
> 
>                CPU0                  CPU1                     CPU0
>           |  in | out |       | in | out     |       | in      | out (exit)   |
> ------------------------------------------------------------------------------
> ctx->time |  0  | t1  |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2 + t3 |
> ------------------------------------------------------------------------------
> e0->ena   |  0  | t1  |       | t1 | t1     *|       | t1 + t2 | t1 + t2 + t3 |
> ------------------------------------------------------------------------------
> e0->run   |  0  | t1  |       | t1 | t1      |       | t1 + t2 | t1 + t3      |
> ------------------------------------------------------------------------------
> e1->ena   |  0  | 0  *|       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2  XXX |
> ------------------------------------------------------------------------------
> e1->run   |  0  | 0   |       | 0  | t2      |       | t1 + t2 | t2           |
> ------------------------------------------------------------------------------

So just the table is fine (better even than this giant wall of text),
but you have to explain what's what. Eg, there is no clear progression,
and having two columns both labeled CPU0 is highly confusing.

Also, a visual indication of where the error happens is useful. So the
cell marked with XXX is the failure case, right, that's missing '+ t3'.

Except then you should also mark those I stuck a * on.

> To address this, update total_enable_time in event_sched_out() when event state
> is PERF_EVENT_STATE_INACTIVE.

This is a giant jump that I'm not following. Notably ctx_sched_out()
will only iterate pmu_ctx->{pinned,flexible}_active and that list should
only include ACTIVE events.

So how does handling INACTIVE in event_sched_out() even begin to help?

Additionally, where does perf-stat get those numbers from; because
afaict perf_event_read() will do perf_event_update_time() and you should
be getting the correct numbers, no?

I'm utterly lost in the perf-stat code :-( Also it appears I can't even
build tools/perf anymore :-(

> After this patch, this problem is gone like:

Yes, but why? Something smells.

Looking at group_sched_in(), I'm thinking that that STATE_OFF thing is
totally wrong, should that not be something like:

	if (group_event->state <= PERF_EVENT_STATE_OFF)
		return -EBUSY;

or something !0 at any rate.


So what path leads to event_sched_out() with !ACTIVE that's relevant
here?

It can't have geen that group_sched_out(), because that wasn't in your
first patch.

How is this a fix and why is it the right fix?


