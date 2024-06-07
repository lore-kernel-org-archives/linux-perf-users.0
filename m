Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11518F6F;
	Fri,  7 Jun 2024 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717721426; cv=none; b=KPfv4G2kk/1HuJ92u2cEwh07nSXKQ0fhsixqsjL2CuW7K0BTYjAB5FIBLFMZTDdxe/n+cRnlmcF/OD6twrfJqrRjPX0TpjeGsnhzYWvcxwubVbr2+fSF9f0x+vHUnBdWw/TVrvC+nenaWTOY5OXxE6NlyY2a/0r1op8SWJu6qIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717721426; c=relaxed/simple;
	bh=9OKGY5q4vExwsfS8GMOedX/ElPhLjFkOClCt3m5gVZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu9gsKg6YjurV8TAvXp501je9jj7NWMTVWExAuUMrbe/cnkipdnQLsubZzUcVcZ14qt35UDtnU3WHEJRV6qEuY4mrOdS8I3FuaP5r06tRixyKhlzoqaYJJySaAAiA8hOcEdz6x5VhrSFhl8zj7JJH3xWC2x1dMzx4V62+vddGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KslxOWeb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KslxOWeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4946C32781;
	Fri,  7 Jun 2024 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717721426;
	bh=9OKGY5q4vExwsfS8GMOedX/ElPhLjFkOClCt3m5gVZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KslxOWebZJXc7JSabOa6yOC3jTVh8v8kZ6VwVrnM/wr0g5QpeZF60SGSxtuM4SW7m
	 x/WzQZc+1RM55hzpES1AEYgyjapyeLrY73c7Tcqjg5f66fkh03b9KLKkurFGNfgM+C
	 n3HtUZ/sfSv/UUWC1ia+bgCPZ3PuTI5WIX82TyTcpsxMX2j32PX8z33LDOH2bGbzgF
	 I51lxOEVJk8h0/ReeK/KJB9TaETc1G6qz2A3upxWoSDhbraftIi4PkfvtX3SPmMv0g
	 KSpBA8oloaIJlli6R7kss7YZsZROO4jzud1t05annAVpfhHGEe0DR9nXvjaeBB/r5Y
	 /DcJGLk3UnRJQ==
Date: Thu, 6 Jun 2024 17:50:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, acme@redhat.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf sched map: Add command-name option to filter the
 output map
Message-ID: <ZmJZULPzy0C4aPiO@google.com>
References: <20240417152521.80340-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240417152521.80340-1-vineethr@linux.ibm.com>

Hello,

Sorry for the late reply.

On Wed, Apr 17, 2024 at 08:55:21PM +0530, Madadi Vineeth Reddy wrote:
> By default, perf sched map prints sched-in events for all the tasks
> which may not be required all the time as it prints lot of symbols
> and rows to the terminal.
> 
> With --command-name option, one could specify the specific command
> for which the map has to be shown. This would help in analyzing the
> CPU usage patterns easier for that specific command. Since multiple
> PID's might have the same command name, using command-name filter
> would be more useful for debugging.
> 
> For other tasks, instead of printing the symbol, ** is printed and
> the same . is used to represent idle. ** is used instead of symbol
> for other tasks because it helps in clear visualization of command
> of interest and secondly the symbol itself doesn't mean anything
> because the sched-in of that symbol will not be printed(first sched-in
> contains pid and the corresponding symbol).
> 
> 6.8.0
> ======
>   *A0                   213864.670142 secs A0 => migration/0:18
>   *.                    213864.670148 secs .  => swapper:0
>    .  *B0               213864.670217 secs B0 => migration/1:21
>    .  *.                213864.670223 secs
>    .   .  *C0           213864.670247 secs C0 => migration/2:26
>    .   .  *.            213864.670252 secs
> 
> 6.8.0 + patch (--command-name = schbench)
> =============
>    **  .   ** *A0       213864.671055 secs A0 => schbench:104834
>   *B0  .   .   A0       213864.671156 secs B0 => schbench:104835
>   *C0  .   .   A0       213864.671187 secs C0 => schbench:104836
>   *D0  .   .   A0       213864.671219 secs D0 => schbench:104837
>   *E0  .   .   A0       213864.671250 secs E0 => schbench:104838
>    E0  .  *D0  A0
> 
> This helps in visualizing how a benchmark like schbench is spread over
> the available cpus while also knowing which cpus are idle(.) and which
> are not(**). This will be more useful as number of CPUs increase.

Yeah I think this is good!  Thanks for working on this.

But I guess people want to see when the tasks were sched out as well.
Can you please add that too?

> 
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  tools/perf/Documentation/perf-sched.txt |  4 ++++
>  tools/perf/builtin-sched.c              | 17 ++++++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index 5fbe42bd599b..b04a37560935 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -94,6 +94,10 @@ OPTIONS for 'perf sched map'
>  --color-pids::
>  	Highlight the given pids.
>  
> +--command-name::
> +	Map output only for the given command name.
> +	(** indicates other tasks while . is idle).

Probably we can support multiple names in CSV.

Thanks,
Namhyung


> +
>  OPTIONS for 'perf sched timehist'
>  ---------------------------------
>  -k::
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 0fce7d8986c0..e60836da53e5 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -156,6 +156,7 @@ struct perf_sched_map {
>  	const char		*color_pids_str;
>  	struct perf_cpu_map	*color_cpus;
>  	const char		*color_cpus_str;
> +	const char		*command;
>  	struct perf_cpu_map	*cpus;
>  	const char		*cpus_str;
>  };
> @@ -1594,8 +1595,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  
>  	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
>  
> -	printf("  ");
> -
>  	new_shortname = 0;
>  	if (!tr->shortname[0]) {
>  		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
> @@ -1605,7 +1604,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  			 */
>  			tr->shortname[0] = '.';
>  			tr->shortname[1] = ' ';
> -		} else {
> +		} else if (!sched->map.command || !strcmp(thread__comm_str(sched_in),
> +								sched->map.command)) {
>  			tr->shortname[0] = sched->next_shortname1;
>  			tr->shortname[1] = sched->next_shortname2;
>  
> @@ -1618,10 +1618,18 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
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
> +	if (sched->map.command && strcmp(thread__comm_str(sched_in), sched->map.command))
> +		goto skip;
> +
> +	printf("  ");
> +
>  	for (i = 0; i < cpus_nr; i++) {
>  		struct perf_cpu cpu = {
>  			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
> @@ -1678,6 +1686,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  out:
>  	color_fprintf(stdout, color, "\n");
>  
> +skip:
>  	thread__put(sched_in);
>  
>  	return 0;
> @@ -3560,6 +3569,8 @@ int cmd_sched(int argc, const char **argv)
>                      "highlight given CPUs in map"),
>  	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
>                      "display given CPUs in map"),
> +	OPT_STRING(0, "command-name", &sched.map.command, "command",
> +		"map output only for the given command name"),
>  	OPT_PARENT(sched_options)
>  	};
>  	const struct option timehist_options[] = {
> -- 
> 2.39.1
> 
