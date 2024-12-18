Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6151B19ABD4;
	Wed, 18 Dec 2024 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521618; cv=none; b=AFSFi74rC9WDSqKdWJSczsqhiMzScGDrMu7vbV1lL+38+jZzUgePUepJEV68ts9wHECiFZUbi7oJ5WIFQEWjimPd+cfDjGQB46eU6wMvTZpC747KdVW6NbfNHn6MaeTmShklKhGsdPucNx9R3XyjRL/u0NgnexfUQ5WMe/o5RrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521618; c=relaxed/simple;
	bh=2b5TU0cXJ+74NZ5c4maRkiE2EAu3rheZbCFzyTJUHFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5T6UTqXiujS68/KxlXwoRJTSqKouoVPCYcO8vhkuG9NUm/heRHDIYFPhIGYO4jpDGT7PIYvYZplfNsVjPZ9rp9PN9i5Q/q/8FzaJweLrCw1mL2yB7hBJ0S+XpMVb5jujh9mJKMhQ9okzk8nxBYVIboQktSyielz8HP6sy39KAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2729FEC;
	Wed, 18 Dec 2024 03:34:03 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66DDC3F7B4;
	Wed, 18 Dec 2024 03:33:33 -0800 (PST)
Date: Wed, 18 Dec 2024 11:33:27 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, mingo@redhat.com, acme@kernel.org,
	amhyung@kernel.org, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	nd@arm.com
Subject: Re: [PATCH 1/1] events/core: fix error run/enable ratio display
Message-ID: <Z2KzB_xQb7-DQ_Js@J2N7QTR9R3>
References: <20241218084656.609764-1-yeoreum.yun@arm.com>
 <20241218104255.GE2484@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218104255.GE2484@noisy.programming.kicks-ass.net>

Hi Peter, Levi,

On Wed, Dec 18, 2024 at 11:42:55AM +0100, Peter Zijlstra wrote:
> 
> git log --oneline kernel/events/core.c 
> 
> Compare result with your subject.
> 
> On Wed, Dec 18, 2024 at 08:46:56AM +0000, Yeoreum Yun wrote:
> > when runs below command (with core pmu) sometime perf prints error
> > ratio for each perf.
> > 
> > sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
> > ...
> > armv8_pmuv3_0/event=0x08/: -1: 1081702126 2289429840 2174835740
> > armv8_pmuv3_1/event=0x08/: -1: 794080238 1950025700 847648440
> > armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
> > armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
> > 
> >  Performance counter stats for 'stress-ng --pthread=2 -t 2s':
> > 
> >      1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
> >      1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)
> 
> At this point I've no idea what the error is. You start by saying there
> is an error, but then give no clue.

I *think* what this was trying to say is along the lines of:

  The perf core code fails to account for some time that an event is
  inactive. This can be seen by opening two mutually-exclusive events,
  whose active ratios should add to at most 100%, e.g.

  | sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
  |   ...
  |   armv8_pmuv3_0/event=0x08/: -1: 1081702126 2289429840 2174835740
  |   armv8_pmuv3_1/event=0x08/: -1: 794080238 1950025700 847648440
  |   armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
  |   armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
  |   
  |    Performance counter stats for 'stress-ng --pthread=2 -t 2s':
  |   
  |        1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
  |        1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)
  | 
  | ... where the active ratios add to 138.46%, which is clearly wrong.
  | 
  | [ explanation of the reason for this, etc ]

Note: I haven't looked into the code in detail, so the above might be
wrong.

Levi, how about we have a chat offline about how to make this a bit
clearer? I'll be in the office later today.

Mark.

> > This happens because of missing total_enable_time of inactivate event.
> > it's enabled time doesn't update at the event_sched_out() because state
> > isn't PERF_EVENT_STATE_ACTIVE but PERF_EVENT_STATE_INACTIVE.
> 
> time tracking doesn't happen at sched calls -- you'll find a grand total
> of 0 perf_event_update_time() calls in them.
> 
> Also, things like group_sched_out() don't even call into
> event_sched_out() when !ACTIVE.
> 
> So why is event_sched_out() the right place to change here?
> 
> Also, I've still no clue under what condition all this is supposed to
> have happened :/
> 
> > For example, Suppose there're two events:
> >     e0: with pmu0 which supports only cpu0
> >     e1: with pmu1 which supports only cpu1.
> > then
> > 
> >                CPU0                  CPU1                     CPU0
> >           |  in | out |       | in | out     |       | in      | out (exit)   |
> > ------------------------------------------------------------------------------
> > ctx->time |  0  | t1  |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2 + t3 |
> > ------------------------------------------------------------------------------
> > e0->ena   |  0  | t1  |       | t1 | t1      |       | t1 + t2 | t1 + t2 + t3 |
> > ------------------------------------------------------------------------------
> > e0->run   |  0  | t1  |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t3      |
> > ------------------------------------------------------------------------------
> > e1->ena   |  0  | 0   |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2      |
> > ------------------------------------------------------------------------------
> > e1->run   |  0  | 0   |       | 0  | t2      |       | t1 + t2 | t2           |
> > ------------------------------------------------------------------------------
> > 
> > at the CPU0, state of e1 is PERF_EVENT_STATE_INACTIVE since it doesn't
> > support on CPU0. So when event_sched_out() it failed to update its
> > total_enable_time and it makes error print of run/ena ratio.
> 
> Sorry, I have no idea what you're saying. I can't relate the table to
> the text in any meaningful way.
> 
