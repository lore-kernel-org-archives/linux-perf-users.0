Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991630;
	b=2GpLU4p8vkJ8XhzbYXHixz6f0bYNkKdExsl/m6cIttldC1z2JyJ9CTEPAZ6wx+N5CYuM
	 G0gYAfghSJNU/upAHp+HY5XT8bYoYzOfdjvu4JbBGbOKE/iUvL8ypapU1J5VWoBsm9Y73
	 E15oqCzW8LN3+RMrEWsNaCmdnd2qEcBVlLRVWBBur9f2RzGG8naVGznDEtGfUvnTc02CN
	 THgVaOTJ1wfLC12Ac8w8izZoqBhhUdcokPHS9SLowOxivOUOcDS9x5Riuc6nFGCZWJf1d
	 lRDSV/wv90RU4wCdLqSWGifhMsMafmd5Teb8NXiJ+YrlU8sq23DZei1CWO3wZ0qbbRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991630;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uYwSNnb7OA+GCMgTJIkrtvCSV/hKTuQm/TCR4lvd0JE=;
	b=OqqrResvJO4oCWtkCBfs+QIEi5yawlJ7qVQCSnEmr/7HMTly/6k6a3i//EpovEAcJsIA
	 QCxwPP/82gsn0ghHd5fh/mKQs8ljSEmV/fapw4+YmsyIsySTCQMkLmiu1dmZNmirpbBx6
	 CwPzuYxvtVQKYHKHm2Lai1BzTQPqfbSRawwItT9VJv7XTKwNi6CGTukrNPKeL0A/I1Uvi
	 pF+JUZJjZ+JZ0Qjha0jbCMBo3+Vtu9toJywpzMVLhPfybxxOk2kAKMHseR935vPcRNtRQ
	 /yhIrADua23GgBoVUCdsnpPv6aaDcTuGtWQzbePFfWrom42rQ2Ydo3osPu11op8DL+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdHFvCC1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862D606A31C;
	Wed, 18 Nov 2026 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdHFvCC1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50E71F000C4;
	Wed, 18 Nov 2026 08:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991630;
	bh=uYwSNnb7OA+GCMgTJIkrtvCSV/hKTuQm/TCR4lvd0JE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hdHFvCC1WPamkRXXXdud9djAk7xMgrMdJOMeOMRXCkiFmRqPUfpggrsjEwsr22pA9
	 NPk/uQxxLQ2wv1ESL1EIHXfJ+XOZng3bDNtip2jsvtTr/2/vBcf6hbn6M+5tGgdRwy
	 sMCQuwmMTu0NVZndUUPSZ/tFb5x4GmG93YoVIjC2SvGPXvigsG7GRKB6sOU969XxIF
	 bgRdi3bOOxu9xmnAL9A/4oS4u8T0mV+rVuk8fDrOUZ+3tKLgGksbIJa15UVlVCOovf
	 t57h7C6e5FmPdj9yPx0IFL11Q+0CIlSg9nwM1e6bdmM8259pl8v09bQNWZu2DdiHfk
	 eiJ/MtNb3Rl+A==
Message-ID: <sashiko-outbox-220493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 5/5] perf: riscv: Deliver PDIS samples through
 the SBI PMU interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>, linux-perf-users@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118081327.10684-12-zhangzhanpeng.jasper@bytedance.com>
References: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
 <20261118081327.10684-12-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:47:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] perf: riscv: transient pdis_cpus clear in
  pdis_cpu_pm_notify() on idle exit
- [Medium] perf: riscv: pmu_sbi_ovf_handler() restarts stopped counters
  on PDIS IRQ
- [Medium] perf: riscv: pcpu->ready left enabled on failure in
  riscv_pdis_register()
--

commit cd24c079596cb117f90d17389f647a0a1991c1b3
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

perf: riscv: Deliver PDIS samples through the SBI PMU interrupt

This commit wires up PDIS overflow handling into the shared SBI PMU
interrupt handler, registers a CPU PM notifier to preserve PDIS state
across idle states, and registers the PDIS test PMU from the SBI PMU
probe path.

> diff --git a/drivers/perf/riscv_pdis.c b/drivers/perf/riscv_pdis.c
> index 9a8fe5e4ab828..60c9ece22dfce 100644
> --- a/drivers/perf/riscv_pdis.c
> +++ b/drivers/perf/riscv_pdis.c

[ ... ]

> @@ -413,6 +480,32 @@ void riscv_pdis_cpu_dying(void)
>  	cpumask_clear_cpu(smp_processor_id(), &pdis_cpus);
>  }
> =20
> +static int pdis_cpu_pm_notify(struct notifier_block *nb, unsigned long c=
md, void *v)
> +{
> +	struct pdis_cpu *pcpu =3D this_cpu_ptr(&pdis_cpu);
> +	struct perf_event *event =3D pcpu->event;
> +
> +	if (!pcpu->ready)
> +		return NOTIFY_DONE;
> +	if (cmd =3D=3D CPU_PM_ENTER) {
> +		pcpu->pm_resume =3D event && !(event->hw.state & PERF_HES_STOPPED);
> +		if (event)
> +			pdis_stop(event, PERF_EF_UPDATE);
> +		else
> +			pdis_quiesce();
> +	} else if (cmd =3D=3D CPU_PM_EXIT || cmd =3D=3D CPU_PM_ENTER_FAILED) {
> +		riscv_pdis_cpu_starting();
> +		if (pcpu->pm_resume && pcpu->ready && event)
> +			pdis_start(event, PERF_EF_RELOAD);
> +		pcpu->pm_resume =3D false;
> +	}
> +	return NOTIFY_OK;
> +}

[Severity: Medium]
Can calling riscv_pdis_cpu_starting() on CPU_PM_EXIT or
CPU_PM_ENTER_FAILED cause concurrent perf_event_open() calls targeting the
waking CPU to fail spuriously with -ENODEV?

riscv_pdis_cpu_starting() clears the CPU from pdis_cpus before re-probing
device tree properties and CSRs:

drivers/perf/riscv_pdis.c:riscv_pdis_cpu_starting() {
	pcpu->ready =3D false;
	pcpu->counter_valid =3D false;
	cpumask_clear_cpu(cpu, &pdis_cpus);
	...
	pcpu->ready =3D true;
	cpumask_set_cpu(cpu, &pdis_cpus);
}

Because CPU_PM_EXIT runs on every deep cpuidle wakeup without serializing
against pdis_event_init() or cpumask_show() on other CPUs, a concurrent
reader can observe the online CPU missing from pdis_cpus:

CPU0                              CPU1
pdis_cpu_pm_notify(CPU_PM_EXIT)
  riscv_pdis_cpu_starting()
    cpumask_clear_cpu(0, &pdis_cpus)
    pdis_test_model_matches(0)
                                  perf_event_open(..., cpu=3D0)
                                    pdis_event_init()
                                      !cpumask_test_cpu(0, &pdis_cpus)
                                        --> returns -ENODEV
    cpumask_set_cpu(0, &pdis_cpus)

[ ... ]

> @@ -444,3 +537,22 @@ static struct pmu pdis_pmu =3D {
>  	.check_period =3D pdis_check_period,
>  	.sched_task =3D pdis_sched_task,
>  };
> +
> +int riscv_pdis_register(struct device *parent)
> +{
> +	int ret;
> +
> +	if (cpumask_empty(&pdis_cpus)) {
> +		if (pdis_test)
> +			dev_info(parent, "PDIS test PMU unavailable on all online CPUs\n");
> +		return -ENODEV;
> +	}
> +	ret =3D cpu_pm_register_notifier(&pdis_cpu_pm_nb);
> +	if (ret)
> +		return ret;
> +	pdis_pmu.parent =3D parent;
> +	ret =3D perf_pmu_register(&pdis_pmu, "riscv_pdis_test", -1);
> +	if (ret)
> +		cpu_pm_unregister_notifier(&pdis_cpu_pm_nb);
> +	return ret;
> +}

[Severity: Medium]
If riscv_pdis_register() fails, does it leave pcpu->ready and pdis_test
enabled while the SBI PMU continues running without pdis_cpu_pm_nb
registered?

pmu_sbi_device_probe() calls cpuhp_state_add_instance() before
riscv_pdis_register(), which sets pcpu->ready =3D true on online CPUs via
pmu_sbi_starting_cpu() -> riscv_pdis_cpu_starting(), and ignores
registration errors from riscv_pdis_register().  If
cpu_pm_register_notifier() or perf_pmu_register() fails (or if
riscv_pdis_register() returns -ENODEV and a PDIS-capable CPU is brought
online later), riscv_pdis_irq_prepare() still runs on every SBI PMU
interrupt and executes an unguarded csr_clear(RISCV_PDIS_CSR_CTL,
RISCV_PDIS_CTL_OF) without pdis_cpu_pm_notify() registered to quiesce or
re-probe PDIS CSRs across non-retentive CPU idle transitions.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 545b8becf90ae..af86a30aae835 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -1092,24 +1092,23 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, v=
oid *dev)

[ ... ]

> @@ -1128,7 +1127,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, voi=
d *dev)
> =20
>  	/* No overflow bit is set */
>  	if (!overflow)
> -		return IRQ_NONE;
> +		goto restart;
> =20
>  	regs =3D get_irq_regs();
> =20
> @@ -1181,10 +1180,20 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, v=
oid *dev)
>  		hw_evt->state =3D 0;
>  	}
> =20
> -	pmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);
> -	perf_sample_event_took(sched_clock() - start_clock);
> +	handled =3D true;
> =20
> -	return IRQ_HANDLED;
> +restart:
> +	/* A PDIS-only interrupt must also resume the ordinary HPM counters. */
> +	pmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);

[Severity: Medium]
Does jumping to restart on a PDIS-only interrupt start SBI hardware
counters that perf has stopped or throttled?

When an SBI PMU event is stopped via riscv_pmu_stop() (for example by
PERF_EVENT_IOC_DISABLE or perf_event_throttle()), event->hw.state has
PERF_HES_STOPPED set, but its bit in cpu_hw_evt->used_hw_ctrs remains set
until riscv_pmu_del().  pmu_sbi_start_overflow_mask() starts every counter
in used_hw_ctrs & ~ctr_ovf_mask without checking PERF_HES_STOPPED:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_start_ovf_ctrs_sbi() {
	for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
		ctr_start_mask =3D cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
		/* Start all the counters that did not overflow in a single shot */
		if (ctr_start_mask) {
			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG,
				  ctr_start_mask, 0);
		}
	}
}

When a PDIS-only interrupt fires on a CPU with a stopped SBI HPM event,
overflow is 0 and overflowed_ctrs is 0, so pmu_sbi_start_overflow_mask()
restarts the stopped hardware counter behind perf's back.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118081327.1068=
4-7-zhangzhanpeng.jasper@bytedance.com?part=3D5
