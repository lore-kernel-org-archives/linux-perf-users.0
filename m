Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC24A3AE6F3
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990427; cv=none; b=tZfsbrIXmSMeTDfM9yEYwIH0QbFZyAOa9uFO7oKl/oQEPfKGgap6tj/lut0N99k7kKzXCy3oL8W79UnCwfMnmkGb399M9Dun1cJqVtX2w6QUBI98Xuqq9WyMfhM4XbCzDL3RGNsa82UMJnnu22hnKb8aXtc4crKJeW1b7/SI00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990427; c=relaxed/simple;
	bh=HN0z6zAoTo9yJqjaQ6UyfewzqwALhSvM1FLhVuKRY68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MMMRAH1vyzb92sxE6xkpXuVF4JZojXXKiRaXJAPQzMxsOgVtZTr1lRk/nWPjFe9K3rpBWO5F3jNw6OyZeJuFb0rOFFTn95x+DkMJlqNroAQWZ6X1AcsDfHQUCDDOVdq711eNlgkocvx6G0Do6FyFVB6VMaB5kiqrf55LZ+QctKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlatJHoD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlatJHoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A831F000FF;
	Mon, 21 Sep 2026 11:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789990425;
	bh=lDfOYwcVsss2Gjw5fVEf8K36IW8+L08cW0H77yFXvwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LlatJHoDqwFbyTDfc0ZAoKE1IgxWVHDbA7eu6InuTGVZJXkpHrcRodZr3GQOnM7S/
	 d4Gnivqz8ydeK1GffyovZx43Yah0baiqkaPQOODjW8XWMsojou8UtOcuc0a0USsf7l
	 MG2fhtM/NQcHLVNb/LF4vJczNUb36xMezB7a1YG/GS0Vn99kKSygEk0XauTyeQG/hX
	 J9LpR1iJnbN8ZkAszpQaNJglUmSy1VLKc7LkCqy4IUxBG0Ih5QWx5RLddGZsLLd0h4
	 CabCLcUgP7dXipNDyV0cDnbQ+/AIARDyu3c6zjuzL/8dzR710n/Zglj10F37oPERgb
	 xzwDgstiTJ1xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 RESEND 7/9] perf: RISC-V: add support for SSE event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4f7828b3e30407de9df205264bb94edc767d318c.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
References: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
 <4f7828b3e30407de9df205264bb94edc767d318c.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:33:44 +0000
Message-Id: <20260921113345.21A831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf/riscv: flawed IRQ teardown logic on probe error when using SSE
--

commit 032c8cbfa5a61964759ab79256536a060b79e8f8
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

perf: RISC-V: add support for SSE event

This commit registers a handler for the local PMU overflow SSE event so
that RISC-V perf can receive overflows when normal S-mode interrupts are
masked. It sets up the delivery mechanism once during PMU probe and
handles SSE delivery state transitions during CPU power management.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -1844,6 +1844,7 @@ static int pmu_sbi_device_probe(struct platform_dev=
ice *pdev)
>  	ret =3D pmu_sbi_setup_irqs(pmu, pdev);
>  	if (ret < 0) {
>  		pr_info("Perf sampling/filtering is not supported as sscof extension i=
s not available\n");
>  		pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_INTERRUPT;
>  		pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_EXCLUDE;
>  	}
>  	irq_requested =3D (ret =3D=3D 0);

[Severity: Low]
When pmu_sbi_setup_irqs() successfully configures SSE delivery, it returns 0
without mapping an IRQ. Does this mistakenly set irq_requested to true,
treating general delivery setup success as an IRQ allocation? Should this
condition check riscv_pmu_use_irq instead?

> =20
> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
> +	if (pmu->sse_active) {
> +		pmu->pmu.pmu_enable =3D pmu_sbi_sse_enable;
> +		pmu->pmu.pmu_disable =3D pmu_sbi_sse_disable;
> +	}
> +#endif

[ ... ]

> @@ -1885,8 +1895,8 @@ out_unregister:
>  	perf_pmu_unregister(&pmu->pmu);
> =20
>  out_destroy:
>  	riscv_pmu_destroy(pmu);
>  	if (irq_requested) {
>  		free_percpu_irq(riscv_pmu_irq, pmu->hw_events);
>  		irq_dispose_mapping(riscv_pmu_irq);
>  		riscv_pmu_irq =3D 0;
>  	}

[Severity: Low]
If pmu_sbi_device_probe() fails later (such as in perf_pmu_register()) after
SSE delivery is configured, irq_requested will evaluate to true here.

Does this inadvertently cause the cleanup path to attempt to free and dispo=
se
of an unallocated IRQ (with riscv_pmu_irq =3D=3D 0)?

Although the IRQ subsystem safely mitigates this since irq_dispose_mapping(=
0)
ignores virq =3D=3D 0 and free_percpu_irq(0) safely returns early, could th=
is
flawed logic be corrected by verifying riscv_pmu_use_irq instead of the
ret =3D=3D 0 success flag?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789974241.gi=
t.zhangzhanpeng.jasper@bytedance.com?part=3D7
