Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7F19F136;
	Wed, 11 Sep 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064932; cv=none; b=tUGV2I8r+BSFD3pW3T0UF8K+qceQM5nICgL61Nche4+o4vZsJWUTi87610R8q+8m9dKVlP/n6uFcjhrUWyj1gd0fj4HS2VJ91CxvTqI6MKIdqotamvwY4jDUY0IK+XI7tDBbcGBOEWg4Op4VOiNbdP/fNmdabbCCrOGZDjMIB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064932; c=relaxed/simple;
	bh=URmhcJC1NvBBmPuyBXkLuJeA3g7Rpc5NjE1fbH+kESU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7fT65Fs5s3urp/Rx6g6wdTQmF84uA1W68StRGV+0ZDKJaWKaPiY+1nPw3H6q+YVHalCIcmkAuq6LEDWzrgS7nKkTc/tOqH1M7Om9VOKmQK2tzgd0p2yqmV92pnY/p4L7OGqafyWdkkr1sBEnOZ+LF2axAjbQ4iGfiXLaIZKY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RazeZuOU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RazeZuOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF077C4CEC0;
	Wed, 11 Sep 2024 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726064932;
	bh=URmhcJC1NvBBmPuyBXkLuJeA3g7Rpc5NjE1fbH+kESU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RazeZuOU+aD3rdYumVAguCydSajlu3OUhVwC+sQQgrkNToSjohqcXIHkhbwEcYEcL
	 ZiDNCc1PGtKmC8kZ21Tnt/cBFHLwc8psfbROSxnl3+nPaVvXsZP8/64Ah44qFlC2D1
	 nvBotGkNiydCTvcts5a8JtUVNHqQhTcS7WKgR0PDOK8r01cFEuIE3AUTOwJKbI78pu
	 pBlyyp4B2aGEawiGuFObhPK7/MLeTFErzQL4Hb213vmp5myf8SCEQv9iSKtZChkcji
	 hiRz2hfEJg9Dc40vErXUHCkBHd6YhnNfZxQ8PH9REDFY5OpUqssGSMEzhB5p/BsEz1
	 V/Z7FXtfDGOYg==
Date: Wed, 11 Sep 2024 11:28:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Junhao He <hejunhao3@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 03/15] perf evsel: Add accessor for tool_event
Message-ID: <ZuGpIQmfmC1t3xt7@x1>
References: <20240907050830.6752-1-irogers@google.com>
 <20240907050830.6752-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907050830.6752-4-irogers@google.com>

On Fri, Sep 06, 2024 at 10:08:18PM -0700, Ian Rogers wrote:
> Currently tool events use a dedicated variable within the evsel. Later
> changes will move this to the unused struct perf_event_attr config for
> these events. Add an accessor to allow the later change to be well
> typed and avoid changing all uses.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c     |  6 +++---
>  tools/perf/util/evsel.c       | 24 ++++++++++++------------
>  tools/perf/util/evsel.h       |  5 +++++
>  tools/perf/util/stat-shadow.c |  2 +-
>  4 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index cf985cdb9a6e..689a3d43c258 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -294,14 +294,14 @@ static int read_single_counter(struct evsel *counter, int cpu_map_idx, int threa
>  	 * terminates. Use the wait4 values in that case.
>  	 */
>  	if (err && cpu_map_idx == 0 &&
> -	    (counter->tool_event == PERF_TOOL_USER_TIME ||
> -	     counter->tool_event == PERF_TOOL_SYSTEM_TIME)) {
> +	    (evsel__tool_event(counter) == PERF_TOOL_USER_TIME ||
> +	     evsel__tool_event(counter) == PERF_TOOL_SYSTEM_TIME)) {
>  		u64 val, *start_time;
>  		struct perf_counts_values *count =
>  			perf_counts(counter->counts, cpu_map_idx, thread);
>  
>  		start_time = xyarray__entry(counter->start_times, cpu_map_idx, thread);
> -		if (counter->tool_event == PERF_TOOL_USER_TIME)
> +		if (evsel__tool_event(counter) == PERF_TOOL_USER_TIME)
>  			val = ru_stats.ru_utime_usec_stat.mean;
>  		else
>  			val = ru_stats.ru_stime_usec_stat.mean;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 49cc71511c0c..dbf9c8cee3c5 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -773,7 +773,7 @@ const char *evsel__name(struct evsel *evsel)
>  
>  	case PERF_TYPE_SOFTWARE:
>  		if (evsel__is_tool(evsel))
> -			evsel__tool_name(evsel->tool_event, bf, sizeof(bf));
> +			evsel__tool_name(evsel__tool_event(evsel), bf, sizeof(bf));
>  		else
>  			evsel__sw_name(evsel, bf, sizeof(bf));
>  		break;
> @@ -811,7 +811,7 @@ const char *evsel__metric_id(const struct evsel *evsel)
>  		return evsel->metric_id;
>  
>  	if (evsel__is_tool(evsel))
> -		return perf_tool_event__to_str(evsel->tool_event);
> +		return perf_tool_event__to_str(evsel__tool_event(evsel));
>  
>  	return "unknown";
>  }
> @@ -1503,8 +1503,8 @@ void evsel__exit(struct evsel *evsel)
>  	evsel->per_pkg_mask = NULL;
>  	zfree(&evsel->metric_events);
>  	perf_evsel__object.fini(evsel);
> -	if (evsel->tool_event == PERF_TOOL_SYSTEM_TIME ||
> -	    evsel->tool_event == PERF_TOOL_USER_TIME)
> +	if (evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME ||
> +	    evsel__tool_event(evsel) == PERF_TOOL_USER_TIME)
>  		xyarray__delete(evsel->start_times);
>  }
>  
> @@ -1785,7 +1785,7 @@ static int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
>  
>  	count = perf_counts(evsel->counts, cpu_map_idx, thread);
>  
> -	switch (evsel->tool_event) {
> +	switch (evsel__tool_event(evsel)) {
>  	case PERF_TOOL_DURATION_TIME:
>  		/*
>  		 * Pretend duration_time is only on the first CPU and thread, or
> @@ -1800,7 +1800,7 @@ static int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
>  		break;
>  	case PERF_TOOL_USER_TIME:
>  	case PERF_TOOL_SYSTEM_TIME: {
> -		bool system = evsel->tool_event == PERF_TOOL_SYSTEM_TIME;
> +		bool system = evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME;
>  
>  		start_time = xyarray__entry(evsel->start_times, cpu_map_idx, thread);
>  		fd = FD(evsel, cpu_map_idx, thread);
> @@ -2072,8 +2072,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	    perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
>  		return -ENOMEM;
>  
> -	if ((evsel->tool_event == PERF_TOOL_SYSTEM_TIME ||
> -	     evsel->tool_event == PERF_TOOL_USER_TIME) &&
> +	if ((evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME ||
> +	     evsel__tool_event(evsel) == PERF_TOOL_USER_TIME) &&
>  	    !evsel->start_times) {
>  		evsel->start_times = xyarray__new(perf_cpu_map__nr(cpus), nthreads, sizeof(__u64));
>  		if (!evsel->start_times)
> @@ -2262,7 +2262,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	int pid = -1, err, old_errno;
>  	enum rlimit_action set_rlimit = NO_CHANGE;
>  
> -	if (evsel->tool_event == PERF_TOOL_DURATION_TIME) {
> +	if (evsel__tool_event(evsel) == PERF_TOOL_DURATION_TIME) {
>  		if (evsel->core.attr.sample_period) /* no sampling */
>  			return -EINVAL;
>  		evsel->start_time = rdclock();
> @@ -2304,9 +2304,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  			if (!evsel->cgrp && !evsel->core.system_wide)
>  				pid = perf_thread_map__pid(threads, thread);
>  
> -			if (evsel->tool_event == PERF_TOOL_USER_TIME ||
> -			    evsel->tool_event == PERF_TOOL_SYSTEM_TIME) {
> -				bool system = evsel->tool_event == PERF_TOOL_SYSTEM_TIME;
> +			if (evsel__tool_event(evsel) == PERF_TOOL_USER_TIME ||
> +			    evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME) {
> +				bool system = evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME;
>  				__u64 *start_time = NULL;
>  
>  				if (evsel->core.attr.sample_period) {
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 15acf293e12a..15e745a9a798 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -330,6 +330,11 @@ static inline bool evsel__is_retire_lat(const struct evsel *evsel)
>  	return evsel->retire_lat;
>  }
>  
> +static inline enum perf_tool_event evsel__tool_event(const struct evsel *evsel)
> +{
> +	return evsel->tool_event;
> +}
> +
>  const char *evsel__group_name(struct evsel *evsel);
>  int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
>  
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 6bb975e46de3..99376c12dd8e 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -380,7 +380,7 @@ static int prepare_metric(const struct metric_expr *mexp,
>  			struct stats *stats;
>  			double scale;
>  
> -			switch (metric_events[i]->tool_event) {
> +			switch (evsel__tool_event(metric_events[i])) {
>  			case PERF_TOOL_DURATION_TIME:
>  				stats = &walltime_nsecs_stats;
>  				scale = 1e-9;
> -- 
> 2.46.0.469.g59c65b2a67-goog
