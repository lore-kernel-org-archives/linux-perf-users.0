Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DBD2F691D;
	Tue,  9 Dec 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765273136; cv=none; b=AFq2OfsJ4GuuNqLnlV/R/y+qp7fE7osC+e7FTDOOsnR7Ds4teIZ5IyrBrRx2fMJULpVCd08rR+j6BEdZ72e+p03XPlEHy+B3JS67jUZUXmDm0Ogoj1PUDxjjcVS8Zs8GzyI/saZ3Q2tcuh6l/IT3cAA488E+HvNrhyHRSg4YfXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765273136; c=relaxed/simple;
	bh=l343WGoBCGxuw1w6kVcEJnvXKrhscvAS//dntrt37II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rk6VA6NBJuqDIXUK3g9oSnl6hRovlI6FWL7T0OXcsaO8XOkj4TTG4K3ZQ8OmWOADq2a1yqrOJTVTcD4rvAA2BhGKFZOaKPm57zMccvOllr++vydO4vvxvPeHuExcNvRcONr6pZQJgL3InhrT2EOVZzVjXF04CYYy8tE7h09Fb+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JpEwfp4E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JpEwfp4E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IA9vbhctquU1+roJTvFyfy6IXlfcAxQIeJiu52IUJaY=; b=JpEwfp4EfbxW/mDaCmw8PQGxiP
	s+zTGxu1aW9pEtaW1+nrB+TwMlL3aOSNFtcJ8qHV3P+2aqu0M4l3LynkNHJNmUCHvSpcpdbZTHtHV
	0Gt+k8ggYKnXmUHsOe1bOzv1C+ItgH+TVpAAf5DtiA64qKhx+XdAz6XzH8jiJc2DrcVsCCbvyIe6W
	Ir2wmlZa+/zWGzoIH7rvdY5VqEznz2c5Qz9DCRpltoqJs8R9Cf117foqlVg5vbkF9+soyGA+sN8c9
	BysdcMuSmeW2zcVT8IHsUiZoG/g2avUfx3R5WhrGPrl+D+pTY+wdw5ZrHE/x+N2dNCl4A9FS8rtUi
	xZ5Cl2Mw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSuBA-0000000B1fA-0Dxr;
	Tue, 09 Dec 2025 09:38:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9D9E730045C; Tue, 09 Dec 2025 10:38:43 +0100 (CET)
Date: Tue, 9 Dec 2025 10:38:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thaumy Cheng <thaumy.love@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] perf/core: Fix missing read event generation
 on task exit
Message-ID: <20251209093843.GI3707891@noisy.programming.kicks-ass.net>
References: <20251209041600.963586-1-thaumy.love@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209041600.963586-1-thaumy.love@gmail.com>

On Tue, Dec 09, 2025 at 12:16:00PM +0800, Thaumy Cheng wrote:
> For events with inherit_stat enabled, a "read" event will be generated
> to collect per task event counts on task exit.
> 
> The call chain is as follows:
> 
> do_exit
>   -> perf_event_exit_task
>     -> perf_event_exit_task_context
>       -> perf_event_exit_event
>         -> perf_remove_from_context
>           -> perf_child_detach
>             -> sync_child_event
>               -> perf_event_read_event
> 
> However, the child event context detaches the task too early in
> perf_event_exit_task_context, which causes sync_child_event to never
> generate the read event in this case, since child_event->ctx->task is
> always set to TASK_TOMBSTONE. Fix that by moving context lock section
> backward to ensure ctx->task is not set to TASK_TOMBSTONE before
> generating the read event.
> 
> Because perf_event_free_task calls perf_event_exit_task_context with
> exit = false to tear down all child events from the context, and the
> task never lived, accessing the task PID can lead to a use-after-free.
> 
> To fix that, let sync_child_event read task from argument and move the
> call to the only place it should be triggered to avoid the effect of
> setting ctx->task to TASK_TOMESTONE, and add a task parameter to
> perf_event_exit_event to trigger the sync_child_event properly when
> needed.
> 
> This bug can be reproduced by running "perf record -s" and attaching to
> any program that generates perf events in its child tasks. If we check
> the result with "perf report -T", the last line of the report will leave
> an empty table like "# PID  TID", which is expected to contain the
> per-task event counts by design.
> 
> Fixes: ef54c1a476ae ("perf: Rework perf_event_exit_event()")
> Signed-off-by: Thaumy Cheng <thaumy.love@gmail.com>
> ---

>  kernel/events/core.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 177e57c1a362..618e7947c358 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2316,7 +2316,8 @@ static void perf_group_detach(struct perf_event *event)
>  	perf_event__header_size(leader);
>  }
> 
> -static void sync_child_event(struct perf_event *child_event);
> +static void sync_child_event(struct perf_event *child_event,
> +			     struct task_struct *task);

This forward declaration can be entirely removed now.

Other than that, yes this seems fine. I see Ingo already picked up the
patch, thanks!
