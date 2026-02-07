Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA219C566;
	Sat,  7 Feb 2026 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770468667; cv=none; b=Z4iZaYSw++R1DsIyaB9Fza7gyJHN2FPM4XB4kDj/DhZXou0PrhvZfmiHmBTO8yKKfhPYV08TQYxnp4PAo5K6HPK2IddYNLTvpiQqaQZzzKZeNqOp6BhxYqO65JZ08Pko2S/3gyW2mOIWVVL0NQpAdDIJkgfQ+iV45Lav4NJBSrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770468667; c=relaxed/simple;
	bh=KcoP1L+2m8YDoJTv8viQnElGh4MC4o3kw2wvQXWpH/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlLW0qR83mmPbJ1herizE4TueWBjsA6encDq1ldSowuaOOIJfe1qXkoOkqNNISh2LBIrxeR49qMtMBP1/nqM65Jhdx7sdULd3TTJui+fU53nw1YKKbiP+WkmyGFzBQ4d+C8FPV9pEEIVBdHsqxSLBKdpblNSFDiYCAG+rYU657g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkTJ6jVo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkTJ6jVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4DAC116D0;
	Sat,  7 Feb 2026 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770468667;
	bh=KcoP1L+2m8YDoJTv8viQnElGh4MC4o3kw2wvQXWpH/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkTJ6jVoYO7VJhX76qeHtf67lv43738OcXGvSm9XI7im2gTCiBBTA5ADLF5gHgOzR
	 naU0kV0ffTXrrfF5Xs6h2O6hk8MXXPiFG9bGtLN4cnb9O/4totpU5CBsspvWLvoHHq
	 FYH73EXSx5Fm18bqdpgCd4SmmT4KJBpLpwRatQY89Cv52sRTJbJnw+wmkCqu9trSTI
	 zyVcKU4KOXq9gIZ+IvhmhuGnxSuI0HIrFmlECJv71BJV6O4cDlQGB85MRjGzhLnAtL
	 IPjT85LKO953Qr98WFiFWMX4g+jlw1GZlhmxI/ArASm05/tz20YjGvKhIfk1YWERGF
	 VOKkAaoLBtPBA==
Date: Sat, 7 Feb 2026 09:51:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, ak@linux.intel.com,
	alexander.shishkin@linux.intel.com, andres@anarazel.de,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux@treblig.org,
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
	thomas.falcon@intel.com, tmricht@linux.ibm.com,
	yang.lee@linux.alibaba.com
Subject: Re: [PATCH v8 6/6] perf stat: Add no-affinity flag
Message-ID: <aYc1NrEYIMxKzlCF@x1>
References: <aYZnkYqWXnKpHd3h@x1>
 <20260206222509.982489-1-irogers@google.com>
 <20260206222509.982489-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206222509.982489-7-irogers@google.com>

On Fri, Feb 06, 2026 at 02:25:09PM -0800, Ian Rogers wrote:
> Add flag that disables affinity behavior. Using sched_setaffinity to
> place a perf thread on a CPU can avoid certain interprocessor
> interrupts but may introduce a delay due to the scheduling,
> particularly on loaded machines. Add a command line option to disable
> the behavior. This behavior is less present in other tools like `perf
> record`, as it uses a ring buffer and doesn't make repeated system
> calls.

This is confusing:

⬢ [acme@toolbx perf-tools-next]$ perf stat -h affinity

 Usage: perf stat [<options>] [<command>]

        --affinity        don't allow affinity optimizations aimed at reducing IPIs

⬢ [acme@toolbx perf-tools-next]$

The way it is presented in the -h output it looks as if one has to use:

	perf stat --affinity

To disable affinity setting, when used that way it looks as if the user
is asking for affinity to be used.

We have things like:

⬢ [acme@toolbx perf-tools-next]$ grep -A2 OPT_.*no- tools/perf/builtin-record.c
	OPT_BOOLEAN(0, "no-buffering", &record.opts.no_buffering,
		    "collect data without buffering"),
	OPT_BOOLEAN('R', "raw-samples", &record.opts.raw_samples,
--
	OPT_BOOLEAN_SET('i', "no-inherit", &record.opts.no_inherit,
			&record.opts.no_inherit_set,
			"child tasks do not inherit counters"),
--
	OPT_BOOLEAN(0, "no-bpf-event", &record.opts.no_bpf_event, "do not record bpf events"),
	OPT_BOOLEAN(0, "strict-freq", &record.opts.strict_freq,
		    "Fail if the specified frequency can't be used"),
--
	OPT_BOOLEAN('n', "no-samples", &record.opts.no_samples,
		    "don't sample"),
	OPT_BOOLEAN_SET('N', "no-buildid-cache", &record.no_buildid_cache,
			&record.no_buildid_cache_set,
			"do not update the buildid cache"),
	OPT_BOOLEAN_SET('B', "no-buildid", &record.no_buildid,
			&record.no_buildid_set,
			"do not collect buildids in perf.data"),
⬢ [acme@toolbx perf-tools-next]$

Probably this needs to be that way?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-stat.txt | 4 ++++
>  tools/perf/builtin-stat.c              | 6 ++++++
>  tools/perf/util/evlist.c               | 6 +-----
>  tools/perf/util/evlist.h               | 1 +
>  4 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 1a766d4a2233..1ffb510606af 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -382,6 +382,10 @@ color the metric's computed value.
>  Don't print output, warnings or messages. This is useful with perf stat
>  record below to only write data to the perf.data file.
>  
> +--no-affinity::
> +Don't change scheduler affinities when iterating over CPUs. Disables
> +an optimization aimed at minimizing interprocessor interrupts.
> +
>  STAT RECORD
>  -----------
>  Stores stat data into perf data file.
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index c1bb40b99176..8bbdea44c3ba 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2426,6 +2426,7 @@ static int parse_tpebs_mode(const struct option *opt, const char *str,
>  int cmd_stat(int argc, const char **argv)
>  {
>  	struct opt_aggr_mode opt_mode = {};
> +	bool affinity = true, affinity_set = false;
>  	struct option stat_options[] = {
>  		OPT_BOOLEAN('T', "transaction", &transaction_run,
>  			"hardware transaction statistics"),
> @@ -2554,6 +2555,8 @@ int cmd_stat(int argc, const char **argv)
>  			"don't print 'summary' for CSV summary output"),
>  		OPT_BOOLEAN(0, "quiet", &quiet,
>  			"don't print any output, messages or warnings (useful with record)"),
> +		OPT_BOOLEAN_SET(0, "affinity", &affinity, &affinity_set,
> +			"don't allow affinity optimizations aimed at reducing IPIs"),
>  		OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
>  			"Only enable events on applying cpu with this type "
>  			"for hybrid platform (e.g. core or atom)",
> @@ -2611,6 +2614,9 @@ int cmd_stat(int argc, const char **argv)
>  	} else
>  		stat_config.csv_sep = DEFAULT_SEPARATOR;
>  
> +	if (affinity_set)
> +		evsel_list->no_affinity = !affinity;
> +
>  	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
>  		argc = __cmd_record(stat_options, &opt_mode, argc, argv);
>  		if (argc < 0)
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 45833244daf3..591bdf0b3e2a 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -369,11 +369,7 @@ static bool evlist__use_affinity(struct evlist *evlist)
>  	struct perf_cpu_map *used_cpus = NULL;
>  	bool ret = false;
>  
> -	/*
> -	 * With perf record core.user_requested_cpus is usually NULL.
> -	 * Use the old method to handle this for now.
> -	 */
> -	if (!evlist->core.user_requested_cpus ||
> +	if (evlist->no_affinity || !evlist->core.user_requested_cpus ||
>  	    cpu_map__is_dummy(evlist->core.user_requested_cpus))
>  		return false;
>  
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 30dff7484d3c..d17c3b57a409 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -59,6 +59,7 @@ struct event_enable_timer;
>  struct evlist {
>  	struct perf_evlist core;
>  	bool		 enabled;
> +	bool		 no_affinity;
>  	int		 id_pos;
>  	int		 is_pos;
>  	int		 nr_br_cntr;
> -- 
> 2.53.0.rc2.204.g2597b5adb4-goog
> 
