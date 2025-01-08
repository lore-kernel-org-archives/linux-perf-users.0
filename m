Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BCD202C41;
	Wed,  8 Jan 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365521; cv=none; b=dXEz2R60+JydwfoNcwYiecsx63Wm9sxvVOx38NVmQQU+t1zv9hKTwCLivI4EVks2vabywzXMGmdJWh1M+TptGexDp/aPNM+C31O8okYNKGTSIiyOskgIaDXF4WmLmRzSTTYM83FGB0EByLE+zz7b+jyA0YNJJYwehxaTmkXhm1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365521; c=relaxed/simple;
	bh=CMuP0H9ETwtFDnpu5R7vNHWZzlXhp2pJ7kYHvHZS9yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/z6F6UoFRY6kZhJQE/H1AFPFyEckk7C6CQ6kLs9dofx7HJIL5IvDFeJ/uqTOtA6wTXtiVGTgA3qPM9+SV3ySecvrOfZap25TRfLZNd815SkiAjV7lJZRn8xhv/oVOBB5E+jrzp/rDvDV7wi4lykmDBDyBETonESI/Si9bwhpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddwAkj+i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddwAkj+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA853C4CED3;
	Wed,  8 Jan 2025 19:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736365520;
	bh=CMuP0H9ETwtFDnpu5R7vNHWZzlXhp2pJ7kYHvHZS9yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddwAkj+i0I2tCwQfvzqhODKrhI7cMZM6wGCsvKh2etEwDi1ggkvwHPfrwaU7Nbli6
	 FJEOA0rezVU8U17ux9MzYQRSmb+vPZ9AJTW5E72RXmGV8oD1B5FWfr5QZzd8Az5lC9
	 rwSyroirsFDFHTP/VIdw0Ar+QKqPWhtGJgB0Y4gfUh/XSeuGP0My7bR9NdVkzjPjDz
	 xmD301QHobDJVvt6BoxA3Fj08vIUg/29ADIjLDI2KMkSmhArQVOPTKM+mYM3nEISiL
	 ScSqya5N6GLihnloXEv5eymP7X/TcBpb+9Gq8kiQPMT1tutbxJD3rFip+E3vWp9CT+
	 JUsY8OsIxAGeg==
Date: Wed, 8 Jan 2025 11:45:18 -0800
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
Subject: Re: [PATCH v4 2/4] perf stat: Use counter cpumask to skip zero values
Message-ID: <Z37Vzk_-x-nE34fL@google.com>
References: <20250108053428.1724490-1-irogers@google.com>
 <20250108053428.1724490-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250108053428.1724490-3-irogers@google.com>

On Tue, Jan 07, 2025 at 09:34:26PM -0800, Ian Rogers wrote:
> When a counter is 0 it may or may not be skipped. For uncore counters
> it is common they are only valid on 1 logical CPU and all other CPUs
> should be skipped. The PMU's cpumask was used for the skip
> calculation, but that cpumask may not reflect user overrides.

It's not clear to me how uncore PMU works with CPU overrides.
I thought it's ignored and the kernel changed the CPU internally
using the cpumask.  But it may be transparent to userspace and
we can think it works as what we expect.

Anyway, the commit dd15480a3d67b9cf ("perf stat: Hide invalid uncore
event output for aggr mode") added the code and the concern was like

  $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1

So it should be fine as long as the output remains the same.


> Similarly a counter on a core PMU may explicitly not
> request a CPU be gathered. If the counter on this CPU's value is 0
> then the counter should be skipped as it wasn't requested. Switch from
> using the PMU cpumask to that associated with the evsel to support
> these cases.

Do you mean hybrid PMUs?  I guess they won't open events on not
supported/requested CPUs in the first place, right?

Thanks,
Namhyung

> 
> Avoid potential crash with --per-thread mode where config->aggr_get_id
> is NULL. Add some examples for the tool event 0 counter skipping.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-display.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index ba79f73e1cf5..32badf623267 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1042,8 +1042,16 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
>  		return true;
>  
>  	/*
> -	 * Many tool events are only gathered on the first index, skip other
> -	 * zero values.
> +	 * In per-thread mode the aggr_map and aggr_get_id functions may be
> +	 * NULL, assume all 0 values should be output in that case.
> +	 */
> +	if (!config->aggr_map || !config->aggr_get_id)
> +		return false;
> +
> +	/*
> +	 * Tool events may be gathered on all logical CPUs, for example
> +	 * system_time, but for many the first index is the only one used, for
> +	 * example num_cores. Don't skip for the first index.
>  	 */
>  	if (evsel__is_tool(counter)) {
>  		struct aggr_cpu_id own_id =
> @@ -1051,15 +1059,12 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
>  
>  		return !aggr_cpu_id__equal(id, &own_id);
>  	}
> -
>  	/*
> -	 * Skip value 0 when it's an uncore event and the given aggr id
> -	 * does not belong to the PMU cpumask.
> +	 * Skip value 0 when the counter's cpumask doesn't match the given aggr
> +	 * id.
>  	 */
> -	if (!counter->pmu || !counter->pmu->is_uncore)
> -		return false;
>  
> -	perf_cpu_map__for_each_cpu(cpu, idx, counter->pmu->cpus) {
> +	perf_cpu_map__for_each_cpu(cpu, idx, counter->core.cpus) {
>  		struct aggr_cpu_id own_id = config->aggr_get_id(config, cpu);
>  
>  		if (aggr_cpu_id__equal(id, &own_id))
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
