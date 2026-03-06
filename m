Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491213E02A;
	Fri,  6 Mar 2026 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760047; cv=none; b=p9fAJ6W8EdxFERQ/ffq7fXLZ7EiDGtzpKVLddA9iqs4DekjSu0rH8r1bx9rAV8Z7MgXbSOcjcPJVm1zZubeWpz4YSbr46Ohayu02xuxyW7YvLHV31XxW0adzZaIqRdEFx7vK7Kqc1K6dz8UBSgzMErrRrcljeQhvMADfEKZiHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760047; c=relaxed/simple;
	bh=4Qk7l8KOHqO1VDkH5kt60LobCFUjyWr1tAOyQtmIl8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inLPmO9A5XXZeTEqcdaWomoQ6D4ZDnnQgTgkVSwAMr+fqgZe3u/wLFAyIX46yxgd63FDagVsi5ZMJFDmH6o1UvpqvIoD09kqwe8F1acW8uowaZVpHusVMyWGrgm0TamTWA/bVyUArpaYb6p6b0Xf4Hd0acZKDd9T/By4rdpETRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2j6EfgR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2j6EfgR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772760045; x=1804296045;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4Qk7l8KOHqO1VDkH5kt60LobCFUjyWr1tAOyQtmIl8M=;
  b=b2j6EfgRav4gpsIInZhQSWthrVuGOWBtSYjqXZkntQga/uA51G5ZKYna
   7LFg6I+iZyxwGmqK1RRrFZFA0V+hnv1/qliLzr/QdMrPBNQXy4MGc14QK
   ooWrSn/R7YjopPTW5g3tIctnYHCqR6JQtDdiv0HvTmL6itPAoSxUGFS49
   oO4syifc1HK5eVl71kSEnm6B+mITOpmJXPsLcLRaLo3seQC3Zxs9n8Vh1
   METUahmdjkPXJlWJn1x565XQ6tqv94rL9tKVQe1RkKMRNXO+5JaMMt/7K
   20Mt9cBGlbRrptoEXpYmBQUc1YzoSyr2IySoGcr1YxmzWtBEbUMtsEALo
   A==;
X-CSE-ConnectionGUID: 5veI6W10QDCyHOa9JjiSjA==
X-CSE-MsgGUID: qH8ff5K2Q/GCqbxbyfG98Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="76468078"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="76468078"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 17:20:44 -0800
X-CSE-ConnectionGUID: GK3ccQ2GQkyXfxhbf53YCw==
X-CSE-MsgGUID: JkLB+qGEQT67LSxqFndPEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223816873"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 17:20:39 -0800
Message-ID: <84583ecd-d596-4989-9183-a462af040931@linux.intel.com>
Date: Fri, 6 Mar 2026 09:20:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 08/12] perf/x86/intel: Process arch-PEBS records or
 record fragments
To: Chun-Tse Shao <ctshao@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-9-dapeng1.mi@linux.intel.com>
 <CAJpZYjUwzo7E1QknNkiJy9PDjycVcPLDEnSZL+sGWebv1hYjfQ@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAJpZYjUwzo7E1QknNkiJy9PDjycVcPLDEnSZL+sGWebv1hYjfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/3/2026 8:20 AM, Chun-Tse Shao wrote:
> On Wed, Oct 29, 2025 at 3:39 AM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> A significant difference with adaptive PEBS is that arch-PEBS record
>> supports fragments which means an arch-PEBS record could be split into
>> several independent fragments which have its own arch-PEBS header in
>> each fragment.
>>
>> This patch defines architectural PEBS record layout structures and add
>> helpers to process arch-PEBS records or fragments. Only legacy PEBS
>> groups like basic, GPR, XMM and LBR groups are supported in this patch,
>> the new added YMM/ZMM/OPMASK vector registers capturing would be
>> supported in the future.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c      |  13 +++
>>  arch/x86/events/intel/ds.c        | 184 ++++++++++++++++++++++++++++++
>>  arch/x86/include/asm/msr-index.h  |   6 +
>>  arch/x86/include/asm/perf_event.h |  96 ++++++++++++++++
>>  4 files changed, 299 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 9ce27b326923..de4dbde28adc 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3215,6 +3215,19 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>                         status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
>>         }
>>
>> +       /*
>> +        * Arch PEBS sets bit 54 in the global status register
>> +        */
>> +       if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
>> +                                (unsigned long *)&status)) {
>> +               handled++;
>> +               static_call(x86_pmu_drain_pebs)(regs, &data);
>> +
>> +               if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
>> +                   is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
>> +                       status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
>> +       }
>> +
>>         /*
>>          * Intel PT
>>          */
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 68664526443f..fe1bf373409e 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -2270,6 +2270,117 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>>                         format_group);
>>  }
>>
>> +static inline bool arch_pebs_record_continued(struct arch_pebs_header *header)
>> +{
>> +       /* Continue bit or null PEBS record indicates fragment follows. */
>> +       return header->cont || !(header->format & GENMASK_ULL(63, 16));
>> +}
>> +
>> +static void setup_arch_pebs_sample_data(struct perf_event *event,
>> +                                       struct pt_regs *iregs,
>> +                                       void *__pebs,
>> +                                       struct perf_sample_data *data,
>> +                                       struct pt_regs *regs)
>> +{
>> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +       u64 sample_type = event->attr.sample_type;
>> +       struct arch_pebs_header *header = NULL;
>> +       struct arch_pebs_aux *meminfo = NULL;
>> +       struct arch_pebs_gprs *gprs = NULL;
>> +       struct x86_perf_regs *perf_regs;
>> +       void *next_record;
>> +       void *at = __pebs;
>> +
>> +       if (at == NULL)
>> +               return;
>> +
>> +       perf_regs = container_of(regs, struct x86_perf_regs, regs);
>> +       perf_regs->xmm_regs = NULL;
>> +
>> +       __setup_perf_sample_data(event, iregs, data);
>> +
>> +       *regs = *iregs;
>> +
>> +again:
>> +       header = at;
>> +       next_record = at + sizeof(struct arch_pebs_header);
>> +       if (header->basic) {
>> +               struct arch_pebs_basic *basic = next_record;
>> +               u16 retire = 0;
>> +
>> +               next_record = basic + 1;
>> +
>> +               if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
>> +                       retire = basic->valid ? basic->retire : 0;
>> +               __setup_pebs_basic_group(event, regs, data, sample_type,
>> +                                basic->ip, basic->tsc, retire);
>> +       }
>> +
>> +       /*
>> +        * The record for MEMINFO is in front of GP
>> +        * But PERF_SAMPLE_TRANSACTION needs gprs->ax.
>> +        * Save the pointer here but process later.
>> +        */
>> +       if (header->aux) {
>> +               meminfo = next_record;
>> +               next_record = meminfo + 1;
>> +       }
>> +
>> +       if (header->gpr) {
>> +               gprs = next_record;
>> +               next_record = gprs + 1;
>> +
>> +               __setup_pebs_gpr_group(event, regs,
>> +                                      (struct pebs_gprs *)gprs,
>> +                                      sample_type);
>> +       }
>> +
>> +       if (header->aux) {
>> +               u64 ax = gprs ? gprs->ax : 0;
>> +
>> +               __setup_pebs_meminfo_group(event, data, sample_type,
>> +                                          meminfo->cache_latency,
>> +                                          meminfo->instr_latency,
>> +                                          meminfo->address, meminfo->aux,
>> +                                          meminfo->tsx_tuning, ax);
>> +       }
>> +
>> +       if (header->xmm) {
>> +               struct pebs_xmm *xmm;
>> +
>> +               next_record += sizeof(struct arch_pebs_xer_header);
>> +
>> +               xmm = next_record;
>> +               perf_regs->xmm_regs = xmm->xmm;
>> +               next_record = xmm + 1;
>> +       }
>> +
>> +       if (header->lbr) {
>> +               struct arch_pebs_lbr_header *lbr_header = next_record;
>> +               struct lbr_entry *lbr;
>> +               int num_lbr;
>> +
>> +               next_record = lbr_header + 1;
>> +               lbr = next_record;
>> +
>> +               num_lbr = header->lbr == ARCH_PEBS_LBR_NUM_VAR ?
>> +                               lbr_header->depth :
>> +                               header->lbr * ARCH_PEBS_BASE_LBR_ENTRIES;
>> +               next_record += num_lbr * sizeof(struct lbr_entry);
>> +
>> +               if (has_branch_stack(event)) {
>> +                       intel_pmu_store_pebs_lbrs(lbr);
>> +                       intel_pmu_lbr_save_brstack(data, cpuc, event);
>> +               }
>> +       }
>> +
>> +       /* Parse followed fragments if there are. */
>> +       if (arch_pebs_record_continued(header)) {
>> +               at = at + header->size;
> If the header->size is 0, will it cause infinite loop?
> I can see a 0 check below but not here.

No, there are 2 places to check the header size in
intel_pmu_drain_arch_pebs(). They would break the while loop if there is
any 0 size record or fragment. Thanks.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/ds.c?h=v7.0-rc2#n3268

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/ds.c?h=v7.0-rc2#n3285


>
> Thanks,
> CT
>
>> +               goto again;
>> +       }
>> +}
>> +
>>  static inline void *
>>  get_next_pebs_record_by_bit(void *base, void *top, int bit)
>>  {
>> @@ -2753,6 +2864,78 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>>                                             setup_pebs_adaptive_sample_data);
>>  }
>>
>> +static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
>> +                                     struct perf_sample_data *data)
>> +{
>> +       short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
>> +       void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
>> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +       union arch_pebs_index index;
>> +       struct x86_perf_regs perf_regs;
>> +       struct pt_regs *regs = &perf_regs.regs;
>> +       void *base, *at, *top;
>> +       u64 mask;
>> +
>> +       rdmsrq(MSR_IA32_PEBS_INDEX, index.whole);
>> +
>> +       if (unlikely(!index.wr)) {
>> +               intel_pmu_pebs_event_update_no_drain(cpuc, X86_PMC_IDX_MAX);
>> +               return;
>> +       }
>> +
>> +       base = cpuc->ds_pebs_vaddr;
>> +       top = (void *)((u64)cpuc->ds_pebs_vaddr +
>> +                      (index.wr << ARCH_PEBS_INDEX_WR_SHIFT));
>> +
>> +       index.wr = 0;
>> +       index.full = 0;
>> +       wrmsrq(MSR_IA32_PEBS_INDEX, index.whole);
>> +
>> +       mask = hybrid(cpuc->pmu, arch_pebs_cap).counters & cpuc->pebs_enabled;
>> +
>> +       if (!iregs)
>> +               iregs = &dummy_iregs;
>> +
>> +       /* Process all but the last event for each counter. */
>> +       for (at = base; at < top;) {
>> +               struct arch_pebs_header *header;
>> +               struct arch_pebs_basic *basic;
>> +               u64 pebs_status;
>> +
>> +               header = at;
>> +
>> +               if (WARN_ON_ONCE(!header->size))
>> +                       break;
>> +
>> +               /* 1st fragment or single record must have basic group */
>> +               if (!header->basic) {
>> +                       at += header->size;
>> +                       continue;
>> +               }
>> +
>> +               basic = at + sizeof(struct arch_pebs_header);
>> +               pebs_status = mask & basic->applicable_counters;
>> +               __intel_pmu_handle_pebs_record(iregs, regs, data, at,
>> +                                              pebs_status, counts, last,
>> +                                              setup_arch_pebs_sample_data);
>> +
>> +               /* Skip non-last fragments */
>> +               while (arch_pebs_record_continued(header)) {
>> +                       if (!header->size)
>> +                               break;
>> +                       at += header->size;
>> +                       header = at;
>> +               }
>> +
>> +               /* Skip last fragment or the single record */
>> +               at += header->size;
>> +       }
>> +
>> +       __intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
>> +                                           counts, last,
>> +                                           setup_arch_pebs_sample_data);
>> +}
>> +
>>  static void __init intel_arch_pebs_init(void)
>>  {
>>         /*
>> @@ -2762,6 +2945,7 @@ static void __init intel_arch_pebs_init(void)
>>          */
>>         x86_pmu.arch_pebs = 1;
>>         x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
>> +       x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
>>         x86_pmu.pebs_capable = ~0ULL;
>>
>>         x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 9e1720d73244..fc7a4e7c718d 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -327,6 +327,12 @@
>>                                          PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
>>                                          PERF_CAP_PEBS_TIMING_INFO)
>>
>> +/* Arch PEBS */
>> +#define MSR_IA32_PEBS_BASE             0x000003f4
>> +#define MSR_IA32_PEBS_INDEX            0x000003f5
>> +#define ARCH_PEBS_OFFSET_MASK          0x7fffff
>> +#define ARCH_PEBS_INDEX_WR_SHIFT       4
>> +
>>  #define MSR_IA32_RTIT_CTL              0x00000570
>>  #define RTIT_CTL_TRACEEN               BIT(0)
>>  #define RTIT_CTL_CYCLEACC              BIT(1)
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index 0dfa06722bab..3b3848f0d339 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -437,6 +437,8 @@ static inline bool is_topdown_idx(int idx)
>>  #define GLOBAL_STATUS_LBRS_FROZEN              BIT_ULL(GLOBAL_STATUS_LBRS_FROZEN_BIT)
>>  #define GLOBAL_STATUS_TRACE_TOPAPMI_BIT                55
>>  #define GLOBAL_STATUS_TRACE_TOPAPMI            BIT_ULL(GLOBAL_STATUS_TRACE_TOPAPMI_BIT)
>> +#define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT  54
>> +#define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD      BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT)
>>  #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT     48
>>
>>  #define GLOBAL_CTRL_EN_PERF_METRICS            BIT_ULL(48)
>> @@ -507,6 +509,100 @@ struct pebs_cntr_header {
>>
>>  #define INTEL_CNTR_METRICS             0x3
>>
>> +/*
>> + * Arch PEBS
>> + */
>> +union arch_pebs_index {
>> +       struct {
>> +               u64 rsvd:4,
>> +                   wr:23,
>> +                   rsvd2:4,
>> +                   full:1,
>> +                   en:1,
>> +                   rsvd3:3,
>> +                   thresh:23,
>> +                   rsvd4:5;
>> +       };
>> +       u64 whole;
>> +};
>> +
>> +struct arch_pebs_header {
>> +       union {
>> +               u64 format;
>> +               struct {
>> +                       u64 size:16,    /* Record size */
>> +                           rsvd:14,
>> +                           mode:1,     /* 64BIT_MODE */
>> +                           cont:1,
>> +                           rsvd2:3,
>> +                           cntr:5,
>> +                           lbr:2,
>> +                           rsvd3:7,
>> +                           xmm:1,
>> +                           ymmh:1,
>> +                           rsvd4:2,
>> +                           opmask:1,
>> +                           zmmh:1,
>> +                           h16zmm:1,
>> +                           rsvd5:5,
>> +                           gpr:1,
>> +                           aux:1,
>> +                           basic:1;
>> +               };
>> +       };
>> +       u64 rsvd6;
>> +};
>> +
>> +struct arch_pebs_basic {
>> +       u64 ip;
>> +       u64 applicable_counters;
>> +       u64 tsc;
>> +       u64 retire      :16,    /* Retire Latency */
>> +           valid       :1,
>> +           rsvd        :47;
>> +       u64 rsvd2;
>> +       u64 rsvd3;
>> +};
>> +
>> +struct arch_pebs_aux {
>> +       u64 address;
>> +       u64 rsvd;
>> +       u64 rsvd2;
>> +       u64 rsvd3;
>> +       u64 rsvd4;
>> +       u64 aux;
>> +       u64 instr_latency       :16,
>> +           pad2                :16,
>> +           cache_latency       :16,
>> +           pad3                :16;
>> +       u64 tsx_tuning;
>> +};
>> +
>> +struct arch_pebs_gprs {
>> +       u64 flags, ip, ax, cx, dx, bx, sp, bp, si, di;
>> +       u64 r8, r9, r10, r11, r12, r13, r14, r15, ssp;
>> +       u64 rsvd;
>> +};
>> +
>> +struct arch_pebs_xer_header {
>> +       u64 xstate;
>> +       u64 rsvd;
>> +};
>> +
>> +#define ARCH_PEBS_LBR_NAN              0x0
>> +#define ARCH_PEBS_LBR_NUM_8            0x1
>> +#define ARCH_PEBS_LBR_NUM_16           0x2
>> +#define ARCH_PEBS_LBR_NUM_VAR          0x3
>> +#define ARCH_PEBS_BASE_LBR_ENTRIES     8
>> +struct arch_pebs_lbr_header {
>> +       u64 rsvd;
>> +       u64 ctl;
>> +       u64 depth;
>> +       u64 ler_from;
>> +       u64 ler_to;
>> +       u64 ler_info;
>> +};
>> +
>>  /*
>>   * AMD Extended Performance Monitoring and Debug cpuid feature detection
>>   */
>> --
>> 2.34.1
>>
>>
