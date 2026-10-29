Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275828;
	b=34u6vxXN1sUyPxppJbTC1v2Uj79Tk3vIZ2hCYxd3rDtCbiIQU9mdxduyJvAHVhrfBpzg
	 Vi82b5wRnvMDSAzh+2R77KG8+RpR2t0dpXDIDoLPFDIEGD54uL1fa/TcUL/H/AQcPFWhC
	 VBq1oPaHgFUPISOiC4RC+4NcCnQpO3sZsvFfdz/vsBFyv7qrlopSXQ2iDFznl9mLgw2/S
	 HXiR4illLmzPa6Oatky2BIwLAupfOuJbU02EaQE1WJvUS/eOeEiJTBHd7fcPc5QbGkbeR
	 gOHQ4KoiUz95bY8U0p0ZFLVf1kf5J4UHJpkMw/kfyPKXwZz873SGbJ6TSTupaaTqOKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275828;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hyFdMhdlNQFnuTDrMPyGlw/CiCf0Ud050kPaTLWYHgQ=;
	b=yesq/2zu1lhs4xOyFRH4arqroa7VuHBfB++7GNAi2jLjYovWm0aMxY0B1wflPjvGvjbG
	 4QLyJlzcv6s6/uPFdZgLTrU5tODSLydmn0n7phR0ZaTl4roQ7YCYYlFeaIOqK51R5yK4B
	 OmBViMqD8a5ZsXxkNWPOMyI6cYpR6EjKKx/X/e96FwJd4OtducAtJ1iqSIzRYCAXnLjSL
	 Who6DAviP9Zz7QBYnf+7i7334tu5CF4NQbJg+1X3lIcH4BH+eQ9Cn2/8KQ1fL1PrJmG3o
	 HdfO6ABubzirfSEpUWaxc7dEBGLCj1ecKUJSKAodRszqLCOPiSHj/xYyKq1bfTK9Jew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oi3VR+nu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43744606A327
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oi3VR+nu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4F81F031E5;
	Thu, 29 Oct 2026 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793275828;
	bh=hyFdMhdlNQFnuTDrMPyGlw/CiCf0Ud050kPaTLWYHgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oi3VR+nufJrPcNY8f761TPwU+g/A9D3srMJTcpoEpVkCpVwzTocvl1+T3WtUjhq3d
	 RQ4YGmJpQA1ZSnCEE9SGp0QCSX61RS1Fpy5YuRdSBxEQG6cJFhWkdeEcXGVdmmgbpY
	 NfPRaJA+LiDFlhcz8r8CWt5fYFx1uAzzj2eHqNMKYteAaPvmfSZYv/8UnAYDe7PfT0
	 iZH5Q5wZGYCfGRkZtrp6PhHPcTTOMQO9o+QkFzaVFn3aBwWdTKJV4C1ErvG+ua+tiF
	 lPRQgHsfU/KNcsDgGpn5Cwzvd2g7kJnK6YcEdCtMrMyMxeFvfLdb6W0ObFxuW/2cgV
	 rZGgsZT+AiRYg==
Message-ID: <sashiko-outbox-189257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 03/11] riscv: sse: mask events during shutdown and
 kexec
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029074853.35467-4-zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
 <20261029074853.35467-4-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 12:10:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] riscv: sse: unmasked SSE on other harts and preemptible machine_re=
start()
- [Medium] riscv: sse: unreachable !CONFIG_SMP panic_smp_self_stop() in res=
et.c
--

commit 62f5a8c35f215daa60d30a9c5320a99ed72eb26e
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

riscv: sse: mask events during shutdown and kexec

This commit masks SBI Supervisor Software Events (SSE) on the local hart
during panic stop, CPU stop, restart, poweroff, and crash shutdown paths,
and rejects normal kexec from a crash kernel when firmware advertises SSE.

Link: https://lore.kernel.org/r/as7-3PbWDxygadnJ@hu-himchau-blr.qualcomm.co=
m/

> diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
> index 14eb08a6db855..fdab37e7ae52d 100644
> --- a/arch/riscv/kernel/reset.c
> +++ b/arch/riscv/kernel/reset.c
> @@ -6,6 +6,20 @@
>  #include <linux/efi.h>
>  #include <linux/reboot.h>
>  #include <linux/pm.h>
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

[Severity: Medium]
Can this !CONFIG_SMP implementation of panic_smp_self_stop() in
arch/riscv/kernel/reset.c ever be reached, and does a panic under !CONFIG_S=
MP
leave SSE unmasked on the panicking hart?

In kernel/panic.c, panic_smp_self_stop() is only called from vpanic() and
nmi_panic() -> nmi_panic_self_stop():

kernel/panic.c:vpanic() {
	if (panic_try_force_cpu(fmt, args)) {
		set_cpu_online(smp_processor_id(), false);
		panic_smp_self_stop();
	}
	...
	if (panic_try_start()) {
		/* go ahead */
	} else if (panic_on_other_cpu())
		panic_smp_self_stop();
}

When !CONFIG_SMP, panic_try_force_cpu() returns false directly. Furthermore,
panic_on_other_cpu() checks:

kernel/panic.c:panic_on_other_cpu() {
	return (panic_in_progress() && !panic_on_this_cpu());
}

Because raw_smp_processor_id() is 0 on !CONFIG_SMP and panic_try_start() on=
ly
ever sets panic_cpu to 0, panic_on_this_cpu() is always true whenever a pan=
ic
is in progress, making panic_on_other_cpu() always false.

Meanwhile, on CONFIG_SMP kernels, the panicking CPU masks SSE in
panic_other_cpus_shutdown() via smp_send_stop() or crash_smp_send_stop() in
arch/riscv/kernel/smp.c:

kernel/panic.c:panic_other_cpus_shutdown() {
	if (!crash_kexec)
		smp_send_stop();
	else
		crash_smp_send_stop();
}

On !CONFIG_SMP kernels, arch/riscv/kernel/smp.c is not built and both
smp_send_stop() and the weak crash_smp_send_stop() reduce to the no-op
smp_send_stop() in include/linux/smp.h. Without the panic notifier from the
follow-up commit "drivers: firmware: add riscv SSE support" (for example, w=
hen
CONFIG_RISCV_SBI_SSE is disabled, in a kdump kernel, or before arch_initcall
runs sse_init()), nothing masks SSE on the panicking hart under !CONFIG_SMP.

> @@ -18,6 +32,8 @@ EXPORT_SYMBOL(pm_power_off);
> =20
>  void machine_restart(char *cmd)
>  {
> +	riscv_sse_mask_current_hart();
> +
>  	/*
>  	 * UpdateCapsule() depends on the system being reset via ResetSystem().
>  	 */
> @@ -30,12 +46,14 @@ void machine_restart(char *cmd)
> =20
>  void machine_halt(void)
>  {
> +	riscv_sse_mask_current_hart();
>  	do_kernel_power_off();
>  	default_power_off();
>  }
> =20
>  void machine_power_off(void)
>  {
> +	riscv_sse_mask_current_hart();
>  	do_kernel_power_off();
>  	default_power_off();
>  }

[Severity: High]
Should machine_restart(), machine_halt(), and machine_power_off() in
arch/riscv/kernel/reset.c also disable local interrupts and call
smp_send_stop() before masking SSE?

In arch/riscv/kernel/reset.c, riscv_sse_mask_current_hart() only masks SSE =
on
the local hart via SBI_SSE_HART_MASK. Although this patch adds
riscv_sse_mask_current_hart() to ipi_stop() and smp_send_stop() in
arch/riscv/kernel/smp.c, none of machine_restart(), machine_halt(), or
machine_power_off() call local_irq_disable() or smp_send_stop().

While the follow-up commit "drivers: firmware: add riscv SSE support" adds
sse_reboot_notifier() on reboot_notifier_list to tear down and mask SSE via
cpuhp_remove_state(CPUHP_AP_RISCV_SSE_ONLINE) during normal kernel_restart(=
),
kernel_halt(), and kernel_power_off(), emergency_restart() invokes
machine_emergency_restart() -> machine_restart(NULL) directly without runni=
ng
reboot_notifier_list or migrate_to_reboot_cpu():

emergency_restart()
  -> machine_emergency_restart()
    -> machine_restart(NULL)

During emergency_restart() (for example from sysrq_handle_reboot(),
hw_failure_emergency_action_func(), watchdog handlers, or driver recovery
workqueues), or during normal restart/halt/poweroff if sse_cpu_teardown()
fails on a CPU, secondary CPUs never receive IPI_CPU_STOP and remain online
with SSE unmasked.

In addition, because machine_restart() does not disable interrupts or
preemption before calling riscv_sse_mask_current_hart(), callers with
preemption enabled can be migrated to another unmasked hart after
riscv_sse_mask_current_hart(), or preempted into idle if do_kernel_restart()
falls through to the infinite loop, where sse_pm_notifier() (CPU_PM_EXIT) c=
an
unmask SSE on the local hart because sse_shutting_down remains false.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029074853.3546=
7-1-zhangzhanpeng.jasper@bytedance.com?part=3D3
