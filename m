Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34918F40;
	Thu,  3 Oct 2024 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727915724; cv=none; b=u1KpyNjaJybTA+Dya3Yhnt6mQx+FsbffaETZVW59+gcxonWxPE1/ipilTTMTOu/m9k9kP3QK3ZKWawOK1R8XvifRG0j3MD6OVOFyhp39VjRutjSLwTK5Bvy655SQCRG/0AtoWoZ2SOCAYIlgvx3XCviwt57d+8mFruWXnIj+tZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727915724; c=relaxed/simple;
	bh=Lu5TUbvtaoA5IZx4ztAD1WTDekopQwfWxqQgsOskw20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Umo9SFayaRV5TbkORMOUsbFBd5M1llEdvcTSCtE9SPRb9ztTC2Q9NsmVyubNgCMjk475CZ3bLxwQnKDXl/uAoiSWtDuWKyVugc2g6JePPZ6HuM+/QKj/ADHfpgOAt3EgIj3aL2ABgq+JAmKKxoT+ZyQsIU2BnbLnEvdFhm63GRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTHh/0Pu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTHh/0Pu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E30C4CEC2;
	Thu,  3 Oct 2024 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727915724;
	bh=Lu5TUbvtaoA5IZx4ztAD1WTDekopQwfWxqQgsOskw20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTHh/0Pusa/NIM/Moa51I6MqLwWPXJ7uwseoHOXDqQkNTauEACrcUoA4yga0VyBwj
	 O7sBXnlbiDX0dE+KcLjf9J6gcEBttpZHDp3OoefDuC8u/ypI9z3xQ/rPC7IoU3wR/6
	 htZnrmWLSbjiY7w+qvIkoqW8bOMm6q6yb0TEKuT0dUmwfj8dxdiTEnYQ/ehVU334ud
	 FrZGyQZtDvvmDGoYBIfG6V5AxUuW4zynE7Lr6gU5eQ3KSpt83sn1LuVW9zQ2rNURX8
	 yRTu6vlhSU0HFaZrtNXfpKIrtWh4ns+mDdVNpGI4xYUwrw6lehkbreU/ifh8VGXsyI
	 HZ0//9g2C6ySw==
Date: Wed, 2 Oct 2024 17:35:22 -0700
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
Subject: Re: [PATCH v3] perf sched timehist: Add pre-migration wait time
 option
Message-ID: <Zv3myhcbdEPLCAIC@google.com>
References: <20241002163917.33781-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002163917.33781-1-vineethr@linux.ibm.com>

On Wed, Oct 02, 2024 at 10:09:17PM +0530, Madadi Vineeth Reddy wrote:
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
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  tools/perf/Documentation/perf-sched.txt |  8 +++
>  tools/perf/builtin-sched.c              | 83 ++++++++++++++++---------
>  2 files changed, 60 insertions(+), 31 deletions(-)
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
> index fdf979aaf275..e6540803ced6 100644
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
> @@ -2239,6 +2244,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,

It'd be nice if you update the comment on timehist_update_runtime_stats.


>  	r->dt_iowait  = 0;
>  	r->dt_preempt = 0;
>  	r->dt_run     = 0;
> +	r->dt_pre_mig = 0;
>  
>  	if (tprev) {
>  		r->dt_run = t - tprev;
> @@ -2247,6 +2253,11 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>  				pr_debug("time travel: wakeup time for task > previous sched_switch event\n");
>  			else
>  				r->dt_delay = tprev - r->ready_to_run;
> +
> +			if (r->ready_to_run && r->migrated) {

At this point r->read_to_run is not zero.  And the r->migrated should
not be zero when the below condition is met.  So I think you can remove
this condition.

Thanks,
Namhyung


> +				if ((r->migrated > r->ready_to_run) && (r->migrated < tprev))
> +					r->dt_pre_mig = r->migrated - r->ready_to_run;
> +			}
>  		}
>  
>  		if (r->last_time > tprev)
> @@ -2270,6 +2281,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>  	r->total_sleep_time   += r->dt_sleep;
>  	r->total_iowait_time  += r->dt_iowait;
>  	r->total_preempt_time += r->dt_preempt;
> +	r->total_pre_mig_time += r->dt_pre_mig;
>  }
>  
>  static bool is_idle_sample(struct perf_sample *sample,
> @@ -2684,8 +2696,14 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
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
> @@ -2836,11 +2854,13 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
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
> @@ -3280,8 +3300,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
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
> @@ -3823,6 +3843,7 @@ int cmd_sched(int argc, const char **argv)
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
