Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205802F7F02;
	Mon, 28 Sep 2026 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584388; cv=none; b=jQBsGH16MadSVRLRJOoQg+RM/VzwAjTz5vX68YRQBdk2S9O5Dof3ceze/u7BL7GVb6/62SHWhDLwE26TJca7Q5ItzZsqpioyPvE0FPxVXmw8c3si54tP5LO4UOwWdtH5GhlsXBO5XNnPQbJYJeUFc4VlnfOCqgUfsh1SzjVwwOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584388; c=relaxed/simple;
	bh=0RpbMTfn+gvvZIjyJ2+TQQ0qDMnKXcFVGLXk6A3d0UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUQwFyC3t2Zn6ku1VLoEwrH9Js/vmzndZkz7bkUG5VrILgHF6X21ipAZhN1S72P+w2hnMagb2C3dggrnD+xy3Ll41CbxWeQapbA6LQE7T5+askmCDhZlWaxUiNPEu1tfzczxiOmb5QRpHZ2ix787UnLRSSup0bjKzT/OnU94utc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TTDVUvqi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TTDVUvqi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D7631570;
	Mon, 28 Sep 2026 01:33:03 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 123093F86F;
	Mon, 28 Sep 2026 01:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790584386; bh=0RpbMTfn+gvvZIjyJ2+TQQ0qDMnKXcFVGLXk6A3d0UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTDVUvqi1Ach8JNeWYAQJzsHxtfM+Zm7SeLtsWf7onhpa9/BLw9LzQDp+q8Mgqvmm
	 5TL8sQbTz+WRHPda5DtK4ix6y58CAOCtq/ODuXOb0MtDTXpec5/yVd+rCIo1kSob7r
	 8NkR4SRjZX0TqJaR2hdy0syFhhkwn7nthkuBHaBM=
Date: Mon, 28 Sep 2026 09:33:03 +0100
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko AI <sashiko-bot@kernel.org>
Subject: Re: [PATCH] perf/core: Fix ITRACE start suppression for inherited
 events
Message-ID: <20260928083303.GA14479@e132581.arm.com>
References: <20260903-perf_core_itrace_start_fix_inherit_event-v1-1-6bff7e675af5@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-perf_core_itrace_start_fix_inherit_event-v1-1-6bff7e675af5@arm.com>

On Thu, Sep 03, 2026 at 10:35:12AM +0100, Leo Yan wrote:
> PMU drivers call perf_event_itrace_started() for the event that has
> started tracing. This sets PERF_ATTACH_ITRACE in that event's
> attach_state.
> 
> For inherited events, however, perf_log_itrace_start() replaces the
> child event with its parent before checking PERF_ATTACH_ITRACE. The
> setter and checker therefore operate on different events. If the
> parent's flag is clear, the child continues to emit ITRACE_START
> records on subsequent schedule-ins. If the parent has already started,
> its flag can instead suppress the child's initial record.
> 
> Remove the parent substitution so that perf_log_itrace_start() checks
> the same event that the PMU driver marks as started.
> 
> This is safe for tool consumers. Intel PT uses the ITRACE_START record
> to set the current thread context. CoreSight ETM uses the record only
> to find or create the corresponding thread. Neither decoder depends on
> the parent event.
> 
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/20260901164705.042781F000E9@smtp.kernel.org/
> Fixes: 9a6694cfa239 ("perf/x86/intel/pt: Do not force sync packets on every schedule-in")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Gentle ping ...

> ---
>  kernel/events/core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a311042afab6b65814a84c67b87ba929b..991ae214d46ebe8b0d9de497255f25a4ad12397f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10572,9 +10572,6 @@ static void perf_log_itrace_start(struct perf_event *event)
>  	} rec;
>  	int ret;
>  
> -	if (event->parent)
> -		event = event->parent;
> -
>  	if (!(event->pmu->capabilities & PERF_PMU_CAP_ITRACE) ||
>  	    event->attach_state & PERF_ATTACH_ITRACE)
>  		return;
> 
> ---
> base-commit: 940de590b839f71d6dc846160534bf202401b8b7
> change-id: 20260903-perf_core_itrace_start_fix_inherit_event-a8930d792899
> 
> Best regards,
> -- 
> Leo Yan <leo.yan@arm.com>
> 
