Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3F36124;
	Tue,  4 Nov 2025 04:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762231642; cv=none; b=pKRLAVMj/BLn0TmkR3KzWbSeybcICVGz/mpN3U09wYeBI1SbsIMv9QpaR/kOC+5/7PFnTyOt7W7Tz1pZWyfcvA0GPxAbheYiGOtdlYGaz1P0sGIExddnaAswCpEMbB1BMheGH9S2rM+d+XwLT1SqQYvijHPqc2A5b8qas6GmJXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762231642; c=relaxed/simple;
	bh=OUqBNqT56GLjUMxvk50Lwb/eboCNMSG2WZnI5H1Vdx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JijhVsvwWDLhTcYUOrUDMPsxxk0zbnDq6EV8MpogkqOza6G61GxJw02DMpTCR//iBB6Vya1YDMvve4n51A6Ip4xnB0KcZbqx7bETWh6MGDee6HNEw00YtySPw4FFRR7hxy+4LRH9POE3v3wonjxpBI4IAmsyVWbbr+Fh+rkMTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVvePz+p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVvePz+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491D2C4CEF7;
	Tue,  4 Nov 2025 04:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762231642;
	bh=OUqBNqT56GLjUMxvk50Lwb/eboCNMSG2WZnI5H1Vdx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVvePz+pNbfWL3S0fhbS4Ys6Dyy6Vwswd4uGmJf8YGEVBOCL27O7j+5DePcysM2fF
	 ZiltLQo+4V0EXDlV6l25KQvu88FOVJ9AeFucC0yImzoBmmEXl7fGONBtoS2Mn1XnTL
	 a8jkj3oe4bUTRBzUqwWC+Ks+GdGM2dunlAwjGSirO2eWuO97KsYH4lRpnAGkKTq2G/
	 lbw32ZAiT2PagiABdWjTqjJV0PySVKVezQjotyEhlpBU9A+x7Mi4F/s4aG7UI0vWfK
	 3N55Dpz8AyupODRKMyywZTeEeSWhBprrOR6MdFf8T01w6Ozl8xPBQC7r+T5rMUyzGf
	 2Ct5qvmX+RXyg==
Date: Mon, 3 Nov 2025 20:47:19 -0800
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
Subject: Re: [PATCH v1 00/22] Switch the default perf stat metrics to json
Message-ID: <aQmFV7fqURMXQNHC@google.com>
References: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024175857.808401-1-irogers@google.com>

Hi Ian,

On Fri, Oct 24, 2025 at 10:58:35AM -0700, Ian Rogers wrote:
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
>        429,978,120      branches                         #     26.8 K/sec  branch_frequency     (88.85%)
>      1,626,915,897      cpu-cycles                       #      0.1 GHz  cycles_frequency       (88.84%)
>      2,556,805,534      instructions                     #      1.5 instructions  insn_per_cycle  (88.86%)
>                         TopdownL1                 #     20.1 %  tma_backend_bound      
>                                                   #     40.5 %  tma_bad_speculation      (88.90%)
>                                                   #     17.2 %  tma_frontend_bound       (78.05%)
>                                                   #     22.2 %  tma_retiring             (88.89%)
> 
>        1.002994394 seconds time elapsed
> ```

While this looks nicer, I worry about the changes in the output.  And I'm
curious why only the "After" output shows the multiplexing percent.

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
> work for me (I was testing `perf record -e instructions,cycles` and
> then `perf script -F metric` but saw nothing but empty lines)

The documentation says:

	With the metric option perf script can compute metrics for
	sampling periods, similar to perf stat. This requires
	specifying a group with multiple events defining metrics with the :S option
	for perf record. perf will sample on the first event, and
	print computed metrics for all the events in the group. Please note
	that the metric computed is averaged over the whole sampling
	period (since the last sample), not just for the sample point.

So I guess it should have 'S' modifiers in a group.


> but anyway I decided to fix it to the best of my ability in this
> series. So the script side counters were removed and the regular ones
> associated with the evsel used. The json metrics were all searched
> looking for ones that have a subset of events matching those in the
> perf script session, and all metrics are printed. This is kind of
> weird as the counters are being set by the period of samples, but I
> carried the behavior forward. I suspect there needs to be follow up
> work to make this better, but what is in the series is superior to
> what is currently in the tree. Follow up work could include finding
> metrics for the machine in the perf.data rather than using the host,
> allowing multiple metrics even if the metric ids of the events differ,
> fixing pre-existing `perf stat record/report` issues, etc.
> 
> There is a lot of stat tests that, for example, assume '-e
> instructions,cycles' will produce an IPC metric. These things needed
> tidying as now the metric must be explicitly asked for and when doing
> this ones using software events were preferred to increase
> compatibility. As the test updates were numerous they are distinct to
> the patches updating the functionality causing periods in the series
> where not all tests are passing. If this is undesirable the test fixes
> can be squashed into the functionality updates.

Hmm.. how many of them?  I think it'd better to have the test changes at
the same time so that we can assure test success count after the change.
Can the test changes be squashed into one or two commits?

Thanks,
Namhyung

> 
> Ian Rogers (22):
>   perf evsel: Remove unused metric_events variable
>   perf metricgroup: Update comment on location of metric_event list
>   perf metricgroup: Missed free on error path
>   perf metricgroup: When copy metrics copy default information
>   perf metricgroup: Add care to picking the evsel for displaying a
>     metric
>   perf jevents: Make all tables static
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
> 
>  tools/perf/builtin-script.c                   | 238 ++++++++++-
>  tools/perf/builtin-stat.c                     | 154 ++-----
>  .../arch/common/common/metrics.json           | 151 +++++++
>  tools/perf/pmu-events/empty-pmu-events.c      | 139 ++++--
>  tools/perf/pmu-events/jevents.py              |  34 +-
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
>  tools/perf/util/evsel.c                       |   2 -
>  tools/perf/util/evsel.h                       |   2 +-
>  tools/perf/util/expr.c                        |   3 +
>  tools/perf/util/metricgroup.c                 |  95 ++++-
>  tools/perf/util/metricgroup.h                 |   2 +-
>  tools/perf/util/stat-display.c                |  55 +--
>  tools/perf/util/stat-shadow.c                 | 402 +-----------------
>  tools/perf/util/stat.h                        |   2 +-
>  23 files changed, 672 insertions(+), 643 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.json
> 
> -- 
> 2.51.1.821.gb6fe4d2222-goog
> 
