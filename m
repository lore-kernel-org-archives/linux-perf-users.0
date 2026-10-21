Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792563369;
	b=TUqq+54tj+jNR0hHN8SOfW28kAFlO4acspEC+ypJWGT0z45WzkYNQDhV5Nlh+UlZESUX
	 KkxjwSji554Rpk1/ym89CTU5e7vW+mTE8XVQ6u9jjGJGrpYfHTuGnf56Jjb5Q97Qqg52M
	 FicdgHRMnsWJ6EeTUCJvWihQZwstlwcPS/8VECwM2HvIb9+LGBbUNvq/7g6Ntp1U84SVg
	 8DTdJpzNmEbYP0gcF9vr55CS6DdXI05sA9eAHDnM10DiTDErYturL8rvaKjRzUr8Pt2Hi
	 HZuVQ11mw3UfQjrzGDdhLtXgrPJ0rbo4iHNadVPjmU6X/mhVAC0SFRNKUTE5NU5gbIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563369;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=oL3FgeJI0x+Mx58M2ht11EIcuLnRTWJFAOeyZyFpYP0=;
	b=fWl0IAxTCDWa4KhlhEY+O6rDX39bq2poZb48spaHfpwFeBfIfSpbh221jmMLP8K6cGBL
	 uK+l/kxKy+hAkAtbnPg21b5b5pToqezndVtEKSVkvj029wps6OlmmnHlUgMAFrciCoLCw
	 PKfwAYonAKs2P7LgsfopeFIra5xr39bcN/MKF5KweMe7tlZt+LFmpS27tC7aM0Fb3nmdp
	 IdCjQtgPf0Lzb/5Iv+KTZ+tu7/WeCYKcXQVS6bPrDomN5yr/EhRTVNC6s4JEgoVdj4DXC
	 4ADMT5xY004Os4odeR2ZaJKTk7oVRqaRASk8T07ywlpYC/mhFLszrT+BxOifYeL9SAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hr3ueABE;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB1E606A32F;
	Wed, 21 Oct 2026 06:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DB1E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hr3ueABE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792563369; x=1824099369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ur4h1KqeZyzqwlQX1kA8jO9lL69B6yZ2nvZdtkJ9v5g=;
  b=hr3ueABEzckop6O9hE/5spABsZef8ukqolJwsLWP8aT8Ph4UYntn1MXj
   T3vndDH9yltetLkqaL2xN2UQ782aMblTqAk6kXFqXlZ4IBMdw/OGmlBMU
   v+Y3iIwjCh2DYUlPUdhTLPh1kHVrOqZ++o70WOw2XZXvcyWYwA17LrwsX
   dzffwQJluL2Ea2cTnKY+6odlU3sxMF3ZID/kaDadAI8buGfQgYLAinon6
   iR8K6QhsCp7BxDofhiOXX3AfFGsGsQEvMrAVwWaWN4Q7K1wmYwgyz6eTg
   erc20EXSDn7g0Wtt6bzNbr1egp5YXSH22sHTWlViGMyyM2FjoL5dYd55o
   Q==;
X-CSE-ConnectionGUID: LxpmZQ5STwmooT3VOlTs1A==
X-CSE-MsgGUID: HXWeYBSmQNygwEkHYricwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1292123"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1292123"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:16:08 -0700
X-CSE-ConnectionGUID: EebOYou+Ru6HIUCixuo2oQ==
X-CSE-MsgGUID: pA6vuN6zSxOh4DhfzRrqkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3071004"
Received: from unknown (HELO [10.238.3.193]) ([10.238.3.193])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:16:07 -0700
Message-ID: <e8e0c5e0-46c7-4f34-abff-5f24ceba12f7@linux.intel.com>
Date: Wed, 21 Oct 2026 14:16:05 +0800
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
Subject: Re: [Patch v4 1/5] perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds
 MAX_LBR_ENTRIES
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
 <20261021050711.4043703-2-dapeng1.mi@linux.intel.com>
 <sashiko-outbox-179814@kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <sashiko-outbox-179814@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/21/2026 1:42 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf/x86: init_hw_perf_events() disables LBR too late after vendor PMU init
> --
>
> commit c6c1bbb1f4feb929dd247ddd507177ce58d871e1
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES
>
> This commit disables last branch record support in init_hw_perf_events()
> if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES to prevent out-of-bounds
> accesses in the cached branch stack handling path.
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 4df792b139e05..002a04c149c29 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2645,6 +2645,12 @@ static int __init init_hw_perf_events(void)
>>  	if (!x86_pmu.config_mask)
>>  		x86_pmu.config_mask = X86_RAW_EVENT_MASK;
>>  
>> +	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
>> +		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
>> +			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
>> +		x86_pmu.lbr_nr = 0;
>> +	}
>> +
>>  	perf_events_lapic_init();
>>  	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI");
> [Severity: Medium]
> Does zeroing x86_pmu.lbr_nr here in init_hw_perf_events() happen too late,
> after intel_pmu_init() and amd_pmu_init() have already configured hardware
> and driver state using the unvalidated x86_pmu.lbr_nr value?
>
> In arch/x86/events/intel/lbr.c:intel_pmu_arch_lbr_init(), if lbr_nr exceeds
> MAX_LBR_ENTRIES, initialization proceeds instead of taking the clear_arch_lbr
> path:
>
> 	lbr_nr = fls(eax.split.lbr_depth_mask) * 8;
> 	if (!lbr_nr)
> 		goto clear_arch_lbr;
>
> 	/* Apply the max depth of Arch LBR */
> 	if (wrmsrq_safe(MSR_ARCH_LBR_DEPTH, lbr_nr))
> 		goto clear_arch_lbr;
> 	...
> 	x86_pmu.lbr_counters = ecx.split.lbr_counters;
> 	x86_pmu.lbr_nr = lbr_nr;
>
> 	if (!!x86_pmu.lbr_counters)
> 		x86_pmu.flags |= PMU_FL_BR_CNTR | PMU_FL_DYN_CONSTRAINT;
>
> Because clear_arch_lbr is skipped, X86_FEATURE_ARCH_LBR remains enabled,
> MSR_ARCH_LBR_DEPTH is written, pmu->task_ctx_cache is allocated via
> create_lbr_kmem_cache(), and x86_pmu.lbr_ctl_map and static branches are
> configured.
>
> Subsequently, arch/x86/events/intel/lbr.c:reserve_lbr_buffers() checks the
> feature bit and task_ctx_cache rather than x86_pmu.lbr_nr:
>
> 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR))
> 		return;
>
> 	for_each_possible_cpu(cpu) {
> 		cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
> 		kmem_cache = x86_get_pmu(cpu)->task_ctx_cache;
> 		if (!kmem_cache || cpuc->lbr_xsave)
> 			continue;
>
> 		cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache,
> 							GFP_KERNEL | __GFP_ZERO,
> 							cpu_to_node(cpu));
> 	}
>
> Wouldn't this still allocate per-cpu cpuc->lbr_xsave buffers on hardware
> reservation even after x86_pmu.lbr_nr is set to 0?
>
> Similarly, in arch/x86/events/intel/core.c:lbr_is_visible(), leaving
> PMU_FL_BR_CNTR set in x86_pmu.flags keeps branch_counter_nr and
> branch_counter_width visible in sysfs when x86_pmu.lbr_nr is 0:
>
> 	/* branches */
> 	if (i == 0)
> 		return x86_pmu.lbr_nr ? attr->mode : 0;
>
> 	return (x86_pmu.flags & PMU_FL_BR_CNTR) ? attr->mode : 0;
>
> In addition, both arch/x86/events/intel/core.c:intel_pmu_init() and
> arch/x86/events/amd/core.c:amd_core_pmu_init() check x86_pmu.lbr_nr before
> init_hw_perf_events() clears it:
>
> 	if (x86_pmu.lbr_nr) {
> 		intel_pmu_lbr_init();
>
> 		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
>
> 		/* only support branch_stack snapshot for perfmon >= v2 */
> 		if (x86_pmu.disable_all == intel_pmu_disable_all) {
> 			if (boot_cpu_has(X86_FEATURE_ARCH_LBR)) {
> 				static_call_update(perf_snapshot_branch_stack,
> 						   intel_pmu_snapshot_arch_branch_stack);
> 			} else {
> 				static_call_update(perf_snapshot_branch_stack,
> 						   intel_pmu_snapshot_branch_stack);
> 			}
> 		}
> 	}
>
> And in amd_core_pmu_init():
>
> 	if (!amd_pmu_lbr_init()) {
> 		/* LBR requires flushing on context switch */
> 		x86_pmu.sched_task = amd_pmu_lbr_sched_task;
> 		static_call_update(amd_pmu_branch_hw_config, amd_pmu_lbr_hw_config);
> 		static_call_update(amd_pmu_branch_reset, amd_pmu_lbr_reset);
> 		static_call_update(amd_pmu_branch_add, amd_pmu_lbr_add);
> 		static_call_update(amd_pmu_branch_del, amd_pmu_lbr_del);
>
> 		/* Only support branch_stack snapshot on perfmon v2 */
> 		if (x86_pmu.handle_irq == amd_pmu_v2_handle_irq)
> 			static_call_update(perf_snapshot_branch_stack, amd_pmu_v2_snapshot_branch_stack);
> 	} else if (!amd_brs_init()) {
>
> If bpf_get_branch_snapshot() is later called when x86_pmu.lbr_nr is 0, won't
> the registered perf_snapshot_branch_stack callback still run, manipulate
> branch and global control registers, and unconditionally call
> intel_pmu_enable_all(0) or amd_pmu_v2_enable_all(0)?
>
> Should the MAX_LBR_ENTRIES check be performed before or during the
> vendor-specific initialization routines (such as intel_pmu_lbr_init(),
> intel_pmu_arch_lbr_init(), and amd_pmu_lbr_init()) so that None of the
> hardware state, slab caches, flags, or static calls are enabled when
> lbr_nr is out of range?

The change is good enough. The branch sampling perf event creation is
guarded with x86_pmu.lbr_nr regardless of on Intel or AMD platforms. If
x86_pmu.lbr_nr is 0, then no events with branch sampling can be created
successfully, and if no active LBR event is present, the LBR hardware is
not really enabled.

Since it's a common validation for all x86 vendor platforms, it should be
placed into the x86 common PMU initialization path.

Thanks.


>
