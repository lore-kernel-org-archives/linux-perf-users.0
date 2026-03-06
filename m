Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31841189BB6;
	Fri,  6 Mar 2026 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772761090; cv=none; b=PCOpDL30+OvF9armoPR5iUGEFU1IrAP2CFn94X8NF4WbPrh/oYTibwP0QRCus7sd/fhJxxveNvo8cUszJBZhY5QTZCLdNDDa+Ds0vRErMkhrpb3QsdXQ4TGeXPWlx4cUPP0FDwrcHEbdI8yiSvATMtDLfBv9wcS2B4Owp8vXNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772761090; c=relaxed/simple;
	bh=qk2HFdAJtxRppAk0WV+jWgFUmuZGp/Ht/9pBzgQlg1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2TfAGjhUvZTI0Hn+MdETjvxLt82twre0snjKL1Vb3PvJBnDd+onFzfXQGq1YaoUk+RKuffOm0c2GJ24k5NbatM9I8AUe2l+oA9mW6q05iHAkXnC8I5W7vQZbzDa7oZC3zS0+MT/5sQEV3MDPF1h76v3feTxErJvoj2m08mCZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nS6/eaw/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nS6/eaw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772761088; x=1804297088;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qk2HFdAJtxRppAk0WV+jWgFUmuZGp/Ht/9pBzgQlg1I=;
  b=nS6/eaw/UBHrcIKzzjXqCdekIhuh+61RYSo0RUiXpsfOJtc4ZoYAL3Iw
   gxHteq9o0VlDPHUBokoXBWci597iz1Fv5RhddYGffnAqnIocJlJ1Wq3Um
   hBqKXCP1bBRGG/6BbH2lWiCCYgrUW+iz+TVnxctrZlrSa+MDz5Tf3Sw6f
   EJC/fEzqtxuJNkeDPtIZ+XA2ANijdSyEjH4vGdPdnDuBVui8u7ERCVKka
   Tbwg8GUxofVNYJuAUL4h7jUh/iCG9MQAQx5hw+4sdZhjyorLuvvm3x6xQ
   LEWLm/oKnkGkPtGcjCoYrnMGHMNex99nOiIAnwAAitD4tfb3hCUTCr3fa
   g==;
X-CSE-ConnectionGUID: 5+f36hpmQMaZzh8O1iYcHw==
X-CSE-MsgGUID: WaR8CAPZQLOjj5tVlzUYxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="74054345"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="74054345"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 17:38:07 -0800
X-CSE-ConnectionGUID: EgE7w3XGSUWEO37aLiOQug==
X-CSE-MsgGUID: 7ObsCEIdQDyTEYe0KULqPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223000173"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 17:38:03 -0800
Message-ID: <90c14d06-afe8-40e3-a26b-0f85cb2fbd69@linux.intel.com>
Date: Fri, 6 Mar 2026 09:38:00 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 05/12] perf/x86/intel: Initialize architectural PEBS
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-6-dapeng1.mi@linux.intel.com>
 <CAP-5=fUjCy7ENFx+n3mRHuDKPBg2E3pYqe-E2OZ9X2wHWHOj1g@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fUjCy7ENFx+n3mRHuDKPBg2E3pYqe-E2OZ9X2wHWHOj1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/5/2026 8:50 AM, Ian Rogers wrote:
> On Wed, Oct 29, 2025 at 3:24 AM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> arch-PEBS leverages CPUID.23H.4/5 sub-leaves enumerate arch-PEBS
>> supported capabilities and counters bitmap. This patch parses these 2
>> sub-leaves and initializes arch-PEBS capabilities and corresponding
>> structures.
>>
>> Since IA32_PEBS_ENABLE and MSR_PEBS_DATA_CFG MSRs are no longer existed
>> for arch-PEBS, arch-PEBS doesn't need to manipulate these MSRs. Thus add
>> a simple pair of __intel_pmu_pebs_enable/disable() callbacks for
>> arch-PEBS.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/core.c            | 21 ++++++++---
>>  arch/x86/events/intel/core.c      | 60 ++++++++++++++++++++++---------
>>  arch/x86/events/intel/ds.c        | 52 ++++++++++++++++++++++-----
>>  arch/x86/events/perf_event.h      | 25 +++++++++++--
>>  arch/x86/include/asm/perf_event.h |  7 +++-
>>  5 files changed, 132 insertions(+), 33 deletions(-)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 74479f9d6eed..f2402ae3ffa0 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -554,14 +554,22 @@ static inline int precise_br_compat(struct perf_event *event)
>>         return m == b;
>>  }
>>
>> -int x86_pmu_max_precise(void)
>> +int x86_pmu_max_precise(struct pmu *pmu)
>>  {
>>         int precise = 0;
>>
>> -       /* Support for constant skid */
>>         if (x86_pmu.pebs_active && !x86_pmu.pebs_broken) {
>> -               precise++;
>> +               /* arch PEBS */
>> +               if (x86_pmu.arch_pebs) {
>> +                       precise = 2;
>> +                       if (hybrid(pmu, arch_pebs_cap).pdists)
>> +                               precise++;
>> +
>> +                       return precise;
>> +               }
>>
>> +               /* legacy PEBS - support for constant skid */
>> +               precise++;
>>                 /* Support for IP fixup */
>>                 if (x86_pmu.lbr_nr || x86_pmu.intel_cap.pebs_format >= 2)
>>                         precise++;
>> @@ -569,13 +577,14 @@ int x86_pmu_max_precise(void)
>>                 if (x86_pmu.pebs_prec_dist)
>>                         precise++;
>>         }
>> +
>>         return precise;
>>  }
>>
>>  int x86_pmu_hw_config(struct perf_event *event)
>>  {
>>         if (event->attr.precise_ip) {
>> -               int precise = x86_pmu_max_precise();
>> +               int precise = x86_pmu_max_precise(event->pmu);
>>
>>                 if (event->attr.precise_ip > precise)
>>                         return -EOPNOTSUPP;
>> @@ -2630,7 +2639,9 @@ static ssize_t max_precise_show(struct device *cdev,
>>                                   struct device_attribute *attr,
>>                                   char *buf)
>>  {
>> -       return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise());
>> +       struct pmu *pmu = dev_get_drvdata(cdev);
>> +
>> +       return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise(pmu));
>>  }
>>
>>  static DEVICE_ATTR_RO(max_precise);
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index c88bcd5d2bc4..9ce27b326923 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -5271,34 +5271,59 @@ static inline bool intel_pmu_broken_perf_cap(void)
>>         return false;
>>  }
>>
>> +#define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
>> +
>>  static void update_pmu_cap(struct pmu *pmu)
>>  {
>> -       unsigned int cntr, fixed_cntr, ecx, edx;
>> -       union cpuid35_eax eax;
>> -       union cpuid35_ebx ebx;
>> +       unsigned int eax, ebx, ecx, edx;
>> +       union cpuid35_eax eax_0;
>> +       union cpuid35_ebx ebx_0;
>> +       u64 cntrs_mask = 0;
>> +       u64 pebs_mask = 0;
>> +       u64 pdists_mask = 0;
>>
>> -       cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
>> +       cpuid(ARCH_PERFMON_EXT_LEAF, &eax_0.full, &ebx_0.full, &ecx, &edx);
>>
>> -       if (ebx.split.umask2)
>> +       if (ebx_0.split.umask2)
>>                 hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_UMASK2;
>> -       if (ebx.split.eq)
>> +       if (ebx_0.split.eq)
>>                 hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_EQ;
>>
>> -       if (eax.split.cntr_subleaf) {
>> +       if (eax_0.split.cntr_subleaf) {
>>                 cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
>> -                           &cntr, &fixed_cntr, &ecx, &edx);
>> -               hybrid(pmu, cntr_mask64) = cntr;
>> -               hybrid(pmu, fixed_cntr_mask64) = fixed_cntr;
>> +                           &eax, &ebx, &ecx, &edx);
>> +               hybrid(pmu, cntr_mask64) = eax;
>> +               hybrid(pmu, fixed_cntr_mask64) = ebx;
>> +               cntrs_mask = counter_mask(eax, ebx);
>>         }
>>
>> -       if (eax.split.acr_subleaf) {
>> +       if (eax_0.split.acr_subleaf) {
>>                 cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
>> -                           &cntr, &fixed_cntr, &ecx, &edx);
>> +                           &eax, &ebx, &ecx, &edx);
>>                 /* The mask of the counters which can be reloaded */
>> -               hybrid(pmu, acr_cntr_mask64) = cntr | ((u64)fixed_cntr << INTEL_PMC_IDX_FIXED);
>> -
>> +               hybrid(pmu, acr_cntr_mask64) = counter_mask(eax, ebx);
>>                 /* The mask of the counters which can cause a reload of reloadable counters */
>> -               hybrid(pmu, acr_cause_mask64) = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
>> +               hybrid(pmu, acr_cause_mask64) = counter_mask(ecx, edx);
>> +       }
>> +
>> +       /* Bits[5:4] should be set simultaneously if arch-PEBS is supported */
>> +       if (eax_0.split.pebs_caps_subleaf && eax_0.split.pebs_cnts_subleaf) {
>> +               cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_CAP_LEAF,
>> +                           &eax, &ebx, &ecx, &edx);
>> +               hybrid(pmu, arch_pebs_cap).caps = (u64)ebx << 32;
> nit: It seems strange to use a u64 for caps but only use the top 32
> bits. Did you intend to use the low 32-bits for eax?

The intent of right shifting the caps 32 bits is to ensure there are same
layout for the caps with XXX_CFG_C MSR and PEBS record format which put the
caps field on the higher 32 bits. Then it would be easy and unified to
manipulate the caps filed in these 3 places. Thanks.


>
> Thanks,
> Ian
>
>> +
>> +               cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_COUNTER_LEAF,
>> +                           &eax, &ebx, &ecx, &edx);
>> +               pebs_mask   = counter_mask(eax, ecx);
>> +               pdists_mask = counter_mask(ebx, edx);
>> +               hybrid(pmu, arch_pebs_cap).counters = pebs_mask;
>> +               hybrid(pmu, arch_pebs_cap).pdists = pdists_mask;
>> +
>> +               if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask))
>> +                       x86_pmu.arch_pebs = 0;
>> +       } else {
>> +               WARN_ON(x86_pmu.arch_pebs == 1);
>> +               x86_pmu.arch_pebs = 0;
>>         }
>>
>>         if (!intel_pmu_broken_perf_cap()) {
>> @@ -6252,7 +6277,7 @@ tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>>  static umode_t
>>  pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>>  {
>> -       return x86_pmu.ds_pebs ? attr->mode : 0;
>> +       return intel_pmu_has_pebs() ? attr->mode : 0;
>>  }
>>
>>  static umode_t
>> @@ -7728,6 +7753,9 @@ __init int intel_pmu_init(void)
>>         if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
>>                 update_pmu_cap(NULL);
>>
>> +       if (x86_pmu.arch_pebs)
>> +               pr_cont("Architectural PEBS, ");
>> +
>>         intel_pmu_check_counters_mask(&x86_pmu.cntr_mask64,
>>                                       &x86_pmu.fixed_cntr_mask64,
>>                                       &x86_pmu.intel_ctrl);
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index c0b7ac1c7594..26e485eca0a0 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1531,6 +1531,15 @@ static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc)
>>                 intel_pmu_drain_pebs_buffer();
>>  }
>>
>> +static void __intel_pmu_pebs_enable(struct perf_event *event)
>> +{
>> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +       struct hw_perf_event *hwc = &event->hw;
>> +
>> +       hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
>> +       cpuc->pebs_enabled |= 1ULL << hwc->idx;
>> +}
>> +
>>  void intel_pmu_pebs_enable(struct perf_event *event)
>>  {
>>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> @@ -1539,9 +1548,7 @@ void intel_pmu_pebs_enable(struct perf_event *event)
>>         struct debug_store *ds = cpuc->ds;
>>         unsigned int idx = hwc->idx;
>>
>> -       hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
>> -
>> -       cpuc->pebs_enabled |= 1ULL << hwc->idx;
>> +       __intel_pmu_pebs_enable(event);
>>
>>         if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.version < 5))
>>                 cpuc->pebs_enabled |= 1ULL << (hwc->idx + 32);
>> @@ -1603,14 +1610,22 @@ void intel_pmu_pebs_del(struct perf_event *event)
>>         pebs_update_state(needed_cb, cpuc, event, false);
>>  }
>>
>> -void intel_pmu_pebs_disable(struct perf_event *event)
>> +static void __intel_pmu_pebs_disable(struct perf_event *event)
>>  {
>>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>         struct hw_perf_event *hwc = &event->hw;
>>
>>         intel_pmu_drain_large_pebs(cpuc);
>> -
>>         cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
>> +       hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
>> +}
>> +
>> +void intel_pmu_pebs_disable(struct perf_event *event)
>> +{
>> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +       struct hw_perf_event *hwc = &event->hw;
>> +
>> +       __intel_pmu_pebs_disable(event);
>>
>>         if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) &&
>>             (x86_pmu.version < 5))
>> @@ -1622,8 +1637,6 @@ void intel_pmu_pebs_disable(struct perf_event *event)
>>
>>         if (cpuc->enabled)
>>                 wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>> -
>> -       hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
>>  }
>>
>>  void intel_pmu_pebs_enable_all(void)
>> @@ -2669,11 +2682,26 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>>         }
>>  }
>>
>> +static void __init intel_arch_pebs_init(void)
>> +{
>> +       /*
>> +        * Current hybrid platforms always both support arch-PEBS or not
>> +        * on all kinds of cores. So directly set x86_pmu.arch_pebs flag
>> +        * if boot cpu supports arch-PEBS.
>> +        */
>> +       x86_pmu.arch_pebs = 1;
>> +       x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
>> +       x86_pmu.pebs_capable = ~0ULL;
>> +
>> +       x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
>> +       x86_pmu.pebs_disable = __intel_pmu_pebs_disable;
>> +}
>> +
>>  /*
>>   * PEBS probe and setup
>>   */
>>
>> -void __init intel_pebs_init(void)
>> +static void __init intel_ds_pebs_init(void)
>>  {
>>         /*
>>          * No support for 32bit formats
>> @@ -2788,6 +2816,14 @@ void __init intel_pebs_init(void)
>>         }
>>  }
>>
>> +void __init intel_pebs_init(void)
>> +{
>> +       if (x86_pmu.intel_cap.pebs_format == 0xf)
>> +               intel_arch_pebs_init();
>> +       else
>> +               intel_ds_pebs_init();
>> +}
>> +
>>  void perf_restore_debug_store(void)
>>  {
>>         struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index 285779c73479..ca5289980b52 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -708,6 +708,12 @@ enum hybrid_pmu_type {
>>         hybrid_big_small_tiny   = hybrid_big   | hybrid_small_tiny,
>>  };
>>
>> +struct arch_pebs_cap {
>> +       u64 caps;
>> +       u64 counters;
>> +       u64 pdists;
>> +};
>> +
>>  struct x86_hybrid_pmu {
>>         struct pmu                      pmu;
>>         const char                      *name;
>> @@ -752,6 +758,8 @@ struct x86_hybrid_pmu {
>>                                         mid_ack         :1,
>>                                         enabled_ack     :1;
>>
>> +       struct arch_pebs_cap            arch_pebs_cap;
>> +
>>         u64                             pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX];
>>  };
>>
>> @@ -906,7 +914,7 @@ struct x86_pmu {
>>         union perf_capabilities intel_cap;
>>
>>         /*
>> -        * Intel DebugStore bits
>> +        * Intel DebugStore and PEBS bits
>>          */
>>         unsigned int    bts                     :1,
>>                         bts_active              :1,
>> @@ -917,7 +925,8 @@ struct x86_pmu {
>>                         pebs_no_tlb             :1,
>>                         pebs_no_isolation       :1,
>>                         pebs_block              :1,
>> -                       pebs_ept                :1;
>> +                       pebs_ept                :1,
>> +                       arch_pebs               :1;
>>         int             pebs_record_size;
>>         int             pebs_buffer_size;
>>         u64             pebs_events_mask;
>> @@ -929,6 +938,11 @@ struct x86_pmu {
>>         u64             rtm_abort_event;
>>         u64             pebs_capable;
>>
>> +       /*
>> +        * Intel Architectural PEBS
>> +        */
>> +       struct arch_pebs_cap arch_pebs_cap;
>> +
>>         /*
>>          * Intel LBR
>>          */
>> @@ -1216,7 +1230,7 @@ int x86_reserve_hardware(void);
>>
>>  void x86_release_hardware(void);
>>
>> -int x86_pmu_max_precise(void);
>> +int x86_pmu_max_precise(struct pmu *pmu);
>>
>>  void hw_perf_lbr_event_destroy(struct perf_event *event);
>>
>> @@ -1791,6 +1805,11 @@ static inline int intel_pmu_max_num_pebs(struct pmu *pmu)
>>         return fls((u32)hybrid(pmu, pebs_events_mask));
>>  }
>>
>> +static inline bool intel_pmu_has_pebs(void)
>> +{
>> +       return x86_pmu.ds_pebs || x86_pmu.arch_pebs;
>> +}
>> +
>>  #else /* CONFIG_CPU_SUP_INTEL */
>>
>>  static inline void reserve_ds_buffers(void)
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index 49a4d442f3fc..0dfa06722bab 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -200,6 +200,8 @@ union cpuid10_edx {
>>  #define ARCH_PERFMON_EXT_LEAF                  0x00000023
>>  #define ARCH_PERFMON_NUM_COUNTER_LEAF          0x1
>>  #define ARCH_PERFMON_ACR_LEAF                  0x2
>> +#define ARCH_PERFMON_PEBS_CAP_LEAF             0x4
>> +#define ARCH_PERFMON_PEBS_COUNTER_LEAF         0x5
>>
>>  union cpuid35_eax {
>>         struct {
>> @@ -210,7 +212,10 @@ union cpuid35_eax {
>>                 unsigned int    acr_subleaf:1;
>>                 /* Events Sub-Leaf */
>>                 unsigned int    events_subleaf:1;
>> -               unsigned int    reserved:28;
>> +               /* arch-PEBS Sub-Leaves */
>> +               unsigned int    pebs_caps_subleaf:1;
>> +               unsigned int    pebs_cnts_subleaf:1;
>> +               unsigned int    reserved:26;
>>         } split;
>>         unsigned int            full;
>>  };
>> --
>> 2.34.1
>>
