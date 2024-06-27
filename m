Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9554E199E93;
	Thu, 27 Jun 2024 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531384; cv=none; b=gv0GlpTBst4vqOc0pawe/LfOx1eobzmetGabu4VJXY9AqxQkObyANk/hdh6TU1gKh8LtVQgjcgHhIeoFfGylIyFEaUAV/qQPoc6Ig0O5tgdXe7W1ki+Yr/E230f+/3lzG8hbpnhv3G/buMVDjKAqIpXDMkv9ksHnEbQmvP47fOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531384; c=relaxed/simple;
	bh=YlHR2LPPMByutX599IR6915akRVbXvoukaiuOwUQaYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW6vnB7saRpCW76KFMb9k9aFuZlM9odmFICT02SY6Kbw6vGeeMLXhCsd9kbAwA9mEv2cIiEIlab3S2jI2nuzb2bioGhhSOwB53ocKKcta4r7SEezoD8BNE12tdb+RXIY66zb1Tn18COwT5SLy7ZCqeqvfxSC9NnuHcuEyF9XfEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk1T/b3O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk1T/b3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B99C2BBFC;
	Thu, 27 Jun 2024 23:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719531384;
	bh=YlHR2LPPMByutX599IR6915akRVbXvoukaiuOwUQaYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rk1T/b3O35FrCfDoNan/hmqA8EFzFFclfO87fFxyDw8bHgqk3uf+zevzfwbno7/SL
	 tcH7qSL766kN3IZmLK464Izx3a9uEdA5D0DHiYrT4CTfLk6ULtNLgcWnohg9qIpRnL
	 fz7gfk3ef9CAX9p7DjEtauQoOPIfi3yziJnYs5oy5Un8jTM4kLoEOCr+kMeGOqjyUd
	 /ANIEjhqZlVuYqDe46t3EVK5mlXHbXjRf40KjiV6WwrQFj5j1Rl1vbhnSH0+uu2IQp
	 XFI+kPzD+Pjh9QSUW9BHsRR1WeYZ5VPB4vz0b+dcoZuP/SCefNuTyU7g8L8uxqB84m
	 AobsiTx6Jgy6Q==
Date: Thu, 27 Jun 2024 16:36:22 -0700
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
Subject: Re: [PATCH v5 2/3] perf sched map: Add support for multiple task
 names using CSV
Message-ID: <Zn33dkUPuDdVD8KV@google.com>
References: <20240626091550.46707-1-vineethr@linux.ibm.com>
 <20240626091550.46707-3-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626091550.46707-3-vineethr@linux.ibm.com>

On Wed, Jun 26, 2024 at 02:45:49PM +0530, Madadi Vineeth Reddy wrote:
> To track the scheduling patterns of multiple tasks simultaneously,
> multiple task names can be specified using a comma separator
> without any whitespace.
> 
> Sample output for --task-name perf,wdavdaemon
> =============
>  .  *A0  .   .   .   .   -   .   131040.641346 secs A0 => wdavdaemon:62509
>  .   A0 *B0  .   .   .   -   .   131040.641378 secs B0 => wdavdaemon:62274
>  -  *-   -   -   -   -   -   -   131040.641379 secs
> *C0  .   B0  .   .   .   .   .   131040.641572 secs C0 => wdavdaemon:62283
> 
> ...
> 
>  -  *-   -   -   -   -   -   -   131041.395649 secs
>  .   .   .   .   .   .   .  *X2  131041.403969 secs X2 => perf:70211
>  -   -   -   -   -   -   -  *-   131041.404006 secs
> 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  tools/perf/Documentation/perf-sched.txt |  5 +-
>  tools/perf/builtin-sched.c              | 77 +++++++++++++++++++++----
>  2 files changed, 69 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index 3255e5b8e74b..3095e280eb92 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -131,9 +131,10 @@ OPTIONS for 'perf sched map'
>  	Highlight the given pids.
>  
>  --task-name <task>::
> -	Map output only for the given task name. The sched-out
> +	Map output only for the given task name(s). Separate the
> +	task names with a comma (without whitespace). The sched-out
>  	time is printed and is represented by '*-' for the given
> -	task name
> +	task name(s).
>  	('-' indicates other tasks while '.' is idle).
>  
>  OPTIONS for 'perf sched timehist'
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 57f166662d54..ecb43deb9d74 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1540,24 +1540,72 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
>  	return thread;
>  }
>  
> -static bool sched_match_task(const char *comm_str, const char *commands)
> +struct CommandList {

Please don't use camel case.

> +	char **command_list;
> +	int command_count;

If you name the list as commands (or cmds) you can remove the prefix and
use it like commands->list or cmds->count.

Actually I was thinking about strlist API and it'd do most of the work
you did here.  You may want to add the fuzzy (or substring) matching
there.

> +};
> +
> +static void free_command_list(struct CommandList *cmd_list)
> +{
> +	if (cmd_list) {
> +		for (int i = 0; i < cmd_list->command_count; i++)
> +			free(cmd_list->command_list[i]);
> +		free(cmd_list->command_list);
> +		free(cmd_list);
> +	}

Then it could be just strlist__delete().


> +}
> +
> +static struct CommandList *parse_commands(const char *commands)
>  {
>  	char *commands_copy = NULL;
> +	struct CommandList *cmd_list = NULL;
>  	char *token = NULL;
> -	bool match_found = false;
>  
>  	commands_copy = strdup(commands);
>  	if (commands_copy == NULL)
>  		return NULL;
>  
> +	cmd_list = malloc(sizeof(struct CommandList));
> +	if (cmd_list == NULL) {
> +		free(commands_copy);
> +		return NULL;
> +	}
> +
> +	cmd_list->command_count = 0;
> +	cmd_list->command_list = NULL;

You can use zalloc() and remove the zero initialization.


> +
>  	token = strtok(commands_copy, ",");
> +	while (token != NULL) {
> +		cmd_list->command_list = realloc(cmd_list->command_list, sizeof(char *)
> +							*(cmd_list->command_count + 1));
> +		if (cmd_list->command_list == NULL) {
> +			free_command_list(cmd_list);
> +			free(commands_copy);
> +			return NULL;
> +		}
>  
> -	while (token != NULL && !match_found) {
> -		match_found = !strcmp(comm_str, token);
> +		cmd_list->command_list[cmd_list->command_count] = strdup(token);
> +		if (cmd_list->command_list[cmd_list->command_count] == NULL) {
> +			free_command_list(cmd_list);
> +			free(commands_copy);
> +			return NULL;
> +		}
> +
> +		cmd_list->command_count++;
>  		token = strtok(NULL, ",");
>  	}
>  
>  	free(commands_copy);
> +	return cmd_list;

And this could be just `strlist__new(commands, NULL)`.

Thanks,
Namhyung


> +}
> +
> +static bool sched_match_task(const char *comm_str, struct CommandList *cmd_list)
> +{
> +	bool match_found = false;
> +
> +	for (int i = 0; i < cmd_list->command_count && !match_found; i++)
> +		match_found = !strcmp(comm_str, cmd_list->command_list[i]);
> +
>  	return match_found;
>  }
>  
> @@ -1624,6 +1672,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  	char stimestamp[32];
>  	const char *str;
>  
> +	struct CommandList *cmd_list = NULL;
> +
>  	BUG_ON(this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0);
>  
>  	if (this_cpu.cpu > sched->max_cpu.cpu)
> @@ -1664,7 +1714,11 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
>  	sched->curr_out_thread[this_cpu.cpu] = thread__get(sched_out);
>  
> +	if (sched->map.task_name)
> +		cmd_list = parse_commands(sched->map.task_name);
> +
>  	new_shortname = 0;
> +	str = thread__comm_str(sched_in);
>  	if (!tr->shortname[0]) {
>  		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
>  			/*
> @@ -1673,8 +1727,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  			 */
>  			tr->shortname[0] = '.';
>  			tr->shortname[1] = ' ';
> -		} else if (!sched->map.task_name || sched_match_task(thread__comm_str(sched_in),
> -								sched->map.task_name)) {
> +		} else if (!sched->map.task_name || sched_match_task(str, cmd_list)) {
>  			tr->shortname[0] = sched->next_shortname1;
>  			tr->shortname[1] = sched->next_shortname2;
>  
> @@ -1703,15 +1756,15 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  	 * Check which of sched_in and sched_out matches the passed --task-name
>  	 * arguments and call the corresponding print_sched_map.
>  	 */
> -	if (sched->map.task_name && !sched_match_task(str, sched->map.task_name)) {
> -		if (!sched_match_task(thread__comm_str(sched_out), sched->map.task_name))
> +	if (sched->map.task_name && !sched_match_task(str, cmd_list)) {
> +		if (!sched_match_task(thread__comm_str(sched_out), cmd_list))
>  			goto out;
>  		else
>  			goto sched_out;
>  
>  	} else {
>  		str = thread__comm_str(sched_out);
> -		if (!(sched->map.task_name && !sched_match_task(str, sched->map.task_name)))
> +		if (!(sched->map.task_name && !sched_match_task(str, cmd_list)))
>  			proceed = 1;
>  	}
>  
> @@ -1758,8 +1811,10 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  	color_fprintf(stdout, color, "\n");
>  
>  out:
> -	if (sched->map.task_name)
> +	if (sched->map.task_name) {
> +		free_command_list(cmd_list);
>  		thread__put(sched_out);
> +	}
>  
>  	thread__put(sched_in);
>  
> @@ -3651,7 +3706,7 @@ int cmd_sched(int argc, const char **argv)
>  	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
>                      "display given CPUs in map"),
>  	OPT_STRING(0, "task-name", &sched.map.task_name, "task",
> -		"map output only for the given task name"),
> +		"map output only for the given task name(s)."),
>  	OPT_PARENT(sched_options)
>  	};
>  	const struct option timehist_options[] = {
> -- 
> 2.43.2
> 
