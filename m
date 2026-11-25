Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597298;
	b=NEkvxBchdcQijrYBBkFN24rfYCGKMFbA/NVH/VxQoOQOyGMmbZuXuNw5A1xnYuL2kl9i
	 V5Gs33k0MWj9P7B5Y1dECnxTlpOHQ1f+o7PmCG+amsys1kBV6h3Rvcgx1naz6Lvuc6tsp
	 PBN40kVhMxwM0qbAHdvZnyyjbjTABr0h5cfIlqz5wgBzV82BLoh2/NK4UvHpjicKVo7GS
	 1V9pdpi/bql9q/YQIeQlSRuV2iP9oEFsVpiUOBL5Ml41tjnQOVXz6J0A0H3hbWxxV4Jfb
	 AlnZ67sK57hEPqPccW9+PFdu7jI5BUincuzDGU7EC6JnwCuwvRtcdw8axfc0IkIrDsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597298;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MI6w+xLkq+kgc7RpcEMajWtW3ubEnAx8egyV+jmxVZw=;
	b=xqYpqrowzZvnwD6swt+xMGnw1VAO1dvZ8cOY0/X5u+SV4ZNbrtZ4T2rRudYpJk1ICpFs
	 7lg/tdIvyRyPKd6jaBGnTsnlSGQ+3bKCbaly8Ks8KMKK1fCLDiaYwQEr8Z2DZd+0RjQdq
	 bJBMx/AvDLlaDIUWpz2tO/J6Qs+WT4SOb3ItHKfPSa/DOzv78YO0WhRbKIrLEBlIL7cua
	 /Cr2FZXUwYEa8IZlpEKZJ7N6h3Ruq6DObdm9ohhgk7U5g0GTM8hQIvSy0zSJ37HER8Vm7
	 p99NxS5CQibV6j7qvZqLE0rDZ0Xcd51Zx/Ttb3ruoZZl6B1HbD6AE5Dltk7JjJ+z8vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J74eo1q0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFD4606A31E;
	Wed, 25 Nov 2026 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J74eo1q0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D101F000C4;
	Wed, 25 Nov 2026 09:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795597298;
	bh=MI6w+xLkq+kgc7RpcEMajWtW3ubEnAx8egyV+jmxVZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J74eo1q0XaLoLF2BxFEEO0RcEujzPN7OacguwsHORt7D2UdXBgEwlvX4wCL14RnD5
	 IAiM2wM+fTiEpg25yv3MY2XYNSPedkJcQhhMyP/arsEIGya1A+pHtM9+5c8t7hdRqb
	 zuoL9QjyeywEokxDmvCYblA+f2CRj9J/fRfc2kfq74n3yEq3b55oiqZJ/XUs5f/HyQ
	 puBTBHeaXcaKzakjb+5DWGSBVmaczf7XVRPWSEsWzmDSyq2Hz7cO5oA+Y0kYUZuJWa
	 Bsh4c8taTaxLeBmFDX1WeASdT3rNDhTNaXv24BzA0LGZq/iQF2L9QdUAVnyVKl55wB
	 TmIJt0/PqQMuw==
Message-ID: <sashiko-outbox-232966@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/7] riscv: pmu: Integrate CTR Ext support in
 riscv_pmu_dev driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikram Singh" <vikram.singh3@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125083942.3695072-7-vikram.singh3@oss.qualcomm.com>
References: <20261125083942.3695072-1-vikram.singh3@oss.qualcomm.com>
 <20261125083942.3695072-7-vikram.singh3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:01:37 +0000
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
- [High] riscv: pmu: NULL event->ctx->task dereference in
  riscv_pmu_ctr_add()
- [Medium] riscv: pmu: IRQ cleanup bypassed on error in
  pmu_sbi_device_probe()
- [Medium] riscv: pmu: per-CPU branch_records leak in
  branch_records_alloc()
- [Medium] riscv: pmu: broken CTR state in pmu_sbi_ctr_stop() and
  pmu_sbi_ovf_handler()
- [Medium] riscv: pmu: premature -EOPNOTSUPP in pmu_sbi_event_map()
  before type check
- [Medium] riscv: pmu: section mismatch calling __init
  check_available_filters()
- [Medium] riscv: pmu: missing inline on riscv_pmu_ctr_add() and del()
  header stubs
--

commit e9fe3c69a6f658642dd8da7db09d885c5571874f
Author: Vikram Singh <vikram.singh3@oss.qualcomm.com>

riscv: pmu: Integrate CTR Ext support in riscv_pmu_dev driver

This commit integrates Control Transfer Record (CTR) extension support
into the RISC-V SBI PMU driver to enable branch stack sampling on PMU
events.

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
> =20

[Severity: Medium]
Should this check come after riscv_pmu_get_event_info() verifies that
event->attr.type belongs to this PMU?

Returning -EOPNOTSUPP before riscv_pmu_get_event_info() can return
-ENOENT for an unhandled event type causes perf_init_event() to abort
iterating through other registered PMUs when an event with branch filters
not in allowed_filters targets another PMU.

> @@ -827,10 +830,14 @@ static void pmu_sbi_reset_scounteren(void *arg)
> =20
>  static void pmu_sbi_ctr_add(struct perf_event *event, int flags)
>  {
> +	if (needs_branch_stack(event))
> +		riscv_pmu_ctr_add(event);
>  }
> =20
>  static void pmu_sbi_ctr_del(struct perf_event *event, int flags)
>  {
> +	if (needs_branch_stack(event))
> +		riscv_pmu_ctr_del(event);
>  }

[Severity: High]
Can riscv_pmu_ctr_add() and riscv_pmu_ctr_del() dereference a NULL
event->ctx->task on per-CPU events?

Nothing in event initialization rejects a per-CPU event (pid =3D=3D -1, whe=
re
event->ctx->task is NULL) configured with PERF_SAMPLE_BRANCH_USER |
PERF_SAMPLE_BRANCH_CALL_STACK, and both helpers dereference
event->ctx->task without a NULL check:

drivers/perf/riscv_ctr.c:riscv_pmu_ctr_add() {
    ...
	if (branch_user_callstack(event->attr.branch_sample_type) &&
	    event->ctx->task->perf_ctx_data)
		task_context(event->ctx->task->perf_ctx_data)->callstack_users++;
    ...
}

In addition, when CONFIG_RISCV_CTR is disabled, the stub definitions of
riscv_pmu_ctr_add() and riscv_pmu_ctr_del() in
include/linux/perf/riscv_pmu.h are missing the inline keyword:

include/linux/perf/riscv_pmu.h:
static void riscv_pmu_ctr_add(struct perf_event *event) { }
static void riscv_pmu_ctr_del(struct perf_event *event) { }

This triggers -Wunused-function warnings in translation units that include
the header without calling them.

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
> =20
>  static int pmu_sbi_find_num_ctrs(void)
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
>  			/*
>  			 * Unlike other ISAs, RISC-V don't have to disable interrupts
>  			 * to avoid throttling here. As per the specification, the

[Severity: Medium]
Can pmu_sbi_ctr_stop() and pmu_sbi_ovf_handler() leave CTR disabled,
frozen, or recording kernel branches when multiple events or multi-part
sample periods are active?

In pmu_sbi_ctr_stop(), riscv_pmu_ctr_disable() unconditionally clears
CSR_CTRCTL even if other active branch-sampling events remain on the CPU
(cpu_hw_evt->ctr_users > 1).

In pmu_sbi_ovf_handler(), hardware sets SCTRSTATUS_FROZEN on any LCOFI
because CTRCTL_LCOFIFRZ is enabled, but SCTRSTATUS_FROZEN is only cleared
inside riscv_pmu_ctr_consume().  If a co-scheduled non-branch counter
overflows or riscv_pmu_event_set_period() returns 0 on an intermediate
overflow, SCTRSTATUS_FROZEN stays set when pmu_sbi_start_overflow_mask()
restarts the counters.  Conversely, when riscv_pmu_ctr_consume() does run
inside the loop, ctr_read_entries() re-enables CTR_BRANCH_ENABLE_BITS and
clears SCTRSTATUS_FROZEN before perf_event_overflow() and
pmu_sbi_start_overflow_mask() without resetting the CTR FIFO, so CTR
records kernel branches while counters are still stopped and corrupts the
buffer for any subsequent overflowed counter in the same interrupt.

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
Does branch_records_alloc() leak tmp_alloc_ptr if a later step in
pmu_sbi_device_probe() fails?

Only the per-CPU virtual pointers per_cpu_ptr(tmp_alloc_ptr, cpu) are
saved in events->branches, while the __percpu base pointer tmp_alloc_ptr
needed by free_percpu() is discarded on return and never freed by any
error unwind label or teardown helper.

> +
> +static int pmu_sbi_event_init(struct perf_event *event)
>  {
>  	/*
>  	 * The permissions are set at event_init so that we do not depend
> @@ -1379,6 +1426,11 @@ static void pmu_sbi_event_init(struct perf_event *=
event)
>  		event->hw.flags |=3D PERF_EVENT_FLAG_USER_ACCESS;
>  	else
>  		event->hw.flags |=3D PERF_EVENT_FLAG_LEGACY;
> +
> +	if (branch_sample_call_stack(event))
> +		event->attach_state |=3D PERF_ATTACH_TASK_DATA;
> +
> +	return 0;
>  }

[Severity: Critical]
Does setting PERF_ATTACH_TASK_DATA cause riscv_pmu_ctr_sched_task(),
riscv_pmu_ctr_add(), and riscv_pmu_ctr_del() to write struct
riscv_perf_task_context into the struct perf_ctx_data wrapper?

When PERF_ATTACH_TASK_DATA is set, attach_perf_ctx_data() stores a 40-byte
struct perf_ctx_data wrapper in task->perf_ctx_data and places the PMU's
struct riscv_perf_task_context allocation from pmu->task_ctx_cache in
task->perf_ctx_data->data.  However, riscv_pmu_ctr_add(),
riscv_pmu_ctr_del(), and riscv_pmu_ctr_sched_task() access
task->perf_ctx_data directly without rcu_read_lock()/rcu_dereference() and
without dereferencing ->data:

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

When a task monitored with PERF_SAMPLE_BRANCH_USER |
PERF_SAMPLE_BRANCH_CALL_STACK schedules out, riscv_pmu_ctr_save() writes
up to 6168 bytes into the 40-byte struct perf_ctx_data slab object,
corrupting its ctx_cache and data pointers and adjacent slab objects.

> =20
>  static void pmu_sbi_event_mapped(struct perf_event *event, struct mm_str=
uct *mm)
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

pmu_sbi_device_probe() and riscv_pmu_ctr_init() live in .text, whereas
check_available_filters() in drivers/perf/riscv_ctr.c is marked __init, so
probing the driver after init memory is freed will execute freed
.init.text.

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
>  	ret =3D riscv_pm_pmu_register(pmu);
>  	if (ret)
>  		goto out_destroy;

[Severity: High]
Does this register &pmu->node with CPUHP_AP_PERF_RISCV_STARTING twice in
pmu_sbi_device_probe()?

pmu_sbi_device_probe() already registers &pmu->node after
register_sysctl():

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_device_probe() {
    ...
	register_sysctl("kernel", sbi_pmu_sysctl_table);

	ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
	if (ret)
		goto out_unregister;
    ...
}

Calling cpuhp_state_add_instance() twice with the same struct hlist_node
runs pmu_sbi_starting_cpu() twice on all present CPUs (the first time
before SBI PMU snapshot shared memory is set up) and links pmu->node.next
to itself in __cpuhp_state_add_instance_cpuslocked(), corrupting the
hotplug state's hlist into a circular loop.

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
Does jumping to out_ctr_finish or out_free after pmu_sbi_setup_irqs()
leave riscv_pmu_irq registered while freeing pmu->hw_events?

out_ctr_finish and out_free are placed below the irq_requested teardown
block in out_destroy, so if riscv_pmu_ctr_init(), branch_records_alloc(),
or cpuhp_state_add_instance() fails, free_percpu(pmu->hw_events) frees the
per-CPU dev_id token while the per-CPU IRQ and its mapping remain
registered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125083942.3695=
072-1-vikram.singh3@oss.qualcomm.com?part=3D6
