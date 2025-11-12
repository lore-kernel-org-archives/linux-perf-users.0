Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703052BE02C;
	Wed, 12 Nov 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938214; cv=none; b=YiHhSgzEwxwvsxl1QmltnXf5nqQIb+X4z5CpAvF59f3jmCzcEgC8k3Jghfh0oZUO74vGQYjXKiqNVSEniIinV/bL6rb54D/3qWg8KGftUWhgOvoVjYNB1YHFrBxMCH9DvgzzfI+wXnYnO98WHDUm/bCiUWtJi/CH7L4TSOFVgBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938214; c=relaxed/simple;
	bh=SBmBPLPrOqVXNs7CtEqUz7f2zBWDgz14Q/e9SffTdSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dBxkXsm+xI9t5CkRoF4Sqp8iVyFroJCwv7AgPytH1FoK1xhFFR6vr0TZLTEA9wTc6Z10LHlIo4MjT69TDkY/lRG1DN+2yXy/ESvovlBB9SRDQuj0PktRO56l5Lev5CnZrYNpo5/EVMPWQZJB00uzxAMkqqDo9kbFAfmpVDFtoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PfCMpLAy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PfCMpLAy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762938212; x=1794474212;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=SBmBPLPrOqVXNs7CtEqUz7f2zBWDgz14Q/e9SffTdSo=;
  b=PfCMpLAy8irGSqfZ5L7x5lE0+RAENTXFgmZRhlLvr2f4Oc1TTSaCG9m0
   8gu7VaAMX2o7C7KGuf/LIAE688FpkBq+nxg929Vl9jJBJVGlImmvSQqII
   CTYvLhU06/XMWBeRjnwGo9hEyqsURwFwGomo+YWbIORKGWOaO0TU7PsPW
   uvps8ePM83W94Pllf+byeSrrkyi0g6XVSzx5/LpTz395lZB/WG3Pa07R4
   loM3TvpuaSaGXIvMXphtFAhjdvO0BnCXCOrLeTNQfC9CZ7I9flBrqi+i2
   qoA2NjyDj0FxufzJHpqs6Alb/v7XNsLUAluocusy7EWAmId9hUbFu9yaS
   w==;
X-CSE-ConnectionGUID: Y91viC4DQduWCVidEGb1Bg==
X-CSE-MsgGUID: gIde7OcBQTKcqB3voqZwhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="75302608"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="75302608"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 01:03:31 -0800
X-CSE-ConnectionGUID: SYCH4bBLSL+2T+NmN9ACxA==
X-CSE-MsgGUID: lxwRr1OuRpqznOQwoPY4Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="212565458"
Received: from unknown (HELO [10.238.3.175]) ([10.238.3.175])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 01:03:26 -0800
Message-ID: <52a04db2-ee35-4870-9fcc-1b8824d2f2f9@linux.intel.com>
Date: Wed, 12 Nov 2025 17:03:24 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/18]
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
References: <20251111212206.631711-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I tested this patch series on Sapphire Rapids and Arrow Lake, the topdown
metrics output looks much prettier and reader-friendly (especially on
hybrid platforms) than before. Thanks.

Sapphire Rapids:

1. sudo ./perf stat -a
^C
 Performance counter stats for 'system wide':

             1,742      context-switches                 #      4.1 cs/sec 
cs_per_second
        420,720.12 msec cpu-clock                        #    224.5 CPUs 
CPUs_utilized
               225      cpu-migrations                   #      0.5
migrations/sec  migrations_per_second
             1,463      page-faults                      #      3.5
faults/sec  page_faults_per_second
           842,434      branch-misses                    #      3.0 % 
branch_miss_rate
        28,215,728      branches                         #      0.1 M/sec 
branch_frequency
       373,303,824      cpu-cycles                       #      0.0 GHz 
cycles_frequency
       135,738,837      instructions                     #      0.4
instructions  insn_per_cycle
                        TopdownL1                 #      4.4 % 
tma_bad_speculation
                                                  #     29.0 % 
tma_frontend_bound
                                                  #     58.3 % 
tma_backend_bound
                                                  #      8.3 %  tma_retiring
                        TopdownL2                 #     25.9 %  tma_core_bound
                                                  #     32.4 % 
tma_memory_bound
                                                  #      2.3 % 
tma_heavy_operations
                                                  #      6.0 % 
tma_light_operations
                                                  #      4.1 % 
tma_branch_mispredicts
                                                  #      0.3 % 
tma_machine_clears
                                                  #      4.4 % 
tma_fetch_bandwidth
                                                  #     24.6 % 
tma_fetch_latency

       1.873921629 seconds time elapsed

2. sudo ./perf stat -- true

 Performance counter stats for 'true':

                 0      context-switches                 #      0.0 cs/sec 
cs_per_second
                 0      cpu-migrations                   #      0.0
migrations/sec  migrations_per_second
                53      page-faults                      # 178267.5
faults/sec  page_faults_per_second
              0.30 msec task-clock                       #      0.4 CPUs 
CPUs_utilized
             4,977      branch-misses                    #      4.6 % 
branch_miss_rate
           109,186      branches                         #    367.3 M/sec 
branch_frequency
           832,970      cpu-cycles                       #      2.8 GHz 
cycles_frequency
           561,263      instructions                     #      0.7
instructions  insn_per_cycle
                        TopdownL1                 #     11.1 % 
tma_bad_speculation
                                                  #     40.5 % 
tma_frontend_bound
                                                  #     35.2 % 
tma_backend_bound
                                                  #     13.3 %  tma_retiring
                        TopdownL2                 #     13.7 %  tma_core_bound
                                                  #     21.5 % 
tma_memory_bound
                                                  #      3.1 % 
tma_heavy_operations
                                                  #     10.2 % 
tma_light_operations
                                                  #     10.5 % 
tma_branch_mispredicts
                                                  #      0.6 % 
tma_machine_clears
                                                  #     10.5 % 
tma_fetch_bandwidth
                                                  #     29.9 % 
tma_fetch_latency

       0.000752150 seconds time elapsed

3. sudo ./perf stat -M TopdownL1 -- true

 Performance counter stats for 'true':

         5,352,744      TOPDOWN.SLOTS                    #     11.1 % 
tma_bad_speculation
                                                  #     41.5 % 
tma_frontend_bound
           650,725      topdown-retiring                 #     35.4 % 
tma_backend_bound
         2,246,053      topdown-fe-bound
         1,910,194      topdown-be-bound
           146,938      topdown-heavy-ops                #     12.1 % 
tma_retiring
           587,752      topdown-bad-spec
             8,977      INT_MISC.UOP_DROPPING

       0.000655604 seconds time elapsed

4. sudo ./perf stat -M TopdownL2 -- true

 Performance counter stats for 'true':

         5,935,368      TOPDOWN.SLOTS
           651,726      topdown-retiring
         2,257,767      topdown-fe-bound
         1,699,144      topdown-mem-bound                #     12.5 % 
tma_core_bound
                                                  #     28.6 % 
tma_memory_bound
         2,443,975      topdown-be-bound
           162,931      topdown-heavy-ops                #      2.7 % 
tma_heavy_operations
                                                  #      8.2 % 
tma_light_operations
           558,622      topdown-br-mispredict            #      9.4 % 
tma_branch_mispredicts
                                                  #      0.5 % 
tma_machine_clears
         1,722,420      topdown-fetch-lat                #      9.0 % 
tma_fetch_bandwidth
                                                  #     28.9 % 
tma_fetch_latency
           581,898      topdown-bad-spec
             9,177      INT_MISC.UOP_DROPPING

       0.000762976 seconds time elapsed

Arrow Lake:

1. sudo ./perf stat -a
^C
 Performance counter stats for 'system wide':

               355      context-switches                 #      8.7 cs/sec 
cs_per_second
         40,877.75 msec cpu-clock                        #     24.0 CPUs 
CPUs_utilized
                37      cpu-migrations                   #      0.9
migrations/sec  migrations_per_second
               749      page-faults                      #     18.3
faults/sec  page_faults_per_second
            80,736      cpu_core/branch-misses/          #      4.5 % 
branch_miss_rate
         1,817,804      cpu_core/branches/               #      0.0 M/sec 
branch_frequency
        22,099,084      cpu_core/cpu-cycles/             #      0.0 GHz 
cycles_frequency
         8,993,043      cpu_core/instructions/           #      0.4
instructions  insn_per_cycle
         7,484,501      cpu_atom/branch-misses/          #      9.0 % 
branch_miss_rate         (72.70%)
        80,826,849      cpu_atom/branches/               #      2.0 M/sec 
branch_frequency     (72.79%)
     1,071,170,614      cpu_atom/cpu-cycles/             #      0.0 GHz 
cycles_frequency       (72.78%)
       429,581,963      cpu_atom/instructions/           #      0.4
instructions  insn_per_cycle  (72.68%)
             TopdownL1 (cpu_core)                 #     62.1 % 
tma_backend_bound
                                                  #      4.6 % 
tma_bad_speculation
                                                  #     27.5 % 
tma_frontend_bound
                                                  #      5.9 %  tma_retiring
             TopdownL1 (cpu_atom)                 #     13.5 % 
tma_bad_speculation      (72.85%)
                                                  #     29.4 % 
tma_backend_bound        (72.87%)
                                                  #      0.0 % 
tma_frontend_bound       (81.91%)
                                                  #      0.0 % 
tma_retiring             (81.76%)

       1.703000770 seconds time elapsed

2. sudo ./perf stat -- true

 Performance counter stats for 'true':

                 0      context-switches                 #      0.0 cs/sec 
cs_per_second
                 0      cpu-migrations                   #      0.0
migrations/sec  migrations_per_second
                52      page-faults                      # 123119.2
faults/sec  page_faults_per_second
              0.42 msec task-clock                       #      0.3 CPUs 
CPUs_utilized
             8,317      cpu_atom/branch-misses/          #      1.6 % 
branch_miss_rate         (51.13%)
           621,409      cpu_atom/branches/               #   1471.3 M/sec 
branch_frequency
         1,670,355      cpu_atom/cpu-cycles/             #      4.0 GHz 
cycles_frequency
         3,412,023      cpu_atom/instructions/           #      2.0
instructions  insn_per_cycle
             TopdownL1 (cpu_atom)                 #     12.9 % 
tma_bad_speculation
                                                  #     22.1 % 
tma_backend_bound        (48.87%)
                                                  #      0.0 % 
tma_frontend_bound       (48.87%)

       0.001387192 seconds time elapsed

3. sudo ./perf stat -M TopdownL1
^C
 Performance counter stats for 'system wide':

        70,711,798      cpu_atom/TOPDOWN_BE_BOUND.ALL_P/ #     32.5 % 
tma_backend_bound
        34,170,064      cpu_core/slots/
         2,838,696      cpu_core/topdown-retiring/       #     31.9 % 
tma_backend_bound
                                                  #      7.6 % 
tma_bad_speculation
                                                  #     52.2 % 
tma_frontend_bound
         2,596,813      cpu_core/topdown-bad-spec/
           389,708      cpu_core/topdown-heavy-ops/      #      8.3 % 
tma_retiring
        17,836,476      cpu_core/topdown-fe-bound/
        10,892,767      cpu_core/topdown-be-bound/
                 0      cpu_atom/TOPDOWN_RETIRING.ALL/   #      0.0 % 
tma_retiring
        27,212,830      cpu_atom/CPU_CLK_UNHALTED.CORE/
        14,606,510      cpu_atom/TOPDOWN_BAD_SPECULATION.ALL_P/ #      6.7
%  tma_bad_speculation
                 0      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #      0.0 % 
tma_frontend_bound

       0.933603501 seconds time elapsed

4. sudo ./perf stat -M TopdownL2
^C
 Performance counter stats for 'system wide':

         3,185,474      cpu_atom/TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS/ # 
    0.3 %  tma_machine_clears
       362,392,575      cpu_atom/TOPDOWN_BE_BOUND.ALL_P/ #     11.2 % 
tma_core_bound
                                                  #     21.1 % 
tma_resource_bound
       134,220,848      cpu_core/slots/
         7,973,945      cpu_core/topdown-retiring/
        21,283,136      cpu_core/topdown-mem-bound/      #     20.3 % 
tma_core_bound
                                                  #     15.9 % 
tma_memory_bound
         8,723,033      cpu_core/topdown-bad-spec/
         1,312,216      cpu_core/topdown-heavy-ops/      #      1.0 % 
tma_heavy_operations
                                                  #      5.0 % 
tma_light_operations
        58,866,799      cpu_core/topdown-fetch-lat/      #      7.5 % 
tma_fetch_bandwidth
                                                  #     43.9 % 
tma_fetch_latency
         8,588,952      cpu_core/topdown-br-mispredict/  #      6.4 % 
tma_branch_mispredicts
                                                  #      0.1 % 
tma_machine_clears
        68,870,574      cpu_core/topdown-fe-bound/
        48,573,009      cpu_core/topdown-be-bound/
       125,913,035      cpu_atom/TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS/
       106,491,449      cpu_atom/TOPDOWN_BAD_SPECULATION.MISPREDICT/ #     
9.5 %  tma_branch_mispredicts
       199,780,747      cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_LATENCY/ #   
 17.8 %  tma_ifetch_latency
       140,205,932      cpu_atom/CPU_CLK_UNHALTED.CORE/
       109,670,746      cpu_atom/TOPDOWN_BAD_SPECULATION.ALL_P/
                 0      cpu_atom/TOPDOWN_FE_BOUND.ALL/
       176,695,510      cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH/ #   
 15.8 %  tma_ifetch_bandwidth

       1.463942844 seconds time elapsed


On 11/12/2025 5:21 AM, Ian Rogers wrote:
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
