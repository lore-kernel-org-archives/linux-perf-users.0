From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 1/2] perf stat: Add support to print counts for fixed
 times
Date: Mon, 29 Jan 2018 08:29:49 +0100
Message-ID: <20180129072949.GB8162@krava>
References: <1516957617-23985-1-git-send-email-ufo19890607@gmail.com>
 <1516957617-23985-2-git-send-email-ufo19890607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516957617-23985-2-git-send-email-ufo19890607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ufo19890607 <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com, Kan.liang@intel.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

On Fri, Jan 26, 2018 at 10:06:56AM +0100, ufo19890607 wrote:

SNIP

> @@ -1891,6 +1902,8 @@ static const struct option stat_options[] = {
>  			"command to run after to the measured command"),
>  	OPT_UINTEGER('I', "interval-print", &stat_config.interval,
>  		    "print counts at regular interval in ms (>= 10)"),
> +	OPT_INTEGER(0, "interval-count", &stat_config.times,
> +		    "print counts for fixed number of times"),
>  	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
>  		     "aggregate counts per processor socket", AGGR_SOCKET),
>  	OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
> @@ -2689,6 +2702,7 @@ int cmd_stat(int argc, const char **argv)
>  	const char *mode;
>  	FILE *output = stderr;
>  	unsigned int interval;
> +	int times;
>  	const char * const stat_subcommands[] = { "record", "report" };
>  
>  	setlocale(LC_ALL, "");
> @@ -2719,6 +2733,7 @@ int cmd_stat(int argc, const char **argv)
>  		return __cmd_report(argc, argv);
>  
>  	interval = stat_config.interval;
> +	times = stat_config.times;
>  
>  	/*
>  	 * For record command the -o is already taken care of.
> @@ -2870,6 +2885,15 @@ int cmd_stat(int argc, const char **argv)
>  				   "The overhead percentage could be high in some cases. "
>  				   "Please proceed with caution.\n");
>  	}
> +	if (times && interval)
> +		interval_count = true;
> +	else if (times && !interval) {

you can use stat_config.times in here, no need for 'times' copy

jirka

> +		pr_err("interval-count option should be used together with "
> +				"interval-print.\n");
> +		parse_options_usage(stat_usage, stat_options, "interval-count", 0);
> +		parse_options_usage(stat_usage, stat_options, "I", 1);
> +		goto out;
> +	}
>  
>  	if (perf_evlist__alloc_stats(evsel_list, interval))
>  		goto out;
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index dbc6f7134f61..b2f8a347d358 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -90,6 +90,7 @@ struct perf_stat_config {
>  	bool		scale;
>  	FILE		*output;
>  	unsigned int	interval;
> +	int				times;
>  	struct runtime_stat *stats;
>  	int		stats_num;
>  };
> -- 
> 2.14.1
> 
