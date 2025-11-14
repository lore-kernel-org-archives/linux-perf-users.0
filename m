Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE8283CBF
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137698; cv=none; b=NHrWs3WQ57wz4fCX1ZbsofIVAjNR2dNafqIu26CPnp/HNcRM0dWdg4AFqPlqhITZFwLQ3JFDxYR7J3lnohjToA63uOojodWAFVrG8Z4qCC1jmKfVnWl5CbbyZEs/xlEikrhpP1Z2Ty+C3gMr3jeV7s5Z1LjZX1Q/KaUNpmr2u/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137698; c=relaxed/simple;
	bh=tjpcF4VRv40n82/ZQ0dn6Zvqu8XKzVxZSoG0sFYcqyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Ya0GBb+WTHgY/NiFf9yd5AQUtesqJFaHbzgnbtac1MoIegQzEEwqEpcSXD0tb3kC06Kipq+lbpn9m8H0RbRWHpYkmOT22bnbmHBk0jIctMhmunxWeHQTbgqcuO0ABxLiVhRMSeusvYt1TI0BeMfiwAC7xarkpkC0yiLJ6b6z/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D9gBQFpR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9gBQFpR"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42bb288c17bso64234f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 08:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763137693; x=1763742493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yb6EQuPjfe1dez/70bfwQ6UxwoIziPXjrLq3lesuUD4=;
        b=D9gBQFpRY5hf190NLlIrpN9lSstsPHD3vVLbNX6IbboNrTF8XFAR2+/ptVLyhxhbo+
         55we+fBba04JXgzdEvx+I5294LwNdArTbVkzyHmGwVIjBmwtG5emZbeyRCyBzdto1EPK
         ZL/okyHZ3j5OYoB+kGUqMSvbaWENXood65hP0yp/zGXCeBDnIUX1y6ctzoJWiYyHKLp7
         pZt0UD6Ycb0sfw+ZfyodVSpnl9BJSNKDi9Rol3jNyzQzmVLDwSFOjsJkYriQYMopsCum
         JraGfA0kqtPCuwV1BdnWM1PLUzOP4EiNctXPcGszIBu4lwodlfsAoPjnncL0p7qG0cjb
         FD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763137693; x=1763742493;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yb6EQuPjfe1dez/70bfwQ6UxwoIziPXjrLq3lesuUD4=;
        b=S+VECaP+xdkSl10KvQJ0MPHCSZaUfTn1aO3LqION22aQWYhpWYbsI6qpMT4/zChkZH
         Pg1BX+IqDsHgJzxLWYRlR/y9/BOHMzBlUWZUXVqkyPS92sCd2jV10VHlFN2Qu3rn0osG
         uH2pmve1DcLyvLWN7Mzr1MC7YHLbLlxQaqfJSlUb0wSVWltEvTycYk+17pHSY7/SnzpI
         vCxTyF1nVhCTw0fTUz9OZ2hSVxqezxTVyW/QI5mNq1Ac/MZcnWkbX9H4UydieXSmdmoy
         BUUtoNMOE9WGRl6r7LiL9tJhvWJMxGRZttAt6BKpC0PuZ6vyCwB1jSE0kxX2P457/ABQ
         23cw==
X-Forwarded-Encrypted: i=1; AJvYcCUWuoVcITktjIakjP6ZVIUh6K260nGP0kIjQVsVYlbJuCcvaU7DBReiVcQzETkJd8h6nKvVpPCKmii4qn8a1ETh@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZvnbwxvAt2DOf5Forw489Gj1vBd/ljK/yF2Umqln/k3n0pmH
	ztO0oWv7SCKF2EgbEAh398Z054aYqrJpmMPM+SfGH5kcGBublu5qQH32uPLl3RbZtv8=
X-Gm-Gg: ASbGncsecPVUDvF6oI9aoRlcPL8XzXUUa9N+w2UYBRcFtE8twu9IdB1RtsexlGOqjzH
	5dIu/IlY+DtB1YsTNVgGGTTUKOWjeLvBmyW9RTnWj90gCg2DoJtWIIz6gCMoQ02/gQVCGDU1EKh
	sUligU/7q35ZiI6PcNym8Wkkk3dZjkQLip3664BeYAMS+a1E/odOP21f693T/j70PAGmnfNqGNT
	aMZ2+hNiLDKIskFGFmQEw7w3XOOOc/1ejEbsvAccfVKJQD+TTKNM5VZ++GXDGJS8I2ILzOhVqAG
	kXCHf57KhmSkJvVCEaN7VNWQChTwCvLzLilAj6bqn+/C4f7mQd5vf+LEKc15+txq0exoyD85u8p
	CSw0KL6wPjWNAf7onyGqj6iCZKZPj0BOK6MKb9VFgYAwNu89Q3za+e+aMDPOpGrvLOvgQTlJTJj
	62xx3pS9x2lh9dbbtrUkwwUsBtQAqqoykIwhImig==
X-Google-Smtp-Source: AGHT+IEftDnoX0hJfrDjscEjLeai4Q4kbwjsPhryKRkDi9+1zviVdJk29AN8SrUk4gwQpXnYH4P/Tw==
X-Received: by 2002:a05:6000:26c8:b0:42b:3ee9:4773 with SMTP id ffacd0b85a97d-42b59323452mr3191779f8f.7.1763137692887;
        Fri, 14 Nov 2025 08:28:12 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b074sm10419660f8f.7.2025.11.14.08.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 08:28:12 -0800 (PST)
Message-ID: <ca0f0cd3-7335-48f9-8737-2f70a75b019a@linaro.org>
Date: Fri, 14 Nov 2025 16:28:11 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/18] perf jevents: Add set of common metrics based on
 default ones
To: Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20251111212206.631711-1-irogers@google.com>
 <20251111212206.631711-4-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Xu Yang <xu.yang_2@nxp.com>, Chun-Tse Shao <ctshao@google.com>,
 Thomas Richter <tmricht@linux.ibm.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Collin Funk <collin.funk1@gmail.com>, Thomas Falcon
 <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>,
 Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Weilin Wang <weilin.wang@intel.com>, Leo Yan <leo.yan@arm.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251111212206.631711-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/11/2025 9:21 pm, Ian Rogers wrote:
> Add support to getting a common set of metrics from a default
> table. It simplifies the generation to add json metrics at the same
> time. The metrics added are CPUs_utilized, cs_per_second,
> migrations_per_second, page_faults_per_second, insn_per_cycle,
> stalled_cycles_per_instruction, frontend_cycles_idle,
> backend_cycles_idle, cycles_frequency, branch_frequency and
> branch_miss_rate based on the shadow metric definitions.
> 
> Following this change the default perf stat output on an alderlake
> looks like:
> ```
> $ perf stat -a -- sleep 2
> 
>   Performance counter stats for 'system wide':
> 
>                0.00 msec cpu-clock                        #    0.000 CPUs utilized
>              77,739      context-switches
>              15,033      cpu-migrations
>             321,313      page-faults
>      14,355,634,225      cpu_atom/instructions/           #    1.40  insn per cycle              (35.37%)
>     134,561,560,583      cpu_core/instructions/           #    3.44  insn per cycle              (57.85%)
>      10,263,836,145      cpu_atom/cycles/                                                        (35.42%)
>      39,138,632,894      cpu_core/cycles/                                                        (57.60%)
>       2,989,658,777      cpu_atom/branches/                                                      (42.60%)
>      32,170,570,388      cpu_core/branches/                                                      (57.39%)
>          29,789,870      cpu_atom/branch-misses/          #    1.00% of all branches             (42.69%)
>         165,991,152      cpu_core/branch-misses/          #    0.52% of all branches             (57.19%)
>                         (software)                 #      nan cs/sec  cs_per_second
>               TopdownL1 (cpu_core)                 #     11.9 %  tma_bad_speculation
>                                                    #     19.6 %  tma_frontend_bound       (63.97%)
>               TopdownL1 (cpu_core)                 #     18.8 %  tma_backend_bound
>                                                    #     49.7 %  tma_retiring             (63.97%)
>                         (software)                 #      nan faults/sec  page_faults_per_second
>                                                    #      nan GHz  cycles_frequency       (42.88%)
>                                                    #      nan GHz  cycles_frequency       (69.88%)
>               TopdownL1 (cpu_atom)                 #     11.7 %  tma_bad_speculation
>                                                    #     29.9 %  tma_retiring             (50.07%)
>               TopdownL1 (cpu_atom)                 #     31.3 %  tma_frontend_bound       (43.09%)
>                         (cpu_atom)                 #      nan M/sec  branch_frequency     (43.09%)
>                                                    #      nan M/sec  branch_frequency     (70.07%)
>                                                    #      nan migrations/sec  migrations_per_second
>               TopdownL1 (cpu_atom)                 #     27.1 %  tma_backend_bound        (43.08%)
>                         (software)                 #      0.0 CPUs  CPUs_utilized
>                                                    #      1.4 instructions  insn_per_cycle  (43.04%)
>                                                    #      3.5 instructions  insn_per_cycle  (69.99%)
>                                                    #      1.0 %  branch_miss_rate         (35.46%)
>                                                    #      0.5 %  branch_miss_rate         (65.02%)
> 
>         2.005626564 seconds time elapsed
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   .../arch/common/common/metrics.json           |  86 +++++++++++++
>   tools/perf/pmu-events/empty-pmu-events.c      | 115 +++++++++++++-----
>   tools/perf/pmu-events/jevents.py              |  21 +++-
>   tools/perf/pmu-events/pmu-events.h            |   1 +
>   tools/perf/util/metricgroup.c                 |  31 +++--
>   5 files changed, 212 insertions(+), 42 deletions(-)
>   create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.json
> 
> diff --git a/tools/perf/pmu-events/arch/common/common/metrics.json b/tools/perf/pmu-events/arch/common/common/metrics.json
> new file mode 100644
> index 000000000000..d915be51e300
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/common/common/metrics.json
> @@ -0,0 +1,86 @@
> +[
> +    {
> +        "BriefDescription": "Average CPU utilization",
> +        "MetricExpr": "(software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@) / (duration_time * 1e9)",

Hi Ian,

I noticed that this metric is making "perf stat tests" fail. 
"duration_time" is a tool event and they don't work with "perf stat 
record" anymore. The test tests the record command with the default args 
which results in this event being used and a failure.

I suppose there are three issues. First two are unrelated to this change:

  - Perf stat record continues to write out a bad perf.data file even
    though it knows that tool events won't work.

    For example 'status' ends up being -1 in cmd_stat() but it's ignored
    for some of the writing parts. It does decide to not print any stdout
    though:

    $ perf stat record -e "duration_time"
    <blank>

  - The other issue is obviously that tool events don't work with perf
    stat record which seems to be a regression from 6828d6929b76 ("perf
    evsel: Refactor tool events")

  - The third issue is that this change adds a broken tool event to the
    default output of perf stat

I'm not actually sure what "perf stat record" is for? It's possible that 
it's not used anymore, expecially if nobody noticed that tool events 
haven't been working in it for a while.

I think we're also supposed to have json output for perf stat (although 
this is also broken in some obscure scenarios), so maybe perf stat 
record isn't needed anymore?

Thanks
James

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
> +        "ScaleUnit": "1000M/sec",
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
> index 2fdf4fbf36e2..e4d00f6b2b5d 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
> @@ -1303,21 +1303,32 @@ static const char *const big_c_string =
>   /* offset=127519 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=0x2c\0000x01\00000\000\000\000\000\000"
>   /* offset=127596 */ "uncore_sys_cmn_pmu\000"
>   /* offset=127615 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in first lookup result (high priority)\000eventid=1,type=5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
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
> +/* offset=129368 */ "branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\000\000\00001"
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
>   ;
>   
>   static const struct compact_pmu_event pmu_events__common_default_core[] = {
> @@ -2603,6 +2614,29 @@ static const struct pmu_table_entry pmu_events__common[] = {
>   },
>   };
>   
> +static const struct compact_pmu_event pmu_metrics__common_default_core[] = {
> +{ 127758 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\00001 */
> +{ 129068 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\000\000\000\000\000\00000 */
> +{ 129368 }, /* branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\000\000\00001 */
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
>   static const struct compact_pmu_event pmu_events__test_soc_cpu_default_core[] = {
>   { 126205 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=0x8a\000\00000\000\000\000\000\000 */
>   { 126267 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=0x8b\000\00000\000\000\000\000\000 */
> @@ -2664,21 +2698,21 @@ static const struct pmu_table_entry pmu_events__test_soc_cpu[] = {
>   };
>   
>   static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_core[] = {
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
>   };
>   
> @@ -2759,7 +2793,10 @@ static const struct pmu_events_map pmu_events_map[] = {
>   		.pmus = pmu_events__common,
>   		.num_pmus = ARRAY_SIZE(pmu_events__common),
>   	},
> -	.metric_table = {},
> +	.metric_table = {
> +		.pmus = pmu_metrics__common,
> +		.num_pmus = ARRAY_SIZE(pmu_metrics__common),
> +	},
>   },
>   {
>   	.arch = "testarch",
> @@ -3208,6 +3245,22 @@ const struct pmu_metrics_table *pmu_metrics_table__find(void)
>           return map ? &map->metric_table : NULL;
>   }
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
>   const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
>   {
>           for (const struct pmu_events_map *tables = &pmu_events_map[0];
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 786a7049363f..5d3f4b44cfb7 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -755,7 +755,10 @@ static const struct pmu_events_map pmu_events_map[] = {
>   \t\t.pmus = pmu_events__common,
>   \t\t.num_pmus = ARRAY_SIZE(pmu_events__common),
>   \t},
> -\t.metric_table = {},
> +\t.metric_table = {
> +\t\t.pmus = pmu_metrics__common,
> +\t\t.num_pmus = ARRAY_SIZE(pmu_metrics__common),
> +\t},
>   },
>   """)
>       else:
> @@ -1237,6 +1240,22 @@ const struct pmu_metrics_table *pmu_metrics_table__find(void)
>           return map ? &map->metric_table : NULL;
>   }
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
>   const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
>   {
>           for (const struct pmu_events_map *tables = &pmu_events_map[0];
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index e0535380c0b2..559265a903c8 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -127,6 +127,7 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
>   const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu);
>   const struct pmu_events_table *perf_pmu__default_core_events_table(void);
>   const struct pmu_metrics_table *pmu_metrics_table__find(void);
> +const struct pmu_metrics_table *pmu_metrics_table__default(void);
>   const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid);
>   const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid);
>   int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 76092ee26761..e67e04ce01c9 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -424,10 +424,18 @@ int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metr
>   		.fn = fn,
>   		.data = data,
>   	};
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
>   		if (ret)
>   			return ret;
>   	}
> @@ -1581,19 +1589,22 @@ static int metricgroup__has_metric_or_groups_callback(const struct pmu_metric *p
>   
>   bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_groups)
>   {
> -	const struct pmu_metrics_table *table = pmu_metrics_table__find();
> +	const struct pmu_metrics_table *tables[2] = {
> +		pmu_metrics_table__find(),
> +		pmu_metrics_table__default(),
> +	};
>   	struct metricgroup__has_metric_data data = {
>   		.pmu = pmu,
>   		.metric_or_groups = metric_or_groups,
>   	};
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
>   }
>   
>   static int metricgroup__topdown_max_level_callback(const struct pmu_metric *pm,

