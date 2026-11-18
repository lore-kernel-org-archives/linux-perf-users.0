Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997488;
	b=thhChJPm/VBKxOAnMsHHQ8Zfa4XZ6mGZ6OcW73C8udmDl+RH4a53lMJqWbgRKcdez7FB
	 edxJ4vsrq9NyHIwQd9flV+PjmHgYrWR/8TYs/SConCyOV04QlqcmqBYiZt2EJhffVi2Fq
	 euk7igY15Z2HI4DP3g/01w3KQOgDOPj1Yi9ndR1aIrKek6/iiIJTXdqvsEsAxRPeeJvHX
	 er1+dwbJEaYkbmS+KAhPAm0Te4COoqldVzNWiAiNMsJFMNpLJjECfNK59KCSocO9vnqs/
	 dHjrzaInwTJ5wfdvKd8BcYw7Z68KeYlE/mzgEcuqfmM7l7AUra6r4HfZgV8iZ+wmucg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997488;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gUALAb4dOixABff1qebcrIY3GrqgLqorGu0AMOZmGBA=;
	b=1T4D3RO7OlSSmYhxZDktaMT0DaHFyacECvevEG7CL9f530SF8wWbNh7wkGFFqfNAtZ72
	 6YRgxIODqhHKdAH5C0qTmSM5cepARmj7Cm7kiICuOqG4Um3EVFu8HqTaGOsdM55FaDAiR
	 OzUyn/pEsklOEGO3yzGgaEg9eUosjej2MP+2mwirtrosDR7kwDxDEZn9D2XmAUC2h9yAw
	 HZMs0Pq0+DNmQeg2BxkDa6zKe06Pww4tisGXlpWDvWY85ajj1OzLYZ42/KjQ0LpRUV/ev
	 4KFun+9LQfUWC0+le5STduQ6BenjsAB6I75E4/qGxPK8f6U1t3gISfV3RGzxJOVca1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P2Pph0Kc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631EF606A31C;
	Wed, 18 Nov 2026 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P2Pph0Kc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34B71F000C4;
	Wed, 18 Nov 2026 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794997488;
	bh=gUALAb4dOixABff1qebcrIY3GrqgLqorGu0AMOZmGBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P2Pph0KcSWXbu7X1dEm75JT7DNeckjgDwtMDa4Kj0kxAHvZw8yfPOgmchRtsrkpMV
	 FixMUXCQF4P0rbG7NdfF6on5i2kGQT2JkTd/KC9CNaN9HrMcAP7EyJr/MRItC8eTpE
	 BPRkmWdCQ7jb0nkTXbixW8rWXXkZFQmqAToGy/apDzBIuiQlIk3HV8VoVg0AHGSfAc
	 /IvPvPYT9xah4/ZMbp9otAgla5nrbfaNcofrs60fo5sMJV3Pq4SJFjI4GfRKHioI9k
	 W47WOBQQRLqm7S7MItuglGNHckv4RzNEOSVio8RauToTz/tTkbeR+KOvd2arOjYMlg
	 rGNYO1sys2WRA==
Message-ID: <sashiko-outbox-220685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/7] dt-bindings: riscv: add Sxctr ISA extension
 description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikram Singh" <vikram.singh3@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118095053.3871267-8-vikram.singh3@oss.qualcomm.com>
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
 <20261118095053.3871267-8-vikram.singh3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:24:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [Critical] perf: riscv: out-of-bounds slab corruption via direct cast
  of perf_ctx_data
- [High] perf: riscv: duplicate cpuhp_state_add_instance() in
  pmu_sbi_device_probe()
- [High] perf: riscv: NULL event->ctx->task dereference in
  riscv_pmu_ctr_add() and del()
- [High] perf: riscv: Kconfig redefines RISCV_M_MODE without !MMU
  dependency
- [Medium] perf: riscv: skipped riscv_pmu_ctr_reset() when
  riscv_pmu_ctr_restore() aborts
- [Medium] perf: riscv: missing inline on riscv_pmu_ctr_add() and del()
  stubs
- [Medium] perf: riscv: per-CPU branch_records leak in
  branch_records_alloc()
- [Medium] perf: riscv: missing SxCSRIND check and hardcoded CSR_SIREG*
  in CTR accessors
--

commit 7e8027524e26d037976ef2abf89eb8bdde55ea3d
Author: Vikram Singh <vikram.singh3@oss.qualcomm.com>

dt-bindings: riscv: add Sxctr ISA extension description

This series adds support for the RISC-V Control Transfer Records (Smctr and
Ssctr) ISA extensions to the RISC-V PMU driver and device tree bindings.

Link: https://lore.kernel.org/r/20261106173942.3175069-8-vikram.singh3@oss.=
qualcomm.com

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 245e7bb763b99..0b4c04c50c227 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -129,6 +129,22 @@ config ANDES_CUSTOM_PMU
> =20
>  	  If you don't know what to do here, say "Y".
> =20
> +config RISCV_CTR
> +	bool "Enable support for Control Transfer Records (CTR)"
> +	depends on PERF_EVENTS && RISCV_PMU
> +	default y
> +	help
> +	  Enable support for Control Transfer Records (CTR) which
> +	  allows recording branches, Jumps, Calls, returns etc taken in an
> +	  execution path. This also supports privilege based filtering. It
> +	  captures additional relevant information such as cycle count,
> +	  branch misprediction etc.
> +
> +config RISCV_M_MODE
> +		bool "Enable M Mode"
> +		depends on RISCV_CTR
> +		default n

[Severity: High]
Does defining config RISCV_M_MODE here conflict with the architecture-wide
RISCV_M_MODE symbol in arch/riscv/Kconfig?

In arch/riscv/Kconfig, RISCV_M_MODE depends on !MMU and RISCV_SBI depends
on !RISCV_M_MODE.  Adding a second definition that depends only on
RISCV_CTR allows CONFIG_RISCV_M_MODE=3Dy on CONFIG_MMU=3Dy kernels (such as
allyesconfig and allmodconfig), which disables CONFIG_RISCV_SBI and switches
CSR macros to M-mode, breaking the build.

> diff --git a/drivers/perf/riscv_ctr.c b/drivers/perf/riscv_ctr.c
> new file mode 100644
> index 0000000000000..1af8a304dd699
> --- /dev/null
> +++ b/drivers/perf/riscv_ctr.c

[ ... ]

> +static inline u64 get_ctr_src_reg(unsigned int ctr_idx)
> +{
> +	return csr_indirect_read(CSR_SIREG, CTR_ENTRIES_FIRST, ctr_idx);
> +}
> +
> +static inline void set_ctr_src_reg(unsigned int ctr_idx, u64 value)
> +{
> +	return csr_indirect_write(CSR_SIREG, CTR_ENTRIES_FIRST, ctr_idx, value);
> +}
> +
> +static inline u64 get_ctr_tgt_reg(unsigned int ctr_idx)
> +{
> +	return csr_indirect_read(CSR_SIREG2, CTR_ENTRIES_FIRST, ctr_idx);
> +}
> +
> +static inline void set_ctr_tgt_reg(unsigned int ctr_idx, u64 value)
> +{
> +	return csr_indirect_write(CSR_SIREG2, CTR_ENTRIES_FIRST, ctr_idx, value=
);
> +}
> +
> +static inline u64 get_ctr_data_reg(unsigned int ctr_idx)
> +{
> +	return csr_indirect_read(CSR_SIREG3, CTR_ENTRIES_FIRST, ctr_idx);
> +}
> +
> +static inline void set_ctr_data_reg(unsigned int ctr_idx, u64 value)
> +{
> +	return csr_indirect_write(CSR_SIREG3, CTR_ENTRIES_FIRST, ctr_idx, value=
);
> +}

[Severity: Medium]
Should these accessors use CSR_IREG, CSR_IREG2, and CSR_IREG3 instead of
CSR_SIREG, CSR_SIREG2, and CSR_SIREG3, and should riscv_pmu_ctr_init() also
check that SxCSRIND is available?

csr_indirect_read() and csr_indirect_write() write CSR_ISELECT, which maps
to CSR_MISELECT under CONFIG_RISCV_M_MODE, so hardcoding CSR_SIREG*
mismatches the indirect select CSR in M-mode.  In addition,
riscv_pmu_ctr_init(), riscv_pmu_ctr_starting_cpu(), and
riscv_pmu_ctr_dying_cpu() check SxCTR and SSCOFPMF without checking
riscv_isa_extension_available(NULL, SxCSRIND), which causes an illegal
instruction trap if SxCTR is advertised without SxCSRIND.

[ ... ]

> +static void riscv_pmu_ctr_restore(void *ctx)
> +{
> +	if (task_context(ctx)->stack_state =3D=3D CTR_STATE_NONE ||
> +	    task_context(ctx)->callstack_users =3D=3D 0) {
> +		return;
> +	}
> +
> +	riscv_pmu_ctr_reset();
> +	__riscv_pmu_ctr_restore(ctx);
> +
> +	task_context(ctx)->stack_state =3D CTR_STATE_NONE;
> +}

[ ... ]

> +void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *pmu_ctx, st=
ruct task_struct *task,
> +			      bool sched_in)
> +{
> +	struct riscv_pmu *rvpmu =3D to_riscv_pmu(pmu_ctx->pmu);
> +	struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_events);
> +	void *task_ctx;
> +
> +	if (!cpuc->ctr_users)
> +		return;
> +
> +	/* Save branch records in task_ctx on sched out */
> +	task_ctx =3D pmu_ctx ? task->perf_ctx_data : NULL;
> +	if (task_ctx) {
> +		if (sched_in)
> +			riscv_pmu_ctr_restore(task_ctx);
> +		else
> +			riscv_pmu_ctr_save(task_ctx, rvpmu->ctr_depth);
> +		return;
> +	}
> +
> +	/* Reset branch records on sched in */
> +	if (sched_in)
> +		riscv_pmu_ctr_reset();
> +}

[Severity: Medium]
When sched_in is true and task_ctx is non-NULL, does returning early from
riscv_pmu_ctr_restore() skip resetting the CTR registers?

If stack_state is CTR_STATE_NONE (for example on the task's first
schedule-in) or callstack_users is 0, riscv_pmu_ctr_restore() returns
before calling riscv_pmu_ctr_reset(), and riscv_pmu_ctr_sched_task() then
returns immediately without reaching the fallback riscv_pmu_ctr_reset().
That leaves the previous task's branch records in the hardware registers
across the context switch.

> +
> +static inline bool branch_user_callstack(unsigned int br_type)
> +{
> +	return (br_type & PERF_SAMPLE_BRANCH_USER) &&
> +		(br_type & PERF_SAMPLE_BRANCH_CALL_STACK);
> +}
> +
> +void riscv_pmu_ctr_add(struct perf_event *event)
> +{
> +	struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> +	struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_events);
> +
> +	if (branch_user_callstack(event->attr.branch_sample_type) &&
> +	    event->ctx->task->perf_ctx_data)
> +		task_context(event->ctx->task->perf_ctx_data)->callstack_users++;
> +
> +	perf_sched_cb_inc(event->pmu);
> +
> +	if (!cpuc->ctr_users++)
> +		riscv_pmu_ctr_reset();
> +}
> +
> +void riscv_pmu_ctr_del(struct perf_event *event)
> +{
> +	struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> +	struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_events);
> +
> +	if (branch_user_callstack(event->attr.branch_sample_type) &&
> +	    event->ctx->task->perf_ctx_data)
> +		task_context(event->ctx->task->perf_ctx_data)->callstack_users--;

[Severity: Critical]
Does casting task->perf_ctx_data directly to struct riscv_perf_task_context
in riscv_pmu_ctr_sched_task(), riscv_pmu_ctr_add(), and
riscv_pmu_ctr_del() corrupt struct perf_ctx_data and adjacent slab memory?

task->perf_ctx_data is a struct perf_ctx_data __rcu * wrapper whose void
*data member holds the object allocated from pmu->task_ctx_cache:

include/linux/perf_event.h:
struct perf_ctx_data {
	struct rcu_head rcu_head;
	refcount_t refcount;
	struct kmem_cache *ctx_cache;
	void *data;
};

Treating task->perf_ctx_data itself as struct riscv_perf_task_context *
without dereferencing cd->data under RCU overwrites struct perf_ctx_data
(starting at rcu_head.next when updating callstack_users and stack_state)
and writes up to 256 struct ctr_regset entries (~6 KB) out of bounds past
the 48-byte struct perf_ctx_data slab object during __riscv_pmu_ctr_save().

[Severity: High]
Can event->ctx->task be NULL in riscv_pmu_ctr_add() and
riscv_pmu_ctr_del()?

For a CPU-wide perf event opened with PERF_SAMPLE_BRANCH_USER |
PERF_SAMPLE_BRANCH_CALL_STACK, event->ctx->task is NULL, so evaluating
event->ctx->task->perf_ctx_data causes a NULL pointer dereference when the
event is added or deleted.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 21a2078eab98a..637b9d97e20a4 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> @@ -1353,7 +1391,30 @@ static void riscv_pmu_destroy(struct riscv_pmu *pm=
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
Does branch_records_alloc() leak the per-CPU allocation from
alloc_percpu_gfp()?

tmp_alloc_ptr is a local __percpu pointer that is discarded when
branch_records_alloc() returns, and only the resolved per-CPU pointers are
stored in events->branches.  If pmu_sbi_device_probe() fails at a later
step or the PMU is torn down, there is no __percpu pointer saved to pass to
free_percpu(), leaking the per-CPU branch_records memory.

[ ... ]

> @@ -1517,6 +1592,11 @@ static int pmu_sbi_device_probe(struct platform_de=
vice *pdev)
>  	pmu->event_mapped =3D pmu_sbi_event_mapped;
>  	pmu->event_unmapped =3D pmu_sbi_event_unmapped;
>  	pmu->csr_index =3D pmu_sbi_csr_index;
> +	pmu->sched_task =3D pmu_sbi_sched_task;
> +
> +	ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->no=
de);
> +	if (ret)
> +		goto out_ctr_finish;
> =20
>  	ret =3D riscv_pm_pmu_register(pmu);
>  	if (ret)

[Severity: High]
Does adding cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING,
&pmu->node) here register &pmu->node twice during pmu_sbi_device_probe()?

The existing cpuhp_state_add_instance() call later in pmu_sbi_device_probe()
is still present:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_device_probe() {
	...
	register_sysctl("kernel", sbi_pmu_sysctl_table);

	ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
	if (ret)
		goto out_unregister;
	...
}

Calling cpuhp_state_add_instance() twice with the same hlist_node invokes
pmu_sbi_starting_cpu() a second time on each online CPU and re-inserts
&pmu->node at the head of the hotplug state list while it is already the
head, corrupting the list into a circular self-loop.

> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pm=
u.h
> index ecaa40370830a..848977ecf319f 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h

[ ... ]

> +#else
> +
> +static inline bool riscv_pmu_ctr_valid(struct perf_event *event) { retur=
n false; }
> +static inline void riscv_pmu_ctr_consume(struct cpu_hw_events *cpuc,
> +					 struct perf_event *event) { }
> +static inline void riscv_pmu_ctr_sched_task(struct perf_event_pmu_contex=
t *,
> +					    struct task_struct *task, bool sched_in) { }
> +static void riscv_pmu_ctr_add(struct perf_event *event) { }
> +static void riscv_pmu_ctr_del(struct perf_event *event) { }

[Severity: Medium]
Should riscv_pmu_ctr_add() and riscv_pmu_ctr_del() be marked static inline
in the !CONFIG_RISCV_CTR block?  Without inline, any translation unit that
includes include/linux/perf/riscv_pmu.h without calling both helpers emits
-Wunused-function warnings when CONFIG_RISCV_CTR is disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118095053.3871=
267-1-vikram.singh3@oss.qualcomm.com?part=3D7
