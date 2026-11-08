Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145559;
	b=PtQ6kRPGtOzcgGVxv3TEH5K472a6CzNErWybxNBI7SG10tAqSFuiMPUY1DtJGzFKeTIP
	 /Arb/dW031JSuUjT/qRmU1O/MA5zx9QVr+i8CWphHrYX7rYx2Q7XMAI3y3QSPEHZ7y+5Z
	 zf+cbtenvTzREdHXe6EXzb2eCjfsdJnvv8GrwKSBTATv8aMWLUTYfU9XS/LmrmwePhk60
	 QEHsphgxg1pTHmwnfYMFxqJr7hGU6ewlxby6vIumkmFee/q+Q7xaRp8Z7TeacFwBU8OQj
	 u0dL9iP+lhesXDcD4kC0m9dldGIDeT641CAb3MsNMJGbG8EhDaPRSnqCr6rodKKTmKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145559;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3J9MEQNBQoLk3yIq1U3fXeBJMi6GOjqhSdWlc111+hM=;
	b=3P5tPYNxa/FUUwfzMyqITnBvooonl13GmW/TBtQCzwuUKYjLENODkDvf2L1v1SGlRnrI
	 7kDfJQOfd+HIpq5vuBjCU0rBQP4YR4KYQVui1wugWLhJT8P0SFROvsT76gQ8ipiTc8zS9
	 kWMGly9jU8JQbeumNzH8IXIZJXZwLSBflLFuRcnf5egTBy4nQSOFkD0Up0F90al/ZmSMb
	 iXw79pMAVxJ9fw9oPz3bWj3W6R4hAN0Xn1jOMhZC25/3pZRiWWVoWd6JFCtu0yFgIgV5o
	 vcsDJZ1PTFYY7wZQ5US4C03LRN0XE96uQYzac5f1Y03Qft7LEZE/YG/p41dH337jYAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e5Mq/W8C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379FD606A320;
	Sun,  8 Nov 2026 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5Mq/W8C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A953C1F0089F;
	Sun,  8 Nov 2026 13:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794145558;
	bh=3J9MEQNBQoLk3yIq1U3fXeBJMi6GOjqhSdWlc111+hM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5Mq/W8CtpLK0CVts/M0yLKeWvH7ZkE5rOGorUUSOjUkuBVPiu7eiv2Q9ZKYBM9Z9
	 7ZxZVSYYDo53hVJjr5bJ/s2/Du102xt99RaCjTabIMl08u7eQXcRUymnxqFrh//IIp
	 MDPYxTXdDlFMMYp0E1ISGLpdEYSX8Lsocq9VZ3EsrFOf/IA0DNYZk5nSIR+5VearcR
	 S1jk4JgXwZzLNQKubeZlbrwwLx+0U5q/A/woL24Tqclgh9TZ4oM9/IqTjn90MJ5Gfe
	 hWf41eoqJ0eiDpVEkVKii+Dn1Th4Y24AVItckPS+2WwP46OnQ7P+Ilhy6/8tl5rZOM
	 4RM8DnqG6Dsdw==
Message-ID: <sashiko-outbox-203782@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf: add MIPS Coherence Manager 3 (CM3) PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261108-i6500-cm3-pmu-v1-4-bd119584891a@mobileye.com>
References: <20261108-i6500-cm3-pmu-v1-0-bd119584891a@mobileye.com>
 <20261108-i6500-cm3-pmu-v1-4-bd119584891a@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:45:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] perf/mips_cm3: 2^32 counts lost on counter overflow in
  cm3_pmu_update()
- [Medium] perf/mips_cm3: 64-bit qualifier truncated in hwc->config_base
  on 32-bit
- [Medium] perf/mips_cm3: cm3_pmu_event_init() validates group before
  setting config
- [Medium] perf/mips_cm3: NULL ctx deref in cm3_pmu_validate_group()
  with lockdep
- [Medium] perf/mips_cm3: cpuhp_state_remove_instance() migrates
  unregistered PMU
- [Medium] perf/mips_cm3: cm3_pmu_hw_init() skips power check when
  initialized
- [Medium] perf/mips_cm3: invalid wait context acquiring cm_core_lock in
  cm3_pmu_lock()
--

commit 7d10c5a1b5055212bfd02b13d5581ab06e3a9b14
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

perf: add MIPS Coherence Manager 3 (CM3) PMU driver

This commit adds an uncore PMU driver and documentation for the performance
counters in the MIPS Coherence Manager 3 (CM3).

> diff --git a/drivers/perf/mips_cm3_pmu.c b/drivers/perf/mips_cm3_pmu.c
> new file mode 100644
> index 0000000000000..d4be23e79d6f0
> --- /dev/null
> +++ b/drivers/perf/mips_cm3_pmu.c

[ ... ]

> +static bool cm3_pmu_lock(struct cm3_pmu *cm3_pmu)
> +{
> +	preempt_disable();
> +	if (cm3_pmu->cluster =3D=3D cpu_cluster(&current_cpu_data))
> +		return false;
> +
> +	mips_cm_lock_other(cm3_pmu->cluster, 0, 0, CM_GCR_Cx_OTHER_BLOCK_DEBUG);
> +	return true;
> +}

[Severity: Medium]
Can calling mips_cm_lock_other() here trigger a lockdep wait-context
splat under CONFIG_PROVE_RAW_LOCK_NESTING?

mips_cm_lock_other() acquires the per-CPU cm_core_lock, which is a
non-raw spinlock_t:

arch/mips/kernel/mips-cm.c:mips_cm_lock_other() {
	...
	spin_lock_irqsave(this_cpu_ptr(&cm_core_lock),
			  *this_cpu_ptr(&cm_core_lock_flags));
	...
}

CM3_PMU_READ() and CM3_PMU_WRITE() call cm3_pmu_lock() from the PMU
callbacks (add, start, stop, del, read), which run while holding the
raw_spinlock_t perf_event_context::lock, as well as from the hardirq
hrtimer callback cm3_pmu_poll().  Acquiring a spinlock_t inside a
raw_spinlock_t or hardirq context is an invalid wait-context transition
when accessing a remote cluster's PMU.

[ ... ]

> +static int cm3_pmu_hw_init(struct cm3_pmu *cm3_pmu)
> +{
> +	guard(mutex)(&cm3_pmu->init_lock);
> +
> +	if (cm3_pmu->initialized)
> +		return 0;
> +
> +	if (!cm3_pmu_cluster_powered(cm3_pmu))
> +		return -ENODEV;
> +
> +	cm3_pmu->num_pcs =3D FIELD_GET(CM_GCR_DB_PC_CTL_PERF_NUM_CNT,
> +				     CM3_PMU_READ(cm3_pmu, pc_ctl));
> +	cm3_pmu->num_pcs =3D min_t(unsigned int, cm3_pmu->num_pcs,
> +				 CM3_PMU_MAX_PCS);
> +	cm3_pmu_hw_reset(cm3_pmu);
> +	cm3_pmu->initialized =3D true;
> +
> +	return 0;
> +}

[Severity: Medium]
Does returning early when cm3_pmu->initialized is true skip the power
check if a remote cluster is powered down after probe or an earlier
event?  As cm3_pmu_unregister() notes by checking both
cm3_pmu->initialized and cm3_pmu_cluster_powered(), a cluster that was
once initialized can later power down; opening a new event on it will
then pass cm3_pmu_hw_init() and fault when cm3_pmu_start() accesses its
GCRs.

[ ... ]

> +static void cm3_pmu_update(struct perf_event *event)
> +{
> +	struct cm3_pmu *cm3_pmu =3D to_cm3_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u64 prev, new;
> +
> +	do {
> +		prev =3D local64_read(&hwc->prev_count);
> +		new =3D cm3_pmu_read_counter(cm3_pmu, hwc->idx);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, new) !=3D prev);
> +
> +	local64_add((new - prev) & CM3_PMU_COUNTER_MASK, &event->count);
> +}
> +
> +static void cm3_pmu_start(struct perf_event *event, int flags)
> +{
> +	struct cm3_pmu *cm3_pmu =3D to_cm3_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int idx =3D hwc->idx;
> +
> +	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
> +		return;
> +
> +	hwc->state =3D 0;
> +
> +	if (idx !=3D CM3_PMU_IDX_CYCLES)
> +		cm3_pmu_program_counter(cm3_pmu, idx, hwc->config,
> +					hwc->config_base);
> +
> +	/*
> +	 * Setting the reset bit together with the count-on bit resets the
> +	 * counter and its overflow status before counting is started.
> +	 */
> +	local64_set(&hwc->prev_count, 0);
> +	cm3_pmu_set_ctl(cm3_pmu, 0,
> +			cm3_pmu_reset_bit(idx) | cm3_pmu_counton_bit(idx));
> +
> +	perf_event_update_userpage(event);
> +}

[Severity: High]
When operating in overflow-interrupt mode (cm3_pmu->irq > 0, where the
polling timer is not started), does cm3_pmu_update() lose 2^32 counts on
counter wraparound?

cm3_pmu_start() resets both hwc->prev_count and the 32-bit hardware
counter to 0.  When the counter reaches 0xffffffff, raises the overflow
interrupt, and wraps past 0 to a small value new before
cm3_pmu_handle_irq() calls cm3_pmu_update(), (new - prev) & 0xffffffff
evaluates to just new (or on subsequent overflows, whenever new >=3D prev),
discarding the full 2^32 wraparound.

[ ... ]

> +static void cm3_pmu_count_group_event(struct perf_event *event,
> +				      struct perf_event *member,
> +				      unsigned int *cycles, unsigned int *pcs)
> +{
> +	if (member->pmu !=3D event->pmu)
> +		return;
> +
> +	if (member->hw.config =3D=3D CM3_PMU_EV_CYCLES)
> +		(*cycles)++;
> +	else
> +		(*pcs)++;
> +}
> +
> +static bool cm3_pmu_validate_group(struct perf_event *event)
> +{
> +	struct cm3_pmu *cm3_pmu =3D to_cm3_pmu(event->pmu);
> +	struct perf_event *leader =3D event->group_leader;
> +	struct perf_event *sibling;
> +	unsigned int cycles =3D 0, pcs =3D 0;
> +
> +	/* Hardware events of the group must all be ours */
> +	if (leader->pmu !=3D event->pmu && !is_software_event(leader))
> +		return false;
> +
> +	cm3_pmu_count_group_event(event, event, &cycles, &pcs);
> +	if (leader !=3D event)
> +		cm3_pmu_count_group_event(event, leader, &cycles, &pcs);
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (sibling->pmu !=3D event->pmu && !is_software_event(sibling))
> +			return false;
> +
> +		cm3_pmu_count_group_event(event, sibling, &cycles, &pcs);
> +	}
> +
> +	return cycles <=3D 1 && pcs <=3D cm3_pmu->num_pcs;
> +}

[Severity: Medium]
Can for_each_sibling_event(sibling, leader) cause a NULL pointer
dereference when leader =3D=3D event and CONFIG_PROVE_LOCKING is enabled?

When initializing a standalone event or group leader in
perf_try_init_event(), leader->ctx is still NULL, and
for_each_sibling_event() expands lockdep_assert_event_ctx(leader), which
dereferences leader->ctx->mutex.  Returning true before the loop when
leader =3D=3D event avoids this.

> +
> +static int cm3_pmu_event_init(struct perf_event *event)
> +{

[ ... ]

> +	if (!cm3_pmu_validate_group(event))
> +		return -EINVAL;
> +
> +	hwc->idx =3D -1;
> +	hwc->config =3D config;

[Severity: Medium]
Is cm3_pmu_validate_group(event) called before hwc->config is set?

Because event->hw.config is still 0 during cm3_pmu_validate_group(),
cm3_pmu_count_group_event(event, event, &cycles, &pcs) always counts the
new event in pcs instead of cycles.  Adding a CM3_PMU_EV_CYCLES event to
a group that already has two programmable events fails with -EINVAL,
while a group with two CM3_PMU_EV_CYCLES events passes validation.

> +	hwc->config_base =3D event->attr.config1 ?: cm3_pmu_default_qual(config=
);
> +	event->cpu =3D cm3_pmu->on_cpu;
> +
> +	return 0;
> +}

[Severity: Medium]
Does storing the 64-bit qualifier in hwc->config_base truncate bits 63:32
on 32-bit kernels?

hwc->config_base is an unsigned long, whereas CM3 qualifiers are 64-bit
values (and events such as CM3_PMU_EV_CM_REQ, CM3_PMU_EV_IO_REQ, and
CM3_PMU_EV_MEM_REQ require bits in 63:32 to be set in order to match any
requests).  Storing the qualifier in hwc->config1 (which is u64 in
struct hw_perf_event) preserves all 64 bits on CONFIG_32BIT.

[ ... ]

> +static void cm3_pmu_unregister(struct cm3_pmu *cm3_pmu)
> +{
> +	perf_pmu_unregister(&cm3_pmu->pmu);
> +	cpuhp_state_remove_instance(cm3_pmu_cpuhp_state, &cm3_pmu->node);
> +	hrtimer_cancel(&cm3_pmu->hrtimer);
> +	if (cm3_pmu->initialized && cm3_pmu_cluster_powered(cm3_pmu)) {
> +		cm3_pmu->irq =3D 0;
> +		cm3_pmu_hw_reset(cm3_pmu);
> +	}
> +}
> +
> +static int cm3_pmu_register(struct device *dev, struct cm3_pmu *cm3_pmu)
> +{

[ ... ]

> +	ret =3D perf_pmu_register(&cm3_pmu->pmu, name, -1);
> +	if (ret) {
> +		cpuhp_state_remove_instance(cm3_pmu_cpuhp_state, &cm3_pmu->node);
> +		return dev_err_probe(dev, ret, "failed to register %s\n", name);
> +	}

[Severity: Medium]
Should cm3_pmu_unregister() and the error path in cm3_pmu_register() use
cpuhp_state_remove_instance_nocalls() instead of
cpuhp_state_remove_instance()?

cpuhp_state_remove_instance() invokes cm3_pmu_offline_cpu() for each
online CPU while all CPUs remain in cpu_online_mask.  When more than one
CPU is online, cpumask_any_but(cpu_online_mask, cpu) finds a target CPU
and calls perf_pmu_migrate_context() on a PMU that has already been
unregistered (or failed perf_pmu_register()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-i6500-cm3-=
pmu-v1-0-bd119584891a@mobileye.com?part=3D4
