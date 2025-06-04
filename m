Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38F528FFCB;
	Wed,  4 Jun 2025 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048909; cv=none; b=ICwpzzsJldL5Ya37/JhvZT4V5TM2NMNzu5iBo85Yqr8oGbAPzf/wd544c98hIlO8R3n6iPFQNkqR3TucLgc4wb18y9DI8R89Q5rr74xvnY0Z6uhYP5NG6t3inQgzr5Q3dHLHGiFlthRatEjbx2TbCqnhxMdAy8sEppHIcQWTDpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048909; c=relaxed/simple;
	bh=HOlvILzQbzz5g/GGLiJxW+I2MtTR7FvGq/Gxnu+WYDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAEETUyZg56riBWVkFKPxKgf6xDk7jCwt7KXvHe3mlxquc+k+gN54diZ33GmX1pzgCGdJMoVnAkjpd7P/ZhwV8koctUyAWNmKi/D9u8EJZReYvZoXGP+ApjJHxuzhK4d0g80jN6F4P29KSlXbRrPHZjGh9iRneaIfr2GHIkjflQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6D3D1758;
	Wed,  4 Jun 2025 07:54:49 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38F4D3F59E;
	Wed,  4 Jun 2025 07:55:04 -0700 (PDT)
Date: Wed, 4 Jun 2025 15:55:01 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Baisheng Gao <baisheng.gao@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"reviewer:PERFORMANCE EVENTS SUBSYSTEM" <kan.liang@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
	cixi.geng@linux.dev, hao_hao.wang@unisoc.com
Subject: Re: [PATCH] perf/core: Handling the race between exit_mmap and perf
 sample
Message-ID: <aEBeRfScZKD-7h5u@J2N7QTR9R3>
References: <20250424025429.10942-1-baisheng.gao@unisoc.com>
 <aEBSt2LN7YhxYX7N@J2N7QTR9R3>
 <20250604142437.GM38114@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604142437.GM38114@noisy.programming.kicks-ass.net>

On Wed, Jun 04, 2025 at 04:24:37PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 04, 2025 at 03:05:43PM +0100, Mark Rutland wrote:
> 
> > Loooking at 5.15.149 and current HEAD (5abc7438f1e9), do_exit() calls
> > exit_mm() before perf_event_exit_task(), so it looks
> > like perf could sample from another task's mm.
> > 
> > Yuck.
> > 
> > Peter, does the above sound plausible to you?
> 
> Yuck indeed. And yeah, we should probably re-arrange things there.
> 
> Something like so?

That should plumb the hole for task-bound events, yep.

I think we might need something in the perf core for cpu-bound events, assuming
those can also potentially make samples.

From a quick scan of perf_event_sample_format:

	PERF_SAMPLE_IP			// safe
	PERF_SAMPLE_TID			// safe
	PERF_SAMPLE_TIME		// safe
	PERF_SAMPLE_ADDR		// ???
	PERF_SAMPLE_READ		// ???
	PERF_SAMPLE_CALLCHAIN		// may access mm
	PERF_SAMPLE_ID			// safe
	PERF_SAMPLE_CPU			// safe
	PERF_SAMPLE_PERIOD		// safe
	PERF_SAMPLE_STREAM_ID		// ???
	PERF_SAMPLE_RAW			// ???
	PERF_SAMPLE_BRANCH_STACK	// safe
	PERF_SAMPLE_REGS_USER		// safe
	PERF_SAMPLE_STACK_USER		// may access mm
	PERF_SAMPLE_WEIGHT		// ???
	PERF_SAMPLE_DATA_SRC		// ???
	PERF_SAMPLE_IDENTIFIER		// safe
	PERF_SAMPLE_TRANSACTION		// ???
	PERF_SAMPLE_REGS_INTR		// safe
	PERF_SAMPLE_PHYS_ADDR		// safe; handles mm==NULL && addr < TASK_SIZE
	PERF_SAMPLE_AUX			// ???
	PERF_SAMPLE_CGROUP		// safe
	PERF_SAMPLE_DATA_PAGE_SIZE	// partial; doesn't check addr < TASK_SIZE
	PERF_SAMPLE_CODE_PAGE_SIZE	// partial; doesn't check addr < TASK_SIZE
	PERF_SAMPLE_WEIGHT_STRUCT	// ???

... I think all the dodgy cases use mm somehow, so maybe the perf core
should check for current->mm?

> 
> ---
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 38645039dd8f..3407c16fc5a3 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -944,6 +944,15 @@ void __noreturn do_exit(long code)
>  	taskstats_exit(tsk, group_dead);
>  	trace_sched_process_exit(tsk, group_dead);
>  
> +	/*
> +	 * Since samping can touch ->mm, make sure to stop everything before we

Typo: s/samping/sampling/

> +	 * tear it down.
> +	 *
> +	 * Also flushes inherited counters to the parent - before the parent
> +	 * gets woken up by child-exit notifications.
> +	 */
> +	perf_event_exit_task(tsk);
> +
>  	exit_mm();
>  
>  	if (group_dead)
> @@ -959,14 +968,6 @@ void __noreturn do_exit(long code)
>  	exit_task_work(tsk);
>  	exit_thread(tsk);
>  
> -	/*
> -	 * Flush inherited counters to the parent - before the parent
> -	 * gets woken up by child-exit notifications.
> -	 *
> -	 * because of cgroup mode, must be called before cgroup_exit()
> -	 */
> -	perf_event_exit_task(tsk);
> -
>  	sched_autogroup_exit_task(tsk);
>  	cgroup_exit(tsk);
>  

Otherwise, that looks good to me!

Mark.
