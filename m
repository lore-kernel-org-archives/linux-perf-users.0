Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24FDA1719
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 10:31:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5880139F
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 10:31:54 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 855143F762
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 10:31:08 -0800 (PST)
Date: Thu, 7 Dec 2023 18:30:57 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>, Arnd Bergmann <arnd@arndb.de>,
	soc@kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: Delete ARM11MPCore (ARM11 ARMv6K SMP) support
Message-ID: <ZXIPYUrtitafCKH8@e110455-lin.cambridge.arm.com>
References: <20231207-drop-11mpcore-v2-1-560b396f3bf5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231207-drop-11mpcore-v2-1-560b396f3bf5@linaro.org>

On Thu, Dec 07, 2023 at 02:33:35PM +0100, Linus Walleij wrote:
> This ARM11 SMP configuration was one of the first SMP configurations
> the ARM kernel supported, but it has the downside of odd DMA handling,
> odd cache tagging, and often (as of recent) completely broken cache
> handling on the ARM RealView PB11MPCore test chips. To boot the
> platform it was necessary to completely disable the cache.
> When it comes to the EB 11MPCore it is unclear if this ever worked.
> 
> These reference designs are now the only ARMv6K SMP platforms.
> 
> As only reference designs of purely academic interest remain, and
> since the special-cased DMA and PMU code is hard to maintain and
> doesn't really work, it is not really worth our time.
> 
> Delete the ARM11MPCore support along with:
> 
> - The special DMA quirk CONFIG_DMA_CACHE_RWFO that is only used
>   on ARMv6K SMP, and we are the last ARMV6K system leaving the
>   building and the cache handling is awkward, so good-bye.
> 
> - The special PMU handling that was only used by ARM11MPCore.
> 
> The following is left behind:
> 
> - TIMER_OF_DECLARE(arm_twd_11mp, "arm,arm11mp-twd-timer", ...)
>   in arch/arm/kernel/smp_twd.c, this is still in use by Marvell MMP3
>   arch/arm/boot/dts/marvell/mmp3.dtsi
> 
> - IRQCHIP_DECLARE(arm11mp_gic, "arm,arm11mp-gic", ...)
>   in drivers/irqchip/irq-gic.c, this is still in use by Marvell MMP3
>   arch/arm/boot/dts/marvell/mmp3.dtsi
> 
> - A compatible for the arm11mpcore SCU, since this was mistakedly
>   used for the Cortex-A9 version of RealView EB.
> 
> These are unfortunate but will need to be kept around for
> compatibility. New Marvell-specific compatibles should however probably
> be added.

I remember seeing a decade ago some evaluation boards with ARM11MPCore
but that's as far as I have ever come close to this platform.

For what is worth:

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Keep the PB11MPCore SCU compatible for a bit (until we delete these
>   RealView EB device trees).
> - Please apply this to the SoC tree once there is consensus.
> - Link to v1: https://lore.kernel.org/r/20231204-drop-11mpcore-v1-1-f96cd3938cf1@linaro.org
> ---
>  arch/arm/kernel/perf_event_v6.c            | 34 ------------------------------
>  arch/arm/mach-versatile/Kconfig            | 17 ---------------
>  arch/arm/mach-versatile/platsmp-realview.c |  6 +++++-
>  arch/arm/mach-versatile/realview.c         |  1 -
>  arch/arm/mm/Kconfig                        | 18 ----------------
>  arch/arm/mm/cache-v6.S                     | 31 ---------------------------
>  6 files changed, 5 insertions(+), 102 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
> index 1ae99deeec54..3115077f6abc 100644
> --- a/arch/arm/kernel/perf_event_v6.c
> +++ b/arch/arm/kernel/perf_event_v6.c
> @@ -525,40 +525,7 @@ static int armv6_1176_pmu_init(struct arm_pmu *cpu_pmu)
>  	return 0;
>  }
>  
> -/*
> - * ARMv6mpcore is almost identical to single core ARMv6 with the exception
> - * that some of the events have different enumerations and that there is no
> - * *hack* to stop the programmable counters. To stop the counters we simply
> - * disable the interrupt reporting and update the event. When unthrottling we
> - * reset the period and enable the interrupt reporting.
> - */
> -
> -static int armv6mpcore_map_event(struct perf_event *event)
> -{
> -	return armpmu_map_event(event, &armv6mpcore_perf_map,
> -				&armv6mpcore_perf_cache_map, 0xFF);
> -}
> -
> -static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
> -{
> -	cpu_pmu->name		= "armv6_11mpcore";
> -	cpu_pmu->handle_irq	= armv6pmu_handle_irq;
> -	cpu_pmu->enable		= armv6pmu_enable_event;
> -	cpu_pmu->disable	= armv6mpcore_pmu_disable_event;
> -	cpu_pmu->read_counter	= armv6pmu_read_counter;
> -	cpu_pmu->write_counter	= armv6pmu_write_counter;
> -	cpu_pmu->get_event_idx	= armv6pmu_get_event_idx;
> -	cpu_pmu->clear_event_idx = armv6pmu_clear_event_idx;
> -	cpu_pmu->start		= armv6pmu_start;
> -	cpu_pmu->stop		= armv6pmu_stop;
> -	cpu_pmu->map_event	= armv6mpcore_map_event;
> -	cpu_pmu->num_events	= 3;
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id armv6_pmu_of_device_ids[] = {
> -	{.compatible = "arm,arm11mpcore-pmu",	.data = armv6mpcore_pmu_init},
>  	{.compatible = "arm,arm1176-pmu",	.data = armv6_1176_pmu_init},
>  	{.compatible = "arm,arm1136-pmu",	.data = armv6_1136_pmu_init},
>  	{ /* sentinel value */ }
> @@ -568,7 +535,6 @@ static const struct pmu_probe_info armv6_pmu_probe_table[] = {
>  	ARM_PMU_PROBE(ARM_CPU_PART_ARM1136, armv6_1136_pmu_init),
>  	ARM_PMU_PROBE(ARM_CPU_PART_ARM1156, armv6_1156_pmu_init),
>  	ARM_PMU_PROBE(ARM_CPU_PART_ARM1176, armv6_1176_pmu_init),
> -	ARM_PMU_PROBE(ARM_CPU_PART_ARM11MPCORE, armv6mpcore_pmu_init),
>  	{ /* sentinel value */ }
>  };
>  
> diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
> index b1519b4dc03a..e029270c2687 100644
> --- a/arch/arm/mach-versatile/Kconfig
> +++ b/arch/arm/mach-versatile/Kconfig
> @@ -201,23 +201,6 @@ config REALVIEW_EB_A9MP
>  	  Enable support for the Cortex-A9MPCore tile fitted to the
>  	  Realview(R) Emulation Baseboard platform.
>  
> -config REALVIEW_EB_ARM11MP
> -	bool "Support ARM11MPCore Tile"
> -	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
> -	select HAVE_SMP
> -	help
> -	  Enable support for the ARM11MPCore tile fitted to the Realview(R)
> -	  Emulation Baseboard platform.
> -
> -config MACH_REALVIEW_PB11MP
> -	bool "Support RealView(R) Platform Baseboard for ARM11MPCore"
> -	depends on ARCH_MULTI_V6
> -	select HAVE_SMP
> -	help
> -	  Include support for the ARM(R) RealView(R) Platform Baseboard for
> -	  the ARM11MPCore.  This platform has an on-board ARM11MPCore and has
> -	  support for PCI-E and Compact Flash.
> -
>  # ARMv6 CPU without K extensions, but does have the new exclusive ops
>  config MACH_REALVIEW_PB1176
>  	bool "Support RealView(R) Platform Baseboard for ARM1176JZF-S"
> diff --git a/arch/arm/mach-versatile/platsmp-realview.c b/arch/arm/mach-versatile/platsmp-realview.c
> index 5d363385c801..6965a1de727b 100644
> --- a/arch/arm/mach-versatile/platsmp-realview.c
> +++ b/arch/arm/mach-versatile/platsmp-realview.c
> @@ -18,6 +18,11 @@
>  #define REALVIEW_SYS_FLAGSSET_OFFSET	0x30
>  
>  static const struct of_device_id realview_scu_match[] = {
> +	/*
> +	 * The ARM11MP SCU compatible is only provided as fallback for
> +	 * old RealView EB Cortex-A9 device trees that were using this
> +	 * compatible by mistake.
> +	 */
>  	{ .compatible = "arm,arm11mp-scu", },
>  	{ .compatible = "arm,cortex-a9-scu", },
>  	{ .compatible = "arm,cortex-a5-scu", },
> @@ -27,7 +32,6 @@ static const struct of_device_id realview_scu_match[] = {
>  static const struct of_device_id realview_syscon_match[] = {
>          { .compatible = "arm,core-module-integrator", },
>          { .compatible = "arm,realview-eb-syscon", },
> -        { .compatible = "arm,realview-pb11mp-syscon", },
>          { .compatible = "arm,realview-pbx-syscon", },
>          { },
>  };
> diff --git a/arch/arm/mach-versatile/realview.c b/arch/arm/mach-versatile/realview.c
> index a3933e2373d5..36a6f6bc4fdd 100644
> --- a/arch/arm/mach-versatile/realview.c
> +++ b/arch/arm/mach-versatile/realview.c
> @@ -9,7 +9,6 @@
>  static const char *const realview_dt_platform_compat[] __initconst = {
>  	"arm,realview-eb",
>  	"arm,realview-pb1176",
> -	"arm,realview-pb11mp",
>  	"arm,realview-pba8",
>  	"arm,realview-pbx",
>  	NULL,
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index c164cde50243..2b6f50dd5478 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -937,24 +937,6 @@ config VDSO
>  	  You must have glibc 2.22 or later for programs to seamlessly
>  	  take advantage of this.
>  
> -config DMA_CACHE_RWFO
> -	bool "Enable read/write for ownership DMA cache maintenance"
> -	depends on CPU_V6K && SMP
> -	default y
> -	help
> -	  The Snoop Control Unit on ARM11MPCore does not detect the
> -	  cache maintenance operations and the dma_{map,unmap}_area()
> -	  functions may leave stale cache entries on other CPUs. By
> -	  enabling this option, Read or Write For Ownership in the ARMv6
> -	  DMA cache maintenance functions is performed. These LDR/STR
> -	  instructions change the cache line state to shared or modified
> -	  so that the cache operation has the desired effect.
> -
> -	  Note that the workaround is only valid on processors that do
> -	  not perform speculative loads into the D-cache. For such
> -	  processors, if cache maintenance operations are not broadcast
> -	  in hardware, other workarounds are needed (e.g. cache
> -	  maintenance broadcasting in software via FIQ).
>  
>  config OUTER_CACHE
>  	bool
> diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
> index 250c83bf7158..44211d8a296f 100644
> --- a/arch/arm/mm/cache-v6.S
> +++ b/arch/arm/mm/cache-v6.S
> @@ -201,10 +201,6 @@ ENTRY(v6_flush_kern_dcache_area)
>   *	- end     - virtual end address of region
>   */
>  v6_dma_inv_range:
> -#ifdef CONFIG_DMA_CACHE_RWFO
> -	ldrb	r2, [r0]			@ read for ownership
> -	strb	r2, [r0]			@ write for ownership
> -#endif
>  	tst	r0, #D_CACHE_LINE_SIZE - 1
>  	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
>  #ifdef HARVARD_CACHE
> @@ -213,10 +209,6 @@ v6_dma_inv_range:
>  	mcrne	p15, 0, r0, c7, c11, 1		@ clean unified line
>  #endif
>  	tst	r1, #D_CACHE_LINE_SIZE - 1
> -#ifdef CONFIG_DMA_CACHE_RWFO
> -	ldrbne	r2, [r1, #-1]			@ read for ownership
> -	strbne	r2, [r1, #-1]			@ write for ownership
> -#endif
>  	bic	r1, r1, #D_CACHE_LINE_SIZE - 1
>  #ifdef HARVARD_CACHE
>  	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D line
> @@ -231,10 +223,6 @@ v6_dma_inv_range:
>  #endif
>  	add	r0, r0, #D_CACHE_LINE_SIZE
>  	cmp	r0, r1
> -#ifdef CONFIG_DMA_CACHE_RWFO
> -	ldrlo	r2, [r0]			@ read for ownership
> -	strlo	r2, [r0]			@ write for ownership
> -#endif
>  	blo	1b
>  	mov	r0, #0
>  	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
> @@ -248,9 +236,6 @@ v6_dma_inv_range:
>  v6_dma_clean_range:
>  	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
>  1:
> -#ifdef CONFIG_DMA_CACHE_RWFO
> -	ldr	r2, [r0]			@ read for ownership
> -#endif
>  #ifdef HARVARD_CACHE
>  	mcr	p15, 0, r0, c7, c10, 1		@ clean D line
>  #else
> @@ -269,10 +254,6 @@ v6_dma_clean_range:
>   *	- end     - virtual end address of region
>   */
>  ENTRY(v6_dma_flush_range)
> -#ifdef CONFIG_DMA_CACHE_RWFO
> -	ldrb	r2, [r0]		@ read for ownership
> -	strb	r2, [r0]		@ write for ownership
> -#endif
>  	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
>  1:
>  #ifdef HARVARD_CACHE
> @@ -282,10 +263,6 @@ ENTRY(v6_dma_flush_range)
>  #endif
>  	add	r0, r0, #D_CACHE_LINE_SIZE
>  	cmp	r0, r1
> -#ifdef CONFIG_DMA_CACHE_RWFO
> -	ldrblo	r2, [r0]			@ read for ownership
> -	strblo	r2, [r0]			@ write for ownership
> -#endif
>  	blo	1b
>  	mov	r0, #0
>  	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
> @@ -301,13 +278,7 @@ ENTRY(v6_dma_map_area)
>  	add	r1, r1, r0
>  	teq	r2, #DMA_FROM_DEVICE
>  	beq	v6_dma_inv_range
> -#ifndef CONFIG_DMA_CACHE_RWFO
>  	b	v6_dma_clean_range
> -#else
> -	teq	r2, #DMA_TO_DEVICE
> -	beq	v6_dma_clean_range
> -	b	v6_dma_flush_range
> -#endif
>  ENDPROC(v6_dma_map_area)
>  
>  /*
> @@ -317,11 +288,9 @@ ENDPROC(v6_dma_map_area)
>   *	- dir	- DMA direction
>   */
>  ENTRY(v6_dma_unmap_area)
> -#ifndef CONFIG_DMA_CACHE_RWFO
>  	add	r1, r1, r0
>  	teq	r2, #DMA_TO_DEVICE
>  	bne	v6_dma_inv_range
> -#endif
>  	ret	lr
>  ENDPROC(v6_dma_unmap_area)
>  
> 
> ---
> base-commit: d570fe67df85c84be7cc33ca9e9568d9601b494f
> change-id: 20231202-drop-11mpcore-d556cc5f7d99
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
