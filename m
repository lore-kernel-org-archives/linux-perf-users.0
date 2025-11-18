Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177CF157480;
	Tue, 18 Nov 2025 02:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433071; cv=none; b=jDStNZDhjilt1CANCtuJcDgRibD2U7yezDSpXv+kImJtIum+agZbC0BeL7YbrZT9fC9hfxrqLp4lomzEmYTEgTp2l2MzQHAJfjOAYq7jlihGiarjosokUkfhZXw9/tm2/s/kL1x1rOljwZNqL6zh9miiabfiSRO0B90FckeYryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433071; c=relaxed/simple;
	bh=9ymC2b8dlxIXyL8oM8nsj/ti4vyT5wZ+QxebmyA6C0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eII2AdmRy92V+58qnlbh7u5UPLNojTn0xUIxxzF873NHAz0ehmt7cv2kkuHdfZZuF5BD2J/rpYs26yjCBsG6sYuniCU8RvzjNWDNRL0DoJexG9gVwuJfiu98fkphYrOgllohVGUaMgm9WbF0zRBK/VKa4d3t3IldFMQ8M87/oCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa6BtMNf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa6BtMNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C80C2BCAF;
	Tue, 18 Nov 2025 02:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763433070;
	bh=9ymC2b8dlxIXyL8oM8nsj/ti4vyT5wZ+QxebmyA6C0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fa6BtMNfGlUVH7pN5C8dXUHmkk3THPJhVhSGzPJmzBfQTjKhrKooBLZPSN0/qEVtz
	 yIsAyM1gogGTxYJSFOASrQrkUI3RuESdoqyqCfmwrHWtTtqHoQk7J4SEYRrg/F3OlE
	 u6O39qMODfCoat55zH5oKMedctKkMxZNyPMRagHeQCGFjiCexR235FqnwyUTIcfgeF
	 XeXwjTU7KVXOjlQg0Qzi1+2oY7BgLEWPCEE1g2x4w6abVmHU55KDpfvsu3B6BR2ZjA
	 S878/vfGWPjd0zb+JK8Qe3Lvfi5bYwE6PT+EXk9P7JQnFBHvQDG+SoyEZln5oZnc5Q
	 RlplJi9g2S07A==
Date: Mon, 17 Nov 2025 18:31:06 -0800
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
Subject: Re: [PATCH v4 05/10] perf stat: Reduce scope of ru_stats
Message-ID: <aRvaasKg-ctKvzgi@google.com>
References: <20251113180517.44096-1-irogers@google.com>
 <20251113180517.44096-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113180517.44096-6-irogers@google.com>

On Thu, Nov 13, 2025 at 10:05:11AM -0800, Ian Rogers wrote:
> The ru_stats are used to capture user and system time stats when a
> process exits. These are then applied to user and system time tool
> events if their reads fail due to the process terminating. Reduce the
> scope now the metric code no longer reads these values.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c     | 19 ++++++++++++++++++-
>  tools/perf/util/config.c      |  1 -
>  tools/perf/util/stat-shadow.c |  2 --
>  tools/perf/util/stat.h        | 21 ---------------------
>  4 files changed, 18 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 654f840f7a2f..d6f4c84f7d7e 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -104,6 +104,11 @@
>  #define DEFAULT_SEPARATOR	" "
>  #define FREEZE_ON_SMI_PATH	"bus/event_source/devices/cpu/freeze_on_smi"
>  
> +struct rusage_stats {
> +	struct stats ru_utime_usec_stat;
> +	struct stats ru_stime_usec_stat;

Maybe we need to rename it to ru_[us]time_nsec_stat now?
But it can be a separate change.

Thanks,
Namhyung


> +};
> +
>  static void print_counters(struct timespec *ts, int argc, const char **argv);
>  
>  static struct evlist	*evsel_list;
> @@ -133,6 +138,7 @@ static bool			interval_count;
>  static const char		*output_name;
>  static int			output_fd;
>  static char			*metrics;
> +static struct rusage_stats	ru_stats;
>  
>  struct perf_stat {
>  	bool			 record;
> @@ -730,6 +736,17 @@ static int create_perf_stat_counter(struct evsel *evsel,
>  					      evsel->core.threads);
>  }
>  
> +static void update_rusage_stats(const struct rusage *rusage)
> +{
> +	const u64 us_to_ns = 1000;
> +	const u64 s_to_ns = 1000000000;
> +
> +	update_stats(&ru_stats.ru_utime_usec_stat,
> +		(rusage->ru_utime.tv_usec * us_to_ns + rusage->ru_utime.tv_sec * s_to_ns));
> +	update_stats(&ru_stats.ru_stime_usec_stat,
> +		(rusage->ru_stime.tv_usec * us_to_ns + rusage->ru_stime.tv_sec * s_to_ns));
> +}
> +
>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  {
>  	int interval = stat_config.interval;
> @@ -979,7 +996,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  		evlist__reset_aggr_stats(evsel_list);
>  	} else {
>  		update_stats(&walltime_nsecs_stats, t1 - t0);
> -		update_rusage_stats(&ru_stats, &stat_config.ru_data);
> +		update_rusage_stats(&stat_config.ru_data);
>  	}
>  
>  	/*
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 6f914620c6ff..cc0746f494f4 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -45,7 +45,6 @@ struct perf_stat_config stat_config = {
>  	.run_count		= 1,
>  	.metric_only_len	= METRIC_ONLY_LEN,
>  	.walltime_nsecs_stats	= &walltime_nsecs_stats,
> -	.ru_stats		= &ru_stats,
>  	.big_num		= true,
>  	.ctl_fd			= -1,
>  	.ctl_fd_ack		= -1,
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 6c1ad78604e1..cb7c741a1ebb 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -18,12 +18,10 @@
>  #include "tool_pmu.h"
>  
>  struct stats walltime_nsecs_stats;
> -struct rusage_stats ru_stats;
>  
>  void perf_stat__reset_shadow_stats(void)
>  {
>  	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
> -	memset(&ru_stats, 0, sizeof(ru_stats));
>  }
>  
>  static bool tool_pmu__is_time_event(const struct perf_stat_config *config,
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index b42da4a29c44..055b95d18106 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -56,11 +56,6 @@ enum aggr_mode {
>  	AGGR_MAX
>  };
>  
> -struct rusage_stats {
> -	struct stats ru_utime_usec_stat;
> -	struct stats ru_stime_usec_stat;
> -};
> -
>  typedef struct aggr_cpu_id (*aggr_get_id_t)(struct perf_stat_config *config, struct perf_cpu cpu);
>  
>  struct perf_stat_config {
> @@ -102,7 +97,6 @@ struct perf_stat_config {
>  	const char		*csv_sep;
>  	struct stats		*walltime_nsecs_stats;
>  	struct rusage		 ru_data;
> -	struct rusage_stats		 *ru_stats;
>  	struct cpu_aggr_map	*aggr_map;
>  	aggr_get_id_t		 aggr_get_id;
>  	struct cpu_aggr_map	*cpus_aggr_map;
> @@ -132,25 +126,10 @@ static inline void init_stats(struct stats *stats)
>  	stats->max  = 0;
>  }
>  
> -static inline void init_rusage_stats(struct rusage_stats *ru_stats) {
> -	init_stats(&ru_stats->ru_utime_usec_stat);
> -	init_stats(&ru_stats->ru_stime_usec_stat);
> -}
> -
> -static inline void update_rusage_stats(struct rusage_stats *ru_stats, struct rusage* rusage) {
> -	const u64 us_to_ns = 1000;
> -	const u64 s_to_ns = 1000000000;
> -	update_stats(&ru_stats->ru_utime_usec_stat,
> -	             (rusage->ru_utime.tv_usec * us_to_ns + rusage->ru_utime.tv_sec * s_to_ns));
> -	update_stats(&ru_stats->ru_stime_usec_stat,
> -	             (rusage->ru_stime.tv_usec * us_to_ns + rusage->ru_stime.tv_sec * s_to_ns));
> -}
> -
>  struct evsel;
>  struct evlist;
>  
>  extern struct stats walltime_nsecs_stats;
> -extern struct rusage_stats ru_stats;
>  
>  enum metric_threshold_classify {
>  	METRIC_THRESHOLD_UNKNOWN,
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 
