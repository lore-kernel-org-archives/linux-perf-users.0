From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 1/2] perf stat: Add support to print counts for fixed
 times
Date: Mon, 29 Jan 2018 08:29:05 +0100
Message-ID: <20180129072905.GA8162@krava>
References: <1516957617-23985-1-git-send-email-ufo19890607@gmail.com>
 <1516957617-23985-2-git-send-email-ufo19890607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeA2H3N (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Jan 2018 02:29:13 -0500
Content-Disposition: inline
In-Reply-To: <1516957617-23985-2-git-send-email-ufo19890607@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: ufo19890607 <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com, Kan.liang@intel.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com

On Fri, Jan 26, 2018 at 10:06:56AM +0100, ufo19890607 wrote:

SNIP

> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -168,6 +168,7 @@ static struct timespec		ref_time;
>  static struct cpu_map		*aggr_map;
>  static aggr_get_id_t		aggr_get_id;
>  static bool			append_file;
> +static bool			interval_count;
>  static const char		*output_name;
>  static int			output_fd;
>  static int			print_free_counters_hint;
> @@ -571,6 +572,7 @@ static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
>  static int __run_perf_stat(int argc, const char **argv)
>  {
>  	int interval = stat_config.interval;
> +	int times = stat_config.times;
>  	char msg[BUFSIZ];
>  	unsigned long long t0, t1;
>  	struct perf_evsel *counter;
> @@ -700,6 +702,10 @@ static int __run_perf_stat(int argc, const char **argv)
>  			while (!waitpid(child_pid, &status, WNOHANG)) {
>  				nanosleep(&ts, NULL);
>  				process_interval();
> +				if (interval_count == true) {
> +					if (--times == 0)
> +						break;

why not single line in here?

if (interval_count && !(--times))

> +				}
>  			}
>  		}
>  		waitpid(child_pid, &status, 0);
> @@ -716,8 +722,13 @@ static int __run_perf_stat(int argc, const char **argv)
>  		enable_counters();
>  		while (!done) {
>  			nanosleep(&ts, NULL);
> -			if (interval)
> +			if (interval) {
>  				process_interval();
> +				if (interval_count == true) {
> +					if (--times == 0)
> +						break;

same here

SNIP

>  	}
> +	if (times && interval)
> +		interval_count = true;
> +	else if (times && !interval) {
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

wrong indent

thanks,
jirka

>  	struct runtime_stat *stats;
>  	int		stats_num;
>  };
> -- 
> 2.14.1
> 
