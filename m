Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B34756D6
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130282; cv=none; b=EAC7DrvlMrwSk4t1Yh7UXH0kNMnHkd5M10qhIq0MzN63KDHr9R6x8EzngfGvw5WAeyokZ54cBopt0tLFu+Vq89ls1W/4FwIo+t7+S8enJh6GAORY/gIDvpXwke6vOtJEhIcmWjhH3G3jULkHRifo1X4+7M55F2HTP0h8mKI3HuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130282; c=relaxed/simple;
	bh=EEdV8nJj4rUld3svFvekVlcEaQznlum5ZbnBX3DS10k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vuyawa7oq07FpcPKCO8lLz8/H45IW5hZJS6ezVB95p1TzrPimfYq8LqlOZWmWI5lD5aUt3gbfL2ucub7c+zCo1/59lShn8TZ1OQ0zBMLZJ3yZW88PWSDFQ8BaLHMNLgR/hRk4QcFU3UOpz2ZDckc4vx8VXjVqF49J/lxa4U3NU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezs7L4uq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezs7L4uq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577FE1F00893;
	Fri, 11 Sep 2026 12:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130280;
	bh=FnnQJHMYiIadQT7SDCg4u+yKLGdk57/6J8u+8IrSQEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ezs7L4uqjA7fd0jwTp2BQ9k1u9uGKg1+qnbmQLVXoXb0CSw4gaiHy3bMlAeUt35cj
	 MY6iZTDn20ZN0PtVlHgOeDU1YnnBcFiPTGvjXlH/y6MrYfXf2FsvuKqbkF9fEgSNb/
	 RUTpkW1hx5J3waZBtCHjPcALFmhNdLmx9bBUouQ3iWKhCYa7OHVAFjLZeztqcG2xd6
	 9BIHPTB35hGxhXHftxeR2LyHrMZsQGvpyq/R4OHij7B+IXg1l9kEcTqdIH0Ilkki4F
	 ssMpAwz3Kx/6KJUSgwjH3EBQ5X+j9UsyzFQJNoImriNGtC7X5x7LxIgRnDJ2a1FTK3
	 weYMdrCIl4U5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 7/9] perf: RISC-V: add support for SSE event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260911121456.33223-8-zhangzhanpeng.jasper@bytedance.com>
References: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
 <20260911121456.33223-8-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:37:59 +0000
Message-Id: <20260911123800.577FE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The SSE overflow handler early bailout checks `events[fidx]` where=
 `fidx` is the lowest active counter in `used_hw_ctrs`. Because `used_hw_ct=
rs` is updated non-atomically relative to `events[]` during event addition =
and deletion, an SSE NMI arriving in this window observes a NULL event and =
permanently stops all PMU counters.
- [High] Synchronously calling `riscv_pmu_stop` from `pmu_sbi_fail_sse` in =
NMI context corrupts PMU state if it interrupts perf core operations.
- [Medium] Overloaded use of `ret =3D=3D 0` causes `irq_requested` to be tr=
ue even when SSE setup succeeds (which does not request an IRQ). This leads=
 to an invalid `free_percpu_irq` on IRQ 0 in the probe error path.

Pre-existing issues:
- [High] On 32-bit RISC-V architectures, the driver uses a 32-bit `unsigned=
 long` for `cmask` and invokes `BIT(i)` in a loop up to `RISCV_MAX_COUNTERS=
` (64). This causes undefined behavior when `i >=3D 32` and fails to track =
or stop PMU counters with IDs >=3D 32.
--

commit 9148146c03e3720e4a1ce81cb1e6c77ab87c87df
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
Subject: perf: RISC-V: add support for SSE event

This commit adds support for the local PMU overflow SSE event so that RISC-V
perf can receive overflows even when normal S-mode interrupts are masked. It
selects the delivery mechanism during PMU probe and configures SSE event
masking across CPU power management transitions.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 50220f7b46d9b..7e971b47730c4 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -896,14 +898,24 @@ static int pmu_sbi_get_ctrinfo(int nctr, unsigned l=
ong *mask)
>  	return 0;
>  }
> =20
> -static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
> +static inline void pmu_sbi_stop_all_mask(unsigned long ctr_mask)
>  {
>  	/*
>  	 * No need to check the error because we are disabling all the counters
>  	 * which may include counters that are not enabled yet.
>  	 */
>  	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> -		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
> +		  0, ctr_mask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
> +}

[Severity: High]
This is a pre-existing issue, but on 32-bit RISC-V architectures, cmask is
an unsigned long, which truncates to 32 bits on RV32. In pmu_sbi_get_ctrinf=
o(),
the driver also invokes BIT(i) in a loop up to RISCV_MAX_COUNTERS (64). Does
this cause undefined behavior and fail to track or stop firmware/hardware P=
MU
counters with IDs >=3D 32 during PMU teardown or SSE early-exit paths?

[ ... ]

> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
> +/*
> + * A local SSE delivery failure makes the current PMU state unsafe to re=
sume.
> + * Latch the failure before stopping mapped events so the SSE transition=
 and
> + * overflow restart paths cannot undo the fail-safe while they are quies=
ced.
> + */
> +static void pmu_sbi_fail_sse(struct riscv_pmu *pmu, const char *op, int =
ret)
> +{
> +	struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events);
> +	struct perf_event *event;
> +	int idx;
> +
> +	if (READ_ONCE(cpu_hw_evt->sse_failed))
> +		return;
> +
> +	WRITE_ONCE(cpu_hw_evt->sse_failed, true);
> +	pr_err_ratelimited("failed to %s local PMU SSE event: %d; stopping coun=
ters\n",
> +			   op, ret);
> +
> +	for (idx =3D 0; idx < RISCV_MAX_COUNTERS; idx++) {
> +		event =3D cpu_hw_evt->events[idx];
> +		if (event)
> +			riscv_pmu_stop(event, PERF_EF_UPDATE);

[Severity: High]
Can calling riscv_pmu_stop() synchronously from pmu_sbi_fail_sse() corrupt
PMU state if executed in NMI context?=20

When pmu_sbi_ovf_sse_handler() receives a NULL regs pointer, it calls
pmu_sbi_fail_sse(). If this NMI interrupts perf core operations like
riscv_pmu_start(), the software state could become desynchronized from the
hardware counter state.

> +	}
> +}

[ ... ]

> @@ -1048,28 +1154,38 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, v=
oid *dev)
>  	struct perf_event *event;
>  	u64 overflow;
>  	u64 overflowed_ctrs =3D 0;
> -	struct cpu_hw_events *cpu_hw_evt =3D dev;
>  	u64 start_clock =3D sched_clock();
>  	struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_addr;
> =20
>  	if (WARN_ON_ONCE(!cpu_hw_evt))
>  		return IRQ_NONE;
> =20
> -	/* Firmware counter don't support overflow yet */
> +	/*
> +	 * SSE can arrive before perf installs an event. The early exits below
> +	 * must stop the PMU source before firmware completes the SSE.
> +	 */
>  	fidx =3D find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
>  	if (fidx =3D=3D RISCV_MAX_COUNTERS) {
> -		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> +		if (from_sse)
> +			pmu_sbi_stop_all_mask(cmask);
> +		else
> +			csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>  		return IRQ_NONE;
>  	}
> =20
>  	event =3D cpu_hw_evt->events[fidx];
>  	if (!event) {
> -		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
> +		if (from_sse)
> +			pmu_sbi_stop_all_mask(cmask);
> +		else
> +			ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
>  		return IRQ_NONE;
>  	}

[Severity: High]
Does this early bailout race with concurrent event addition or deletion?

The used_hw_ctrs bit is set inside riscv_pmu_add() via ctr_get_idx(), which
exposes a window where events[fidx] is NULL while the bit is active. If an
SSE NMI arrives in this window, it observes a NULL event and triggers the
!event fallback path, permanently stopping all PMU counters via
pmu_sbi_stop_all_mask().

[ ... ]

> @@ -1453,6 +1806,7 @@ static int pmu_sbi_device_probe(struct platform_dev=
ice *pdev)
>  	/* cache all the information about counters now */
>  	if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
>  		goto out_free;
> +	pmu->cmask =3D cmask;
> =20
>  	ret =3D pmu_sbi_setup_irqs(pmu, pdev);
>  	if (ret < 0) {
> @@ -1462,9 +1816,15 @@ static int pmu_sbi_device_probe(struct platform_de=
vice *pdev)
>  	}
>  	irq_requested =3D (ret =3D=3D 0);

[Severity: Medium]
Could this attempt to free an unallocated IRQ on the error path?

Because pmu_sbi_setup_irqs() now returns 0 when SSE setup succeeds,
irq_requested is set to true even when no IRQ was requested. If a subsequent
initialization step fails, the out_destroy error path would call
free_percpu_irq() for IRQ 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911121456.3322=
3-1-zhangzhanpeng.jasper@bytedance.com?part=3D7
