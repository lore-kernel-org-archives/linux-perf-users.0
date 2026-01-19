Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2717189F20;
	Mon, 19 Jan 2026 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768783909; cv=none; b=LDfrvkYCbKRz/X8TCxAgBJCMpbLEROTCoG52f9GTAdgisNT6BLm3QfPnq7eHGZvUj0WYzYFCmCIlvnBxlwVhDEIWXlAQoMKIc7EkIxYrf7q/KtnwpOxoDEFrvyiY20peDkpJOyzFdwyJrKFo8BXHctZ4KBHdlA+5BWIkWxCSXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768783909; c=relaxed/simple;
	bh=Z0MzzFE/D0d7Wuie7GIqfiwpEsDh6q5M3MMG1cDYoI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9lcgFeQFbfch0vF3koBtkop5HH6CHyCaIfZcJhjQ8f50ttielnPuphcRfTzsZJK+tHYRv4XG0J3icJrOgHEkatMEpdHgTDIZcdbj2LbDYcajyMDrX5ZaOLJfcmNUXX8P/laA+CB/eT+kz9DLX162rd8AYC/1fWb+4I8FJXHnx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcM6TTqM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcM6TTqM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768783908; x=1800319908;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z0MzzFE/D0d7Wuie7GIqfiwpEsDh6q5M3MMG1cDYoI4=;
  b=KcM6TTqMrFKZ7FFajnDl//a2d4aQbTpxAQpVrG3SaK14tsA5qxzywR4k
   I9u2HgssqdqJkh48YWGNW1nnmUj1EiFhNu1oShH2breWukA5jVdjQ2F0R
   aFDPvWqoJMG3rRHOONE03VTk7HQpw3s3X96+a6dAQACOF1uTuZVT7reua
   jUNa4pDjRWxcRqINvkv1pSWByEk7qtN9oen2iJLpMl45kTVHz4SXnIg9C
   0UQCHCMlJCYBh3R9I2azEfruOhuC6IScABsqmbwH/9Sk4H4ZcDYEiJ4p7
   NCyWuvcFiX9LVzmvbreaWjWiapvDFoHpGV9uqrGFmLDDqcCLoHPN0jOOp
   A==;
X-CSE-ConnectionGUID: 49EHl5O/RAqBEAyJCckPRg==
X-CSE-MsgGUID: hIuxU0rpS4uzvtxF3wmrXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="73846035"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="73846035"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 16:51:48 -0800
X-CSE-ConnectionGUID: UiFcRq1CQ7+vC4j1iK6D9Q==
X-CSE-MsgGUID: IECm42ndSvGl57JYy7FaJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="205525293"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 16:51:43 -0800
Message-ID: <09ff8b36-eb35-425d-b36c-d33237f2623a@linux.intel.com>
Date: Mon, 19 Jan 2026 08:51:41 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf pmu intel: Adjust cpumaks for sub-NUMA clusters on
 Emeraldrapids
To: Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>,
 "Chen, Zide" <zide.chen@intel.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, james.clark@linaro.org, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org
References: <20260108184430.1210223-1-ctshao@google.com>
 <CAP-5=fVLFVzitYZso2HB7dFgaNbJqW0pLE_AqMhc0ytW0PFvZw@mail.gmail.com>
 <CAJpZYjVadSgX6eSczFsqxJpMSq8q67CkA_WA+8jf+atgUScBNA@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAJpZYjVadSgX6eSczFsqxJpMSq8q67CkA_WA+8jf+atgUScBNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/14/2026 2:06 AM, Chun-Tse Shao wrote:
> Ping.
>
> Thanks for your comment, Ian. To Intel team, can we get confirmation
> of the GNR SNR2 configuration?

+ Zide

Zide would look at and verify the configuration. Thanks.


>
> -CT
>
> On Thu, Jan 8, 2026 at 11:19 AM Ian Rogers <irogers@google.com> wrote:
>> On Thu, Jan 8, 2026 at 10:45 AM Chun-Tse Shao <ctshao@google.com> wrote:
>>> Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as well.
>>> Adjust cpumasks as the logic for GNR in [1].
>>>
>>> Tested on Emeraldrapids with SNC2 enabled:
>>>   $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a -- sleep 1
>>>
>>>    Performance counter stats for 'system wide':
>>>
>>>   N0       30        72125876670      UNC_CHA_CLOCKTICKS
>>>   N0        4         8815163648      UNC_M_CLOCKTICKS
>>>   N1       30        72124958844      UNC_CHA_CLOCKTICKS
>>>   N1        4         8815014974      UNC_M_CLOCKTICKS
>>>   N2       30        72121049022      UNC_CHA_CLOCKTICKS
>>>   N2        4         8814592626      UNC_M_CLOCKTICKS
>>>   N3       30        72117133854      UNC_CHA_CLOCKTICKS
>>>   N3        4         8814012840      UNC_M_CLOCKTICKS
>>>
>>>          1.001574118 seconds time elapsed
>>>
>>> [1] lore.kernel.org/20250515181417.491401-1-irogers@google.com
>>>
>>> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
>>> ---
>>>  tools/perf/arch/x86/util/pmu.c | 45 +++++++++++++++++++++-------------
>>>  1 file changed, 28 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
>>> index a3f96221758d..fad68a0f7b5d 100644
>>> --- a/tools/perf/arch/x86/util/pmu.c
>>> +++ b/tools/perf/arch/x86/util/pmu.c
>>> @@ -22,20 +22,29 @@
>>>  #include "util/env.h"
>>>  #include "util/header.h"
>>>
>>> -static bool x86__is_intel_graniterapids(void)
>>> +static bool x86__is_snc_supported(void)
>>>  {
>>> -       static bool checked_if_graniterapids;
>>> -       static bool is_graniterapids;
>>> +       static bool checked_if_snc_supported;
>>> +       static bool is_supported;
>>>
>>> -       if (!checked_if_graniterapids) {
>>> -               const char *graniterapids_cpuid = "GenuineIntel-6-A[DE]";
>>> +       if (!checked_if_snc_supported) {
>>> +
>>> +               /* Emeraldrapids and Graniterapids support SNC configuration. */
>>> +               static const char *const supported_cpuids[] = {
>>> +                       "GenuineIntel-6-CF", /* Emeraldrapids */
>>> +                       "GenuineIntel-6-A[DE]", /* Graniterapids */
>>> +               };
>>>                 char *cpuid = get_cpuid_str((struct perf_cpu){0});
>>>
>>> -               is_graniterapids = cpuid && strcmp_cpuid_str(graniterapids_cpuid, cpuid) == 0;
>>> +               for (size_t i = 0; i < ARRAY_SIZE(supported_cpuids); i++) {
>>> +                       is_supported = cpuid && strcmp_cpuid_str(supported_cpuids[i], cpuid) == 0;
>>> +                       if (is_supported)
>>> +                               break;
>>> +               }
>>>                 free(cpuid);
>>> -               checked_if_graniterapids = true;
>>> +               checked_if_snc_supported = true;
>>>         }
>>> -       return is_graniterapids;
>>> +       return checked_if_snc_supported;
>>>  }
>>>
>>>  static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
>>> @@ -64,6 +73,7 @@ static int snc_nodes_per_l3_cache(void)
>>>                         read_sysfs_cpu_map("devices/system/cpu/cpu0/cache/index3/shared_cpu_list");
>>>
>>>                 snc_nodes = perf_cpu_map__nr(cache_cpus) / perf_cpu_map__nr(node_cpus);
>>> +
>>>                 perf_cpu_map__put(cache_cpus);
>>>                 perf_cpu_map__put(node_cpus);
>>>                 checked_snc = true;
>>> @@ -137,8 +147,8 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>>>         // Compute the IMC SNC using lookup tables.
>>>         unsigned int imc_num;
>>>         int snc_nodes = snc_nodes_per_l3_cache();
>>> -       const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
>>> -       const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
>>> +       const u8 snc2_map[] = {0, 0, 1, 1};
>> Does this alter the behavior on GNR? ie 1,1,0,0 vs 0,0,1,1.
>>
>> Thanks,
>> Ian
>>
>>> +       const u8 snc3_map[] = {1, 1, 0, 0, 2, 2};
>>>         const u8 *snc_map;
>>>         size_t snc_map_len;
>>>
>>> @@ -161,11 +171,11 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>>>                 pr_warning("Unexpected: unable to compute IMC number '%s'\n", pmu->name);
>>>                 return 0;
>>>         }
>>> -       if (imc_num >= snc_map_len) {
>>> +       if (imc_num >= snc_map_len * perf_cpu_map__nr(pmu->cpus)) {
>>>                 pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_num, snc_nodes);
>>>                 return 0;
>>>         }
>>> -       return snc_map[imc_num];
>>> +       return snc_map[imc_num % snc_map_len];
>>>  }
>>>
>>>  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
>>> @@ -205,7 +215,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
>>>         return cpu_adjust[pmu_snc];
>>>  }
>>>
>>> -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
>>> +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
>>>  {
>>>         // With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
>>>         // topology. For example, a two socket graniterapids machine may be set
>>> @@ -304,11 +314,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>>>                                 pmu->mem_events = perf_mem_events_intel_aux;
>>>                         else
>>>                                 pmu->mem_events = perf_mem_events_intel;
>>> -               } else if (x86__is_intel_graniterapids()) {
>>> +               } else if (x86__is_snc_supported()) {
>>>                         if (starts_with(pmu->name, "uncore_cha_"))
>>> -                               gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
>>> -                       else if (starts_with(pmu->name, "uncore_imc_"))
>>> -                               gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
>>> +                               uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
>>> +                       else if (starts_with(pmu->name, "uncore_imc_") &&
>>> +                                !starts_with(pmu->name, "uncore_imc_free_running"))
>>> +                               uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
>>>                 }
>>>         }
>>>  }
>>> --
>>> 2.52.0.457.g6b5491de43-goog
>>>
