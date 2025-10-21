Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75234B69A;
	Tue, 21 Oct 2025 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067143; cv=none; b=fmGWKFjKIz4r48zj0G7qJAMjTORzKe46wdSLuNiEIgxUF/UPK8BD9PZih8oI4pwiyNng/LyTMuZ1gnKXt/C/IAEWBWYd6PIXREkNm2YjIEjVl+Yp0SWMDgFPZijUvKJ/0BzQKtMaOZ3iQYKukIpNC5QnLJA7klenWHgZbqKSE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067143; c=relaxed/simple;
	bh=VqQpvww5/bfc5HRnT2W6/kK7doCRuXSbhiOxXfmOcZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUl4cYFE8CoYI6hQAWiYupas3Gblx1JafVG56BXqXuPeQ4naax9Le5FhfM/WRN0PQC4Of7aZa4I+XQJgigmnx7uoT5vPkImCeWaL+gEphjTb5j9m0XcFMs1fiIVDSy1p+Hsjhp9Q73yC7P/kFAlEAmVvhyoJnmiwnb37huUnoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fdtNtaiJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fdtNtaiJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pZqlg7NWx2eBUhWu5OH2HtZkdmQ7Q5RonVfRGAJCOoI=; b=fdtNtaiJ2KtUICUHyIHkrIhVgr
	XNMtJ0td3p9Cs93OMUzV00Ulf74sYHXDq37pHwX73x+T/XupjLwSpUkAjdvcyOVmbrje7eV30Y2L1
	a/vGkc4a5wX3btFSdesYJGznE0yCFUu6iFWYmW39NkK+c/nNC1QXBClZ5vSV/KvXNETCBmMKcdeAy
	8/TKUmHcKNkwWNx4kdDXuQyr6ylyGjiZX54tg5TFRyEGoBG0xL8JjaJLd/onYfJYNiAg861o+Us/z
	v+OcTKgj5iw/jjLRmR5NxSfGxV9qyYQQz40zMvX2nzlXA7lJQzVg8BdRL6hHuNOodEwVW+G8FD/gg
	BWTN3DhQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0c-0000000DsWh-1jzd;
	Tue, 21 Oct 2025 17:18:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 00CCE3031B4; Tue, 21 Oct 2025 16:47:51 +0200 (CEST)
Date: Tue, 21 Oct 2025 16:47:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Octavia Togami <octavia.togami@gmail.com>
Subject: Re: [PATCH] perf: Fix system hang caused by cpu-clock
Message-ID: <20251021144751.GQ3245006@noisy.programming.kicks-ass.net>
References: <20251015051828.12809-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015051828.12809-1-dapeng1.mi@linux.intel.com>

On Wed, Oct 15, 2025 at 01:18:28PM +0800, Dapeng Mi wrote:
> A system hang issue caused by cpu-clock is reported and bisection
> indicates the commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery
>  breakage") causes this issue.
> 
> The root cause of the hang issue is that cpu-clock is a specific SW
> event which relies on the hrtimer. The __perf_event_overflow()
> is invoked from the hrtimer handler for cpu-clock event, and
> __perf_event_overflow() tries to call event stop callback
> (cpu_clock_event_stop()) to stop the event, and cpu_clock_event_stop()
> calls htimer_cancel() to cancel the hrtimer. But unfortunately the
> hrtimer callback is currently executing and then traps into deadlock.
> 
> To avoid this deadlock, use hrtimer_try_to_cancel() instead of
> hrtimer_cancel() to cancel the hrtimer, and set PERF_HES_STOPPED flag
> for the stopping events. perf_swevent_hrtimer() would stop the event
> hrtimer once it detects the PERF_HES_STOPPED flag.
> 
> Reported-by: Octavia Togami <octavia.togami@gmail.com>
> Closes: https://lore.kernel.org/all/CAHPNGSQpXEopYreir+uDDEbtXTBvBvi8c6fYXJvceqtgTPao3Q@mail.gmail.com/
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Fixes: 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage")
> Tested-by: Octavia Togami <octavia.togami@gmail.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  kernel/events/core.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7541f6f85fcb..f90105d5f26a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11773,7 +11773,8 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
>  
>  	event = container_of(hrtimer, struct perf_event, hw.hrtimer);
>  
> -	if (event->state != PERF_EVENT_STATE_ACTIVE)
> +	if (event->state != PERF_EVENT_STATE_ACTIVE ||
> +	    event->hw.state & PERF_HES_STOPPED)
>  		return HRTIMER_NORESTART;
>  
>  	event->pmu->read(event);

I was wondering if we need a HES_STOPPED check after calling
__perf_event_overflow(), but typically that will return 1 when it does
the stop itself, which then already does NORESTART.

So yeah, I suppose this works. Let me go queue this up.

Thanks!
