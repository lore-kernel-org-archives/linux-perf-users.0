Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD5257845;
	Tue, 11 Nov 2025 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843054; cv=none; b=aKhPLmLbVTiDRVeZsatCXqPcOlnKJfkh3A4KaoPfkjFL4BhGgxxUhYdDTQ8SOvoUG/YY3Oevi/JWIRPonhh+rYIukH9pAdzLNtcVxsNn3dPa0S1dWW4usDHOeTZ126W5ZUKUBgtMFkrS1p07uHNyxu6c0fPnfjPb3xXYEuGNsIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843054; c=relaxed/simple;
	bh=6MViIM9/7t1IqgruydtUqi5FbfXktT9o5O9C7n/JeVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5YdyAuJdHcE6NoVgSWVKD1tcr4j1DYaxHNrjOzcdQ/m/Aa3YJbX9FWSEMmj3otZ9eUg+AGDVTeYYWbdjPHAMor/SFfyV8OFFxTWOhQ+RO1Pe1zi7ImyztK/YBOtQftkiGxkrF0ChLFu3dDZl029ui9aH2pEy5VC+62c4nTBbp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFQSHMfb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFQSHMfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D15C19422;
	Tue, 11 Nov 2025 06:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762843054;
	bh=6MViIM9/7t1IqgruydtUqi5FbfXktT9o5O9C7n/JeVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFQSHMfbEVrGGligCrBW9p29+lYQKzUjT1Gkryo5CQyfug6I+rNbB26vov2hYfePJ
	 8F4zz1xlIXxq82EVBsTzHqO0osGrVeK55GHlhCdJF8qtf0wyS+QJsomL8pUuC+XHJ+
	 c7cCFdvn/TWoBtJmvPwjaE58WC3/TLRD0c3ELUeoWHyvb68ailCtwWhJUA4SpKKXsc
	 NcKdw9UHK/XK9m+bxK90sc7LnJucBO2tihRCJLYMOdKMuIV9OSsO+fTx8PfzPQ2ucp
	 EKogFWz/+hpeRKup78gQNCe7Wc4Vt0kgunUMDw8dg3RRVleXmbmQ5hTuQdbg/n2FLS
	 XQpMjiNEZqIgg==
Date: Mon, 10 Nov 2025 22:37:31 -0800
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
Subject: Re: [PATCH v3 03/18] perf jevents: Add set of common metrics based
 on default ones
Message-ID: <aRLZq4Po-1AJ8br4@google.com>
References: <20251111040417.270945-1-irogers@google.com>
 <20251111040417.270945-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111040417.270945-4-irogers@google.com>

On Mon, Nov 10, 2025 at 08:04:02PM -0800, Ian Rogers wrote:
> Add support to getting a common set of metrics from a default
> table. It simplifies the generation to add json metrics at the same
> time. The metrics added are CPUs_utilized, cs_per_second,
> migrations_per_second, page_faults_per_second, insn_per_cycle,
> stalled_cycles_per_instruction, frontend_cycles_idle,
> backend_cycles_idle, cycles_frequency, branch_frequency and
> branch_miss_rate based on the shadow metric definitions.
> 
> Following this change the default perf stat output on an alderlake looks like:
> ```
> $ perf stat -a -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>     28,165,735,434      cpu-clock                        #   27.973 CPUs utilized
>             23,220      context-switches                 #  824.406 /sec
>                833      cpu-migrations                   #   29.575 /sec
>             35,293      page-faults                      #    1.253 K/sec
>        997,341,554      cpu_atom/instructions/           #    0.84  insn per cycle              (35.63%)
>     11,197,053,736      cpu_core/instructions/           #    1.97  insn per cycle              (58.21%)
>      1,184,871,493      cpu_atom/cycles/                 #    0.042 GHz                         (35.64%)
>      5,676,692,769      cpu_core/cycles/                 #    0.202 GHz                         (58.22%)
>        150,525,309      cpu_atom/branches/               #    5.344 M/sec                       (42.80%)
>      2,277,232,030      cpu_core/branches/               #   80.851 M/sec                       (58.21%)
>          5,248,575      cpu_atom/branch-misses/          #    3.49% of all branches             (42.82%)
>         28,829,930      cpu_core/branch-misses/          #    1.27% of all branches             (58.22%)
>                        (software)                 #    824.4 cs/sec  cs_per_second
>              TopdownL1 (cpu_core)                 #     12.6 %  tma_bad_speculation
>                                                   #     28.8 %  tma_frontend_bound       (66.57%)
>              TopdownL1 (cpu_core)                 #     25.8 %  tma_backend_bound
>                                                   #     32.8 %  tma_retiring             (66.57%)
>                        (software)                 #   1253.1 faults/sec  page_faults_per_second
>                                                   #      0.0 GHz  cycles_frequency       (42.80%)
>                                                   #      0.2 GHz  cycles_frequency       (74.92%)
>              TopdownL1 (cpu_atom)                 #     22.3 %  tma_bad_speculation
>                                                   #     17.2 %  tma_retiring             (49.95%)
>              TopdownL1 (cpu_atom)                 #     30.6 %  tma_backend_bound
>                                                   #     29.8 %  tma_frontend_bound       (49.94%)
>                        (cpu_atom)                 #      6.9 K/sec  branch_frequency     (42.89%)
>                                                   #     80.5 K/sec  branch_frequency     (74.93%)
>                                                   #     29.6 migrations/sec  migrations_per_second
>                                                   #     28.0 CPUs  CPUs_utilized
>                        (cpu_atom)                 #      0.8 instructions  insn_per_cycle  (42.91%)
>                                                   #      2.0 instructions  insn_per_cycle  (75.14%)
>                        (cpu_atom)                 #      3.8 %  branch_miss_rate         (35.75%)
>                                                   #      1.2 %  branch_miss_rate         (66.86%)
> 
>        1.007063529 seconds time elapsed
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../arch/common/common/metrics.json           |  86 +++++++++++++
>  tools/perf/pmu-events/empty-pmu-events.c      | 115 +++++++++++++-----
>  tools/perf/pmu-events/jevents.py              |  21 +++-
>  tools/perf/pmu-events/pmu-events.h            |   1 +
>  tools/perf/util/metricgroup.c                 |  31 +++--
>  5 files changed, 212 insertions(+), 42 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.json
> 
> diff --git a/tools/perf/pmu-events/arch/common/common/metrics.json b/tools/perf/pmu-events/arch/common/common/metrics.json
> new file mode 100644
> index 000000000000..d1e37db18dc6
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/common/common/metrics.json
> @@ -0,0 +1,86 @@
> +[
> +    {
> +        "BriefDescription": "Average CPU utilization",
> +        "MetricExpr": "(software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@) / (duration_time * 1e9)",
> +        "MetricGroup": "Default",
> +        "MetricName": "CPUs_utilized",
> +        "ScaleUnit": "1CPUs",
> +        "MetricConstraint": "NO_GROUP_EVENTS"
> +    },
> +    {
> +        "BriefDescription": "Context switches per CPU second",
> +        "MetricExpr": "(software@context\\-switches\\,name\\=context\\-switches@ * 1e9) / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)",
> +        "MetricGroup": "Default",
> +        "MetricName": "cs_per_second",
> +        "ScaleUnit": "1cs/sec",
> +        "MetricConstraint": "NO_GROUP_EVENTS"
> +    },
> +    {
> +        "BriefDescription": "Process migrations to a new CPU per CPU second",
> +        "MetricExpr": "(software@cpu\\-migrations\\,name\\=cpu\\-migrations@ * 1e9) / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)",
> +        "MetricGroup": "Default",
> +        "MetricName": "migrations_per_second",
> +        "ScaleUnit": "1migrations/sec",
> +        "MetricConstraint": "NO_GROUP_EVENTS"
> +    },
> +    {
> +        "BriefDescription": "Page faults per CPU second",
> +        "MetricExpr": "(software@page\\-faults\\,name\\=page\\-faults@ * 1e9) / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)",
> +        "MetricGroup": "Default",
> +        "MetricName": "page_faults_per_second",
> +        "ScaleUnit": "1faults/sec",
> +        "MetricConstraint": "NO_GROUP_EVENTS"
> +    },
> +    {
> +        "BriefDescription": "Instructions Per Cycle",
> +        "MetricExpr": "instructions / cpu\\-cycles",
> +        "MetricGroup": "Default",
> +        "MetricName": "insn_per_cycle",
> +        "MetricThreshold": "insn_per_cycle < 1",
> +        "ScaleUnit": "1instructions"
> +    },
> +    {
> +        "BriefDescription": "Max front or backend stalls per instruction",
> +        "MetricExpr": "max(stalled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions",
> +        "MetricGroup": "Default",
> +        "MetricName": "stalled_cycles_per_instruction"
> +    },
> +    {
> +        "BriefDescription": "Frontend stalls per cycle",
> +        "MetricExpr": "stalled\\-cycles\\-frontend / cpu\\-cycles",
> +        "MetricGroup": "Default",
> +        "MetricName": "frontend_cycles_idle",
> +        "MetricThreshold": "frontend_cycles_idle > 0.1"
> +    },
> +    {
> +        "BriefDescription": "Backend stalls per cycle",
> +        "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
> +        "MetricGroup": "Default",
> +        "MetricName": "backend_cycles_idle",
> +        "MetricThreshold": "backend_cycles_idle > 0.2"
> +    },
> +    {
> +        "BriefDescription": "Cycles per CPU second",
> +        "MetricExpr": "cpu\\-cycles / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)",
> +        "MetricGroup": "Default",
> +        "MetricName": "cycles_frequency",
> +        "ScaleUnit": "1GHz",
> +        "MetricConstraint": "NO_GROUP_EVENTS"
> +    },
> +    {
> +        "BriefDescription": "Branches per CPU second",
> +        "MetricExpr": "branches / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)",
> +        "MetricGroup": "Default",
> +        "MetricName": "branch_frequency",
> +        "ScaleUnit": "1000K/sec",

We talked it should be 1000M/sec, right?

Thanks,
Namhyung


> +        "MetricConstraint": "NO_GROUP_EVENTS"
> +    },
> +    {
> +        "BriefDescription": "Branch miss rate",
> +        "MetricExpr": "branch\\-misses / branches",
> +        "MetricGroup": "Default",
> +        "MetricName": "branch_miss_rate",
> +        "MetricThreshold": "branch_miss_rate > 0.05",
> +        "ScaleUnit": "100%"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
> index 2fdf4fbf36e2..d78c1857ac4b 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
> @@ -1303,21 +1303,32 @@ static const char *const big_c_string =
>  /* offset=127519 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=0x2c\0000x01\00000\000\000\000\000\000"
>  /* offset=127596 */ "uncore_sys_cmn_pmu\000"
>  /* offset=127615 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in first lookup result (high priority)\000eventid=1,type=5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
> -/* offset=127758 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000"
> -/* offset=127780 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\000\000\000\000\00000"
> -/* offset=127843 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
> -/* offset=128009 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000"
> -/* offset=128073 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000"
> -/* offset=128140 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000"
> -/* offset=128211 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
> -/* offset=128305 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\000\000\000\00000"
> -/* offset=128439 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\000\000\000\000\00000"
> -/* offset=128503 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> -/* offset=128571 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> -/* offset=128641 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00000"
> -/* offset=128663 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00000"
> -/* offset=128685 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
> -/* offset=128705 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\000\000\000\000\000\000\00000"
> +/* offset=127758 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\00001"
> +/* offset=127943 */ "cs_per_second\000Default\000software@context\\-switches\\,name\\=context\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\00001"
> +/* offset=128175 */ "migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\000\00001"
> +/* offset=128434 */ "page_faults_per_second\000Default\000software@page\\-faults\\,name\\=page\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\00001"
> +/* offset=128664 */ "insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\00000"
> +/* offset=128776 */ "stalled_cycles_per_instruction\000Default\000max(stalled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max front or backend stalls per instruction\000\000\000\000\000\00000"
> +/* offset=128939 */ "frontend_cycles_idle\000Default\000stalled\\-cycles\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\00000"
> +/* offset=129068 */ "backend_cycles_idle\000Default\000stalled\\-cycles\\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\000\000\000\000\000\00000"
> +/* offset=129193 */ "cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\00001"
> +/* offset=129368 */ "branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Branches per CPU second\000\0001000K/sec\000\000\000\00001"
> +/* offset=129547 */ "branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000"
> +/* offset=129650 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000"
> +/* offset=129672 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\000\000\000\000\00000"
> +/* offset=129735 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
> +/* offset=129901 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000"
> +/* offset=129965 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000"
> +/* offset=130032 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000"
> +/* offset=130103 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
> +/* offset=130197 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\000\000\000\00000"
> +/* offset=130331 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\000\000\000\000\00000"
> +/* offset=130395 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> +/* offset=130463 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> +/* offset=130533 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00000"
> +/* offset=130555 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00000"
> +/* offset=130577 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
> +/* offset=130597 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\000\000\000\000\000\000\00000"
>  ;
>  
>  static const struct compact_pmu_event pmu_events__common_default_core[] = {
> @@ -2603,6 +2614,29 @@ static const struct pmu_table_entry pmu_events__common[] = {
>  },
>  };
>  
> +static const struct compact_pmu_event pmu_metrics__common_default_core[] = {
> +{ 127758 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\00001 */
> +{ 129068 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\000\000\000\000\000\00000 */
> +{ 129368 }, /* branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Branches per CPU second\000\0001000K/sec\000\000\000\00001 */
> +{ 129547 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000 */
> +{ 127943 }, /* cs_per_second\000Default\000software@context\\-switches\\,name\\=context\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\00001 */
> +{ 129193 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\00001 */
> +{ 128939 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\00000 */
> +{ 128664 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\00000 */
> +{ 128175 }, /* migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\000\00001 */
> +{ 128434 }, /* page_faults_per_second\000Default\000software@page\\-faults\\,name\\=page\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\00001 */
> +{ 128776 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max front or backend stalls per instruction\000\000\000\000\000\00000 */
> +
> +};
> +
> +static const struct pmu_table_entry pmu_metrics__common[] = {
> +{
> +     .entries = pmu_metrics__common_default_core,
> +     .num_entries = ARRAY_SIZE(pmu_metrics__common_default_core),
> +     .pmu_name = { 0 /* default_core\000 */ },
> +},
> +};
> +
>  static const struct compact_pmu_event pmu_events__test_soc_cpu_default_core[] = {
>  { 126205 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=0x8a\000\00000\000\000\000\000\000 */
>  { 126267 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=0x8b\000\00000\000\000\000\000\000 */
> @@ -2664,21 +2698,21 @@ static const struct pmu_table_entry pmu_events__test_soc_cpu[] = {
>  };
>  
>  static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_core[] = {
> -{ 127758 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
> -{ 128439 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\000\000\000\000\00000 */
> -{ 128211 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
> -{ 128305 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\000\000\000\00000 */
> -{ 128503 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\000\000\000\000\000\00000 */
> -{ 128571 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000 */
> -{ 127843 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
> -{ 127780 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\000\000\000\000\00000 */
> -{ 128705 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\000\000\000\000\000\000\00000 */
> -{ 128641 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
> -{ 128663 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
> -{ 128685 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> -{ 128140 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000 */
> -{ 128009 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
> -{ 128073 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
> +{ 129650 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
> +{ 130331 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\000\000\000\000\00000 */
> +{ 130103 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
> +{ 130197 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\000\000\000\00000 */
> +{ 130395 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\000\000\000\000\000\00000 */
> +{ 130463 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000 */
> +{ 129735 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
> +{ 129672 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\000\000\000\000\00000 */
> +{ 130597 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\000\000\000\000\000\000\00000 */
> +{ 130533 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
> +{ 130555 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
> +{ 130577 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> +{ 130032 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000 */
> +{ 129901 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
> +{ 129965 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
>  
>  };
>  
> @@ -2759,7 +2793,10 @@ static const struct pmu_events_map pmu_events_map[] = {
>  		.pmus = pmu_events__common,
>  		.num_pmus = ARRAY_SIZE(pmu_events__common),
>  	},
> -	.metric_table = {},
> +	.metric_table = {
> +		.pmus = pmu_metrics__common,
> +		.num_pmus = ARRAY_SIZE(pmu_metrics__common),
> +	},
>  },
>  {
>  	.arch = "testarch",
> @@ -3208,6 +3245,22 @@ const struct pmu_metrics_table *pmu_metrics_table__find(void)
>          return map ? &map->metric_table : NULL;
>  }
>  
> +const struct pmu_metrics_table *pmu_metrics_table__default(void)
> +{
> +        int i = 0;
> +
> +        for (;;) {
> +                const struct pmu_events_map *map = &pmu_events_map[i++];
> +
> +                if (!map->arch)
> +                        break;
> +
> +                if (!strcmp(map->cpuid, "common"))
> +                        return &map->metric_table;
> +        }
> +        return NULL;
> +}
> +
>  const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
>  {
>          for (const struct pmu_events_map *tables = &pmu_events_map[0];
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 786a7049363f..5d3f4b44cfb7 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -755,7 +755,10 @@ static const struct pmu_events_map pmu_events_map[] = {
>  \t\t.pmus = pmu_events__common,
>  \t\t.num_pmus = ARRAY_SIZE(pmu_events__common),
>  \t},
> -\t.metric_table = {},
> +\t.metric_table = {
> +\t\t.pmus = pmu_metrics__common,
> +\t\t.num_pmus = ARRAY_SIZE(pmu_metrics__common),
> +\t},
>  },
>  """)
>      else:
> @@ -1237,6 +1240,22 @@ const struct pmu_metrics_table *pmu_metrics_table__find(void)
>          return map ? &map->metric_table : NULL;
>  }
>  
> +const struct pmu_metrics_table *pmu_metrics_table__default(void)
> +{
> +        int i = 0;
> +
> +        for (;;) {
> +                const struct pmu_events_map *map = &pmu_events_map[i++];
> +
> +                if (!map->arch)
> +                        break;
> +
> +                if (!strcmp(map->cpuid, "common"))
> +                        return &map->metric_table;
> +        }
> +        return NULL;
> +}
> +
>  const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
>  {
>          for (const struct pmu_events_map *tables = &pmu_events_map[0];
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index e0535380c0b2..559265a903c8 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -127,6 +127,7 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
>  const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu);
>  const struct pmu_events_table *perf_pmu__default_core_events_table(void);
>  const struct pmu_metrics_table *pmu_metrics_table__find(void);
> +const struct pmu_metrics_table *pmu_metrics_table__default(void);
>  const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid);
>  const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid);
>  int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 76092ee26761..e67e04ce01c9 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -424,10 +424,18 @@ int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metr
>  		.fn = fn,
>  		.data = data,
>  	};
> +	const struct pmu_metrics_table *tables[2] = {
> +		table,
> +		pmu_metrics_table__default(),
> +	};
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(tables); i++) {
> +		int ret;
>  
> -	if (table) {
> -		int ret = pmu_metrics_table__for_each_metric(table, fn, data);
> +		if (!tables[i])
> +			continue;
>  
> +		ret = pmu_metrics_table__for_each_metric(tables[i], fn, data);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1581,19 +1589,22 @@ static int metricgroup__has_metric_or_groups_callback(const struct pmu_metric *p
>  
>  bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_groups)
>  {
> -	const struct pmu_metrics_table *table = pmu_metrics_table__find();
> +	const struct pmu_metrics_table *tables[2] = {
> +		pmu_metrics_table__find(),
> +		pmu_metrics_table__default(),
> +	};
>  	struct metricgroup__has_metric_data data = {
>  		.pmu = pmu,
>  		.metric_or_groups = metric_or_groups,
>  	};
>  
> -	if (!table)
> -		return false;
> -
> -	return pmu_metrics_table__for_each_metric(table,
> -						  metricgroup__has_metric_or_groups_callback,
> -						  &data)
> -		? true : false;
> +	for (size_t i = 0; i < ARRAY_SIZE(tables); i++) {
> +		if (pmu_metrics_table__for_each_metric(tables[i],
> +							metricgroup__has_metric_or_groups_callback,
> +							&data))
> +			return true;
> +	}
> +	return false;
>  }
>  
>  static int metricgroup__topdown_max_level_callback(const struct pmu_metric *pm,
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 
