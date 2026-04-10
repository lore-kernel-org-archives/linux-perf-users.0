Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078DF33260F;
	Fri, 10 Apr 2026 04:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775795997; cv=none; b=ElIeLVGnJGFvzsLkxKMlkYhZvk1flWucD7pcbAcZ/GTUCDz1IYGhdGYd5CmWXG0r+gii/xg7UQXwxZcT9Bp74STfzI6OR1AViVv6qeHqnHevUDHdrvyG0NzbrpZk9Y1pQgedUWGPdLO1dTbbIqOyhTssR1eCddBBJ+Wf1RiG5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775795997; c=relaxed/simple;
	bh=tohjpnH8/qAypmZepm3LGhtjiO6W9KKk1qY5u0SRAdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pla2ML5H/N5KmIy/kqbtsMUDucyokF2Ryj5BoLF+eBg29fNKkcsPmEgsMhFBpJx9fpkYE2z1WV7woUTGaY34rcPI3UY71kOGK2kSFRQiMBJ+jUkko+/xHTvCrWRPFXFNqNPpuvw0gxjg63NQledUiOtVEIEw3hR4k475owyOgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pA8QM8cn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA8QM8cn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAFEC19421;
	Fri, 10 Apr 2026 04:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775795996;
	bh=tohjpnH8/qAypmZepm3LGhtjiO6W9KKk1qY5u0SRAdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pA8QM8cn2dDo6sT50Us12pOI4fVs7uhVJW+OXlAyMrG/H57Ur9mRBOBajmiq6FI3q
	 2nOINe3DVXa+mItmaREykUadsdITRgWBVvOpx953OA5JT3C2ae4zhv9oD4FOYkz2Bk
	 zvgdTbhMHthPRkEo7pqZWK3V5HuCjlttzC81BBHobAqLR4NIU/3234p52/JiRUrB9T
	 OB2EV+A5mwdOV2HOq6WvHS089jeQsJrXb24S/u3QMq9XnzfiqG46wgjveAuVAxpfZG
	 EQ72Kd53HS4Pn0Dhk8z83UMe0g32k0bFiNjCHljwY7ffD00tBH1EBwpbJ3Q/gjm2T/
	 ZhmjUJEPGQVgg==
Date: Thu, 9 Apr 2026 21:39:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>, zide.chen@intel.com
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf pmu intel: Generalize SNC cpumask adjustment
 for multiple platforms
Message-ID: <adh_GvlvCZLN0nJ6@google.com>
References: <20260407203918.3178481-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407203918.3178481-1-ctshao@google.com>

Hello,

On Tue, Apr 07, 2026 at 01:38:42PM -0700, Chun-Tse Shao wrote:
> Prepare for supporting more Intel platforms with sub-NUMA clustering by
> generalizing the GNR specific logic.
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
> v5:
>   Split patch.
> 
> v4: lore.kernel.org/20260402205300.1953706-1-ctshao@google.com
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
>  tools/perf/arch/x86/util/pmu.c | 44 +++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 0661e0f0b02d..938be36ec0f7 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -23,20 +23,28 @@
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
> +		/* Graniterapids supports SNC configuration. */
> +		static const char *const supported_cpuids[] = {
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
> @@ -133,8 +141,8 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>  	// Compute the IMC SNC using lookup tables.
>  	unsigned int imc_num;
>  	int snc_nodes = snc_nodes_per_l3_cache();
> -	const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
> -	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
> +	const u8 snc2_map[] = {1, 1, 0, 0};
> +	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2};
>  	const u8 *snc_map;
>  	size_t snc_map_len;
> 
> @@ -157,11 +165,12 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>  		pr_warning("Unexpected: unable to compute IMC number '%s'\n", pmu->name);
>  		return 0;
>  	}
> -	if (imc_num >= snc_map_len) {
> +	if (imc_num >= snc_map_len * perf_cpu_map__nr(pmu->cpus)) {
>  		pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_num, snc_nodes);
>  		return 0;

Like sashiko said, I'm curious if it'd work well on 1-socket machine
which may have the same number of uncore IMC PMUs.

Zide, can you confirm?

Thanks,
Namhyung

>  	}
> -	return snc_map[imc_num];
> +
> +	return snc_map[imc_num % snc_map_len];
>  }
> 
>  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
> @@ -201,7 +210,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
>  	return cpu_adjust[pmu_snc];
>  }
> 
> -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
> +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
>  {
>  	// With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
>  	// topology. For example, a two socket graniterapids machine may be set
> @@ -301,11 +310,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
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
