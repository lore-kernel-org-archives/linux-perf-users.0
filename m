Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B32C3264;
	Fri, 15 Aug 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755255381; cv=none; b=fT38TkK0lN6A/GzgFUawFhKTaqof/Bd0/Rno4xLpeo3sQyITI+vbfTT0fqLyaq8eSwmrxqfbiu898PheNoXA5KJf3Rc9sy7KvF4vqbHyk9WfR5PeHUyr1tXbRzxfGJte1W+covJ5UHiZWAfvzQc9yomU4gVNWYsPW7oTnAxk27k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755255381; c=relaxed/simple;
	bh=tzXbTWV8qNFqQb2QpXq90iV5Cbg9kO1VG9m6vpVQ65U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgRqYoNPSMX3etW9l0NiAf41eD/Equ4J0td7HI+bpBAWeQ7QnZQJ5GAn3ySCuuzc0eRFHMaa2ZcUpb4+Ov99tLb5wGZOoE8lUlJKzIOv7ZHahGXenvy9Ce496VDdah15bzY1A0WJ0T7xJ2D3W7n0td6rltWXGF4wFkf8U463v8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LMQpZwT6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LMQpZwT6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I9wd9JD5yaWspOFUNaW5j2BV7yycEibPeUF2FP6pZ7w=; b=LMQpZwT6yw/fL2wv0AFCPtHWs0
	GrQ9WJEZJtI48c8epzwgaidC5KYSR732nI3AhY7lHDYs9i0Vkah8ng70rwmUuKSpwlBLOYqEi17ju
	656rA6NVfX8Ar0KW9QjXs+Erh26UaMMzlCrTSz3ZI4haiw7VqMrHp8vny9MmzyPOiMwbfCxbyk4IC
	46P7eqsbu11tsR+edLjyNmYyoch5Ktd6zyf3GMzgYRgz9nKlpsM72y1jnUmERldbuZISbftbxlAty
	As4diWfbDvxG+whcoplG6kujMwcXjt6dDst9uUAgYKDjOxzLamSN1V/vsxxJGIMJ2vHwcyXG/L6dd
	lqceHwyQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ums6Q-0000000Ggbl-32FU;
	Fri, 15 Aug 2025 10:56:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 57DB03002ED; Fri, 15 Aug 2025 12:56:05 +0200 (CEST)
Date: Fri, 15 Aug 2025 12:56:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Yunseong Kim <ysk@kzalloc.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
	Austin Kim <austindh.kim@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: [PATCH v3] perf: Avoid undefined behavior from stopping/starting
 inactive events
Message-ID: <20250815105605.GA3245006@noisy.programming.kicks-ass.net>
References: <20250812181046.292382-2-ysk@kzalloc.com>
 <922f69f6-e290-46f6-af6f-5a71e4508cf0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <922f69f6-e290-46f6-af6f-5a71e4508cf0@linux.intel.com>

On Tue, Aug 12, 2025 at 04:51:28PM -0700, Liang, Kan wrote:
> 
> 
> On 2025-08-12 11:10 a.m., Yunseong Kim wrote:
> > Calling pmu->start()/stop() on perf events in PERF_EVENT_STATE_OFF can
> > leave event->hw.idx at -1. When PMU drivers later attempt to use this
> > negative index as a shift exponent in bitwise operations, it leads to UBSAN
> > shift-out-of-bounds reports.
> > 
> > The issue is a logical flaw in how event groups handle throttling when some
> > members are intentionally disabled. Based on the analysis and the
> > reproducer provided by Mark Rutland (this issue on both arm64 and x86-64).
> > 
> > The scenario unfolds as follows:
> > 
> >  1. A group leader event is configured with a very aggressive sampling
> >     period (e.g., sample_period = 1). This causes frequent interrupts and
> >     triggers the throttling mechanism.
> >  2. A child event in the same group is created in a disabled state
> >     (.disabled = 1). This event remains in PERF_EVENT_STATE_OFF.
> >     Since it hasn't been scheduled onto the PMU, its event->hw.idx remains
> >     initialized at -1.
> >  3. When throttling occurs, perf_event_throttle_group() and later
> >     perf_event_unthrottle_group() iterate through all siblings, including
> >     the disabled child event.
> >  4. perf_event_throttle()/unthrottle() are called on this inactive child
> >     event, which then call event->pmu->start()/stop().
> >  5. The PMU driver receives the event with hw.idx == -1 and attempts to
> >     use it as a shift exponent. e.g., in macros like PMCNTENSET(idx),
> >     leading to the UBSAN report.
> > 
> > The throttling mechanism attempts to start/stop events that are not
> > actively scheduled on the hardware.
> > 
> > Move the state check into perf_event_throttle()/perf_event_unthrottle() so
> > that inactive events are skipped entirely. This ensures only active events
> > with a valid hw.idx are processed, preventing undefined behavior and
> > silencing UBSAN warnings. The corrected check ensures true before
> > proceeding with PMU operations.
> > 
> > The problem can be reproduced with the syzkaller reproducer:
> > Link: https://lore.kernel.org/lkml/714b7ba2-693e-42e4-bce4-feef2a5e7613@kzalloc.com/
> > 
> > Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> 
> Thanks for the fix.
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks both!
