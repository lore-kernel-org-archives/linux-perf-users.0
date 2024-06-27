Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51911CA9F;
	Thu, 27 Jun 2024 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530008; cv=none; b=GF9qgfLwxWxiq625Y2AP3cbolQdOdRW8XVR1D5JhkO7ld6oXCaBbZA1wVIutYA94inqYDJMYtAIU+mBKuuM5t9wfchrVPWMd4+U5zsmB8u0Q8Q7FGp64U4Bw4q8LM3fhv65W/aUkyIvygIuvqLQUWmwqzG/DXhEGvA2U10WiyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530008; c=relaxed/simple;
	bh=w+KqrY6PCe0bhZpsdCQ09Ljv7uPieywmVvajVT9/XQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rxhchnjp2UvYhRVi7qWsOhT5gYcxuD3hCSg5rC+n/gVIzPIuKA9YXFRqACB6+6JuImOTntUdAaEPk0bOXis+8q4lZtfmpw2VheYRzUdQekf8y72Q0uP3iCfdW2vNW6jHc03sThswLmlEJDRzWnzWA2EJ1+FeUR3yBwSwpAmuXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnQNceEr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnQNceEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932F1C2BBFC;
	Thu, 27 Jun 2024 23:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719530008;
	bh=w+KqrY6PCe0bhZpsdCQ09Ljv7uPieywmVvajVT9/XQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnQNceEraUFlcxDqIkkSvGam+M6jCjpG3DVmIcOW0S4pJlZS3jawcwAC7VnI+Vkhe
	 QUrAu8RnVIoJWqqqDH+It4T0i6k3wO1o7UgBgySnxaoXxqX2A9q9fgLtSZ+ocLN2U9
	 SHvOAcFus+SBDsgykECI594i08xVNByxKgtFKFZjvGK9fbiVoEmt32nCmj8+io13cK
	 8QO6YeQPmA9S7t0US4n2pHg3BWkuBLhqHOFA/CRtWaDPNr97gNqtDIL/hXBGd0caxv
	 knS1e3rgsg5DG44Fmea9/ufSOTPLGGs/Nu/ZSNmUFqA5V5DBlz3XEqDZ0QcVy5DuwC
	 TdvvC85dr7CXw==
Date: Thu, 27 Jun 2024 16:13:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
	Fernand Sieber <sieberf@amazon.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] perf sched map: Add task-name option to filter
 the output map
Message-ID: <Zn3yFucQlvxyhzki@google.com>
References: <20240626091550.46707-1-vineethr@linux.ibm.com>
 <20240626091550.46707-2-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626091550.46707-2-vineethr@linux.ibm.com>

Hello,

On Wed, Jun 26, 2024 at 02:45:48PM +0530, Madadi Vineeth Reddy wrote:
> By default, perf sched map prints sched-in events for all the tasks
> which may not be required all the time as it prints lot of symbols
> and rows to the terminal.
> 
> With --task-name option, one could specify the specific task name
> for which the map has to be shown. This would help in analyzing the
> CPU usage patterns easier for that specific task. Since multiple
> PID's might have the same task name, using task-name filter
> would be more useful for debugging.
> 
> For other tasks, instead of printing the symbol, '-' is printed and
> the same '.' is used to represent idle. '-' is used instead of symbol
> for other tasks because it helps in clear visualization of task
> of interest and secondly the symbol itself doesn't mean anything
> because the sched-in of that symbol will not be printed(first sched-in
> contains pid and the corresponding symbol).
> 
> When using the --task-name option, the sched-out time is represented
> by a '*-'. Since not all task sched-in events are printed, the sched-out
> time of the relevant task might be lost. This representation ensures
> that the sched-out time of the interested task is not overlooked.
> 
> 6.10.0-rc1
> ==========
> *A0                              131040.639793 secs A0 => migration/0:19
> *.                               131040.639801 secs .  => swapper:0
>  .  *B0                          131040.639830 secs B0 => migration/1:24
>  .  *.                           131040.639836 secs
>  .   .  *C0                      131040.640108 secs C0 => migration/2:30
>  .   .  *.                       131040.640163 secs
>  .   .   .  *D0                  131040.640386 secs D0 => migration/3:36
>  .   .   .  *.                   131040.640395 secs
> 
> 6.10.0-rc1 + patch (--task-name wdavdaemon)
> =============
>  .  *A0  .   .   .   .   -   .   131040.641346 secs A0 => wdavdaemon:62509
>  .   A0 *B0  .   .   .   -   .   131040.641378 secs B0 => wdavdaemon:62274
>  -  *-   -   -   -   -   -   -   131040.641379 secs
> *C0  .   B0  .   .   .   .   .   131040.641572 secs C0 => wdavdaemon:62283
>  C0  .   B0  .  *D0  .   .   .   131040.641572 secs D0 => wdavdaemon:62277
>  C0  .   B0  .   D0  .  *E0  .   131040.641578 secs E0 => wdavdaemon:62270
> *-   -   -   -   -   -   -   -   131040.641581 secs
>  -   -   -   -   -   -  *-   -   131040.641583 secs

It seems the last two lines should be like below..

  *-   -   B0  -   D0  -   E0  -   131040.641581 secs
   -   -   B0  -   D0  -  *-   -   131040.641583 secs

> 
> Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  tools/perf/Documentation/perf-sched.txt |   6 +
>  tools/perf/builtin-sched.c              | 161 ++++++++++++++++++------
>  2 files changed, 131 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index 74c812f7a4a4..3255e5b8e74b 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -130,6 +130,12 @@ OPTIONS for 'perf sched map'
>  --color-pids::
>  	Highlight the given pids.
>  
> +--task-name <task>::
> +	Map output only for the given task name. The sched-out
> +	time is printed and is represented by '*-' for the given
> +	task name
> +	('-' indicates other tasks while '.' is idle).
> +
>  OPTIONS for 'perf sched timehist'
>  ---------------------------------
>  -k::
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index aa59f763ca46..57f166662d54 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -156,6 +156,7 @@ struct perf_sched_map {
>  	const char		*color_pids_str;
>  	struct perf_cpu_map	*color_cpus;
>  	const char		*color_cpus_str;
> +	const char		*task_name;
>  	struct perf_cpu_map	*cpus;
>  	const char		*cpus_str;
>  };
> @@ -177,6 +178,7 @@ struct perf_sched {
>  	struct perf_cpu	 max_cpu;
>  	u32		 *curr_pid;
>  	struct thread	 **curr_thread;
> +	struct thread	 **curr_out_thread;
>  	char		 next_shortname1;
>  	char		 next_shortname2;
>  	unsigned int	 replay_repeat;
> @@ -1538,23 +1540,89 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
>  	return thread;
>  }
>  
> +static bool sched_match_task(const char *comm_str, const char *commands)

It'd be easier if you pass the sched pointer.

static bool sched_match_task(struct perf_sched *sched, const char *comm_str)
{
   ...


> +{
> +	char *commands_copy = NULL;
> +	char *token = NULL;
> +	bool match_found = false;
> +
> +	commands_copy = strdup(commands);
> +	if (commands_copy == NULL)
> +		return NULL;
> +
> +	token = strtok(commands_copy, ",");
> +
> +	while (token != NULL && !match_found) {
> +		match_found = !strcmp(comm_str, token);
> +		token = strtok(NULL, ",");
> +	}
> +
> +	free(commands_copy);

Why is this needed?  I think we only support a single command and then
simply check with strcmp().

Also if you add multiple string support, you need to parse the string
when you parse the command line arguments, not when you match.


> +	return match_found;
> +}
> +
> +static void print_sched_map(struct perf_sched *sched, struct perf_cpu this_cpu, int cpus_nr,
> +								const char *color, bool sched_out)
> +{
> +	for (int i = 0; i < cpus_nr; i++) {
> +		struct perf_cpu cpu = {
> +		.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,

Please fix the indentation.

Thanks,
Namhyung


> +		};
> +		struct thread *curr_thread = sched->curr_thread[cpu.cpu];
> +		struct thread *curr_out_thread = sched->curr_out_thread[cpu.cpu];
> +		struct thread_runtime *curr_tr;
> +		const char *pid_color = color;
> +		const char *cpu_color = color;
> +		char symbol = ' ';
> +		struct thread *thread_to_check = sched_out ? curr_out_thread : curr_thread;
> +
> +		if (thread_to_check && thread__has_color(thread_to_check))
> +			pid_color = COLOR_PIDS;
> +
> +		if (sched->map.color_cpus && perf_cpu_map__has(sched->map.color_cpus, cpu))
> +			cpu_color = COLOR_CPUS;
> +
> +		if (cpu.cpu == this_cpu.cpu)
> +			symbol = '*';
> +
> +		color_fprintf(stdout, cpu.cpu != this_cpu.cpu ? color : cpu_color, "%c", symbol);
> +
> +		thread_to_check = sched_out ? sched->curr_out_thread[cpu.cpu] :
> +								sched->curr_thread[cpu.cpu];
> +
> +		if (thread_to_check) {
> +			curr_tr = thread__get_runtime(thread_to_check);
> +			if (curr_tr == NULL)
> +				return;
> +
> +			if (sched_out)
> +				color_fprintf(stdout, color, "-  ");
> +			else
> +				color_fprintf(stdout, pid_color, "%2s ", curr_tr->shortname);
> +		} else
> +			color_fprintf(stdout, color, "   ");
> +	}
> +}
> +
>  static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  			    struct perf_sample *sample, struct machine *machine)
>  {
>  	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
> -	struct thread *sched_in;
> +	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid");
> +	struct thread *sched_in, *sched_out;
>  	struct thread_runtime *tr;
>  	int new_shortname;
>  	u64 timestamp0, timestamp = sample->time;
>  	s64 delta;
> -	int i;
>  	struct perf_cpu this_cpu = {
>  		.cpu = sample->cpu,
>  	};
>  	int cpus_nr;
> +	int proceed;
>  	bool new_cpu = false;
>  	const char *color = PERF_COLOR_NORMAL;
>  	char stimestamp[32];
> +	const char *str;
>  
>  	BUG_ON(this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0);
>  
> @@ -1583,7 +1651,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  	}
>  
>  	sched_in = map__findnew_thread(sched, machine, -1, next_pid);
> -	if (sched_in == NULL)
> +	sched_out = map__findnew_thread(sched, machine, -1, prev_pid);
> +	if (sched_in == NULL || sched_out == NULL)
>  		return -1;
>  
>  	tr = thread__get_runtime(sched_in);
> @@ -1593,6 +1662,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  	}
>  
>  	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
> +	sched->curr_out_thread[this_cpu.cpu] = thread__get(sched_out);
>  
>  	new_shortname = 0;
>  	if (!tr->shortname[0]) {
> @@ -1603,7 +1673,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  			 */
>  			tr->shortname[0] = '.';
>  			tr->shortname[1] = ' ';
> -		} else {
> +		} else if (!sched->map.task_name || sched_match_task(thread__comm_str(sched_in),
> +								sched->map.task_name)) {
>  			tr->shortname[0] = sched->next_shortname1;
>  			tr->shortname[1] = sched->next_shortname2;
>  
> @@ -1616,6 +1687,9 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  				else
>  					sched->next_shortname2 = '0';
>  			}
> +		} else {
> +			tr->shortname[0] = '-';
> +			tr->shortname[1] = ' ';
>  		}
>  		new_shortname = 1;
>  	}
> @@ -1623,42 +1697,28 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  	if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, this_cpu))
>  		goto out;
>  
> -	printf("  ");
> -
> -	for (i = 0; i < cpus_nr; i++) {
> -		struct perf_cpu cpu = {
> -			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
> -		};
> -		struct thread *curr_thread = sched->curr_thread[cpu.cpu];
> -		struct thread_runtime *curr_tr;
> -		const char *pid_color = color;
> -		const char *cpu_color = color;
> -
> -		if (curr_thread && thread__has_color(curr_thread))
> -			pid_color = COLOR_PIDS;
> -
> -		if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, cpu))
> -			continue;
> -
> -		if (sched->map.color_cpus && perf_cpu_map__has(sched->map.color_cpus, cpu))
> -			cpu_color = COLOR_CPUS;
> -
> -		if (cpu.cpu != this_cpu.cpu)
> -			color_fprintf(stdout, color, " ");
> +	proceed = 0;
> +	str = thread__comm_str(sched_in);
> +	/*
> +	 * Check which of sched_in and sched_out matches the passed --task-name
> +	 * arguments and call the corresponding print_sched_map.
> +	 */
> +	if (sched->map.task_name && !sched_match_task(str, sched->map.task_name)) {
> +		if (!sched_match_task(thread__comm_str(sched_out), sched->map.task_name))
> +			goto out;
>  		else
> -			color_fprintf(stdout, cpu_color, "*");
> +			goto sched_out;
>  
> -		if (sched->curr_thread[cpu.cpu]) {
> -			curr_tr = thread__get_runtime(sched->curr_thread[cpu.cpu]);
> -			if (curr_tr == NULL) {
> -				thread__put(sched_in);
> -				return -1;
> -			}
> -			color_fprintf(stdout, pid_color, "%2s ", curr_tr->shortname);
> -		} else
> -			color_fprintf(stdout, color, "   ");
> +	} else {
> +		str = thread__comm_str(sched_out);
> +		if (!(sched->map.task_name && !sched_match_task(str, sched->map.task_name)))
> +			proceed = 1;
>  	}
>  
> +	printf("  ");
> +
> +	print_sched_map(sched, this_cpu, cpus_nr, color, false);
> +
>  	timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
>  	color_fprintf(stdout, color, "  %12s secs ", stimestamp);
>  	if (new_shortname || tr->comm_changed || (verbose > 0 && thread__tid(sched_in))) {
> @@ -1675,9 +1735,32 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  	if (sched->map.comp && new_cpu)
>  		color_fprintf(stdout, color, " (CPU %d)", this_cpu);
>  
> +	if (proceed != 1) {
> +		color_fprintf(stdout, color, "\n");
> +		goto out;
> +	}
> +
> +sched_out:
> +	if (sched->map.task_name) {
> +		tr = thread__get_runtime(sched->curr_out_thread[this_cpu.cpu]);
> +		if (strcmp(tr->shortname, "") == 0)
> +			goto out;
> +
> +		if (proceed == 1)
> +			color_fprintf(stdout, color, "\n");
> +
> +		printf("  ");
> +		print_sched_map(sched, this_cpu, cpus_nr, color, true);
> +		timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
> +		color_fprintf(stdout, color, "  %12s secs ", stimestamp);
> +	}
> +
>  	color_fprintf(stdout, color, "\n");
>  
>  out:
> +	if (sched->map.task_name)
> +		thread__put(sched_out);
> +
>  	thread__put(sched_in);
>  
>  	return 0;
> @@ -3310,6 +3393,10 @@ static int perf_sched__map(struct perf_sched *sched)
>  	if (!sched->curr_thread)
>  		return rc;
>  
> +	sched->curr_out_thread = calloc(MAX_CPUS, sizeof(*(sched->curr_out_thread)));
> +	if (!sched->curr_out_thread)
> +		return rc;
> +
>  	if (setup_cpus_switch_event(sched))
>  		goto out_free_curr_thread;
>  
> @@ -3563,6 +3650,8 @@ int cmd_sched(int argc, const char **argv)
>                      "highlight given CPUs in map"),
>  	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
>                      "display given CPUs in map"),
> +	OPT_STRING(0, "task-name", &sched.map.task_name, "task",
> +		"map output only for the given task name"),
>  	OPT_PARENT(sched_options)
>  	};
>  	const struct option timehist_options[] = {
> -- 
> 2.43.2
> 
