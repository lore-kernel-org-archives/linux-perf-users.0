Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5425228D;
	Thu,  6 Nov 2025 06:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762410156; cv=none; b=TUEUdMpLi9sc2VJhDCkQfAnS/J7/eLJk1qpaP0eF0n88Mw1nvKvY21V5zqALUm5twYCuBTBgYz4UO7S5BM9WN4j9VyiOovDGgbFJfApT3VgwjhRSaU8PapKouUV/WkrQT8QmnUhwmbpbExku7AakIVMt753vyD5iYZLBItM9ENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762410156; c=relaxed/simple;
	bh=La3rE3GWGm2LjHT1GnPHQF4BwIAf4w6c4woYhVapbAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxdsI7VcVTZfuyhFCaH7Gdt1s565JSMsRydIJn2qKEebqCRcVmIZjBbGp0FQs0W1pFSIdbME4eJZd0UFwo5x3bSSZoTFDBN9VLoTYF88aWbCTHldmTYJmNqwbaGKRbPsg8z8Zj8IaRNAXxt297YewdFOvJdWeVrgkIQiDlbOjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO6Qw65x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO6Qw65x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86ABCC4CEF7;
	Thu,  6 Nov 2025 06:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762410156;
	bh=La3rE3GWGm2LjHT1GnPHQF4BwIAf4w6c4woYhVapbAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fO6Qw65xz0wrxc4gj+5Vq15uaz6DCX41MKpAR88jm/KzDyhpJ/oPo7h6QjThU3fyG
	 QjWpG7RwL1l7purjgr1rWmzcunQ5RW4iCzFamIwXyBepsG2ihqMnqpyM57y5BFe6xk
	 m/Hv7EAPhzJbtQwUUevIzfV8SEAiubS3Mn8DTwuVWTZyLcdVRWvAPFrhEU1+MJ/D7J
	 J67GLLU0ttPZ5Pr5vjyFC7Pz7UN1l/+WC1N/IKZok1tk/U8O7RZtWkucR7x3GAxZeS
	 4NxalVfn9px14RHTAdXFS399WrG3VEyHoLkPjCcAhcDKYyqEmP9xtCWFqo0GO/8kiA
	 NddiKjgdynuzg==
Date: Wed, 5 Nov 2025 22:22:34 -0800
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
Subject: Re: [PATCH v1 08/22] perf jevents: Add set of common metrics based
 on default ones
Message-ID: <aQw-qsVuWf8IHUrL@google.com>
References: <20251024175857.808401-1-irogers@google.com>
 <20251024175857.808401-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024175857.808401-9-irogers@google.com>

On Fri, Oct 24, 2025 at 10:58:43AM -0700, Ian Rogers wrote:
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

Wouldn't it be "1000M/sec" ?


> +        "MetricConstraint": "NO_GROUP_EVENTS"
> +    },
> +    {
> +        "BriefDescription": "Branch miss rate",
> +        "MetricExpr": "branch\\-misses / branches",
> +        "MetricGroup": "Default",
> +        "MetricName": "branch_miss_rate",
> +        "MetricThreshold": "branch_miss_rate > 0.05",

Is MetricThreshold evaluated before scaling?

Thanks,
Namhyung


> +        "ScaleUnit": "100%"
> +    }
> +]
