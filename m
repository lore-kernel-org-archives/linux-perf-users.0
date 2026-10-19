Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4249DB97;
	Mon, 19 Oct 2026 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399492; cv=none; b=CEwCK2VUCjYTEinwjTmMinY1z/kNhprZADoZlU1r61GH/K2BJqkFhJNCRCiSbrSLM+gcMdbIjb8HYeA2BT4KAKt6UQvUkDVtz/pxXV53tbTtEgUA16CPw570p9QLTgA7BrPZn2uq+lkhkkMnlxY4QzIVafQMFxC0Jsj6QLwHsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399492; c=relaxed/simple;
	bh=+rxHd7A2spdMZj37iqfIcRBFMWAgi1P2y5Fb791M4DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dgwdz+v8Vgs6nWsbT+eMQFTgr2utb19t4+mB3S4+xcEHHLZw9VPI9ZBQQnwTkUi2l7jwqXVkjcGV9yEH2QfF7929cxxQ7eKNfxIkZ5FDu0l64p5DpNK+Ngp9ZU0UAvDLwB3vuaz3sXwRW8PXbJ248zWsSKFvY5ldzqVuqYhxc/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSqa8SBg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSqa8SBg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399488; x=1823935488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+rxHd7A2spdMZj37iqfIcRBFMWAgi1P2y5Fb791M4DE=;
  b=RSqa8SBgsp2q1H/JZtAJKT6ScifPOa6Mn2JkR49WoToFahvvGs5UIo3y
   ehzwwEGQ/mhqDMofxMeZ873QU4BgFBDIo1JLq52oEZ5GW5/z8S1oZCme4
   SYiWbHaQ0l0/lHTq7wedWBC7eP3dE7pkM0jdBqOKXJF3zw23VfTQb6KPv
   yOcQdLq9isID7eTzxLyskg7Wr2H5UXzlZ2ebcs3kXiPTT7MU1Nno1CM8t
   fxDFWCyF4Do1VLoiUVE6/25NB48OE02S8FK+RqoscPGFlhuOz0k9ZG7pm
   XjibTTSQb4rGngHjoqiPCMcwxbmEH5z5g+2RFQoOcgptReLUzTY6120MI
   g==;
X-CSE-ConnectionGUID: W51NflGWQhG8X+qUS2xQOg==
X-CSE-MsgGUID: 4MRTMqa5TrShobhUqLaYXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="975530"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="975530"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:44:48 -0700
X-CSE-ConnectionGUID: JrtbCrjLR+KrG8YyzfuBkw==
X-CSE-MsgGUID: cS9H3YcHR2Kcul8kw+46GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4263057"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:44:47 -0700
Message-ID: <73659458-7d74-4340-92cc-bd88df1a82a1@linux.intel.com>
Date: Mon, 19 Oct 2026 16:44:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 1/4] perf/x86: Clamp x86_pmu.lbr_nr to MAX_LBR_ENTRIES
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
 <20261019070836.2972403-2-dapeng1.mi@linux.intel.com>
 <sashiko-outbox-176745@kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <sashiko-outbox-176745@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/19/2026 3:28 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] perf/x86: late x86_pmu.lbr_nr clamp in init_hw_perf_events() risks #GP
> --
>
> commit 7f534b76717bd0a7a33fa3404815780334bcf485
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Clamp x86_pmu.lbr_nr to MAX_LBR_ENTRIES
>
> This commit clamps x86_pmu.lbr_nr to MAX_LBR_ENTRIES in
> init_hw_perf_events() to prevent out-of-bounds accesses to the cached
> LBR stack.
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 4df792b139e05..82f6b66db7e2f 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2645,6 +2645,8 @@ static int __init init_hw_perf_events(void)
>>  	if (!x86_pmu.config_mask)
>>  		x86_pmu.config_mask = X86_RAW_EVENT_MASK;
>>  
>> +	x86_pmu.lbr_nr = min(x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
>> +
>>  	perf_events_lapic_init();
>>  	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI");
> [Severity: High]
> Does clamping x86_pmu.lbr_nr after intel_pmu_init() and amd_pmu_init()
> return risk an unhandled #GP in intel_pmu_arch_lbr_reset() and leave
> the vendor PMU initialization inconsistent with the clamped depth?
>
> For Intel Architectural LBR, supported depths are enumerated as a bitmask
> in eax.split.lbr_depth_mask (where each bit indicates support for a
> multiple of 8 up to 64). During init_hw_perf_events() -> intel_pmu_init()
> -> intel_pmu_arch_lbr_init(), the code selects the highest supported bit
> and validates that unclamped depth against MSR_ARCH_LBR_DEPTH:
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
> 	...
> }
>
> If a CPU or hypervisor advertises a depth greater than 32 in
> lbr_depth_mask without also setting the bit for depth 32, clamping
> x86_pmu.lbr_nr to MAX_LBR_ENTRIES (32) here leaves x86_pmu.lbr_nr set to
> an unsupported depth that was never tested with wrmsrq_safe(). When
> cpuhp_setup_state() subsequently runs x86_pmu_starting_cpu() ->
> intel_pmu_cpu_starting() -> intel_pmu_lbr_reset() ->
> intel_pmu_arch_lbr_reset():
>
> arch/x86/events/intel/lbr.c:intel_pmu_arch_lbr_reset() {
> 	/* Write to ARCH_LBR_DEPTH MSR, all LBR entries are reset to 0 */
> 	wrmsrq(MSR_ARCH_LBR_DEPTH, x86_pmu.lbr_nr);
> }
>
> won't this unchecked wrmsrq() of 32 to MSR_ARCH_LBR_DEPTH raise a fatal
> #GP at boot?
>
> Additionally, because this clamp runs after vendor initialization has
> completed:
>
> 1. intel_pmu_arch_lbr_init() has already validated the XSAVE size via
>    is_arch_lbr_xsave_available() and allocated pmu->task_ctx_cache using
>    the unclamped lbr_nr.
>
> 2. intel_pmu_init() has already probed MSRs up to the unclamped
>    x86_pmu.lbr_nr and logged the unclamped depth:
>
> arch/x86/events/intel/core.c:intel_pmu_init() {
> 	...
> 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
> 		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
> 		      check_msr(x86_pmu.lbr_to + i, 0xffffUL)))
> 			x86_pmu.lbr_nr = 0;
> 	}
>
> 	if (x86_pmu.lbr_nr) {
> 		intel_pmu_lbr_init();
>
> 		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
> 	...
> }
>
> 3. amd_pmu_lbr_init() has likewise already logged the unclamped depth:
>
> arch/x86/events/amd/lbr.c:amd_pmu_lbr_init() {
> 	...
> 	x86_pmu.lbr_nr = ebx.split.lbr_v2_stack_sz;
>
> 	pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
> 	...
> }
>
> Should the MAX_LBR_ENTRIES limit be enforced at the point where
> x86_pmu.lbr_nr (and lbr_depth_mask in intel_pmu_arch_lbr_init()) is
> determined inside the vendor initialization paths instead?

Ok, directly clampling x86_pmu.lbr_nr to MAX_LBR_ENTRIES seems not a good way. The proper way could be to check if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES, if so, just error out the PMU initialization. Thanks.




>
>>  
>  완벽
>
