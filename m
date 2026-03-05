Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3F1EEBA;
	Thu,  5 Mar 2026 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692793; cv=none; b=CYV5HCz/RReEthGIhP6pS7WEQQ15JP5WGfLrV9gY823rCtJIOn2pdEeN2fkxvRUskdzUH1adgYjpMRGHr3NoJpAWBJA2BDnD3Db03a9DD7MGWBbBzZBWzLBXh0on9ZseDRGStmMlfSjHeZdjc24+9roJHGjZQBvkzPJNuS4/vvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692793; c=relaxed/simple;
	bh=k81IUKBtJLwZrGmN/xV4OqojfKX88TIuOxTZAnXXy5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rul8KSwijIHg1r0o+0MIoqwVyI/+88o3Rs0a8otUZr4xYWYHhgMYJrl5vnPSjAZwa7X9ciNwfdnnF8XWpw2yqRtR40Idh4ZsTOKj7qJuyvaoYvMGlSIoIrnpW0pjwNvreCmmtd4YeQ+HJT9djm8tT0Zkg2NqvAUXc2zT4gpo+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klztSzM1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klztSzM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4383EC116C6;
	Thu,  5 Mar 2026 06:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772692793;
	bh=k81IUKBtJLwZrGmN/xV4OqojfKX88TIuOxTZAnXXy5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klztSzM1Nd4QmB6RLYIpQ2csd4zB7vIqWAA/Z5/Gzb22Atsa0Cdesvh/LjpWXPoDs
	 bxvyGohkQfDYIvK5yaiMfbXRoUcjBxsJy94zj61qFaxYgxANCBjmxFxGmw78dyDJHu
	 JPGk+AKIXEDcCMY4tk4jeZ1SIwv+TU3j17F8GPQ3Edl/VfNIeLFAPtWvTHFy8dC5GO
	 SLdSDfe1TjhmHQaGDMeRWTgmuFZoHx6bf23tnUsGkm36Dcka6uN1GwbD+mwwJLH9Ot
	 n/hwT0KWJ/f1CbnUj5RNstNPsTSxzjACjw6ODGDLLuPj6ZrrluJ8yBiLBiS7kzJ8z1
	 7aWbDjc0o5pQA==
Date: Wed, 4 Mar 2026 22:39:50 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Derek Foreman <derek.foreman@collabora.com>,
	Howard Chu <howardchu95@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Hrishikesh Suresh <hrishikesh123s@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] perf data convert ctf: Pipe mode improvements
Message-ID: <aaklNmye9-6rsTCb@z2>
References: <20260228065953.3226283-1-irogers@google.com>
 <20260228065953.3226283-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260228065953.3226283-8-irogers@google.com>

On Fri, Feb 27, 2026 at 10:59:53PM -0800, Ian Rogers wrote:
> Handle the finished_round event. Set up the CTF events when the
> feature event desc is read. In pipe mode the attr events will create
> the evsels and the feature event desc events will name the evsels. The
> CTF events need the evsel name, so wait until feature event descs are
> read (in pipe mode) before setting up the events except for tracepoint
> events. Handle the tracing_data event so that tracepoint information
> is available when setting up tracepoint events.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/data-convert-bt.c | 54 +++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> index 665bf8eea24b..5d35e9822b8f 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -1223,13 +1223,28 @@ static int add_event(struct ctf_writer *cw, struct evsel *evsel)
>  	return -1;
>  }
>  
> -static int setup_events(struct ctf_writer *cw, struct perf_session *session)
> +enum setup_events_type {
> +	SETUP_EVENTS_ALL,
> +	SETUP_EVENTS_NOT_TRACEPOINT,
> +	SETUP_EVENTS_TRACEPOINT_ONLY,
> +};
> +
> +static int setup_events(struct ctf_writer *cw, struct perf_session *session,
> +			enum setup_events_type type)
>  {
>  	struct evlist *evlist = session->evlist;
>  	struct evsel *evsel;
>  	int ret;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> +		bool is_tracepoint = evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
> +
> +		if (is_tracepoint && type == SETUP_EVENTS_NOT_TRACEPOINT)
> +			continue;
> +
> +		if (!is_tracepoint && type == SETUP_EVENTS_TRACEPOINT_ONLY)
> +			continue;
> +
>  		ret = add_event(cw, evsel);
>  		if (ret)
>  			return ret;
> @@ -1418,6 +1433,18 @@ static int process_feature_event(const struct perf_tool *tool,
>  		return ret;
>  
>  	switch (fe->feat_id) {
> +	case HEADER_EVENT_DESC:
> +		/*
> +		 * In non-pipe mode (not here) the evsels combine the desc with
> +		 * the perf_event_attr when it is parsed. In pipe mode the
> +		 * perf_event_attr events appear first and then the event desc
> +		 * feature events that set the names appear after. Once we have
> +		 * the full evsel data we can generate the babeltrace
> +		 * events. For tracepoint events we still don't have the tracing
> +		 * data and so need to wait until the tracing data event to add
> +		 * those events to babeltrace.
> +		 */
> +		return setup_events(cw, session, SETUP_EVENTS_NOT_TRACEPOINT);
>  	case HEADER_HOSTNAME:
>  		if (session->header.env.hostname) {
>  			return bt_ctf_writer_add_environment_field(cw->writer, "host",
> @@ -1448,6 +1475,26 @@ static int process_feature_event(const struct perf_tool *tool,
>  	return 0;
>  }
>  
> +static int process_tracing_data(const struct perf_tool *tool,
> +				struct perf_session *session,
> +				union perf_event *event)
> +{
> +	struct convert *c = container_of(tool, struct convert, tool);
> +	struct ctf_writer *cw = &c->writer;
> +	int ret;
> +
> +	ret = perf_event__process_tracing_data(tool, session, event);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Now the attr was set up by the attr event, the name by the feature
> +	 * event desc event and the tracepoint data set up above, the tracepoint
> +	 * babeltrace events can be added.
> +	 */
> +	return setup_events(cw, session, SETUP_EVENTS_TRACEPOINT_ONLY);
> +}
> +
>  static int ctf_writer__setup_clock(struct ctf_writer *cw,
>  				   struct perf_session *session,
>  				   bool tod)
> @@ -1677,9 +1724,10 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>  	c.tool.exit            = perf_event__process_exit;
>  	c.tool.fork            = perf_event__process_fork;
>  	c.tool.lost            = perf_event__process_lost;
> -	c.tool.tracing_data    = perf_event__process_tracing_data;
> +	c.tool.tracing_data    = process_tracing_data;
>  	c.tool.build_id        = perf_event__process_build_id;
>  	c.tool.namespaces      = perf_event__process_namespaces;
> +	c.tool.finished_round  = perf_event__process_finished_round;
>  	c.tool.attr            = perf_event__process_attr;
>  	c.tool.feature         = process_feature_event;
>  	c.tool.ordering_requires_timestamps = true;
> @@ -1725,7 +1773,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>  		goto free_writer;
>  
>  	/* CTF events setup */
> -	if (setup_events(cw, session))
> +	if (setup_events(cw, session, SETUP_EVENTS_ALL))

I was wondering if it'd add duplicate events in pipe mode.  But it turns
out that it would do nothing in pipe mode as no event was found at the
moment.

Can you please update the comment that it's for file, and pipe mode will
be handled differently?

Thanks,
Namhyung


>  		goto free_writer;
>  
>  	if (opts->all && setup_non_sample_events(cw, session))
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 
