Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276345;
	b=xpNZfpbkJc34gpEHTRqKmIWenE6xVAcRNE3rs0WikVqDINoUyVauqP0v0tMuDKbTrwPT
	 v2Ne5qOYAdgTxVG5wgjCa74R5JkbeizSC/z0GYfl0B3qoTeIV7tEYsQaZpQEkGixWrYQE
	 l/2mGF7TOozAB2Vc8wDDArbvb9PPGOfdQimJiJ7RcbK5Pb8sAUaz7eKqop4kRdwjm0X3E
	 pewiqkg8ZPHuCUaztNYu5MYud3ElVB6hbc/xV5yUYkGU17e7dAimD2UQhGWucvn5notxi
	 fPC54ohSQGGXUg0VS3m/R1HMx5Tf8Pn0HOC8FzmZ+YTxQyHDIN0gZP+dU6swxhBDeYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276345;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y3yHLi/IAZgzUSGJc6QjrYr4KfA7DPljq6fwuLPuXIk=;
	b=cm2sU9/0y9GRlUnF2JeVRZXHynTq87xoUI0FGFOZggy25h5xyWKcmsXk/Evh1g0R0sYo
	 sxj7m5LVYIpJf1t9UPXaE4GGVMZaG5AXLJvv8FarGo66M+uGcJD2Zo33pwJdMbIi78HOV
	 ugU5Jl+ol2RlqoSsGL+/svNnH1gaTF9PrdGf4c8MllvB0/MFbEdvPCVfiyDCs36dOYs7g
	 g3P7yQ+BxcVFe0D7hLTBoskansH4G/eaunpj8070WYYaj/IuxICByHCPMoobR+EokkM/g
	 cTnr8tr6m6Yjq1vCN5r+DFz4CLuYRy1/tCc1NlHaxxePgCD26AfEzv9jYYY+FWRKtiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FQ+/islA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17162606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQ+/islA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA1B1F01825;
	Thu, 29 Oct 2026 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793276344;
	bh=y3yHLi/IAZgzUSGJc6QjrYr4KfA7DPljq6fwuLPuXIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FQ+/islAtNEzOZnxfUQDEKCENbo19d/8xRmZWyHRP4LcWj1zT7OhPzL8jiPL1PmEQ
	 DZhLjV0WFeUzDvFXnQOjwPKSiz8yXhagLWyaN8AZAJk4gFv3leDppQhPLnqvQ4eRXD
	 aDO8zd2Jo3dc/IOnM73DW6WvDAcyINANOdq+0DbI4iAaATmNkUA1Igv5wBJ+n5bMRt
	 aVrYcjAx722dfaZWbgMBNIx8IEsbmSmO5gkwoxcWnygguVTsITJKnr9N5qCadiHppf
	 QFLZU79gYECvYOA/ia6xcu9akZ1eMjZniptqh5D/MUyco3vv8WRboy5NEaDbTNQrk+
	 pIN3r2+WlWQyA==
Message-ID: <sashiko-outbox-189273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 08/11] perf: RISC-V: add support for SSE event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029074853.35467-9-zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
 <20261029074853.35467-9-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 12:19:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] perf: RISC-V: unhandled PERF_HES_STOPPED counters in pmu_sbi_ovf_h=
andler()
- [High] perf: RISC-V: unstopped PMU counters in pmu_sbi_ovf_sse_handler() =
when regs is NULL
- [Medium] perf: riscv: missing sse_event_cleanup() when pmu_sbi_setup_sse(=
) fails
- [Medium] perf: RISC-V: batch counter stop in pmu_sbi_cleanup_sse()
- [Medium] perf: RISC-V: pmu_sbi_fail_sse() clears SCOUNTEREN without updat=
ing userpage
- [Medium] perf: RISC-V: pmu_sbi_sse_enable() latches sse_failed on hotplug=
 and reboot
- [Medium] perf: RISC-V: riscv_pm_pmu_notify() ignores latched cpuc->sse_fa=
iled state
- [Medium] perf: riscv: lost PMU SSE resume state after CPU_PM_EXIT unmask =
failure
--

commit 97de0c9d3e465757bf9e40945610083784df9d4b
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

perf: RISC-V: add support for SSE event

This commit adds support for delivering RISC-V SBI PMU counter overflow
events via Supervisor Software Events (SSE), including probe-time delivery
selection, overflow handling, error latching, and CPU power management
integration.

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
> +	for (idx =3D 0; idx < RISCV_MAX_COUNTERS; idx++) {
> +		event =3D cpu_hw_evt->events[idx];
> +		if (event)
> +			riscv_pmu_stop(event, PERF_EF_UPDATE);
> +	}
> +}

[Severity: Medium]
When pmu_sbi_fail_sse() stops mapped events via riscv_pmu_stop(), can a
userspace task with a direct-mapped counter page subsequently fault with
SIGILL?

When an event is started in riscv_pmu_start() (for example during
event_sched_in() or riscv_pm_pmu_update() on CPU_PM_EXIT), pmu_sbi_ctr_star=
t()
sets the counter bit in CSR_SCOUNTEREN and perf_event_update_userpage() sets
a non-zero userpg->index.

If a subsequent SSE call fails and invokes pmu_sbi_fail_sse(), it calls
riscv_pmu_stop() -> pmu_sbi_ctr_stop() -> pmu_sbi_reset_scounteren(), which
clears the counter bit in CSR_SCOUNTEREN and sets PERF_HES_STOPPED:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_ctr_stop() {
    ...
	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
		pmu_sbi_reset_scounteren((void *)event);
    ...
}

Because neither riscv_pmu_stop() nor pmu_sbi_fail_sse() calls
perf_event_update_userpage(event), userpg->index remains non-zero while
CSR_SCOUNTEREN has the counter bit cleared, and cpu_hw_evt->sse_failed
prevents riscv_pmu_start() from restarting the event. Should
pmu_sbi_fail_sse() call perf_event_update_userpage(event) after
riscv_pmu_stop() so that userpg->index is cleared and userpg->offset is
updated?

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

[Severity: Medium]
Can pmu_sbi_sse_enable() permanently latch cpu_hw_evt->sse_failed during CPU
hotplug or system reboot?

In drivers/firmware/riscv/riscv_sbi_sse.c, sse_event_enable_local() returns
-ESHUTDOWN once sse_reboot_notifier sets sse_shutting_down, and returns
-EINVAL when reg_evt->is_registered is false on the local CPU:

drivers/firmware/riscv/riscv_sbi_sse.c:sse_event_enable_local() {
    ...
	if (READ_ONCE(sse_shutting_down)) {
		ret =3D -ESHUTDOWN;
		goto out;
	}

	if (!reg_evt->is_registered) {
		ret =3D -EINVAL;
		goto out;
	}
    ...
}

During CPU hotplug, CPUHP_AP_RISCV_SSE_ONLINE is in the threaded online
section after CPUHP_AP_ONLINE_IDLE, CPUHP_AP_SCHED_WAIT_EMPTY, and
CPUHP_AP_SMPBOOT_THREADS. On cpu_down, sse_cpu_teardown() sets
reg_evt->is_registered =3D false before sched_cpu_wait_empty() and
smpboot_park_threads() finish running tasks on that CPU; on cpu_up,
cpuhp/%u and unparked smpboot threads run before sse_cpu_online() registers
the local SSE event. Any context switch of a task with a hardware perf event
in that window calls perf_event_context_sched_out() or
perf_event_context_sched_in() -> perf_pmu_enable() -> pmu_sbi_sse_enable()
-> sse_event_enable_local(), which returns -EINVAL and causes
pmu_sbi_fail_sse() to latch cpu_hw_evt->sse_failed =3D true (which is never
cleared on a subsequent cpu_up).

Similarly, on reboot or kexec, sse_reboot_nb (priority 0) runs before
perf_reboot_notifier (priority INT_MIN), so perf_event_exit_cpu() triggers
pmu_sbi_sse_enable() after sse_shutting_down is true, failing with
-ESHUTDOWN.

Should pmu_sbi_sse_enable() avoid latching sse_failed when the local SSE
event is not currently registered during hotplug or when SSE is shutting
down?

[ ... ]

> @@ -1153,6 +1288,12 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, vo=
id *dev)
>  		if (!(overflow & BIT_ULL(hidx)))
>  			continue;
> =20
> +#ifdef CONFIG_CPU_PM
> +		/* Do not let CPU-PM resume override this overflow decision. */
> +		if (from_sse)
> +			clear_bit(lidx, cpu_hw_evt->pm_resume_hw_ctrs);
> +#endif
> +
>  		/*
>  		 * Keep a track of overflowed counters so that they can be started
>  		 * with updated initial value.
>  		 */
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

[Severity: High]
When perf_event_overflow() returns non-zero and leaves an event with
PERF_HES_STOPPED set while its bit remains set in cpu_hw_evt->used_hw_ctrs,
what happens when a second active counter on the same CPU overflows?

First, pmu_sbi_ovf_handler() calls pmu_sbi_stop_hw_ctrs(), which passes the
unfiltered cpu_hw_evt->used_hw_ctrs[i] mask to a batch
SBI_EXT_PMU_COUNTER_STOP ecall:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_stop_hw_ctrs() {
    ...
	for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
		/* No need to check the error here as we can't do anything about the erro=
r */
		ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LON=
G,
				cpu_hw_evt->used_hw_ctrs[i], flag);
		if (!ret.error && sbi_pmu_snapshot_available()) {
			/* Save the counter values to avoid clobbering */
			for_each_set_bit(idx, &cpu_hw_evt->used_hw_ctrs[i], BITS_PER_LONG)
				cpu_hw_evt->snapshot_cval_shcopy[i * BITS_PER_LONG + idx] =3D
							sdata->ctr_values[idx];
    ...
}

Because the throttled counter is already stopped in firmware, the batch stop
can return SBI_ERR_ALREADY_STOPPED (or stop early before higher-indexed
counters). When sbi_pmu_snapshot_available() is true, ret.error !=3D 0 skips
copying sdata->ctr_values into snapshot_cval_shcopy after memset() zeroed
snapshot_cval_shcopy, and then overwrites sdata->ctr_values with 0 for all
used_hw_ctrs.

Second, in the overflow loop of pmu_sbi_ovf_handler(), events that already
have PERF_HES_STOPPED set are not skipped:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_ovf_handler() {
    ...
	for_each_set_bit(lidx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
		struct perf_event *event =3D cpu_hw_evt->events[lidx];

		/* Skip if invalid event or user did not request a sampling */
		if (!event || !is_sampling_event(event))
			continue;
    ...
}

Without CSR_SCOUNTOVF (MHPMEVENT_OF) having been cleared by a counter start,
overflow & BIT_ULL(hidx) remains set for the previously stopped counter. On
the subsequent overflow of another counter, pmu_sbi_ovf_handler() visits the
throttled event again: riscv_pmu_event_update() is a no-op because
PERF_HES_UPTODATE is still set, and riscv_pmu_event_set_period() returns 0
because period_left was already made positive on the initial overflow. That
takes the else branch (or the from_guest branch) and clears hw_evt->state =
=3D
0, causing pmu_sbi_start_overflow_mask() to prematurely restart the throttl=
ed
counter.

Should pmu_sbi_stop_hw_ctrs() and the loop in pmu_sbi_ovf_handler() skip
counters whose event already has PERF_HES_STOPPED set?

> =20
>  	pmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);
> +
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
Can the !regs path in pmu_sbi_ovf_sse_handler() return without stopping the
overflowing counter source, leading to an infinite SSE re-delivery loop when
firmware executes SBI_SSE_EVENT_COMPLETE?

When regs is NULL, pmu_sbi_ovf_sse_handler() bypasses pmu_sbi_ovf_handler()
and relies only on pmu_sbi_fail_sse(). However, there are two cases where
pmu_sbi_fail_sse() does not stop the counter source while
pmu_sbi_ovf_handler() would have:

1. An SSE overflow arrives after pmu_sbi_setup_sse() sets pmu->sse_active =
=3D
   true (before pmu_sbi_starting_cpu() stops counters or before perf instal=
ls
   an event in cpu_hw_evt->events[]). In pmu_sbi_ovf_handler(), empty
   used_hw_ctrs or a NULL event calls pmu_sbi_sse_stop_all(cmask), whereas
   pmu_sbi_fail_sse() only loops over non-NULL cpu_hw_evt->events[idx] and
   stops nothing.

2. In pmu_sbi_fail_sse(), cpu_hw_evt->sse_failed is set to true before
   pr_err_ratelimited() and before the loop that stops mapped events (for
   example, when sse_event_disable_local() fails in pmu_sbi_sse_disable()).=
 If
   an SSE overflow preempts that path with regs =3D=3D NULL, pmu_sbi_fail_s=
se()
   sees READ_ONCE(cpu_hw_evt->sse_failed) =3D=3D true and returns immediate=
ly
   without stopping the overflowing counter, whereas pmu_sbi_ovf_handler()
   calls pmu_sbi_stop_hw_ctrs(pmu) before checking pmu_sbi_sse_failed().

Should the !regs path (or pmu_sbi_fail_sse()) also ensure that unmapped or
still-running hardware counters are stopped before returning from the SSE
handler?

> =20
> -	if (sbi_pmu_snapshot_available())
> -		return pmu_sbi_snapshot_setup(pmu, cpu);
> +	context =3D riscv_sse_get_interrupted_context();
> +	from_guest =3D context && context->regs =3D=3D regs &&
> +		     (context->hstatus & HSTATUS_SPV);
> +	pmu_sbi_ovf_handler(hw_event, regs, true, from_guest);
> =20
>  	return 0;
>  }
> =20
> -static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
> +static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
>  {
> -	if (riscv_pmu_use_irq) {
> -		disable_percpu_irq(riscv_pmu_irq);
> -	}
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
If sse_event_enable(evt) fails in pmu_sbi_setup_sse() and then
sse_event_disable(evt) or sse_event_unregister(evt) also fails, should this
error path hand evt over to sse_event_cleanup(evt)?

When pmu->sse_evt is retained here, pmu_sbi_setup_irqs() sees
pmu_sbi_sse_state_retained(pmu) and returns -EUCLEAN, and
pmu_sbi_device_probe() continues in counting-only mode:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_device_probe() {
    ...
	ret =3D pmu_sbi_setup_irqs(pmu, pdev);
	if (ret < 0) {
		pr_info("Perf sampling/filtering is not supported as sscof extension is n=
ot available\n");
		pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_INTERRUPT;
		pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_EXCLUDE;
	}
    ...
}

Because probe succeeds without calling riscv_pmu_destroy() ->
pmu_sbi_cleanup_sse(), sse_event_cleanup(evt) is never called on the retain=
ed
event. With evt->cleanup_pending left false, the SSE core's hotplug and PM
callbacks (sse_cpu_online() and sse_restore_local_events()) treat evt as an
active registration and re-register it on CPUs instead of cleaning it up, a=
nd
if the event remained enabled on any CPU, a counting-event wrap will invoke
pmu_sbi_ovf_sse_handler() with pmu->sse_active =3D=3D false and reset active
counters via pmu_sbi_sse_stop_all(pmu->cmask).

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
Should pmu_sbi_cleanup_sse() stop counters on each CPU using
pmu_sbi_sse_stop_all(pmu->cmask) instead of pmu_sbi_stop_all_cpu()?

pmu_sbi_stop_all_cpu() calls pmu_sbi_stop_all() ->
pmu_sbi_stop_all_mask(pmu->cmask), which issues a batch
SBI_EXT_PMU_COUNTER_STOP per word. As noted in the commit message, a batch
stop can return SBI_ERR_ALREADY_STOPPED when encountering an already-stopped
counter before stopping higher-numbered counters in pmu->cmask. If
sse_event_disable() or sse_event_unregister() subsequently fails and jumps =
to
retain, sse_event_cleanup(sse_evt) replaces the PMU SSE handler with the
no-op cleanup handler while a higher-numbered counter could still be runnin=
g.

[ ... ]

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
Should riscv_pm_pmu_notify() check READ_ONCE(cpuc->sse_failed) before runni=
ng
the local SSE disable and enable transitions?

If cpuc->sse_failed was latched while the local SSE event remained enabled
(for instance when pmu_sbi_ovf_sse_handler() failed with !regs, or when
sse_event_disable_local() failed in pmu_sbi_sse_disable()), a later
CPU_PM_ENTER will see sse_event_is_enabled_local(rvpmu->sse_evt) =3D=3D tru=
e. If
sse_event_disable_local() then succeeds on CPU_PM_ENTER, cpuc->pm_resume_sse
is set to true and CPU_PM_EXIT will re-enable the local SSE event via
sse_event_enable_local(rvpmu->sse_evt) even though cpuc->sse_failed is latc=
hed
(or if sse_event_disable_local() keeps failing, every CPU_PM_ENTER will
return notifier_from_errno(ret) and abort idle entry).

[Severity: Medium]
Also in riscv_pm_pmu_notify() and riscv_pm_pmu_update(), what happens on the
next CPU_PM_ENTER if sse_events_unmask() failed during the preceding
CPU_PM_EXIT?

On CPU_PM_EXIT, sse_pm_notifier() (priority 0) runs before
riscv_pm_pmu_notify() (priority -1). If sse_events_unmask() fails,
sse_pm_notifier() returns notifier_from_errno(ret) with NOTIFY_STOP_MASK,
stopping the notifier chain before riscv_pm_pmu_notify() runs. At that poin=
t,
rvpmu->sse_evt is still disabled (is_enabled =3D=3D false) and the counters
stopped during the prior CPU_PM_ENTER still have PERF_HES_STOPPED set.

When the CPU enters idle again on the next CPU_PM_ENTER,
riscv_pm_pmu_notify() overwrites cpuc->pm_resume_sse with
sse_event_is_enabled_local(rvpmu->sse_evt) (which is now false), and
riscv_pm_pmu_update() zeroes cpuc->pm_resume_hw_ctrs and only records
counters without PERF_HES_STOPPED:

drivers/perf/riscv_pmu_sbi.c:riscv_pm_pmu_update() {
    ...
	if (cmd =3D=3D CPU_PM_ENTER)
		bitmap_zero(cpuc->pm_resume_hw_ctrs, RISCV_MAX_COUNTERS);
    ...
		case CPU_PM_ENTER:
			if (!(event->hw.state & PERF_HES_STOPPED))
				set_bit(idx, cpuc->pm_resume_hw_ctrs);
    ...
}

Won't that lose both cpuc->pm_resume_sse and cpuc->pm_resume_hw_ctrs, leavi=
ng
the counters stopped and the local PMU SSE event disabled on subsequent
CPU_PM_EXIT notifications?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029074853.3546=
7-1-zhangzhanpeng.jasper@bytedance.com?part=3D8
