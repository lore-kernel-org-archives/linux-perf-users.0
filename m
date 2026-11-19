Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095866;
	b=2zlvMr9SEhQUx6hFLkDq2DDMkT7JoR4oOpfOcXa41U19r5U8wt7hqZR6VBgXzmhhx6yp
	 Y4gAFP0LU8f396S6sESN5t3uF7nH/r53W8DHR7aJa0Vs5NkJ0kEBP5axubjPIQlcO4yIE
	 cyOyHsTULPosYUvuDEoqdd00/wJtPl1TgLeYiQ1d64dyH5Lub8xipM81RhcdC895jixEP
	 ylZURnFBZ8ueCJwtIqjmdfK+hgu24RujqdghBqlN/DM/2IdS4dVvUpolkVMEzgXXySaOT
	 fJ9EdxTnfcl7pNj2JRFA0gX4GcJGq0WPLCdh9GlUOv9fBiV5lA6pQzzKNvO9T3LOjYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095866;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=JFOr/HaA5M4ow4p4WMe/GDqNkmn9F87y18KWeoj8kmU=;
	b=D6n9UgKa7V0XwDn+7AjqCJ6jt7gTGrXabJ6u61wkRXV1uff/vJlO5blIxhUzoXi5RtIe
	 YOs+wwKq8dkS5tlgK+owRJaIOFTiROJnmpA5GZmP5VEhzBevOOcDZJ/lVTcJfyD/+4FKk
	 OJzyICtIXBdNNninhhHLi9NSuoz2cp9wiHTEr5fDA06bKDRckj25WP8riDDw7PoebeksN
	 Oz3xZBYgMgTt86rdixSnoQRN8DWVFWPnBd9fxGEyE9Gn2jWn4QM7cMxjtkAkmWp5mMEnt
	 3x1uiqbIMkhc29pljf+jidCj0PSLIPlqh+CPI1suTavfGMryIY66vD25mdO2+Vd29Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=E5PJ485w;
	arc=none smtp.remote-ip=91.218.175.245
Received: from mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202F606A325
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 13:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B202F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=E5PJ485w
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GeacZfWtcOKsPTca8YX1CAhAl83TpLkh+Pna1MJGv8k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795095863; v=1; x=1795700663;
 b=E5PJ485wDF8oE5jTv1Rr41cNiZNzU0XeGUmmT39gnMH98TrS0u/0aV7yqDfFpLde4fRt0NCY
 H24T4j+VZEVaF2ChPgk2T6Sf32pqCmpYceCHvzudkrQnOtE/zlUg9/sZBSno3UVKPrreBqaGjUo
 10Pj2RuMTOh+PV79Xh95P7uY=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2b1b82f9378b37d8;
	Thu, 19 Nov 2026 13:44:23 +0000
X-Mizu-Trace-ID: 2b1b82f9378b37d8
X-Migadu-Flow: FLOW_OUT
Message-ID: <0305b6b3-8292-4a4d-a473-dc26a39beca1@linux.dev>
Date: Thu, 19 Nov 2026 14:44:18 +0100
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
Subject: Re: [PATCH v13 03/11] riscv: sse: mask events during shutdown and
 kexec
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 himanshu.chauhan@oss.qualcomm.com, conor@kernel.org,
 anup.patel@oss.qualcomm.com
Cc: cuiyunhui@bytedance.com, atish.patra@linux.dev, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
 will@kernel.org, tglx@kernel.org, corbet@lwn.net, rdunlap@infradead.org,
 shuah@kernel.org, yuanzhu@bytedance.com, yang.susheng@zte.com.cn,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
 <20261119120824.13969-16-zhangzhanpeng.jasper@bytedance.com>
Content-Language: en-US
From: Clement Leger <clement.leger@linux.dev>
In-Reply-To: <20261119120824.13969-16-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/19/26 13:08, Zhanpeng Zhang wrote:
> SSE delivery is independent of normal S-mode interrupts. Firmware may also
> retain an event registration until Linux explicitly unregisters it. A hart
> must therefore stop accepting SSE events before Linux stops servicing the
> registered handler.
> 
> Mask SSE on the local hart before panic stop, CPU stop, restart, poweroff,
> and crash shutdown paths. This prevents firmware from entering Linux-owned
> handler state after the corresponding CPU or kernel context is no longer
> valid.
> 
> A crash kernel cannot identify or take ownership of registrations
> inherited from the crashed kernel. Reject a later normal kexec while such
> SSE state may still exist, rather than transferring unknown firmware state
> to another kernel.
> 
> The restriction is deliberately based on firmware SSE availability, not
> CONFIG_RISCV_SBI_SSE or registrations made by the crash kernel. Disabling
> SSE in the crash kernel does not establish that registrations left by the
> crashed kernel are absent. Consequently, normal kexec from a crash kernel
> is also rejected when firmware advertises SSE but no registrations were
> actually left behind. This conservative restriction remains until a safe
> way to establish or clear inherited firmware state is available.
> 
> Link: https://lore.kernel.org/r/as7-3PbWDxygadnJ@hu-himchau-blr.qualcomm.com/
> Reviewed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> ---
>   arch/riscv/kernel/machine_kexec.c | 11 +++++++++++
>   arch/riscv/kernel/reset.c         | 18 ++++++++++++++++++
>   arch/riscv/kernel/smp.c           | 17 +++++++++++++++++
>   3 files changed, 46 insertions(+)
> 
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index 738df176ff6f..24e7affae70b 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -14,10 +14,13 @@
>   #include <asm/set_memory.h>	/* For set_memory_x() */
>   #include <linux/compiler.h>	/* For unreachable() */
>   #include <linux/cpu.h>		/* For cpu_down() */
> +#include <linux/crash_dump.h>
>   #include <linux/reboot.h>
>   #include <linux/interrupt.h>
>   #include <linux/irq.h>
>   
> +#include <asm/sse.h>
> +
>   /*
>    * machine_kexec_prepare - Initialize kexec
>    *
> @@ -36,6 +39,13 @@ machine_kexec_prepare(struct kimage *image)
>   	unsigned int control_code_buffer_sz = 0;
>   	int i = 0;
>   
> +	/* A crash kernel cannot tear down registrations inherited from firmware. */
> +	if (is_kdump_kernel() && image->type != KEXEC_TYPE_CRASH &&
> +	    riscv_sse_available()) {
> +		pr_err("Normal kexec from a crash kernel is unsupported with SSE\n");
> +		return -EOPNOTSUPP;
> +	}
 > +>   	/* Find the Flattened Device Tree and save its physical address */
>   	for (i = 0; i < image->nr_segments; i++) {
>   		if (image->segment[i].memsz <= sizeof(fdt))
> @@ -127,6 +137,7 @@ void
>   machine_crash_shutdown(struct pt_regs *regs)
>   {
>   	local_irq_disable();
> +	riscv_sse_mask_current_hart();
>   
>   	/* shutdown non-crashing cpus */
>   	crash_smp_send_stop();
> diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
> index 14eb08a6db85..fdab37e7ae52 100644
> --- a/arch/riscv/kernel/reset.c
> +++ b/arch/riscv/kernel/reset.c
> @@ -6,6 +6,20 @@
>   #include <linux/efi.h>
>   #include <linux/reboot.h>
>   #include <linux/pm.h>
> +#include <linux/smp.h>
> +
> +#include <asm/sse.h>
> +
> +#ifndef CONFIG_SMP
> +void __noreturn panic_smp_self_stop(void)
> +{
> +	riscv_sse_mask_current_hart();
> +	local_irq_disable();
> +
> +	for (;;)
> +		cpu_relax();
> +}
> +#endif
>   
>   static void __noreturn default_power_off(void)
>   {
> @@ -18,6 +32,8 @@ EXPORT_SYMBOL(pm_power_off);
>   
>   void machine_restart(char *cmd)
>   {
> +	riscv_sse_mask_current_hart();
> +
>   	/*
>   	 * UpdateCapsule() depends on the system being reset via ResetSystem().
>   	 */
> @@ -30,12 +46,14 @@ void machine_restart(char *cmd)
>   
>   void machine_halt(void)
>   {
> +	riscv_sse_mask_current_hart();
>   	do_kernel_power_off();
>   	default_power_off();
>   }
>   
>   void machine_power_off(void)
>   {
> +	riscv_sse_mask_current_hart();
>   	do_kernel_power_off();
>   	default_power_off();
>   }


Hi Zhanpeng,

Can you please factor that out in a single function ? both functions are 
doing the exact same thing.

Thanks,

Clément

> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 07027cfeba4b..5b05243e1deb 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -22,10 +22,13 @@
>   #include <linux/irq.h>
>   #include <linux/irq_work.h>
>   #include <linux/nmi.h>
> +#include <linux/panic.h>
>   
>   #include <asm/tlbflush.h>
>   #include <asm/cacheflush.h>
>   #include <asm/cpu_ops.h>
> +#include <asm/sbi.h>
> +#include <asm/sse.h>
>   
>   static const char * const ipi_names[] = {
>   	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
> @@ -66,8 +69,18 @@ int riscv_hartid_to_cpuid(unsigned long hartid)
>   	return -ENOENT;
>   }
>   
> +void __noreturn panic_smp_self_stop(void)
> +{
> +	riscv_sse_mask_current_hart();
> +	local_irq_disable();
> +
> +	for (;;)
> +		cpu_relax();
> +}
> +
>   static void ipi_stop(void)
>   {
> +	riscv_sse_mask_current_hart();
>   	set_cpu_online(smp_processor_id(), false);
>   	while (1)
>   		wait_for_interrupt();
> @@ -78,6 +91,7 @@ static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
>   
>   static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
>   {
> +	riscv_sse_mask_current_hart();
>   	crash_save_cpu(regs, cpu);
>   
>   	atomic_dec(&waiting_for_crash_ipi);
> @@ -241,6 +255,8 @@ void smp_send_stop(void)
>   {
>   	unsigned long timeout;
>   
> +	riscv_sse_mask_current_hart();
> +
>   	if (num_online_cpus() > 1) {
>   		cpumask_t mask;
>   
> @@ -288,6 +304,7 @@ void crash_smp_send_stop(void)
>   		return;
>   
>   	cpus_stopped = 1;
> +	riscv_sse_mask_current_hart();
>   
>   	/*
>   	 * If this cpu is the only one alive at this point in time, online or

