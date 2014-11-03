From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 4/5]ARM64: Kernel: To read PMU cycle counter through
 vDSO Path
Date: Mon, 3 Nov 2014 16:13:21 +0000
Message-ID: <20141103161321.GK29621@leverpostej>
References: <1415027045-6573-1-git-send-email-yogesh.tillu@linaro.org>
 <1415027045-6573-5-git-send-email-yogesh.tillu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:51328 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752957AbaKCQQU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Nov 2014 11:16:20 -0500
Content-Disposition: inline
In-Reply-To: <1415027045-6573-5-git-send-email-yogesh.tillu@linaro.org>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yogesh Tillu <yogesh.tillu@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "magnus.karlsson@avagotech.com" <magnus.karlsson@avagotech.com>, "tillu.yogesh@gmail.com" <tillu.yogesh@gmail.com>, "Prasun.Kapoor@caviumnetworks.com" <Prasun.Kapoor@caviumnetworks.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "Andrew.Pinski@caviumnetworks.com" <Andrew.Pinski@caviumnetworks.com>, "mike.holmes@linaro.org" <mike.holmes@linaro.org>, "ola.liljedahl@linaro.org" <ola.liljedahl@linaro.org>, "linaro-networking@linaro.org" <linaro-networking@linaro.org>, "jean.pihet@linaro.org" <jean.pihet@linaro.org>, "arnd@linaro.org" <arnd@linaro.org>

On Mon, Nov 03, 2014 at 03:04:04PM +0000, Yogesh Tillu wrote:
> Kernel patchset to enable vDSO path for reading PMU cycle counter.
> 
> Signed-off-by: Yogesh Tillu <yogesh.tillu@linaro.org>
> ---
>  arch/arm64/kernel/vdso/Makefile     |    6 +++---
>  arch/arm64/kernel/vdso/vdso.lds.S   |    5 +++++
>  arch/arm64/kernel/vdso/vdso_perfc.c |   20 ++++++++++++++++++++
>  3 files changed, 28 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/kernel/vdso/vdso_perfc.c
> 
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 6d20b7d..4fde490 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -5,7 +5,7 @@
>  # Heavily based on the vDSO Makefiles for other archs.
>  #
>  
> -obj-vdso := gettimeofday.o note.o sigreturn.o
> +obj-vdso := gettimeofday.o note.o sigreturn.o armpmu.o
>  
>  # Build rules
>  targets := $(obj-vdso) vdso.so vdso.so.dbg
> @@ -43,8 +43,8 @@ $(obj)/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
>  	$(call if_changed,vdsosym)
>  
>  # Assembly rules for the .S files
> -$(obj-vdso): %.o: %.S
> -	$(call if_changed_dep,vdsoas)
> +#$(obj-vdso): %.o: %.S
> +#	$(call if_changed_dep,vdsoas)

Either this is unnecessary, and it goes, or it is necessary, and it
stays. Do not half-remove code in this fashion.

>  # Actual build commands
>  quiet_cmd_vdsold = VDSOL $@
> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> index 8154b8d..8cb56e0 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> @@ -90,6 +90,11 @@ VERSION
>  		__kernel_gettimeofday;
>  		__kernel_clock_gettime;
>  		__kernel_clock_getres;
> +		 /* ADD YOUR VDSO STUFF HERE */

This comment adds no value.

> +		perf_read_counter;
> +		__vdso_perf_read_counter;
> +		perf_open_counter;
> +		__vdso_perf_open_counter;

I believe we need a new version label for these symbols.

Why are we exposing internal names outside of the VDSO? That would seem
to defeat the point of this linker script.

>  	local: *;
>  	};
>  }
> diff --git a/arch/arm64/kernel/vdso/vdso_perfc.c b/arch/arm64/kernel/vdso/vdso_perfc.c
> new file mode 100644
> index 0000000..c363d64
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso/vdso_perfc.c
> @@ -0,0 +1,20 @@
> +#include <linux/compiler.h>
> +
> +int perf_read_counter(void)
> +    __attribute__((weak, alias("__vdso__perf_read_counter")));
> +int perf_open_counter(void)
> +    __attribute__((weak, alias("__vdso__perf_open_counter")));

Why is this not in plain assembly like the rest of the VDSO functions?

There is absolutely no reason for a C wrapper for an asm block,
especially given the additional changes required to make that work at
all.

> +
> +#define ARMV8_PMCNTENSET_EL0_ENABLE (1<<31) /**< Enable Perf count reg */
> +
> +__attribute__((no_instrument_function)) int __vdso__perf_read_counter(void)
> +{
> +int ret = 0;
> +asm volatile("mrs %0, pmccntr_el0" : "=r" (ret));
> +return ret;
> +}
> +
> +__attribute__((no_instrument_function)) void __vdso__perf_open_counter(void)
> +{
> +asm volatile("msr pmcntenset_el0, %0" : : "r" (ARMV8_PMCNTENSET_EL0_ENABLE));
> +}

Huh?

This function is completely misnamed, as it enables the cycle counter in
hardware -- it does not 'open' any counter in the traditional perf
meaning. It does so without notifying the kernel, and no code has been
added to context switch the counter.

This will not work as-is for all but the most trivial of test cases:

* The application's view of the cycle counter will jump up arbitrarily
  when the kernel/hypervisor/firmware takes control of the hardware
  (e.g. to handle interrupts).

* The application's view of the cycle counter can change arbitrarily as
  it gets migrated across CPUs. The counter value can change, and its
  configuration can also change (e.g. when moving from a CPU where it is
  enabled to one where it is not).

* If another application is profiling system-wide, it will cause the
  cycle counter to be reset occasionally on overflow.

* With cpuidle, the hardware context (including the cycle counter
  configuration) can be lost in low power states. The cycle counter may
  suddenly stop ticking, and stay at an arbitrary reset value.

If you want to expose the counters directly to userspace for reading,
then you need to modify the existing framework to work with that. It is
simply not possible to hack this onto the side. Otherwise the numbers
you read are effectively meaningless.

There are additional complications for big.LITTLE when using anything
other than the cycle counter (which even then is meaningless when
summed).

Thanks,
Mark.
