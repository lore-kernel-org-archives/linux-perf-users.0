Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091645;
	b=efe5KusEipfUCO0BuYvAlMyhN/eliNP9B+LjjdpXHzfCPsD7POBsuaIIQ0pFWHWvjvFZ
	 yjuOvgtCfAiG2vLhQrpclDzx5tz18XpdcgBE3v6WjUVR/3GROIszf2C4RU/Vf9HIfdinT
	 miESNl8gYbURzVcyCmaoRNZRBjsCr/lKGKnoihHf6BM/mG/VIQGooeSB97kSNOOPoFcww
	 KK2xv+DnRzCVmm/NxHJYHjFmQF4ZSqVjBZzgjSSTmweEjNbYrQcfdtOYEba1YCaRv+X27
	 IpPlzExOzDcdDsk3Ar72xl/KqbU4gQMZoUBatc5tQJfXEYCsK58xu8FQreJUP49bFsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091645;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pBWL0BUCvrgqcvfYufztZCROUTMcC4fyr41kwkCksqw=;
	b=YdZtEhZrwRNJPb4Q0OjPNmBFgLKVhFo2swH/UttXJhYh4nvjM/JTCpLOMqBigNQa7LNt
	 5Gt5ldDMuplu7MDkM/2UiLvF/R/hpjyVma1lyD4o25ST42AJTcLgLBiAJ4KFq5oaZXaUz
	 S9F5EcWTj4YKV0M1p+VyryP4itVAl+00Q5uq1ql/zIpgZrl6l84AZ1eWEVAtH3mRzX7bD
	 BwKrOqV7aqEtW0SiXWKgcRZDgBN+oZ06hZrmijYtIcOgaonGlVJAiZIxg5rs8d/HkaYzs
	 m0G9tWQKOQxYZ/E0278EqK7JzJdq9j5iqboikibz/8KkGwje+2BooQbHgv+jo0Y+tBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GqLWg3Wn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA2606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GqLWg3Wn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3BB1F000C4;
	Thu, 19 Nov 2026 12:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795091645;
	bh=pBWL0BUCvrgqcvfYufztZCROUTMcC4fyr41kwkCksqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GqLWg3Wnt5Kq+Cz4nc/fGG0PL9y20f6qFf4iPVBlEOOx3ZBzapX/gIfQkhlojhfja
	 HRowqKgFOoiTuv2OU1wDn+fpZ1MjMzdOh01ONVEpPihEPpi73iJUSFj89X55OOFpU5
	 i7GI+4tXojmOd7hXKEsBmpIOIvdMfrE/7pOpigrQsWqyPuZf/6iAJAmym9VxIzCBb7
	 hzzjANxE6AFZxAz4R7Ggj02D5zcbsnbPozhTMRCeA9p1ovQ8cpVEiKBgpXwzvP5P5r
	 sx/v5OFxZg2tpNyOUuYMtFobcKDNVTtmkyzRU8JZ8BonehWEiYfczneDJpVsoKxD2r
	 A/wP1vZrARRpQ==
Message-ID: <sashiko-outbox-223092@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 08/11] perf: RISC-V: add support for SSE event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119120824.13969-21-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
 <20261119120824.13969-21-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:34:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 10 potential
issues to consider:
- [High] perf: riscv: unstopped counters in pmu_sbi_ovf_sse_handler()
  when regs is NULL
- [High] perf: riscv: unhandled PERF_HES_STOPPED counters in overflow
  and stop paths
- [Medium] perf: riscv: missing sse_event_cleanup() when
  pmu_sbi_setup_sse() fails
- [Medium] perf: riscv: batch counter stop in pmu_sbi_cleanup_sse()
  skips active counters
- [Medium] perf: riscv: premature hw_evt->state reset in
  pmu_sbi_ovf_handler() loop
- [Medium] perf: riscv: missing perf_event_update_userpage() in
  pmu_sbi_fail_sse()
- [Medium] perf: riscv: pmu_sbi_sse_enable() latches sse_failed on
  hotplug and reboot
- [Medium] perf: riscv: riscv_pm_pmu_notify() ignores latched
  cpuc->sse_failed state
- [Medium] perf: riscv: lost PMU SSE resume state on CPU_PM_ENTER after
  unmask failure
- [Low] perf: riscv: unused pmu_sbi_stop_all_cpu() when
  CONFIG_RISCV_PMU_SBI_SSE=3Dn
--

commit f0818fdfc418d31969bed16ca22047c7d7a80ce8
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

perf: RISC-V: add support for SSE event

This commit adds support for delivering RISC-V SBI PMU counter overflow
events via Supervisor Software Events (SSE), including probe-time delivery
selection, CPU power-management coordination, and error handling.

Link: https://lore.kernel.org/r/20261002-reach-cloning-f1594729dbe3@wendy/

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 21a2078eab98a..a984ac57a7b6e 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> @@ -936,14 +938,42 @@ static inline void pmu_sbi_stop_all(struct riscv_pm=
u *pmu)
>  	 * which may include counters that are not enabled yet.
>  	 */
>  	for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
> -		if (!pmu->cmask[i])
> +		if (!ctr_mask[i])
>  			continue;
>  		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> -			  i * BITS_PER_LONG, pmu->cmask[i],
> +			  i * BITS_PER_LONG, ctr_mask[i],
>  			  SBI_PMU_STOP_FLAG_RESET);
>  	}
>  }
> =20
> +static void pmu_sbi_sse_stop_all(const unsigned long *ctr_mask)
> +{
> +	struct sbiret ret;
> +	int i;
> +
> +	/*
> +	 * Stop each counter separately: an already-stopped counter must not
> +	 * prevent firmware from stopping a later, overflowing counter.
> +	 */
> +	for_each_set_bit(i, ctr_mask, RISCV_MAX_COUNTERS) {
> +		ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> +				i, 1, SBI_PMU_STOP_FLAG_RESET);
> +		if (ret.error && ret.error !=3D SBI_ERR_ALREADY_STOPPED)
> +			pr_warn_ratelimited("failed to stop counter %d: %ld\n",
> +					    i, ret.error);
> +	}
> +}
> +
> +static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
> +{
> +	pmu_sbi_stop_all_mask(pmu->cmask);
> +}
> +
> +static void pmu_sbi_stop_all_cpu(void *info)
> +{
> +	pmu_sbi_stop_all(info);
> +}

[Severity: Low]
Will pmu_sbi_stop_all_cpu() trigger an unused-function warning when
CONFIG_RISCV_PMU_SBI_SSE is disabled, since its only caller is
pmu_sbi_cleanup_sse() inside #ifdef CONFIG_RISCV_PMU_SBI_SSE?

[ ... ]

> @@ -1054,32 +1098,111 @@ static inline void pmu_sbi_start_ovf_ctrs_snapsh=
ot(struct cpu_hw_events *cpu_hw_

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
> +	for (idx =3D 0; idx < RISCV_MAX_COUNTERS; idx++) {\n> +		event =3D cpu_=
hw_evt->events[idx];
> +		if (event)
> +			riscv_pmu_stop(event, PERF_EF_UPDATE);
> +	}
> +}

[Severity: Medium]
Should pmu_sbi_fail_sse() also call perf_event_update_userpage(event) after
riscv_pmu_stop()?

riscv_pmu_stop() calls pmu_sbi_ctr_stop() -> pmu_sbi_reset_scounteren(),
which clears the counter's bit in CSR_SCOUNTEREN and sets PERF_HES_STOPPED,
but does not update the perf mmap page.  If userpg->index remains non-zero
(for example when sse_event_enable_local() fails in pmu_sbi_sse_enable() or
after riscv_pm_pmu_update() on CPU_PM_EXIT), userspace direct counter reads
will execute csrr on the disabled CSR and trap with SIGILL.

> +
> +static void pmu_sbi_sse_disable(struct pmu *pmu)
> +{
> +	struct riscv_pmu *rvpmu =3D to_riscv_pmu(pmu);
> +	struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(rvpmu->hw_events);
> +	int ret;
> +
> +	if (!READ_ONCE(rvpmu->sse_active) ||
> +	    READ_ONCE(cpu_hw_evt->sse_failed))
> +		return;
> +
> +	ret =3D sse_event_disable_local(rvpmu->sse_evt);
> +	if (unlikely(ret))
> +		pmu_sbi_fail_sse(rvpmu, "disable", ret);
> +}
> +
> +static void pmu_sbi_sse_enable(struct pmu *pmu)
> +{
> +	struct riscv_pmu *rvpmu =3D to_riscv_pmu(pmu);
> +	struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(rvpmu->hw_events);
> +	int ret;
> +
> +	if (!READ_ONCE(rvpmu->sse_active) ||
> +	    READ_ONCE(cpu_hw_evt->sse_failed))
> +		return;
> +
> +	ret =3D sse_event_enable_local(rvpmu->sse_evt);
> +	if (unlikely(ret))
> +		pmu_sbi_fail_sse(rvpmu, "enable", ret);
> +}
> +#endif

[Severity: Medium]
Can pmu_sbi_sse_enable() permanently latch cpu_hw_evt->sse_failed during
CPU hotplug or system reboot?

CPUHP_AP_RISCV_SSE_ONLINE runs in the threaded ONLINE section after
CPUHP_AP_ONLINE_IDLE, CPUHP_AP_SCHED_WAIT_EMPTY, and
CPUHP_AP_SMPBOOT_THREADS.  If a task carrying a hardware perf event
context-switches on a CPU after sse_cpu_teardown() on cpu_down or before
sse_cpu_online() on cpu_up, perf_pmu_enable() -> pmu_sbi_sse_enable() calls
sse_event_enable_local() while reg_evt->is_registered is false, which
returns -EINVAL and permanently disables PMU counters on that CPU via
pmu_sbi_fail_sse().  Similarly, during reboot sse_reboot_nb (priority 0)
sets sse_shutting_down before perf_reboot_notifier (priority INT_MIN) stops
events, causing sse_event_enable_local() to return -ESHUTDOWN and hit
pmu_sbi_fail_sse().

[ ... ]

> @@ -1165,6 +1306,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, vo=
id *dev)
>  		hw_evt->state |=3D PERF_HES_UPTODATE;
>  		perf_sample_data_init(&data, 0, hw_evt->last_period);
>  		if (riscv_pmu_event_set_period(event)) {
> +			int overflow_ret;
> +
> +			/* Guest attribution and guest stack sampling are not supported yet. =
*/
> +			if (from_guest) {
> +				hw_evt->state =3D 0;
> +				continue;
> +			}
> +
>  			/*
>  			 * Unlike other ISAs, RISC-V don't have to disable interrupts
>  			 * to avoid throttling here. As per the specification, the
> @@ -1173,128 +1322,291 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq,=
 void *dev)
>  			 * TODO: We will need to stop the guest counters once
>  			 * virtualization support is added.
>  			 */
> -			perf_event_overflow(event, &data, regs);
> +			overflow_ret =3D perf_event_overflow(event, &data, regs);
> +			if (!overflow_ret)
> +				hw_evt->state =3D 0;
> +		} else {
> +			hw_evt->state =3D 0;
>  		}
> -		/* Reset the state as we are going to start the counter after the loop=
 */
> -		hw_evt->state =3D 0;
>  	}
> =20
>  	pmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);

[Severity: High]
When perf_event_overflow() returns non-zero and leaves a throttled counter
stopped with PERF_HES_STOPPED while its bit remains set in
cpu_hw_evt->used_hw_ctrs, how does a subsequent overflow on another counter
handle that stopped counter?

First, pmu_sbi_stop_hw_ctrs() passes the unfiltered cpu_hw_evt->used_hw_ctr=
s[i]
to a batch SBI_EXT_PMU_COUNTER_STOP call.  Because the throttled counter is
already stopped in firmware, the batch call can abort early with
SBI_ERR_ALREADY_STOPPED without stopping higher-indexed overflowing
counters, or return ret.error =3D=3D SBI_ERR_ALREADY_STOPPED and cause
pmu_sbi_stop_hw_ctrs() to skip saving sdata->ctr_values[] and overwrite the
shared snapshot buffer with zeroes from snapshot_cval_shcopy[].

Second, because the throttled counter was never restarted, its hardware OF
bit in CSR_SCOUNTOVF remains set while riscv_pmu_event_set_period() already
reloaded hw_evt->period_left > 0.  On the next overflow of another counter,
the loop in pmu_sbi_ovf_handler() does not skip events with
PERF_HES_STOPPED set; it revisits the throttled counter, sees
riscv_pmu_event_set_period(event) return 0, and sets hw_evt->state =3D 0 in
the else branch (or the from_guest branch), causing
pmu_sbi_start_overflow_mask() to restart the throttled counter.

[Severity: Medium]
Can clearing hw_evt->state =3D 0 inside the pmu_sbi_ovf_handler() loop befo=
re
pmu_sbi_start_overflow_mask() reprograms the counters corrupt group
throttling or frequency-mode throttling?

If two events in the same group overflow together and the first does not
throttle (setting its hw_evt->state =3D 0) while the second throttles the
group, perf_event_throttle_group() calls riscv_pmu_stop() on the first
event before its hardware counter is reprogrammed, running
riscv_pmu_event_update() a second time against the new hw_evt->prev_count.
Also, for attr.freq events, __perf_event_account_interrupt() calls
perf_adjust_period() after perf_event_throttle_group(); when period_left >
8 * sample_period, perf_adjust_period() calls event->pmu->start()
(riscv_pmu_start()), clearing hwc->state =3D 0 and starting the counter even
though perf_event_overflow() returns 1.

> =20
>  	perf_sample_event_took(sched_clock() - start_clock);
> =20
>  	return IRQ_HANDLED;
>  }
> =20
> -static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *nod=
e)
> +static irqreturn_t pmu_sbi_ovf_irq_handler(int irq, void *dev)
>  {
> -	struct riscv_pmu *pmu =3D hlist_entry_safe(node, struct riscv_pmu, node=
);
> -	struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events);
> -
> -	/*
> -	 * We keep enabling userspace access to CYCLE, TIME and INSTRET via the
> -	 * legacy option but that will be removed in the future.
> -	 */
> -	if (sysctl_perf_user_access =3D=3D SYSCTL_LEGACY)
> -		csr_write(CSR_SCOUNTEREN, 0x7);
> -	else
> -		csr_write(CSR_SCOUNTEREN, 0x2);
> +	return pmu_sbi_ovf_handler(dev, get_irq_regs(), false, false);
> +}
> =20
> -	/* Stop all the counters so that they can be enabled from perf */
> -	pmu_sbi_stop_all(pmu);
> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
> +static int pmu_sbi_ovf_sse_handler(u32 evt, void *arg, struct pt_regs *r=
egs)
> +{
> +	const struct riscv_sse_interrupted_context *context;
> +	struct riscv_pmu *pmu =3D arg;
> +	struct cpu_hw_events *hw_event =3D raw_cpu_ptr(pmu->hw_events);
> +	bool from_guest;
> +
> +	if (unlikely(!READ_ONCE(pmu->sse_active))) {
> +		pmu_sbi_sse_stop_all(pmu->cmask);
> +		return -EIO;
> +	}
> =20
> -	if (riscv_pmu_use_irq) {
> -		cpu_hw_evt->irq =3D riscv_pmu_irq;
> -		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
> -		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
> +	if (unlikely(!regs)) {
> +		pmu_sbi_fail_sse(pmu, "read interrupted context for", -EIO);
> +		return -EIO;
>  	}

[Severity: High]
Does the !regs path in pmu_sbi_ovf_sse_handler() leave the overflowing
counter running when no perf event is mapped or when cpu_hw_evt->sse_failed
is already true?

Unlike pmu_sbi_ovf_handler(), which stops all counters via
pmu_sbi_sse_stop_all(cmask) when no event is installed and calls
pmu_sbi_stop_hw_ctrs(pmu) before checking pmu_sbi_sse_failed(),
pmu_sbi_fail_sse() only stops non-NULL entries in cpu_hw_evt->events[] and
returns immediately if cpu_hw_evt->sse_failed was already latched (for
example after a failed sse_event_disable_local()).  If an early or unmapped
counter overflows after pmu_sbi_setup_sse() enables the event during probe,
or an overflow arrives after sse_failed is set, returning with the counter
still overflowing will cause firmware to immediately re-deliver the NMI-like
SSE event on SBI_SSE_EVENT_COMPLETE.

[ ... ]

> +static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
> +{
> +	int ret;
> +	struct sse_event *evt;
> =20
> -	/* Disable all counters access for user mode now */
> -	csr_write(CSR_SCOUNTEREN, 0x0);
> +	evt =3D sse_event_register(SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW, 0,
> +				 pmu_sbi_ovf_sse_handler, pmu);
> +	if (IS_ERR(evt))
> +		return PTR_ERR(evt);
> +	pmu->sse_evt =3D evt;
> =20
> -	if (sbi_pmu_snapshot_available())
> -		return pmu_sbi_snapshot_disable();
> +	ret =3D sse_event_enable(evt);
> +	if (ret) {
> +		int cleanup_ret;
> =20
> -	return 0;
> +		cleanup_ret =3D sse_event_disable(evt);
> +		if (cleanup_ret) {
> +			pr_warn("failed to disable SSE event after setup error: %d\n",
> +				cleanup_ret);
> +			return cleanup_ret;
> +		}
> +
> +		cleanup_ret =3D sse_event_unregister(evt);
> +
> +		if (cleanup_ret) {
> +			pr_warn("failed to unregister SSE event: %d\n",
> +				cleanup_ret);
> +		} else {
> +			pmu->sse_evt =3D NULL;
> +		}
> +		return cleanup_ret ?: ret;
> +	}

[Severity: Medium]
If sse_event_enable() fails in pmu_sbi_setup_sse() and the rollback in
sse_event_disable() or sse_event_unregister() also fails, what transfers the
retained pmu->sse_evt to sse_event_cleanup()?

When pmu_sbi_setup_irqs() returns -EUCLEAN, pmu_sbi_device_probe() treats
the error as non-fatal and continues registering the PMU in counting-only
mode without calling riscv_pmu_destroy() -> pmu_sbi_cleanup_sse().  Because
sse_event_cleanup() is never called on pmu->sse_evt, evt->cleanup_pending
remains false, so the SSE core continues treating the event as active across
CPU hotplug and any counter wrap while pmu->sse_active is false will invoke
pmu_sbi_ovf_sse_handler() -> pmu_sbi_sse_stop_all(pmu->cmask), resetting
active counting counters.

> +
> +	WRITE_ONCE(pmu->sse_active, true);
> +	pr_info("using SSE for PMU event delivery\n");
> +
> +	return ret;
>  }
> =20
> -static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_dev=
ice *pdev)
> +static void pmu_sbi_cleanup_sse(struct riscv_pmu *pmu)
>  {
> +	struct sse_event *sse_evt;
>  	int ret;
> -	struct cpu_hw_events __percpu *hw_events =3D pmu->hw_events;
> -	struct irq_domain *domain =3D NULL;
> =20
> +	sse_evt =3D pmu->sse_evt;
> +	if (!sse_evt)
> +		return;
> +	/*
> +	 * Close callback admission before draining each CPU. PMU callbacks run
> +	 * with local interrupts disabled, so the synchronous IPI cannot comple=
te
> +	 * until a callback that observed the old state has returned.
> +	 */
> +	WRITE_ONCE(pmu->sse_active, false);
> +	on_each_cpu(pmu_sbi_stop_all_cpu, pmu, 1);

[Severity: Medium]
Should pmu_sbi_stop_all_cpu() call pmu_sbi_sse_stop_all(pmu->cmask) instead
of the batch pmu_sbi_stop_all(pmu)?

pmu_sbi_stop_all() issues a batch SBI_EXT_PMU_COUNTER_STOP across
pmu->cmask, which can stop at an already-stopped lower-indexed counter and
return SBI_ERR_ALREADY_STOPPED before stopping higher-indexed active
counters.  If sse_event_disable() or sse_event_unregister() then fails and
branches to retain, sse_event_cleanup() replaces the handler with the no-op
sse_cleanup_event_handler(), leaving no handler to stop the counter source.

[ ... ]

> @@ -1289,14 +1601,17 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *p=
mu, struct platform_device *pde
>  }
> =20
>  #ifdef CONFIG_CPU_PM
> -static int riscv_pm_pmu_notify(struct notifier_block *b, unsigned long c=
md,
> -				void *v)
> +static int riscv_pm_pmu_update(struct riscv_pmu *rvpmu, unsigned long cm=
d)
>  {
> -	struct riscv_pmu *rvpmu =3D container_of(b, struct riscv_pmu, riscv_pm_=
nb);
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_events);
>  	bool enabled =3D !bitmap_empty(cpuc->used_hw_ctrs, RISCV_MAX_COUNTERS);
>  	struct perf_event *event;
>  	int idx;
> =20
> +	if (cmd =3D=3D CPU_PM_ENTER)
> +		bitmap_zero(cpuc->pm_resume_hw_ctrs, RISCV_MAX_COUNTERS);
> +
>  	if (!enabled)
>  		return NOTIFY_OK;
> =20
> @@ -1305,6 +1617,8 @@ static int riscv_pm_pmu_notify(struct notifier_bloc=
k *b, unsigned long cmd,
> =20
>  		switch (cmd) {
>  		case CPU_PM_ENTER:
> +			if (!(event->hw.state & PERF_HES_STOPPED))
> +				set_bit(idx, cpuc->pm_resume_hw_ctrs);
>  			/*
>  			 * Stop and update the counter
>  			 */
> @@ -1312,6 +1626,8 @@ static int riscv_pm_pmu_notify(struct notifier_bloc=
k *b, unsigned long cmd,
>  			break;
>  		case CPU_PM_EXIT:
>  		case CPU_PM_ENTER_FAILED:
> +			if (!test_and_clear_bit(idx, cpuc->pm_resume_hw_ctrs))
> +				break;
>  			/*
>  			 * Restore and enable the counter.
>  			 */
> @@ -1325,9 +1641,59 @@ static int riscv_pm_pmu_notify(struct notifier_blo=
ck *b, unsigned long cmd,
>  	return NOTIFY_OK;
>  }
> =20
> +static int riscv_pm_pmu_notify(struct notifier_block *b,
> +			       unsigned long cmd, void *v)
> +{
> +	struct riscv_pmu *rvpmu =3D container_of(b, struct riscv_pmu,
> +						 riscv_pm_nb);
> +
> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
> +	struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_events);
> +	int ret;
> +
> +	if (!riscv_pmu_use_irq && READ_ONCE(rvpmu->sse_active)) {
> +		switch (cmd) {
> +		case CPU_PM_ENTER:
> +			cpuc->pm_resume_sse =3D
> +				sse_event_is_enabled_local(rvpmu->sse_evt);
> +			if (cpuc->pm_resume_sse) {
> +				ret =3D sse_event_disable_local(rvpmu->sse_evt);
> +				if (ret) {
> +					cpuc->pm_resume_sse =3D false;
> +					pmu_sbi_fail_sse(rvpmu, "disable for CPU PM",
> +							 ret);
> +					return notifier_from_errno(ret);
> +				}
> +			}
> +			break;
> +		case CPU_PM_EXIT:
> +		case CPU_PM_ENTER_FAILED:
> +			ret =3D riscv_pm_pmu_update(rvpmu, cmd);
> +			if (!cpuc->pm_resume_sse)
> +				return ret;
> +
> +			cpuc->pm_resume_sse =3D false;
> +			ret =3D sse_event_enable_local(rvpmu->sse_evt);
> +			if (ret) {
> +				pmu_sbi_fail_sse(rvpmu, "enable after CPU PM", ret);
> +				return notifier_from_errno(ret);
> +			}
> +			return NOTIFY_OK;
> +		default:
> +			break;
> +		}
> +	}
> +#endif

[Severity: Medium]
Should riscv_pm_pmu_notify() check READ_ONCE(cpuc->sse_failed) before
performing local SSE transitions?

If pmu_sbi_fail_sse() is triggered while the local SSE event is enabled (for
example when regs is NULL in pmu_sbi_ovf_sse_handler() or when
sse_event_disable_local() fails in pmu_sbi_sse_disable()), reg_evt->is_enab=
led
remains true.  On the next CPU_PM_ENTER, riscv_pm_pmu_notify() sees
sse_event_is_enabled_local() =3D=3D true and tries to disable the event: if=
 that
succeeds, CPU_PM_EXIT re-enables the failed SSE event in firmware; if it
keeps failing, every CPU_PM_ENTER returns notifier_from_errno(ret) and
aborts CPU idle entry.

[Severity: Medium]
What happens on the next CPU_PM_ENTER if sse_events_unmask() fails during
CPU_PM_EXIT?

When sse_events_unmask() fails on CPU_PM_EXIT, sse_pm_notifier() returns
notifier_from_errno(ret) and stops the notifier chain before the
lower-priority riscv_pm_pmu_notify() runs, leaving rvpmu->sse_evt disabled
and the counters stopped with PERF_HES_STOPPED (without setting
cpuc->sse_failed).  On the next CPU_PM_ENTER, riscv_pm_pmu_notify()
overwrites cpuc->pm_resume_sse with false and riscv_pm_pmu_update() zeroes
cpuc->pm_resume_hw_ctrs while skipping the stopped counters, so subsequent
CPU_PM_EXIT calls never restore the counters or re-enable the SSE event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119120824.1396=
9-13-zhangzhanpeng.jasper@bytedance.com?part=3D8
