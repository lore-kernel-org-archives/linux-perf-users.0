Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F2274FF1;
	Wed, 16 Jul 2025 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697688; cv=none; b=N0jD6LN41vfKAmGHNR8zPL9Gi/o50dx0iMc0pdteAwsZzLp+6997qbtHv4xIP5lLYvCyGFxIjgQr2R7QPST+NGN4luTGeJm9i4YCn4DXa9Om1bWWez0jT3LqXtSyNd953yNLfs3qN6R5vzVUaSSYREf8pvpJqmqCZGE4ZBrZhZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697688; c=relaxed/simple;
	bh=brHo0opNvg7cbMIzp5qYocuQ4Uf/Pi0EVD1qO32ApB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnOXAmjP4/GxpvMdvkB8Ed0BpG6tQQeg/ruUzXlEI2py9da01c+t3E8YcrwlTtf3Ykv6OB4Y3O9FD8m38IMFiRrFDDD0WPubzwQnrbm4+lz0DoW59nOoUSM2LP1AGCJzbArGeSpR2c5OIzdnKAOHyPsEpVygEanFaJaiZAYRjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XS9wW+kC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS9wW+kC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5057C4CEE7;
	Wed, 16 Jul 2025 20:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752697687;
	bh=brHo0opNvg7cbMIzp5qYocuQ4Uf/Pi0EVD1qO32ApB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XS9wW+kCAdkIs5Bt2XOj2EhOPkuGPB92ZEvnDz/jfOInfmJCwXIbUYlJOwBm5c5C4
	 SxQhGI5YL9BpuiZX7QsNK5MSlb0s7xfn0e6vkX/uW8mbEVLs2aXFfxpa252kxruxTq
	 8BL8JKk3oewMZzEva9iMDYJ5o+TTm7B65eS9c2402Dy+XHytd5KUOprfJjZZNIWElb
	 6h4FWhOqCuVNNwsbSzyN2HBWpIH1uIFjlZlqrXW0F3n2xNrFhuyUkSX0VFJZ6NuRg8
	 3M5TPVpBWcerUE4g3ExO4XEFF//YqHQ40uaXOy4/HN5Vv0WfZYp1yadLcRiN5+0tDy
	 8HPsURqRtwzdw==
Date: Wed, 16 Jul 2025 13:28:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ben Gainey <ben.gainey@arm.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Blake Jones <blakejones@google.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/12] perf parse-events: Support user CPUs mixed with
 threads/processes
Message-ID: <aHgLVcxpEphtYLsB@google.com>
References: <20250627192417.1157736-1-irogers@google.com>
 <20250627192417.1157736-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627192417.1157736-13-irogers@google.com>

On Fri, Jun 27, 2025 at 12:24:17PM -0700, Ian Rogers wrote:
> Counting events system-wide with a specified CPU prior to this change worked:
> ```
> $ perf stat -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' -a sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>      59,393,419,099      msr/tsc/
>      33,927,965,927      msr/tsc,cpu=cpu_core/
>      25,465,608,044      msr/tsc,cpu=cpu_atom/
> ```
> 
> However, when counting with process the counts became system wide:
> ```
> $ perf stat -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' perf test -F 10
>  10.1: Basic parsing test                                            : Ok
>  10.2: Parsing without PMU name                                      : Ok
>  10.3: Parsing with PMU name                                         : Ok
> 
>  Performance counter stats for 'perf test -F 10':
> 
>         59,233,549      msr/tsc/
>         59,227,556      msr/tsc,cpu=cpu_core/
>         59,224,053      msr/tsc,cpu=cpu_atom/
> ```
> 
> Make the handling of CPU maps with event parsing clearer. When an
> event is parsed creating an evsel the cpus should be either the PMU's
> cpumask or user specified CPUs.
> 
> Update perf_evlist__propagate_maps so that it doesn't clobber the user
> specified CPUs. Try to make the behavior clearer, firstly fix up
> missing cpumasks. Next, perform sanity checks and adjustments from the
> global evlist CPU requests and for the PMU including simplifying to
> the "any CPU"(-1) value. Finally remove the event if the cpumask is
> empty.
> 
> So that events are opened with a CPU and a thread change stat's
> create_perf_stat_counter to give both.
> 
> With the change things are fixed:
> ```
> $ perf stat --no-scale -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' perf test -F 10
>  10.1: Basic parsing test                                            : Ok
>  10.2: Parsing without PMU name                                      : Ok
>  10.3: Parsing with PMU name                                         : Ok
> 
>  Performance counter stats for 'perf test -F 10':
> 
>         63,704,975      msr/tsc/
>         47,060,704      msr/tsc,cpu=cpu_core/                        (4.62%)
>         16,640,591      msr/tsc,cpu=cpu_atom/                        (2.18%)
> ```
> 
> However, note the "--no-scale" option is used. This is necessary as
> the running time for the event on the counter isn't the same as the
> enabled time because the thread doesn't necessarily run on the CPUs
> specified for the counter. All counter values are scaled with:
> 
>   scaled_value = value * time_enabled / time_running
> 
> and so without --no-scale the scaled_value becomes very large. This
> problem already exists on hybrid systems for the same reason. Here are
> 2 runs of the same code with an instructions event that counts the
> same on both types of core, there is no real multiplexing happening on
> the event:

This is unfortunate.  The event is in a task context but also has a CPU
constraint.  So it's not schedulable on other CPUs.

A problem is that it cannot distinguish the real multiplexing..

> 
> ```
> $ perf stat -e instructions perf test -F 10
> ...
>  Performance counter stats for 'perf test -F 10':
> 
>         87,896,447      cpu_atom/instructions/                       (14.37%)
>         98,171,964      cpu_core/instructions/                       (85.63%)
> ...
> $ perf stat --no-scale -e instructions perf test -F 10
> ...
>  Performance counter stats for 'perf test -F 10':
> 
>         13,069,890      cpu_atom/instructions/                       (19.32%)
>         83,460,274      cpu_core/instructions/                       (80.68%)
> ...
> ```
> The scaling has inflated per-PMU instruction counts and the overall
> count by 2x.
> 
> To fix this the kernel needs changing when a task+CPU event (or just
> task event on hybrid) is scheduled out. A fix could be that the state
> isn't inactive but off for such events, so that time_enabled counts
> don't accumulate on them.

Right, maybe we need to add a new state (UNSCHEDULABLE?) to skip
updating the enabled time.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/evlist.c        | 118 ++++++++++++++++++++++-----------
>  tools/perf/util/parse-events.c |  10 ++-
>  tools/perf/util/stat.c         |   6 +-
>  3 files changed, 86 insertions(+), 48 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 9d9dec21f510..2d2236400220 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -36,49 +36,87 @@ void perf_evlist__init(struct perf_evlist *evlist)
>  static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>  					  struct perf_evsel *evsel)
>  {
> -	if (evsel->system_wide) {
> -		/* System wide: set the cpu map of the evsel to all online CPUs. */
> -		perf_cpu_map__put(evsel->cpus);
> -		evsel->cpus = perf_cpu_map__new_online_cpus();
> -	} else if (evlist->has_user_cpus && evsel->is_pmu_core) {
> -		/*
> -		 * User requested CPUs on a core PMU, ensure the requested CPUs
> -		 * are valid by intersecting with those of the PMU.
> -		 */
> +	if (perf_cpu_map__is_empty(evsel->cpus)) {
> +		if (perf_cpu_map__is_empty(evsel->pmu_cpus)) {
> +			/*
> +			 * Assume the unset PMU cpus were for a system-wide
> +			 * event, like a software or tracepoint.
> +			 */
> +			evsel->pmu_cpus = perf_cpu_map__new_online_cpus();
> +		}
> +		if (evlist->has_user_cpus && !evsel->system_wide) {
> +			/*
> +			 * Use the user CPUs unless the evsel is set to be
> +			 * system wide, such as the dummy event.
> +			 */
> +			evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> +		} else {
> +			/*
> +			 * System wide and other modes, assume the cpu map
> +			 * should be set to all PMU CPUs.
> +			 */
> +			evsel->cpus = perf_cpu_map__get(evsel->pmu_cpus);
> +		}
> +	}
> +	/*
> +	 * Avoid "any CPU"(-1) for uncore and PMUs that require a CPU, even if
> +	 * requested.
> +	 */
> +	if (evsel->requires_cpu && perf_cpu_map__has_any_cpu(evsel->cpus)) {
>  		perf_cpu_map__put(evsel->cpus);
> -		evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->pmu_cpus);
> +		evsel->cpus = perf_cpu_map__get(evsel->pmu_cpus);
> +	}
>  
> -		/*
> -		 * Empty cpu lists would eventually get opened as "any" so remove
> -		 * genuinely empty ones before they're opened in the wrong place.
> -		 */
> -		if (perf_cpu_map__is_empty(evsel->cpus)) {
> -			struct perf_evsel *next = perf_evlist__next(evlist, evsel);
> -
> -			perf_evlist__remove(evlist, evsel);
> -			/* Keep idx contiguous */
> -			if (next)
> -				list_for_each_entry_from(next, &evlist->entries, node)
> -					next->idx--;
> +	/*
> +	 * Globally requested CPUs replace user requested unless the evsel is
> +	 * set to be system wide.
> +	 */
> +	if (evlist->has_user_cpus && !evsel->system_wide) {
> +		assert(!perf_cpu_map__has_any_cpu(evlist->user_requested_cpus));
> +		if (!perf_cpu_map__equal(evsel->cpus, evlist->user_requested_cpus)) {
> +			perf_cpu_map__put(evsel->cpus);
> +			evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>  		}
> -	} else if (!evsel->pmu_cpus || evlist->has_user_cpus ||
> -		(!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
> -		/*
> -		 * The PMU didn't specify a default cpu map, this isn't a core
> -		 * event and the user requested CPUs or the evlist user
> -		 * requested CPUs have the "any CPU" (aka dummy) CPU value. In
> -		 * which case use the user requested CPUs rather than the PMU
> -		 * ones.
> -		 */
> +	}
> +
> +	/* Ensure cpus only references valid PMU CPUs. */
> +	if (!perf_cpu_map__has_any_cpu(evsel->cpus) &&
> +	    !perf_cpu_map__is_subset(evsel->pmu_cpus, evsel->cpus)) {
> +		struct perf_cpu_map *tmp = perf_cpu_map__intersect(evsel->pmu_cpus, evsel->cpus);
> +
>  		perf_cpu_map__put(evsel->cpus);
> -		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> -	} else if (evsel->cpus != evsel->pmu_cpus) {
> -		/*
> -		 * No user requested cpu map but the PMU cpu map doesn't match
> -		 * the evsel's. Reset it back to the PMU cpu map.
> -		 */
> +		evsel->cpus = tmp;
> +	}
> +
> +	/*
> +	 * Was event requested on all the PMU's CPUs but the user requested is
> +	 * any CPU (-1)? If so switch to using any CPU (-1) to reduce the number
> +	 * of events.
> +	 */
> +	if (!evsel->system_wide &&
> +	    perf_cpu_map__equal(evsel->cpus, evsel->pmu_cpus) &&
> +	    perf_cpu_map__has_any_cpu(evlist->user_requested_cpus)) {
>  		perf_cpu_map__put(evsel->cpus);
> -		evsel->cpus = perf_cpu_map__get(evsel->pmu_cpus);
> +		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> +	}
> +
> +	/* Sanity check assert before the evsel is potentially removed. */
> +	assert(!evsel->requires_cpu || !perf_cpu_map__has_any_cpu(evsel->cpus));
> +
> +	/*
> +	 * Empty cpu lists would eventually get opened as "any" so remove
> +	 * genuinely empty ones before they're opened in the wrong place.
> +	 */
> +	if (perf_cpu_map__is_empty(evsel->cpus)) {
> +		struct perf_evsel *next = perf_evlist__next(evlist, evsel);
> +
> +		perf_evlist__remove(evlist, evsel);
> +		/* Keep idx contiguous */
> +		if (next)
> +			list_for_each_entry_from(next, &evlist->entries, node)
> +				next->idx--;
> +
> +		return;
>  	}
>  
>  	if (evsel->system_wide) {
> @@ -98,6 +136,10 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
>  
>  	evlist->needs_map_propagation = true;
>  
> +	/* Clear the all_cpus set which will be merged into during propagation. */
> +	perf_cpu_map__put(evlist->all_cpus);
> +	evlist->all_cpus = NULL;
> +
>  	list_for_each_entry_safe(evsel, n, &evlist->entries, node)
>  		__perf_evlist__propagate_maps(evlist, evsel);
>  }
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 4092a43aa84e..0ff7ae75d8f9 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -313,20 +313,18 @@ __add_event(struct list_head *list, int *idx,
>  	if (pmu) {
>  		is_pmu_core = pmu->is_core;
>  		pmu_cpus = perf_cpu_map__get(pmu->cpus);
> +		if (perf_cpu_map__is_empty(pmu_cpus))
> +			pmu_cpus = cpu_map__online();
>  	} else {
>  		is_pmu_core = (attr->type == PERF_TYPE_HARDWARE ||
>  			       attr->type == PERF_TYPE_HW_CACHE);
>  		pmu_cpus = is_pmu_core ? cpu_map__online() : NULL;
>  	}
>  
> -	if (has_user_cpus) {
> +	if (has_user_cpus)
>  		cpus = perf_cpu_map__get(user_cpus);
> -		/* Existing behavior that pmu_cpus matches the given user ones. */
> -		perf_cpu_map__put(pmu_cpus);
> -		pmu_cpus = perf_cpu_map__get(user_cpus);
> -	} else {
> +	else
>  		cpus = perf_cpu_map__get(pmu_cpus);
> -	}
>  
>  	if (init_attr)
>  		event_attr_init(attr);
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 355a7d5c8ab8..8d3bcdb69d37 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -769,8 +769,6 @@ int create_perf_stat_counter(struct evsel *evsel,
>  			attr->enable_on_exec = 1;
>  	}
>  
> -	if (target__has_cpu(target) && !target__has_per_thread(target))
> -		return evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu_map_idx);
> -
> -	return evsel__open_per_thread(evsel, evsel->core.threads);
> +	return evsel__open_per_cpu_and_thread(evsel, evsel__cpus(evsel), cpu_map_idx,
> +					      evsel->core.threads);
>  }
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
