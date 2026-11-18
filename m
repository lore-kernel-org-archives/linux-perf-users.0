Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997265;
	b=KnnTGCcj1/HO4dnVys/aJrAGrNwXsUTaEjKzEc8AfqPJuP8E/l6v/QDHTosKzap2H9on
	 Bew3rDfHsPru3fZ/fZWIBQEdFelaBBd4zVdN73sdff0MNkpieH5wYxthzPbzZIqgc5qud
	 3I3Wn5E6f7Sfel/vK/XUadMfm9196OVuHhZ4JwyiSNnm1doLXUz7uK2dprZVZXG3OIfSJ
	 vDT/+aKj7O2tpieVzpG3PN5cQl66kNiWRgnMoBRA61lZB+npc8TfaxC7GBf6Dqw458FXG
	 +a8J9FgGZBcCBiWatPbYZpWsLPaWjo9b19fPv5IIWdDO1hLi2q+TO1n5Iyjx5dIvqtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997265;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0M6aVKYAC6Jxq7rRd52mMLorBjhnnY2bShYRqWVVp28=;
	b=bok9TsBBhbQHzY6xON7n/C4bujvrBpyfPJvgjfPUCGsc+aoqAoe35lH5lEJ4aGsmhiI/
	 1Hfadeyq73rDc6NnyQ7MNwvinDy8bfAuzj6RYvTQLAfUKAx5oohxow1KCR67alhP5OoCU
	 7c/mzXlMRcHNMf86B2p1fdWH4jlT2DhILE3X5Nr6wEao1mcaJLI0VAjI3gmAY5NzHuIHz
	 L+TI3glPxfzP4S2BrUWy8KUgQ0XwCpXoLhrzYfd+YU2VkXKYu/mHO9DUH6txQIURgMm3K
	 aADccYx3V3u7+tA3Zonn79/emNdfR801a9sqveQbAZx9bbyjrNlpxuub2+doV6Urxag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXCnX32h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E690606A320;
	Wed, 18 Nov 2026 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXCnX32h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1711F000C4;
	Wed, 18 Nov 2026 10:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794997264;
	bh=0M6aVKYAC6Jxq7rRd52mMLorBjhnnY2bShYRqWVVp28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CXCnX32hQGaMlYGlzYjU/lMISTBlfiuU9C5N/rp1PoqoaDMKA5ua9SON7nfQNQA/N
	 4t9B23cG4l5N9C+OUB6hYmF7HgBzuL7WhXMIdhqv0RTPvRykKubyMvcFz6N+ph5txt
	 W7jcFNPA2Q8/vnOxj8sjF/1L8cRIkrA/dNWRZZHDPUjJoeIRgqdEoptLJvFjplY9QS
	 21DP9Q2511sNIa3m4s+gJh7JCRFabO/6uEGgS7XfLvUD8Ln3do+FYnWhTMYBUxbnJM
	 a7BIyXhaa+5Tm1RIV3TjJvuvt4U5xxL22DZaW4tgpssEUVFgsP1uSb/RVOgoYQL+ld
	 mPJITBsOYBQ7w==
Message-ID: <sashiko-outbox-220678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/7] riscv: pmu: Integrate CTR Ext support in
 riscv_pmu_dev driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikram Singh" <vikram.singh3@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118095053.3871267-7-vikram.singh3@oss.qualcomm.com>
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
 <20261118095053.3871267-7-vikram.singh3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:21:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [Critical] riscv: pmu: perf_ctx_data type confusion and OOB write in
  CTR callbacks
- [High] riscv: pmu: duplicate cpuhp_state_add_instance() in
  pmu_sbi_device_probe()
- [High] riscv: pmu: NULL ctx->task deref in riscv_pmu_ctr_add() on CPU
  events
- [Medium] riscv: pmu: IRQ cleanup bypassed on error in
  pmu_sbi_device_probe()
- [Medium] riscv: pmu: per-CPU branch_records leak in
  pmu_sbi_device_probe()
- [Medium] riscv: pmu: broken CTR state across concurrent events in SBI
  PMU
- [Medium] riscv: pmu: premature -EOPNOTSUPP in pmu_sbi_event_map()
  before type check
- [Medium] riscv: pmu: section mismatch calling __init
  check_available_filters()
- [Medium] riscv: pmu: missing inline on riscv_pmu_ctr_add() and del()
  stubs
--

commit e244663b591d7b5c6a7f72d19726b56679ea8ed0
Author: Vikram Singh <vikram.singh3@oss.qualcomm.com>

riscv: pmu: Integrate CTR Ext support in riscv_pmu_dev driver

This commit integrates Control Transfer Records (CTR) extension support
into the RISC-V SBI PMU driver to enable branch stack sampling on PMU
events.

Link: https://lore.kernel.org/r/20261106173942.3175069-7-vikram.singh3@oss.=
qualcomm.com

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index b14b3acf75674..637b9d97e20a4 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -678,6 +678,9 @@ static int pmu_sbi_event_map(struct perf_event *event=
, u64 *econfig)
>  	 */
>  	flush_work(&check_std_events_work);
> =20
> +	if (needs_branch_stack(event) && !riscv_pmu_ctr_valid(event))
> +		return -EOPNOTSUPP;
> +
>  	return riscv_pmu_get_event_info(type, config, econfig);
>  }

[Severity: Medium]
Does returning -EOPNOTSUPP before riscv_pmu_get_event_info() break PMU
iteration in perf_init_event() for events targeting another PMU?

struct pmu::event_init must return -ENOENT when event->attr.type is not
handled by this PMU.  Checking riscv_pmu_ctr_valid() before
riscv_pmu_get_event_info() validates type causes perf_init_event() to
abort searching other registered PMUs whenever a non-CPU event requests
branch filters outside allowed_filters.

> @@ -827,10 +830,14 @@ static void pmu_sbi_reset_scounteren(void *arg)
> =20
>  static void pmu_sbi_ctr_add(struct perf_event *event, int flags)
>  {
> +	if (needs_branch_stack(event))
> +		riscv_pmu_ctr_add(event);
>  }

[Severity: High]
Does riscv_pmu_ctr_add() (and riscv_pmu_ctr_del()) cause a NULL pointer
dereference when scheduling a per-CPU event with
PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANCH_CALL_STACK?

For a CPU-wide event (pid =3D=3D -1), event->ctx->task is NULL, but
riscv_pmu_ctr_add() and riscv_pmu_ctr_del() dereference event->ctx->task
unconditionally:

drivers/perf/riscv_ctr.c:riscv_pmu_ctr_add() {
	if (branch_user_callstack(event->attr.branch_sample_type) &&
	    event->ctx->task->perf_ctx_data)
		task_context(event->ctx->task->perf_ctx_data)->callstack_users++;
...
}

>  static void pmu_sbi_ctr_del(struct perf_event *event, int flags)
>  {
> +	if (needs_branch_stack(event))
> +		riscv_pmu_ctr_del(event);
>  }

[Severity: Medium]
When CONFIG_RISCV_PMU=3Dy and CONFIG_RISCV_CTR=3Dn, do the
riscv_pmu_ctr_add() and riscv_pmu_ctr_del() stubs in
include/linux/perf/riscv_pmu.h trigger -Wunused-function warnings in
other translation units?

include/linux/perf/riscv_pmu.h:
static void riscv_pmu_ctr_add(struct perf_event *event) { }
static void riscv_pmu_ctr_del(struct perf_event *event) { }

Both stubs are missing the inline keyword, so files such as
drivers/perf/riscv_pmu.c and arch/riscv/kvm/vcpu_pmu.c that include this
header without calling them fail to build under CONFIG_WERROR=3Dy.

[ ... ]

> @@ -864,6 +875,9 @@ static void pmu_sbi_ctr_stop(struct perf_event *event=
, unsigned long flag)
>  	struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events);
>  	struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_addr;
> =20
> +	if (needs_branch_stack(event) && flag !=3D RISCV_PMU_STOP_FLAG_RESET)
> +		riscv_pmu_ctr_disable(event);
> +
>  	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
>  	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
>  		pmu_sbi_reset_scounteren((void *)event);
> @@ -896,7 +910,7 @@ static void pmu_sbi_ctr_stop(struct perf_event *event=
, unsigned long flag)
>  static void pmu_sbi_sched_task(struct perf_event_pmu_context *pmu_ctx, s=
truct task_struct *task,
>  			       bool sched_in)
>  {
> -	/* Call CTR specific Sched hook. */
> +	riscv_pmu_ctr_sched_task(pmu_ctx, task, sched_in);
>  }

[Severity: Critical]
Does wiring up riscv_pmu_ctr_sched_task() alongside
PERF_ATTACH_TASK_DATA in pmu_sbi_event_init() cause an out-of-bounds
heap write into task->perf_ctx_data?

When PERF_ATTACH_TASK_DATA is set, core perf allocates a 40-byte
struct perf_ctx_data wrapper at task->perf_ctx_data and places the
struct riscv_perf_task_context allocation in task->perf_ctx_data->data.
However, riscv_pmu_ctr_sched_task(), riscv_pmu_ctr_add() and
riscv_pmu_ctr_del() cast task->perf_ctx_data directly to
struct riscv_perf_task_context * without RCU protection or dereferencing
->data:

drivers/perf/riscv_ctr.c:riscv_pmu_ctr_sched_task() {
...
	/* Save branch records in task_ctx on sched out */
	task_ctx =3D pmu_ctx ? task->perf_ctx_data : NULL;
	if (task_ctx) {
		if (sched_in)
			riscv_pmu_ctr_restore(task_ctx);
		else
			riscv_pmu_ctr_save(task_ctx, rvpmu->ctr_depth);
		return;
	}
...
}

When a task monitored with PERF_SAMPLE_BRANCH_CALL_STACK schedules out,
riscv_pmu_ctr_save() overwrites the struct perf_ctx_data fields
(including ctx_cache and data) and writes up to 6144 bytes of branch
records past the end of the 40-byte slab object.  Compare with
intel_pmu_lbr_sched_task(), which accesses
rcu_dereference(task->perf_ctx_data)->data under rcu_read_lock().

> @@ -1179,6 +1193,12 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, vo=
id *dev)
>  		hw_evt->state |=3D PERF_HES_UPTODATE;
>  		perf_sample_data_init(&data, 0, hw_evt->last_period);
>  		if (riscv_pmu_event_set_period(event)) {
> +			if (needs_branch_stack(event)) {
> +				riscv_pmu_ctr_consume(cpu_hw_evt, event);
> +				perf_sample_save_brstack(&data, event,
> +							 &cpu_hw_evt->branches->branch_stack, NULL);
> +			}
> +

[Severity: Medium]
How is CTR hardware state managed when multiple events are active on the
same CPU?

First, in pmu_sbi_ctr_stop(), riscv_pmu_ctr_disable() clears CSR_CTRCTL
unconditionally even when other active events on the CPU still have
needs_branch_stack(event) set.  Second, because CTRCTL_LCOFIFRZ is set,
any local counter overflow interrupt freezes CTR by setting
SCTRSTATUS_FROZEN, but pmu_sbi_ovf_handler() only clears
SCTRSTATUS_FROZEN inside riscv_pmu_ctr_consume(); if a non-branch event
overflows (or riscv_pmu_event_set_period() returns 0), CTR remains
frozen for active branch-sampling events.  Third, riscv_pmu_ctr_consume()
re-enables CSR_CTRCTL and clears SCTRSTATUS_FROZEN before
perf_event_overflow() and pmu_sbi_start_overflow_mask() run, so kernel
branches during overflow handling are recorded while the PMU counters are
still stopped.

[ ... ]

> @@ -1367,7 +1391,30 @@ static void riscv_pmu_destroy(struct riscv_pmu *pm=
u)
>  		cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>  }
> =20
> -static void pmu_sbi_event_init(struct perf_event *event)
> +static int branch_records_alloc(struct riscv_pmu *pmu)
> +{
> +	struct branch_records __percpu *tmp_alloc_ptr;
> +	struct branch_records *records;
> +	struct cpu_hw_events *events;
> +	int cpu;
> +
> +	if (!riscv_pmu_ctr_supported(pmu))
> +		return 0;
> +
> +	tmp_alloc_ptr =3D alloc_percpu_gfp(struct branch_records, GFP_KERNEL);
> +	if (!tmp_alloc_ptr)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu) {
> +		events =3D per_cpu_ptr(pmu->hw_events, cpu);
> +		records =3D per_cpu_ptr(tmp_alloc_ptr, cpu);
> +		events->branches =3D records;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Does branch_records_alloc() leak the per-CPU tmp_alloc_ptr allocation if
pmu_sbi_device_probe() fails later?

tmp_alloc_ptr is only resolved via per_cpu_ptr() into events->branches,
and the __percpu base pointer is discarded on return, so neither the
probe error path nor riscv_pmu_destroy() ever calls free_percpu() on it.

[ ... ]

> @@ -1516,9 +1568,16 @@ static int pmu_sbi_device_probe(struct platform_de=
vice *pdev)
>  		pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_EXCLUDE;
>  	}
>  	irq_requested =3D (ret =3D=3D 0);
> -
>  	pmu->pmu.attr_groups =3D riscv_pmu_attr_groups;
>  	pmu->pmu.parent =3D &pdev->dev;
> +	ret =3D riscv_pmu_ctr_init(pmu);
> +	if (ret)
> +		goto out_free;

[Severity: Medium]
Does calling riscv_pmu_ctr_init() from pmu_sbi_device_probe() cause a
section mismatch with check_available_filters()?

pmu_sbi_device_probe() and riscv_pmu_ctr_init() are in .text, but
riscv_pmu_ctr_init() calls check_available_filters(), which is marked
__init in drivers/perf/riscv_ctr.c.  This triggers a modpost section
mismatch warning and will execute freed initmem if the platform device
is probed after boot.

> +
> +	ret =3D branch_records_alloc(pmu);
> +	if (ret)
> +		goto out_ctr_finish;
> +
>  	bitmap_copy(pmu->cmask, cmask, RISCV_MAX_COUNTERS);
>  	pmu->ctr_add =3D pmu_sbi_ctr_add;
>  	pmu->ctr_del =3D pmu_sbi_ctr_del;
> @@ -1535,6 +1594,10 @@ static int pmu_sbi_device_probe(struct platform_de=
vice *pdev)
>  	pmu->csr_index =3D pmu_sbi_csr_index;
>  	pmu->sched_task =3D pmu_sbi_sched_task;
> =20
> +	ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->no=
de);
> +	if (ret)
> +		goto out_ctr_finish;
> +

[Severity: High]
Doesn't this register &pmu->node with cpuhp_state_add_instance() a
second time?

pmu_sbi_device_probe() already registers &pmu->node with
CPUHP_AP_PERF_RISCV_STARTING after register_sysctl():

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_device_probe() {
...
	register_sysctl("kernel", sbi_pmu_sysctl_table);

	ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
	if (ret)
		goto out_unregister;
...
}

Adding the same hlist_node twice corrupts the CPUHP_AP_PERF_RISCV_STARTING
instance list into a circular self-loop (pmu->node.next =3D &pmu->node) and
runs pmu_sbi_starting_cpu() twice per online CPU (with the first pass
running before SBI PMU snapshot setup).

>  	ret =3D riscv_pm_pmu_register(pmu);
>  	if (ret)
>  		goto out_destroy;
> @@ -1592,6 +1655,9 @@ static int pmu_sbi_device_probe(struct platform_dev=
ice *pdev)
>  		riscv_pmu_irq =3D 0;
>  	}
> =20
> +out_ctr_finish:
> +	riscv_pmu_ctr_finish(pmu);
> +
>  out_free:
>  	free_percpu(pmu->hw_events);
>  	kfree(pmu_ctr_list);

[Severity: Medium]
Do the error paths jumping to out_ctr_finish and out_free bypass freeing
riscv_pmu_irq?

pmu_sbi_setup_irqs() requests the per-CPU IRQ with pmu->hw_events as the
dev_id token before riscv_pmu_ctr_init() and branch_records_alloc() run.
Because out_ctr_finish and out_free are placed below the irq_requested
cleanup block in out_destroy, failing in riscv_pmu_ctr_init(),
branch_records_alloc(), or the new cpuhp_state_add_instance() call frees
pmu->hw_events while the per-CPU IRQ remains registered with that freed
pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118095053.3871=
267-1-vikram.singh3@oss.qualcomm.com?part=3D6
