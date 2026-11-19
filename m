Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091926;
	b=r9odPXHtnFI4p4LKWFsJoKor+OE3QqCKbzKLwQ/txdScJGgutyziIvO1/JQ8qyWe6QYL
	 ppHNbB8OcJXzwsxh63zD387tRsfEsHP6REF5mlqoY1lXM+eLJq0HSKgFxsIoP/lYwr5tk
	 YLgvjthSp1ssvjEBhIgoR09Nu18Pz59TX9lmrf/RLd4rHa/1vQwgY32TImO3rO66d+oI0
	 ChnxqoLwaCfE+TBtJ6rTqhFF2C0gVkx/urBKWWx2lhQlPdXt+rHP8SlBkPE/+jCYdpta8
	 KKd2owE5obwqD7HrJUWTTJQYcmLOs1NiBER4vea+XqgIw1yzbIkSJLG6Noo0SHrZ6Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091926;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AzNV66SdhErawkTLYBlu8WpHpmukYuYHfJg0E4AqjiE=;
	b=ICdqjLgdicMDjypuayUQIp3GEG65bI0SzIsbRE3FpUqE3R0BkcE/mWIoK5fneIGs2SvT
	 mlKdR8bRFzu9vlc24xjx9TuN44QIY1omf2c5IM9dEFqDMPN6Ys3sOQnng+WhgRNLbzKc2
	 U/cLvOmETYk58lWPlncag8obYcGCylTCxVN0SN05ut7mpLXJJFmWLcly5MqzqCAmomOdd
	 OJ9u0tcqaDeSCnJffe1BpSPaGi84q6HmEoSIste1ss/IbBajZt4gv3+Qeg39yggouUSL1
	 +aj2+nb+fOZbsxYQtPo66wluPgZVWbNsebDvhGCiCMQjd6obb+AieUuSZ0WCGckhNCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eGI51/0L";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE2606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eGI51/0L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AC61F000C5;
	Thu, 19 Nov 2026 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795091926;
	bh=AzNV66SdhErawkTLYBlu8WpHpmukYuYHfJg0E4AqjiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eGI51/0Ljgjjx/IsW6tvpjgsaR1HlndkOXHfaigQMs+huHdy+uMcr5H5TuZSbuiJa
	 xiHnPd9eHEdIQS2+UFYODOuXQ7z4H57pT8rGVazUpNua3GnVbRXaRv5CKG7rn7t7uW
	 zeH8purLwgQq1RoBfz7ws0Po1urkiWfz+YI1Kswk5AnKpiSQj2Kvq/rnAwOvp6sttM
	 pJhdOC7ImOpdtzw4GOo1BenwAyiCH7kV68ZyyCZRftpSaBG0SGg2GAnJSS89e83KcC
	 v3LeiVyQA6jQYR1Qzd0OfUlrOm292hr6+B6ysc6gdfnYtc5grc1t5+Bj186jsQt3bx
	 6Lcvo6z+4w5yA==
Message-ID: <sashiko-outbox-223101@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/11] riscv: sse: mask events during shutdown and
 kexec
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119120824.13969-16-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
 <20261119120824.13969-16-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:38:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] riscv: sse: unreachable !CONFIG_SMP panic_smp_self_stop() in
  reset.c
- [Medium] riscv: sse: unmasked SSE on other harts and preemptible
  machine_restart()
--

commit 39abe8f5f293bf4034ca8ab03a15f0ede47b20ab
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

riscv: sse: mask events during shutdown and kexec

This commit masks SBI Supervisor Software Events (SSE) on the local hart
during panic, CPU stop, restart, poweroff, and crash shutdown paths, and
rejects normal kexec from a crash kernel when firmware supports SSE.

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
Is this !CONFIG_SMP definition of panic_smp_self_stop() reachable, and does
a uniprocessor panic ever mask SSE on the panicking hart?

All callers of panic_smp_self_stop() in kernel/panic.c are gated by
panic_try_force_cpu() or panic_on_other_cpu().  When !CONFIG_SMP,
panic_try_force_cpu() is a stub returning false, and raw_smp_processor_id()
is always 0 while panic_cpu can only be PANIC_CPU_INVALID or 0, so
panic_on_other_cpu() is also always false.

Meanwhile, the panicking CPU calls panic_other_cpus_shutdown() ->
smp_send_stop() / crash_smp_send_stop(), both of which compile to the empty
smp_send_stop() stub in include/linux/smp.h when !CONFIG_SMP, leaving SSE
unmasked during vpanic().

>  static void __noreturn default_power_off(void)
>  {
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

[Severity: Medium]
Can secondary harts=E2=80=94or the calling task itself after migration=E2=
=80=94still receive
SSE events during machine_restart(), machine_halt(), and
machine_power_off()?

Unlike arm64, these functions do not call local_irq_disable() or
smp_send_stop().  On paths that bypass reboot_notifier_list and
migrate_to_reboot_cpu(), such as emergency_restart() ->
machine_emergency_restart() -> machine_restart(), secondary harts never
receive IPI_CPU_STOP and stay online with SSE unmasked.  Because preemption
is not disabled before riscv_sse_mask_current_hart(), a preemptible
emergency_restart() caller (for example from a workqueue) can also migrate
to another unmasked hart after masking the previous one.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119120824.1396=
9-13-zhangzhanpeng.jasper@bytedance.com?part=3D3
