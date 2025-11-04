Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5813AF2;
	Tue,  4 Nov 2025 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762231935; cv=none; b=Q0tmjROayg8TwlutNVnL9l900MKWEKSuqP7x+VmzS5tI3jImh1e66pBtrUerCs3Pe1Uhr85WRzSFk+xZ9zzG2TLnkGz+U0nAYUH5ijJK2F3XRuP3RnrLhuMLVOY3uS0+hhgJ1zqAUNlfu92YC13gMN+yzPqZ1E7DQIwVMBNjKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762231935; c=relaxed/simple;
	bh=tvonMAkdmDIaa9P3/K8ip62gNPVZb1WNmqCGHyIRKyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8V0ZW4fCGPbvwiOihxbn6j8IwWUfykc+Q/Kar0pA01ZmNzYlS15ZDAXSprACwg1h6KKI4kLaASyq/NXcmaZ1n2hkbfGCrxlyKeGzx/pJEDxFfT88cZ5r0YIKkf88mIQ15dJOBL7oLAKQttWEh/e7orVkjGAL7CmoVNm/gBPEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEzZSlc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEzZSlc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2401DC4CEF8;
	Tue,  4 Nov 2025 04:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762231934;
	bh=tvonMAkdmDIaa9P3/K8ip62gNPVZb1WNmqCGHyIRKyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HEzZSlc6BED1LfGVfN093g4j53wApkF9FzgaoNaANfFG68717aO04hiYRjQZHEwFm
	 LZoPPBSZnE9KUhIbudGwgaHeJlhlN0bjgHUObA+B8OGBtBRoKw44e+33klNpRkyHYz
	 ws5+s2je+o2LmclfgLkJiKJof2vFesoOsqyfUTmd7eO5gm04dUg1Tim2t0wMiLT0ic
	 e4k6+RK8MOyqanbvhwQCW9BCOt3ud+cuz+zVPkdcJ/XgHItbiYlW9bsOU/o2yF0nil
	 EcMotjDiEgg9tjCkKkt1dPI/YKyDGZFKUCNJajbIafOhWyy2oBzaCOR2i0D+5BJ6nO
	 ftN7WeHa/LlIA==
Date: Mon, 3 Nov 2025 20:52:12 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 05/22] perf metricgroup: Add care to picking the evsel
 for displaying a metric
Message-ID: <aQmGfLVKk0UFGAyd@google.com>
References: <20251024175857.808401-1-irogers@google.com>
 <20251024175857.808401-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024175857.808401-6-irogers@google.com>

On Fri, Oct 24, 2025 at 10:58:40AM -0700, Ian Rogers wrote:
> Rather than using the first evsel in the matched events, try to find
> the least shared non-tool evsel. The aim is to pick the first evsel
> that typifies the metric within the list of metrics.
> 
> This addresses an issue where Default metric group metrics may lose
> their counter value due to how the stat displaying hides counters for
> default event/metric output.

Do you have a command line example to show impact of this change?

Thanks,
Namhyung

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
> -- 
> 2.51.1.821.gb6fe4d2222-goog
> 
