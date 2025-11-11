Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3C2D2390;
	Tue, 11 Nov 2025 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900933; cv=none; b=pzNVSwuHkp6PHQu558zrx9XArwoZZLN5Q7UYx2wnpQ9P7pH/H8OBDqqq4KY9h6Ru+mnbm0FQ0BAderq11D9Qy73rMvR0CmMvX+j3SzQhJGybxGuDxcXO45379oE9NJo7BSjv2kVHHtV/JjOx1WX9Fm0HeE/t3NeOPoH44V1Smww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900933; c=relaxed/simple;
	bh=Lc9vhqqidLUUiVViFMCDBdY4ppWiVH0VoPoZ9DtU8aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFUTo6NrWx4K6Jn7gnjmEbQt4MgH/gLSTOAlWM/QHMk/SIE/gdElJSAGfJjLOgJZZpttilUDHN0CvU3n0fImYi3Y1Uq7Qmby4p08bubO7h2fNOl9WzJMFEbm2TpfQ0ywU/1ugN4PFfViZdC2qisvcE5oCUyqBifaBnFF7v6H/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xnkqmh7V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xnkqmh7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D8EC4CEF5;
	Tue, 11 Nov 2025 22:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762900929;
	bh=Lc9vhqqidLUUiVViFMCDBdY4ppWiVH0VoPoZ9DtU8aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xnkqmh7Vdg5xjX4LAbdSu3EeRd/rn1Eo1xo/XIY+XZjkAhUj4p4h1g29BekPqUl1w
	 I3MRupU0RubvZN/5IHKyJopF/AvuZBAR7efQDNktscKRPSygncjmry4hbzmYLle7uz
	 z/8UYuDMBfbqLYpt9Mzxu+GpC1F8GHW9G3vBXhs5WhgHOHyW/r5EdZJDormvABzaKH
	 egkFVW8oDvmFwnncKjLaIShMjR173Pq5MTPqQALIosy2JQi3+28bLCYe5vm88KzE12
	 imzxqQWn4ltyHtu3nqGO1NzZ+xYMNQR6x0M2IK0vKchjmJOjsFQtgaFlaatqLoQ+n+
	 sFMSTzEHV/q0w==
Date: Tue, 11 Nov 2025 14:42:04 -0800
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
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>
Subject: Re: [PATCH v4 00/18]
Message-ID: <aRO7vPpfuH7vzRg-@google.com>
References: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111212206.631711-1-irogers@google.com>

On Tue, Nov 11, 2025 at 01:21:48PM -0800, Ian Rogers wrote:
> Prior to this series stat-shadow would produce hard coded metrics if
> certain events appeared in the evlist. This series produces equivalent
> json metrics and cleans up the consequences in tests and display
> output. A before and after of the default display output on a
> tigerlake is:
> 
> Before:
> ```
> $ perf stat -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>     16,041,816,418      cpu-clock                        #   15.995 CPUs utilized             
>              5,749      context-switches                 #  358.376 /sec                      
>                121      cpu-migrations                   #    7.543 /sec                      
>              1,806      page-faults                      #  112.581 /sec                      
>        825,965,204      instructions                     #    0.70  insn per cycle            
>      1,180,799,101      cycles                           #    0.074 GHz                       
>        168,945,109      branches                         #   10.532 M/sec                     
>          4,629,567      branch-misses                    #    2.74% of all branches           
>  #     30.2 %  tma_backend_bound      
>                                                   #      7.8 %  tma_bad_speculation    
>                                                   #     47.1 %  tma_frontend_bound     
>  #     14.9 %  tma_retiring           
> ```
> 
> After:
> ```
> $ perf stat -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>              2,890      context-switches                 #    179.9 cs/sec  cs_per_second     
>     16,061,923,339      cpu-clock                        #     16.0 CPUs  CPUs_utilized       
>                 43      cpu-migrations                   #      2.7 migrations/sec  migrations_per_second
>              5,645      page-faults                      #    351.5 faults/sec  page_faults_per_second
>          5,708,413      branch-misses                    #      1.4 %  branch_miss_rate         (88.83%)
>        429,978,120      branches                         #     26.8 M/sec  branch_frequency     (88.85%)
>      1,626,915,897      cpu-cycles                       #      0.1 GHz  cycles_frequency       (88.84%)
>      2,556,805,534      instructions                     #      1.5 instructions  insn_per_cycle  (88.86%)
>                         TopdownL1                 #     20.1 %  tma_backend_bound      
>                                                   #     40.5 %  tma_bad_speculation      (88.90%)
>                                                   #     17.2 %  tma_frontend_bound       (78.05%)
>                                                   #     22.2 %  tma_retiring             (88.89%)
> 
>        1.002994394 seconds time elapsed
> ```
> 
> Having the metrics in json brings greater uniformity, allows events to
> be shared by metrics, and it also allows descriptions like:
> ```
> $ perf list cs_per_second
> ...
>   cs_per_second
>        [Context switches per CPU second]
> ```
> 
> A thorn in the side of doing this work was that the hard coded metrics
> were used by perf script with '-F metric'. This functionality didn't
> work for me (I was testing `perf record -e instructions,cycles`
> with/without leader sampling and then `perf script -F metric` but saw
> nothing but empty lines) but anyway I decided to fix it to the best of
> my ability in this series. So the script side counters were removed
> and the regular ones associated with the evsel used. The json metrics
> were all searched looking for ones that have a subset of events
> matching those in the perf script session, and all metrics are
> printed. This is kind of weird as the counters are being set by the
> period of samples, but I carried the behavior forward. I suspect there
> needs to be follow up work to make this better, but what is in the
> series is superior to what is currently in the tree. Follow up work
> could include finding metrics for the machine in the perf.data rather
> than using the host, allowing multiple metrics even if the metric ids
> of the events differ, fixing pre-existing `perf stat record/report`
> issues, etc.
> 
> There is a lot of stat tests that, for example, assume '-e
> instructions,cycles' will produce an IPC metric. These things needed
> tidying as now the metric must be explicitly asked for and when doing
> this ones using software events were preferred to increase
> compatibility. As the test updates were numerous they are distinct to
> the patches updating the functionality causing periods in the series
> where not all tests are passing. If this is undesirable the test fixes
> can be squashed into the functionality updates, but this will be kind
> of messy, especially as at some points in the series both the old
> metrics and the new metrics will be displayed.
> 
> v4: K/sec to M/sec on branch frequency (Namhyung), perf script -F
>     metric to-done a system-wide calculation (Namhyung) and don't
>     crash because of the CPU map index couldn't be found. Regenerate
>     commit messages but the cpu-clock was always yielding 0 on my
>     machine leading to a lot of nan metric values.

This is strange.  The cpu-clock should not be 0 as long as you ran it.
Do you think it's related to the scale unit change?  I tested v3 and
didn't see the problem.

Thanks,
Namhyung

> 
> v3: Rebase resolving merge conflicts in
>     tools/perf/pmu-events/empty-pmu-events.c by just regenerating it
>     (Dapeng Mi).
>     https://lore.kernel.org/lkml/20251111040417.270945-1-irogers@google.com/
> 
> v2: Drop merged patches, add json to document target_cpu/core_wide and
>     example to "Add care to picking the evsel for displaying a metric"
>     commit message (Namhyung).
>     https://lore.kernel.org/lkml/20251106231508.448793-1-irogers@google.com/
> 
> v1: https://lore.kernel.org/lkml/20251024175857.808401-1-irogers@google.com/
> 
> Ian Rogers (18):
>   perf metricgroup: Add care to picking the evsel for displaying a
>     metric
>   perf expr: Add #target_cpu literal
>   perf jevents: Add set of common metrics based on default ones
>   perf jevents: Add metric DefaultShowEvents
>   perf stat: Add detail -d,-dd,-ddd metrics
>   perf script: Change metric format to use json metrics
>   perf stat: Remove hard coded shadow metrics
>   perf stat: Fix default metricgroup display on hybrid
>   perf stat: Sort default events/metrics
>   perf stat: Remove "unit" workarounds for metric-only
>   perf test stat+json: Improve metric-only testing
>   perf test stat: Ignore failures in Default[234] metricgroups
>   perf test stat: Update std_output testing metric expectations
>   perf test metrics: Update all metrics for possibly failing default
>     metrics
>   perf test stat: Update shadow test to use metrics
>   perf test stat: Update test expectations and events
>   perf test stat csv: Update test expectations and events
>   perf tool_pmu: Make core_wide and target_cpu json events
> 
>  tools/perf/builtin-script.c                   | 251 ++++++++++-
>  tools/perf/builtin-stat.c                     | 154 ++-----
>  .../arch/common/common/metrics.json           | 151 +++++++
>  .../pmu-events/arch/common/common/tool.json   |  12 +
>  tools/perf/pmu-events/empty-pmu-events.c      | 229 ++++++----
>  tools/perf/pmu-events/jevents.py              |  28 +-
>  tools/perf/pmu-events/pmu-events.h            |   2 +
>  .../tests/shell/lib/perf_json_output_lint.py  |   4 +-
>  tools/perf/tests/shell/lib/stat_output.sh     |   2 +-
>  tools/perf/tests/shell/stat+csv_output.sh     |   2 +-
>  tools/perf/tests/shell/stat+json_output.sh    |   2 +-
>  tools/perf/tests/shell/stat+shadow_stat.sh    |   4 +-
>  tools/perf/tests/shell/stat+std_output.sh     |   4 +-
>  tools/perf/tests/shell/stat.sh                |   6 +-
>  .../perf/tests/shell/stat_all_metricgroups.sh |   3 +
>  tools/perf/tests/shell/stat_all_metrics.sh    |   7 +-
>  tools/perf/util/evsel.h                       |   1 +
>  tools/perf/util/expr.c                        |   8 +-
>  tools/perf/util/metricgroup.c                 |  92 +++-
>  tools/perf/util/stat-display.c                |  55 +--
>  tools/perf/util/stat-shadow.c                 | 404 +-----------------
>  tools/perf/util/stat.h                        |   2 +-
>  tools/perf/util/tool_pmu.c                    |  24 +-
>  tools/perf/util/tool_pmu.h                    |   9 +-
>  24 files changed, 769 insertions(+), 687 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.json
> 
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 
