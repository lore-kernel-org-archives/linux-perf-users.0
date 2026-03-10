Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602A2C15BA;
	Tue, 10 Mar 2026 02:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108399; cv=none; b=Pr5GLpWdeXz1PxeTUUuFTLj5R701De+z83C6qH7/Er9pvGDn5zE0H4WxregAGDMrvpfh/YwRdHlrtll2wXRl1ga2KqqjTRXuw8a5NCr/RJMIwC2/r0INOpvEbEY54lbHzPY4H1Z1W7Veq96NpFahoBhalkvudy6klpavMWvwOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108399; c=relaxed/simple;
	bh=VXC/JLoBIpugjm4pYZ6DdFlb6py/g+Rh5bbyrDoLtTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhUFjAHT8o0V0VcekYo06wyOeJDpd3xOPovUQbjnzBZff8GUHocmvhBdA/ZOZAKD3YYa9D4/nQlMxIufL1ksEcVLNbgj0vQIiIAuCFDrgEHlpKHlYmnhouqDVDtmOnMOMGRxHYsoh/zoVBfrRe80Ry1w+WaYsf77MCcNbf10QVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQXvKn/H; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQXvKn/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773108395; x=1804644395;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VXC/JLoBIpugjm4pYZ6DdFlb6py/g+Rh5bbyrDoLtTY=;
  b=OQXvKn/HxGqNUR41rUyZ5fN632kSkfdY2CvAzdw9TJ1wjBcFh8ifDBVd
   eSc7rx6KwgvqWJtZUYEptCxRWqpcnJJa7CzQjlXcn6RsxZfO/Ry+j2gvF
   VJBAphGbbjgrxPIxSs0dHseGRbWj1P+hgIsRTHsMdzW8O4kFU17DX+ddv
   MCooGJ04efV3RgwZ40aCAPm00hncyf9Lqrfk0Cyy6lJCqhc6gC/lMFmas
   dYPsPl90+uU553SK0doQEvwjsNypG8D4ODziRzcXvZflrwaRiHdTLJQc5
   3KZUURhtDoxDykAvJILYLT6UmN6DjbT+szFjTsYwJ5eXl+gXHcoZWiox6
   g==;
X-CSE-ConnectionGUID: DjdNXIAvStG6fCQRuCWspA==
X-CSE-MsgGUID: w0TA7FH9QnOa/tKlBiIfRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="91531390"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="91531390"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 19:06:34 -0700
X-CSE-ConnectionGUID: +aJhL914RS6GbIGXELDT/A==
X-CSE-MsgGUID: 6YMQklUYQLaCKPy13uGTiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="224055404"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 19:06:32 -0700
Message-ID: <0e6df3b8-d9c7-4b0e-99d4-eb5dd73a5a5e@linux.intel.com>
Date: Tue, 10 Mar 2026 10:06:28 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 12/12] perf/x86/intel: Add counter group support for
 arch-PEBS
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
 <20251029102136.61364-13-dapeng1.mi@linux.intel.com>
 <CAP-5=fUDfgSC9CcJWg9CpKQo4aTdFbD89_XcmVX8OivRLoEAcA@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fUDfgSC9CcJWg9CpKQo4aTdFbD89_XcmVX8OivRLoEAcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/10/2026 6:59 AM, Ian Rogers wrote:
> On Wed, Oct 29, 2025 at 3:25 AM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> Base on previous adaptive PEBS counter snapshot support, add counter
>> group support for architectural PEBS. Since arch-PEBS shares same
>> counter group layout with adaptive PEBS, directly reuse
>> __setup_pebs_counter_group() helper to process arch-PEBS counter group.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c      | 38 ++++++++++++++++++++++++++++---
>>  arch/x86/events/intel/ds.c        | 29 ++++++++++++++++++++---
>>  arch/x86/include/asm/msr-index.h  |  6 +++++
>>  arch/x86/include/asm/perf_event.h | 13 ++++++++---
>>  4 files changed, 77 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 75cba28b86d5..cb64018321dd 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3014,6 +3014,17 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
>>
>>                         if (pebs_data_cfg & PEBS_DATACFG_LBRS)
>>                                 ext |= ARCH_PEBS_LBR & cap.caps;
>> +
>> +                       if (pebs_data_cfg &
>> +                           (PEBS_DATACFG_CNTR_MASK << PEBS_DATACFG_CNTR_SHIFT))
>> +                               ext |= ARCH_PEBS_CNTR_GP & cap.caps;
>> +
>> +                       if (pebs_data_cfg &
>> +                           (PEBS_DATACFG_FIX_MASK << PEBS_DATACFG_FIX_SHIFT))
>> +                               ext |= ARCH_PEBS_CNTR_FIXED & cap.caps;
>> +
>> +                       if (pebs_data_cfg & PEBS_DATACFG_METRICS)
>> +                               ext |= ARCH_PEBS_CNTR_METRICS & cap.caps;
>>                 }
>>
>>                 if (cpuc->n_pebs == cpuc->n_large_pebs)
>> @@ -3038,6 +3049,9 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
>>                 }
>>         }
>>
>> +       if (is_pebs_counter_event_group(event))
>> +               ext |= ARCH_PEBS_CNTR_ALLOW;
>> +
>>         if (cpuc->cfg_c_val[hwc->idx] != ext)
>>                 __intel_pmu_update_event_ext(hwc->idx, ext);
>>  }
>> @@ -4323,6 +4337,20 @@ static bool intel_pmu_is_acr_group(struct perf_event *event)
>>         return false;
>>  }
>>
>> +static inline bool intel_pmu_has_pebs_counter_group(struct pmu *pmu)
>> +{
>> +       u64 caps;
>> +
>> +       if (x86_pmu.intel_cap.pebs_format >= 6 && x86_pmu.intel_cap.pebs_baseline)
>> +               return true;
>> +
>> +       caps = hybrid(pmu, arch_pebs_cap).caps;
>> +       if (x86_pmu.arch_pebs && (caps & ARCH_PEBS_CNTR_MASK))
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>>  static inline void intel_pmu_set_acr_cntr_constr(struct perf_event *event,
>>                                                  u64 *cause_mask, int *num)
>>  {
>> @@ -4471,8 +4499,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>         }
>>
>>         if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
>> -           (x86_pmu.intel_cap.pebs_format >= 6) &&
>> -           x86_pmu.intel_cap.pebs_baseline &&
>> +           intel_pmu_has_pebs_counter_group(event->pmu) &&
>>             is_sampling_event(event) &&
>>             event->attr.precise_ip)
>>                 event->group_leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
>> @@ -5420,6 +5447,8 @@ static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
>>         x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
>>         if (caps & ARCH_PEBS_LBR)
>>                 x86_pmu.large_pebs_flags |= PERF_SAMPLE_BRANCH_STACK;
>> +       if (caps & ARCH_PEBS_CNTR_MASK)
>> +               x86_pmu.large_pebs_flags |= PERF_SAMPLE_READ;
>>
>>         if (!(caps & ARCH_PEBS_AUX))
>>                 x86_pmu.large_pebs_flags &= ~PERF_SAMPLE_DATA_SRC;
>> @@ -7134,8 +7163,11 @@ __init int intel_pmu_init(void)
>>          * Many features on and after V6 require dynamic constraint,
>>          * e.g., Arch PEBS, ACR.
>>          */
>> -       if (version >= 6)
>> +       if (version >= 6) {
>>                 x86_pmu.flags |= PMU_FL_DYN_CONSTRAINT;
>> +               x86_pmu.late_setup = intel_pmu_late_setup;
>> +       }
>> +
>>         /*
>>          * Install the hw-cache-events table:
>>          */
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index c66e9b562de3..c93bf971d97b 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1530,13 +1530,20 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
>>
>>  u64 intel_get_arch_pebs_data_config(struct perf_event *event)
>>  {
>> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>         u64 pebs_data_cfg = 0;
>> +       u64 cntr_mask;
>>
>>         if (WARN_ON(event->hw.idx < 0 || event->hw.idx >= X86_PMC_IDX_MAX))
>>                 return 0;
>>
>>         pebs_data_cfg |= pebs_update_adaptive_cfg(event);
>>
>> +       cntr_mask = (PEBS_DATACFG_CNTR_MASK << PEBS_DATACFG_CNTR_SHIFT) |
>> +                   (PEBS_DATACFG_FIX_MASK << PEBS_DATACFG_FIX_SHIFT) |
>> +                   PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS;
>> +       pebs_data_cfg |= cpuc->pebs_data_cfg & cntr_mask;
>> +
>>         return pebs_data_cfg;
>>  }
>>
>> @@ -2444,6 +2451,24 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
>>                 }
>>         }
>>
>> +       if (header->cntr) {
>> +               struct arch_pebs_cntr_header *cntr = next_record;
>> +               unsigned int nr;
>> +
>> +               next_record += sizeof(struct arch_pebs_cntr_header);
>> +
>> +               if (is_pebs_counter_event_group(event)) {
>> +                       __setup_pebs_counter_group(cpuc, event,
>> +                               (struct pebs_cntr_header *)cntr, next_record);
>> +                       data->sample_flags |= PERF_SAMPLE_READ;
>> +               }
>> +
>> +               nr = hweight32(cntr->cntr) + hweight32(cntr->fixed);
>> +               if (cntr->metrics == INTEL_CNTR_METRICS)
>> +                       nr += 2;
>> +               next_record += nr * sizeof(u64);
>> +       }
>> +
>>         /* Parse followed fragments if there are. */
>>         if (arch_pebs_record_continued(header)) {
>>                 at = at + header->size;
>> @@ -3094,10 +3119,8 @@ static void __init intel_ds_pebs_init(void)
>>                         break;
>>
>>                 case 6:
>> -                       if (x86_pmu.intel_cap.pebs_baseline) {
>> +                       if (x86_pmu.intel_cap.pebs_baseline)
>>                                 x86_pmu.large_pebs_flags |= PERF_SAMPLE_READ;
>> -                               x86_pmu.late_setup = intel_pmu_late_setup;
>> -                       }
> Hi Dapeng,
>
> I'm trying to understand why the late_setup initialization was changed
> here and its connection with counter group support. I couldn't find a
> mention in the commit message.

It's because arch-PEBS also supports counters group sampling, not just the
legacy PEBS with PEBS format 6. Currently ACR (auto counter reload) and
PEBS both needs the late_setup, ACR and counters group sampling (regardless
of legacy PEBS or arch-PEBS) are introduced since Perfmon v6, so the
late_setup initialization is moved to the unified place of perfmon v6
initialization. Thanks.


>
> Thanks,
> Ian
>
>>                         fallthrough;
>>                 case 5:
>>                         x86_pmu.pebs_ept = 1;
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index f1ef9ac38bfb..65cc528fbad8 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -334,12 +334,18 @@
>>  #define ARCH_PEBS_INDEX_WR_SHIFT       4
>>
>>  #define ARCH_PEBS_RELOAD               0xffffffff
>> +#define ARCH_PEBS_CNTR_ALLOW           BIT_ULL(35)
>> +#define ARCH_PEBS_CNTR_GP              BIT_ULL(36)
>> +#define ARCH_PEBS_CNTR_FIXED           BIT_ULL(37)
>> +#define ARCH_PEBS_CNTR_METRICS         BIT_ULL(38)
>>  #define ARCH_PEBS_LBR_SHIFT            40
>>  #define ARCH_PEBS_LBR                  (0x3ull << ARCH_PEBS_LBR_SHIFT)
>>  #define ARCH_PEBS_VECR_XMM             BIT_ULL(49)
>>  #define ARCH_PEBS_GPR                  BIT_ULL(61)
>>  #define ARCH_PEBS_AUX                  BIT_ULL(62)
>>  #define ARCH_PEBS_EN                   BIT_ULL(63)
>> +#define ARCH_PEBS_CNTR_MASK            (ARCH_PEBS_CNTR_GP | ARCH_PEBS_CNTR_FIXED | \
>> +                                        ARCH_PEBS_CNTR_METRICS)
>>
>>  #define MSR_IA32_RTIT_CTL              0x00000570
>>  #define RTIT_CTL_TRACEEN               BIT(0)
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index 3b3848f0d339..7276ba70c88a 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -141,16 +141,16 @@
>>  #define ARCH_PERFMON_EVENTS_COUNT                      7
>>
>>  #define PEBS_DATACFG_MEMINFO   BIT_ULL(0)
>> -#define PEBS_DATACFG_GP        BIT_ULL(1)
>> +#define PEBS_DATACFG_GP                BIT_ULL(1)
>>  #define PEBS_DATACFG_XMMS      BIT_ULL(2)
>>  #define PEBS_DATACFG_LBRS      BIT_ULL(3)
>> -#define PEBS_DATACFG_LBR_SHIFT 24
>>  #define PEBS_DATACFG_CNTR      BIT_ULL(4)
>> +#define PEBS_DATACFG_METRICS   BIT_ULL(5)
>> +#define PEBS_DATACFG_LBR_SHIFT 24
>>  #define PEBS_DATACFG_CNTR_SHIFT        32
>>  #define PEBS_DATACFG_CNTR_MASK GENMASK_ULL(15, 0)
>>  #define PEBS_DATACFG_FIX_SHIFT 48
>>  #define PEBS_DATACFG_FIX_MASK  GENMASK_ULL(7, 0)
>> -#define PEBS_DATACFG_METRICS   BIT_ULL(5)
>>
>>  /* Steal the highest bit of pebs_data_cfg for SW usage */
>>  #define PEBS_UPDATE_DS_SW      BIT_ULL(63)
>> @@ -603,6 +603,13 @@ struct arch_pebs_lbr_header {
>>         u64 ler_info;
>>  };
>>
>> +struct arch_pebs_cntr_header {
>> +       u32 cntr;
>> +       u32 fixed;
>> +       u32 metrics;
>> +       u32 reserved;
>> +};
>> +
>>  /*
>>   * AMD Extended Performance Monitoring and Debug cpuid feature detection
>>   */
>> --
>> 2.34.1
>>
