Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E415574F;
	Tue,  3 Sep 2024 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388805; cv=none; b=gI7WgpUjR1ObbSk+AB1mjkuaq5iReylEgtvoxZMR7l9rtIiVe17pnkVEDitPO69REZvKZ9vTSxLKolzB+1QHxVIkOajhn5+ADQQrWFhzRhpTRgP6B+MGQipRNDYvDbmpr6Fk4YFw5KTqqAlr9Zg0beh+GlLOeTdhJm6PmB5Mqy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388805; c=relaxed/simple;
	bh=DzmqlxFkbW8l5hee1Qs9zw4hXO9ms1lr7KFAAbhwKtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VUtqOishYS2FwSl8ZcjGyA+GM7lTuPZ/dM/ErzGNjFEL9gaMiAY+t7OXyweuyOcNs2Co2oIfwmjWS8PKKMF44UGHwvqa+HMQBc0bUlI18ZMIu32dmOEKEGLGNe+89cf0Hl8TyQI96ME41f6pWtlKxi6L2sKZe5p+OyLHJBksQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQdSi3T2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQdSi3T2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725388804; x=1756924804;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=DzmqlxFkbW8l5hee1Qs9zw4hXO9ms1lr7KFAAbhwKtk=;
  b=OQdSi3T2MJlHLVurLNrR94FOv+FibwrPysMcOScn5y3HEUTm0+mX5ZhT
   iBEAAH5rgWymtkgtV0WMlc4mdk+i3kNUrcHn6iYvsGol9YyCPdyu/9vQq
   UbXAA8vW2BxCaX9XfuNief2HUzb6vdJL/iU18u1LqAwskUuIq4dSor0yP
   u05r8WUoyXreQivkotRP4oCcH+X+KTbDoLxTYIC7lXcv3cnek1RKSSA6S
   viwOsW0KPCXtxDPpELwhzL6oWNs/hyd/I5NBKWiY4IYMbpW0ybYImkHyz
   4e18YtFvtIKfG2pjAi4yCwST7rZya8hbHG81+dYy3OOMANBR6eVVSKpp/
   A==;
X-CSE-ConnectionGUID: +si+VclSSmOdD9yNnv+ACQ==
X-CSE-MsgGUID: R7sP72MHQ2WvklzG2Rlogg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23525669"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="23525669"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:40:03 -0700
X-CSE-ConnectionGUID: drdrmKCAR4yEXkdLsALm5A==
X-CSE-MsgGUID: 00LTrQ9DRyugXGYv3JuTeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="102419383"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:39:57 -0700
Message-ID: <45a41368-8986-491f-a6cc-20800b857f27@intel.com>
Date: Tue, 3 Sep 2024 21:39:50 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] perf auxtrace: Refactor evlist__enable_event_idx()
To: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20240823113306.2310957-1-leo.yan@arm.com>
 <20240823113306.2310957-6-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240823113306.2310957-6-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/08/24 14:33, Leo Yan wrote:
> This commit splits the evlist__enable_event_idx() function into two
> steps. The first step uses a new function evlist__find_cpu_map_idx() to
> find the CPU map index, based on the found CPU map index or a thread map
> index, it continues to call evlist__enable_event_idx() for enabling the
> corresponding event.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/auxtrace.c | 42 +++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 87e4f21b6edf..e7b582d92811 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -651,20 +651,30 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
>  	return -EINVAL;
>  }
>  
> -static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
> +static int evlist__find_cpu_map_idx(struct evlist *evlist, struct evsel *evsel,
> +				    int idx)
>  {
>  	bool per_cpu_mmaps = !perf_cpu_map__has_any_cpu(evlist->core.user_requested_cpus);
> +	struct perf_cpu evlist_cpu;
> +	int cpu_map_idx;
>  
> -	if (per_cpu_mmaps) {
> -		struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
> -		int cpu_map_idx = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
> +	if (!per_cpu_mmaps)
> +		return -EINVAL;
>  
> -		if (cpu_map_idx == -1)
> -			return -EINVAL;
> -		return perf_evsel__enable_cpu(&evsel->core, cpu_map_idx);
> -	}
> +	evlist_cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
> +	cpu_map_idx = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
> +	if (cpu_map_idx == -1)
> +		return -ENOENT;
> +
> +	return cpu_map_idx;
> +}
>  
> -	return perf_evsel__enable_thread(&evsel->core, idx);
> +static int evlist__enable_event_idx(struct evsel *evsel, int cpu_mode, int idx)
> +{
> +	if (cpu_mode)
> +		return perf_evsel__enable_cpu(&evsel->core, idx);
> +	else
> +		return perf_evsel__enable_thread(&evsel->core, idx);
>  }
>  
>  int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
> @@ -676,9 +686,21 @@ int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
>  
>  	evlist__for_each_entry(itr->evlist, evsel) {
>  		if (evsel__is_aux_event(evsel)) {
> +			int cpu_map_idx;
> +
>  			if (evsel->disabled)
>  				return 0;
> -			return evlist__enable_event_idx(itr->evlist, evsel, idx);
> +
> +			cpu_map_idx = evlist__find_cpu_map_idx(itr->evlist,
> +							       evsel, idx);
> +			/* No map is found in per CPU mmap */
> +			if (cpu_map_idx == -ENOENT)
> +				return cpu_map_idx;
> +
> +			if (cpu_map_idx >= 0)
> +				return evlist__enable_event_idx(evsel, 1, cpu_map_idx);
> +			else
> +				return evlist__enable_event_idx(evsel, 0, idx);
>  		}
>  	}
>  	return -EINVAL;

What about keeping per_cpu_mmaps in auxtrace_record__read_finish()
e.g.

static int evlist__find_evsel_cpu_idx(struct evlist *evlist, struct evsel *evsel, int idx)
{
	struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);

	return perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
}

int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
{
	bool per_cpu_mmaps = !perf_cpu_map__has_any_cpu(evlist->core.user_requested_cpus);
	struct evsel *evsel;
	int evsel_cpu_idx;

	if (!itr->evlist)
		return -EINVAL;

	evlist__for_each_entry(itr->evlist, evsel) {
		if (!evsel__is_aux_event(evsel))
			continue;

		if (per_cpu_mmaps) {
			evsel_cpu_idx = evlist__find_evsel_cpu_idx(itr->evlist, evsel, idx);
			/* No map is found in per CPU mmap */
			if (evsel_cpu_idx < 0)
				return -EINVAL;
		}

		if (evsel->disabled)
			return 0;

		if (per_cpu_mmaps)
			return perf_evsel__enable_cpu(&evsel->core, evsel_cpu_idx);

		return perf_evsel__enable_thread(&evsel->core, idx);
	}
	return -EINVAL;
}

