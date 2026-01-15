Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1451C4369A;
	Thu, 15 Jan 2026 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768440659; cv=none; b=lL1baO0ekJ1oO3yRRLq2RSLv+Pkd8fKvSq1QAZgjl0X1ipXsufkuaoCGPZ4Uy1K87KnyBvYJGnYpAx12buZli/U1uCsQgEbKB03MBMiDOr+bqHDjrFkGpKDV5CJXut2k6spjvPjOBA0sL1GqNUIQK+8dHNYabOJGRGhveM18yhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768440659; c=relaxed/simple;
	bh=mX0rueHhtKwbsyf+pbcJ7kgqpNFg3hFLcOBtApN41Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXArWWCM+GKZzb5Ckhfuwq5pTS6A7VrDcrUQnUcQtgRtnQjSwSlAXgDZ3JC/dd4bs7csuzfVMYQ/fgSJDUPAzg5oaPSPHTfc22x8xsGtnVjNm1bVthkyp7hMfYhDekHyPGgW75oBnLTI2qUx5nGv9hl0rA44hpjImPcZgc8Ii3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJQq5JXF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJQq5JXF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768440658; x=1799976658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mX0rueHhtKwbsyf+pbcJ7kgqpNFg3hFLcOBtApN41Zg=;
  b=JJQq5JXFFqSa4vrhc8bBtUeRGYvTLmG4k2nfyR79GVvnA+y3OPQ1gF1Y
   dS7ahWnK3CnxvUSkcKcA/ZRw4/N3Iz9qeJpS+v27IhZvE8QSryP7eeGQK
   NCsihBmGKv0HTSj7cpBAwx1/56RDrCJact9FhSXXKzxVYqRInC93toQUP
   orbWhfMqgiTDHRRNhrWpl+qnjgH4wlHAGl0lu5zaRuqchRyDSFiCC4pE2
   3FMqUnMVDSnRiTMOPkv8AhhgrcIIMqpn9Q9Z48fwptuEzRwYi5V085iGF
   aXz8iehL/0NLKoRmrI+LHkMh+1e9mdIkQiqJpZZbdFdwR5sYsygkyC2Yd
   Q==;
X-CSE-ConnectionGUID: L2JWMM35SL2iGJbs2nzc4w==
X-CSE-MsgGUID: U+V4cvxpRV2eQ78iZo4ihw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="73601163"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="73601163"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 17:30:57 -0800
X-CSE-ConnectionGUID: tusOgR2aQ9uXc0zwpTjS/g==
X-CSE-MsgGUID: f/ZPVuj0QOq3udOCOf/JTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204448954"
Received: from unknown (HELO [10.238.4.29]) ([10.238.4.29])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 17:30:54 -0800
Message-ID: <f085c624-c548-4dfb-833f-3b628d937aa9@linux.intel.com>
Date: Thu, 15 Jan 2026 09:30:52 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf pmu intel: Adjust cpumaks for sub-NUMA clusters on
 Emeraldrapids
To: Chun-Tse Shao <ctshao@google.com>
Cc: Ian Rogers <irogers@google.com>, Thomas Falcon <thomas.falcon@intel.com>,
 linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, james.clark@linaro.org, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org
References: <20260108184430.1210223-1-ctshao@google.com>
 <CAP-5=fVLFVzitYZso2HB7dFgaNbJqW0pLE_AqMhc0ytW0PFvZw@mail.gmail.com>
 <CAJpZYjVadSgX6eSczFsqxJpMSq8q67CkA_WA+8jf+atgUScBNA@mail.gmail.com>
 <76406086-7175-43ac-90bc-3b268186ebbc@linux.intel.com>
 <CAJpZYjVREv324c7SXDK2m+Tb0FKXnWaAfYREetZTWZ05zo1HYw@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAJpZYjVREv324c7SXDK2m+Tb0FKXnWaAfYREetZTWZ05zo1HYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/15/2026 2:03 AM, Chun-Tse Shao wrote:
> Hi Dapeng,
>
> I set the SNC2 config to {0, 0, 1, 1} because that is how my EMR
> testing machine shows with SNC2 enabled. If that is true, I wonder if
> the SNC2 map for GNR is still {1, 1, 0, 0}.

Ok, let me find a GNR to double check it. (Maybe next week, I have some
higher priority things on my hand in this week). Thanks.


>
> Thanks,
> CT
>
> On Tue, Jan 13, 2026 at 4:42 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 1/14/2026 2:06 AM, Chun-Tse Shao wrote:
>>> Ping.
>>>
>>> Thanks for your comment, Ian. To Intel team, can we get confirmation
>>> of the GNR SNR2 configuration?
>> It seems you missed Ian's comments.
>>
>> I have same question with Ian, the snc map for uncore IMC is changed. It
>> may not change the total count of uncore_imc events, but it would change
>> the count of the uncore_imc events for a specific SNC node. What's the
>> reason you did the change?
>>
>> I have no GNR/EMR on my hand, I can't check how the SNC nodes are mapped on
>> these 2 machines.
>>
>>
>>> -CT
>>>
>>> On Thu, Jan 8, 2026 at 11:19 AM Ian Rogers <irogers@google.com> wrote:
>>>> On Thu, Jan 8, 2026 at 10:45 AM Chun-Tse Shao <ctshao@google.com> wrote:
>>>>> Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as well.
>>>>> Adjust cpumasks as the logic for GNR in [1].
>>>>>
>>>>> Tested on Emeraldrapids with SNC2 enabled:
>>>>>   $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a -- sleep 1
>>>>>
>>>>>    Performance counter stats for 'system wide':
>>>>>
>>>>>   N0       30        72125876670      UNC_CHA_CLOCKTICKS
>>>>>   N0        4         8815163648      UNC_M_CLOCKTICKS
>>>>>   N1       30        72124958844      UNC_CHA_CLOCKTICKS
>>>>>   N1        4         8815014974      UNC_M_CLOCKTICKS
>>>>>   N2       30        72121049022      UNC_CHA_CLOCKTICKS
>>>>>   N2        4         8814592626      UNC_M_CLOCKTICKS
>>>>>   N3       30        72117133854      UNC_CHA_CLOCKTICKS
>>>>>   N3        4         8814012840      UNC_M_CLOCKTICKS
>>>>>
>>>>>          1.001574118 seconds time elapsed
>>>>>
>>>>> [1] lore.kernel.org/20250515181417.491401-1-irogers@google.com
>>>>>
>>>>> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
>>>>> ---
>>>>>  tools/perf/arch/x86/util/pmu.c | 45 +++++++++++++++++++++-------------
>>>>>  1 file changed, 28 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
>>>>> index a3f96221758d..fad68a0f7b5d 100644
>>>>> --- a/tools/perf/arch/x86/util/pmu.c
>>>>> +++ b/tools/perf/arch/x86/util/pmu.c
>>>>> @@ -22,20 +22,29 @@
>>>>>  #include "util/env.h"
>>>>>  #include "util/header.h"
>>>>>
>>>>> -static bool x86__is_intel_graniterapids(void)
>>>>> +static bool x86__is_snc_supported(void)
>>>>>  {
>>>>> -       static bool checked_if_graniterapids;
>>>>> -       static bool is_graniterapids;
>>>>> +       static bool checked_if_snc_supported;
>>>>> +       static bool is_supported;
>>>>>
>>>>> -       if (!checked_if_graniterapids) {
>>>>> -               const char *graniterapids_cpuid = "GenuineIntel-6-A[DE]";
>>>>> +       if (!checked_if_snc_supported) {
>>>>> +
>>>>> +               /* Emeraldrapids and Graniterapids support SNC configuration. */
>>>>> +               static const char *const supported_cpuids[] = {
>>>>> +                       "GenuineIntel-6-CF", /* Emeraldrapids */
>>>>> +                       "GenuineIntel-6-A[DE]", /* Graniterapids */
>>>>> +               };
>>>>>                 char *cpuid = get_cpuid_str((struct perf_cpu){0});
>>>>>
>>>>> -               is_graniterapids = cpuid && strcmp_cpuid_str(graniterapids_cpuid, cpuid) == 0;
>>>>> +               for (size_t i = 0; i < ARRAY_SIZE(supported_cpuids); i++) {
>>>>> +                       is_supported = cpuid && strcmp_cpuid_str(supported_cpuids[i], cpuid) == 0;
>>>>> +                       if (is_supported)
>>>>> +                               break;
>>>>> +               }
>>>>>                 free(cpuid);
>>>>> -               checked_if_graniterapids = true;
>>>>> +               checked_if_snc_supported = true;
>>>>>         }
>>>>> -       return is_graniterapids;
>>>>> +       return checked_if_snc_supported;
>>>>>  }
>>>>>
>>>>>  static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
>>>>> @@ -64,6 +73,7 @@ static int snc_nodes_per_l3_cache(void)
>>>>>                         read_sysfs_cpu_map("devices/system/cpu/cpu0/cache/index3/shared_cpu_list");
>>>>>
>>>>>                 snc_nodes = perf_cpu_map__nr(cache_cpus) / perf_cpu_map__nr(node_cpus);
>>>>> +
>>>>>                 perf_cpu_map__put(cache_cpus);
>>>>>                 perf_cpu_map__put(node_cpus);
>>>>>                 checked_snc = true;
>>>>> @@ -137,8 +147,8 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>>>>>         // Compute the IMC SNC using lookup tables.
>>>>>         unsigned int imc_num;
>>>>>         int snc_nodes = snc_nodes_per_l3_cache();
>>>>> -       const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
>>>>> -       const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
>>>>> +       const u8 snc2_map[] = {0, 0, 1, 1};
>>>> Does this alter the behavior on GNR? ie 1,1,0,0 vs 0,0,1,1.
>>>>
>>>> Thanks,
>>>> Ian
>>>>
>>>>> +       const u8 snc3_map[] = {1, 1, 0, 0, 2, 2};
>>>>>         const u8 *snc_map;
>>>>>         size_t snc_map_len;
>>>>>
>>>>> @@ -161,11 +171,11 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>>>>>                 pr_warning("Unexpected: unable to compute IMC number '%s'\n", pmu->name);
>>>>>                 return 0;
>>>>>         }
>>>>> -       if (imc_num >= snc_map_len) {
>>>>> +       if (imc_num >= snc_map_len * perf_cpu_map__nr(pmu->cpus)) {
>>>>>                 pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_num, snc_nodes);
>>>>>                 return 0;
>>>>>         }
>>>>> -       return snc_map[imc_num];
>>>>> +       return snc_map[imc_num % snc_map_len];
>>>>>  }
>>>>>
>>>>>  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
>>>>> @@ -205,7 +215,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
>>>>>         return cpu_adjust[pmu_snc];
>>>>>  }
>>>>>
>>>>> -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
>>>>> +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
>>>>>  {
>>>>>         // With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
>>>>>         // topology. For example, a two socket graniterapids machine may be set
>>>>> @@ -304,11 +314,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>>>>>                                 pmu->mem_events = perf_mem_events_intel_aux;
>>>>>                         else
>>>>>                                 pmu->mem_events = perf_mem_events_intel;
>>>>> -               } else if (x86__is_intel_graniterapids()) {
>>>>> +               } else if (x86__is_snc_supported()) {
>>>>>                         if (starts_with(pmu->name, "uncore_cha_"))
>>>>> -                               gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
>>>>> -                       else if (starts_with(pmu->name, "uncore_imc_"))
>>>>> -                               gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
>>>>> +                               uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
>>>>> +                       else if (starts_with(pmu->name, "uncore_imc_") &&
>>>>> +                                !starts_with(pmu->name, "uncore_imc_free_running"))
>>>>> +                               uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
>>>>>                 }
>>>>>         }
>>>>>  }
>>>>> --
>>>>> 2.52.0.457.g6b5491de43-goog
>>>>>
