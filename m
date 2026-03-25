Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B331A5B9D;
	Wed, 25 Mar 2026 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423843; cv=none; b=Ky+oWCIsBF5fwJiSKlUI7H8pg2WtwFx5ZGO7UefQSiT4IChvASEDmbU7SVHLaRZSwZpyEnp2uas93YTNXKNKFoqSLFRL7oMLHgAuv5N6k7Tx80D8EAD6wFRRSerMPsL2cxsvXwrDz3EbMCjJqHsaanFJ+sfdmwmOY2YhYqfNCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423843; c=relaxed/simple;
	bh=s3hC8H/CAbpDhgG7XgndWPmi8g5J2apl4ZhBr3StsyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaYWlpciV5AYZ5UNOQB8GslCxh5LKC+CuO8ZE8AfA/Kjf5/ewwq9oeEI2qjElENf8odBcyit0F2CQAYqJ3Wqny7Xhj/vrZbCEOerilVOGFsyKlLs3SoNrozC7DjyMVKR6C6H9/tcAuPcTscrOeUaNQ56bXg/u1ntzsh/52nt08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=el3UO8xc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="el3UO8xc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774423841; x=1805959841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s3hC8H/CAbpDhgG7XgndWPmi8g5J2apl4ZhBr3StsyU=;
  b=el3UO8xc9tkRbfj3U/7Rg/K6tV/rqfpwU+lqb54GDCVfjKmUGHAiy8No
   uw5cT4qOtT40wqJdAAkfepi1bUyTMhLdLA5A/zagbwVDq6CKDzStflwnB
   40vADeUO3ab1Ycvdt04+beZeZaRR8TaNxXuCP0XbbudfbFkGJ+v2ruoZU
   DgCCihXlVs3XcTNftEDpEDVy001SbCM3XSAoPRy6C5L/b5D5CMBtDdD2v
   uMaPz6/IXd8e75++o/dYA31uz6zdTYIEtqvyKAgS/v+vOh78+S60eYjzT
   1yKjU63l6uMVlyYJ6w75Zc2wo62WW3cM/ouIZ1WDo8fGd+HOrBdi5xx5w
   A==;
X-CSE-ConnectionGUID: O7cWkyHiRze3iUfjkU7bPw==
X-CSE-MsgGUID: widns9YDQ3iCaL4m5zWofA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="98077246"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="98077246"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 00:30:40 -0700
X-CSE-ConnectionGUID: d0VMq9DHSjmfplnnAYLLqw==
X-CSE-MsgGUID: qKHxUcwVTYmiKlJRvLit6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="219738946"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 00:30:35 -0700
Message-ID: <5a25943a-5d71-4d32-bc7a-88339eb7ba86@linux.intel.com>
Date: Wed, 25 Mar 2026 15:30:32 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 11/24] perf/x86: Enable XMM Register Sampling for
 Non-PEBS Events
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
 <20260324004118.3772171-12-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260324004118.3772171-12-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/24/2026 8:41 AM, Dapeng Mi wrote:
> Previously, XMM register sampling was only available for PEBS events
> starting from Icelake. Currently the support is now extended to non-PEBS
> events by utilizing the xsaves instruction, thereby completing the
> feature set.
>
> To implement this, a 64-byte aligned buffer is required. A per-CPU
> ext_regs_buf is introduced to store SIMD and other registers, with an
> approximate size of 2K. The buffer is allocated using kzalloc_node(),
> ensuring natural and 64-byte alignment for all kmalloc() allocations
> with powers of 2.
>
> XMM sampling for non-PEBS events is supported in the REGS_INTR case.
> Support for REGS_USER will be added in a subsequent patch. For PEBS
> events, XMM register sampling data is directly retrieved from PEBS
> records.
>
> Future support for additional vector registers (YMM/ZMM/OPMASK) is
> planned. An `ext_regs_mask` is added to track the supported vector
> register groups.
>
> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>
> V7: Optimize and simplify x86_pmu_sample_xregs(), etc. No functional
> change.
>
>  arch/x86/events/core.c            | 139 +++++++++++++++++++++++++++---
>  arch/x86/events/intel/core.c      |  31 ++++++-
>  arch/x86/events/intel/ds.c        |  20 +++--
>  arch/x86/events/perf_event.h      |  11 ++-
>  arch/x86/include/asm/fpu/xstate.h |   2 +
>  arch/x86/include/asm/perf_event.h |   5 +-
>  arch/x86/kernel/fpu/xstate.c      |   2 +-
>  7 files changed, 185 insertions(+), 25 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 0a6c51e86e9b..22965a8a22b3 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -410,6 +410,45 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
>  	return x86_pmu_extra_regs(val, event);
>  }
>  
> +static DEFINE_PER_CPU(struct xregs_state *, ext_regs_buf);
> +
> +static void release_ext_regs_buffers(void)
> +{
> +	int cpu;
> +
> +	if (!x86_pmu.ext_regs_mask)
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		kfree(per_cpu(ext_regs_buf, cpu));
> +		per_cpu(ext_regs_buf, cpu) = NULL;
> +	}
> +}
> +
> +static void reserve_ext_regs_buffers(void)
> +{
> +	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
> +	unsigned int size;
> +	int cpu;
> +
> +	if (!x86_pmu.ext_regs_mask)
> +		return;
> +
> +	size = xstate_calculate_size(x86_pmu.ext_regs_mask, compacted);
> +
> +	for_each_possible_cpu(cpu) {
> +		per_cpu(ext_regs_buf, cpu) = kzalloc_node(size, GFP_KERNEL,
> +							  cpu_to_node(cpu));

Paste Sashiko (AI review agent)'s comments here.

"

Does kzalloc_node() guarantee the strict 64-byte alignment required by the 
XSAVES instruction? If debugging options like CONFIG_KANSAN or 
CONFIG_SLUB_DEBUG add redzone padding, could this shift the object offset 
and trigger a #GP fault in NMI context?

"

Although kzalloc_node() (essentially kmalloc()) usually returns a
power-of-two aligned address. When the allocated size is larger than 64
bytes that the xstate size meets this requirement, the allocated memory
usually aligns at 64 bytes. But it's not a strict API guarantee.

I'm not quite sure if the CONFIG_KANSAN and CONFIG_SLUB_DEBUG would break
the alignment although the explanation for these items looks reasonable. I
enabled these 2 Kconfig items and test xsaves based sampling on NVL, but no
crash is found. 

It may be lucky. Anyway, we need to ensure the xsave memory is 64 bytes
aligned and don't just depend on the internal implementation of
kzalloc_node(). It's some kind of risky. Would add a force alignment in
next version.


> +		if (!per_cpu(ext_regs_buf, cpu))
> +			goto err;
> +	}
> +
> +	return;
> +
> +err:
> +	release_ext_regs_buffers();
> +}
> +
>  int x86_reserve_hardware(void)
>  {
>  	int err = 0;
> @@ -422,6 +461,7 @@ int x86_reserve_hardware(void)
>  			} else {
>  				reserve_ds_buffers();
>  				reserve_lbr_buffers();
> +				reserve_ext_regs_buffers();
>  			}
>  		}
>  		if (!err)
> @@ -438,6 +478,7 @@ void x86_release_hardware(void)
>  		release_pmc_hardware();
>  		release_ds_buffers();
>  		release_lbr_buffers();
> +		release_ext_regs_buffers();
>  		mutex_unlock(&pmc_reserve_mutex);
>  	}
>  }
> @@ -655,18 +696,23 @@ int x86_pmu_hw_config(struct perf_event *event)
>  			return -EINVAL;
>  	}
>  
> -	/* sample_regs_user never support XMM registers */
> -	if (unlikely(event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK))
> -		return -EINVAL;
> -	/*
> -	 * Besides the general purpose registers, XMM registers may
> -	 * be collected in PEBS on some platforms, e.g. Icelake
> -	 */
> -	if (unlikely(event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK)) {
> -		if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
> -			return -EINVAL;
> +	if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
> +		/*
> +		 * Besides the general purpose registers, XMM registers may
> +		 * be collected as well.
> +		 */
> +		if (event_has_extended_regs(event)) {
> +			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
> +				return -EINVAL;
> +		}
> +	}
>  
> -		if (!event->attr.precise_ip)
> +	if (event->attr.sample_type & PERF_SAMPLE_REGS_USER) {
> +		/*
> +		 * Currently XMM registers sampling for REGS_USER is not
> +		 * supported yet.
> +		 */
> +		if (event_has_extended_regs(event))
>  			return -EINVAL;
>  	}
>  
> @@ -1699,9 +1745,9 @@ static void x86_pmu_del(struct perf_event *event, int flags)
>  	static_call_cond(x86_pmu_del)(event);
>  }
>  
> -void x86_pmu_setup_regs_data(struct perf_event *event,
> -			     struct perf_sample_data *data,
> -			     struct pt_regs *regs)
> +static void x86_pmu_setup_gpregs_data(struct perf_event *event,
> +				      struct perf_sample_data *data,
> +				      struct pt_regs *regs)
>  {
>  	struct perf_event_attr *attr = &event->attr;
>  	u64 sample_type = attr->sample_type;
> @@ -1732,6 +1778,71 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
>  	}
>  }
>  
> +inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
> +{
> +	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
> +
> +	perf_regs->xmm_regs = NULL;
> +}
> +
> +static inline void x86_pmu_update_xregs(struct x86_perf_regs *perf_regs,
> +					struct xregs_state *xsave, u64 bitmap)
> +{
> +	u64 mask;
> +
> +	if (!xsave)
> +		return;
> +
> +	/* Filtered by what XSAVE really gives */
> +	mask = bitmap & xsave->header.xfeatures;
> +
> +	if (mask & XFEATURE_MASK_SSE)
> +		perf_regs->xmm_space = xsave->i387.xmm_space;
> +}
> +
> +static void x86_pmu_sample_xregs(struct perf_event *event,
> +				 struct perf_sample_data *data,
> +				 u64 ignore_mask)
> +{
> +	struct xregs_state *xsave = per_cpu(ext_regs_buf, smp_processor_id());
> +	u64 sample_type = event->attr.sample_type;
> +	struct x86_perf_regs *perf_regs;
> +	u64 intr_mask = 0;
> +	u64 mask = 0;
> +
> +	if (WARN_ON_ONCE(!xsave))
> +		return;
> +
> +	if (event_has_extended_regs(event))
> +		mask |= XFEATURE_MASK_SSE;
> +
> +	mask &= x86_pmu.ext_regs_mask;
> +
> +	if ((sample_type & PERF_SAMPLE_REGS_INTR) && data->regs_intr.abi)
> +		intr_mask = mask & ~ignore_mask;
> +
> +	if (intr_mask) {
> +		perf_regs = container_of(data->regs_intr.regs,
> +					 struct x86_perf_regs, regs);
> +		xsave->header.xfeatures = 0;
> +		xsaves_nmi(xsave, mask);
> +		x86_pmu_update_xregs(perf_regs, xsave, intr_mask);
> +	}
> +}
> +
> +void x86_pmu_setup_regs_data(struct perf_event *event,
> +			     struct perf_sample_data *data,
> +			     struct pt_regs *regs,
> +			     u64 ignore_mask)
> +{
> +	x86_pmu_setup_gpregs_data(event, data, regs);
> +	/*
> +	 * ignore_mask indicates the PEBS sampled extended regs
> +	 * which are unnecessary to sample again.
> +	 */
> +	x86_pmu_sample_xregs(event, data, ignore_mask);
> +}
> +
>  int x86_pmu_handle_irq(struct pt_regs *regs)
>  {
>  	struct perf_sample_data data;
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 5a2b1503b6a5..5772dcc3bcbd 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3649,6 +3649,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		if (has_branch_stack(event))
>  			intel_pmu_lbr_save_brstack(&data, cpuc, event);
>  
> +		x86_pmu_clear_perf_regs(regs);
> +		x86_pmu_setup_regs_data(event, &data, regs, 0);
> +
>  		perf_event_overflow(event, &data, regs);
>  	}
>  
> @@ -5884,8 +5887,32 @@ static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
>  	}
>  }
>  
> -#define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
> +static void intel_extended_regs_init(struct pmu *pmu)
> +{
> +	struct pmu *dest_pmu = pmu ? pmu : x86_get_pmu(smp_processor_id());
> +
> +	/*
> +	 * Extend the vector registers support to non-PEBS.
> +	 * The feature is limited to newer Intel machines with
> +	 * PEBS V4+ or archPerfmonExt (0x23) enabled for now.
> +	 * In theory, the vector registers can be retrieved as
> +	 * long as the CPU supports. The support for the old
> +	 * generations may be added later if there is a
> +	 * requirement.
> +	 * Only support the extension when XSAVES is available.
> +	 */
> +	if (!boot_cpu_has(X86_FEATURE_XSAVES))
> +		return;
> +
> +	if (!boot_cpu_has(X86_FEATURE_XMM) ||
> +	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
> +		return;
>  
> +	x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
> +	dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
> +}
> +
> +#define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
>  static void update_pmu_cap(struct pmu *pmu)
>  {
>  	unsigned int eax, ebx, ecx, edx;
> @@ -5949,6 +5976,8 @@ static void update_pmu_cap(struct pmu *pmu)
>  		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
>  		rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
>  	}
> +
> +	intel_extended_regs_init(pmu);
>  }
>  
>  static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index b045297c02d0..74a41dae8a62 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1743,8 +1743,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
>  	if (gprs || (attr->precise_ip < 2) || tsx_weight)
>  		pebs_data_cfg |= PEBS_DATACFG_GP;
>  
> -	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
> -	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
> +	if (event_has_extended_regs(event))
>  		pebs_data_cfg |= PEBS_DATACFG_XMMS;
>  
>  	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> @@ -2460,10 +2459,8 @@ static inline void __setup_pebs_gpr_group(struct perf_event *event,
>  		regs->flags &= ~PERF_EFLAGS_EXACT;
>  	}
>  
> -	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
> +	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
>  		adaptive_pebs_save_regs(regs, gprs);
> -		x86_pmu_setup_regs_data(event, data, regs);
> -	}
>  }
>  
>  static inline void __setup_pebs_meminfo_group(struct perf_event *event,
> @@ -2521,6 +2518,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>  	struct pebs_meminfo *meminfo = NULL;
>  	struct pebs_gprs *gprs = NULL;
>  	struct x86_perf_regs *perf_regs;
> +	u64 ignore_mask = 0;
>  	u64 format_group;
>  	u16 retire;
>  
> @@ -2528,7 +2526,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>  		return;
>  
>  	perf_regs = container_of(regs, struct x86_perf_regs, regs);
> -	perf_regs->xmm_regs = NULL;
> +	x86_pmu_clear_perf_regs(regs);
>  
>  	format_group = basic->format_group;
>  
> @@ -2575,6 +2573,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>  	if (format_group & PEBS_DATACFG_XMMS) {
>  		struct pebs_xmm *xmm = next_record;
>  
> +		ignore_mask |= XFEATURE_MASK_SSE;
>  		next_record = xmm + 1;
>  		perf_regs->xmm_regs = xmm->xmm;
>  	}
> @@ -2613,6 +2612,8 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>  		next_record += nr * sizeof(u64);
>  	}
>  
> +	x86_pmu_setup_regs_data(event, data, regs, ignore_mask);
> +
>  	WARN_ONCE(next_record != __pebs + basic->format_size,
>  			"PEBS record size %u, expected %llu, config %llx\n",
>  			basic->format_size,
> @@ -2638,6 +2639,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
>  	struct arch_pebs_aux *meminfo = NULL;
>  	struct arch_pebs_gprs *gprs = NULL;
>  	struct x86_perf_regs *perf_regs;
> +	u64 ignore_mask = 0;
>  	void *next_record;
>  	void *at = __pebs;
>  
> @@ -2645,7 +2647,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
>  		return;
>  
>  	perf_regs = container_of(regs, struct x86_perf_regs, regs);
> -	perf_regs->xmm_regs = NULL;
> +	x86_pmu_clear_perf_regs(regs);
>  
>  	__setup_perf_sample_data(event, iregs, data);
>  
> @@ -2700,6 +2702,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
>  
>  		next_record += sizeof(struct arch_pebs_xer_header);
>  
> +		ignore_mask |= XFEATURE_MASK_SSE;
>  		xmm = next_record;
>  		perf_regs->xmm_regs = xmm->xmm;
>  		next_record = xmm + 1;
> @@ -2747,6 +2750,8 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
>  		at = at + header->size;
>  		goto again;
>  	}
> +
> +	x86_pmu_setup_regs_data(event, data, regs, ignore_mask);
>  }
>  
>  static inline void *
> @@ -3409,6 +3414,7 @@ static void __init intel_ds_pebs_init(void)
>  				x86_pmu.flags |= PMU_FL_PEBS_ALL;
>  				x86_pmu.pebs_capable = ~0ULL;
>  				pebs_qual = "-baseline";
> +				x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
>  				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
>  			} else {
>  				/* Only basic record supported */

Sashiko complains

"

Is it safe to unconditionally set ext_regs_mask |= XFEATURE_MASK_SSE and 
PERF_PMU_CAP_EXTENDED_REGS here if the CPU doesn't support XSAVES? If a 
user boots with noxsaves or a hypervisor hides it, could a non-PEBS event 
requesting extended registers trigger an Invalid Opcode (#UD) exception 
when the NMI handler later executes the XSAVES instruction?

"

Hmm, it looks reasonable, especially in guest environment. Would check if
xsaves is supported here. 



> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 39c41947c70d..a5e5bffb711e 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1020,6 +1020,12 @@ struct x86_pmu {
>  	struct extra_reg *extra_regs;
>  	unsigned int flags;
>  
> +	/*
> +	 * Extended regs, e.g., vector registers
> +	 * Utilize the same format as the XFEATURE_MASK_*
> +	 */
> +	u64		ext_regs_mask;
> +
>  	/*
>  	 * Intel host/guest support (KVM)
>  	 */
> @@ -1306,9 +1312,12 @@ void x86_pmu_enable_event(struct perf_event *event);
>  
>  int x86_pmu_handle_irq(struct pt_regs *regs);
>  
> +void x86_pmu_clear_perf_regs(struct pt_regs *regs);
> +
>  void x86_pmu_setup_regs_data(struct perf_event *event,
>  			     struct perf_sample_data *data,
> -			     struct pt_regs *regs);
> +			     struct pt_regs *regs,
> +			     u64 ignore_mask);
>  
>  void x86_pmu_show_pmu_cap(struct pmu *pmu);
>  
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 38fa8ff26559..19dec5f0b1c7 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -112,6 +112,8 @@ void xsaves(struct xregs_state *xsave, u64 mask);
>  void xrstors(struct xregs_state *xsave, u64 mask);
>  void xsaves_nmi(struct xregs_state *xsave, u64 mask);
>  
> +unsigned int xstate_calculate_size(u64 xfeatures, bool compacted);
> +
>  int xfd_enable_feature(u64 xfd_err);
>  
>  #ifdef CONFIG_X86_64
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 752cb319d5ea..e47a963a7cf0 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -726,7 +726,10 @@ extern void perf_events_lapic_init(void);
>  struct pt_regs;
>  struct x86_perf_regs {
>  	struct pt_regs	regs;
> -	u64		*xmm_regs;
> +	union {
> +		u64	*xmm_regs;
> +		u32	*xmm_space;	/* for xsaves */
> +	};
>  };
>  
>  extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 39e5f9e79a4c..93631f7a638e 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -587,7 +587,7 @@ static bool __init check_xstate_against_struct(int nr)
>  	return true;
>  }
>  
> -static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
> +unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
>  {
>  	unsigned int topmost = fls64(xfeatures) -  1;
>  	unsigned int offset, i;
