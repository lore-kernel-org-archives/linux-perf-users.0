Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FEE17BA3;
	Mon, 18 Nov 2024 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964172; cv=none; b=VFmU6XinNdwAujYh/T5wOv0pZ2jI8uvIjNJ7E8DKHiElWIcFGofEEpoVfpdRIaJmDedj1sKzvI8TozbWgO/oejSjHsyErWZQXIarSSEDNE7Z+6V5eCpsIDCAlJ6MbFMjc3JFDPB9kz8uCvud0bBI7GQfVC3IKfVX0b75yd87ysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964172; c=relaxed/simple;
	bh=dzd5GAnO2vMvLhfVZwgpxhH6Zqx4+TRRGuxsgsdTjvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+04TN0B9EjwsuXAMXej6TSBCH0CH+n0WGIjMcwVcrvcWeYyHVH0e88KaTp5UTYfIS9J7eIw059WiCZHDyBHNc3v9L7mHutOE/r5IUJuakZnJFhtoqUbNwv+vOGHXDrb9PsY6IheBmKeKt+QSpltOGDzPGvNaJU49EIY2o5AwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hn/pm4/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn/pm4/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB8DC4CED0;
	Mon, 18 Nov 2024 21:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964171;
	bh=dzd5GAnO2vMvLhfVZwgpxhH6Zqx4+TRRGuxsgsdTjvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hn/pm4/PAyIB4SHOQyI112PSqeZxTEyC4OpNOtMWrMYjAEA12aVwYA6MAULkmCJ+y
	 D/Rvwy533KxTcFXH06we5HT+IJgua5ce2rnWW1v+d0wzhxBBb1bBjqTDoOmqYo7eXZ
	 4S+P0yXP51Mb/cGofBT6Ts4AwqGwpI9gNptQMj95PpFO2+16lJZcOyQDzJk+++SS+s
	 0I8RyXRehu0gunl4SntPOv8xywIa/sTWG8qdYINWRTRsG9p0fAXG1o3tylUXl5BKnJ
	 n6NrVvxRnzo7uvZg5ZV+3RENHxxBbXrGj9OrW22klAHKLhEB0z8Vyf/7RoESlTlpe9
	 8GRYhgXthtHzA==
Date: Mon, 18 Nov 2024 13:09:29 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, irogers@google.com,
	mingo@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v8 01/10] perf record --off-cpu: Add --off-cpu-thresh
 option
Message-ID: <ZzutCSbEU-5UZXc3@google.com>
References: <20241113002818.3578645-1-howardchu95@gmail.com>
 <20241113002818.3578645-2-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113002818.3578645-2-howardchu95@gmail.com>

Hello Howard,

On Tue, Nov 12, 2024 at 04:28:09PM -0800, Howard Chu wrote:
> Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
> the unit is us (microsecond). Default value is 500000us (500ms, 0.5s).

I think it's better to add an option after you implemented the feature.
Before that you may hardcode the threshold if necessary.

Also it'd be a good practice to add an example for the option in the
commit message.

> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20241108204137.2444151-2-howardchu95@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-record.c | 26 ++++++++++++++++++++++++++
>  tools/perf/util/off_cpu.h   |  1 +
>  tools/perf/util/record.h    |  1 +

Please update the documentation if you add a new option.

Thanks,
Namhyung


>  3 files changed, 28 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index f83252472921..c069000efe5c 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3149,6 +3149,28 @@ static int record__parse_mmap_pages(const struct option *opt,
>  	return ret;
>  }
>  
> +static int record__parse_off_cpu_thresh(const struct option *opt,
> +					const char *str,
> +					int unset __maybe_unused)
> +{
> +	struct record_opts *opts = opt->value;
> +	char *endptr;
> +	u64 off_cpu_thresh_us;
> +
> +	if (!str)
> +		return -EINVAL;
> +
> +	off_cpu_thresh_us = strtoull(str, &endptr, 10);
> +
> +	/* threshold isn't string "0", yet strtoull() returns 0, parsing failed */
> +	if (*endptr || (off_cpu_thresh_us == 0 && strcmp(str, "0")))
> +		return -EINVAL;
> +	else
> +		opts->off_cpu_thresh_us = off_cpu_thresh_us;
> +
> +	return 0;
> +}
> +
>  void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __maybe_unused)
>  {
>  }
> @@ -3342,6 +3364,7 @@ static struct record record = {
>  		.ctl_fd              = -1,
>  		.ctl_fd_ack          = -1,
>  		.synth               = PERF_SYNTH_ALL,
> +		.off_cpu_thresh_us   = OFFCPU_THRESH,
>  	},
>  };
>  
> @@ -3564,6 +3587,9 @@ static struct option __record_options[] = {
>  	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
>  	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
>  		   "BPF filter action"),
> +	OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "us",
> +		     "Dump off-cpu samples if off-cpu time reaches this threshold. The unit is microsecond (default: 500000)",
> +		     record__parse_off_cpu_thresh),
>  	OPT_END()
>  };
>  
> diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
> index 2dd67c60f211..c6edc0f7c40d 100644
> --- a/tools/perf/util/off_cpu.h
> +++ b/tools/perf/util/off_cpu.h
> @@ -16,6 +16,7 @@ struct record_opts;
>  			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
>  			      PERF_SAMPLE_CGROUP)
>  
> +#define OFFCPU_THRESH 500000ull
>  
>  #ifdef HAVE_BPF_SKEL
>  int off_cpu_prepare(struct evlist *evlist, struct target *target,
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index a6566134e09e..2ca74add26c0 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -79,6 +79,7 @@ struct record_opts {
>  	int	      synth;
>  	int	      threads_spec;
>  	const char    *threads_user_spec;
> +	u64	      off_cpu_thresh_us;
>  };
>  
>  extern const char * const *record_usage;
> -- 
> 2.43.0
> 
