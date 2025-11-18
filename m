Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8930597C;
	Tue, 18 Nov 2025 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433661; cv=none; b=X4C/EQ2fLSJI0AkKg3nPFWpkpMs65O4z9b5E9C0atP3shoyoJDnHhVahRGx0K/UPJg60bSEXtaPKvkWaWDsChkmfWLyV4TqgnS8e98Ye18yUQF6WEC9MIQ1bprN8wKN2AE/zEQdbGpA0SIIij+iLiOBMjn7rU+tRtTzBY5hRz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433661; c=relaxed/simple;
	bh=Q62wl5sZGcLb5+Fr+2IFnjR/5GV0RSMjVfTridFArNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKljG4LnNwAWRsW+wiwPxDWspyaavU8QL1MeKfEvft/ys9u3qA68neCbZ/hHuoLJAH4xFZ6OXGC2xDcMUZ6wRSXtAxpSn3wwGD4ux2JewLGI9mDDPEwsCJXDk+dwPy4D5QtD8KIAmtaM30mBfsHn+4ZvdIr1ABErvNgZZxZMhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExIXac5u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExIXac5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72CCC2BC86;
	Tue, 18 Nov 2025 02:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763433660;
	bh=Q62wl5sZGcLb5+Fr+2IFnjR/5GV0RSMjVfTridFArNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExIXac5uan/kk+heaVqh3AQcw9YzyZFjIgkJpuRcH6qPS9XGFtYF/sfFp/YyDg+91
	 bFio0c9JMRl9dw0uzB02XbeVG3TrdWZ6fNLw2TsA1VRxSg0yb//9kCHi4jYQ8hZ4Nf
	 iCk0VYq7Bz0egeE2WvM/b8xAWVGm1BZGJnb+uo75EKD0P3BPLguxMKYVmnYb59r/Ow
	 pyInEyp/x8J6ywfoMjWkty6nBiaGunU+ZklezmUcrvTIw4p+nAl7eAWodvAcwj8rNh
	 ka4r8YUXOQCdlM+wAoWrXG45K1sCDNOcZibYVSClCGkiA+GAQyBRzb1ZzcfkTvjNAr
	 agc6RguGNFcHQ==
Date: Mon, 17 Nov 2025 18:40:56 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 10/10] perf stat: Add no-affinity flag
Message-ID: <aRvcuMfbDRSBU87k@google.com>
References: <20251113180517.44096-1-irogers@google.com>
 <20251113180517.44096-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113180517.44096-11-irogers@google.com>

On Thu, Nov 13, 2025 at 10:05:16AM -0800, Ian Rogers wrote:
> Add flag that disables affinity behavior. Using sched_setaffinity to
> place a perf thread on a CPU can avoid certain interprocessor
> interrupts but may introduce a delay due to the scheduling,
> particularly on loaded machines. Add a command line option to disable
> the behavior. This behavior is less present in other tools like `perf
> record`, as it uses a ring buffer and doesn't make repeated system
> calls.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-stat.txt | 4 ++++
>  tools/perf/builtin-stat.c              | 6 ++++++
>  tools/perf/util/evlist.c               | 2 +-
>  tools/perf/util/evlist.h               | 1 +
>  4 files changed, 12 insertions(+), 1 deletion(-)
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
> index aec93b91fd11..fa42b08bd1df 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2415,6 +2415,7 @@ static int parse_tpebs_mode(const struct option *opt, const char *str,
>  int cmd_stat(int argc, const char **argv)
>  {
>  	struct opt_aggr_mode opt_mode = {};
> +	bool no_affinity = false;
>  	struct option stat_options[] = {
>  		OPT_BOOLEAN('T', "transaction", &transaction_run,
>  			"hardware transaction statistics"),
> @@ -2543,6 +2544,8 @@ int cmd_stat(int argc, const char **argv)
>  			"don't print 'summary' for CSV summary output"),
>  		OPT_BOOLEAN(0, "quiet", &quiet,
>  			"don't print any output, messages or warnings (useful with record)"),
> +		OPT_BOOLEAN(0, "no-affinity", &no_affinity,
> +			"don't allow affinity optimizations aimed at reducing IPIs"),

I know you want to add an option to disable the behaivor, but I think
it'd better to have a positive option like just '--affinity'.  Then we
will have '--no-affinity' for free. :)  The current form will allow
'--no-no-affinity'.

Then the variable also can be 'enable_affinity' or so.

You can mention --no-affinity in the help message and the man page
document so that users can discover the intention.

Thanks,
Namhyung


>  		OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
>  			"Only enable events on applying cpu with this type "
>  			"for hybrid platform (e.g. core or atom)",
> @@ -2600,6 +2603,9 @@ int cmd_stat(int argc, const char **argv)
>  	} else
>  		stat_config.csv_sep = DEFAULT_SEPARATOR;
>  
> +	if (no_affinity)
> +		evsel_list->no_affinity = true;
> +
>  	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
>  		argc = __cmd_record(stat_options, &opt_mode, argc, argv);
>  		if (argc < 0)
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index fc3dae7cdfca..53c8e974de8b 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -368,7 +368,7 @@ static bool evlist__use_affinity(struct evlist *evlist)
>  	struct perf_cpu_map *used_cpus = NULL;
>  	bool ret = false;
>  
> -	if (!evlist->core.user_requested_cpus ||
> +	if (evlist->no_affinity || !evlist->core.user_requested_cpus ||
>  	    cpu_map__is_dummy(evlist->core.user_requested_cpus))
>  		return false;
>  
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index b4604c3f03d6..c7ba0e0b2219 100644
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
> 2.51.2.1041.gc1ab5b90ca-goog
> 
