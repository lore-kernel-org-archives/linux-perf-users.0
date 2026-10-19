Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4C3909B9;
	Mon, 19 Oct 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402160; cv=none; b=gj2GOfRawRwcVeJlimKGYS7jfWa5pf+mnFIZBFjD3Bop96XrM35XI72KNZY/BfzmZNZLTNWerNqAIAd2V9A5O0tf2YEDJwcTHEo1EH8hh26sFfa6DclXUyGgC7U1Cl6jAmvWjNjbAvt3MgqBclKXC+w/wSCC/1DaxfuGUvVmvqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402160; c=relaxed/simple;
	bh=w25myChFYQNAFEK+shdbC7r73FBE3ZUvmtEKqMa9QoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWTD+9e5+lDfXDpPj31GTmRp8gpxIsh5Pv/8ZxnTKUMa5XD3T7r5sRJxam32/EpwUhM/34oNuSaGN+QLk/Bh7L4hfDfvE9peZ4HCrCZmHYxTrgHrCQA4up82U/bcKeiZ8ezuJRuRTj9euD+4cZsRWsLdgF5fG67E7MwPcfU3bTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ek62wio4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ek62wio4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792402158; x=1823938158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w25myChFYQNAFEK+shdbC7r73FBE3ZUvmtEKqMa9QoA=;
  b=Ek62wio4jMw8PR9lorJ9g+Pv1SD71Not2399Yrn+MliKVdUqm1Jb42UH
   2GMd3Se8DyIPnlEuPP39AZ3Fpt/wJXi0545MRQjEgYoZ1cp+zUklSz2q+
   YfVamiIMG6hTbBbUfJXk7tCNJI+3qPBzN5PMyw10gBj5NHiKf3Ij7s1dC
   TDt5R5Qa55ffOEVGXsob7C+qFxttH8/jvv2PLECMvOIJ8Wf+N9j4vDjdk
   ODfNZ5IyPDNqQWpDzArlua5oeJdBKt9g0EyDLRaSmnHD5zOJt6+3bhUhR
   CeiQLNcg6xW4dTM9LxXb45IZCH95pJVq5uq3tfdoBFYqo6t1YOyTAsX2J
   g==;
X-CSE-ConnectionGUID: fanfGmLRQdeO8gzvrVUSqQ==
X-CSE-MsgGUID: CvkVw+tvS1O5KnWVb0i+WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="972434"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="972434"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:29:17 -0700
X-CSE-ConnectionGUID: e1zupzaDRT+LQjk03FM3Bw==
X-CSE-MsgGUID: Co9vCk0MSTi7/oUqnZPxDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2472814"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:29:17 -0700
Message-ID: <e608f201-5240-4bbe-a2d6-de61a708a2f5@linux.intel.com>
Date: Mon, 19 Oct 2026 17:29:12 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 4/4] perf/x86/intel/lbr: Limit branch snapshots to
 valid entries
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
 <20261019070836.2972403-5-dapeng1.mi@linux.intel.com>
 <sashiko-outbox-176751@kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <sashiko-outbox-176751@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/19/2026 3:35 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] perf/x86/intel/lbr: stale LBR data or -ENOENT in intel_pmu_lbr_read() for PEBS
> - [Medium] perf/x86/intel/lbr: unreset lbr_stack.nr in intel_pmu_arch_lbr_read_xsave()
> - [Medium] perf/x86: late lbr_nr clamping in init_hw_perf_events() after arch LBR init
> --
>
> commit da27a6ac96e6d944e33e171c276d0b044be96def
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel/lbr: Limit branch snapshots to valid entries
>
> This patch limits __intel_pmu_snapshot_branch_stack() to copy up to
> cpuc->lbr_stack.nr entries rather than x86_pmu.lbr_nr, and resets
> cpuc->lbr_stack.nr to 0 in intel_pmu_lbr_read() when there are no active
> LBR users or LBR is excluded on the host.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 0a34d674df590..5dfb9e9156e88 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2822,7 +2822,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  
>>  	intel_pmu_lbr_read();
>> -	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
>> +	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
>>  
>>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>>  	intel_pmu_enable_all(0);
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 249db12e927ed..cc0300aba7de0 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1022,14 +1022,19 @@ void intel_pmu_lbr_read(void)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  
>> +	if (!cpuc->lbr_users || vlbr_exclude_host()) {
>> +		/* Reset lbr_stack.nr to prevent stale data leakage. */
>> +		cpuc->lbr_stack.nr = 0;
>> +		return;
>> +	}
>> +
>>  	/*
>>  	 * Don't read when all LBRs users are using adaptive PEBS.
>>  	 *
>>  	 * This could be smarter and actually check the event,
>>  	 * but this simple approach seems to work for now.
>>  	 */
>> -	if (!cpuc->lbr_users || vlbr_exclude_host() ||
>> -	    cpuc->lbr_users == cpuc->lbr_pebs_users)
>> +	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
>>  		return;
> [Severity: High]
> Does skipping x86_pmu.lbr_read(cpuc) here when cpuc->lbr_users ==
> cpuc->lbr_pebs_users cause __intel_pmu_snapshot_branch_stack() to return
> 0 entries or copy stale cpuc->lbr_entries[] to BPF programs?
>
> The commit message notes that when all active LBR users are PEBS events,
> the LBR stack is already updated from the PEBS records. However, PEBS LBR
> records are only written into cpuc->lbr_entries[] and cpuc->lbr_stack.nr
> during counter overflow PMI draining:
>
>   handle_pmi_common()
>     -> x86_pmu_drain_pebs()
>       -> setup_pebs_adaptive_sample_data() / setup_arch_pebs_sample_data()
>         -> intel_pmu_store_pebs_lbrs()
>
> In contrast, bpf_get_branch_snapshot() invokes
> intel_pmu_snapshot_branch_stack() or intel_pmu_snapshot_arch_branch_stack()
> synchronously from a software or tracing event outside of any PEBS drain.
> Those functions freeze the hardware LBRs and call
> __intel_pmu_snapshot_branch_stack() -> intel_pmu_lbr_read() to read the
> current hardware LBR registers.
>
> When all active LBR events on the CPU are adaptive PEBS events, returning
> early in intel_pmu_lbr_read() without reading the hardware LBRs or
> updating cpuc->lbr_stack.nr leads to several issues:
>
> 1. If no PEBS PMI has occurred since the last intel_pmu_lbr_reset(),
>    cpuc->lbr_stack.nr is still 0, so __intel_pmu_snapshot_branch_stack()
>    copies 0 entries and bpf_get_branch_snapshot() fails with -ENOENT even
>    though the LBR hardware has been actively recording branches.
>
> 2. If an earlier PEBS PMI occurred, cpuc->lbr_entries[] and
>    cpuc->lbr_stack.nr hold the historical branch stack from that old PEBS
>    overflow sample rather than the live branches frozen at the snapshot
>    point.
>
> 3. Stale or cross-task entries can also remain in cpuc->lbr_entries[] with
>    cpuc->lbr_stack.nr > 0 across transitions that do not call
>    intel_pmu_lbr_reset():
>
>    arch/x86/events/intel/lbr.c:intel_pmu_lbr_add() {
>        if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
>            cpuc->lbr_pebs_users++;
>        perf_sched_cb_inc(event->pmu);
>        if (!cpuc->lbr_users++ && !event->total_time_running)
>            intel_pmu_lbr_reset();
>    }
>
>    Scheduling in a previously active PEBS LBR event where
>    event->total_time_running > 0 (or removing a non-PEBS LBR event via
>    intel_pmu_lbr_del() while a PEBS LBR event remains active) does not
>    reset cpuc->lbr_stack.nr. Similarly, on a context switch with
>    PERF_SAMPLE_BRANCH_CALL_STACK:
>
>    arch/x86/events/intel/lbr.c:__intel_pmu_lbr_restore() {
>        ...
>        x86_pmu.lbr_restore(ctx);
>
>        task_context_opt(ctx)->lbr_stack_state = LBR_NONE;
>    }
>
>    __intel_pmu_lbr_restore() updates the hardware LBR MSRs for the
>    incoming task without resetting cpuc->lbr_stack.nr, leaving the
>    previous task's cached cpuc->lbr_entries[] to be copied by
>    __intel_pmu_snapshot_branch_stack().
>
>>  
>>  	x86_pmu.lbr_read(cpuc);

Hmm, I hesitated for a long time on whether perf should snapshot the
runtime LBR registers instead of using the cached LBR stack data which may
comes from the PEBS record previously. If
__intel_pmu_snapshot_branch_stack() doesn't snapshot the runtime hardware
LBR registers, then BPF may get the stale LBR stack instead of the LBR
stack data at the BPF hook point. If __intel_pmu_snapshot_branch_stack()
snapshots the runtime LBR stack, it would overwrite the cached the PEBS LBR
stack data and this data could be used in the regular overflow handler
processing later.

We could have to save the PEBS LBR stack into a temporary buffer, and then
restore them into the cpuc->lbr_stack after copying the runtime hardware
LBR stack to BFP buffer. Thanks. 




> [Severity: Medium]
> Can x86_pmu.lbr_read(cpuc) leave a stale non-zero cpuc->lbr_stack.nr when
> intel_pmu_arch_lbr_read_xsave() sees the hardware Arch LBR state in its
> XSAVE INIT configuration?
>
> In the preceding patch ("perf/x86/intel/lbr: Reset the cached LBR stack in
> intel_pmu_lbr_reset()"), intel_pmu_arch_lbr_read_xsave() was updated to:
>
> arch/x86/events/intel/lbr.c:intel_pmu_arch_lbr_read_xsave() {
> 	...
> 	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
>
> 	if (xsave->header.xfeatures & XFEATURE_MASK_LBR)
> 		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
> }
>
> When 0 branches have been recorded in hardware, the Arch LBR state is in
> its XSAVE INIT configuration, so xsaves() clears XFEATURE_MASK_LBR in
> xsave->header.xfeatures. Unlike the MSR fallback path
> intel_pmu_store_lbr(cpuc, NULL) which reads 0 from MSR_ARCH_LBR_FROM_0 and
> sets cpuc->lbr_stack.nr = 0, skipping intel_pmu_store_lbr() here without
> an else branch leaves cpuc->lbr_stack.nr at its previous value.
>
> If cpuc->lbr_stack.nr was non-zero from an earlier read and the hardware
> Arch LBR state subsequently returns to the INIT state without
> intel_pmu_lbr_reset() being called (for example, when
> __intel_pmu_lbr_restore() restores a task's call-stack LBR context via
> intel_pmu_arch_lbr_xrstors() whose saved xfeatures has XFEATURE_MASK_LBR
> clear, when RET instructions pop all prior CALL entries in call-stack
> mode, when a CPU wakes from a deep C-state that resets Arch LBR registers,
> or when an LBR event with event->total_time_running > 0 is scheduled back
> in), __intel_pmu_snapshot_branch_stack() will see the old
> cpuc->lbr_stack.nr and copy stale cpuc->lbr_entries[] into entries.
>
> Should intel_pmu_arch_lbr_read_xsave() set cpuc->lbr_stack.nr = 0 when
> !(xsave->header.xfeatures & XFEATURE_MASK_LBR)?
>
>
> [Severity: Medium]
> Also in the earlier patch in this series ("perf/x86: Clamp x86_pmu.lbr_nr
> to MAX_LBR_ENTRIES"), init_hw_perf_events() clamps x86_pmu.lbr_nr after
> vendor PMU initialization has already run:
>
> arch/x86/events/core.c:init_hw_perf_events() {
> 	...
> 	err = x86_pmu.init();
> 	...
> 	x86_pmu.lbr_nr = min(x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
> }
>
> During x86_pmu.init() -> intel_pmu_init() -> intel_pmu_arch_lbr_init(),
> the Arch LBR depth is selected from the highest bit in
> eax.split.lbr_depth_mask (up to 64), tested against MSR_ARCH_LBR_DEPTH,
> and validated against xfeature_size(XFEATURE_LBR):
>
> arch/x86/events/intel/lbr.c:intel_pmu_arch_lbr_init() {
> 	...
> 	lbr_nr = fls(eax.split.lbr_depth_mask) * 8;
> 	if (!lbr_nr)
> 		goto clear_arch_lbr;
>
> 	/* Apply the max depth of Arch LBR */
> 	if (wrmsrq_safe(MSR_ARCH_LBR_DEPTH, lbr_nr))
> 		goto clear_arch_lbr;
>
> 	x86_pmu.lbr_nr = lbr_nr;
>
> 	if (has_arch_lbr_xsave() &&
> 	    xfeature_size(XFEATURE_LBR) != get_lbr_state_size()) {
> 		WARN_ON(1);
> 		goto clear_arch_lbr;
> 	}
> }
>
> If hardware enumerates a maximum depth greater than MAX_LBR_ENTRIES (32)
> in eax.split.lbr_depth_mask, clamping x86_pmu.lbr_nr to 32 afterwards in
> init_hw_perf_events() means intel_pmu_arch_lbr_reset() will later execute
> an unchecked wrmsrq(MSR_ARCH_LBR_DEPTH, x86_pmu.lbr_nr) with depth 32:
>
> arch/x86/events/intel/lbr.c:intel_pmu_arch_lbr_reset() {
> 	/* Write to ARCH_LBR_DEPTH MSR, all LBR entries are reset to 0 */
> 	wrmsrq(MSR_ARCH_LBR_DEPTH, x86_pmu.lbr_nr);
> }
>
> If depth 32 (bit 3 in eax.split.lbr_depth_mask) is not supported by the
> processor or VM, won't that wrmsrq(MSR_ARCH_LBR_DEPTH, 32) trigger an
> unhandled #GP fault during CPU startup or LBR reset, in addition to
> get_lbr_state_size() and the boot logs having used the unclamped
> x86_pmu.lbr_nr?
>
> Should intel_pmu_arch_lbr_init() mask or bound the selected depth to
> MAX_LBR_ENTRIES before validating MSR_ARCH_LBR_DEPTH and
> get_lbr_state_size()?
>
