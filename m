Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596925;
	b=Hz3Wo8u0OAfApNtdEufJFCkx4LoO8UYCTuuuF6MA2nDVdKvYyn3chzetnc8+6lgd1tm0
	 yR61vg7B2dYE7poxiwAxshqEOvgkpy9vctGUTfscYnF4/CjgQNHUHaJGM91ZO5mHsadEW
	 K2Ft4w36Sm2WtDsEcaeTPQPLHb0NctxjgaDqWbE9fkKBzEe2KXTHzttwOK0gJJIQHPxwB
	 XWOgK66wATwbF9+B/mA2UAZSxe2zUgHIgUR5VZKY2IvTBhmJB++qdoWy6T0hrb0lSym7B
	 w0t3cbvsU+dRnr6m5jyl6hvnc4a7SgFOMGQeLUp0mIJcsVqT7qTGyXvFV2qep11q+4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596925;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0g1+ghBFmfk9nCHFWSNg0rNLR5uyAMuZKHyC0p9vfmk=;
	b=0Eiag/IJk1C+0jRUBWHATEOzWOJ73oFZRdUJzq7wC5SW6iPce2zwADUtUwlTVpnieGOc
	 j20fuZ9zvEEMOvu9w0yUiwoEhuMZmh1XK24e7LpSXSnW0F/DX8G1uptqrmxz4T7wR10Et
	 xFf7WuJwmIlTuCx4t2uS+mwBmDGLmkB2UNC9ZK4gTM58eBOpSMOd2FLjezVcHUFUsTA5I
	 jrHyx6I9iMJID/ZnCQiQbNAD16zfdzATsC6jv8Rrw6J8WpbxhkD0e4Gwh+UWILvIUbFZ+
	 Ji+Bd46/kyXazBWEbIQ4aBWAR86ihVWtF5blfuLgSQ4euE73mPDhIZbdNkDuCTF+tRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNui5XzM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1582606A31E;
	Wed, 25 Nov 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNui5XzM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039271F000D2;
	Wed, 25 Nov 2026 08:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795596925;
	bh=0g1+ghBFmfk9nCHFWSNg0rNLR5uyAMuZKHyC0p9vfmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CNui5XzMttpqA4V3c4ys0N85HnbLdShS3a16I0bXtKKl0bHpwfI98X64dYYMn5pp4
	 nfiOAgWgMSZ1YTUSsYYgOem+SCMSayNjE8sxutNVW1H5+vpBEmWHLGW+UEkk2utT0a
	 GPtzeJ6mPttXQ2Qq/lLCw5ellCog2oZhFB9fjQMTzrW2vlLCvtet32frBIf0t9OoRe
	 naVXk9v8v/PQY1UsrJbIbnJjvZedag4CJrZ/JDwsgNcupSuKpfyK46cMtA4agfc4i0
	 grA4NpTOY6pCwmdbtd/EkT5CsVm68N4ydexHccuErHpi2edn9qThZ9b40YfqP2uds0
	 w3i/TtAkm8LHA==
Message-ID: <sashiko-outbox-232956@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/7] dt-bindings: riscv: add Sxctr ISA extension
 description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikram Singh" <vikram.singh3@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125083942.3695072-8-vikram.singh3@oss.qualcomm.com>
References: <20261125083942.3695072-1-vikram.singh3@oss.qualcomm.com>
 <20261125083942.3695072-8-vikram.singh3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:55:24 +0000
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
- [Critical] perf: riscv: out-of-bounds slab corruption via direct cast
  of perf_ctx_data
- [High] perf: riscv: duplicate cpuhp_state_add_instance() in
  pmu_sbi_device_probe()
- [High] perf: riscv: NULL event->ctx->task dereference in
  riscv_pmu_ctr_add() and del()
- [Medium] perf: riscv: skipped riscv_pmu_ctr_reset() when
  riscv_pmu_ctr_restore() aborts
- [Medium] perf: riscv: missing inline on riscv_pmu_ctr_add() and del()
  stubs
- [Medium] perf: riscv: per-CPU branch_records leak in
  branch_records_alloc()
- [Medium] perf: riscv: missing SxCSRIND check and hardcoded CSR_SIREG*
  in CTR accessors
--

commit d8946febe7369229970ffb521dc938bff583395a
Author: Vikram Singh <vikram.singh3@oss.qualcomm.com>

dt-bindings: riscv: add Sxctr ISA extension description

This series adds support for the RISC-V Control Transfer Records (CTR)
extension, including CSR definitions, extension parsing, the CTR PMU
driver, SBI PMU integration, and DeviceTree binding descriptions.

> diff --git a/drivers/perf/riscv_ctr.c b/drivers/perf/riscv_ctr.c
> new file mode 100644
> index 0000000000000..649b68247ff56
> --- /dev/null
> +++ b/drivers/perf/riscv_ctr.c
> @@ -0,0 +1,608 @@

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
hardcoding the S-mode CSR_SIREG* registers, and should CTR initialization
verify that SxCSRIND is available?

csr_indirect_read() and csr_indirect_write() select the target register via
CSR_ISELECT (which maps to CSR_MISELECT under CONFIG_RISCV_M_MODE) and rely
on the Smcsrind/Sscsrind extension.  However, riscv_pmu_ctr_init(),
riscv_pmu_ctr_starting_cpu(), and riscv_pmu_ctr_dying_cpu() only check for
SxCTR and SSCOFPMF, so accessing these indirect CSRs when SxCSRIND is not
implemented will trap with an illegal instruction.

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
Does returning early from riscv_pmu_ctr_restore() skip resetting the CTR
registers on context switch-in?

When task_ctx is non-NULL and sched_in is true, riscv_pmu_ctr_sched_task()
calls riscv_pmu_ctr_restore() and immediately returns.  If stack_state is
CTR_STATE_NONE (such as on the task's first schedule-in) or callstack_users
is 0, riscv_pmu_ctr_restore() returns before calling riscv_pmu_ctr_reset(),
leaving the previous task's branch records in the hardware registers.

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
> +
> +	perf_sched_cb_dec(event->pmu);
> +	cpuc->ctr_users--;
> +	WARN_ON_ONCE(cpuc->ctr_users < 0);
> +}

[Severity: Critical]
Does passing task->perf_ctx_data directly to task_context(),
riscv_pmu_ctr_save(), and riscv_pmu_ctr_restore() corrupt struct
perf_ctx_data and adjacent slab objects?

task->perf_ctx_data is a struct perf_ctx_data __rcu * wrapper whose ->data
member points to the struct riscv_perf_task_context allocated from
pmu->task_ctx_cache.  Treating task->perf_ctx_data itself as struct
riscv_perf_task_context * overwrites struct perf_ctx_data (starting with
rcu_head) when updating callstack_users or stack_state, and writes up to
256 struct ctr_regset entries past the end of the 48-byte struct
perf_ctx_data allocation on context switch.  Should these callers
dereference task->perf_ctx_data under RCU and pass cd->data instead?

[Severity: High]
Can event->ctx->task be NULL in riscv_pmu_ctr_add() and
riscv_pmu_ctr_del()?

For CPU-wide events (pid =3D=3D -1), event->ctx is a per-CPU context where
event->ctx->task is NULL.  Because neither riscv_pmu_event_init() nor
pmu_sbi_event_init() rejects PERF_SAMPLE_BRANCH_USER |
PERF_SAMPLE_BRANCH_CALL_STACK on CPU-wide events, dereferencing
event->ctx->task->perf_ctx_data triggers a NULL pointer dereference when
such an event is scheduled.

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
Does branch_records_alloc() leak the per-CPU branch_records allocation if
pmu_sbi_device_probe() later fails?

tmp_alloc_ptr is local to branch_records_alloc(), while only the resolved
per-CPU pointers are stored in events->branches.  The __percpu pointer
needed by free_percpu() is lost, and the probe error unwind paths never
free the allocation.

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
&pmu->node) here register the same hlist_node twice?

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

Calling cpuhp_state_add_instance() a second time on &pmu->node runs
pmu_sbi_starting_cpu() twice on each online CPU and inserts &pmu->node at
the head of the hotplug state's hlist while it is already on that list,
corrupting the list into a self-loop.

> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pm=
u.h
> index ecaa40370830a..f61e1fd364040 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -92,6 +108,44 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *nu=
m_hw_ctr);

[ ... ]

> +static inline void riscv_pmu_ctr_sched_task(struct perf_event_pmu_contex=
t *,
> +					    struct task_struct *task, bool sched_in) { }
> +static void riscv_pmu_ctr_add(struct perf_event *event) { }
> +static void riscv_pmu_ctr_del(struct perf_event *event) { }
> +static inline void riscv_pmu_ctr_enable(struct perf_event *event) { }

[Severity: Medium]
Should the !CONFIG_RISCV_CTR stubs for riscv_pmu_ctr_add() and
riscv_pmu_ctr_del() be marked static inline?  Without inline, compilation
units that include this header without calling both functions trigger
-Wunused-function warnings when CONFIG_RISCV_CTR is disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125083942.3695=
072-1-vikram.singh3@oss.qualcomm.com?part=3D7
