Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A402B17A2F6
	for <linux-perf-users@vger.kernel.org>; Sat,  9 May 2026 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778339787; cv=none; b=Q3i3vEnjw6xlwPso3CEnxn26qSzBrFkrTNstxazdzdL8jjvRM3dSKXNBfiW7Xc6n4ZsEybMRpb/MDTU2NdsV5wW+NlfGua0tcD1AD3DjZ9esWGGQ+ZOUpsEoeawCwUlsGB+jONATO5J1f7WrtdPHAjJGKjKbe5YACl7TPB5sDjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778339787; c=relaxed/simple;
	bh=TerI3/Jr7GNtYdI6Ac+Xdx2mO7s8NqwSmSYTfxAhP7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tn2srAVezhivY7onSwp2YSGjtBJFb70s4GsJTIIWIAQvYbxpehsMg/sAJd6iUU3CBE3PhVAS/lvFlrkhOFgfv90/we3ZDCl+GWFnTJutarrcv6oNBmf8ZhNoGLyaI333fK4cJgWySwOytMPgek2kz8UEaP5UNDg2w67cBw1XOWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj34QQ4H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj34QQ4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AD2C2BCB2;
	Sat,  9 May 2026 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778339787;
	bh=TerI3/Jr7GNtYdI6Ac+Xdx2mO7s8NqwSmSYTfxAhP7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Pj34QQ4HpS94kP8QEJG+43elN28q9Y3SqlN/sx5EX5I1Zhe+M7l7F7vduOerhvaOO
	 3QMCa/fjQQWchkB8Q7Gp4Tp5SrQjLG+o4GSdbc6IusTZsw5ohN3FRn27VM91q7WZ9c
	 wFvKRE8XT2QamA2W+E9YCH4Hpj6pFcdYLTjZWmAXMRoMM98yhRxHiMrPgsXYUS/na8
	 VSgyl2gd7TN16/hZb3M9IPfQcFN9NiENn92RpvnswNeZF/L0XEXixUen7+3nKCczBy
	 IgWwTP+LoSTQw3aqWONp/13uecSuMoc24TaIbcIHiyqUPw7kG2+7DHbbFxyNJLCRjw
	 16VCHFQJX6dcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/5] perf: RISC-V: add support for SSE event
Reply-To: sashiko@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <7989b7338b7480164bda55131fb7537bd9416591.1778331862.4.git.zhangzhanpeng.jasper@bytedance.com>
References: <7989b7338b7480164bda55131fb7537bd9416591.1778331862.4.git.zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 15:16:26 +0000
Message-Id: <20260509151627.29AD2C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Skipping `pmu_sbi_start_overflow_mask()` when an event is throttle=
d leaves all active PMU counters permanently stopped in hardware.
- [High] Missing unregistration of the SSE event on PMU teardown or probe f=
ailure causes a memory leak and use-after-free.
- [Medium] Executing synchronous SBI ecalls in `pmu_enable` and `pmu_disabl=
e` introduces severe context switch latency.
- [Medium] The `RISCV_PMU_SBI_SSE` config lacks a required dependency on `R=
ISCV_PMU_SBI`, violating Kconfig consistency.
--

commit 81e6d410a510416892cbd91339e3c8f19af5b1b2
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

perf: RISC-V: add support for SSE event

This commit adds support for delivering local PMU interrupts via SSE
events. It registers an SSE handler for the local PMU event, honors
throttle returns from perf core, and adds a new RISCV_PMU_SBI_SSE
Kconfig option.

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index ab90932fc2d01..a92846bcffaca 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -105,6 +105,16 @@ config RISCV_PMU_SBI
>  	  full perf feature support i.e. counter overflow, privilege mode
>  	  filtering, counter configuration.
> =20
> +config RISCV_PMU_SBI_SSE
> +	depends on RISCV_PMU && RISCV_SBI_SSE

Should this depend on RISCV_PMU_SBI instead of RISCV_PMU?=20

The implementation for pmu_sbi_setup_sse() is located in riscv_pmu_sbi.c,
which is only compiled if RISCV_PMU_SBI is enabled. If a user enables
RISCV_PMU and RISCV_SBI_SSE but leaves RISCV_PMU_SBI disabled, it seems
like this feature would be selectable but its functions would do nothing.

> +	bool "RISC-V PMU SSE events"

[ ... ]

> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index 8e3cd0f35336f..a48e286d9394f 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -254,6 +255,24 @@ void riscv_pmu_start(struct perf_event *event, int f=
lags)
>  	perf_event_update_userpage(event);
>  }
> =20
> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
> +static void riscv_pmu_disable(struct pmu *pmu)
> +{
> +	struct riscv_pmu *rvpmu =3D to_riscv_pmu(pmu);
> +
> +	if (rvpmu->sse_evt)
> +		sse_event_disable_local(rvpmu->sse_evt);
> +}

Does mapping pmu_disable and pmu_enable to sse_event_disable_local and
sse_event_enable_local introduce significant context switch latency?

Since the perf core frequently invokes these callbacks during task
context switches, performing a synchronous SBI ecall to trap into the
machine-mode firmware on every switch might introduce a massive
performance regression.

> +
> +static void riscv_pmu_enable(struct pmu *pmu)
> +{
> +	struct riscv_pmu *rvpmu =3D to_riscv_pmu(pmu);
> +
> +	if (rvpmu->sse_evt)
> +		sse_event_enable_local(rvpmu->sse_evt);
> +}
> +#endif

[ ... ]

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 385af5e6e6d0d..e6f5a619a2c08 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -1133,18 +1136,65 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, v=
oid *dev)
>  			 * TODO: We will need to stop the guest counters once
>  			 * virtualization support is added.
>  			 */
> -			perf_event_overflow(event, &data, regs);
> +			ev_overflow |=3D perf_event_overflow(event, &data, regs);
>  		}
>  		/* Reset the state as we are going to start the counter after the loop=
 */
>  		hw_evt->state =3D 0;
>  	}
> =20
> -	pmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);
> +	if (!ev_overflow || !from_sse)
> +		pmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);

When perf_event_overflow() throttles an event and returns a non-zero value,
ev_overflow is set to 1. For SSE events, won't this cause the condition to
evaluate to false and completely skip calling pmu_sbi_start_overflow_mask()?

Since pmu_sbi_stop_hw_ctrs() is called at the beginning of the handler,
it seems like skipping this would leave all active hardware counters
permanently stopped in hardware, with the perf core unaware because the
event state was just reset inside the loop.

> +
>  	perf_sample_event_took(sched_clock() - start_clock);
> =20
>  	return IRQ_HANDLED;
>  }

[ ... ]

> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
> +static int pmu_sbi_ovf_sse_handler(u32 evt, void *arg, struct pt_regs *r=
egs)
> +{
> +	struct cpu_hw_events __percpu *hw_events =3D arg;
> +	struct cpu_hw_events *hw_event =3D raw_cpu_ptr(hw_events);
> +
> +	pmu_sbi_ovf_handler(hw_event, regs, true);
> +
> +	return 0;
> +}
> +
> +static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
> +{
> +	int ret;
> +	struct sse_event *evt;
> +	struct cpu_hw_events __percpu *hw_events =3D pmu->hw_events;
> +
> +	evt =3D sse_event_register(SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW, 0,
> +				 pmu_sbi_ovf_sse_handler, hw_events);

Is there a corresponding sse_event_unregister() call missing in the
PMU teardown or error cleanup paths?

If the PMU device probe fails after registration, or if the driver is
subsequently unbound, won't the registered SSE event remain active in the
firmware? A subsequent hardware overflow might trigger the handler and
dereference the freed hw_events pointer, causing a use-after-free.

> +	if (IS_ERR(evt))
> +		return PTR_ERR(evt);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1778331862.gi=
t.zhangzhanpeng.jasper@bytedance.com?part=3D4
