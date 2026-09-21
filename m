Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20648F011
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990233; cv=none; b=alcM4mLBgUvmkYL2MKltQhbzQS18qh5UzBy8yAATPAFXKzaknjgoHul7Cu2KslixIO18VRpQUhIJwN01bhex31/eLSLz83GHCJcpbw2bZ0PV3rOZ7dSf5ZGAQ1XvhGTmp0IkZXp3G7eqOCh434WorKBA+t/NohDrULMessh7MxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990233; c=relaxed/simple;
	bh=4J5rjnl8PkZ9amKW0A52ExlpuzubR4eRR/iLnqcaagw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WQd2ti7LeZVHQpvD82emfyYYaLHbNoDd6tnRG+7ALv54FSQLUinNWE7Oys8SeqAXXUH5RMX6cVj9HnCYaupRvBUdbpHQ389QjWf5cwKGrues7KnLiwjv3ojbBRQUXRdK1Q68E03abuZlNBFAtfrCgolUGwZshzMY+Y1jeyqnYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yg6gIT12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yg6gIT12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0100D1F00898;
	Mon, 21 Sep 2026 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789990232;
	bh=0jpN4bVx8CoHbzbiOPF2jkI44QXzaz2kCq4WCRL6Ej4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yg6gIT12lw2olMEHmPfu2WwxsmEu0BihO9wodlQkq2Ll/2XZylTMevF8t9vy/Aci8
	 eHFtj3acJXgjJU/XDEkLqM+FGFmiymMT3X54tdzzsOSh6nJH2bKCPMKNJT392/p53x
	 hirCS/6d5Rh17Nmmpt2ioJfISyoggUla953G4Gt9cOTF7xD+LWEFLaje9W9m4QxOjO
	 tOrLSYdDudJzjEfnk0A625TgTP0ody/xAWtal5rgeZNQ5rihvHbUpQQwhIRvIulUVQ
	 QiCpcObg+hUyaAGrH1Gh01Pt9tQcAHJiVRWJgP73yXx9gEBqUFsACi8oXLTC/RTDwQ
	 Zf0b9obZPfuXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 RESEND 3/9] riscv: sse: mask events during shutdown
 and kexec
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <03472b45125793a768f3e5bbc168f167e673d4cc.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
References: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
 <03472b45125793a768f3e5bbc168f167e673d4cc.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:30:31 +0000
Message-Id: <20260921113032.0100D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] riscv: dead code in UP panic_smp_self_stop() misses early SSE mask
--

commit 7602c0f047088ef36df958ced3408ede048d0ce9
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

riscv: sse: mask events during shutdown and kexec

This commit masks SSE events on the local hart before panic stop, CPU stop,
restart, poweroff, and crash shutdown paths to prevent firmware from enteri=
ng
a Linux-owned handler state after the CPU or kernel context becomes invalid.
It also rejects normal kexec from a crash kernel to avoid transferring unkn=
own
firmware state to the new kernel.

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

[Severity: Low]
Is this panic_smp_self_stop() function reachable on UP systems?

When a kernel panic occurs on a UP system, the single CPU will always win t=
he
panic_try_start() race and proceed as the primary panicking CPU. The primary
panicking CPU never calls panic_smp_self_stop().

Additionally, on UP systems, the smp_send_stop() and crash_smp_send_stop()
functions are inline no-ops, so the primary CPU does not mask its own SSE
early in the panic path. Although a follow-up patch (Patch 4) adds a panic
notifier that eventually masks the SSE before the final infinite loop, the =
UP
CPU remains unmasked during the early panic stages (such as stack trace
dumping), and this added UP code appears to be entirely dead.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789974241.gi=
t.zhangzhanpeng.jasper@bytedance.com?part=3D3
