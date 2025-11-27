Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA36830F7ED;
	Thu, 27 Nov 2025 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279284; cv=none; b=ZpLW3XN1U41ZAz+LJ7PYi/wfq0/aBk0RoHXRxxlaIX23Pxe6fV+CMUjqfG8nz42IBy3KMrlEDzPeYso6VnoLq9x1R6O/sFpZkOxX68CBA0lon57Ne/y9gqcvJ7IP+QmiH2M1dxvDg0slo5LM7m4ngRN5F1HNpN3eZyW3JFvFNJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279284; c=relaxed/simple;
	bh=fReJ7B0zzohyHeXgCW2gHW6cexupyNkwi03bPHKdIJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjusVkOJhSawNg1jwE3vN7CYdqTBOUPNiAA9W+XNO9uhcTERznQ+qjPejufUoR22H+FBWW/aRmSbv4xERhgJZkpJ/VYll7W5cf3eNWqKIPk6vGLCoYqhpm/3aBqwCpF9BsTzy1k/f7ElbBwnfigj0dqEia2D6uSN9MUq1vqgYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuK3l+50; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuK3l+50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540C9C4CEF8;
	Thu, 27 Nov 2025 21:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764279283;
	bh=fReJ7B0zzohyHeXgCW2gHW6cexupyNkwi03bPHKdIJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AuK3l+50f8ZOQoe1H1b7drQUYSY6J4cLqDJySMLMVsdMC8/1TqPRSViLC9H+t78xs
	 xmLeuB0BWHGja9MTwRgJ3x4DRD99VXVKtp3D4KQPg9ktHI3Q/xaLixPOBhN8kGpSwk
	 gK6nma1bjh+DtadS1I/jH5z7shFhWP0kGGUdFxMnawq7yLL6nWiunHBnM/aM4+U9dV
	 O9YUnCFxhVacdK29FDTK++ZlvzKDghzR3GvFhAYQiJx8SN/3YsYHCgnlSIOEw6V/qp
	 Unlecowr3CzPsnjehbnCwEFh7jThHOdcUBjb7sfQ+8pVf2IJVy0hfNyBuKFHKFc4Rl
	 reDoxUYV+ecog==
Date: Thu, 27 Nov 2025 13:34:41 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Derek Foreman <derek.foreman@collabora.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, kernel@collabora.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf data: Allow filtering conversion by start and end
 time
Message-ID: <aSjD8WC9qUzjrvH6@google.com>
References: <20251124212301.450296-1-derek.foreman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251124212301.450296-1-derek.foreman@collabora.com>

Hello,

On Mon, Nov 24, 2025 at 03:23:00PM -0600, Derek Foreman wrote:
> This adds a feature to allow restricting the range of converted samples
> with start and end times specified in nanoseconds.
> 
> Use it like this:
> 
>   $ perf data convert --to-json out.json -s 12345 -e 13340
> 
> Start, end, or both may be omitted.

Looks useful, thanks!

> 
> Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
> ---
>  tools/perf/Documentation/perf-data.txt |  6 ++++++
>  tools/perf/builtin-data.c              |  4 ++++
>  tools/perf/util/data-convert-bt.c      | 18 ++++++++++++++++++
>  tools/perf/util/data-convert-json.c    | 18 ++++++++++++++++++
>  tools/perf/util/data-convert.h         |  3 +++
>  5 files changed, 49 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
> index 417bf17e265c..db0de1f354a3 100644
> --- a/tools/perf/Documentation/perf-data.txt
> +++ b/tools/perf/Documentation/perf-data.txt
> @@ -40,6 +40,12 @@ OPTIONS for 'convert'
>  --force::
>  	Don't complain, do it.
>  
> +-s::

Please add this as well.

--start=<TIME>::

> +	Start time, in nanoseconds. Samples before this time will not be converted.

It'd be nice if you mention that users can see the timestamp from perf
script or so.


> +
> +-e::

--end=<TIME>::

> +	End time, in nanoseconds. Samples after this time will not be converted.
> +
>  -v::
>  --verbose::
>          Be more verbose (show counter open errors, etc).
> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
> index ce51cbf6dc97..da813c62e284 100644
> --- a/tools/perf/builtin-data.c
> +++ b/tools/perf/builtin-data.c
> @@ -33,6 +33,8 @@ const char *to_ctf;
>  struct perf_data_convert_opts opts = {
>  	.force = false,
>  	.all = false,
> +	.range_start = 0,
> +	.range_end = 0,
>  };
>  
>  const struct option data_options[] = {
> @@ -45,6 +47,8 @@ const struct option data_options[] = {
>  #endif
>  		OPT_BOOLEAN('f', "force", &opts.force, "don't complain, do it"),
>  		OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"),
> +		OPT_U64('s', "start", &opts.range_start, "Earliest timestamp to convert"),
> +		OPT_U64('e', "end", &opts.range_end, "Latest timestamp to convert"),
>  		OPT_END()
>  	};
>  
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> index 3d2e437e1354..6819f11fe900 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -91,9 +91,13 @@ struct convert {
>  	struct perf_tool	tool;
>  	struct ctf_writer	writer;
>  
> +	u64			start;
> +	u64			end;
> +
>  	u64			events_size;
>  	u64			events_count;
>  	u64			non_sample_count;
> +	u64			skipped;
>  
>  	/* Ordered events configured queue size. */
>  	u64			queue_size;
> @@ -811,6 +815,12 @@ static int process_sample_event(const struct perf_tool *tool,
>  	if (WARN_ONCE(!priv, "Failed to setup all events.\n"))
>  		return 0;
>  
> +	if (sample->time < c->start ||
> +	    (c->end && sample->time > c->end)) {
> +		++c->skipped;
> +		return 0;
> +	}
> +
>  	event_class = priv->event_class;
>  
>  	/* update stats */
> @@ -1626,6 +1636,9 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>  	c.tool.namespaces      = perf_event__process_namespaces;
>  	c.tool.ordering_requires_timestamps = true;
>  
> +	c.start = opts->range_start;
> +	c.end = opts->range_end;
> +
>  	if (opts->all) {
>  		c.tool.comm = process_comm_event;
>  		c.tool.exit = process_exit_event;
> @@ -1677,6 +1690,11 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>  		"[ perf data convert: Converted '%s' into CTF data '%s' ]\n",
>  		data.path, path);
>  
> +	if (c.skipped)
> +		fprintf(stderr,
> +			"[ perf data convert: Skipped %" PRIu64 " samples",
> +			c.skipped);

This is a strange style to have the literal in a different line.  It'd
be nice if you can fix others too - probably in a separate commit.

And this line could come after the next, but it's up to you.

Also it'd be recommended to have a pair of parentheses for multi-line
bodies even it's a single statement.

> +
>  	fprintf(stderr,
>  		"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples",
>  		(double) c.events_size / 1024.0 / 1024.0,
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index 9dc1e184cf3c..dcbba34d6b08 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -35,7 +35,11 @@ struct convert_json {
>  	struct perf_tool tool;
>  	FILE *out;
>  	bool first;
> +	u64 start;
> +	u64 end;
> +
>  	u64 events_count;
> +	u64 skipped;
>  };
>  
>  // Outputs a JSON-encoded string surrounded by quotes with characters escaped.
> @@ -165,6 +169,12 @@ static int process_sample_event(const struct perf_tool *tool,
>  		return -1;
>  	}
>  
> +	if (sample->time < c->start ||
> +	    (c->end && sample->time > c->end)) {
> +		++c->skipped;
> +		return 0;
> +	}
> +
>  	++c->events_count;
>  
>  	if (c->first)
> @@ -320,6 +330,9 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
>  	struct convert_json c = {
>  		.first = true,
>  		.events_count = 0,
> +		.start = opts->range_start,
> +		.end = opts->range_end,
> +		.skipped = 0,
>  	};
>  	struct perf_data data = {
>  		.mode = PERF_DATA_MODE_READ,
> @@ -407,6 +420,11 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
>  			"[ perf data convert: Converted '%s' into JSON data '%s' ]\n",
>  			data.path, output_name);
>  
> +	if (c.skipped)
> +		fprintf(stderr,
> +				"[ perf data convert: Skipped %" PRIu64 " samples.\n",
> +				c.skipped);

Ditto.

Thanks,
Namhyung

> +
>  	fprintf(stderr,
>  			"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples) ]\n",
>  			(ftell(c.out)) / 1024.0 / 1024.0, c.events_count);
> diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
> index 1b4c5f598415..5d055e1c31c8 100644
> --- a/tools/perf/util/data-convert.h
> +++ b/tools/perf/util/data-convert.h
> @@ -3,11 +3,14 @@
>  #define __DATA_CONVERT_H
>  
>  #include <stdbool.h>
> +#include <linux/types.h>
>  
>  struct perf_data_convert_opts {
>  	bool force;
>  	bool all;
>  	bool tod;
> +	u64 range_start;
> +	u64 range_end;
>  };
>  
>  #ifdef HAVE_LIBBABELTRACE_SUPPORT
> -- 
> 2.47.3
> 
