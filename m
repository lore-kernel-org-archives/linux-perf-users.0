Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA003B1A2;
	Mon, 11 Nov 2024 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731305859; cv=none; b=d1n4nyZY7Zm059hW318P3k3L7ux7LvKy2Xy7w/f9LSkY71IqawBoI52W2eL8vv/DGiGhIBo0s5Poc5IIHYRRqCTrJAnXQZUJ5q7HtMRRmpZZyBHrYf+D1oORhJRaL+KEiFAV/m6wpiNRl18ZnuF64HNwB78fEyFGGAJxk0V9bYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731305859; c=relaxed/simple;
	bh=ncjbv0XqcOfZzaJmbOfOv+5qicSMAB21heGShx92YTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rl9ySRBLg6OggBWeIHY/wy7ORwBSNe2OpsphqbD3825DR8/7uIRNu6wNEdoXC1e6Ib5ht0f024gI5pHSMsXAG2djNik8qPloBynu1hlkjnDkToqd3nh+9zZh2Em1iL+ir6+LBKP/mAzSU/oKNspw2rUFKUmFx1Ydgi3IPW5ZdO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvXQdnzP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvXQdnzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731305858; x=1762841858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ncjbv0XqcOfZzaJmbOfOv+5qicSMAB21heGShx92YTE=;
  b=QvXQdnzPkhos+xv7IWzx5myavSgcDu8a3zwv6iDms+OLD3+LTQxDvNSg
   rk8vcxIHm3JdG4qE5e/i0gKpaTVO9NTh62N+ZK/Mj52RF79xtZXFWmykL
   fctVZSH1gH8wpbEHXN58zYjyJur43RCR7p/CvQsomXVIAcLOu9+iBbqi/
   RTfhIhCHshy5WZ3VxmiLdjL35Qkw8qeVxRQYnSdSHlbis+69oBjNtB3t0
   dnrYaxkkjHmC0Hg8fjc35NLcukhn2fghWRA3Vn+OSBTx6pmX3b+PywgxM
   ua4+x5jnFMmzgD25QFZZxoHbsRwAok4/v0eZMofaHTwiT2PMy8tiSQEYn
   g==;
X-CSE-ConnectionGUID: 3Bp7ecOJTfCuizI0j6e3Hw==
X-CSE-MsgGUID: /FDLnMy0RbG98vSD0Uaa4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="42500681"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="42500681"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:17:37 -0800
X-CSE-ConnectionGUID: UcLni4JlRH2QesEAdpU4AA==
X-CSE-MsgGUID: BcXks8rnT8SdkKne2iF2/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="86920847"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:17:33 -0800
Message-ID: <c1592c50-e903-4ee5-a560-530792fcbae7@intel.com>
Date: Mon, 11 Nov 2024 08:17:29 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Fix typos Muliplier -> Multiplier
To: Andrew Kreimer <algonell@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Liang Kan <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20241108134728.25515-1-algonell@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241108134728.25515-1-algonell@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/24 15:47, Andrew Kreimer wrote:
> There are some typos in fprintf messages.
> Fix them via codespell.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/intel-bts.c | 2 +-
>  tools/perf/util/intel-pt.c  | 2 +-
>  tools/perf/util/tsc.c       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 3ea82d5e8d2e..a7c589fecb98 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -808,7 +808,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
>  static const char * const intel_bts_info_fmts[] = {
>  	[INTEL_BTS_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
>  	[INTEL_BTS_TIME_SHIFT]		= "  Time Shift         %"PRIu64"\n",
> -	[INTEL_BTS_TIME_MULT]		= "  Time Muliplier     %"PRIu64"\n",
> +	[INTEL_BTS_TIME_MULT]		= "  Time Multiplier    %"PRIu64"\n",
>  	[INTEL_BTS_TIME_ZERO]		= "  Time Zero          %"PRIu64"\n",
>  	[INTEL_BTS_CAP_USER_TIME_ZERO]	= "  Cap Time Zero      %"PRId64"\n",
>  	[INTEL_BTS_SNAPSHOT_MODE]	= "  Snapshot mode      %"PRId64"\n",
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 3fe67bf652b6..30be6dfe09eb 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -4110,7 +4110,7 @@ static int intel_pt_parse_vm_tm_corr_args(struct intel_pt *pt)
>  static const char * const intel_pt_info_fmts[] = {
>  	[INTEL_PT_PMU_TYPE]		= "  PMU Type            %"PRId64"\n",
>  	[INTEL_PT_TIME_SHIFT]		= "  Time Shift          %"PRIu64"\n",
> -	[INTEL_PT_TIME_MULT]		= "  Time Muliplier      %"PRIu64"\n",
> +	[INTEL_PT_TIME_MULT]		= "  Time Multiplier     %"PRIu64"\n",
>  	[INTEL_PT_TIME_ZERO]		= "  Time Zero           %"PRIu64"\n",
>  	[INTEL_PT_CAP_USER_TIME_ZERO]	= "  Cap Time Zero       %"PRId64"\n",
>  	[INTEL_PT_TSC_BIT]		= "  TSC bit             %#"PRIx64"\n",
> diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
> index 2e33a20e1e1b..511a517ce613 100644
> --- a/tools/perf/util/tsc.c
> +++ b/tools/perf/util/tsc.c
> @@ -119,7 +119,7 @@ size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp)
>  	size_t ret;
>  
>  	ret  = fprintf(fp, "\n... Time Shift      %" PRI_lu64 "\n", tc->time_shift);
> -	ret += fprintf(fp, "... Time Muliplier  %" PRI_lu64 "\n", tc->time_mult);
> +	ret += fprintf(fp, "... Time Multiplier %" PRI_lu64 "\n", tc->time_mult);
>  	ret += fprintf(fp, "... Time Zero       %" PRI_lu64 "\n", tc->time_zero);
>  
>  	/*

