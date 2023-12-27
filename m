Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7667544378
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Dec 2023 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 865E8150C
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Dec 2023 03:08:29 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D766D3F641
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Dec 2023 03:07:43 -0800 (PST)
Date: Wed, 27 Dec 2023 11:07:16 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>, Arnd Bergmann <arnd@arndb.de>,
	soc@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] ARM: Delete ARM11MPCore perf leftovers
Message-ID: <ZYwFZOwbBAEy9PJ1@e110455-lin.cambridge.arm.com>
References: <20231224-drop-11mpcore-fix-v1-1-d8b16d1c1fae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231224-drop-11mpcore-fix-v1-1-d8b16d1c1fae@linaro.org>

On Sun, Dec 24, 2023 at 11:24:38PM +0100, Linus Walleij wrote:
> My commit deleting the PB11MPCore apparently left a few dangling
> structs in the perf event code. Fix it up.
> 
> Fixes: 2560cffd2134 ("ARM: Delete ARM11MPCore (ARM11 ARMv6K SMP) support")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> This fixes a warning reported in the SoC tree, it's not even
> in next yet. Now that I turned on ARMv6 in my builds it is
> also tested.
> ---
>  arch/arm/kernel/perf_event_v6.c | 94 -----------------------------------------
>  1 file changed, 94 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
> index 3115077f6abc..0cbf46233d6b 100644
> --- a/arch/arm/kernel/perf_event_v6.c
> +++ b/arch/arm/kernel/perf_event_v6.c
> @@ -113,69 +113,6 @@ static const unsigned armv6_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
>  	[C(ITLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV6_PERFCTR_ITLB_MISS,
>  };
>  
> -enum armv6mpcore_perf_types {
> -	ARMV6MPCORE_PERFCTR_ICACHE_MISS	    = 0x0,
> -	ARMV6MPCORE_PERFCTR_IBUF_STALL	    = 0x1,
> -	ARMV6MPCORE_PERFCTR_DDEP_STALL	    = 0x2,
> -	ARMV6MPCORE_PERFCTR_ITLB_MISS	    = 0x3,
> -	ARMV6MPCORE_PERFCTR_DTLB_MISS	    = 0x4,
> -	ARMV6MPCORE_PERFCTR_BR_EXEC	    = 0x5,
> -	ARMV6MPCORE_PERFCTR_BR_NOTPREDICT   = 0x6,
> -	ARMV6MPCORE_PERFCTR_BR_MISPREDICT   = 0x7,
> -	ARMV6MPCORE_PERFCTR_INSTR_EXEC	    = 0x8,
> -	ARMV6MPCORE_PERFCTR_DCACHE_RDACCESS = 0xA,
> -	ARMV6MPCORE_PERFCTR_DCACHE_RDMISS   = 0xB,
> -	ARMV6MPCORE_PERFCTR_DCACHE_WRACCESS = 0xC,
> -	ARMV6MPCORE_PERFCTR_DCACHE_WRMISS   = 0xD,
> -	ARMV6MPCORE_PERFCTR_DCACHE_EVICTION = 0xE,
> -	ARMV6MPCORE_PERFCTR_SW_PC_CHANGE    = 0xF,
> -	ARMV6MPCORE_PERFCTR_MAIN_TLB_MISS   = 0x10,
> -	ARMV6MPCORE_PERFCTR_EXPL_MEM_ACCESS = 0x11,
> -	ARMV6MPCORE_PERFCTR_LSU_FULL_STALL  = 0x12,
> -	ARMV6MPCORE_PERFCTR_WBUF_DRAINED    = 0x13,
> -	ARMV6MPCORE_PERFCTR_CPU_CYCLES	    = 0xFF,
> -};
> -
> -/*
> - * The hardware events that we support. We do support cache operations but
> - * we have harvard caches and no way to combine instruction and data
> - * accesses/misses in hardware.
> - */
> -static const unsigned armv6mpcore_perf_map[PERF_COUNT_HW_MAX] = {
> -	PERF_MAP_ALL_UNSUPPORTED,
> -	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV6MPCORE_PERFCTR_CPU_CYCLES,
> -	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV6MPCORE_PERFCTR_INSTR_EXEC,
> -	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV6MPCORE_PERFCTR_BR_EXEC,
> -	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV6MPCORE_PERFCTR_BR_MISPREDICT,
> -	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV6MPCORE_PERFCTR_IBUF_STALL,
> -	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= ARMV6MPCORE_PERFCTR_LSU_FULL_STALL,
> -};
> -
> -static const unsigned armv6mpcore_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
> -					[PERF_COUNT_HW_CACHE_OP_MAX]
> -					[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
> -	PERF_CACHE_MAP_ALL_UNSUPPORTED,
> -
> -	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV6MPCORE_PERFCTR_DCACHE_RDACCESS,
> -	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_DCACHE_RDMISS,
> -	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV6MPCORE_PERFCTR_DCACHE_WRACCESS,
> -	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_DCACHE_WRMISS,
> -
> -	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_ICACHE_MISS,
> -
> -	/*
> -	 * The ARM performance counters can count micro DTLB misses, micro ITLB
> -	 * misses and main TLB misses. There isn't an event for TLB misses, so
> -	 * use the micro misses here and if users want the main TLB misses they
> -	 * can use a raw counter.
> -	 */
> -	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_DTLB_MISS,
> -	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_DTLB_MISS,
> -
> -	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_ITLB_MISS,
> -	[C(ITLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_ITLB_MISS,
> -};
> -
>  static inline unsigned long
>  armv6_pmcr_read(void)
>  {
> @@ -452,37 +389,6 @@ static void armv6pmu_disable_event(struct perf_event *event)
>  	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
> -static void armv6mpcore_pmu_disable_event(struct perf_event *event)
> -{
> -	unsigned long val, mask, flags, evt = 0;
> -	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> -	struct hw_perf_event *hwc = &event->hw;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> -	int idx = hwc->idx;
> -
> -	if (ARMV6_CYCLE_COUNTER == idx) {
> -		mask	= ARMV6_PMCR_CCOUNT_IEN;
> -	} else if (ARMV6_COUNTER0 == idx) {
> -		mask	= ARMV6_PMCR_COUNT0_IEN;
> -	} else if (ARMV6_COUNTER1 == idx) {
> -		mask	= ARMV6_PMCR_COUNT1_IEN;
> -	} else {
> -		WARN_ONCE(1, "invalid counter number (%d)\n", idx);
> -		return;
> -	}
> -
> -	/*
> -	 * Unlike UP ARMv6, we don't have a way of stopping the counters. We
> -	 * simply disable the interrupt reporting.
> -	 */
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
> -	val = armv6_pmcr_read();
> -	val &= ~mask;
> -	val |= evt;
> -	armv6_pmcr_write(val);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
> -}
> -
>  static int armv6_map_event(struct perf_event *event)
>  {
>  	return armpmu_map_event(event, &armv6_perf_map,
> 
> ---
> base-commit: b057e7afb79ec2edddc940b82af6e3571d1f0ffe
> change-id: 20231224-drop-11mpcore-fix-c6cb526d1296
> 
> Best regards,
> -- 
> Linus Walleij <linus.walleij@linaro.org>
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
