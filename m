Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997207;
	b=FIoGY1MSpBlXKGUCf9U5mzWJH9jAxweScR/ozTZeSSYIS47eiZsjhje1zvBw0Xg+cuNn
	 wOb1FpYyco1MugKD8JbCV09cxU6P3N555vI7qKkcUuSVlcGEkSkaD5BA8Rg4Fc9ZD+zXh
	 fES59zi8iEQiYFnf6ECqTbjLyUBC1Eeor7mau/W/Huk2jjU2IUbdrXmIleWSxIpxsMIcK
	 1YMc9rxMMSNugTNC7lcT5X/Erxr5IXcdMWC96ZJBG0d35dJVT6yjb/CmzQkDKDBPIdBbK
	 o450ZSQ1xUdCTCR4Jc2Bw11qOmqpAThFNbY7gjNt9YznZN9FhsRPmebdcOT7/uYzPjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997207;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AWAP7Sbb/SVgqYL31WVcwSW/Oi389iyo1C6G5JBLyPo=;
	b=qwPN3/I6IjJ8gDJuFHHAm0xFLSLtYmcDvjL1e9U8hMK75BWGt8WFwbxoFxlpkZ7/pJxU
	 u2JJ6rHIhp4ADMo4O489plOeujcH931sMX0akN1h9VAhWFHwO6Z0aI8orqNxhufTQba57
	 Mi2FWCLLEej4U6msgoZWDih+Sk9MtY3WrdX/7G3gE7kwfU1bPj/wZyDDg/BjHnxS8zyFl
	 vxE+vxJAmxtmu8Fb7ouVIIMMQYH4AjoaLNb4XALLO18myteQDzyr1hN04lwTybPNBcWd+
	 nqTjaL0oDUBCPzuxc5wPRODhR1O+pYw1sfjgXWZ5csKWq9AZEciFWQg76mBRb3TI5SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2vcCgtB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F2606A31C;
	Wed, 18 Nov 2026 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2vcCgtB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5231F000C8;
	Wed, 18 Nov 2026 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794997207;
	bh=AWAP7Sbb/SVgqYL31WVcwSW/Oi389iyo1C6G5JBLyPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h2vcCgtBVJtxgOvUz7N+8awwxmZknnlrqQ7aYkCzYU4X2V7NqFsx4jOVB4K9xOk0R
	 w4Y7kYxORG9MchXDcnlZMyv8Y+M1rQyeMXEcBsaKVfQ/XimrHdEW86p2RwxFgpuqZU
	 winW59mGklltBfeAgufF0BAZx9ezs4v3TOQ+yoYkSXVziL7jBQMGuzepXBaEodQLED
	 u1QTNxBiIscXXyrpHmak7hm5PqmLzEWiwg1beUF7M++fVER9cjj1uBBt2JElpGY/Pw
	 2LRoSmD/EDlW4XL/4sCEIddTEglSBIa6hQCFEELwtBwVwLPTFZT8C9NAeUoIWG8ww5
	 tWYPcTzCUpYgg==
Message-ID: <sashiko-outbox-220675@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/7] riscv: pmu: Add driver for Control Transfer
 Records Ext
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikram Singh" <vikram.singh3@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118095053.3871267-6-vikram.singh3@oss.qualcomm.com>
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
 <20261118095053.3871267-6-vikram.singh3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:20:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 13 potential
issues to consider:
- [Critical] riscv: pmu: perf_ctx_data type confusion and missing RCU in
  CTR task context
- [High] riscv: pmu: duplicate RISCV_M_MODE Kconfig definition and
  broken M-mode CSRs
- [High] riscv: pmu: NULL event->ctx->task dereference in
  riscv_pmu_ctr_add() and del()
- [High] riscv: pmu: inverted CTRDATA_CCV check and cycle truncation in
  ctr_get_cycles()
- [High] riscv: pmu: missing SxCSRIND check, CSR_SIREG* mismatch, and
  RV32 truncation
- [High] riscv: pmu: unmerged CSR_CTRCTL without filtering and hardirq
  pr_warn()
- [Medium] riscv: pmu: 32-bit truncation of CSR_CTRCTL filter bits on
  CONFIG_32BIT
- [Medium] riscv: pmu: missing CTR reset in riscv_pmu_ctr_restore() and
  unpaused save
- [Medium] riscv: pmu: section mismatch on check_available_filters() and
  filter validation
- [Medium] riscv: pmu: missing inline on CTR stubs and wrong header
  guard in riscv_pmu.h
- [Medium] riscv: pmu: reserved SCTRDEPTH_MASK write and unclamped
  ctr_get_depth()
- [Medium] riscv: pmu: early return in branch_type_to_ctr() skips
  CTRCTL_RASEMU
- [Low] riscv: pmu: non-existent Documentation/arch/riscv/pmu-sse.rst in
  MAINTAINERS
--

commit 10ed00c3c43c9d9b32ecbe8d5c8ccf6143b76904
Author: Vikram Singh <vikram.singh3@oss.qualcomm.com>

riscv: pmu: Add driver for Control Transfer Records Ext

This commit adds a driver for the RISC-V Control Transfer Records (CTR)
extension to support hardware branch stack sampling in perf.

Link: https://lore.kernel.org/r/20261106173942.3175069-6-vikram.singh3@oss.=
qualcomm.com

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93abbb315065d..19ddb35654445 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24126,8 +24126,11 @@ F:	arch/riscv/boot/dts/sifive/
>  RISC-V PMU DRIVERS
>  M:	Atish Patra <atish.patra@linux.dev>
>  R:	Anup Patel <anup@brainfault.org>
> +R:	Vikram Singh <vikram.singh3@oss.qualcomm.com>
>  L:	linux-riscv@lists.infradead.org
>  S:	Supported
> +F:	Documentation/arch/riscv/pmu-sse.rst
> +F:	drivers/perf/riscv_ctr.c

[Severity: Low]
Documentation/arch/riscv/pmu-sse.rst does not exist in the tree, which caus=
es
get_maintainer.pl and documentation file reference checks to warn.

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

[Severity: Medium]
Should RISCV_CTR depend on 64BIT?

On CONFIG_32BIT=3Dy builds, csr_read() and csr_write() cast values to a 32-=
bit
unsigned long, truncating bits 33..47 (CTRCTL_EXCINH through
CTRCTL_DIROJUMP_INH) of CSR_CTRCTL in check_available_filters() and
riscv_pmu_ctr_enable().

> +
> +config RISCV_M_MODE
> +		bool "Enable M Mode"
> +		depends on RISCV_CTR
> +		default n

[Severity: High]
Does defining RISCV_M_MODE here conflict with the architecture-wide symbol =
in
arch/riscv/Kconfig?

arch/riscv/Kconfig restricts RISCV_M_MODE with "depends on !MMU", whereas
redefining it here without "!MMU" makes CONFIG_RISCV_M_MODE selectable on
S-mode MMU kernels (and enabled in allyesconfig/allmodconfig).  That disabl=
es
CONFIG_RISCV_SBI and switches core CSR macros such as CSR_STATUS, CSR_IE and
CSR_TVEC to Machine-mode CSRs, breaking S-mode builds and boot.

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

[Severity: High]
Should these helpers pass CSR_IREG, CSR_IREG2 and CSR_IREG3 instead of
hardcoding S-mode CSR_SIREG, CSR_SIREG2 and CSR_SIREG3?

csr_indirect_read() and csr_indirect_write() program CSR_ISELECT (which maps
to CSR_MISELECT under CONFIG_RISCV_M_MODE), so passing CSR_SIREG* accesses =
the
wrong indirect CSR window in M-mode.  In addition, riscv_pmu_ctr_init(),
riscv_pmu_ctr_starting_cpu() and riscv_pmu_ctr_dying_cpu() only check for
SxCTR and SSCOFPMF without checking riscv_isa_extension_available(NULL,
SxCSRIND), which traps with an illegal instruction if SxCSRIND is absent.

[ ... ]

> +static inline unsigned int ctr_get_cycles(u64 ctr_data)
> +{
> +	const unsigned int cce =3D FIELD_GET(CTRDATA_CCE_MASK, ctr_data);
> +	const unsigned int ccm =3D FIELD_GET(CTRDATA_CCM_MASK, ctr_data);
> +
> +	if (ctr_data & CTRDATA_CCV)
> +		return 0;
> +
> +	/* Formula to calculate cycles from spec: (2^12 + CCM) << CCE-1 */
> +	if (cce > 0)
> +		return (4096 + ccm) << (cce - 1);
> +
> +	return FIELD_GET(CTRDATA_CCM_MASK, ctr_data);
> +}

[Severity: High]
Is the CTRDATA_CCV check inverted here?

Per the CTR specification, CTRDATA_CCV (Cycle Count Valid) is 1 when the cy=
cle
count is valid and 0 when invalid, so returning 0 when CTRDATA_CCV is set
discards all valid cycle counts.  Also, (4096 + ccm) << (cce - 1) can reach
27 bits when cce >=3D 5, so assigning the unclamped return value to the 16-=
bit
entry->cycles bitfield in capture_ctr_flags() truncates the upper bits inst=
ead
of saturating at U16_MAX.

> +
> +static inline unsigned int ctr_get_type(u64 ctr_data)
> +{
> +	return FIELD_GET(CTRDATA_TYPE_MASK, ctr_data);
> +}
> +
> +static inline unsigned int ctr_get_depth(u64 ctr_depth)
> +{
> +	/* Depth table from CTR Spec: 2.4 sctrdepth.
> +	 *
> +	 * sctrdepth.depth       Depth
> +	 * 000			- 16
> +	 * 001			- 32
> +	 * 010			- 64
> +	 * 011			- 128
> +	 * 100			- 256
> +	 *
> +	 * Depth =3D 16 * 2 ^ (ctrdepth.depth)
> +	 * or
> +	 * Depth =3D 16 << ctrdepth.depth.
> +	 */
> +	return 16 << FIELD_GET(SCTRDEPTH_MASK, ctr_depth);
> +}

[Severity: Medium]
Can riscv_pmu->ctr_depth exceed MAX_BRANCH_RECORDS (256) or select a
non-maximum WARL depth?

riscv_pmu_ctr_init() and riscv_pmu_ctr_starting_cpu() write the reserved
encoding SCTRDEPTH_MASK (0x7) instead of SCTRDEPTH_MAX (0x4) to CSR_SCTRDEP=
TH.
Under WARL rules a reserved value may map to any legal depth, and if an
implementation retains a field value in 5..7, ctr_get_depth() returns
512..2048 and overflows cpuc->branches->branch_entries[MAX_BRANCH_RECORDS] =
and
task_ctx->store[MAX_BRANCH_RECORDS].

[ ... ]

> +static u64 branch_type_to_ctr(int branch_type)
> +{
> +	u64 config =3D CTR_BRANCH_FILTERS_INH | CTRCTL_LCOFIFRZ;
> +
> +	if (branch_type & PERF_SAMPLE_BRANCH_USER)
> +		config |=3D CTRCTL_U_ENABLE;
> +
> +	if (branch_type & PERF_SAMPLE_BRANCH_KERNEL)
> +		config |=3D CTRCTL_KERNEL_ENABLE;
> +
> +	if (branch_type & PERF_SAMPLE_BRANCH_HV) {
> +		if (riscv_isa_extension_available(NULL, H))
> +			config |=3D CTRCTL_KERNEL_ENABLE;
> +	}
> +
> +	if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
> +		config &=3D ~CTR_BRANCH_FILTERS_INH;
> +		return config;
> +	}

[Severity: Medium]
Does returning early for PERF_SAMPLE_BRANCH_ANY skip setting CTRCTL_RASEMU
when PERF_SAMPLE_BRANCH_CALL_STACK is also requested?

riscv_pmu_ctr_valid() and riscv_pmu_ctr_add() accept events combining
PERF_SAMPLE_BRANCH_ANY and PERF_SAMPLE_BRANCH_CALL_STACK, but the early ret=
urn
here bypasses the PERF_SAMPLE_BRANCH_CALL_STACK check below and leaves RAS
emulation disabled in hardware.

[ ... ]

> +static void ctr_set_perf_entry_type(struct perf_branch_entry *entry,
> +				    u64 ctr_data)
> +{
> +	int ctr_type =3D ctr_get_type(ctr_data);
> +
> +	entry->type =3D ctr_perf_map[ctr_type];
> +	if (entry->type =3D=3D PERF_BR_UNKNOWN)
> +		pr_warn("%d - unknown branch type captured\n", ctr_type);
> +}
[ ... ]
> +static void ctr_regset_to_branch_entry(struct cpu_hw_events *cpuc,
> +				       struct perf_event *event,
> +				       struct ctr_regset *regset,
> +				       unsigned int idx)
> +{
> +	struct perf_branch_entry *entry =3D &cpuc->branches->branch_entries[idx=
];
> +
> +	*entry =3D (struct perf_branch_entry){ };
> +	entry->from =3D regset->src & (~CTRSOURCE_VALID);
> +	entry->to =3D regset->target & (~CTRTARGET_MISP);
> +	capture_ctr_flags(entry, event, regset->ctr_data, regset->target);
> +}

[Severity: High]
Can concurrent CTR events clobber CSR_CTRCTL or leak kernel branch addresses
to unprivileged user-only events, and can ctr_set_perf_entry_type() flood t=
he
kernel log from hardirq context?

riscv_pmu_ctr_enable() overwrites CSR_CTRCTL with a single event's
configuration and riscv_pmu_ctr_disable() unconditionally zeroes CSR_CTRCTL
while other CTR events on the CPU are still active.  When a privileged kern=
el
event and an unprivileged PERF_SAMPLE_BRANCH_USER event share a CPU (or when
branch_type_to_ctr() clears CTRCTL_EXCINH, CTRCTL_INTRINH and CTRCTL_TRETINH
without PERF_SAMPLE_BRANCH_KERNEL), ctr_regset_to_branch_entry() copies
entries without software privilege or type filtering.  Also,
CTRDATA_TYPE_CO_ROUTINE_SWAP (produced by unprivileged jalr x1, x5, 0
instructions) maps to PERF_BR_UNKNOWN and triggers an un-ratelimited pr_war=
n()
up to 256 times per PMU overflow interrupt.

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
> +
> +static void __riscv_pmu_ctr_save(void *ctx, unsigned int depth)
> +{
> +	struct riscv_perf_task_context *task_ctx =3D ctx;
> +	struct ctr_regset *dst;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < depth; i++) {
> +		dst =3D &task_ctx->store[i];
> +		if (!get_ctr_regset(dst, i))
> +			break;
> +	}
> +
> +	task_ctx->num_entries =3D i;
> +
> +	task_ctx->ctr_status =3D csr_read(CSR_SCTRSTATUS);
> +}

[Severity: Medium]
Does returning early in riscv_pmu_ctr_restore() leave the previous task's
branch records in the CTR registers?

When task_ctx is non-NULL on context switch in, riscv_pmu_ctr_sched_task()
calls riscv_pmu_ctr_restore() and returns before reaching the fallback
riscv_pmu_ctr_reset(), so an early return when stack_state =3D=3D CTR_STATE=
_NONE
or callstack_users =3D=3D 0 exposes stale hardware records to the incoming =
task.
In addition, __riscv_pmu_ctr_save() and __riscv_pmu_ctr_restore() access the
CTR registers without clearing CTR_BRANCH_ENABLE_BITS in CSR_CTRCTL first, =
so
branches taken during the save/restore loops corrupt the state when kernel
branch recording is enabled.

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
Does passing task->perf_ctx_data directly to task_context(),
riscv_pmu_ctr_save() and riscv_pmu_ctr_restore() corrupt struct perf_ctx_da=
ta
and overflow the slab allocation?

task->perf_ctx_data is an RCU-protected pointer to a 40-byte struct
perf_ctx_data wrapper whose ->data field holds the PMU's task_ctx_cache
object:

include/linux/perf_event.h:
struct perf_ctx_data {
	struct rcu_head			rcu_head;
	refcount_t			refcount;
	unsigned int			global;
	struct kmem_cache		*ctx_cache;
	void				*data;
};

Treating task->perf_ctx_data itself as struct riscv_perf_task_context
overwrites rcu_head when updating callstack_users and writes up to 256
ctr_regset entries (6144 bytes) past the 40-byte struct perf_ctx_data on
context switch.  These accesses should use rcu_dereference(task->perf_ctx_d=
ata)
under rcu_read_lock() and pass cd->data to task_context().

[Severity: High]
Can event->ctx->task be NULL in riscv_pmu_ctr_add() and riscv_pmu_ctr_del()?

For per-CPU events (pid =3D=3D -1) configured with PERF_SAMPLE_BRANCH_USER |
PERF_SAMPLE_BRANCH_CALL_STACK, event->ctx->task is NULL, so evaluating
event->ctx->task->perf_ctx_data causes a NULL pointer dereference when the
event is scheduled in or out.

[ ... ]

> +static void __init check_available_filters(void)
> +{
[ ... ]
> +	if (ctr_ctl & (CTRCTL_INDCALL_INH | CTRCTL_DIRCALL_INH))
> +		allowed_filters |=3D PERF_SAMPLE_BRANCH_ANY_CALL;
[ ... ]
> +}
[ ... ]
> +int riscv_pmu_ctr_init(struct riscv_pmu *riscv_pmu)
> +{
> +	size_t size =3D sizeof(struct riscv_perf_task_context);
> +
> +	if (!riscv_isa_extension_available(NULL, SxCTR) ||
> +	    !riscv_isa_extension_available(NULL, SSCOFPMF))
> +		return 0;
> +
> +	riscv_pmu->pmu.task_ctx_cache =3D
> +		kmem_cache_create("ctr_task_ctx", size, sizeof(u64), 0, NULL);
> +	if (!riscv_pmu->pmu.task_ctx_cache)
> +		return -ENOMEM;
> +
> +	check_available_filters();

[Severity: Medium]
Does calling __init check_available_filters() from non-__init
riscv_pmu_ctr_init() cause a section mismatch?

riscv_pmu_ctr_init() is in .text and called from platform driver probe, so
calling check_available_filters() in .init.text triggers a modpost warning =
and
will execute freed init memory if probe is deferred or rebound after boot.
Also, check_available_filters() checks whether each branch type's own inhib=
it
bit is writable rather than the complement inhibit bits used by
branch_type_to_ctr() to isolate that type, and riscv_pmu_ctr_valid() does n=
ot
verify that at least one branch type filter is set in branch_sample_type.

> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pm=
u.h
> index c748a06ad7514..848977ecf319f 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
[ ... ]
>  #endif /* CONFIG_RISCV_PMU */
> =20
> +#ifdef CONFIG_RISCV_CTR
> +
> +bool riscv_pmu_ctr_valid(struct perf_event *event);
> +void riscv_pmu_ctr_consume(struct cpu_hw_events *cpuc, struct perf_event=
 *event);
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
Should riscv_pmu_ctr_add() and riscv_pmu_ctr_del() be marked static inline,
and should the CONFIG_RISCV_CTR block sit inside #ifdef CONFIG_RISCV_PMU?

Without inline, every translation unit including this header when
CONFIG_RISCV_CTR=3Dn triggers -Wunused-function warnings.  Also, struct
cpu_hw_events and struct riscv_pmu are only declared inside #ifdef
CONFIG_RISCV_PMU, so placing these prototypes after #endif /* CONFIG_RISCV_=
PMU
*/ triggers -Wvisibility warnings when CONFIG_RISCV_PMU=3Dn.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118095053.3871=
267-1-vikram.singh3@oss.qualcomm.com?part=3D5
