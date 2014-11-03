From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 2/5] Kernel module: to Enable userspace access to PMU
 counters for ArmV8
Date: Mon, 3 Nov 2014 16:16:17 +0000
Message-ID: <20141103161617.GL29621@leverpostej>
References: <1415027045-6573-1-git-send-email-yogesh.tillu@linaro.org>
 <1415027045-6573-3-git-send-email-yogesh.tillu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:51360 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752465AbaKCQTR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Nov 2014 11:19:17 -0500
Content-Disposition: inline
In-Reply-To: <1415027045-6573-3-git-send-email-yogesh.tillu@linaro.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yogesh Tillu <yogesh.tillu@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "magnus.karlsson@avagotech.com" <magnus.karlsson@avagotech.com>, "tillu.yogesh@gmail.com" <tillu.yogesh@gmail.com>, "Prasun.Kapoor@caviumnetworks.com" <Prasun.Kapoor@caviumnetworks.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "Andrew.Pinski@caviumnetworks.com" <Andrew.Pinski@caviumnetworks.com>, "mike.holmes@linaro.org" <mike.holmes@linaro.org>, "ola.liljedahl@linaro.org" <ola.liljedahl@linaro.org>, "linaro-networking@linaro.org" <linaro-networking@linaro.org>, "jean.pihet@linaro.org" <jean.pihet@linaro.org>, "arnd@linaro.org" <arnd@linaro.org>

On Mon, Nov 03, 2014 at 03:04:02PM +0000, Yogesh Tillu wrote:
> This Patchset is for Kernel Module to Enable userspace access to PMU counters(ArmV8)

NAK.

This _must_ be built within the existing framework.

Thanks,
Mark.

> 
> Signed-off-by: Yogesh Tillu <yogesh.tillu@linaro.org>
> ---
>  ARMv8_Module/Makefile         |    8 ++++
>  ARMv8_Module/README           |    1 +
>  ARMv8_Module/enable_arm_pmu.c |   96 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 ARMv8_Module/Makefile
>  create mode 100644 ARMv8_Module/README
>  create mode 100644 ARMv8_Module/enable_arm_pmu.c
> 
> diff --git a/ARMv8_Module/Makefile b/ARMv8_Module/Makefile
> new file mode 100644
> index 0000000..19a31ea
> --- /dev/null
> +++ b/ARMv8_Module/Makefile
> @@ -0,0 +1,8 @@
> +obj-m	:= enable_arm_pmu.o
> +KDIR	:= /lib/modules/$(shell uname -r)/build
> +PWD	:= $(shell pwd)
> +
> +all:
> +	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> +clean:
> +	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
> diff --git a/ARMv8_Module/README b/ARMv8_Module/README
> new file mode 100644
> index 0000000..648456b
> --- /dev/null
> +++ b/ARMv8_Module/README
> @@ -0,0 +1 @@
> +make ARCH=arm64 clean;make ARCH=arm64 CROSS_COMPILE=~/arm64-tc-14.06/bin/aarch64-linux-gnu- -C ~/work/lava_ci/juno/linux-linaro/workspace/builddir-3.16.0-linaro-juno/ SUBDIRS=`pwd`
> diff --git a/ARMv8_Module/enable_arm_pmu.c b/ARMv8_Module/enable_arm_pmu.c
> new file mode 100644
> index 0000000..5c87b08
> --- /dev/null
> +++ b/ARMv8_Module/enable_arm_pmu.c
> @@ -0,0 +1,96 @@
> +/*
> + * Enable user-mode ARM performance counter access.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/smp.h>
> +/** -- Configuration stuff ------------------------------------------------- */
> +
> +#define DRVR_NAME "enable_arm_pmu"
> +
> +#if !defined(__aarch64__)
> +	#error Module can only be compiled on ARM 64 machines.
> +#endif
> +
> +/** -- Initialization & boilerplate ---------------------------------------- */
> +
> +#define PERF_DEF_OPTS 		(1 | 16)
> +#define PERF_OPT_RESET_CYCLES 	(2 | 4)
> +#define PERF_OPT_DIV64 		(8)
> +#define ARMV8_PMCR_MASK         0x3f
> +#define ARMV8_PMCR_E            (1 << 0) /* Enable all counters */
> +#define ARMV8_PMCR_P            (1 << 1) /* Reset all counters */
> +#define ARMV8_PMCR_C            (1 << 2) /* Cycle counter reset */
> +#define ARMV8_PMCR_D            (1 << 3) /* CCNT counts every 64th cpu cycle */
> +#define ARMV8_PMCR_X            (1 << 4) /* Export to ETM */
> +#define ARMV8_PMCR_DP           (1 << 5) /* Disable CCNT if non-invasive debug*/
> +#define ARMV8_PMCR_N_SHIFT      11       /* Number of counters supported */
> +#define ARMV8_PMCR_N_MASK       0x1f
> +
> +#define ARMV8_PMUSERENR_EN_EL0  (1 << 0) /* EL0 access enable */
> +#define ARMV8_PMUSERENR_CR      (1 << 2) /* Cycle counter read enable */
> +#define ARMV8_PMUSERENR_ER      (1 << 3) /* Event counter read enable */
> +
> +static inline u32 armv8pmu_pmcr_read(void)
> +{
> +        u64 val=0;
> +        asm volatile("mrs %0, pmcr_el0" : "=r" (val));
> +        return (u32)val;
> +}
> +static inline void armv8pmu_pmcr_write(u32 val)
> +{
> +        val &= ARMV8_PMCR_MASK;
> +        isb();
> +        asm volatile("msr pmcr_el0, %0" : : "r" ((u64)val));
> +}
> + 
> +static void
> +enable_cpu_counters(void* data)
> +{
> +	u32 val=0;
> +/* Enable user-mode access to counters. */
> +	asm volatile("msr pmuserenr_el0, %0" : : "r"((u64)ARMV8_PMUSERENR_EN_EL0|ARMV8_PMUSERENR_ER|ARMV8_PMUSERENR_CR));
> +/* Initialize & Reset PMNC: C and P bits. */
> +	armv8pmu_pmcr_write(ARMV8_PMCR_P | ARMV8_PMCR_C); 
> +/*G4.4.11
> +PMINTENSET, Performance Monitors Interrupt Enable Set register */
> +/*cycle counter overflow interrupt request is disabled */
> +	asm volatile("msr pmintenset_el1, %0" : : "r" ((u64)(0 << 31)));
> +/*start*/
> +	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMCR_E);
> +}
> +
> +static void
> +disable_cpu_counters(void* data)
> +{
> +	u32 val=0;
> +	printk(KERN_INFO "\n [" DRVR_NAME "] disabling user-mode PMU access on CPU #%d",
> +	smp_processor_id());
> +
> +	/* Program PMU and disable all counters */
> +	armv8pmu_pmcr_write(armv8pmu_pmcr_read() |~ARMV8_PMCR_E);
> +	/* disable user-mode access to counters. */
> +	asm volatile("msr pmuserenr_el0, %0" : : "r"((u64)0));
> +
> +}
> +
> +static int __init
> +init(void)
> +{
> +	on_each_cpu(enable_cpu_counters, NULL, 1);
> +	printk(KERN_INFO "[" DRVR_NAME "] initialized");
> +	return 0;
> +}
> +
> +static void __exit
> +fini(void)
> +{
> +	on_each_cpu(disable_cpu_counters, NULL, 1);
> +	printk(KERN_INFO "[" DRVR_NAME "] unloaded");
> +}
> +
> +MODULE_AUTHOR("Yogesh Tillu ");
> +MODULE_DESCRIPTION("Enables user-mode access to ARMv8 PMU counters");
> +MODULE_VERSION("0:0.1-dev");
> +module_init(init);
> +module_exit(fini);
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
