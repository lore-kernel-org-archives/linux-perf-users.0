Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943534D38D;
	Wed, 22 Apr 2026 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776891233; cv=none; b=S/34118i5jxdIPUaF41apmzkNht5UwumqOGfo0m3sAEjldAwyEk50LWcYpN7wHseKGBgn+jBp7E+TFd4vUrHArdXAx27mUM+xSKSaSr/sX7Rs/X7FAA8CnngZxEJv4MIRg0JXY3qpoPIdfOCshtj6wsXUyqk2iwLh0KF7CeG3gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776891233; c=relaxed/simple;
	bh=lq67gNrOGY/g/ZQPaqhXU2WGtYSac9P5h2CEKwkDfSI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rPBv8B9a56D+AUxHjHOaUg8p8NVU5DwEI+j8T/zzXJiNOAvopQ2GPylp1ESyr/CLx9Li3y0E2GLOiDnJqrsWYTubBk+3dwvK9RJq458EXNTGaKnkdTz5x9uDtW+P9chhNGk6UatJmHCRQN/5kj+1kMSOaVc5AQh4QbKfDyfvZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=in6sxh9f; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="in6sxh9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776891231; x=1808427231;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=lq67gNrOGY/g/ZQPaqhXU2WGtYSac9P5h2CEKwkDfSI=;
  b=in6sxh9f6Gj8IZwO8Una0ZSsmsXkASrS3/U0jYF61rRWJvQw3JSkuSg2
   h3mC7+91b9adPnan0GivR7Sl9I9YM9XO5Rjhv/EbYTmth8LGemyrqCzSQ
   ZGsVlnn8OYAsED2KPN0hkawcbFW3+mMm00dIp3dS6BFjGqI+xsoyVH/wN
   yuH2JjApGqz1QB9ZgLFesje1vii2UOLzIio4N3XimhWZbDFxfw6yJLPpV
   sl+iFuuvbtUgTu0kl4yvTWbF+o7wco2YzoBperhn7RV+4e6ediW8J+rz/
   eLVGTvFneECHe+99xk3QajdskpwgONlu+EcIqNWt9tpuPfTc6kmMDyiOq
   g==;
X-CSE-ConnectionGUID: vrraMqyZSPmK36PUOwPZfw==
X-CSE-MsgGUID: 4KqWx1XvSPWi7Q91CMxmRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77019369"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77019369"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:53:50 -0700
X-CSE-ConnectionGUID: iqb3RENZTZKqWCyT4xGpfQ==
X-CSE-MsgGUID: 3XbTm2W9TUCjWMtUB5mXwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="228119515"
Received: from unknown (HELO [10.241.241.111]) ([10.241.241.111])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:53:50 -0700
Message-ID: <38005c4c-1c21-46c7-bfdb-4aeb4997c409@intel.com>
Date: Wed, 22 Apr 2026 13:53:49 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Chen, Zide" <zide.chen@intel.com>
Subject: Re: [PATCH v5 1/2] perf pmu intel: Generalize SNC cpumask adjustment
 for multiple platforms
To: Namhyung Kim <namhyung@kernel.org>, Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 james.clark@linaro.org, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org
References: <20260407203918.3178481-1-ctshao@google.com>
 <adh_GvlvCZLN0nJ6@google.com>
Content-Language: en-US
In-Reply-To: <adh_GvlvCZLN0nJ6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/2026 9:39 PM, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Apr 07, 2026 at 01:38:42PM -0700, Chun-Tse Shao wrote:
>> Prepare for supporting more Intel platforms with sub-NUMA clustering by
>> generalizing the GNR specific logic.
>>
>> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
>> ---
>> v5:
>>   Split patch.
>>
>> v4: lore.kernel.org/20260402205300.1953706-1-ctshao@google.com
>>   Rebase.
>>
>> v3: lore.kernel.org/20260212223942.3832857-1-ctshao@google.com
>>   Fix a typo.
>>
>> v2: lore.kernel.org/20260205232220.1980168-1-ctshao@google.com
>>   Split EMR and GNR in the SNC2 IMC cpu map.
>>
>> v1: lore.kernel.org/20260108184430.1210223-1-ctshao@google.com
>>
>>  tools/perf/arch/x86/util/pmu.c | 44 +++++++++++++++++++++-------------
>>  1 file changed, 27 insertions(+), 17 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
>> index 0661e0f0b02d..938be36ec0f7 100644
>> --- a/tools/perf/arch/x86/util/pmu.c
>> +++ b/tools/perf/arch/x86/util/pmu.c
>> @@ -23,20 +23,28 @@
>>  #include "util/env.h"
>>  #include "util/header.h"
>>
>> -static bool x86__is_intel_graniterapids(void)
>> +static bool x86__is_snc_supported(void)
>>  {
>> -	static bool checked_if_graniterapids;
>> -	static bool is_graniterapids;
>> +	static bool checked_if_snc_supported;
>> +	static bool is_supported;
>>
>> -	if (!checked_if_graniterapids) {
>> -		const char *graniterapids_cpuid = "GenuineIntel-6-A[DE]";
>> +	if (!checked_if_snc_supported) {
>> +
>> +		/* Graniterapids supports SNC configuration. */
>> +		static const char *const supported_cpuids[] = {
>> +			"GenuineIntel-6-A[DE]", /* Graniterapids */
>> +		};
>>  		char *cpuid = get_cpuid_str((struct perf_cpu){0});
>>
>> -		is_graniterapids = cpuid && strcmp_cpuid_str(graniterapids_cpuid, cpuid) == 0;
>> +		for (size_t i = 0; i < ARRAY_SIZE(supported_cpuids); i++) {
>> +			is_supported = cpuid && strcmp_cpuid_str(supported_cpuids[i], cpuid) == 0;
>> +			if (is_supported)
>> +				break;
>> +		}
>>  		free(cpuid);
>> -		checked_if_graniterapids = true;
>> +		checked_if_snc_supported = true;
>>  	}
>> -	return is_graniterapids;
>> +	return is_supported;
>>  }
>>
>>  static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
>> @@ -133,8 +141,8 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>>  	// Compute the IMC SNC using lookup tables.
>>  	unsigned int imc_num;
>>  	int snc_nodes = snc_nodes_per_l3_cache();
>> -	const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
>> -	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
>> +	const u8 snc2_map[] = {1, 1, 0, 0};
>> +	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2};
>>  	const u8 *snc_map;
>>  	size_t snc_map_len;
>>
>> @@ -157,11 +165,12 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>>  		pr_warning("Unexpected: unable to compute IMC number '%s'\n", pmu->name);
>>  		return 0;
>>  	}
>> -	if (imc_num >= snc_map_len) {
>> +	if (imc_num >= snc_map_len * perf_cpu_map__nr(pmu->cpus)) {
>>  		pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_num, snc_nodes);
>>  		return 0;
> 
> Like sashiko said, I'm curious if it'd work well on 1-socket machine
> which may have the same number of uncore IMC PMUs.
> 
> Zide, can you confirm?

On 1-socket, 1-die systems, the IMC controllers may be the same as on
multi-die systems. Theoretically, this could cause issues if NUMA is
enabled, but I am not aware of any platforms that support SNC on
single-die GNR/EMR SKUs.

I checked on a single-die GNR WS: SNC is not supported, so snc_nodes ==
1 and the cpumask adjustment is correctly skipped.

> 
> Thanks,
> Namhyung
> 
>>  	}
>> -	return snc_map[imc_num];
>> +
>> +	return snc_map[imc_num % snc_map_len];
>>  }
>>
>>  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
>> @@ -201,7 +210,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
>>  	return cpu_adjust[pmu_snc];
>>  }
>>
>> -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
>> +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
>>  {
>>  	// With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
>>  	// topology. For example, a two socket graniterapids machine may be set
>> @@ -301,11 +310,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>>  				pmu->mem_events = perf_mem_events_intel_aux;
>>  			else
>>  				pmu->mem_events = perf_mem_events_intel;
>> -		} else if (x86__is_intel_graniterapids()) {
>> +		} else if (x86__is_snc_supported()) {
>>  			if (strstarts(pmu->name, "uncore_cha_"))
>> -				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
>> -			else if (strstarts(pmu->name, "uncore_imc_"))
>> -				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
>> +				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
>> +			else if (strstarts(pmu->name, "uncore_imc_") &&
>> +				 !strstarts(pmu->name, "uncore_imc_free_running"))
>> +				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
>>  		}
>>  	}
>>  }
>> --
>> 2.53.0.1213.gd9a14994de-goog
>>

