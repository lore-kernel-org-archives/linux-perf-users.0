Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BB2C3265;
	Tue, 12 Aug 2025 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985427; cv=none; b=WQ3uNOqWM1jEegOU+uqA20pMrf9+tFa0J8XrsOuPYJ9gjer+9mBCjEed2XtvEk2MaJ5tbR2SWe4fMTnD3SXpEU/DmShS1PiH//P9Mmtkrmne+kOaLbU2Oi/wmwv8fCByueSDVX9o0AJb9Drxp7VIf75FgsOrroChCrxFFU8dJfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985427; c=relaxed/simple;
	bh=uND59x9ZQ5rkqPTf5MVpzM2uV3BtQWtHn7hG4Nn7W54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZStd5s7tQyCOxeDKfKOIpPVPpdlCNYzr2OLbwQrSYPfZSaIq7eHLtvxzp+6g81QmnFvayKk16jsG/JWnTvzMhiZW0BZ5nioA7CFAp5DSS6T2aLUoL3UI/mFZI17HQ/AgXCFnEGFQnNIOy3dpx8lS3m4ddVF/c1CMRDWoeek4FA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n38cBToB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n38cBToB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xFzUS7aI0hvY4j9wtcgEliFgmjU3wq4f3XK0sCbKOPY=; b=n38cBToBaEhHuXspah2SPNjIMU
	EEugFiYSXEKxezGCVOK+gY9KGRtUQeIuB5RecgDax/hlt9Zw0apZ0dQoVk2+t/P9R/XiX97vi0J7x
	NPeawwhdnvVGNj+TxMa+gFz6a7ceCUQj+oMhGH4PjZd6Q4/qtQLt2zosZpV1lv+Io4u/NSyeJm6AD
	LAHds1atVaPw1SRccOr3Ja7YseBtRA0JGORrBuqNOJK0rJAz50bbFqGkmC82OIYWLmMVjnTlpWyD4
	E1rndUbqd+CfDUEy9tRxqmUp81imHFkKcPoWfEXcTGcWsjwB/KHi6oSreyqAQz0tMtSGlgEbtxw1E
	tiJKDFrg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uljsO-0000000E7eN-2fF3;
	Tue, 12 Aug 2025 07:56:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 56FD53002D4; Tue, 12 Aug 2025 09:56:56 +0200 (CEST)
Date: Tue, 12 Aug 2025 09:56:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
	Austin Kim <austindh.kim@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: [PATCH v2] perf: Avoid undefined behavior from stopping/starting
 inactive events
Message-ID: <20250812075656.GE4067720@noisy.programming.kicks-ass.net>
References: <20250812012722.127646-1-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812012722.127646-1-ysk@kzalloc.com>

On Tue, Aug 12, 2025 at 01:27:22AM +0000, Yunseong Kim wrote:
> Calling pmu->start()/stop() on events in PERF_EVENT_STATE_OFF can leave
> event->hw.idx at -1, which may lead to UBSAN shift-out-of-bounds reports
> when the PMU code later shifts by a negative exponent.

Yeah, but how do we get there? I suppose there is a race somewhere?
Please describe.

> Move the state check into perf_event_throttle()/perf_event_unthrottle() so
> that inactive events are skipped entirely. This ensures only active events
> with a valid hw.idx are processed, preventing undefined behavior and
> silencing UBSAN warnings.
> The problem can be reproduced with the syzkaller reproducer:
> Link: https://lore.kernel.org/lkml/714b7ba2-693e-42e4-bce4-feef2a5e7613@kzalloc.com/
> 
> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> ---
>  kernel/events/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8060c2857bb2..c9322029a8ae 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2665,6 +2665,9 @@ static void perf_log_itrace_start(struct perf_event *event);
>  
>  static void perf_event_unthrottle(struct perf_event *event, bool start)
>  {
> +	if (event->state <= PERF_EVENT_STATE_OFF)
> +		return;

This seems wrong. We should only {,un}throttle ACTIVE events, no?

>  	event->hw.interrupts = 0;
>  	if (start)
>  		event->pmu->start(event, 0);
> @@ -2674,6 +2677,9 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
>  
>  static void perf_event_throttle(struct perf_event *event)
>  {
> +	if (event->state <= PERF_EVENT_STATE_OFF)
> +		return;
> +
>  	event->hw.interrupts = MAX_INTERRUPTS;
>  	event->pmu->stop(event, 0);
>  	if (event == event->group_leader)
> -- 
> 2.50.0
> 
