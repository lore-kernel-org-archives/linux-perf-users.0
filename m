Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3F83BB48;
	Mon, 10 Jun 2024 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060114; cv=none; b=sego/ZsRNlLLCp2aAmOqjdxE/l8/f1zZYbyEU1AE42oCeUd6iwH/kCmjyEIi83ZKpLtU7ZX9+WbwxN6mhRjgJNxgHGYFK/ZV3mpVQlyO7813xUGo1Fu47A75VaNc3KbeNeQJ3YDSem46kpStONewKbz8i2vPVJPuZdJhfY7vpkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060114; c=relaxed/simple;
	bh=IGTVyfZEJPfTzIux9gJBo5CPb1G8MlrIO/vrEjzPIgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1ZFf73zOJxVhz6tek1XoJcsGRjO49YH7wxoktDZJ50MJMkZjlCIUOBV1A7M0CL8au65OO6O7Z4wDRNOTOP0OL+PdhC0eFUB7gK6mtoc/w5xgsokgsLGkRG14kOvX//stmrOEcBk6BELj8BdCq+v+wEPZXBqZw3rzt6c1AxyORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8LOHIJo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8LOHIJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28949C2BBFC;
	Mon, 10 Jun 2024 22:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718060113;
	bh=IGTVyfZEJPfTzIux9gJBo5CPb1G8MlrIO/vrEjzPIgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8LOHIJoXqqGRYAB0Q1p7dq+CAOaPJeJQ/jXroDFjilIOKHzz04sIeks5LD1uJLYk
	 e5VoV/lqx+o+rG2xp0sc1JtIvBHg6jDA+WncPTvqG8g5EJ0uWxred5NwSybkf7yDVJ
	 Y6Z0ppN77koPZNLOEOwu9wtzrGTk9IEPtsqEQB647QF+f5Q+3AQsQ8ciyIDqzWoID2
	 CPMH8Kxtkig/DNyszbg+620B3vqoLIq9W8NqrT0jSVI0YCliNJ58DIQK2i4ArCxuuE
	 gI5OeWwMiukJBhSW37phERGUwNoys1K4s19JlLk2z9RDI+G3bx7rWZjZnmE5en/716
	 WpuoV5EiWZlCA==
Date: Mon, 10 Jun 2024 15:55:11 -0700
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
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf sched map: Add command-name, fuzzy-name options
 to filter the output map
Message-ID: <ZmeET1yhxU1-D7hy@google.com>
References: <20240608124915.33860-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240608124915.33860-1-vineethr@linux.ibm.com>

Hello,

On Sat, Jun 08, 2024 at 06:18:29PM +0530, Madadi Vineeth Reddy wrote:
> By default, perf sched map prints sched-in events for all the tasks
> which may not be required all the time as it prints lot of symbols
> and rows to the terminal.
> 
> With --command-name option, one could specify the specific command(s)
> for which the map has to be shown. This would help in analyzing the
> CPU usage patterns easier for that specific command(s). Since multiple
> PID's might have the same command name, using command-name filter
> would be more useful for debugging.
> 
> Multiple command names can be given with a comma separator without
> whitespace.
> 
> The --fuzzy-name option can be used if fuzzy name matching is required.
> For example, "taskname" can be matched to any string that contains
> "taskname" as its substring.
> 
> For other tasks, instead of printing the symbol, ** is printed and
> the same . is used to represent idle. ** is used instead of symbol
> for other tasks because it helps in clear visualization of command(s)
> of interest and secondly the symbol itself doesn't mean anything
> because the sched-in of that symbol will not be printed(first sched-in
> contains pid and the corresponding symbol).
> 
> 6.10.0-rc1
> ==========
>   *A0                   213864.670142 secs A0 => migration/0:18
>   *.                    213864.670148 secs .  => swapper:0
>    .  *B0               213864.670217 secs B0 => migration/1:21
>    .  *.                213864.670223 secs
>    .   .  *C0           213864.670247 secs C0 => migration/2:26
>    .   .  *.            213864.670252 secs
> 
> 6.10.0-rc1 + patch (--command-name = schbench)
> =============
>    **  .   ** *A0       213864.671055 secs A0 => schbench:104834
>   *B0  .   .   A0       213864.671156 secs B0 => schbench:104835
>   *C0  .   .   A0       213864.671187 secs C0 => schbench:104836

I still think some people are interested in sched-out time.  For
example, we don't know when B0 was scheduled out in the above.  There
could be other tasks between B0 and C0 on the CPU 0.


>   *D0  .   .   A0       213864.671219 secs D0 => schbench:104837
>   *E0  .   .   A0       213864.671250 secs E0 => schbench:104838
>    E0  .  *D0  A0
> 
> This helps in visualizing how a benchmark like schbench is spread over
> the available cpus while also knowing which cpus are idle(.) and which
> are not(**). This will be more useful as number of CPUs increase.
> 
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com <mailto:atrajeev@linux.vnet.ibm.com>>
> 
> ---
> Changes in v2:
> - Add support for giving multiple command-names in CSV. (Namhyung Kim)
> - Add fuzzy name matching option. (Chen Yu)
> - Add Reviewed-and-tested-by tag from Athira Rajeev.
> - Rebase against perf-tools-next commit d2307fd4f989 ("perf maps: Add/use
>   a sorted insert for fixup overlap and insert")
> - Link to v1: https://lore.kernel.org/lkml/20240417152521.80340-1-vineethr@linux.ibm.com/
> ---
>  tools/perf/Documentation/perf-sched.txt |  8 +++++
>  tools/perf/builtin-sched.c              | 41 +++++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index a216d2991b19..6901c192eb6f 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -130,6 +130,14 @@ OPTIONS for 'perf sched map'
>  --color-pids::
>  	Highlight the given pids.
>  
> +--command-name::
> +	Map output only for the given command name(s). Separate the
> +	command names with a comma (without whitespace).
> +	(** indicates other tasks while . is idle).
> +
> +--fuzzy-name::
> +	Given command name can be partially matched (fuzzy matching).
> +
>  OPTIONS for 'perf sched timehist'
>  ---------------------------------
>  -k::
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 5977c49ae2c7..364f48170e65 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -156,6 +156,8 @@ struct perf_sched_map {
>  	const char		*color_pids_str;
>  	struct perf_cpu_map	*color_cpus;
>  	const char		*color_cpus_str;
> +	const char		*command;
> +	bool			fuzzy;
>  	struct perf_cpu_map	*cpus;
>  	const char		*cpus_str;
>  };
> @@ -1538,6 +1540,26 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
>  	return thread;
>  }
>  
> +static bool command_matches(const char *comm_str, const char *commands, bool fuzzy_match)
> +{
> +	char *commands_copy = strdup(commands);
> +	char *token = strtok(commands_copy, ",");

Hmm.. copying and parsing the commands whenever it compares the task
comm looks inefficient.  I think you can parse the input string once and
keep the list of names.

> +
> +	bool match_found = false;
> +
> +	while (token != NULL) {
> +		if ((fuzzy_match && strstr(comm_str, token) != NULL) ||
> +					strcmp(comm_str, token) == 0) {
> +			match_found = true;
> +			break;
> +		}
> +	token = strtok(NULL, ",");
> +	}

It could be:

    while (token != NULL && !match_found) {
        if (fuzzy_match)
            match_found = !!strstr(comm_str, token);
        else
            match_found = !strcmp(comm_str, token);

        token = strtok(NULL, ",");
    }

But as I said, it'd better not to call strtok() here.

> +
> +	free(commands_copy);
> +	return match_found;
> +}
> +
>  static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  			    struct perf_sample *sample, struct machine *machine)
>  {
> @@ -1594,8 +1616,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  
>  	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
>  
> -	printf("  ");
> -
>  	new_shortname = 0;
>  	if (!tr->shortname[0]) {
>  		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
> @@ -1605,7 +1625,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  			 */
>  			tr->shortname[0] = '.';
>  			tr->shortname[1] = ' ';
> -		} else {
> +		} else if (!sched->map.command || command_matches(thread__comm_str(sched_in),
> +							sched->map.command, sched->map.fuzzy)) {

We usually align the indentation using the open parenthesis.
Maybe you can rename the function and pass the sched pointer directly
to reduce the argument.

  bool sched_match_task(struct perf_sched *sched, const char *comm_str)
  {
      ...
  }

Or you could pass thread instead of comm_str and possibly support
matching with TID too.

Thanks,
Namhyung


>  			tr->shortname[0] = sched->next_shortname1;
>  			tr->shortname[1] = sched->next_shortname2;
>  
> @@ -1618,10 +1639,19 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  				else
>  					sched->next_shortname2 = '0';
>  			}
> +		} else {
> +			tr->shortname[0] = '*';
> +			tr->shortname[1] = '*';
>  		}
>  		new_shortname = 1;
>  	}
>  
> +	if (sched->map.command && !command_matches(thread__comm_str(sched_in), sched->map.command,
> +										sched->map.fuzzy))
> +		goto skip;
> +
> +	printf("  ");
> +
>  	for (i = 0; i < cpus_nr; i++) {
>  		struct perf_cpu cpu = {
>  			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
> @@ -1678,6 +1708,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  out:
>  	color_fprintf(stdout, color, "\n");
>  
> +skip:
>  	thread__put(sched_in);
>  
>  	return 0;
> @@ -3560,6 +3591,10 @@ int cmd_sched(int argc, const char **argv)
>                      "highlight given CPUs in map"),
>  	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
>                      "display given CPUs in map"),
> +	OPT_STRING(0, "command-name", &sched.map.command, "command",
> +		"map output only for the given command name(s)"),
> +	OPT_BOOLEAN(0, "fuzzy-name", &sched.map.fuzzy,
> +		"given command name can be partially matched (fuzzy matching)"),
>  	OPT_PARENT(sched_options)
>  	};
>  	const struct option timehist_options[] = {
> -- 
> 2.31.1
> 
