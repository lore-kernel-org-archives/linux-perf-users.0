Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181471CDA3F;
	Thu, 10 Oct 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577405; cv=none; b=Ip///RjkFQXwOaRZwW/z3aLA/afCBGd4LXqqY+nE0atGzsS8/s9FNG5FV1IhqkydpRplegek/0DWNO7J480WBiWXgamPPPm58Lcfb0nQ1T+Tcp92LvFbbf/3UxjerhRS98BrHvzNWej+ebG1KnrL6ryhqfKjT0ETAOMIPwNj4OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577405; c=relaxed/simple;
	bh=6rdJr7otc8W+RkGQxs66qnVjioEnaZFeJipOaEfE3OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNGaJr6c2R71XZ2uwKEqPeU34no2ybfpvxubvmqEs4kOzHMYvZe8dcwcrx4N0RoBASRwTOFkzXLgdieqrttQWjDuMN2DmM/5lMdUNB2I/RSEFBqQjHu5yn13XDURlDll77yZR4+ocembYiuJbMyrAqBWParExEhrQM00WDSFebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RydIZYtq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RydIZYtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20979C4CEC5;
	Thu, 10 Oct 2024 16:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577404;
	bh=6rdJr7otc8W+RkGQxs66qnVjioEnaZFeJipOaEfE3OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RydIZYtqHy27cPynt38bmdAdM4eqIVtD6Wy223gU+ShCRMIqjQqh1Skh8QdhetBEL
	 G4GDggxaHpljJVnI6X3V1NSNwwKdO9+YeMBeadiNSgamBdPJMs8Uv6JiJySsaTKBaD
	 zAL2XkFSqbtg3X0J3+UWhPB/LXQlyVYyWJLTk2B5M0Fu2Ex4HHTC9Q/7N3avAR/4YG
	 1+Sbbu9GePniHHz6UUGf0NKokULOfgbGy9lC16j/TcpWynfw7m56jA/X+ksVauiV1r
	 ARBF4TQtVhog26hEEjTjyaBYruVrGtOpA7s0INmxaOkJ0SQovV8qGP5MyZ5n/d9S/V
	 DsuKCRWx5xesg==
Date: Thu, 10 Oct 2024 09:23:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>
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
Subject: Re: [PATCH v6] perf sched timehist: Add pre-migration wait time
 option
Message-ID: <Zwf_ep16969kIE2y@google.com>
References: <20241004170756.18064-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004170756.18064-1-vineethr@linux.ibm.com>

Hello Tim,

On Fri, Oct 04, 2024 at 10:37:56PM +0530, Madadi Vineeth Reddy wrote:
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
> 
> The sched:sched_waking event is used to capture the wakeup time,
> as it aligns with the existing code and only introduces a negligible
> time difference.
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
>    38456.720806 [0001]  schbench[28634/28574]               4.917      4.768      1.004      0.000
>    38456.720810 [0001]  rcu_preempt[18]                     3.919      0.003      0.004      0.000
>    38456.721800 [0006]  schbench[28779/28574]              23.465     23.465      1.999      0.000
>    38456.722800 [0002]  schbench[28773/28574]              60.371     60.237      3.955     60.197
>    38456.722806 [0001]  schbench[28634/28574]               0.004      0.004      1.996      0.000
>    38456.722811 [0001]  rcu_preempt[18]                     1.996      0.005      0.005      0.000
>    38456.723800 [0000]  schbench[28833/28574]               4.000      4.000      3.999      0.000
>    38456.723800 [0004]  schbench[28762/28574]              42.951     42.839      3.999     39.867
>    38456.723802 [0007]  schbench[28812/28574]              43.947     43.817      3.999     40.866
>    38456.723804 [0001]  schbench[28587/28574]               7.935      7.822      0.993      0.000
> 
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> 
> ---
> Changes in v6:
> - Handle the case of multiple migrations before the task is
>   scheduled in. (Tim Chen)

Are you ok with this now?

Thanks,
Namhyung

> 
> Changes in v5:
> - Update the ASCII diagram to include dt_pre_mig. (Namhyung Kim)
> 
> Changes in v4:
> - Remove the redundant check for r->ready_to_run and r->migrated. (Namhyung Kim)
> - Rebase against perf-tools-next commit 5873de90315a ("perf/test: perf test
>   86 fails on s390")
> 
> Changes in v3:
> - Use the sched:sched_waking event to calculate the wakeup time. (Namhyung Kim)
> - Rebase against perf-tools-next commit 80f192724e31 ("perf tests: Add more
>   topdown events regroup tests")
> 
> Changes in v2:
> - Use timehist_sched_wakeup_event() to get the sched_wakeup time. (Namhyung Kim)
> - Rebase against perf-tools-next commit b38c49d8296b ("perf/test: Speed up test
>   case perf annotate basic tests")
> 
>  tools/perf/Documentation/perf-sched.txt |  8 ++
>  tools/perf/builtin-sched.c              | 98 +++++++++++++++----------
>  2 files changed, 67 insertions(+), 39 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index 3db64954a267..6dbbddb6464d 100644
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
> +	time between sched_wakeup and migrate_task is the pre-migration wait
> +	time.
> +
>  OPTIONS for 'perf sched replay'
>  ------------------------------
>  
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index fdf979aaf275..c053074b98b4 100644
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
> @@ -244,7 +245,9 @@ struct thread_runtime {
>  	u64 dt_iowait;      /* time between CPU access by iowait (off cpu) */
>  	u64 dt_preempt;     /* time between CPU access by preempt (off cpu) */
>  	u64 dt_delay;       /* time between wakeup and sched-in */
> +	u64 dt_pre_mig;     /* time between migration and wakeup */
>  	u64 ready_to_run;   /* time of wakeup */
> +	u64 migrated;	    /* time when a thread is migrated */
>  
>  	struct stats run_stats;
>  	u64 total_run_time;
> @@ -252,6 +255,7 @@ struct thread_runtime {
>  	u64 total_iowait_time;
>  	u64 total_preempt_time;
>  	u64 total_delay_time;
> +	u64 total_pre_mig_time;
>  
>  	char last_state;
>  
> @@ -2073,14 +2077,15 @@ static void timehist_header(struct perf_sched *sched)
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
> @@ -2095,17 +2100,15 @@ static void timehist_header(struct perf_sched *sched)
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
> @@ -2117,15 +2120,15 @@ static void timehist_header(struct perf_sched *sched)
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
> @@ -2180,6 +2183,8 @@ static void timehist_print_sample(struct perf_sched *sched,
>  
>  	print_sched_time(tr->dt_delay, 6);
>  	print_sched_time(tr->dt_run, 6);
> +	if (sched->pre_migrations)
> +		print_sched_time(tr->dt_pre_mig, 6);
>  
>  	if (sched->show_state)
>  		printf(" %5c ", thread__tid(thread) == 0 ? 'I' : state);
> @@ -2217,18 +2222,21 @@ static void timehist_print_sample(struct perf_sched *sched,
>   *    last_time = time of last sched change event for current task
>   *                (i.e, time process was last scheduled out)
>   * ready_to_run = time of wakeup for current task
> + *     migrated = time of task migration to another CPU
>   *
> - * -----|------------|------------|------------|------
> - *    last         ready        tprev          t
> + * -----|-------------|-------------|-------------|-------------|-----
> + *    last         ready         migrated       tprev           t
>   *    time         to run
>   *
> - *      |-------- dt_wait --------|
> - *                   |- dt_delay -|-- dt_run --|
> + *      |---------------- dt_wait ----------------|
> + *                   |--------- dt_delay ---------|-- dt_run --|
> + *                   |- dt_pre_mig -|
>   *
> - *   dt_run = run time of current task
> - *  dt_wait = time between last schedule out event for task and tprev
> - *            represents time spent off the cpu
> - * dt_delay = time between wakeup and schedule-in of task
> + *     dt_run = run time of current task
> + *    dt_wait = time between last schedule out event for task and tprev
> + *              represents time spent off the cpu
> + *   dt_delay = time between wakeup and schedule-in of task
> + * dt_pre_mig = time between wakeup and migration to another CPU
>   */
>  
>  static void timehist_update_runtime_stats(struct thread_runtime *r,
> @@ -2239,6 +2247,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>  	r->dt_iowait  = 0;
>  	r->dt_preempt = 0;
>  	r->dt_run     = 0;
> +	r->dt_pre_mig = 0;
>  
>  	if (tprev) {
>  		r->dt_run = t - tprev;
> @@ -2247,6 +2256,9 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>  				pr_debug("time travel: wakeup time for task > previous sched_switch event\n");
>  			else
>  				r->dt_delay = tprev - r->ready_to_run;
> +
> +			if ((r->migrated > r->ready_to_run) && (r->migrated < tprev))
> +				r->dt_pre_mig = r->migrated - r->ready_to_run;
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
> @@ -2683,9 +2696,13 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
>  		return -1;
>  
>  	tr->migrations++;
> +	tr->migrated = sample->time;
>  
>  	/* show migrations if requested */
> -	timehist_print_migration_event(sched, evsel, sample, machine, thread);
> +	if (sched->show_migrations) {
> +		timehist_print_migration_event(sched, evsel, sample,
> +							machine, thread);
> +	}
>  
>  	return 0;
>  }
> @@ -2836,11 +2853,13 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
>  		/* last state is used to determine where to account wait time */
>  		tr->last_state = state;
>  
> -		/* sched out event for task so reset ready to run time */
> +		/* sched out event for task so reset ready to run time and migrated time */
>  		if (state == 'R')
>  			tr->ready_to_run = t;
>  		else
>  			tr->ready_to_run = 0;
> +
> +		tr->migrated = 0;
>  	}
>  
>  	evsel__save_time(evsel, sample->time, sample->cpu);
> @@ -3280,8 +3299,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
>  		goto out;
>  	}
>  
> -	if (sched->show_migrations &&
> -	    perf_session__set_tracepoints_handlers(session, migrate_handlers))
> +	if ((sched->show_migrations || sched->pre_migrations) &&
> +		perf_session__set_tracepoints_handlers(session, migrate_handlers))
>  		goto out;
>  
>  	/* pre-allocate struct for per-CPU idle stats */
> @@ -3823,6 +3842,7 @@ int cmd_sched(int argc, const char **argv)
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
