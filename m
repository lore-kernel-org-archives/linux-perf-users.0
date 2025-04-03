Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B524337D;
	Thu,  3 Apr 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693426; cv=none; b=ZQSHdyjKALIbMuwhi2S+D7dtUNaEuosCBF8uki0dZ0iHZVD1lsh4E9eOvnZU4rlqlTDRtgApwnX+Fj/RFexlWElHfHCXc2M+NaNKKyOH+tlHH9tHf4td5lcNMmKBPvAqz/UZF641mpmOp0jbDPvfo7Vu6rjlEHBCK439FXJ9a1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693426; c=relaxed/simple;
	bh=m3kC4tz7noRERlVMyBS8eOyyMWXXtshmKA59iy5yIFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ISSgf4jYTX95KXGn9yvGMW3QDYEuNUtaM2zc00wPv2w1afESNGOPqQ1vgr0j5S0WOJJr0G2XeNmB5dVtxeRZ9QcowRjKxUCVS9U6N0S5ycRxNre+FSJaQ6W/kb2MM0Jal2djd69lBKCxo1uj3rOIX1YzZi4MHEbn1dkk+CGPOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1vQiIOe; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1vQiIOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743693424; x=1775229424;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=m3kC4tz7noRERlVMyBS8eOyyMWXXtshmKA59iy5yIFU=;
  b=M1vQiIOeTQkxweY0aPxyXfadNxi17xL9prhz/x15FrL/Vn4ulvSf2NSY
   kOxcNhEySO/CUfagJEXUEERvt/RXizgME9Eo8tpHuu5mC9v4NAiA+Abe6
   efDXiaUq9xdyUtSVcr7aoK8tsNsXbCgl5Aaus5ez4g/kr3rKfRKeZrnLi
   j1fd6k2U/SNOl9lS80XdPnMDqBVPCAcnU4cj4OcLkbEg95eOqAtGrGQ/0
   /4Ti+/INUMCcbJDigZdYQQI+lknD4Uuma466t6HbKH1kON41/UW6oR7jJ
   UcTMoAVOi38gZkwFJbZyywRBaqI/KIE/rhVqsSXLGvsVFM0+NoRiCz4ug
   w==;
X-CSE-ConnectionGUID: zDtoC5LVSGC6udWho5jzZA==
X-CSE-MsgGUID: TCVLntgYQ1W+uKrWRTp35w==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="48974788"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="48974788"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 08:17:03 -0700
X-CSE-ConnectionGUID: swrIOS9FSL2P447QyT0c2Q==
X-CSE-MsgGUID: mWwZKqiiSqCw/9mtRwBuKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="131763763"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 08:17:03 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C208F20B5736;
	Thu,  3 Apr 2025 08:17:00 -0700 (PDT)
Message-ID: <0924de97-67ec-4c8a-8c5c-66264bdd2748@linux.intel.com>
Date: Thu, 3 Apr 2025 11:16:59 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] perf parse-events: Set is_pmu_core for legacy
 hardware events
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>,
 Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>,
 James Clark <james.clark@linaro.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250210183808.130522-1-irogers@google.com>
 <20250210183808.130522-4-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250210183808.130522-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-10 1:38 p.m., Ian Rogers wrote:
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
>  
>  	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 6c36b98875bc..8cccf1e22cdf 100644
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

All online CPUs? Is there a problem for hybrid?

Thanks,
Kan> +		else
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

