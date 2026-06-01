Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F817335066
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293463; cv=none; b=kZqus1fqwolygP/K5XFV/ylnJAQo8sUX+VbiJMZ5AuIZ6Wjz9o3C+jAaQezvMJOHuh9nSY0rSN+VQsLXYSs0Qqp3W5ToMRf9jPRqX3jlr7Dr1T2FDXOCtCwLMZmYbqI6vTNwQIeWhdGfwwSYq36I6psL8YH7GF8Sq7/HCYCc9GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293463; c=relaxed/simple;
	bh=HB4LbUt2Ni/I5OgdL6OsLAXATb6FCK+C85Z/A/fdgd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SECWlVA1pOKBlV2ixSqh8bP20Ibk8JtyyFgOOU/yAt01fvqBz9qcmT1K+gyIFSkZCASz8k8g5t1XIOTmQiEnfut9GwYg8V6fuzmBaGFPMreug2hnrNuQvZ0JtMxy/39M9skIWIgIO9jTOiTz9jINvh7aE/kzgbXgdFyseDJn/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUXDd6Bq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUXDd6Bq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780293462; x=1811829462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HB4LbUt2Ni/I5OgdL6OsLAXATb6FCK+C85Z/A/fdgd0=;
  b=YUXDd6Bq3Ra/LDyedUoyTHbzvx0E0GVQ3YAOflHngX7v+q5gA0IVHu9m
   bqZDalwzShBaN1pVMlbwzP4UzwW/3+Z+5ld98V/K/NylM6a1dQjpSvT8p
   3ONdZ+gdgah2GG5mbVA5P2QsFOLNwpECnv8vBN2qvYK9zE+MbG+Q6vrNz
   foY5RumNBvGxCS8MD6zziKaGvMDPu91N8fGKBWDDkYpxjdakrnZX6HdQ0
   XYhhtq5yJnl03v85XVKcSzJSzkc9BCA9VS6QRS6EqX0EY3zh9a4Ov//R2
   hfqq2qIV3NgyORWa19ktpPTh6u62UqKjtUKwqhHnZs3VdX5vVDXLLNXI0
   g==;
X-CSE-ConnectionGUID: g3X9r4EMRbWwcBQGiLm5xw==
X-CSE-MsgGUID: Xh1iQjodQ6SVmIyDWDHFDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80939977"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="80939977"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 22:57:41 -0700
X-CSE-ConnectionGUID: AUAcn4fyQoabukHewLYi9w==
X-CSE-MsgGUID: eXl5ZS/2Ri69vM8cUVnONQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="240961831"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 22:57:40 -0700
Message-ID: <3a08b9f4-186e-411c-a17b-4eeb4b413e38@linux.intel.com>
Date: Mon, 1 Jun 2026 13:57:37 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 11/23] perf/x86: Enable XMM register sampling for
 REGS_USER case
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529075645.580362-12-dapeng1.mi@linux.intel.com>
 <20260529092423.F2DD81F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529092423.F2DD81F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/29/2026 5:24 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Calling `xsaves_nmi()` for PEBS events on CPUs lacking `X86_FEATURE_XSAVES` causes an invalid opcode exception (`#UD`), triggering warning loops and overhead.
> - [High] Guest XMM registers are incorrectly sampled as host REGS_USER XMM registers when a PMU interrupt occurs during KVM guest execution.
> --
>
> commit feabaffcb00c51c951e3f0889a9ad615fe731d5e
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Enable XMM register sampling for REGS_USER case
>
> This patch adds support for XMM register sampling in the REGS_USER case.
> To handle simultaneous sampling of XMM registers, a per-CPU x86_user_regs
> is introduced to store REGS_USER-specific XMM registers. The
> x86_pmu_update_user_xregs helper function is added to retrieve user-space
> XMM registers.
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -707,12 +707,12 @@ int x86_pmu_hw_config(struct perf_event *event)
>>  			return -EINVAL;
>>  	}
>>  
>> -	if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
>> +	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
>>  		/*
>>  		 * Besides the general purpose registers, XMM registers may
>>  		 * be collected as well.
>>  		 */
>> -		if (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK) {
>> +		if (event_has_extended_regs(event)) {
>>  			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
>>  				return -EINVAL;
>>  			if (is_sampling_event(event) && !event->attr.precise_ip &&
>>  			    !this_cpu_has(X86_FEATURE_XSAVES))
>>  				return -EINVAL;
>>  		}
>>  	}
> [ ... ]
>> @@ -1812,33 +1803,155 @@ static void x86_pmu_update_regs_intr(struct perf_event *event,
> [ ... ]
>> +static inline u64 x86_pmu_update_user_xregs(struct perf_sample_data *data,
>> +					    struct pt_regs *regs,
>> +					    u64 mask, u64 ignore_mask)
>> +{
>> +	struct x86_perf_regs *perf_regs;
>> +	struct xregs_state *xsave;
>> +	struct fpu *fpu;
>> +	struct fpstate *fps;
>> +	u64 user_mask = mask;
>> +
>> +	if (data->regs_user.abi == PERF_SAMPLE_REGS_ABI_NONE)
>> +		return 0;
>> +
>> +	/*
>> +	 * If PEBS hits kernel space, need to re-sample extended
>> +	 * registers for user space.
>> +	 */
>> +	if (user_mode(regs))
>> +		user_mask &= ~ignore_mask;
>> +
>> +	if (user_mask && test_thread_flag(TIF_NEED_FPU_LOAD)) {
> [Severity: High]
> When KVM loads a guest's FPU state, fpu_swap_kvm_fpstate() caches the host's
> state in fpu->__task_fpstate and explicitly clears the TIF_NEED_FPU_LOAD flag
> via fpregs_mark_activate().
>
> If a perf NMI interrupts the guest, this check for TIF_NEED_FPU_LOAD will
> evaluate to false, causing x86_pmu_update_user_xregs() to return the mask
> instead of reading the cached host state from __task_fpstate.
>
> Does this cause xsaves_nmi() to sample the hardware registers directly, which
> currently hold the KVM guest's XMM registers, and expose them to the host's
> user-space perf record, leading to cross-VM data leaks?

This is the intended behavior. Users may want to sample guest's register
data from host. As long as the privilege is correctly set, there would be
no data leak.


>
>> +		perf_regs = container_of(data->regs_user.regs,
>> +				 struct x86_perf_regs, regs);
>> +		fpu = x86_task_fpu(current);
>> +		/*
>> +		 * If __task_fpstate is set, it holds the right pointer,
>> +		 * otherwise fpstate will.
>> +		 */
>> +		fps = READ_ONCE(fpu->__task_fpstate);
>> +		if (!fps)
>> +			fps = fpu->fpstate;
>> +		xsave = &fps->regs.xsave;
>> +
>> +		update_perf_regs(perf_regs, xsave, user_mask);
>> +		return 0;
>> +	}
>> +
>> +	return user_mask;
>> +}
> [ ... ]
>>  static void x86_pmu_sample_xregs(struct perf_event *event,
>>  				 struct perf_sample_data *data,
>> +				 struct pt_regs *regs,
>>  				 u64 ignore_mask)
>>  {
>>  	struct xregs_state *xsave = get_ext_regs_buf(smp_processor_id());
>>  	u64 sample_type = event->attr.sample_type;
>>  	struct x86_perf_regs *perf_regs;
>> +	u64 user_mask = 0;
>>  	u64 intr_mask = 0;
>>  	u64 mask = 0;
>>  
>>  	if (WARN_ON_ONCE(!xsave) || !in_nmi())
>>  		return;
>>  
>> -	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
>> -	    (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK))
>> +	if (event_has_extended_regs(event))
>>  		mask |= XFEATURE_MASK_SSE;
>>  
>>  	mask &= x86_pmu.ext_regs_mask;
>> +	if (sample_type & PERF_SAMPLE_REGS_USER) {
>> +		user_mask = x86_pmu_update_user_xregs(data, regs,
>> +						      mask, ignore_mask);
>> +	}
>>  
>>  	if (sample_type & PERF_SAMPLE_REGS_INTR)
>>  		intr_mask = mask & ~ignore_mask;
>>  
>> +	if (user_mask | intr_mask) {
>> +		xsave->header.xfeatures = 0;
>> +		xsaves_nmi(xsave, user_mask | intr_mask);
>> +	}
> [Severity: High]
> For PEBS events with PERF_SAMPLE_REGS_USER, the X86_FEATURE_XSAVES check in
> x86_pmu_hw_config() is bypassed due to event->attr.precise_ip being set.
>
> If this event triggers in kernel space on a CPU lacking XSAVES (for example,
> booted with noxsaves or masked in a VM), user_mode(regs) is false, so
> user_mask retains the extended bits from x86_pmu_update_user_xregs().
>
> Since xsaves_nmi() unconditionally emits the xsaves instruction, will this
> trigger an Invalid Opcode exception on CPUs without XSAVES support and add
> overhead to every PEBS interrupt in kernel space?

Yes, it's a defect. As previous comment said, would enhance the check and
only set the PERF_PMU_CAP_EXTENDED_REGS capability when both PEBS and xsave
support XMM sampling.

Thanks.


>
>> +
>> +	if (user_mask) {
>> +		perf_regs = container_of(data->regs_user.regs,
>> +					 struct x86_perf_regs, regs);
>> +		update_perf_regs(perf_regs, xsave, user_mask);
>> +	}
