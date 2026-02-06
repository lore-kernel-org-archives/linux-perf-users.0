Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC83749C;
	Fri,  6 Feb 2026 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374752; cv=none; b=XZ7mBMASdyOqseBX7jjyMw02qavqk9Zs/CkPhObpXsP5pH/99sgfXqwSLCC+r7f0Y3qVfXNzfeeJcMznjKY7QokAKYTuZS1nFST7wepQcXjUobLE/9BpqXOZFbeHRs4hg2GkQwJbiRTNFXNC0IX3QB3uKtud8WfHFE4mkZqGrrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374752; c=relaxed/simple;
	bh=r2qUiVPYIaNhCMthHdhgLfpgGQDgYIogOFC/kQ62kfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKtQoTj/UTwRAuG9Mc1s27Qd3PjoAi8VeB2eeSywAVrlP9MFHtF/qvm6MhD9XtVPJBeOFL5P7hzzQ4vqvIxe5iM9s1rD/WUFzrgChJHKeuhbxfxAJ/8pp+QkHbVLYQqXdeuKkliqzIMSmpLe5EWQlcvgb2JO3hHhMSUcdjWFUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51A2E339;
	Fri,  6 Feb 2026 02:45:39 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CC603F632;
	Fri,  6 Feb 2026 02:45:45 -0800 (PST)
Date: Fri, 6 Feb 2026 10:45:43 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf metricgroup: Don't early exit if no CPUID
 table exists
Message-ID: <20260206104543.GE3529712@e132581.arm.com>
References: <20260205183603.459363-1-irogers@google.com>
 <20260205183603.459363-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205183603.459363-2-irogers@google.com>

On Thu, Feb 05, 2026 at 10:36:03AM -0800, Ian Rogers wrote:
> The failure to find a table of metrics with a CPUID shouldn't early
> exit as the metric code will now also consider the default table.
> When searching for a metric or metric group,
> pmu_metrics_table__for_each_metric considers all tables and so the
> caller doesn't need to switch the table to do this.
> 
> Fixes: c7adeb0974f1 ("perf jevents: Add set of common metrics based on default ones")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/metricgroup.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 40a1e14de418..46bf4dfeebc8 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1562,8 +1562,6 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
>  {
>  	const struct pmu_metrics_table *table = pmu_metrics_table__find();
>  
> -	if (!table)
> -		return -EINVAL;
>  	if (hardware_aware_grouping)
>  		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
>  
> @@ -1601,22 +1599,16 @@ static int metricgroup__has_metric_or_groups_callback(const struct pmu_metric *p
>  
>  bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_groups)
>  {
> -	const struct pmu_metrics_table *tables[2] = {
> -		pmu_metrics_table__find(),
> -		pmu_metrics_table__default(),
> -	};
> +	const struct pmu_metrics_table *table = pmu_metrics_table__find();

Here should be:

  const struct pmu_metrics_table *table = pmu_metrics_table__default();

With this change, the default metrics can work on my side:

 Performance counter stats for 'sleep 1':

                 1      context-switches                 #    434.8 cs/sec  cs_per_second     
                 0      cpu-migrations                   #      0.0 migrations/sec  migrations_per_second
                70      page-faults                      #  30439.1 faults/sec  page_faults_per_second
              2.30 msec task-clock                       #      0.0 CPUs  CPUs_utilized       
             17398      armv8_pmuv3_0/branch-misses/     #      4.3 %  branch_miss_rate       
            401746      armv8_pmuv3_0/branches/          #    174.7 M/sec  branch_frequency   
           1778245      armv8_pmuv3_0/cpu-cycles/        #      0.8 GHz  cycles_frequency     
           2341698      armv8_pmuv3_0/instructions/      #      1.3 instructions  insn_per_cycle
            680491      armv8_pmuv3_0/stalled-cycles-frontend/ #     0.38 frontend_cycles_idle      
            380360      armv8_pmuv3_0/stalled-cycles-backend/ #     0.21 backend_cycles_idle       
            380360      armv8_pmuv3_0/stalled-cycles-backend/ #     0.29 stalled_cycles_per_instruction

With above change:

Tested-by: Leo Yan <leo.yan@arm.com>


>  	struct metricgroup__has_metric_data data = {
>  		.pmu = pmu,
>  		.metric_or_groups = metric_or_groups,
>  	};
>  
> -	for (size_t i = 0; i < ARRAY_SIZE(tables); i++) {
> -		if (pmu_metrics_table__for_each_metric(tables[i],
> -							metricgroup__has_metric_or_groups_callback,
> -							&data))
> -			return true;
> -	}
> -	return false;
> +	return pmu_metrics_table__for_each_metric(table,
> +						  metricgroup__has_metric_or_groups_callback,
> +						  &data)
> +		? true : false;
>  }
>  
>  static int metricgroup__topdown_max_level_callback(const struct pmu_metric *pm,
> -- 
> 2.53.0.rc2.204.g2597b5adb4-goog
> 
> 
