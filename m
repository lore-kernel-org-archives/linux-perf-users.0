Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA032957B6;
	Tue, 11 Nov 2025 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848935; cv=none; b=ZwvUTgj6/dBbZ4b63F5YV+kyTo8atAg7Tg/5R6181dAdsufClYH6CNO8hjFqwIGnDa24pCUH9DGgWxGt/kcmmsFKD7BjaqGbjwzlEqYlaJ/iW9+qHi1OijQcb5aSw9E63Lq29ygow5TWspdSE1mIf1QeA3g3GaO/MA/pjnmTC1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848935; c=relaxed/simple;
	bh=DguBCWqKqS+yK4Y/p3bCA8+XgInji4qk9nohQ91vz6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tb5t2yaLSZJ24vm7P0MzsQuGMjhuz4IQaPVJ0lQI09lBHc+Qo5oriqwXBfWz56W55LaYSMNJvEk275uxfB3T5fJd02wuEzLcc9UbRZnZ6Nb6aKbvIUeiU230LpLSYyNZMLBqve/YwJflQ/OHGqRHXzouwb7kmTMay57x7bcfMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXn/Nn5J; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXn/Nn5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762848934; x=1794384934;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=DguBCWqKqS+yK4Y/p3bCA8+XgInji4qk9nohQ91vz6g=;
  b=MXn/Nn5JXL7huU8PBBiMCxHFBhlrZXWDnz82mEwhZKEz0VG0g0IA+5Ya
   qQK/uBbd9gSeh19iZwXG5/LNgR4heqBg10N71Zqg+oZ6LPd21rqwOujHX
   7W3VOxSCNHDnucsHFNWzQef9ISRsD6a1VxtU5x5RFl1uwixHMDUzraW4s
   W9O8BvCpG8BGWR7fPlI0qVwPaTd/s9A/UEeAYFDCS8JKy1bC7F16HgGS1
   OKHl0jF9zSzpP7JGCw7CtTqjW8BEeBLEVPASFKsOkO1ufkzQZnjkd5BE5
   zryGZx2216NEy5nsuPDhMO0aXdOPj66XW9VAS8IV7zFds+TpaJezsRNtO
   g==;
X-CSE-ConnectionGUID: ZFmNc7hGRlmjCybHCx+Yaw==
X-CSE-MsgGUID: Z7AZG0ieTtamtrHJ+N5NBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="68768368"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="68768368"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:15:33 -0800
X-CSE-ConnectionGUID: MmuXOI1dRBiU+Ufnli4obA==
X-CSE-MsgGUID: 5ZnPeF+JS52e3qUEOz+tTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="193902406"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 00:15:28 -0800
Message-ID: <e0d29714-df04-48f9-8168-770bf05a0f7f@linux.intel.com>
Date: Tue, 11 Nov 2025 16:15:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/18] perf metricgroup: Add care to picking the evsel
 for displaying a metric
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
 Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Collin Funk <collin.funk1@gmail.com>, Thomas Falcon
 <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>,
 Levi Yun <yeoreum.yun@arm.com>, Yang Li <yang.lee@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
References: <20251111040417.270945-1-irogers@google.com>
 <20251111040417.270945-2-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251111040417.270945-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/11/2025 12:04 PM, Ian Rogers wrote:
> Rather than using the first evsel in the matched events, try to find
> the least shared non-tool evsel. The aim is to pick the first evsel
> that typifies the metric within the list of metrics.
>
> This addresses an issue where Default metric group metrics may lose
> their counter value due to how the stat displaying hides counters for
> default event/metric output.
>
> For a metricgroup like TopdownL1 on an Intel Alderlake the change is,
> before there are 4 events with metrics:
> ```
> $ perf stat -M topdownL1 -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>      7,782,334,296      cpu_core/TOPDOWN.SLOTS/          #     10.4 %  tma_bad_speculation
>                                                   #     19.7 %  tma_frontend_bound
>      2,668,927,977      cpu_core/topdown-retiring/       #     35.7 %  tma_backend_bound
>                                                   #     34.1 %  tma_retiring
>        803,623,987      cpu_core/topdown-bad-spec/
>        167,514,386      cpu_core/topdown-heavy-ops/
>      1,555,265,776      cpu_core/topdown-fe-bound/
>      2,792,733,013      cpu_core/topdown-be-bound/
>        279,769,310      cpu_atom/TOPDOWN_RETIRING.ALL/   #     12.2 %  tma_retiring
>                                                   #     15.1 %  tma_bad_speculation
>        457,917,232      cpu_atom/CPU_CLK_UNHALTED.CORE/  #     38.4 %  tma_backend_bound
>                                                   #     34.2 %  tma_frontend_bound
>        783,519,226      cpu_atom/TOPDOWN_FE_BOUND.ALL/
>         10,790,192      cpu_core/INT_MISC.UOP_DROPPING/
>        879,845,633      cpu_atom/TOPDOWN_BE_BOUND.ALL/
> ```
>
> After there are 6 events with metrics:
> ```
> $ perf stat -M topdownL1 -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>      2,377,551,258      cpu_core/TOPDOWN.SLOTS/          #      7.9 %  tma_bad_speculation
>                                                   #     36.4 %  tma_frontend_bound
>        480,791,142      cpu_core/topdown-retiring/       #     35.5 %  tma_backend_bound
>        186,323,991      cpu_core/topdown-bad-spec/
>         65,070,590      cpu_core/topdown-heavy-ops/      #     20.1 %  tma_retiring
>        871,733,444      cpu_core/topdown-fe-bound/
>        848,286,598      cpu_core/topdown-be-bound/
>        260,936,456      cpu_atom/TOPDOWN_RETIRING.ALL/   #     12.4 %  tma_retiring
>                                                   #     17.6 %  tma_bad_speculation
>        419,576,513      cpu_atom/CPU_CLK_UNHALTED.CORE/
>        797,132,597      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #     38.0 %  tma_frontend_bound
>          3,055,447      cpu_core/INT_MISC.UOP_DROPPING/
>        671,014,164      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #     32.0 %  tma_backend_bound
> ```

It looks the output of cpu_core and cpu_atom events are mixed together,
like the "cpu_core/INT_MISC.UOP_DROPPING/". Could we resort the events and
separate the cpu_core and cpu_atom events output? It would make the output
more read-friendly. Thanks.


>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/metricgroup.c | 48 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 48936e517803..76092ee26761 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1323,6 +1323,51 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
>  	return ret;
>  }
>  
> +/* How many times will a given evsel be used in a set of metrics? */
> +static int count_uses(struct list_head *metric_list, struct evsel *evsel)
> +{
> +	const char *metric_id = evsel__metric_id(evsel);
> +	struct metric *m;
> +	int uses = 0;
> +
> +	list_for_each_entry(m, metric_list, nd) {
> +		if (hashmap__find(m->pctx->ids, metric_id, NULL))
> +			uses++;
> +	}
> +	return uses;
> +}
> +
> +/*
> + * Select the evsel that stat-display will use to trigger shadow/metric
> + * printing. Pick the least shared non-tool evsel, encouraging metrics to be
> + * with a hardware counter that is specific to them.
> + */
> +static struct evsel *pick_display_evsel(struct list_head *metric_list,
> +					struct evsel **metric_events)
> +{
> +	struct evsel *selected = metric_events[0];
> +	size_t selected_uses;
> +	bool selected_is_tool;
> +
> +	if (!selected)
> +		return NULL;
> +
> +	selected_uses = count_uses(metric_list, selected);
> +	selected_is_tool = evsel__is_tool(selected);
> +	for (int i = 1; metric_events[i]; i++) {
> +		struct evsel *candidate = metric_events[i];
> +		size_t candidate_uses = count_uses(metric_list, candidate);
> +
> +		if ((selected_is_tool && !evsel__is_tool(candidate)) ||
> +		    (candidate_uses < selected_uses)) {
> +			selected = candidate;
> +			selected_uses = candidate_uses;
> +			selected_is_tool = evsel__is_tool(selected);
> +		}
> +	}
> +	return selected;
> +}
> +
>  static int parse_groups(struct evlist *perf_evlist,
>  			const char *pmu, const char *str,
>  			bool metric_no_group,
> @@ -1430,7 +1475,8 @@ static int parse_groups(struct evlist *perf_evlist,
>  			goto out;
>  		}
>  
> -		me = metricgroup__lookup(&perf_evlist->metric_events, metric_events[0],
> +		me = metricgroup__lookup(&perf_evlist->metric_events,
> +					 pick_display_evsel(&metric_list, metric_events),
>  					 /*create=*/true);
>  
>  		expr = malloc(sizeof(struct metric_expr));
