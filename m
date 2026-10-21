Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565622;
	b=ZWih+Z4Ok+4e6fmD2S/vnloUUijOQludbVqG/+cluh31ytvyEMQuGF+95oEKBW/IWyqU
	 18bu7mzNS/NiHZEPb3mfeUcXm823I7g45xDI5OOSVTciKn7OIsvACLHTXdVUWq85nHv37
	 T+evCwzZAgZsQw14vOJOgGIYHeLL4pBbIo2YGy0cmovk7qCau6M9EhuvX07Ngan8DxdRt
	 Pkyixq0BVG9sleE+qkgFwTrUCtxvEEsRQbf04jPQ8C3K+eRQSTE48PDweTtM3ZGCoH4bV
	 Mgp6a5a8eLX+NY4nqsBmOfMWE9vfBFw9lGC7hysJ7UZ+guLoTX1z9hEmI5n6KcllQ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565622;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DnjJe/BiY6TmIt7vupCF4Suc4XbqTtuUXIaTXHOVh6U=;
	b=edPUZIw7yH2gWO/RpWRUOKJ+MncJENUl1BRMhaSnfwcBHIim6b8C8xYB7e+3pXEkddOp
	 HEd11gtRvcS6QtHhBNh+fBduQcvb1fQXnYUPOp5+qr1Vs5iYFTq4N9hp9/Jeyu2KP38+T
	 h7BS8KKbN1XsR9ss4VQvfnWuJrRYbPIkIlmXzjaNsvnpyrBWe2sCqILNvsyJOEMyaDKLc
	 q5mPaBeuhI81S71viqGj2Ps4OPjikUCG/UDqGYzqsk7qT0+xcMm1q3NMXAKI/Xpwn8IuJ
	 gxMBq3cBc8X4zzxgzX5D+E9RMP3w2pKTll3Hin4j8XRn4YgFfyTVxQNT0Ca9SKDCUZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SeAaWD24;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4A7606A319;
	Wed, 21 Oct 2026 06:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB4A7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SeAaWD24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792565622; x=1824101622;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n6ozPSbKyuicv9XXEoI3gRSIECXo0MdMWD0Z4BdRWsA=;
  b=SeAaWD24m+pr7DjFEnxNCMpZUfUMHsd7V2blKAjxXEYlpFpL/thVBXFY
   DEbc81NslSTnkgc/1x2v2HOHc3eeSvuZEfSOomalwld6rucvgTr/jNKpJ
   HMSfEp2wURasmvJ+KP18wzy/nSgy286Zx/V67G9AZo8RkGIjclx252iA2
   g0VxCyHCOwKOtlUTBFrvHSL5w4bkaCBk8MhL7U8u9239HtoNplbVMBp4G
   ck74vdxg69P24vObKa4UMiilrbWIhbgugad3xWgYo/tKCxhSm8l4TTSpp
   trgGRNzVo1qpkQLu/K8sNoeqpT4A7065NTRjCpg2SOwZ7t57XkTDT7HjD
   Q==;
X-CSE-ConnectionGUID: mjC5n7CrTLyPjYPqcXeSGA==
X-CSE-MsgGUID: rOPfIjUiQvuIbQJwBjSKiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1175049"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1175049"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:53:42 -0700
X-CSE-ConnectionGUID: 4LZtWgBwQ2+l8459eZXnUQ==
X-CSE-MsgGUID: NlxIn5ofRIq1R/DC5Mh+ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3012733"
Received: from unknown (HELO [10.238.3.193]) ([10.238.3.193])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:53:41 -0700
Message-ID: <00c5d6f3-f92a-40fd-947d-e7cf5bb7904f@linux.intel.com>
Date: Wed, 21 Oct 2026 14:53:38 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 5/5] pef/x86/intel: Always snapshot live hardware LBR
 state for BPF path
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
 <20261021050711.4043703-6-dapeng1.mi@linux.intel.com>
 <sashiko-outbox-179823@kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <sashiko-outbox-179823@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/21/2026 2:05 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [Critical] perf/x86/intel: LBR state corruption in __intel_pmu_snapshot_branch_stack()
> - [High] perf/x86/intel: __intel_pmu_snapshot_branch_stack() enables PMU in PMI
> - [Medium] perf/x86/intel: unfrozen LBRs and PMU re-enable in PMI branch snapshot
> - [Medium] perf/x86: NMI race on lbr_snapshot in __intel_pmu_snapshot_branch_stack()
> - [Medium] perf/x86/intel: unfiltered LBR branch counter bits in perf_branch_entry.reserved
> --
>
> commit 4d2b360d61a8a8f6825b3cd919182ee99dbe2d76
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> pef/x86/intel: Always snapshot live hardware LBR state for BPF path
>
> This commit updates __intel_pmu_snapshot_branch_stack() to always read live
> hardware LBR registers for the BPF snapshot path even when PEBS LBR users
> are active. To avoid clobbering cached PEBS LBR data during a PMI, it saves
> and restores cpuc->lbr_stack, cpuc->lbr_entries, and cpuc->lbr_counters
> around intel_pmu_lbr_read() using a per-CPU buffer, and moves the
> cpuc->lbr_users == cpuc->lbr_pebs_users check into intel_pmu_handle_irq().
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 5dfb9e9156e88..07d1a8a7845b2 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2815,16 +2815,50 @@ static void intel_pmu_enable_all(int added)
>>  	__intel_pmu_enable_all(added, false);
>>  }
>>  
>> +struct lbr_snapshot {
>> +	struct perf_branch_stack stack;
>> +	struct perf_branch_entry entries[MAX_LBR_ENTRIES];
>> +	u64 counters[MAX_LBR_ENTRIES];
>> +};
>> +static DEFINE_PER_CPU(struct lbr_snapshot, lbr_snapshot);
> [Severity: Medium]
> Can an NMI race on the per-CPU lbr_snapshot buffer when
> __intel_pmu_snapshot_branch_stack() is called in non-NMI context?
>
> In arch/x86/events/intel/core.c, intel_pmu_snapshot_branch_stack() and
> intel_pmu_snapshot_arch_branch_stack() call local_irq_save(flags) and
> __intel_pmu_disable_all(false) before invoking
> __intel_pmu_snapshot_branch_stack(). However, local_irq_save() only masks
> normal interrupts, and an in-flight PMI or another NMI can still arrive
> after __intel_pmu_disable_all() due to NMI delivery latency.
>
> When cpuc->lbr_pebs_users > 0 and a non-NMI BPF program (such as an
> fentry/fexit trampoline via __bpf_prog_enter_recur() or a raw_tracepoint,
> where bpf_prog_active is not incremented) calls:
>
>   bpf_get_branch_snapshot()
>     -> intel_pmu_snapshot_branch_stack()
>       -> __intel_pmu_snapshot_branch_stack()
>
> an arriving PMI can still invoke bpf_overflow_handler() ->
> bpf_get_branch_snapshot() -> __intel_pmu_snapshot_branch_stack() on the
> same CPU, overwriting this_cpu_ptr(&lbr_snapshot) while the outer call is
> between its save and restore steps. Even if the PMI does not call
> bpf_get_branch_snapshot(), intel_pmu_handle_irq() updates cpuc->lbr_stack
> and cpuc->lbr_entries while the interrupted snapshot is saving or
> restoring them.
>
> Since cpuc->lbr_stack only holds live sample data awaiting output during a
> PMI, should the save and restore of cpuc->lbr_stack be restricted to NMI
> context or otherwise protected against NMI reentrancy?

This can't happen in reality.  The whole PMU including LBR has been
disabled before calling __intel_pmu_snapshot_branch_stack(). Since PMU
hardware has been disabled, then no PMI can be triggered at the period of
__intel_pmu_snapshot_branch_stack() running. So there is no reentry for the
__intel_pmu_snapshot_branch_stack()  helper, and cpuc->lbr_entries won't be
corrupted.


>
>> +
>>  static noinline int
>>  __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>>  				  unsigned int cnt, unsigned long flags)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	struct lbr_snapshot *snapshot = this_cpu_ptr(&lbr_snapshot);
>> +
>> +	/*
>> +	 * This may be called from bpf_event_handler() in a PMI context. If
>> +	 * a PEBS LBR user is active, the PEBS sample record has already updated
>> +	 * cpuc->lbr_stack. Reading the LBR registers here would overwrite that
>> +	 * cached PEBS LBR stack, so save it first and restore it afterward. This
>> +	 * keeps the cached LBR data available for later output to userspace in
>> +	 * the normal PEBS record path.
>> +	 */
>> +	if (cpuc->lbr_pebs_users) {
>> +		memcpy(&snapshot->stack, &cpuc->lbr_stack,
>> +		       sizeof(struct perf_branch_stack));
>> +		memcpy(snapshot->entries, cpuc->lbr_entries,
>> +		       sizeof(struct perf_branch_entry) * cpuc->lbr_stack.nr);
>> +		memcpy(snapshot->counters, cpuc->lbr_counters,
>> +		       sizeof(u64) * cpuc->lbr_stack.nr);
>> +	}
> [Severity: Critical]
> What happens in __intel_pmu_snapshot_branch_stack() when cpuc->lbr_users
> is non-zero, but cpuc->lbr_pebs_users is 0?
>
> In arch/x86/events/intel/lbr.c:intel_pmu_lbr_add(), cpuc->lbr_pebs_users
> is only incremented when x86_pmu.intel_cap.pebs_baseline is set and
> event->attr.precise_ip > 0:
>
> 	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
> 		cpuc->lbr_pebs_users++;
>
> When non-PEBS hardware LBR events (precise_ip == 0), legacy PEBS LBR
> events (pre-Ice Lake where pebs_baseline == 0), or Architectural PEBS LBR
> events (arch/x86/events/intel/ds.c:setup_arch_pebs_sample_data(), where
> pebs_baseline == 0) are active, cpuc->lbr_users > 0 while
> cpuc->lbr_pebs_users == 0.
>
> In those paths, handle_pmi_common(), setup_pebs_fixed_sample_data(), and
> setup_arch_pebs_sample_data() call intel_pmu_lbr_save_brstack() before
> perf_event_overflow() -> __perf_event_overflow() ->
> bpf_overflow_handler():
>
> 	if (has_branch_stack(event))
> 		intel_pmu_lbr_save_brstack(&data, cpuc, event);
> 	...
> 	perf_event_overflow(event, &data, regs);
>
> Inside include/linux/perf_event.h:perf_sample_save_brstack(), brs
> (&cpuc->lbr_stack) is clamped in place and used to precompute
> data->dyn_size:
>
> 	brs->nr = min_t(u16, event->attr.sample_max_stack, brs->nr);
> 	size += brs->nr * sizeof(struct perf_branch_entry);
> 	if (brs_cntr)
> 		size += brs->nr * sizeof(u64);
> 	data->br_stack = brs;
> 	data->br_stack_cntr = brs_cntr;
> 	data->dyn_size += size;
> 	data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
>
> If bpf_overflow_handler() then calls bpf_get_branch_snapshot() ->
> __intel_pmu_snapshot_branch_stack() with cpuc->lbr_pebs_users == 0, the
> save and restore of cpuc->lbr_stack, cpuc->lbr_entries, and
> cpuc->lbr_counters are skipped, and intel_pmu_lbr_read() overwrites them
> in place:
>
> 1. In kernel/events/core.c:perf_output_sample(), data->br_stack still
>    points to &cpuc->lbr_stack. Because intel_pmu_lbr_read() resets
>    cpuc->lbr_stack.nr up to x86_pmu.lbr_nr, undoing the sample_max_stack
>    clamp after data->dyn_size was already computed, perf_output_sample()
>    can copy more perf_branch_entry (and counter) elements than
>    perf_output_begin() reserved in the ring buffer.
>
> 2. The frozen LBR entries captured at PMI entry (or from the Arch PEBS
>    record) in cpuc->lbr_entries are overwritten by unfrozen post-ack LBR
>    registers containing PMI handler branches.
>
> 3. For branch counter groups, intel_pmu_lbr_counters_reorder() has already
>    extracted counter bits from cpuc->lbr_entries[i].reserved into
>    cpuc->lbr_counters[i] and cleared .reserved; calling
>    intel_pmu_lbr_read() -> intel_pmu_store_lbr() writes raw counter bits
>    back into cpuc->lbr_entries[i].reserved and desynchronizes
>    cpuc->lbr_counters[].
>
> Should the save and restore in __intel_pmu_snapshot_branch_stack() be
> gated on cpuc->lbr_users instead of cpuc->lbr_pebs_users (and save/restore
> based on the pre-clamp entry count or full array when needed)?

This is a real issue. For arch-PEBS, the lbr_pebs_users is missed to
account. Would add a new patch to address this issue.


>
>>  
>>  	intel_pmu_lbr_read();
>>  	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
>> -
>>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
> [Severity: Medium]
> On platforms with Architectural LBR and branch counter logging, does
> copying cpuc->lbr_entries directly after intel_pmu_lbr_read() leak raw
> branch counter bits in entries[i].reserved to BPF programs?
>
> When intel_pmu_snapshot_arch_branch_stack() calls
> __intel_pmu_snapshot_branch_stack(), intel_pmu_lbr_read() invokes
> intel_pmu_arch_lbr_read() or intel_pmu_arch_lbr_read_xsave(), which calls
> arch/x86/events/intel/lbr.c:intel_pmu_store_lbr():
>
> 	/*
> 	 * Leverage the reserved field of
> 	 * cpuc->lbr_entries[i] to temporarily store the
> 	 * branch counters information. The later code will
> 	 * decide what content can be disclosed to the perf
> 	 * tool. Pleae see intel_pmu_lbr_counters_reorder().
> 	 */
> 	.reserved = (info >> LBR_INFO_BR_CNTR_OFFSET) &
> 		    LBR_INFO_BR_CNTR_FULL_MASK,
>
> Normally intel_pmu_lbr_counters_reorder() filters those bits and clears
> cpuc->lbr_entries[i].reserved to 0 before the entries are exposed. Since
> __intel_pmu_snapshot_branch_stack() copies cpuc->lbr_entries directly into
> entries without calling intel_pmu_lbr_counters_reorder(), won't the raw
> hardware counter bits remain in the UAPI perf_branch_entry.reserved field
> returned by bpf_get_branch_snapshot()?

Currently the intel_pmu_lbr_filter() has already filtered the LBR entries
which contain the sensitive information, like kernel address if only user
space sampling is required. After the filtering, there should be no any
sensitive data including the LBR counters. I suppose it can be exposed to
user space.



>
>> +
>> +	if (cpuc->lbr_pebs_users) {
>> +		memcpy(&cpuc->lbr_stack, &snapshot->stack,
>> +		       sizeof(struct perf_branch_stack));
>> +		memcpy(cpuc->lbr_entries, snapshot->entries,
>> +		       sizeof(struct perf_branch_entry) * cpuc->lbr_stack.nr);
>> +		memcpy(cpuc->lbr_counters, snapshot->counters,
>> +		       sizeof(u64) * cpuc->lbr_stack.nr);
>> +	}
>> +
>>  	intel_pmu_enable_all(0);
> [Severity: High]
> Is it safe for __intel_pmu_snapshot_branch_stack() to unconditionally call
> intel_pmu_enable_all(0) when invoked from bpf_overflow_handler() in a PMI?
>
> In arch/x86/events/intel/core.c:intel_pmu_handle_irq(), the PMI handler
> saves cpuc->enabled, sets cpuc->enabled = 0, and disables the PMU in
> hardware:
>
> 	pmu_enabled = cpuc->enabled;
> 	...
> 	cpuc->enabled = 0;
> 	__intel_pmu_disable_all(true);
>
> The PMI handler expects the PMU, PEBS, BTS, and LBRs to remain disabled in
> hardware while handle_pmi_common() and __intel_pmu_pebs_last_event() drain
> PEBS records and reprogram counter periods, only restoring the hardware
> state at the done label if pmu_enabled was set:
>
> 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
> 	cpuc->enabled = pmu_enabled;
> 	if (pmu_enabled)
> 		__intel_pmu_enable_all(0, true);
>
> When a BPF program runs via perf_event_overflow() ->
> bpf_overflow_handler() during a PMI and calls bpf_get_branch_snapshot() ->
> __intel_pmu_snapshot_branch_stack(), calling intel_pmu_enable_all(0)
> invokes x86_pmu_pebs_enable_all() and __intel_pmu_enable_all(0, false)
> while cpuc->enabled is 0. This re-enables MSR_IA32_PEBS_ENABLE, LBRs, BTS,
> and MSR_CORE_PERF_GLOBAL_CTRL before __intel_pmu_pebs_last_event() and
> handle_pmi_common() finish reprogramming counter periods, and leaves the
> hardware PMU enabled after the PMI exits if the PMI interrupted an
> x86_pmu_disable() section where pmu_enabled was 0.
>
> Should __intel_pmu_snapshot_branch_stack() avoid calling
> intel_pmu_enable_all(0) when cpuc->enabled is 0?

Yeah, that's a real issue, would fix it in next version.



>
>>  	local_irq_restore(flags);
>>  	return cnt;
>> @@ -4022,7 +4056,12 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>>  
>>  	loops = 0;
>>  again:
>> -	intel_pmu_lbr_read();
>> +	/*
>> +	 * No need to read the LBR stack when all LBR users are PEBS events,
>> +	 * since the PEBS handler updates it.
>> +	 */
>> +	if (cpuc->lbr_users != cpuc->lbr_pebs_users)
>> +		intel_pmu_lbr_read();
>>  	intel_pmu_ack_status(status);
> [Severity: Medium]
> When cpuc->lbr_users == cpuc->lbr_pebs_users and a BPF program calls
> bpf_get_branch_snapshot() from bpf_overflow_handler() during a PMI, haven't
> the hardware LBR registers already been unfrozen by
> intel_pmu_ack_status(status)?
>
> In arch/x86/events/intel/core.c:intel_pmu_handle_irq(),
> __intel_pmu_disable_all(true) clears MSR_CORE_PERF_GLOBAL_CTRL but does
> not clear LBR enable bits in MSR_IA32_DEBUGCTLMSR or MSR_ARCH_LBR_CTL,
> relying on GLOBAL_STATUS_LBRS_FROZEN to keep the LBR stack frozen.
>
> As noted in arch/x86/events/intel/lbr.c:__intel_pmu_lbr_enable():
>
> 	/*
> 	 * No need to unfreeze manually, as v4 can do that as part
> 	 * of the GLOBAL_STATUS ack.
> 	 */
> 	if (pmi && x86_pmu.version >= 4)
> 		return;
>
> On PMU v4+ platforms (which include all pebs_baseline platforms), calling
> intel_pmu_ack_status(status) clears GLOBAL_STATUS_LBRS_FROZEN and
> immediately unfreezes the hardware LBRs. By the time handle_pmi_common() ->
> x86_pmu_drain_pebs() -> __intel_pmu_pebs_last_event() sets up the PEBS
> sample and invokes bpf_overflow_handler() ->
> __intel_pmu_snapshot_branch_stack(), the unfrozen hardware LBR MSRs have
> been recording branches inside the PMI handler itself (and
> __intel_pmu_snapshot_branch_stack() then also calls intel_pmu_enable_all(0)
> before the PMI finishes).
>
> Can __intel_pmu_snapshot_branch_stack() still obtain an unpolluted hardware
> LBR snapshot in this PMI path after intel_pmu_ack_status(status) has
> unfrozen the LBRs?

Ah, it's indeed an issue. Would fix it in next version.

Thanks.


>
> [ ... ]
>
