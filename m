Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CFC22611;
	Wed,  8 Jan 2025 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365551; cv=none; b=JudFu3cju0788GfKY7jKr/yS7TjrjjOmOSdneeVBM+BESxTGpp8gtnyuqr+TyfCeg0qLBKfYduBO/M1SqGavuWTnbczN9mISXl2cZ3iHW5mXzR3PoB+5gE2veuGDDKZXZXdmSoNTGiESEuP1Y9tOv9uYbCsTVSet9wZwq2gCCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365551; c=relaxed/simple;
	bh=7YeO4NtVni/aC03LGP2tIZFULKZTiKeoXUv5FdQM6/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEXyAE49PN566RR8nKE94BenxGVrrbxHsFYRfNwVN/UfQ128gDsgo7bcKS2+vvPr2zDu0FWYg1aGxiCS9o4Fd9PYIaYSs/ILPotwxMiRjkuxIQHC5Ln51aHF2LkEJ+AyIg7h7gx9W0L2XTzbTJxT1lsts9fhbZcL0H/XH7aDRfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBg4xSRB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBg4xSRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE24C4CED3;
	Wed,  8 Jan 2025 19:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736365550;
	bh=7YeO4NtVni/aC03LGP2tIZFULKZTiKeoXUv5FdQM6/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBg4xSRBAv5uOvIGgMsD1ICrRIESgZ7M5pXCt+sTJnclKW5v2OYdw15DzZPMqwpVj
	 QBqv+8ov+oQT45RSpVsMsAcAK3LTtTJUOp3Hu0lbnrzMhtbcqBsPdU4vrF7FiO/Ej7
	 GzhH4hKj5KYGHsB3vbClEomab+/loxQvxvLKg9JVxkUul97ywnWno4NWoq+YNSYbFd
	 m/+VBw/Xzok2CevzDpl7QNV0NxIZbakJD3dczX/dCw4g0av/ETctQ73Lr8vSUNABk+
	 UzxFxs9m/n2Pk6fw8geC18F8cgYZSWlfDYk31ntQZNj/MBOO35Q3HRcikbJenxTQ2Q
	 58VEvgz6ZXScw==
Date: Wed, 8 Jan 2025 11:45:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] perf parse-events: Set is_pmu_core for legacy
 hardware events
Message-ID: <Z37V7OSYZkp-WYpl@google.com>
References: <20250108053428.1724490-1-irogers@google.com>
 <20250108053428.1724490-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250108053428.1724490-4-irogers@google.com>

On Tue, Jan 07, 2025 at 09:34:27PM -0800, Ian Rogers wrote:
> Also set the CPU map to all online CPU maps. This is done so the
> behavior of legacy hardware and hardware cache events better matches
> that of sysfs and json events during
> __perf_evlist__propagate_maps. Fix missing cpumap put in "Synthesize
> attr update" test.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/event_update.c |  1 +
>  tools/perf/util/parse-events.c  | 37 ++++++++++++++++++++-------------
>  2 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
> index d6b4ce3ef4ee..9301fde11366 100644
> --- a/tools/perf/tests/event_update.c
> +++ b/tools/perf/tests/event_update.c
> @@ -109,6 +109,7 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
>  	TEST_ASSERT_VAL("failed to synthesize attr update name",
>  			!perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_event_name));
>  
> +	perf_cpu_map__put(evsel->core.own_cpus);
>  	evsel->core.own_cpus = perf_cpu_map__new("1,2,3");

Looks like it needs to be in a separate commit.

Thanks,
Namhyung

>  
>  	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 1e23faa364b1..4bda4141e9e7 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -231,21 +231,30 @@ __add_event(struct list_head *list, int *idx,
>  	    struct perf_cpu_map *cpu_list, u64 alternate_hw_config)
>  {
>  	struct evsel *evsel;
> -	struct perf_cpu_map *cpus = perf_cpu_map__is_empty(cpu_list) && pmu ? pmu->cpus : cpu_list;
> +	bool is_pmu_core;
> +	struct perf_cpu_map *cpus;
>  
> -	cpus = perf_cpu_map__get(cpus);
> -	if (pmu)
> +	if (pmu) {
> +		is_pmu_core = pmu->is_core;
> +		cpus = perf_cpu_map__get(perf_cpu_map__is_empty(cpu_list) ? pmu->cpus : cpu_list);
>  		perf_pmu__warn_invalid_formats(pmu);
> -
> -	if (pmu && (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX)) {
> -		perf_pmu__warn_invalid_config(pmu, attr->config, name,
> -					      PERF_PMU_FORMAT_VALUE_CONFIG, "config");
> -		perf_pmu__warn_invalid_config(pmu, attr->config1, name,
> -					      PERF_PMU_FORMAT_VALUE_CONFIG1, "config1");
> -		perf_pmu__warn_invalid_config(pmu, attr->config2, name,
> -					      PERF_PMU_FORMAT_VALUE_CONFIG2, "config2");
> -		perf_pmu__warn_invalid_config(pmu, attr->config3, name,
> -					      PERF_PMU_FORMAT_VALUE_CONFIG3, "config3");
> +		if (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX) {
> +			perf_pmu__warn_invalid_config(pmu, attr->config, name,
> +						PERF_PMU_FORMAT_VALUE_CONFIG, "config");
> +			perf_pmu__warn_invalid_config(pmu, attr->config1, name,
> +						PERF_PMU_FORMAT_VALUE_CONFIG1, "config1");
> +			perf_pmu__warn_invalid_config(pmu, attr->config2, name,
> +						PERF_PMU_FORMAT_VALUE_CONFIG2, "config2");
> +			perf_pmu__warn_invalid_config(pmu, attr->config3, name,
> +						PERF_PMU_FORMAT_VALUE_CONFIG3, "config3");
> +		}
> +	} else {
> +		is_pmu_core = (attr->type == PERF_TYPE_HARDWARE ||
> +			       attr->type == PERF_TYPE_HW_CACHE);
> +		if (perf_cpu_map__is_empty(cpu_list))
> +			cpus = is_pmu_core ? perf_cpu_map__new_online_cpus() : NULL;
> +		else
> +			cpus = perf_cpu_map__get(cpu_list);
>  	}
>  	if (init_attr)
>  		event_attr_init(attr);
> @@ -260,7 +269,7 @@ __add_event(struct list_head *list, int *idx,
>  	evsel->core.cpus = cpus;
>  	evsel->core.own_cpus = perf_cpu_map__get(cpus);
>  	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
> -	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
> +	evsel->core.is_pmu_core = is_pmu_core;
>  	evsel->auto_merge_stats = auto_merge_stats;
>  	evsel->pmu = pmu;
>  	evsel->alternate_hw_config = alternate_hw_config;
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
