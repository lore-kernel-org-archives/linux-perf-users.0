Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A791BE233;
	Fri, 16 Aug 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829275; cv=none; b=mobc7bUYy7usrpcYl7XAhCnYs5YJ7CCL6aD2LbxQu9H3Uatd6cSh9DCKEqIcEqWiHyo34oES393ill6R1AS9/EeJxe+GOLBFiBCvwIfjjEhlqyP8b4OzBTB29oPYLNUi8smw7je4oojCXTXJlvLMQPXQaGKDzT/UyPFbVEWERDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829275; c=relaxed/simple;
	bh=fygN0P5usEVtwcOi4i36r518jPka1qvkd+wRSQxFbBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3A97u8YhJYoDhUMqBg04MZ0dK6Gw5SUOOAPzi16YpSjMLEk9J4t1mRasOexhKNviqUNk5DH3pPGOgCqYLwOupIgVSxhjPsefU32IvWYDLIVJTdBnC6GyefaiLZOkfDVQ9j3zW77QXJf58rl9lavMZ0nqtj2RkJI3rzzRHi1XZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1HZJkS/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1HZJkS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C454FC32782;
	Fri, 16 Aug 2024 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723829275;
	bh=fygN0P5usEVtwcOi4i36r518jPka1qvkd+wRSQxFbBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d1HZJkS/g7RlEWwTeLhxyYgvwuoQrWqgntz9kJrQwVS6CATOosxQzZmouOsWxVOON
	 18V39eS9UBlIjMQkE9tmb8ppaDU2JAD3hmEElpit+fYVJuveC3bNILcrkQMP1lT9/x
	 liwkdMwhbZ18Xkh5IT8gmh/PqYnhQR7Qe0XShWf2Ltj6Q63FjAGX+1oxWLp8/9a0U0
	 wcDOHZ3YTuIGAVQW5qOM/Cu0Q1jENc7IX8X/BYYPHaV0NupoJ/X2shbGe1JsQmzKGE
	 PAHtOt4m6M1V5gvYyylo5ntbmFR6ItL0012ecWfE2sGUn0AvIFEHZlvD50PICV3ec/
	 SSWQizCN3Lqbw==
Date: Fri, 16 Aug 2024 10:27:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf sched timehist: Add --prio option
Message-ID: <Zr-MGX2RfaBFfaMP@google.com>
References: <20240806015701.1309833-1-yangjihong@bytedance.com>
 <20240806015701.1309833-3-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240806015701.1309833-3-yangjihong@bytedance.com>

On Tue, Aug 06, 2024 at 09:57:01AM +0800, Yang Jihong wrote:
> The --prio option is used to only show events for the given task priority(ies).
> The default is to show events for all priority tasks, which is consistent with
> the previous behavior.
> 
> Testcase:
>   # perf sched record nice -n 9 perf bench sched messaging -l 10000
>   # Running 'sched/messaging' benchmark:
>   # 20 sender and receiver processes per group
>   # 10 groups == 400 processes run
> 
>        Total time: 3.435 [sec]
>   [ perf record: Woken up 270 times to write data ]
>   [ perf record: Captured and wrote 618.688 MB perf.data (5729036 samples) ]
> 
>   # perf sched timehist -h
> 
>    Usage: perf sched timehist [<options>]
> 
>       -C, --cpu <cpu>       list of cpus to profile
>       -D, --dump-raw-trace  dump raw trace in ASCII
>       -f, --force           don't complain, do it
>       -g, --call-graph      Display call chains if present (default on)
>       -I, --idle-hist       Show idle events only
>       -i, --input <file>    input file name
>       -k, --vmlinux <file>  vmlinux pathname
>       -M, --migrations      Show migration events
>       -n, --next            Show next task
>       -p, --pid <pid[,pid...]>
>                             analyze events only for given process id(s)
>       -s, --summary         Show only syscall summary with statistics
>       -S, --with-summary    Show all syscalls and summary with statistics
>       -t, --tid <tid[,tid...]>
>                             analyze events only for given thread id(s)
>       -V, --cpu-visual      Add CPU visual
>       -v, --verbose         be more verbose (show symbol address, etc)
>       -w, --wakeups         Show wakeup events
>           --kallsyms <file>
>                             kallsyms pathname
>           --max-stack <n>   Maximum number of functions to display backtrace.
>           --prio <prio>     analyze events only for given task priority(ies)
>           --show-prio       Show task priority
>           --state           Show task state when sched-out
>           --symfs <directory>
>                             Look for files with symbols relative to this directory
>           --time <str>      Time span for analysis (start,stop)
> 
>   # perf sched timehist --prio 140
>   Samples of sched_switch event do not have callchains.
>   Invalid prio string
> 
>   # perf sched timehist --show-prio --prio 129
>   Samples of sched_switch event do not have callchains.
>              time    cpu  task name                       prio      wait time  sch delay   run time
>                           [tid/pid]                                    (msec)     (msec)     (msec)
>   --------------- ------  ------------------------------  --------  ---------  ---------  ---------
>    2090450.765421 [0002]  sched-messaging[1229618]        129           0.000      0.000      0.029
>    2090450.765445 [0007]  sched-messaging[1229616]        129           0.000      0.062      0.043
>    2090450.765448 [0014]  sched-messaging[1229619]        129           0.000      0.000      0.032
>    2090450.765478 [0013]  sched-messaging[1229617]        129           0.000      0.065      0.048
>    2090450.765503 [0014]  sched-messaging[1229622]        129           0.000      0.000      0.017
>    2090450.765550 [0002]  sched-messaging[1229624]        129           0.000      0.000      0.021
>    2090450.765562 [0007]  sched-messaging[1229621]        129           0.000      0.071      0.028
>    2090450.765570 [0005]  sched-messaging[1229620]        129           0.000      0.064      0.066
>    2090450.765583 [0001]  sched-messaging[1229625]        129           0.000      0.001      0.031
>    2090450.765595 [0013]  sched-messaging[1229623]        129           0.000      0.060      0.028
>    2090450.765637 [0014]  sched-messaging[1229628]        129           0.000      0.000      0.019
>    2090450.765665 [0007]  sched-messaging[1229627]        129           0.000      0.038      0.030
>   <SNIP>
> 
>   # perf sched timehist --show-prio --prio 0,120-129
>   Samples of sched_switch event do not have callchains.
>              time    cpu  task name                       prio      wait time  sch delay   run time
>                           [tid/pid]                                    (msec)     (msec)     (msec)
>   --------------- ------  ------------------------------  --------  ---------  ---------  ---------
>    2090450.763231 [0000]  perf[1229608]                   120           0.000      0.000      0.000
>    2090450.763235 [0000]  migration/0[15]                 0             0.000      0.001      0.003
>    2090450.763263 [0001]  perf[1229608]                   120           0.000      0.000      0.000
>    2090450.763268 [0001]  migration/1[21]                 0             0.000      0.001      0.004
>    2090450.763302 [0002]  perf[1229608]                   120           0.000      0.000      0.000
>    2090450.763309 [0002]  migration/2[27]                 0             0.000      0.001      0.007
>    2090450.763338 [0003]  perf[1229608]                   120           0.000      0.000      0.000
>    2090450.763343 [0003]  migration/3[33]                 0             0.000      0.001      0.004
>    2090450.763459 [0004]  perf[1229608]                   120           0.000      0.000      0.000
>    2090450.763469 [0004]  migration/4[39]                 0             0.000      0.002      0.010
>    2090450.763496 [0005]  perf[1229608]                   120           0.000      0.000      0.000
>    2090450.763501 [0005]  migration/5[45]                 0             0.000      0.001      0.004
>    2090450.763613 [0006]  perf[1229608]                   120           0.000      0.000      0.000
>    2090450.763622 [0006]  migration/6[51]                 0             0.000      0.001      0.008
>    2090450.763652 [0007]  perf[1229608]                   120           0.000      0.000      0.000
>    2090450.763660 [0007]  migration/7[57]                 0             0.000      0.001      0.008
>   <SNIP>
>    2090450.765665 [0001]  <idle>                          120           0.031      0.031      0.081
>    2090450.765665 [0007]  sched-messaging[1229627]        129           0.000      0.038      0.030
>    2090450.765667 [0000]  s1-perf[8235/7168]              120           0.008      0.000      0.004
>    2090450.765684 [0013]  <idle>                          120           0.028      0.028      0.088
>    2090450.765685 [0001]  sched-messaging[1229630]        129           0.000      0.001      0.020
>    2090450.765688 [0000]  <idle>                          120           0.004      0.004      0.020
>    2090450.765689 [0002]  <idle>                          120           0.021      0.021      0.138
>    2090450.765691 [0005]  sched-messaging[1229626]        129           0.000      0.085      0.029
> 
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> ---
>  tools/perf/Documentation/perf-sched.txt |  3 +
>  tools/perf/builtin-sched.c              | 74 ++++++++++++++++++++++++-
>  2 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index 3efa5c58418d..70a9016d5a06 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -215,6 +215,9 @@ OPTIONS for 'perf sched timehist'
>  --show-prio::
>  	Show task priority.
>  
> +--prio::
> +	Only show events for given task priority(ies).

Please describe how it takes multiple priorities.  Like 0,120-129.

Thanks,
Namhyung


> +
>  OPTIONS for 'perf sched replay'
>  ------------------------------
>  
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 2af9dbdf4ba2..3981994d9921 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -51,6 +51,7 @@
>  #define COMM_LEN		20
>  #define SYM_LEN			129
>  #define MAX_PID			1024000
> +#define MAX_PRIO		140
>  
>  static const char *cpu_list;
>  static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> @@ -234,6 +235,8 @@ struct perf_sched {
>  	struct perf_time_interval ptime;
>  	struct perf_time_interval hist_time;
>  	volatile bool   thread_funcs_exit;
> +	const char	*prio_str;
> +	DECLARE_BITMAP(prio_bitmap, MAX_PRIO);
>  };
>  
>  /* per thread run time data */
> @@ -2504,12 +2507,33 @@ static bool timehist_skip_sample(struct perf_sched *sched,
>  				 struct perf_sample *sample)
>  {
>  	bool rc = false;
> +	int prio = -1;
> +	struct thread_runtime *tr = NULL;
>  
>  	if (thread__is_filtered(thread)) {
>  		rc = true;
>  		sched->skipped_samples++;
>  	}
>  
> +	if (sched->prio_str) {
> +		/*
> +		 * Because priority may be changed during task execution,
> +		 * first read priority from prev sched_in event for current task.
> +		 * If prev sched_in event is not saved, then read priority from
> +		 * current task sched_out event.
> +		 */
> +		tr = thread__get_runtime(thread);
> +		if (tr && tr->prio != -1)
> +			prio = tr->prio;
> +		else if (evsel__name_is(evsel, "sched:sched_switch"))
> +			prio = evsel__intval(evsel, sample, "prev_prio");
> +
> +		if (prio != -1 && !test_bit(prio, sched->prio_bitmap)) {
> +			rc = true;
> +			sched->skipped_samples++;
> +		}
> +	}
> +
>  	if (sched->idle_hist) {
>  		if (!evsel__name_is(evsel, "sched:sched_switch"))
>  			rc = true;
> @@ -2723,7 +2747,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
>  		goto out;
>  	}
>  
> -	if (sched->show_prio)
> +	if (sched->show_prio || sched->prio_str)
>  		timehist_update_task_prio(evsel, sample, machine);
>  
>  	thread = timehist_get_thread(sched, sample, machine, evsel);
> @@ -3142,6 +3166,47 @@ static int timehist_check_attr(struct perf_sched *sched,
>  	return 0;
>  }
>  
> +static int timehist_parse_prio_str(struct perf_sched *sched)
> +{
> +	char *p;
> +	unsigned long start_prio, end_prio;
> +	const char *str = sched->prio_str;
> +
> +	if (!str)
> +		return 0;
> +
> +	while (isdigit(*str)) {
> +		p = NULL;
> +		start_prio = strtoul(str, &p, 0);
> +		if (start_prio >= MAX_PRIO || (*p != '\0' && *p != ',' && *p != '-'))
> +			return -1;
> +
> +		if (*p == '-') {
> +			str = ++p;
> +			p = NULL;
> +			end_prio = strtoul(str, &p, 0);
> +
> +			if (end_prio >= MAX_PRIO || (*p != '\0' && *p != ','))
> +				return -1;
> +
> +			if (end_prio < start_prio)
> +				return -1;
> +		} else {
> +			end_prio = start_prio;
> +		}
> +
> +		for (; start_prio <= end_prio; start_prio++)
> +			__set_bit(start_prio, sched->prio_bitmap);
> +
> +		if (*p)
> +			++p;
> +
> +		str = p;
> +	}
> +
> +	return 0;
> +}
> +
>  static int perf_sched__timehist(struct perf_sched *sched)
>  {
>  	struct evsel_str_handler handlers[] = {
> @@ -3203,6 +3268,11 @@ static int perf_sched__timehist(struct perf_sched *sched)
>  	if (timehist_check_attr(sched, evlist) != 0)
>  		goto out;
>  
> +	if (timehist_parse_prio_str(sched) != 0) {
> +		pr_err("Invalid prio string\n");
> +		goto out;
> +	}
> +
>  	setup_pager();
>  
>  	/* prefer sched_waking if it is captured */
> @@ -3768,6 +3838,8 @@ int cmd_sched(int argc, const char **argv)
>  		   "analyze events only for given thread id(s)"),
>  	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
>  	OPT_BOOLEAN(0, "show-prio", &sched.show_prio, "Show task priority"),
> +	OPT_STRING(0, "prio", &sched.prio_str, "prio",
> +		   "analyze events only for given task priority(ies)"),
>  	OPT_PARENT(sched_options)
>  	};
>  
> -- 
> 2.25.1
> 
