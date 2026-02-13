Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16877139D;
	Fri, 13 Feb 2026 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770941313; cv=none; b=Nlc0hTAopLbK1z62hE9oaEXYyqxGb7GqB0jN79Vzc/csas4O8KbYBqyMHjYT/GCjmUKv0ZvylvX0bNO2USGJXXOaNsNvzgvhGgEDr63szFtOUcMcGvVCjBWM6Bh13ZbjABX4RUVG66tCZ0K78vcwutM/GFtBzGynbYhOcgU4hNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770941313; c=relaxed/simple;
	bh=LopbS1CU1O//dWEGCOxaweXgiEYp4i7hqO3szWDYfhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjDhDhTT11sovwlDUR0ynmXCr4utb3+Yj0i0MQ9jSrL4Yb3vZsI/apfiCfLr3Xrpdy7fwsHlLBdusOITJCYSX/Wi2MO4k85bJAQiCi6/qBii5zl1OxGR6bAXtHL6n71MOLUrYrpSuGUI2bb3WlCBSVDS/BbgcJ/9Bk51Fj6qG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0swDdtu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0swDdtu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770941311; x=1802477311;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LopbS1CU1O//dWEGCOxaweXgiEYp4i7hqO3szWDYfhk=;
  b=b0swDdtuqlHjTLOJGCPXmTAKL3gsyM+SiUfid5Eejx5WLwDZDnJIoTU3
   d8HCDY4b6LeLjp3hmvc4NK44waigAD+ziBNAlqqpZA+LlbI0a+aEbZ+lJ
   DBCSLAl1R9VAZ+B7t2y4AXY7PqXotahCOJzt7PeMEJycIl09Ze9TnEkwM
   icjDJxDLuuu4GLeqk6Nsf+eKocs0wAtYeLj2mS9JUCa0B00kbwngx7zxt
   7F+/L3VeUj2sSA0DhAsaWzzKU2vW6dDvBA1yHT9lN6E9fU7dyhwSKoUtl
   BQNNEchPwJhTV5vz/+ng05sRw2bnQc8WF1vNPdK1X3zjIHXKvNDX+cUyJ
   g==;
X-CSE-ConnectionGUID: 0N/W0xg/TMWCcwYxztkBvg==
X-CSE-MsgGUID: rXjFE6QgReuQhwN8kNBesA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82763479"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="82763479"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 16:08:30 -0800
X-CSE-ConnectionGUID: YZo3mkh3R6yvhL71aQCO7Q==
X-CSE-MsgGUID: us5TAhkYRHexfzBuZJ5a+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211556722"
Received: from unknown (HELO [10.241.241.224]) ([10.241.241.224])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 16:08:30 -0800
Message-ID: <bb9a1471-6996-47e9-a81e-8de58ab32fb2@intel.com>
Date: Thu, 12 Feb 2026 16:08:29 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on Emeraldrapids
To: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org
References: <20260212223942.3832857-1-ctshao@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260212223942.3832857-1-ctshao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/2026 2:39 PM, Chun-Tse Shao wrote:
> Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as well.
> Adjust cpumasks as the logic for GNR in [1].
> 
> Tested on Emeraldrapids with SNC2 enabled:
>   $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a -- sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>   N0       30        72125876670      UNC_CHA_CLOCKTICKS
>   N0        4         8815163648      UNC_M_CLOCKTICKS
>   N1       30        72124958844      UNC_CHA_CLOCKTICKS
>   N1        4         8815014974      UNC_M_CLOCKTICKS
>   N2       30        72121049022      UNC_CHA_CLOCKTICKS
>   N2        4         8814592626      UNC_M_CLOCKTICKS
>   N3       30        72117133854      UNC_CHA_CLOCKTICKS
>   N3        4         8814012840      UNC_M_CLOCKTICKS
> 
>          1.001574118 seconds time elapsed
> 
> [1] lore.kernel.org/20250515181417.491401-1-irogers@google.com
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

LGTM.

Reviewed-by: Zide Chen <zide.chen@intel.com>

> ---
> v3:
>   Fix a typo.
> 
> v2: lore.kernel.org/20260205232220.1980168-1-ctshao@google.com
>   Split EMR and GNR in the SNC2 IMC cpu map.
> 
> v1: lore.kernel.org/20260108184430.1210223-1-ctshao@google.com
> 
>  tools/perf/arch/x86/util/pmu.c | 95 ++++++++++++++++++++++------------
>  1 file changed, 63 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index a3f96221758d..2215984349f5 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -22,20 +22,29 @@
>  #include "util/env.h"
>  #include "util/header.h"
> 
> -static bool x86__is_intel_graniterapids(void)
> +static bool x86__is_snc_supported(void)
>  {
> -	static bool checked_if_graniterapids;
> -	static bool is_graniterapids;
> +	static bool checked_if_snc_supported;
> +	static bool is_supported;
> 
> -	if (!checked_if_graniterapids) {
> -		const char *graniterapids_cpuid = "GenuineIntel-6-A[DE]";
> +	if (!checked_if_snc_supported) {
> +
> +		/* Emeraldrapids and Graniterapids support SNC configuration. */
> +		static const char *const supported_cpuids[] = {
> +			"GenuineIntel-6-CF", /* Emeraldrapids */
> +			"GenuineIntel-6-A[DE]", /* Graniterapids */
> +		};
>  		char *cpuid = get_cpuid_str((struct perf_cpu){0});
> 
> -		is_graniterapids = cpuid && strcmp_cpuid_str(graniterapids_cpuid, cpuid) == 0;
> +		for (size_t i = 0; i < ARRAY_SIZE(supported_cpuids); i++) {
> +			is_supported = cpuid && strcmp_cpuid_str(supported_cpuids[i], cpuid) == 0;
> +			if (is_supported)
> +				break;
> +		}
>  		free(cpuid);
> -		checked_if_graniterapids = true;
> +		checked_if_snc_supported = true;
>  	}
> -	return is_graniterapids;
> +	return is_supported;
>  }
> 
>  static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
> @@ -64,6 +73,7 @@ static int snc_nodes_per_l3_cache(void)
>  			read_sysfs_cpu_map("devices/system/cpu/cpu0/cache/index3/shared_cpu_list");
> 
>  		snc_nodes = perf_cpu_map__nr(cache_cpus) / perf_cpu_map__nr(node_cpus);
> +
>  		perf_cpu_map__put(cache_cpus);
>  		perf_cpu_map__put(node_cpus);
>  		checked_snc = true;
> @@ -137,23 +147,42 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>  	// Compute the IMC SNC using lookup tables.
>  	unsigned int imc_num;
>  	int snc_nodes = snc_nodes_per_l3_cache();
> -	const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
> -	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
> -	const u8 *snc_map;
> -	size_t snc_map_len;
> -
> -	switch (snc_nodes) {
> -	case 2:
> -		snc_map = snc2_map;
> -		snc_map_len = ARRAY_SIZE(snc2_map);
> -		break;
> -	case 3:
> -		snc_map = snc3_map;
> -		snc_map_len = ARRAY_SIZE(snc3_map);
> -		break;
> -	default:
> -		/* Error or no lookup support for SNC with >3 nodes. */
> -		return 0;
> +	char *cpuid;
> +	static const u8 emr_snc2_map[] = { 0, 0, 1, 1 };
> +	static const u8 gnr_snc2_map[] = { 1, 1, 0, 0 };
> +	static const u8 snc3_map[] = { 1, 1, 0, 0, 2, 2 };
> +	static const u8 *snc_map;
> +	static size_t snc_map_len;
> +
> +	/* snc_map is not inited yet. We only look up once to avoid expensive operations. */
> +	if (!snc_map) {
> +		switch (snc_nodes) {
> +		case 2:
> +			cpuid = get_cpuid_str((struct perf_cpu){ 0 });
> +			if (cpuid) {
> +				if (strcmp_cpuid_str("GenuineIntel-6-CF", cpuid) == 0) {
> +					snc_map = emr_snc2_map;
> +					snc_map_len = ARRAY_SIZE(emr_snc2_map);
> +				} else if (strcmp_cpuid_str("GenuineIntel-6-A[DE]", cpuid) == 0) {
> +					snc_map = gnr_snc2_map;
> +					snc_map_len = ARRAY_SIZE(gnr_snc2_map);
> +				}
> +				free(cpuid);
> +			}
> +			break;
> +		case 3:
> +			snc_map = snc3_map;
> +			snc_map_len = ARRAY_SIZE(snc3_map);
> +			break;
> +		default:
> +			/* Error or no lookup support for SNC with >3 nodes. */
> +			return 0;
> +		}
> +
> +		if (!snc_map) {
> +			pr_warning("Unexpected: can not find snc map config");
> +			return 0;
> +		}
>  	}
> 
>  	/* Compute SNC for PMU. */
> @@ -161,11 +190,12 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>  		pr_warning("Unexpected: unable to compute IMC number '%s'\n", pmu->name);
>  		return 0;
>  	}
> -	if (imc_num >= snc_map_len) {
> +	if (imc_num >= snc_map_len * perf_cpu_map__nr(pmu->cpus)) {
>  		pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_num, snc_nodes);
>  		return 0;
>  	}
> -	return snc_map[imc_num];
> +
> +	return snc_map[imc_num % snc_map_len];
>  }
> 
>  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
> @@ -205,7 +235,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
>  	return cpu_adjust[pmu_snc];
>  }
> 
> -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
> +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
>  {
>  	// With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
>  	// topology. For example, a two socket graniterapids machine may be set
> @@ -304,11 +334,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>  				pmu->mem_events = perf_mem_events_intel_aux;
>  			else
>  				pmu->mem_events = perf_mem_events_intel;
> -		} else if (x86__is_intel_graniterapids()) {
> +		} else if (x86__is_snc_supported()) {
>  			if (starts_with(pmu->name, "uncore_cha_"))
> -				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
> -			else if (starts_with(pmu->name, "uncore_imc_"))
> -				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
> +				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
> +			else if (starts_with(pmu->name, "uncore_imc_") &&
> +				 !starts_with(pmu->name, "uncore_imc_free_running"))
> +				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
>  		}
>  	}
>  }
> --
> 2.53.0.273.g2a3d683680-goog
> 
> 

