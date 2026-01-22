Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569A7318EC7;
	Thu, 22 Jan 2026 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119573; cv=none; b=ljwOERZPMuhIfN6ly9KrcI6U2Ue3+l7cxdaBgwa2FItSLjq4h4PQzwwMFJb2PesGB//jHgbk1jCCsgfK8WtYk9fG5gw3KhvmnBslePHAP7xFbPeVrvklecH+1YdUoWVgQKw+JHn62QN+yKvssAJ9Hh5pw2plhVALGbwScbvLWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119573; c=relaxed/simple;
	bh=XLQ207RzpjLgzT6s4k7mCdSrhqOpym2zeO3tPa79YhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwzPhKqs/BXngtDVvI7vTLDyIkmtz+njw+loD/j3j6Npd14bskHbDAQw8r9vDhM7iaycI2j6asbvJwPLj7qR6tFjBJMIyhY7v4lPYkFUNq/ukgAfgpCu6z2eFINteBNq5fj/3QUnc7yFnsEu5oJJ1VitjL+7VpYYwV4UfbVHSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2j3/tzD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2j3/tzD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769119568; x=1800655568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XLQ207RzpjLgzT6s4k7mCdSrhqOpym2zeO3tPa79YhM=;
  b=Q2j3/tzDRaVALQoKFgUktpppacyNu5gurCqehCiK2S7CjhvOfazWsb5M
   deu7VG//AX4RudfgB16q+CrsnyCOfijQoV9rHwODT0bhyLwJDmsHaZEY4
   EdIcZ8Y6i+2nT+q54E0pOt4MnBJumDDsMHJeJLTve7n2TJKhgxF/XKnRU
   VT/8DYBuFVgaYjLjvU8wwz+6xISYsQDO7jLqGp5WY0BHiWrBNc1fJP7b4
   Zb+8F/ZOLK9Y1vv1O+azaYk6D7ANrRGd/XFWIKAzciSqHbxheOXfU1TIk
   cJz3DRA918HypkdZMK3mUSngmwAv9pPA3saSgqv3MsReGiAF5z//O+1fk
   Q==;
X-CSE-ConnectionGUID: 6X7q/tjlR1Sd+/0Ng9djSA==
X-CSE-MsgGUID: D0HmSJhQRvO7DccVmRpaYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="87787564"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="87787564"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 14:06:04 -0800
X-CSE-ConnectionGUID: b5tZZU4HR3eXnv8B7uGNcg==
X-CSE-MsgGUID: YAzSUFBFROCoTLX2fhk/Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206115510"
Received: from unknown (HELO [10.241.241.119]) ([10.241.241.119])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 14:06:04 -0800
Message-ID: <85202bc5-4b50-458c-8ef8-be4d22e9d939@intel.com>
Date: Thu, 22 Jan 2026 14:06:03 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf pmu intel: Adjust cpumaks for sub-NUMA clusters on
 Emeraldrapids
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, james.clark@linaro.org, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org
References: <20260108184430.1210223-1-ctshao@google.com>
 <CAP-5=fVLFVzitYZso2HB7dFgaNbJqW0pLE_AqMhc0ytW0PFvZw@mail.gmail.com>
 <CAJpZYjVadSgX6eSczFsqxJpMSq8q67CkA_WA+8jf+atgUScBNA@mail.gmail.com>
 <09ff8b36-eb35-425d-b36c-d33237f2623a@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <09ff8b36-eb35-425d-b36c-d33237f2623a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/18/2026 4:51 PM, Mi, Dapeng wrote:
> 
> On 1/14/2026 2:06 AM, Chun-Tse Shao wrote:
>> Ping.
>>
>> Thanks for your comment, Ian. To Intel team, can we get confirmation
>> of the GNR SNR2 configuration?
>>
>> -CT
>>
>> On Thu, Jan 8, 2026 at 11:19 AM Ian Rogers <irogers@google.com> wrote:
>>> On Thu, Jan 8, 2026 at 10:45 AM Chun-Tse Shao <ctshao@google.com> wrote:
>>>> Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as well.
>>>> Adjust cpumasks as the logic for GNR in [1].
>>>>
>>>> Tested on Emeraldrapids with SNC2 enabled:
>>>>   $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a -- sleep 1
>>>>
>>>>    Performance counter stats for 'system wide':
>>>>
>>>>   N0       30        72125876670      UNC_CHA_CLOCKTICKS
>>>>   N0        4         8815163648      UNC_M_CLOCKTICKS
>>>>   N1       30        72124958844      UNC_CHA_CLOCKTICKS
>>>>   N1        4         8815014974      UNC_M_CLOCKTICKS
>>>>   N2       30        72121049022      UNC_CHA_CLOCKTICKS
>>>>   N2        4         8814592626      UNC_M_CLOCKTICKS
>>>>   N3       30        72117133854      UNC_CHA_CLOCKTICKS
>>>>   N3        4         8814012840      UNC_M_CLOCKTICKS
>>>>
>>>>          1.001574118 seconds time elapsed
>>>>
>>>> [1] lore.kernel.org/20250515181417.491401-1-irogers@google.com
>>>>
>>>> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
>>>> ---
>>>>  tools/perf/arch/x86/util/pmu.c | 45 +++++++++++++++++++++-------------
>>>>  1 file changed, 28 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
>>>> index a3f96221758d..fad68a0f7b5d 100644
>>>> --- a/tools/perf/arch/x86/util/pmu.c
>>>> +++ b/tools/perf/arch/x86/util/pmu.c
>>>> @@ -22,20 +22,29 @@
>>>>  #include "util/env.h"
>>>>  #include "util/header.h"
>>>>
>>>> -static bool x86__is_intel_graniterapids(void)
>>>> +static bool x86__is_snc_supported(void)
>>>>  {
>>>> -       static bool checked_if_graniterapids;
>>>> -       static bool is_graniterapids;
>>>> +       static bool checked_if_snc_supported;
>>>> +       static bool is_supported;
>>>>
>>>> -       if (!checked_if_graniterapids) {
>>>> -               const char *graniterapids_cpuid = "GenuineIntel-6-A[DE]";
>>>> +       if (!checked_if_snc_supported) {
>>>> +
>>>> +               /* Emeraldrapids and Graniterapids support SNC configuration. */
>>>> +               static const char *const supported_cpuids[] = {
>>>> +                       "GenuineIntel-6-CF", /* Emeraldrapids */
>>>> +                       "GenuineIntel-6-A[DE]", /* Graniterapids */
>>>> +               };
>>>>                 char *cpuid = get_cpuid_str((struct perf_cpu){0});
>>>>
>>>> -               is_graniterapids = cpuid && strcmp_cpuid_str(graniterapids_cpuid, cpuid) == 0;
>>>> +               for (size_t i = 0; i < ARRAY_SIZE(supported_cpuids); i++) {
>>>> +                       is_supported = cpuid && strcmp_cpuid_str(supported_cpuids[i], cpuid) == 0;
>>>> +                       if (is_supported)
>>>> +                               break;
>>>> +               }
>>>>                 free(cpuid);
>>>> -               checked_if_graniterapids = true;
>>>> +               checked_if_snc_supported = true;
>>>>         }
>>>> -       return is_graniterapids;
>>>> +       return checked_if_snc_supported;
>>>>  }
>>>>
>>>>  static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
>>>> @@ -64,6 +73,7 @@ static int snc_nodes_per_l3_cache(void)
>>>>                         read_sysfs_cpu_map("devices/system/cpu/cpu0/cache/index3/shared_cpu_list");
>>>>
>>>>                 snc_nodes = perf_cpu_map__nr(cache_cpus) / perf_cpu_map__nr(node_cpus);
>>>> +
>>>>                 perf_cpu_map__put(cache_cpus);
>>>>                 perf_cpu_map__put(node_cpus);
>>>>                 checked_snc = true;
>>>> @@ -137,8 +147,8 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>>>>         // Compute the IMC SNC using lookup tables.
>>>>         unsigned int imc_num;
>>>>         int snc_nodes = snc_nodes_per_l3_cache();
>>>> -       const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
>>>> -       const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
>>>> +       const u8 snc2_map[] = {0, 0, 1, 1};
>>> Does this alter the behavior on GNR? ie 1,1,0,0 vs 0,0,1,1.

It appears to break GNR SNC2. While it works for the --per-node test, it
fails the following affinity test. Testing on EMR shows that it follows
the new lookup table. Should we use a model-specific lookup table here?

# Running workload on CPU0
$ taskset -c CPU0 stress-ng --vm 1 --vm-bytes 2G --vm-method all
--timeout 30s

# Profiling UNC_M_PRE_COUNT.ALL on all IMC boxes.
$ perf stat \
        -e uncore_imc_0/event=0x03,umask=0xFF/ \
        -e uncore_imc_1/event=0x03,umask=0xFF/ \
        -e uncore_imc_2/event=0x03,umask=0xFF/ \
        -e uncore_imc_3/event=0x03,umask=0xFF/ \
        -e uncore_imc_4/event=0x03,umask=0xFF/ \
        -e uncore_imc_5/event=0x03,umask=0xFF/ \
        -e uncore_imc_6/event=0x03,umask=0xFF/ \
        -e uncore_imc_7/event=0x03,umask=0xFF/ \
        -a -I 1000

This shows that the uncore_imc_[2|3|6|7] boxes are affinitized to CPU0.

     5.013638757          1,635,470      uncore_imc_0/event=0x03,umask=0xFF/
     5.013638757          1,638,157      uncore_imc_1/event=0x03,umask=0xFF/
     5.013638757         27,093,922      uncore_imc_2/event=0x03,umask=0xFF/
     5.013638757         27,025,980      uncore_imc_3/event=0x03,umask=0xFF/
     5.013638757          1,616,974      uncore_imc_4/event=0x03,umask=0xFF/
     5.013638757          1,627,251      uncore_imc_5/event=0x03,umask=0xFF/
     5.013638757         26,854,588      uncore_imc_6/event=0x03,umask=0xFF/
     5.013638757         26,974,506      uncore_imc_7/event=0x03,umask=0xFF/

Testing with additional CPUs confirms that the original GNR SNC2 lookup
table is correct.

                        CPU                     uncore_imc box
NUMA node0 CPU(s):      0-42,344-386            2 3 6 7
NUMA node1 CPU(s):      43-85,387-429           0 1 4 5
NUMA node2 CPU(s):      86-128,430-472          2 3 6 7
NUMA node3 CPU(s):      129-171,473-515         0 1 4 5
NUMA node4 CPU(s):      172-214,516-558         2 3 6 7
NUMA node5 CPU(s):      215-257,559-601         0 1 4 5
NUMA node6 CPU(s):      258-300,602-644         2 3 6 7
NUMA node7 CPU(s):      301-343,645-687         0 1 4 5


>>> Thanks,
>>> Ian
>>>
>>>> +       const u8 snc3_map[] = {1, 1, 0, 0, 2, 2};
>>>>         const u8 *snc_map;
>>>>         size_t snc_map_len;
>>>>
>>>> @@ -161,11 +171,11 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>>>>                 pr_warning("Unexpected: unable to compute IMC number '%s'\n", pmu->name);
>>>>                 return 0;
>>>>         }
>>>> -       if (imc_num >= snc_map_len) {
>>>> +       if (imc_num >= snc_map_len * perf_cpu_map__nr(pmu->cpus)) {
>>>>                 pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_num, snc_nodes);
>>>>                 return 0;
>>>>         }
>>>> -       return snc_map[imc_num];
>>>> +       return snc_map[imc_num % snc_map_len];
>>>>  }
>>>>
>>>>  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
>>>> @@ -205,7 +215,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
>>>>         return cpu_adjust[pmu_snc];
>>>>  }
>>>>
>>>> -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
>>>> +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
>>>>  {
>>>>         // With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
>>>>         // topology. For example, a two socket graniterapids machine may be set
>>>> @@ -304,11 +314,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>>>>                                 pmu->mem_events = perf_mem_events_intel_aux;
>>>>                         else
>>>>                                 pmu->mem_events = perf_mem_events_intel;
>>>> -               } else if (x86__is_intel_graniterapids()) {
>>>> +               } else if (x86__is_snc_supported()) {
>>>>                         if (starts_with(pmu->name, "uncore_cha_"))
>>>> -                               gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
>>>> -                       else if (starts_with(pmu->name, "uncore_imc_"))
>>>> -                               gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
>>>> +                               uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
>>>> +                       else if (starts_with(pmu->name, "uncore_imc_") &&
>>>> +                                !starts_with(pmu->name, "uncore_imc_free_running"))
>>>> +                               uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
>>>>                 }
>>>>         }
>>>>  }
>>>> --
>>>> 2.52.0.457.g6b5491de43-goog
>>>>

