Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1491472556
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129824; cv=none; b=IeUcj/yIvXlOgiS+BhxXjMSotgMa1kNAtpatRUt6s8Ol5E1evCtl2RuB4iyreT3cMMn1zEVABMPEdKS+xNIwdO+btPQtMxvPvzouq83RhMIAA1GqBTJY+z+YzMllEcFcxCLwB6dJHQk/Z4i0l44vbbnJvrUj9O08642N1NKGu3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129824; c=relaxed/simple;
	bh=E7GDSC0YKSIdkAUTC5loMWMo4wk7Rf+LQSEveY2aIEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XIcGqLqQLFeOPvy5PSM73d0HSYEzO9fc90yTRqN7UuCu2TAhZcP7kAwzBk1VltAigmh4gtV6QQg3eAZrN0Zm0iYA8sN6TXSWIahTcBso6GRKsJbv5JzIYZR/SPP0BYpNqbhg5foBdRbRtmmC2Pnzo54ovT8IqOz2ibH5eTKaN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNnCNpFC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNnCNpFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C313B1F000FF;
	Fri, 11 Sep 2026 12:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789129820;
	bh=m7+DnjMbGNkfmCvUrb0xay6D4uFu9gcwUoS+B2O/JJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LNnCNpFCA4dztdcU/hrP5tWxyqVzYiTtVL2I3EtfrgbbUKG1xXQhvc7YXr95gbaFr
	 mDAf9Q0ihkALc6V/QZ4i1SCIAgEZg4F5XZReKkvETBgvSZwTsek7kioH8l2IRDQJ2+
	 fhWQ6LALW6UwkJKt4J7CV2HBhuFyRGvD+KXC/KVVYSK+rUqWIZqpoV5lkAjqwS3y5f
	 UbzpHFLw24JL/pFmAh5qNN+XJ5I+BMWnd1beaJ3l/S8GjOE+IIEHWuOudCQ/UeRfkf
	 YmDdeyry4vt+09oRDLtezVZKByR35MjjdqJZRUOEgU+8cEilqdmOdfLRHTUwL9ibqK
	 HO40f1uI7LJLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/9] riscv: sse: mask events during shutdown and
 kexec
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260911121456.33223-4-zhangzhanpeng.jasper@bytedance.com>
References: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
 <20260911121456.33223-4-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:30:20 +0000
Message-Id: <20260911123020.C313B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Normal kexec fails to mask SSE events on both the boot and seconda=
ry CPUs, risking arbitrary code execution or memory corruption in the new k=
ernel context.
- [High] The patch fails to mask SSE during normal panics on uniprocessor (=
UP) kernels, leaving the kernel vulnerable to firmware events while in a pa=
nicked state.
- [High] The hibernation resume path does not mask SSE events before restor=
ing the image, leading to a window where firmware may use an invalidated ha=
ndler context.
--

commit cf02237f794742a346c6ebd5d4d2368943f1d5da
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

riscv: sse: mask events during shutdown and kexec

This commit introduces SSE masking during various shutdown paths,
including panic, CPU stop, restart, poweroff, and crash shutdown. It
ensures that a hart stops accepting SSE events before Linux stops
servicing the registered handlers.

> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machin=
e_kexec.c
> index 738df176ff6f1..24e7affae70bf 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
[ ... ]
> @@ -127,6 +137,7 @@ void
>  machine_crash_shutdown(struct pt_regs *regs)
>  {
>  	local_irq_disable();
> +	riscv_sse_mask_current_hart();
> =20
>  	/* shutdown non-crashing cpus */

[Severity: High]
This covers the crash shutdown path, but does the normal kexec path also
need to mask SSE events?

It looks like machine_shutdown() in arch/riscv/kernel/machine_kexec.c
misses an explicit call to riscv_sse_mask_current_hart() for the boot CPU
before jumping to the new image:

arch/riscv/kernel/machine_kexec.c:machine_shutdown() {
    local_irq_disable();
    ...
    smp_shutdown_nonboot_cpus(smp_processor_id());
}

Additionally, for secondary CPUs, smp_shutdown_nonboot_cpus() routes
through CPU hotplug and eventually calls sbi_cpu_stop() in
arch/riscv/kernel/cpu_ops_sbi.c:

arch/riscv/kernel/cpu_ops_sbi.c:sbi_cpu_stop() {
    ...
    ret =3D sbi_hsm_hart_stop();
}

This path also appears to miss masking the SSE state, which would leave it
unmasked when the new kernel brings them back up.

Could firmware deliver SSE events to stale handler addresses after a normal
kexec under these conditions?

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

[Severity: High]
Will this function actually be called for the primary panicking CPU on
uniprocessor builds?

Looking at kernel/panic.c, the primary panicking CPU enters this branch:

kernel/panic.c:vpanic() {
    if (panic_try_start()) {
        /* go ahead */
    } else if (panic_on_other_cpu())
        panic_smp_self_stop();
    ...
}

Since panic_try_start() returns true for the panicking CPU, it bypasses
panic_smp_self_stop() and instead relies on smp_send_stop(). However,
smp_send_stop() is an empty macro on UP builds.

Does this leave the kernel vulnerable to firmware events while in a panicked
state on UP kernels, since the CPU enters the final infinite loop without
masking SSE?

[ ... ]
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
Since we are masking SSE events for power off and restart, do we also need
to mask them during hibernation resume?

When the temporary restore kernel jumps to overwrite its own memory with the
hibernated kernel's image in swsusp_arch_resume(), it doesn't seem to
explicitly mask SSE events:

arch/riscv/kernel/hibernate.c:swsusp_arch_resume() {
    ...
    hibernate_restore_image(resume_hdr.saved_satp, ...);
    return 0;
}

If an SSE event triggers immediately after the overwrite, could firmware ju=
mp
into corrupted memory because it still retains the temporary kernel's SSE
handler registrations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911121456.3322=
3-1-zhangzhanpeng.jasper@bytedance.com?part=3D3
