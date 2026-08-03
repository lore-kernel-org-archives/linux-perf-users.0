Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B94427F8D;
	Mon,  3 Aug 2026 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779971; cv=none; b=ROMnCXuZ/AlHiGfjpBMdcw6WQaMRxxBgxnEWEUWF4wdRVczmbfSoNpuqtkaRwdgbTTDg78yEIoiOa3JnnYynR70uJnayDu8A4s2YavzrznoKwpqMIWTNs6FJHlXhknchL61Pg4L+OmNYcfTye8vRbWY/kbDr9ptaUq2YqqW0n7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779971; c=relaxed/simple;
	bh=JAGBx4h8TwNXjFJvyf7x/DfPcqTE1fQVqS22Ns+lUKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSqSEy1lFfH4sgQWBU5e4XkYa/4vIqOqqvwxQhpSWdrftvWR2/L0TUNuVtT+UFWihod0yigcXr58Npvr5gWE6TTj6ITcsC4jRzYkhMxgUveAUUD8ocf57LHWdz8IcG0wRdFOoVhePTMDxJM48V1fEZfZYyZvs45dRn1mRiqokag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCY+wTOB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCY+wTOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C981F000E9;
	Mon,  3 Aug 2026 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785779966;
	bh=E/sA1uJMiAmrnMkeXrrlZXnqPFNC//fQXnf4g2ib9Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JCY+wTOBozf+Addt289pGNZVFsyfWHKi7yUJ/UE2agl8i7D6pZ0i/sQ7GWXt4E0cX
	 A1iE5awUAPp3Rsz0lYdZR1/7rG7+f8wC0VsfNVs9Ij9+PCNEJFgS0xVXdqX5eC84J1
	 n7DsQWlwPhSKt/SiIoj8K6osden9pFJwbnfazcX40xAVlwA0LHFcjteXDHCty1zGou
	 PVzSXz1QyHAgGOvgwru7g08Ltimck5allnSdMlmKPkHN3a7n6R8TlnjICrY6EiDk8K
	 KMFZqs8j21C+O7rjoxSQMSs/ehTNqVTl++bHk2AEzbG1/XWeF2sBBexRBCcz5nNlIg
	 hpEfGi2EXKDCQ==
Date: Mon, 3 Aug 2026 10:59:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com,
	chjohnst@mail.com, sean@ashe.io, steve@abita.co,
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] perf sched: Handle missing trace samples in pipe
 mode
Message-ID: <anDW_LwPhXrtBrUm@google.com>
References: <20260802210914.199941-1-atomlin@atomlin.com>
 <20260802210914.199941-3-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260802210914.199941-3-atomlin@atomlin.com>

On Sun, Aug 02, 2026 at 05:09:12PM -0400, Aaron Tomlin wrote:
> For pipe mode streams, event attributes are received dynamically during
> event processing, meaning session->evlist is not populated prior to
> perf_session__process_events(). To handle pipe input correctly:
>   - Register the missing .attr, .tracing_data, .build_id, and .feature
>     callbacks in cmd_sched()
> 
>   - Promote the handlers array to file-scope (latency_handlers[]) and
>     dynamically assign matching tracepoint handlers (or a dummy ignore
>     handler) inside perf_sched__process_tracepoint_sample() when
>     evsel->handler is NULL
> 
>   - Perform the trace check post-processing when handling pipe data
> 
> Fixes: 27295592c22e ("perf session: Share the common trace sample_check routine as perf_session__has_traces")
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/builtin-sched.c | 65 +++++++++++++++++++++++++++++---------
>  1 file changed, 50 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 94a323da0799..232e72537df3 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1938,6 +1938,22 @@ typedef int (*tracepoint_handler)(const struct perf_tool *tool,
>  				  struct perf_sample *sample,
>  				  struct machine *machine);
>  
> +static struct evsel_str_handler latency_handlers[] = {
> +	{ "sched:sched_switch",       process_sched_switch_event, },
> +	{ "sched:sched_stat_runtime", process_sched_runtime_event, },
> +	{ "sched:sched_wakeup",       process_sched_wakeup_event, },
> +	{ "sched:sched_waking",       process_sched_wakeup_event, },
> +	{ "sched:sched_wakeup_new",   process_sched_wakeup_event, },
> +	{ "sched:sched_migrate_task", process_sched_migrate_task_event, },
> +};
> +
> +static int process_sched_ignore(const struct perf_tool *tool __maybe_unused,
> +				struct perf_sample *sample __maybe_unused,
> +				struct machine *machine __maybe_unused)
> +{
> +	return 0;
> +}
> +
>  static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __maybe_unused,
>  						 union perf_event *event __maybe_unused,
>  						 struct perf_sample *sample,
> @@ -1946,7 +1962,22 @@ static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __
>  	struct evsel *evsel = sample->evsel;
>  	int err = 0;
>  
> -	if (evsel->handler != NULL) {
> +	if (evsel->handler == NULL) {
> +		evsel->handler = process_sched_ignore;
> +		for (size_t i = 0; i < ARRAY_SIZE(latency_handlers); i++) {
> +			if (evsel__name_is(evsel, latency_handlers[i].name)) {

Please consider using 'continue' statement for the opposite case to
reduce the indent level.


> +				if (!strcmp(latency_handlers[i].name, "sched:sched_wakeup") &&
> +				    sample->evsel->evlist &&
> +				    evlist__find_tracepoint_by_name(sample->evsel->evlist, "sched:sched_waking"))
> +					evsel->handler = process_sched_wakeup_ignore;

Probably better to use/keep the process_sched_ignore().

I think we could replace others to use the function and get rid of the
dummy wakeup_ignore functions.  But it could be a separate change.

Thanks,
Namhyung


> +				else
> +					evsel->handler = latency_handlers[i].handler;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (evsel->handler != process_sched_ignore) {
>  		tracepoint_handler f = evsel->handler;
>  		err = f(tool, sample, machine);
>  	}
> @@ -1987,14 +2018,6 @@ static int perf_sched__process_comm(const struct perf_tool *tool __maybe_unused,
>  
>  static int perf_sched__read_events(struct perf_sched *sched)
>  {
> -	struct evsel_str_handler handlers[] = {
> -		{ "sched:sched_switch",	      process_sched_switch_event, },
> -		{ "sched:sched_stat_runtime", process_sched_runtime_event, },
> -		{ "sched:sched_wakeup",	      process_sched_wakeup_event, },
> -		{ "sched:sched_waking",	      process_sched_wakeup_event, },
> -		{ "sched:sched_wakeup_new",   process_sched_wakeup_event, },
> -		{ "sched:sched_migrate_task", process_sched_migrate_task_event, },
> -	};
>  	struct perf_session *session;
>  	struct perf_data data = {
>  		.path  = input_name,
> @@ -2011,14 +2034,17 @@ static int perf_sched__read_events(struct perf_sched *sched)
>  
>  	symbol__init(perf_session__env(session));
>  
> -	/* prefer sched_waking if it is captured */
> -	if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
> -		handlers[2].handler = process_sched_wakeup_ignore;
> +	if (!perf_data__is_pipe(session->data)) {
> +		/* prefer sched_waking if it is captured */
> +		if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
> +			latency_handlers[2].handler = process_sched_wakeup_ignore;
>  
> -	if (perf_session__set_tracepoints_handlers(session, handlers))
> -		goto out_delete;
> +		if (perf_session__set_tracepoints_handlers(session, latency_handlers))
> +			goto out_delete;
> +	}
>  
> -	if (!perf_session__has_traces(session, "record -R"))
> +	if (!perf_data__is_pipe(session->data) &&
> +	    !perf_session__has_traces(session, "record -R"))
>  		goto out_delete;
>  
>  	err = perf_session__process_events(session);
> @@ -2027,6 +2053,11 @@ static int perf_sched__read_events(struct perf_sched *sched)
>  		goto out_delete;
>  	}
>  
> +	if (perf_data__is_pipe(session->data) &&
> +	    !perf_session__has_traces(session, "record -R")) {
> +		goto out_delete;
> +	}
> +
>  	sched->nr_events      = session->evlist->stats.nr_events[0];
>  	sched->nr_lost_events = session->evlist->stats.total_lost;
>  	sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
> @@ -5168,6 +5199,10 @@ int cmd_sched(int argc, const char **argv)
>  	sched.tool.namespaces	 = perf_event__process_namespaces;
>  	sched.tool.lost		 = perf_event__process_lost;
>  	sched.tool.fork		 = perf_sched__process_fork_event;
> +	sched.tool.attr		 = perf_event__process_attr;
> +	sched.tool.tracing_data	 = perf_event__process_tracing_data;
> +	sched.tool.build_id	 = perf_event__process_build_id;
> +	sched.tool.feature       = perf_event__process_feature;
>  
>  	argc = parse_options_subcommand(argc, argv, sched_options, sched_subcommands,
>  					sched_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> -- 
> 2.55.0
> 
