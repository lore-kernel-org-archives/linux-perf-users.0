Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC17184;
	Mon, 22 Dec 2025 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766446616; cv=none; b=bhPukCWe5u2OAc38/cOGdScIiWmwBBZ/RD0Q/VSFRZezjwZQ49Zg/cBXaPe+d/nzIqdKnLgBlfcETYyhILNRHT/ksOilzSy6EQfcxM0uZIudhk12b3XU1CQvdqOMBw4yQ1qF8r2lnldQjISYEeOzpWY3u/Y3NiXRqQdF9Dlfs1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766446616; c=relaxed/simple;
	bh=5QgQBnax4toZ9nNutUR0ZqylE5Y19pZddGkWLd2TJQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGpdELtrNrj9mhlipoXM1D3CvmgH1CjGniGOHH1b+/9YZ/SOf3DIkca7xZlt68sYyJ4A+qWO6E280AaMQyKtjqSHKXKktAW5NwNkXFGjWYo+ZepT99bNgtqNjWevIDzsTzMjD8yWZgYp+GR4s+zfLDFFMuFsunJjP+s/vYavbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7BWNZQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7BWNZQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58465C4CEF1;
	Mon, 22 Dec 2025 23:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766446615;
	bh=5QgQBnax4toZ9nNutUR0ZqylE5Y19pZddGkWLd2TJQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7BWNZQLgrkIqHTg0bWjGf4MNQAYLQD8fipY1BPkHQrdv/w4AEvLLmw1KmniAh6aN
	 AIxIixg29xkCx3ypOtdPZbebmZiRultYcIDmlY9UPMialAmaxXCiPuet5Fe40Bm6Xd
	 7HqC5EJJEVg+x5thDz2a0JVzaQRQLVgqxn/ImPSVQG8lAgKAfI9oN53ZHx1FsbiQ5u
	 NZOETa5x495MPXg2+tUH61z9wZDhLlgjWk37zEcBjkEdDtkXHFi6aChKGcyuu/ETMm
	 Jl3lIK3z3Aq+Mil2LhT7XzA6VQ7B4VrFauJLL0PNo4+7OsgXUpGpdm/EgkXJ4S1v22
	 hKQId7LcFHaWg==
Date: Mon, 22 Dec 2025 15:36:53 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] perf/core: Task stuck on global_ctx_data_rwsem
Message-ID: <aUnWFc_mILUDFavi@google.com>
References: <aUnVfxDtLNUDJM_v@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aUnVfxDtLNUDJM_v@google.com>

Added a subject prefix and CC LKML.

Thanks,
Namhyung

On Mon, Dec 22, 2025 at 03:34:23PM -0800, Namhyung Kim wrote:
> Hello,
> 
> I got a report that a task is stuck in perf_event_exit_task() waiting
> for global_ctx_data_rwsem.  On large systems, it'd have performance
> issues when it grabs the lock to iterate all threads in the system to
> allocate the context data.  And it'd block task exit path which is
> problematic especially under memory pressure.
> 
>   perf_event_open
>     perf_event_alloc
>       attach_perf_ctx_data
>         attach_global_ctx_data
>           percpu_down_write (global_ctx_data_rwsem)
>             for_each_process_thread
>               alloc_task_ctx_data
>                                                do_exit
>                                                  perf_event_exit_task
>                                                    percpu_down_read (global_ctx_data_rwsem)
> 
> I think attach_global_ctx_data() should skip tasks with PF_EXITING and
> it'd be nice if perf_event_exit_task() could release the ctx_data
> unconditionally.  But I'm not sure how to synchronize them properly.
> 
> Any thoughts?
> 
> Thanks,
> Namhyung
> 
