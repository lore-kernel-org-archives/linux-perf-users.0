Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA023D7DF
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283511; cv=none; b=LqDu4CjYu8p9t+r3M6wxfvMon6jcFsPgGHn/0LcnbDtnJ9vmJPMX9HtKwH5XcyXC75sKLGOSNKgQ8WnJlNUTTc2EhnPwyV+GMXD4XjvyLptkTMDtLlBC9et7wOA3aDhqBfPeHl1JLGGfF4Bwz9cAA8Vz1XE4VcnFiSWZj5M05QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283511; c=relaxed/simple;
	bh=lfqejeSq0JlIgPlcxdVdLN7DnwTLwLSJ9J3QQFOQ8Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2lfSPRrXVRlq8FfhLh5+DKIuaaKVz2jC+dZltNZzn49Ki1dhp06zWUyGE0dbf/0qKluJv8/fAdA8CH8Zte7aPX7EJy6j3t/MvgBe1wEgO/GS0Vp5Mw8ChkoYBkxFbEj4nIDHETcTm8mOhTe16862g0FhJ1QzQHdXFfvzZOAB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bV6ip7Vw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bV6ip7Vw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780283507; x=1811819507;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lfqejeSq0JlIgPlcxdVdLN7DnwTLwLSJ9J3QQFOQ8Sw=;
  b=bV6ip7VwHLTuJLEl3YREPbQQbFHGgyjHQiW3LvhRh3iQye+EXLDkH2zQ
   bR3h1eNO9bl5y+0wG3WOkV19601ysIt7xOAT4vTlcZ16VMlmDPT7rxcRd
   utqHUiyGm6cvVNYTSJIteaOGuXQZlP4yL42GNbk3QZqiSM++rYULxvPPm
   jcSv9FKInZ1Sz8BHUWF3//avGjNslyAGSVw+bTauDSpyHnbwhGCigi3Ha
   NTDrQKulybbEHU/s0l8slVmf4BfCFSw/1V/QQda///kmz2031stAX8SQF
   JWr01Tn+2nXabWGyQm9cqW6RhIVm3PZR02EvaDoS78O4tq8pTK/gqmmlp
   g==;
X-CSE-ConnectionGUID: 4IYGtf9ZRmOiXTfbHnTQ+Q==
X-CSE-MsgGUID: neVm02vGS2qwjZPQlih7gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="84923367"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="84923367"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 20:11:47 -0700
X-CSE-ConnectionGUID: 9UVjC0s9Rn6LspzxazTkMA==
X-CSE-MsgGUID: jvaUHsuZSZyzgl3IPHxcLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="248537313"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 20:11:46 -0700
Message-ID: <3a990307-e900-4b4a-ac88-b3373bf7afa6@linux.intel.com>
Date: Mon, 1 Jun 2026 11:11:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 10/23] perf/x86: Enable XMM Register Sampling for
 Non-PEBS Events
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529075645.580362-11-dapeng1.mi@linux.intel.com>
 <20260529090255.E5E801F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529090255.E5E801F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/29/2026 5:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [High] reserve_ext_regs_buffers() fails to propagate memory allocation errors, leading to a predictable WARN_ON_ONCE in NMI context.
> - [High] PEBS events on older platforms (e.g., Skylake) improperly accept `PERF_REG_EXTENDED_MASK`, bypassing capability checks.
>
> Pre-existing issues:
> - [High] Software PMU events (or hardware events requesting `PERF_SAMPLE_REGS_USER`) can request XMM registers, causing `perf_reg_value()` to perform an out-of-bounds read on the kernel stack.
> --
>
> commit cee33ccbb52239e18206f79aef67c4e7ac96ca59
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Enable XMM Register Sampling for Non-PEBS Events
>
> This commit extends XMM register sampling to non-PEBS events by utilizing the
> xsaves instruction. It introduces a per-CPU 64-byte aligned buffer to store
> SIMD and other registers, allocating it during hardware reservation. The XMM
> data is then retrieved during the REGS_INTR case.
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 17c8f44ee43b3..c219a563434d4 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
> [ ... ]
>
>> @@ -410,6 +410,56 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
> [ ... ]
>
>> +static void reserve_ext_regs_buffers(void)
>> +{
>> +	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
>> +	unsigned int size;
>> +	int cpu;
>> +
>> +	if (!x86_pmu.ext_regs_mask)
>> +		return;
>> +
>> +	/* +64 bytes for the 64 bytes alignment request of xsave area. */
>> +	size = xstate_calculate_size(x86_pmu.ext_regs_mask, compacted) + 64;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		per_cpu(ext_regs_buf, cpu) = kzalloc_node(size, GFP_KERNEL,
>> +							  cpu_to_node(cpu));
>> +		if (WARN_ON_ONCE(!per_cpu(ext_regs_buf, cpu)))
>> +			goto err;
>> +	}
>> +
>> +	return;
>> +
>> +err:
>> +	release_ext_regs_buffers();
>> +}
> [Severity: High]
> Does reserve_ext_regs_buffers() need to propagate the allocation failure back
> to the caller?
>
> When kzalloc_node() fails, this function frees any previously allocated buffers
> and returns void. The caller, x86_reserve_hardware(), then assumes success
> and allows the perf_event_open syscall to succeed. Later, when an event
> requiring extended registers triggers a PMI, x86_pmu_sample_xregs() retrieves
> a NULL buffer and triggers a WARN_ON_ONCE in NMI context.
>
> Could this allow a local user to deliberately exhaust memory and repeatedly
> open a perf event to trigger the warning? If the system has panic_on_warn
> enabled, this could escalate to a kernel panic.
>
> [ ... ]

I suppose add "WARN_ON_ONCE" is fairly enough to report the issue.
Propagating the error would lead to the whole perf reservation fails and
lead to no any perf functions can be used. This is not what we want. Even
the extended buffer allocation fails, most of perf functions can still
work, only the SIMD/eGPRs sampling would be bypassed.

>
>> @@ -655,18 +707,26 @@ int x86_pmu_hw_config(struct perf_event *event)
> [ ... ]
>
>> +	if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
>> +		/*
>> +		 * Besides the general purpose registers, XMM registers may
>> +		 * be collected as well.
>> +		 */
>> +		if (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK) {
>> +			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
>> +				return -EINVAL;
>> +			if (is_sampling_event(event) && !event->attr.precise_ip &&
>> +			    !this_cpu_has(X86_FEATURE_XSAVES))
>> +				return -EINVAL;
>> +		}
>> +	}
>>  
>> -		if (!event->attr.precise_ip)
>> +	if (event->attr.sample_type & PERF_SAMPLE_REGS_USER) {
>> +		/*
>> +		 * Currently XMM registers sampling for REGS_USER is not
>> +		 * supported yet.
>> +		 */
>> +		if (event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK)
>>  			return -EINVAL;
>>  	}
> [Severity: High]
> This isn't a bug introduced by this patch, but can software PMU events request
> XMM registers and cause an out-of-bounds read on the kernel stack?
>
> While x86_pmu_hw_config() correctly blocks PERF_REG_EXTENDED_MASK for
> unsupported scenarios here, software events bypass x86_pmu_hw_config()
> completely. The function perf_reg_validate() checks requested registers against
> PERF_REG_X86_RESERVED, which fails to exclude bits 32-63 (XMM registers).
>
> If a software event requests XMM registers via PERF_SAMPLE_REGS_USER, and the
> event overflows, a standard pt_regs pointing to the top of the kernel stack
> is passed to perf_reg_value().
>
> When it uses container_of(regs, struct x86_perf_regs, regs) and reads
> perf_regs->xmm_regs, does it read past the end of the pt_regs on the stack,
> potentially leaking kernel memory or triggering a page fault?
>
> I note this is addressed later in the patch series by commit "perf/x86: Enable
> XMM register sampling for REGS_USER case", but wanted to mention it here.

I don't think the comment is correct. currently the below check in
perf_try_init_event() would block the PMUs which haven't
PERF_PMU_CAP_EXTENDED_REGS capability, like software PMU, to sample XMM
registers,

```

   if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
        event_has_extended_regs(event)) {
        ret = -EOPNOTSUPP;
        goto err_destroy;
    }

```

>
> [ ... ]
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 92cb9a716e83d..f5d458e3ba3f6 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>
>> @@ -6176,8 +6179,37 @@ static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
> [ ... ]
>
>> +static void intel_extended_regs_init(struct pmu *pmu)
>> +{
>> +	struct pmu *dest_pmu = pmu ? pmu : x86_get_pmu(smp_processor_id());
>> +
>> +	/*
>> +	 * Extend the vector registers support to non-PEBS.
>> +	 * The feature is limited to newer Intel machines with
>> +	 * PEBS V4+ or archPerfmonExt (0x23) enabled for now.
>> +	 * In theory, the vector registers can be retrieved as
>> +	 * long as the CPU supports. The support for the old
>> +	 * generations may be added later if there is a
>> +	 * requirement.
>> +	 * Only support the extension when XSAVES is available.
>> +	 */
>> +	if (!boot_cpu_has(X86_FEATURE_XSAVES))
>> +		return;
>>  
>> +	if (!boot_cpu_has(X86_FEATURE_XMM) ||
>> +	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
>> +		return;
>> +
>> +	/*
>> +	 * On current hybrid platforms, P-cores and E-cores expose the same
>> +	 * XSAVE feature set. Therefore, using the global x86_pmu.ext_regs_mask
>> +	 * is sufficient to represent the hardware-supported XSAVE features.
>> +	 */
>> +	x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
>> +	dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
>> +}
> [Severity: High]
> Will this allow PEBS events on older platforms like Skylake to bypass capability
> checks?
>
> Before this change, PERF_PMU_CAP_EXTENDED_REGS was only set for CPUs with PEBS
> format >= 4 (Icelake+). By introducing intel_extended_regs_init(), the
> capability is now set globally for any CPU supporting XSAVES, including
> Skylake.
>
> Looking back at x86_pmu_hw_config(), if an event is a PEBS event
> (precise_ip > 0), it passes the capability check because the PMU now advertises
> it.
>
> Since Skylake's PEBS v3 hardware cannot sample XMM registers, does this result
> in a silent ABI regression where the kernel returns zeroes in the sample
> payload instead of returning -EINVAL at event creation? Should
> x86_pmu_hw_config() enforce that PEBS XMM requests specifically require PEBS
> v4+ support?

Yes, would strengthen the check and ensure PERF_PMU_CAP_EXTENDED_REGS is
set only when both PEBS and non-PEBS both support it. 

Thanks.


>
