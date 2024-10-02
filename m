Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0C15D1;
	Wed,  2 Oct 2024 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829723; cv=none; b=gPvQn0LLBgPBRttgTRao9QfoIDOd/rnPxxmpv94m5EVaxXz4IxEjVl2ocATqOjRgFa6Vr9de/J5HWMV8NnfJTcNhxJyn1BwdqZnq2KY6lCigS0381npMRQ0lADGVKPB+KpnsYbi9qD5rD4y6JvYsl7bagQkK+b2D8VUUJumIoSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829723; c=relaxed/simple;
	bh=+RVp6pHlr1w5dJ/N9mEdVSdi3GGzwhQj3H2kMDRoh4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7ggY92wiBPqQJsV3tydsEK2n3AP4gdXSv452Z7RXlOXQNQV6KKWcZARTUHr+XcUL+dQLZQE3/AM0tTCh/PBxHhNBavKUAeYg7PkwakpOLkqg6b+HfLz1sMbJ6LNARROkd5rK5amlHkd7cpbYQbRtYkAvvsGa8PZJD9IjZLuNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf3rOZN0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf3rOZN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6049C4CEC6;
	Wed,  2 Oct 2024 00:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727829723;
	bh=+RVp6pHlr1w5dJ/N9mEdVSdi3GGzwhQj3H2kMDRoh4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cf3rOZN0aasVv0TxNLdZ/6ovpK/bMs6tOPeXOAtEqk7xlH4GKEDfrEMkJ8EMz39iS
	 5v/ebGfZP1gei0SJ40qFHInsMOi3KVXNGqkxml99Bh/ymky1x8p+UUue142xsDE6OA
	 +cZToR5sF6nZUp02fGBfcO4PoiZ18dcLbzE9T4CXliGxE4MDrr7YK4XDhI0HxL/iIX
	 QpvgiatSBso1xJnT5X+JmS5K/+nggXI14p68vzuXqaggfc7hn4zZFTuWnFUD83zTAH
	 rsgNZhtvS80JkHGxfUnXOW39QtMBtA8lWl1lR9MDqf2V7sTcc9gIuZng/DZd1v8q60
	 2p4B/rKMT2TPg==
Date: Tue, 1 Oct 2024 17:42:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf sched timehist: Add pre-migration wait time
 option
Message-ID: <ZvyW2dXQxhxsJNWt@google.com>
References: <20241001110620.60602-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241001110620.60602-1-vineethr@linux.ibm.com>

On Tue, Oct 01, 2024 at 04:36:20PM +0530, Madadi Vineeth Reddy wrote:
> pre-migration wait time is the time that a task unnecessarily spends
> on the runqueue of a CPU but doesn't get switched-in there. In terms
> of tracepoints, it is the time between sched:sched_wakeup and
> sched:sched_migrate_task.
> 
> Let's say a task woke up on CPU2, then it got migrated to CPU4 and
> then it's switched-in to CPU4. So, here pre-migration wait time is
> time that it was waiting on runqueue of CPU2 after it is woken up.
> 
> The general pattern for pre-migration to occur is:
> sched:sched_wakeup
> sched:sched_migrate_task
> sched:sched_switch
> So, this option expects sched_wakeup also to be recorded and fails
> if attempted to use the option without sched:sched_wakeup tracepoint.
> 
> pre-migrations are generally not useful and it increases migrations.
> This metric would be helpful in testing patches mainly related to wakeup
> and load-balancer code paths as better wakeup logic would choose an
> optimal CPU where task would be switched-in and thereby reducing pre-
> migrations.
> 
> The sample output(s) when -P or --pre-migrations is used:
> =================
>            time    cpu  task name                       wait time  sch delay   run time  pre-mig time
>                         [tid/pid]                          (msec)     (msec)     (msec)     (msec)
> --------------- ------  ------------------------------  ---------  ---------  ---------  ---------
>   103032.721020 [0000]  perf[47206]                         0.000      0.000      0.000      0.000
>   103032.721034 [0000]  migration/0[18]                     0.000      0.003      0.013      0.000
>   103032.736716 [0001]  schbench[47229/47207]              10.664      9.231      0.039      9.170
>   103032.736719 [0005]  <idle>                              0.000      0.000     15.405      0.000
>   103032.736726 [0003]  schbench[47216/47207]              11.251      9.193      0.022      9.126
>   103032.736727 [0001]  schbench[47228/47207]              10.752      9.264      0.010      9.169
>   103032.736731 [0007]  <idle>                              0.000      0.000     15.314      0.000
>   103032.736739 [0008]  <idle>                              0.000      0.000     15.249      0.000
>   103032.736742 [0003]  schbench[47257/47207]               9.498      9.184      0.015      9.100
> 
>    51370.894024 [0012]  schbench[38775/38770]              21.047     21.047      8.950      0.000
>    51370.894024 [0008]  schbench[38781/38770]              39.597     39.448      9.984     39.437
>    51370.894025 [0009]  stress-ng-cpu[38743]                7.971      7.971      9.997      0.000
> 
> Changes since v1:
>  - Use timehist_sched_wakeup_event() to get the sched_wakeup time. (Namhyung Kim)
>  - Rebase against perf-tools-next commit b38c49d8296b ("perf/test: Speed up test
>    case perf annotate basic tests")
> 
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  tools/perf/Documentation/perf-sched.txt |   8 ++
>  tools/perf/builtin-sched.c              | 112 ++++++++++++++++--------
>  2 files changed, 82 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index 3db64954a267..7935499b88b0 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -221,6 +221,14 @@ OPTIONS for 'perf sched timehist'
>  	priorities are specified with -: 120-129. A combination of both can also be
>  	provided: 0,120-129.
>  
> +-P::
> +--pre-migrations::
> +	Show pre-migration wait time. pre-migration wait time is the time spent
> +	by a task waiting on a runqueue but not getting the chance to run there
> +	and is migrated to a different runqueue where it is finally run. This
> +	time between migrate_task and sched_wakeup is the pre-migration wait
> +	time. This option is valid only if sched_wakeup tracepoint is recorded.
> +
>  OPTIONS for 'perf sched replay'
>  ------------------------------
>  
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index fdf979aaf275..02fe0ec41141 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -225,6 +225,7 @@ struct perf_sched {
>  	bool		show_wakeups;
>  	bool		show_next;
>  	bool		show_migrations;
> +	bool		pre_migrations;
>  	bool		show_state;
>  	bool		show_prio;
>  	u64		skipped_samples;
> @@ -244,7 +245,10 @@ struct thread_runtime {
>  	u64 dt_iowait;      /* time between CPU access by iowait (off cpu) */
>  	u64 dt_preempt;     /* time between CPU access by preempt (off cpu) */
>  	u64 dt_delay;       /* time between wakeup and sched-in */
> +	u64 dt_pre_mig;     /* time between migration and wakeup */
>  	u64 ready_to_run;   /* time of wakeup */
> +	u64 woken;	    /* time when sched_wakeup tracepoint is hit */
> +	u64 migrated;	    /* time when a thread is migrated */
>  
>  	struct stats run_stats;
>  	u64 total_run_time;
> @@ -252,6 +256,7 @@ struct thread_runtime {
>  	u64 total_iowait_time;
>  	u64 total_preempt_time;
>  	u64 total_delay_time;
> +	u64 total_pre_mig_time;
>  
>  	char last_state;
>  
> @@ -2073,14 +2078,15 @@ static void timehist_header(struct perf_sched *sched)
>  		printf(" ");
>  	}
>  
> -	if (sched->show_prio) {
> -		printf(" %-*s  %-*s  %9s  %9s  %9s",
> -		       comm_width, "task name", MAX_PRIO_STR_LEN, "prio",
> -		       "wait time", "sch delay", "run time");
> -	} else {
> -		printf(" %-*s  %9s  %9s  %9s", comm_width,
> -		       "task name", "wait time", "sch delay", "run time");
> -	}
> +	printf(" %-*s", comm_width, "task name");
> +
> +	if (sched->show_prio)
> +		printf("  %-*s", MAX_PRIO_STR_LEN, "prio");
> +
> +	printf("  %9s  %9s  %9s", "wait time", "sch delay", "run time");
> +
> +	if (sched->pre_migrations)
> +		printf("  %9s", "pre-mig time");
>  
>  	if (sched->show_state)
>  		printf("  %s", "state");
> @@ -2095,17 +2101,15 @@ static void timehist_header(struct perf_sched *sched)
>  	if (sched->show_cpu_visual)
>  		printf(" %*s ", ncpus, "");
>  
> -	if (sched->show_prio) {
> -		printf(" %-*s  %-*s  %9s  %9s  %9s",
> -		       comm_width, "[tid/pid]", MAX_PRIO_STR_LEN, "",
> -		       "(msec)", "(msec)", "(msec)");
> -	} else {
> -		printf(" %-*s  %9s  %9s  %9s", comm_width,
> -		       "[tid/pid]", "(msec)", "(msec)", "(msec)");
> -	}
> +	printf(" %-*s", comm_width, "[tid/pid]");
>  
> -	if (sched->show_state)
> -		printf("  %5s", "");
> +	if (sched->show_prio)
> +		printf("  %-*s", MAX_PRIO_STR_LEN, "");
> +
> +	printf("  %9s  %9s  %9s", "(msec)", "(msec)", "(msec)");
> +
> +	if (sched->pre_migrations)
> +		printf("  %9s", "(msec)");
>  
>  	printf("\n");
>  
> @@ -2117,15 +2121,15 @@ static void timehist_header(struct perf_sched *sched)
>  	if (sched->show_cpu_visual)
>  		printf(" %.*s ", ncpus, graph_dotted_line);
>  
> -	if (sched->show_prio) {
> -		printf(" %.*s  %.*s  %.9s  %.9s  %.9s",
> -		       comm_width, graph_dotted_line, MAX_PRIO_STR_LEN, graph_dotted_line,
> -		       graph_dotted_line, graph_dotted_line, graph_dotted_line);
> -	} else {
> -		printf(" %.*s  %.9s  %.9s  %.9s", comm_width,
> -		       graph_dotted_line, graph_dotted_line, graph_dotted_line,
> -		       graph_dotted_line);
> -	}
> +	printf(" %.*s", comm_width, graph_dotted_line);
> +
> +	if (sched->show_prio)
> +		printf("  %.*s", MAX_PRIO_STR_LEN, graph_dotted_line);
> +
> +	printf("  %.9s  %.9s  %.9s", graph_dotted_line, graph_dotted_line, graph_dotted_line);
> +
> +	if (sched->pre_migrations)
> +		printf("  %.9s", graph_dotted_line);
>  
>  	if (sched->show_state)
>  		printf("  %.5s", graph_dotted_line);
> @@ -2180,6 +2184,8 @@ static void timehist_print_sample(struct perf_sched *sched,
>  
>  	print_sched_time(tr->dt_delay, 6);
>  	print_sched_time(tr->dt_run, 6);
> +	if (sched->pre_migrations)
> +		print_sched_time(tr->dt_pre_mig, 6);
>  
>  	if (sched->show_state)
>  		printf(" %5c ", thread__tid(thread) == 0 ? 'I' : state);
> @@ -2239,6 +2245,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>  	r->dt_iowait  = 0;
>  	r->dt_preempt = 0;
>  	r->dt_run     = 0;
> +	r->dt_pre_mig = 0;
>  
>  	if (tprev) {
>  		r->dt_run = t - tprev;
> @@ -2247,6 +2254,11 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>  				pr_debug("time travel: wakeup time for task > previous sched_switch event\n");
>  			else
>  				r->dt_delay = tprev - r->ready_to_run;
> +
> +			if (r->woken && r->migrated) {
> +				if ((r->migrated > r->woken) && (r->migrated < tprev))
> +					r->dt_pre_mig = r->migrated - r->woken;
> +			}
>  		}
>  
>  		if (r->last_time > tprev)
> @@ -2270,6 +2282,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>  	r->total_sleep_time   += r->dt_sleep;
>  	r->total_iowait_time  += r->dt_iowait;
>  	r->total_preempt_time += r->dt_preempt;
> +	r->total_pre_mig_time += r->dt_pre_mig;
>  }
>  
>  static bool is_idle_sample(struct perf_sample *sample,
> @@ -2598,13 +2611,19 @@ static int timehist_sched_wakeup_event(const struct perf_tool *tool,
>  	if (tr == NULL)
>  		return -1;
>  
> -	if (tr->ready_to_run == 0)
> -		tr->ready_to_run = sample->time;
> +	if (!strcmp(evsel__name(evsel), "sched:sched_waking")) {

I guess it won't work when there's no sched_waking event.  Can you
simply handle pre-migration in sched_waking?

Thanks,
Namhyung


> +		if (tr->ready_to_run == 0)
> +			tr->ready_to_run = sample->time;
>  
> -	/* show wakeups if requested */
> -	if (sched->show_wakeups &&
> -	    !perf_time__skip_sample(&sched->ptime, sample->time))
> -		timehist_print_wakeup_event(sched, evsel, sample, machine, thread);
> +		/* show wakeups if requested */
> +		if (sched->show_wakeups &&
> +		    !perf_time__skip_sample(&sched->ptime, sample->time))
> +			timehist_print_wakeup_event(sched, evsel, sample, machine, thread);
> +	} else {
> +		/* keep track of wakeup time for pre-migration */
> +		if (tr->woken == 0)
> +			tr->woken = sample->time;
> +	}
>  
>  	return 0;
>  }
> @@ -2684,8 +2703,14 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
>  
>  	tr->migrations++;
>  
> +	if (tr->migrated == 0)
> +		tr->migrated = sample->time;
> +
>  	/* show migrations if requested */
> -	timehist_print_migration_event(sched, evsel, sample, machine, thread);
> +	if (sched->show_migrations) {
> +		timehist_print_migration_event(sched, evsel, sample,
> +							machine, thread);
> +	}
>  
>  	return 0;
>  }
> @@ -2836,11 +2861,14 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
>  		/* last state is used to determine where to account wait time */
>  		tr->last_state = state;
>  
> -		/* sched out event for task so reset ready to run time */
> +		/* sched out event for task so reset ready to run time, woken and migrated time */
>  		if (state == 'R')
>  			tr->ready_to_run = t;
>  		else
>  			tr->ready_to_run = 0;
> +
> +		tr->woken = 0;
> +		tr->migrated = 0;
>  	}
>  
>  	evsel__save_time(evsel, sample->time, sample->cpu);
> @@ -3267,7 +3295,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
>  	setup_pager();
>  
>  	/* prefer sched_waking if it is captured */
> -	if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
> +	if (!sched->pre_migrations &&
> +		evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
>  		handlers[1].handler = timehist_sched_wakeup_ignore;
>  
>  	/* setup per-evsel handlers */
> @@ -3280,8 +3309,14 @@ static int perf_sched__timehist(struct perf_sched *sched)
>  		goto out;
>  	}
>  
> -	if (sched->show_migrations &&
> -	    perf_session__set_tracepoints_handlers(session, migrate_handlers))
> +	if (sched->pre_migrations && !evlist__find_tracepoint_by_name(session->evlist,
> +									"sched:sched_wakeup")) {
> +		pr_err("No sched_wakeup events found. sched_wakeup tracepoint is mandatory for -P option\n");
> +		goto out;
> +	}
> +
> +	if ((sched->show_migrations || sched->pre_migrations) &&
> +		perf_session__set_tracepoints_handlers(session, migrate_handlers))
>  		goto out;
>  
>  	/* pre-allocate struct for per-CPU idle stats */
> @@ -3823,6 +3858,7 @@ int cmd_sched(int argc, const char **argv)
>  	OPT_BOOLEAN(0, "show-prio", &sched.show_prio, "Show task priority"),
>  	OPT_STRING(0, "prio", &sched.prio_str, "prio",
>  		   "analyze events only for given task priority(ies)"),
> +	OPT_BOOLEAN('P', "pre-migrations", &sched.pre_migrations, "Show pre-migration wait time"),
>  	OPT_PARENT(sched_options)
>  	};
>  
> -- 
> 2.43.2
> 
