Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6C3ED125;
	Tue, 19 May 2026 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229599; cv=none; b=J0Kl1pfZSQfMkJk4s+oYNtwNT0t/GHCt621X9SoVboyQ8nJp9oS8OKduAbAg+xNV+qqqo3Z92gt32AEDVrTED96LqgRRPI7oT1CXYxJTQX9cKSsRvxCcSuokpxjakGZYmFIyr9rkFPYkEFyT/dPZ9lNZMf+4shpnuYfr4lkklQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229599; c=relaxed/simple;
	bh=qC6ZkzuJhMKjkQUdloEOBbVZ0Pawzda//HBxaZIPZFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYdr2awwHs/8sCb/trx2psJ5JDQox6idM6bbtCZEqEufOVayLdAuM4K3uvPY5UubT1J5yMH1VYX0BgjEPX9ocllqDo5K5UmLOLlYt0VRRGTpyG6ruY9MJhrcI5aUlKysiXB75nqg1H71b8YY4ysCZzqOWcGM2TDD2T+qH7gMb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwNsawFR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwNsawFR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779229598; x=1810765598;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qC6ZkzuJhMKjkQUdloEOBbVZ0Pawzda//HBxaZIPZFc=;
  b=GwNsawFRtWt4Z4nDHifK0JNVz0qxQ6fcSXxYSR39wjJvyYP0eonO6sn+
   CK9O9HrPRSQ0/9CyZoIYHc9/PEQRRLKiy7AN0sFR0WiozG4S8JD4a7j1Y
   7b19ohL2lYEcWM/agGzYKPwrVPkSb9zf0kyEoKO+Yamhc8Zs4J7yTY0LQ
   ehdZ0URDrjzRKn3/0qa8jM1t19mrSf5SaKX8TkPVrES7p3deYtLd3764x
   0d8yxqw2qKh4b8Yn2DQxmbWfuhMLzsXrhsn5gwwMUmNItYrNDUWOXHtoY
   2/msG7Y2b10byAcylwChDo21dqGtAcG3qyTcabi1O1X4H2JA/bUDUfGj0
   A==;
X-CSE-ConnectionGUID: 5prO3Fb8QjG/+culFwSEkA==
X-CSE-MsgGUID: RhkxfYf+TwGUWide7aVyMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="105580571"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="105580571"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:26:37 -0700
X-CSE-ConnectionGUID: XqrpW/RCRwKgq18VobT7cA==
X-CSE-MsgGUID: UCOy+/nrQG2/QvyNF0Tnpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239971773"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:26:35 -0700
Message-ID: <cec4a6d6-26a6-45ed-be70-620247d4451b@intel.com>
Date: Tue, 19 May 2026 17:26:34 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] perf/x86/intel: Update event constraints and
 cache_extra_regs[] for ADL
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
 <20260515061143.338553-5-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260515061143.338553-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 11:11 PM, Dapeng Mi wrote:
> Update perf hard-coded event constraints and cache_extra_regs[] for
> Alderlake according to the latest ADL perfmon events (V1.39).
> 
> One important note is that ADL has differences on the L3/node related
> OCR events although it shares same uarch with SPR server, e.g.,
> ADL has different extra MSR values and no node events. So some variants
> of structures and functions are introduced to reflect these
> differences, like adl_glc_hw_cache_event_ids[],
> adl_glc_hw_cache_extra_regs[] and intel_pmu_init_glc_hybrid(), etc.
> 
> Please note these changes would temporarily impact other platforms like
> MTL/ARL-U which shares hard-coded event structures, but it would be
> fixed soon in subsequent patches.

Ditto, could the code be rearranged to avoid this?


> ADL perfmon events:
> https://github.com/intel/perfmon/blob/main/ADL/events/alderlake_goldencove_core.json
> https://github.com/intel/perfmon/blob/main/ADL/events/alderlake_gracemont_core.json
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 137 +++++++++++++++++++++++++++++++++--
>  arch/x86/events/intel/ds.c   |   2 +-
>  2 files changed, 131 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0d0edc2d1b90..7948e3afc291 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -215,8 +215,10 @@ static struct event_constraint intel_slm_event_constraints[] __read_mostly =
>  
>  static struct event_constraint intel_grt_event_constraints[] __read_mostly = {
>  	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
> +	FIXED_EVENT_CONSTRAINT(0x0100, 0), /* pseudo INST_RETIRED.ANY */
>  	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
> -	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF */
> +	FIXED_EVENT_CONSTRAINT(0x0200, 1), /* pseudo CPU_CLK_UNHALTED.THREAD */
> +	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF_TSC */
>  	FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P */
>  	EVENT_CONSTRAINT_END
>  };
> @@ -713,6 +715,80 @@ static __initconst const u64 glc_hw_cache_event_ids
>   },
>  };
>  
> +/* ADL P-core (Golden cove) specific event code. */
> +static __initconst const u64 adl_glc_hw_cache_event_ids
> +				[PERF_COUNT_HW_CACHE_MAX]
> +				[PERF_COUNT_HW_CACHE_OP_MAX]
> +				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
> +{
> + [ C(L1D ) ] = {
> +	[ C(OP_READ) ] = {
> +		[ C(RESULT_ACCESS) ] = 0x81d0,
> +		[ C(RESULT_MISS)   ] = 0xe124,
> +	},
> +	[ C(OP_WRITE) ] = {
> +		[ C(RESULT_ACCESS) ] = 0x82d0,
> +	},
> + },
> + [ C(L1I ) ] = {
> +	[ C(OP_READ) ] = {
> +		[ C(RESULT_MISS)   ] = 0xe424,
> +	},
> +	[ C(OP_WRITE) ] = {
> +		[ C(RESULT_ACCESS) ] = -1,
> +		[ C(RESULT_MISS)   ] = -1,
> +	},
> + },
> + [ C(LL  ) ] = {
> +	[ C(OP_READ) ] = {
> +		[ C(RESULT_ACCESS) ] = 0x12a,
> +		[ C(RESULT_MISS)   ] = 0x12a,
> +	},
> +	[ C(OP_WRITE) ] = {
> +		[ C(RESULT_ACCESS) ] = 0x12a,
> +		[ C(RESULT_MISS)   ] = 0x12a,
> +	},
> + },
> + [ C(DTLB) ] = {
> +	[ C(OP_READ) ] = {
> +		[ C(RESULT_ACCESS) ] = 0x81d0,
> +		[ C(RESULT_MISS)   ] = 0xe12,
> +	},
> +	[ C(OP_WRITE) ] = {
> +		[ C(RESULT_ACCESS) ] = 0x82d0,
> +		[ C(RESULT_MISS)   ] = 0xe13,
> +	},
> + },
> + [ C(ITLB) ] = {
> +	[ C(OP_READ) ] = {
> +		[ C(RESULT_ACCESS) ] = -1,
> +		[ C(RESULT_MISS)   ] = 0xe11,
> +	},
> +	[ C(OP_WRITE) ] = {
> +		[ C(RESULT_ACCESS) ] = -1,
> +		[ C(RESULT_MISS)   ] = -1,
> +	},
> +	[ C(OP_PREFETCH) ] = {
> +		[ C(RESULT_ACCESS) ] = -1,
> +		[ C(RESULT_MISS)   ] = -1,
> +	},
> + },
> + [ C(BPU ) ] = {
> +	[ C(OP_READ) ] = {
> +		[ C(RESULT_ACCESS) ] = 0x4c4,
> +		[ C(RESULT_MISS)   ] = 0x4c5,
> +	},
> +	[ C(OP_WRITE) ] = {
> +		[ C(RESULT_ACCESS) ] = -1,
> +		[ C(RESULT_MISS)   ] = -1,
> +	},
> +	[ C(OP_PREFETCH) ] = {
> +		[ C(RESULT_ACCESS) ] = -1,
> +		[ C(RESULT_MISS)   ] = -1,
> +	},
> + },
> +};
> +
>  static __initconst const u64 glc_hw_cache_extra_regs
>  				[PERF_COUNT_HW_CACHE_MAX]
>  				[PERF_COUNT_HW_CACHE_OP_MAX]
> @@ -736,6 +812,24 @@ static __initconst const u64 glc_hw_cache_extra_regs
>   },
>  };
>  
> +/* ADL P-core (Golden cove) specific extra regs value. */
> +static __initconst const u64 adl_glc_hw_cache_extra_regs
> +				[PERF_COUNT_HW_CACHE_MAX]
> +				[PERF_COUNT_HW_CACHE_OP_MAX]
> +				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
> +{
> + [ C(LL  ) ] = {
> +	[ C(OP_READ) ] = {
> +		[ C(RESULT_ACCESS) ] = 0x10001,		/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
> +		[ C(RESULT_MISS)   ] = 0x3fbfc00001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
> +	},
> +	[ C(OP_WRITE) ] = {
> +		[ C(RESULT_ACCESS) ] = 0x10002,		/* OCR.DEMAND_RFO.ANY_RESPONSE */
> +		[ C(RESULT_MISS)   ] = 0x3fbfc00002,	/* OCR.DEMAND_RFO.L3_MISS */
> +	},
> + },
> +};
> +
>  static __initconst const u64 pnc_hw_cache_event_ids
>  				[PERF_COUNT_HW_CACHE_MAX]
>  				[PERF_COUNT_HW_CACHE_OP_MAX]
> @@ -2384,6 +2478,23 @@ static __initconst const u64 tnt_hw_cache_extra_regs
>  	},
>  };
>  
> +static __initconst const u64 grt_hw_cache_extra_regs
> +				[PERF_COUNT_HW_CACHE_MAX]
> +				[PERF_COUNT_HW_CACHE_OP_MAX]
> +				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
> +	[C(LL)] = {
> +		[C(OP_READ)] = {
> +			[C(RESULT_ACCESS)]	= 0x10001,	/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
> +			[C(RESULT_MISS)]	= 0x3F84400001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
> +		},
> +		[C(OP_WRITE)] = {
> +			[C(RESULT_ACCESS)]	= 0x10002,	/* OCR.DEMAND_RFO.ANY_RESPONSE */
> +			[C(RESULT_MISS)]	= 0x3F84400002,	/* OCR.DEMAND_RFO.L3_MISS */
> +		},
> +	},
> +};
> +
> +
>  static __initconst const u64 arw_hw_cache_extra_regs
>  				[PERF_COUNT_HW_CACHE_MAX]
>  				[PERF_COUNT_HW_CACHE_OP_MAX]
> @@ -2434,9 +2545,12 @@ static struct attribute *grt_mem_attrs[] = {
>  };
>  
>  static struct extra_reg intel_grt_extra_regs[] __read_mostly = {
> -	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
> -	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffffffffull, RSP_0),
> -	INTEL_UEVENT_EXTRA_REG(0x02b7, MSR_OFFCORE_RSP_1, 0x3fffffffffull, RSP_1),
> +	/*
> +	 * Must define OFFCORE_RSP_X first, see intel_fixup_er().
> +	 * Bit 63 only valid on OFFCORE_RSP_0 MSR.
> +	 */
> +	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x8003f03fffffffffull, RSP_0),
> +	INTEL_UEVENT_EXTRA_REG(0x02b7, MSR_OFFCORE_RSP_1, 0x3f03fffffffffull, RSP_1),
>  	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x5d0),
>  	EVENT_EXTRA_END
>  };
> @@ -7499,6 +7613,15 @@ static __always_inline void intel_pmu_init_glc(struct pmu *pmu)
>  	intel_pmu_ref_cycles_ext();
>  }
>  
> +static __always_inline void intel_pmu_init_glc_hybrid(struct pmu *pmu)
> +{
> +	intel_pmu_init_glc(pmu);
> +
> +	/* ADL has different extra MSR values from Server for the L3 or node OCR/OMR events. */
> +	memcpy(hybrid_var(pmu, hw_cache_event_ids), adl_glc_hw_cache_event_ids, sizeof(hw_cache_event_ids));
> +	memcpy(hybrid_var(pmu, hw_cache_extra_regs), adl_glc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
> +}
> +
>  static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
>  {
>  	x86_pmu.mid_ack = true;
> @@ -7511,7 +7634,7 @@ static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
>  	x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
>  
>  	memcpy(hybrid_var(pmu, hw_cache_event_ids), glp_hw_cache_event_ids, sizeof(hw_cache_event_ids));
> -	memcpy(hybrid_var(pmu, hw_cache_extra_regs), tnt_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
> +	memcpy(hybrid_var(pmu, hw_cache_extra_regs), grt_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
>  	hybrid_var(pmu, hw_cache_event_ids)[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
>  	hybrid(pmu, event_constraints) = intel_grt_event_constraints;
>  	hybrid(pmu, pebs_constraints) = intel_grt_pebs_event_constraints;
> @@ -8269,7 +8392,7 @@ __init int intel_pmu_init(void)
>  
>  		/* Initialize big core specific PerfMon capabilities.*/
>  		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
> -		intel_pmu_init_glc(&pmu->pmu);
> +		intel_pmu_init_glc_hybrid(&pmu->pmu);
>  		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
>  			pmu->cntr_mask64 <<= 2;
>  			pmu->cntr_mask64 |= 0x3;
> @@ -8326,7 +8449,7 @@ __init int intel_pmu_init(void)
>  
>  		/* Initialize big core specific PerfMon capabilities.*/
>  		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
> -		intel_pmu_init_glc(&pmu->pmu);
> +		intel_pmu_init_glc_hybrid(&pmu->pmu);
>  		pmu->extra_regs = intel_rwc_extra_regs;
>  
>  		/* Initialize Atom core specific PerfMon capabilities.*/
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 7f0d515c07c5..efab3cb47885 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1292,7 +1292,7 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
>  struct event_constraint intel_grt_pebs_event_constraints[] = {
>  	/* Allow all events as PEBS with no flags */
>  	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0x3),
> -	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xf),
> +	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0x3f),
>  	EVENT_CONSTRAINT_END
>  };
>  

