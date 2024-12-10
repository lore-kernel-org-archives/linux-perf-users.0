Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150455661;
	Tue, 10 Dec 2024 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789383; cv=none; b=s8/M+H8qnZ7CsaFiqnfvZuSPIlU7fSsAlWbZ7WDObmDdV/krilYNaQNTY4Leihb1bylwbLFJ+ioSC7Pf8ZdrrWIb+oxJj8DxGBy+Khn0Qm4dyIDJG3f3mOh26qto9xBrPu0031tcRlqlnCKJghwCEmKpet8306NDX2EpFvhWCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789383; c=relaxed/simple;
	bh=TRiZvDR17O+Q8hOoqxwzTU1eXPC4SFxTM+8FVf170gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFCPIASZCLk0hbZvSWVbjVb2it2sYA8aNCYWf6e06t6Ant1uTpZAgEOUaLQN2WOs3qfXKuxi0d/LTPn5AsFS5ZsJhvhFfdmGhQsnfk2wE/DvOGc6XJP8n0CSPh2Aoo/7q0nhTfrnJaEpJMu9lq5MrbHnRNNtz/DoKFQqNoNSifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loaRffZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loaRffZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206CAC4CED1;
	Tue, 10 Dec 2024 00:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733789381;
	bh=TRiZvDR17O+Q8hOoqxwzTU1eXPC4SFxTM+8FVf170gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loaRffZAmj0AIJZfYvHb8h1vA27b1LDAOS2+DnSr3/+FoFDG10/lzy1oWnmcouwoC
	 mepxBDLbDWCJijFKtlNoDUfV58L464FtCi6tidFYvueu2X4CDi/mSSvlIpiFB4Udp0
	 pJofdm6ewrJCpYbmlyiJ1e3uf9tpmZdEzzQbmWKmWrpB9mAlfGYAMQEbhJU0GY3iN6
	 qoDTCGwWBpjzjtjB4DxyVckC6HAtN5Jpy0BqwN870U8bdi9Jm/a0G9YRxgP+yEcKQm
	 JrQ0fp6eltIQyMM9+E66cfw5wE5A+hu+i/uFwDmVYu+opkrRSvZSEDTlwBqS10mmYt
	 B4pnGyjgUQCUQ==
Date: Mon, 9 Dec 2024 16:09:39 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v9 01/10] perf record --off-cpu: Add --off-cpu-thresh
 option
Message-ID: <Z1eGw52LThYh1Gjx@google.com>
References: <20241122043840.217453-1-howardchu95@gmail.com>
 <20241122043840.217453-2-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122043840.217453-2-howardchu95@gmail.com>

Hi Howard,

Sorry for the late review.

On Thu, Nov 21, 2024 at 08:38:31PM -0800, Howard Chu wrote:
> Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
> the unit is us (microsecond). Default value is 500,000us (500ms, 0.5s).

I guess we mostly care about more than milli-seconds of off-cpu times.
Can we change the unit to msec?

Also I think this commit can be moved to later in this series - like
after implementing direct offcpu samples.  If I see the commit in
history later, I'd think it works.  But it's not at this point.

Otherwise, looks all good to me. :)

Thanks,
Namhyung

> 
> Example:
> 
>   perf record --off-cpu --off-cpu-thresh 400000
> 
> The example above collects off-cpu samples whose off-cpu time is longer
> than 400,000us
> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
>  tools/perf/Documentation/perf-record.txt |  9 ++++++++
>  tools/perf/builtin-record.c              | 26 ++++++++++++++++++++++++
>  tools/perf/util/off_cpu.h                |  1 +
>  tools/perf/util/record.h                 |  1 +
>  4 files changed, 37 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 242223240a08..05c8977983de 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -829,6 +829,15 @@ filtered through the mask provided by -C option.
>  	only, as of now.  So the applications built without the frame
>  	pointer might see bogus addresses.
>  
> +	off-cpu profiling consists two types of samples: direct samples, which
> +	share the same behavior as regular samples, and the accumulated
> +	samples, stored in BPF stack trace map, presented after all the regular
> +	samples.
> +
> +--off-cpu-thresh::
> +	Once a task's off-cpu time reaches this threshold, it generates a
> +	direct off-cpu sample.
> +
>  --setup-filter=<action>::
>  	Prepare BPF filter to be used by regular users.  The action should be
>  	either "pin" or "unpin".  The filter can be used after it's pinned.
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
