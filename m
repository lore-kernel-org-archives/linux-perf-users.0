Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812AB23F26A;
	Fri,  3 Apr 2026 01:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178346; cv=none; b=jeW4YVuzQUJQXzSEOKoCJW1TFhc2kJmzz5Iqmy3DEMOaddcxwOpe5D1+Gj/A+di5M41L+QLce0MadeoWKchJOfhlT68+MiYRQ9Q0nXHowXIltIG1gnIxrnd+3FG5y+yLVnROVVFlRMI/g6NubuijNBk1tAStbXm8/p42NsqvTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178346; c=relaxed/simple;
	bh=8QVu6wQMQzN5RpnneuN3rcFlycUh1rdpNK8roV3jOOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJxtVO7k3sIJSs5sctjg4sM2LVJXwl/1jZ/Bi3o4Kz+Mrh7SB9SMPszPQhCcagobd3ia8PXJs90miUI4+HzoAt8z5ZOIv5l/o2ky2R/92/Qz6WA2/YhF+9wsAXfWOH0b1rxjqrW4YyyvVC5SmjaUFi/HFWLPSNEJUF8LX0k4oZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTardiKi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTardiKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944D6C116C6;
	Fri,  3 Apr 2026 01:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775178346;
	bh=8QVu6wQMQzN5RpnneuN3rcFlycUh1rdpNK8roV3jOOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aTardiKiWT6Lb/uDIbBEYLEdEPpRuHGGkHZtPoF2cVGL5edorNT73Ne0cyfMmswZh
	 dMCozh3XjucfZFgFLLeAL0dMMiWtAmqYpYXPYc18MLZ+EZVR9EIYE7O0FWONEonhGl
	 CukDlxHJkPBXdCyPUFwgJq/nqjeIoy7lgjtZbHvelFBxXs9h5eRXjFUW1KtiC4ujEY
	 ftYWlfvphq5of/7BIB9IdCLe2u6gYt/Krmliwybx6Q+IAgHEeg5npJG7w2FTAem/cp
	 ekUb/Vg39WbSyRLCE57bgQB28+Yfu48zzbavOgDHEyJnMbb3ZIb3/a4xLC9SwBWoUk
	 OlS+ec6mHtubA==
Date: Thu, 2 Apr 2026 18:05:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Ian Rogers <irogers@google.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org,
	ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on Emeraldrapids
Message-ID: <ac8SZ1FoFOhJarLJ@google.com>
References: <20260402205300.1953706-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402205300.1953706-1-ctshao@google.com>

On Thu, Apr 02, 2026 at 01:52:36PM -0700, Chun-Tse Shao wrote:
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
> Reviewed-by: Zide Chen <zide.chen@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
> v4:
>   Rebase.
> 
> v3: lore.kernel.org/20260212223942.3832857-1-ctshao@google.com
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
> index 0661e0f0b02d..ec3c5a368d67 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -23,20 +23,29 @@
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
> @@ -65,6 +74,7 @@ static int snc_nodes_per_l3_cache(void)
>  			read_sysfs_cpu_map("devices/system/cpu/cpu0/cache/index3/shared_cpu_list");
> 
>  		snc_nodes = perf_cpu_map__nr(cache_cpus) / perf_cpu_map__nr(node_cpus);
> +

An unnecessary change.

>  		perf_cpu_map__put(cache_cpus);
>  		perf_cpu_map__put(node_cpus);
>  		checked_snc = true;
> @@ -133,23 +143,42 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
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
> @@ -157,11 +186,12 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
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

Can you please move this part to a separate commit?  I think it's an
independent change from the EMR support.

Thanks,
Namhyung

>  }
> 
>  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
> @@ -201,7 +231,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
>  	return cpu_adjust[pmu_snc];
>  }
> 
> -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
> +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
>  {
>  	// With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
>  	// topology. For example, a two socket graniterapids machine may be set
> @@ -301,11 +331,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>  				pmu->mem_events = perf_mem_events_intel_aux;
>  			else
>  				pmu->mem_events = perf_mem_events_intel;
> -		} else if (x86__is_intel_graniterapids()) {
> +		} else if (x86__is_snc_supported()) {
>  			if (strstarts(pmu->name, "uncore_cha_"))
> -				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
> -			else if (strstarts(pmu->name, "uncore_imc_"))
> -				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
> +				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
> +			else if (strstarts(pmu->name, "uncore_imc_") &&
> +				 !strstarts(pmu->name, "uncore_imc_free_running"))
> +				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
>  		}
>  	}
>  }
> --
> 2.53.0.1213.gd9a14994de-goog
> 
