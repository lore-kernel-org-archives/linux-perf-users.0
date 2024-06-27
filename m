Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0751199E93;
	Thu, 27 Jun 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531544; cv=none; b=P7CI3fDvW7HyRUlr8z/Xjd+aHIFZdYWx6DJJUFYmmF1tEM1iJCuQ3WUKyxg1U0UaNk3+9TEyKNoEDN3F9mzSxLgh2xmj6g8MBmncDVWaVyc2bcgUsnAodhXoK4bxEzb2Yx40eS2haAtgkpqmKaMjHugTxA4Gdwra8ElweWl04ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531544; c=relaxed/simple;
	bh=FFq0TXZ/6J0HYddLoW7PqgXGwAYdWstngZhZmw/yigc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTS86h0OgfSDTxdTgd1wJsDLYOxeGrNvbKFOtEPnkRf5TigNb5OWVhQ5AG4h63NcwKuzzNVS3ZD4n+od34PhBDn9WRcqTv5CHcFWAA0jVt4/6wbiLjG/ZRQ/vcKiB0NPa2Jtoa0b6H0Ea3q2apfBm+iCZX5Tlkc7LEmqmpjBo6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmTvxEH5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmTvxEH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429ACC2BBFC;
	Thu, 27 Jun 2024 23:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719531543;
	bh=FFq0TXZ/6J0HYddLoW7PqgXGwAYdWstngZhZmw/yigc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PmTvxEH58qOOfxpyn7D/OsZKg1RIHjIFZHZo067UiFsAwu1jPC8jeDaOntCyxJLXz
	 zHaAEubTiDuGjDDUPQobS/RX8Y+/Qa4N8q9Gd/PVeGL5tTPTU4u+BzdI5hOkZ5dR9a
	 RVvnBy8gnEeC6Q4DHRZcBLdwIdPRNz9Ia+y8BKjD2hrBGl83Ok7F6oMQa1KqiLY05a
	 jFWoaOE59GGfML3ZyKVz+lA/zvMBG/jWrdBEC7pHxLA+QmVwswCoicuR0hanGLc6Gc
	 aPBdLhzMpaDzIMAepWkY0lPnNhvujb0JytMdZRL+Fx8F1mV7TzNnfSIGsy4iXVu8di
	 lrSKSq6eiduFQ==
Date: Thu, 27 Jun 2024 16:39:01 -0700
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
Subject: Re: [PATCH v5 3/3] perf sched map: Add --fuzzy-name option for fuzzy
 matching in task names
Message-ID: <Zn34FZxPLh3llxy9@google.com>
References: <20240626091550.46707-1-vineethr@linux.ibm.com>
 <20240626091550.46707-4-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626091550.46707-4-vineethr@linux.ibm.com>

On Wed, Jun 26, 2024 at 02:45:50PM +0530, Madadi Vineeth Reddy wrote:
> The --fuzzy-name option can be used if fuzzy name matching is required.
> For example, "taskname" can be matched to any string that contains
> "taskname" as its substring.
> 
> Sample output for --task-name wdav --fuzzy-name
> =============
>  .  *A0  .   .   .   .   -   .   131040.641346 secs A0 => wdavdaemon:62509
>  .   A0 *B0  .   .   .   -   .   131040.641378 secs B0 => wdavdaemon:62274
>  -  *-   -   -   -   -   -   -   131040.641379 secs

   -  *-   B0  -   -   -   -   -   131040.641379 secs

> *C0  .   B0  .   .   .   .   .   131040.641572 secs C0 => wdavdaemon:62283
>  C0  .   B0  .  *D0  .   .   .   131040.641572 secs D0 => wdavdaemon:62277
>  C0  .   B0  .   D0  .  *E0  .   131040.641578 secs E0 => wdavdaemon:62270
> *-   -   -   -   -   -   -   -   131040.641581 secs

  *-   -   B0  -   D0  -   E0  -   131040.641581 secs

Thanks,
Namhyung

> 
> Suggested-by: Chen Yu <yu.c.chen@intel.com>
> Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  tools/perf/Documentation/perf-sched.txt |  3 +++
>  tools/perf/builtin-sched.c              | 22 +++++++++++++++-------
>  2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index 3095e280eb92..938b41a3befa 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -137,6 +137,9 @@ OPTIONS for 'perf sched map'
>  	task name(s).
>  	('-' indicates other tasks while '.' is idle).
>  
> +--fuzzy-name::
> +	Given task name(s) can be partially matched (fuzzy matching).
> +
>  OPTIONS for 'perf sched timehist'
>  ---------------------------------
>  -k::
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index ecb43deb9d74..c801c38e8b9a 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -157,6 +157,7 @@ struct perf_sched_map {
>  	struct perf_cpu_map	*color_cpus;
>  	const char		*color_cpus_str;
>  	const char		*task_name;
> +	bool			fuzzy;
>  	struct perf_cpu_map	*cpus;
>  	const char		*cpus_str;
>  };
> @@ -1599,12 +1600,16 @@ static struct CommandList *parse_commands(const char *commands)
>  	return cmd_list;
>  }
>  
> -static bool sched_match_task(const char *comm_str, struct CommandList *cmd_list)
> +static bool sched_match_task(const char *comm_str, struct CommandList *cmd_list, bool fuzzy_match)
>  {
>  	bool match_found = false;
>  
> -	for (int i = 0; i < cmd_list->command_count && !match_found; i++)
> -		match_found = !strcmp(comm_str, cmd_list->command_list[i]);
> +	for (int i = 0; i < cmd_list->command_count && !match_found; i++) {
> +		if (fuzzy_match)
> +			match_found = !!strstr(comm_str, cmd_list->command_list[i]);
> +		else
> +			match_found = !strcmp(comm_str, cmd_list->command_list[i]);
> +	}
>  
>  	return match_found;
>  }
> @@ -1727,7 +1732,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  			 */
>  			tr->shortname[0] = '.';
>  			tr->shortname[1] = ' ';
> -		} else if (!sched->map.task_name || sched_match_task(str, cmd_list)) {
> +		} else if (!sched->map.task_name || sched_match_task(str, cmd_list,
> +								sched->map.fuzzy)) {
>  			tr->shortname[0] = sched->next_shortname1;
>  			tr->shortname[1] = sched->next_shortname2;
>  
> @@ -1756,15 +1762,15 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  	 * Check which of sched_in and sched_out matches the passed --task-name
>  	 * arguments and call the corresponding print_sched_map.
>  	 */
> -	if (sched->map.task_name && !sched_match_task(str, cmd_list)) {
> -		if (!sched_match_task(thread__comm_str(sched_out), cmd_list))
> +	if (sched->map.task_name && !sched_match_task(str, cmd_list, sched->map.fuzzy)) {
> +		if (!sched_match_task(thread__comm_str(sched_out), cmd_list, sched->map.fuzzy))
>  			goto out;
>  		else
>  			goto sched_out;
>  
>  	} else {
>  		str = thread__comm_str(sched_out);
> -		if (!(sched->map.task_name && !sched_match_task(str, cmd_list)))
> +		if (!(sched->map.task_name && !sched_match_task(str, cmd_list, sched->map.fuzzy)))
>  			proceed = 1;
>  	}
>  
> @@ -3707,6 +3713,8 @@ int cmd_sched(int argc, const char **argv)
>                      "display given CPUs in map"),
>  	OPT_STRING(0, "task-name", &sched.map.task_name, "task",
>  		"map output only for the given task name(s)."),
> +	OPT_BOOLEAN(0, "fuzzy-name", &sched.map.fuzzy,
> +		"given command name can be partially matched (fuzzy matching)"),
>  	OPT_PARENT(sched_options)
>  	};
>  	const struct option timehist_options[] = {
> -- 
> 2.43.2
> 
