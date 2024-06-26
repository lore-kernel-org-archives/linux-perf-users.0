Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE614532F;
	Wed, 26 Jun 2024 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424557; cv=none; b=oosCKxQBEvLvzVEe5t6lv/FMi8oE5U+w8GztWaqypFMylBJBfLhE0XuE+AWBoJ9LMXZwZ1SKuqm1d1aJ9ql8tDva5NSw6zUhyM7vv+qfUo2DHNVMH8bTUalLm2a4zdbMMw9ypRO7gc/QkVdnoYTJrAg4ITAnaa+FHEm7ZKOWNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424557; c=relaxed/simple;
	bh=NLvDvGw54gfP7bQhB9DdMmWepqi55qIOC/HXZx6oxMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlRkmLqTG3arRJy0VKsZJF9yq7u+eicC+W1A6zU4bQc9c7b2iOXFt88G1/H30+hxYOaYczfAbbRCCwKHyuVakhiwJxiX1xBzV3YSmtG14biPN7Uks8o0Mb7ZiuLNbQSjkZOqw5rqELLPqGEhXXbD8vbJIMpHW9W5HyOHnRo6bC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICpd3MgD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICpd3MgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BE4C116B1;
	Wed, 26 Jun 2024 17:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719424556;
	bh=NLvDvGw54gfP7bQhB9DdMmWepqi55qIOC/HXZx6oxMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICpd3MgD4ik1S1PkcaI7M+Hvlp1BdewDiSXp2HL0nAygGud1tFigok0h0JDolCzfL
	 zn8KcBVhUniuGHqcLDtolGkW7tH6zjHkEYDcF7xmVk2Yi2cM45X3xZMArMZWjaMY4f
	 1PlQ6iLnJfr7VQmn3Q0p4NtlIqTtXE4+3AZnK0OORiAWUTn12cPH/pBXt/WWhEoGHh
	 8HMwMWMoJUHT3+jvt2TQZ/VYga4AkdbIue/W/DkhtVICj8opf4u4xAKQCYQQo5qPIG
	 Q/Qzhsf4QKHfCXZUKJQy9iTft0xcO1dI5Ldw56jiv8D3jvQxuvnfhjNqkZMgtFH/wa
	 F+Th/z/aN7h/Q==
Date: Wed, 26 Jun 2024 10:55:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v14 6/8] perf stat: Add command line option for
 enabling tpebs recording
Message-ID: <ZnxWKtOWBbFqEnBq@google.com>
References: <20240624222026.229401-1-weilin.wang@intel.com>
 <20240624222026.229401-7-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240624222026.229401-7-weilin.wang@intel.com>

Hello Weilin,

On Mon, Jun 24, 2024 at 06:20:22PM -0400, weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> With this command line option, tpebs recording is turned off in perf stat on
> default. It will only be turned on when this option is given in perf stat
> command.
> 
> Exampe with --enable-tpebs-recording:

I prefer shorter names, how about --enable-tpebs or --record-tpebs, or
maybe just --tpebs ?

Thanks,
Namhyung

> 
> perf stat -M tma_split_loads -C1-4 --enable-tpebs-recording sleep 1
> 
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.044 MB - ]
> 
>  Performance counter stats for 'CPU(s) 1-4':
> 
>     53,259,156,071      cpu_core/TOPDOWN.SLOTS/          #      1.6 %  tma_split_loads          (50.00%)
>     15,867,565,250      cpu_core/topdown-retiring/                                              (50.00%)
>     15,655,580,731      cpu_core/topdown-mem-bound/                                             (50.00%)
>     11,738,022,218      cpu_core/topdown-bad-spec/                                              (50.00%)
>      6,151,265,424      cpu_core/topdown-fe-bound/                                              (50.00%)
>     20,445,917,581      cpu_core/topdown-be-bound/                                              (50.00%)
>      6,925,098,013      cpu_core/L1D_PEND_MISS.PENDING/                                         (50.00%)
>      3,838,653,421      cpu_core/MEMORY_ACTIVITY.STALLS_L1D_MISS/                                        (50.00%)
>      4,797,059,783      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (50.00%)
>     11,931,916,714      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (50.00%)
>        102,576,164      cpu_core/MEM_LOAD_COMPLETED.L1_MISS_ANY/                                        (50.00%)
>         64,071,854      cpu_core/MEM_INST_RETIRED.SPLIT_LOADS/                                        (50.00%)
>                  3      cpu_core/MEM_INST_RETIRED.SPLIT_LOADS/R
> 
>        1.003049679 seconds time elapsed
> 
> Exampe without --enable-tpebs-recording:
> 
> perf stat -M tma_contested_accesses -C1 sleep 1
> 
>  Performance counter stats for 'CPU(s) 1':
> 
>         50,203,891      cpu_core/TOPDOWN.SLOTS/          #      0.0 %  tma_contested_accesses   (63.60%)
>         10,040,777      cpu_core/topdown-retiring/                                              (63.60%)
>          6,890,729      cpu_core/topdown-mem-bound/                                             (63.60%)
>          2,756,463      cpu_core/topdown-bad-spec/                                              (63.60%)
>         10,828,288      cpu_core/topdown-fe-bound/                                              (63.60%)
>         28,350,432      cpu_core/topdown-be-bound/                                              (63.60%)
>                 98      cpu_core/OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM/                                        (63.70%)
>            577,520      cpu_core/MEMORY_ACTIVITY.STALLS_L2_MISS/                                        (54.62%)
>            313,339      cpu_core/MEMORY_ACTIVITY.STALLS_L3_MISS/                                        (54.62%)
>             14,155      cpu_core/MEM_LOAD_RETIRED.L1_MISS/                                        (45.54%)
>                  0      cpu_core/OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD/                                        (36.30%)
>          8,468,077      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (45.38%)
>                198      cpu_core/MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS/                                        (45.38%)
>              8,324      cpu_core/MEM_LOAD_RETIRED.FB_HIT/                                        (45.38%)
>      3,388,031,520      TSC
>         23,226,785      cpu_core/CPU_CLK_UNHALTED.REF_TSC/                                        (54.46%)
>                 80      cpu_core/MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD/                                        (54.46%)
>                  0      cpu_core/MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD/R
>                  0      cpu_core/MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS/R
>      1,006,816,667 ns   duration_time
> 
>        1.002537737 seconds time elapsed
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/Documentation/perf-stat.txt | 8 ++++++++
>  tools/perf/builtin-stat.c              | 4 ++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 29756a87ab6f..f4cde834811d 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -498,6 +498,14 @@ To interpret the results it is usually needed to know on which
>  CPUs the workload runs on. If needed the CPUs can be forced using
>  taskset.
>  
> +--enable-tpebs-recording::
> +Enable automatic sampling on Intel TPEBS retire_latency events (event with :R
> +modifier). Without this option, perf would not capture dynamic retire_latency
> +at runtime. Currently, a zero value is assigned to the retire_latency event when
> +this option is not set. The TPEBS hardware feature starts from Intel Granite
> +Rapids microarchitecture. This option only exists in X86_64 and is meaningful on
> +Intel platforms with TPEBS feature.
> +
>  --td-level::
>  Print the top-down statistics that equal the input level. It allows
>  users to print the interested top-down metrics level instead of the
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 68125bd75b37..7111c96e68ab 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2475,6 +2475,10 @@ int cmd_stat(int argc, const char **argv)
>  			"disable adding events for the metric threshold calculation"),
>  		OPT_BOOLEAN(0, "topdown", &topdown_run,
>  			"measure top-down statistics"),
> +#ifdef HAVE_ARCH_X86_64_SUPPORT
> +		OPT_BOOLEAN(0, "enable-tpebs-recording", &tpebs_recording,
> +			"enable recording for tpebs when retire_latency required"),
> +#endif
>  		OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
>  			"Set the metrics level for the top-down statistics (0: max level)"),
>  		OPT_BOOLEAN(0, "smi-cost", &smi_cost,
> -- 
> 2.43.0
> 
