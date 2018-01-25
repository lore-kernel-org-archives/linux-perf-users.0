From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 2/2] perf stat: Add support to print counts after a
 period of time
Date: Thu, 25 Jan 2018 13:27:12 +0100
Message-ID: <20180125122712.GA9096@krava>
References: <1516871404-31920-1-git-send-email-ufo19890607@gmail.com>
 <1516871404-31920-3-git-send-email-ufo19890607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751707AbeAYM1R (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Jan 2018 07:27:17 -0500
Content-Disposition: inline
In-Reply-To: <1516871404-31920-3-git-send-email-ufo19890607@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: ufo19890607 <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com

On Thu, Jan 25, 2018 at 10:10:04AM +0100, ufo19890607 wrote:

SNIP

>  --metric-only::
>  Only print computed metrics. Print them in a single line.
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 406f546ad74c..427f06dc35cc 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -573,6 +573,7 @@ static int __run_perf_stat(int argc, const char **argv)
>  {
>  	int interval = stat_config.interval;
>  	int times = stat_config.times;
> +	int time = stat_config.time;
>  	char msg[BUFSIZ];
>  	unsigned long long t0, t1;
>  	struct perf_evsel *counter;
> @@ -586,6 +587,9 @@ static int __run_perf_stat(int argc, const char **argv)
>  	if (interval) {
>  		ts.tv_sec  = interval / USEC_PER_MSEC;
>  		ts.tv_nsec = (interval % USEC_PER_MSEC) * NSEC_PER_MSEC;
> +	} else if (time) {
> +		ts.tv_sec  = time / USEC_PER_MSEC;
> +		ts.tv_nsec = (time % USEC_PER_MSEC) * NSEC_PER_MSEC;

I like the idea.. it won't work with -I option, but let's
keep it like that until someone needs it ;-)

>  	} else {
>  		ts.tv_sec  = 1;
>  		ts.tv_nsec = 0;
> @@ -698,9 +702,11 @@ static int __run_perf_stat(int argc, const char **argv)
>  		perf_evlist__start_workload(evsel_list);
>  		enable_counters();
>  
> -		if (interval) {
> +		if (interval || time) {
>  			while (!waitpid(child_pid, &status, WNOHANG)) {
>  				nanosleep(&ts, NULL);
> +				if (time)
> +					break;
>  				process_interval();
>  				if (interval_count == true) {
>  					if (--times == 0)
> @@ -722,7 +728,9 @@ static int __run_perf_stat(int argc, const char **argv)
>  		enable_counters();
>  		while (!done) {
>  			nanosleep(&ts, NULL);
> -			if (interval) {
> +			if (interval || time) {
> +				if (time)
> +					break;

you can put the time check with break directly after nanosleep
to keep some consistency with the workload case


>  				process_interval();
>  				if (interval_count == true) {
>  					if (--times == 0)
> @@ -1904,6 +1912,8 @@ static const struct option stat_options[] = {
>  		    "print counts at regular interval in ms (>= 10)"),
>  	OPT_INTEGER(0, "interval-count", &stat_config.times,
>  		    "print counts for fixed number of times"),
> +	OPT_UINTEGER(0, "time", &stat_config.time,
> +		    "print counts after a period of time in ms (>= 10)"),
>  	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
>  		     "aggregate counts per processor socket", AGGR_SOCKET),
>  	OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
> @@ -2701,7 +2711,7 @@ int cmd_stat(int argc, const char **argv)
>  	int status = -EINVAL, run_idx;
>  	const char *mode;
>  	FILE *output = stderr;
> -	unsigned int interval;
> +	unsigned int interval, time;
>  	int times;
>  	const char * const stat_subcommands[] = { "record", "report" };
>  
> @@ -2734,6 +2744,7 @@ int cmd_stat(int argc, const char **argv)
>  
>  	interval = stat_config.interval;
>  	times = stat_config.times;
> +	time = stat_config.time;
>  
>  	/*
>  	 * For record command the -o is already taken care of.
> @@ -2885,6 +2896,7 @@ int cmd_stat(int argc, const char **argv)
>  				   "The overhead percentage could be high in some cases. "
>  				   "Please proceed with caution.\n");
>  	}
> +
>  	if (times && interval)
>  		interval_count = true;
>  	else if (times && !interval) {
> @@ -2895,6 +2907,17 @@ int cmd_stat(int argc, const char **argv)
>  		goto out;
>  	}
>  
> +	if (time && time < 10) {
> +		pr_err("time must be >= 10ms.\n");

what is this limitation for? please mentioned
that in comment and changelog

thanks,
jirka
