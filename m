Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597759;
	b=T9mpp2IIuc3Hrj+CCAJKnTdb/3Uj4Z/kgZmguFAlsgXRs7DT6gg1TuSTWTGJScZwfkgL
	 Uq6dKT0IVly51kt0hZxwcQsktrRWV7OieefQZ9i6UdyoEUrTAFGwuOsZKvwMco99FbkhK
	 QEwOJp9wRMyOMrLlR9caS+Y1VByQIswVVGxssCMEiK48gnRAQeVr0iEx76ZIc63rnASDE
	 SMTuqQk9DjK68nSktVCP3gtJ3JpoF89w2i+6kyEA4/vjiUBe/RgnjrYqNRtDixJWiRARn
	 qK8NEvSoVEYOVHi4Du5CVhQe/9fIQHC9gmiVtzq/sxsgOGe/ziNBGtWgxWJh3+kUFqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n+cRyADkKae7vFxhgwT7HPOEUWx6kLcWNYERewf8uLo=;
	b=sQQYYAdoe6P1LsbYCWMQ/R+fcyk/JclQnXP/p63cNs9NMuHhpnnKbmkWkp8jJjZaoQNn
	 0Niw2V5v7LFxKU/0XstFISaZleFIq5eBI5+P1iJ124GP4pjYzHuBsM1YmppVuVobwSdWD
	 rSzStprEcjMaGH+DeMEkVm7zrosw714vQUbVUGYqbC7cOqNBInojfYvRy52IYFA2RhFd+
	 DR+be0NbHMgRb+997i+MIfL3yFbDz6vhBwcXUt/8ZpLayxNEN0gD86o4liOhbsJgH6bvj
	 bk1tN5q0tft3sX4anPiQJolGG2bZs7XHLhOna/00HkZd6M2VvTbIgiwkjrbHtkQgi8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLR8pVn3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54EA606A321;
	Wed, 25 Nov 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLR8pVn3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9891F000ED;
	Wed, 25 Nov 2026 09:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795597759;
	bh=n+cRyADkKae7vFxhgwT7HPOEUWx6kLcWNYERewf8uLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLR8pVn3JWXkWL0kkURL6E7cY5WfcANT3V92UikEF7yLPex1AQsP4YCuXy+Kiyywi
	 P4qQX7ICcFyfJ7hdWlSt396dNOBZB7RNkplFutPY0JvRWNyFeM1UwYqCOBjyUAPzzj
	 vWygGZxcN81NF9vol9tDx7RIz/jh4nVBYkQkwNOLDxykh88imxIF2jrGWP2RdbrJjM
	 dNoU4q8T188tf0H7lJb3JBv1Q6NLwMjU1BzAX8HMrmywu/YDT5LmP9/ktFdpvbixHi
	 lm624ZLcu9b/8hYgHt+hNgta4NP0mLQr84Fu+g6S2nOh0deM5Avg6aerkRipmWfbs2
	 L4EEYgEc2J0MQ==
Message-ID: <sashiko-outbox-232973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/7] riscv: pmu: Add driver for Control Transfer
 Records Ext
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikram Singh" <vikram.singh3@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125083942.3695072-6-vikram.singh3@oss.qualcomm.com>
References: <20261125083942.3695072-1-vikram.singh3@oss.qualcomm.com>
 <20261125083942.3695072-6-vikram.singh3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:09:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 14 potential
issues to consider:
- [Critical] riscv: pmu: perf_ctx_data type confusion and missing RCU in
  CTR task context
- [High] riscv: pmu: NULL event->ctx->task dereference in
  riscv_pmu_ctr_add() and del()
- [High] riscv: pmu: inverted CTRDATA_CCV check and cycle truncation in
  ctr_get_cycles()
- [High] riscv: pmu: missing SxCSRIND check and hardcoded CSR_SIREG* in
  CTR helpers
- [High] riscv: pmu: unmerged CSR_CTRCTL without filtering and hardirq
  pr_warn()
- [High] riscv: pmu: PERF_SAMPLE_BRANCH_HV rejected when H extension is
  absent
- [Medium] riscv: pmu: missing CTR reset in riscv_pmu_ctr_restore() and
  unpaused save
- [Medium] riscv: pmu: 32-bit truncation of CSR_CTRCTL filter bits on
  CONFIG_32BIT
- [Medium] riscv: pmu: reserved SCTRDEPTH_MASK write and unclamped
  ctr_get_depth()
- [Medium] riscv: pmu: broken !CONFIG_RISCV_CTR stubs and guards in
  riscv_pmu.h
- [Medium] riscv: pmu: section mismatch and unsafe CSR probing in
  riscv_pmu_ctr_init()
- [Medium] riscv: pmu: call and return inhibit bits left set for
  CTRCTL_RASEMU
- [Medium] riscv: pmu: early return and HV kernel enable in
  branch_type_to_ctr()
- [Low] riscv: pmu: redundant CSR_ISELECT writes in get/set_ctr_regset()
--

commit d1deee5d4cfeac01fee55cdd3cfa24ef329d2acc
Author: Vikram Singh <vikram.singh3@oss.qualcomm.com>

riscv: pmu: Add driver for Control Transfer Records Ext

This commit adds a driver for the RISC-V Control Transfer Records (CTR)
extension to support hardware branch stack sampling in perf.

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 245e7bb763b99..063339ad7691b 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -129,6 +129,17 @@ config ANDES_CUSTOM_PMU
> =20
>  	  If you don't know what to do here, say "Y".
> =20
> +config RISCV_CTR
> +       bool "Enable support for Control Transfer Records (CTR)"
> +       depends on PERF_EVENTS && RISCV_PMU
> +       default y

[Severity: Medium]
Should RISCV_CTR depend on 64BIT, or access the upper half of CSR_CTRCTL
via CSR_CTRCTLH on 32-bit builds?

On CONFIG_32BIT=3Dy, csr_read() and csr_write() cast values to a 32-bit
unsigned long, truncating bits 33..47 (CTR_BRANCH_FILTERS_INH) in
riscv_pmu_ctr_enable() and check_available_filters().

[ ... ]

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

[Severity: High]
Should these helpers pass CSR_IREG, CSR_IREG2 and CSR_IREG3 instead of
hardcoding S-mode CSR_SIREG*, and should riscv_pmu_ctr_init(),
riscv_pmu_ctr_starting_cpu() and riscv_pmu_ctr_dying_cpu() check
riscv_isa_extension_available(NULL, SxCSRIND)?

csr_indirect_read() and csr_indirect_write() write CSR_ISELECT, which maps
to CSR_MISELECT under CONFIG_RISCV_M_MODE.  Also, neither cpufeature.c nor
the CTR init and hotplug paths verify that SxCSRIND is present before
accessing indirect CSRs, which will trap with an illegal instruction
exception if SxCSRIND is absent.

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
Is the CTRDATA_CCV check inverted here?  Per the CTR specification,
CTRDATA_CCV is the Cycle Count Valid bit (1 when valid), so this returns 0
for every valid cycle count and decodes invalid ones.

Also, when cce >=3D 5, (4096 + ccm) << (cce - 1) exceeds 16 bits, and
assigning it to the 16-bit entry->cycles bitfield in capture_ctr_flags()
truncates the upper bits instead of clamping to U16_MAX.

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
Can ctr_get_depth() return more than MAX_BRANCH_RECORDS (256), and should
riscv_pmu_ctr_init() and riscv_pmu_ctr_starting_cpu() write SCTRDEPTH_MAX
(0x4) instead of SCTRDEPTH_MASK (0x7) to CSR_SCTRDEPTH?

Values 0x5..0x7 are reserved in sctrdepth.depth.  Writing 0x7 is not
guaranteed by WARL rules to select 256, and if CSR_SCTRDEPTH reports a
value above 4, ctr_get_depth() returns up to 2048 and overflows
cpuc->branches->branch_entries[256] and task_ctx->store[256].

> +static inline struct riscv_perf_task_context *task_context(void *ctx)
> +{
> +	return (struct riscv_perf_task_context *)ctx;
> +}
> +
> +/* Reads CTR entry at idx and stores it in entry struct. */
> +static bool get_ctr_regset(struct ctr_regset *entry, unsigned int idx)
> +{
> +	entry->src =3D get_ctr_src_reg(idx);
> +
> +	if (!ctr_record_valid(entry->src))
> +		return false;
> +
> +	entry->src =3D entry->src;
> +	entry->target =3D get_ctr_tgt_reg(idx);
> +	entry->ctr_data =3D get_ctr_data_reg(idx);
> +
> +	return true;
> +}
> +
> +static void set_ctr_regset(struct ctr_regset *entry, unsigned int idx)
> +{
> +	set_ctr_src_reg(idx, entry->src);
> +	set_ctr_tgt_reg(idx, entry->target);
> +	set_ctr_data_reg(idx, entry->ctr_data);
> +}

[Severity: Low]
Each call to get_ctr_*_reg() and set_ctr_*_reg() saves IRQs and writes
CSR_ISELECT, even though selecting CTR_ENTRIES_FIRST + idx once in
CSR_ISELECT exposes source, target and data across CSR_IREG, CSR_IREG2 and
CSR_IREG3 simultaneously.  get_ctr_regset() also has a redundant
entry->src =3D entry->src assignment.

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
Does setting CTRCTL_KERNEL_ENABLE for PERF_SAMPLE_BRANCH_HV record host
kernel branches even when PERF_SAMPLE_BRANCH_KERNEL is excluded?

Also, returning early on PERF_SAMPLE_BRANCH_ANY skips the
PERF_SAMPLE_BRANCH_CALL_STACK check below, leaving CTRCTL_RASEMU unset when
both flags are specified.

[ ... ]

> +	if (branch_type & PERF_SAMPLE_BRANCH_CALL_STACK)
> +		config |=3D CTRCTL_RASEMU;

[Severity: Medium]
Does PERF_SAMPLE_BRANCH_CALL_STACK also need to clear CTRCTL_INDCALL_INH,
CTRCTL_DIRCALL_INH and CTRCTL_RET_INH?

When userspace enables LBR call-stack mode (such as perf record
--call-graph lbr), it sets PERF_SAMPLE_BRANCH_CALL_STACK without separate
call or return filter flags, so leaving those inhibit bits set in config
suppresses all call and return records.

[ ... ]

> +bool riscv_pmu_ctr_valid(struct perf_event *event)
> +{
> +	u64 branch_type =3D event->attr.branch_sample_type;
> +
> +	if (branch_type & ~allowed_filters) {
> +		pr_debug_once("Requested branch filters not supported 0x%llx\n",
> +			      branch_type & ~allowed_filters);
> +		return false;
> +	}
> +
> +	return true;
> +}

[Severity: High]
Does rejecting PERF_SAMPLE_BRANCH_HV when the H extension is absent break
default branch sampling on non-H systems?

When userspace does not specify branch privilege bits, perf_copy_attr()
automatically sets PERF_SAMPLE_BRANCH_HV whenever !attr->exclude_hv, so
check_available_filters() omitting PERF_SAMPLE_BRANCH_HV on systems without
H causes riscv_pmu_ctr_valid() to reject standard commands like perf record
-j any.

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
When riscv_pmu_ctr_restore() returns early because stack_state is
CTR_STATE_NONE or callstack_users is 0, riscv_pmu_ctr_sched_task() returns
immediately without calling riscv_pmu_ctr_reset().  Doesn't that leave the
previous task's CTR records in hardware for the incoming task?

Also, unlike ctr_read_entries(), __riscv_pmu_ctr_save() and
__riscv_pmu_ctr_restore() read and write CTR registers without clearing
CTR_BRANCH_ENABLE_BITS in CSR_CTRCTL, so branches taken inside the
save/restore loops can clobber the CTR entries when kernel recording is
enabled.

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
Isn't task->perf_ctx_data an RCU-protected pointer to struct perf_ctx_data,
whose ->data member holds the struct riscv_perf_task_context allocated from
pmu->task_ctx_cache?

Passing task->perf_ctx_data directly to task_context(),
riscv_pmu_ctr_save() and riscv_pmu_ctr_restore() without rcu_dereference()
or dereferencing cd->data treats the 40-byte struct perf_ctx_data wrapper
as a 6168-byte struct riscv_perf_task_context.  Updating callstack_users
corrupts cd->rcu_head, and __riscv_pmu_ctr_save() writes up to 256
ctr_regset entries past the end of struct perf_ctx_data into adjacent slab
objects.

[Severity: High]
Can event->ctx->task be NULL in riscv_pmu_ctr_add() and
riscv_pmu_ctr_del()?

For per-CPU events (pid =3D=3D -1) configured with PERF_SAMPLE_BRANCH_USER |
PERF_SAMPLE_BRANCH_CALL_STACK, event->ctx->task is NULL, so dereferencing
event->ctx->task->perf_ctx_data causes a NULL pointer dereference when the
event is scheduled.

> +
> +	perf_sched_cb_dec(event->pmu);
> +	cpuc->ctr_users--;
> +	WARN_ON_ONCE(cpuc->ctr_users < 0);
> +}
> +
> +void riscv_pmu_ctr_enable(struct perf_event *event)
> +{
> +	u64 branch_type =3D event->attr.branch_sample_type;
> +	u64 ctr;
> +
> +	ctr =3D branch_type_to_ctr(branch_type);
> +	csr_write(CSR_CTRCTL, ctr);
> +}
> +
> +void riscv_pmu_ctr_disable(struct perf_event *event)
> +{
> +	/* Clear CTRCTL to disable the recording. */
> +	csr_write(CSR_CTRCTL, 0);
> +}

[Severity: High]
What happens when multiple CTR events are active on the same CPU?
riscv_pmu_ctr_enable() overwrites CSR_CTRCTL with a single event's filter
and riscv_pmu_ctr_disable() zeroes CSR_CTRCTL even when other CTR events
are still active.  Because ctr_read_entries() does not filter entries in
software by privilege or branch type (and branch_type_to_ctr() clears
CTRCTL_EXCINH, CTRCTL_INTRINH and CTRCTL_TRETINH even without
PERF_SAMPLE_BRANCH_KERNEL), kernel branch addresses recorded for one event
can be copied into a concurrent user-only event's sample buffer.

Also, in ctr_set_perf_entry_type(), CTRDATA_TYPE_CO_ROUTINE_SWAP maps to
PERF_BR_UNKNOWN and triggers an un-ratelimited pr_warn() in hardirq context
(up to 256 times per PMU overflow interrupt) whenever userspace executes
coroutine-swap jalr instructions under PERF_SAMPLE_BRANCH_ANY |
PERF_SAMPLE_BRANCH_TYPE_SAVE.

> +
> +/*
> + * Check for hardware supported perf filters here. To avoid missing
> + * any new added filter in perf, we do a BUILD_BUG_ON check, so make sure
> + * to update CTR_ALLOWED_BRANCH_FILTERS or CTR_EXCLUDE_BRANCH_FILTERS
> + * defines when adding support for it in below function.
> + */
> +static void __init check_available_filters(void)
> +{
> +	u64 ctr_ctl;
> +
> +	/*
> +	 * Ensure both perf branch filter allowed and exclude
> +	 * masks are always in sync with the generic perf ABI.
> +	 */
> +	BUILD_BUG_ON(CTR_PERF_BRANCH_FILTERS !=3D (PERF_SAMPLE_BRANCH_MAX - 1));
> +
> +	allowed_filters =3D PERF_SAMPLE_BRANCH_USER      |
> +			  PERF_SAMPLE_BRANCH_KERNEL    |
> +			  PERF_SAMPLE_BRANCH_ANY       |
> +			  PERF_SAMPLE_BRANCH_HW_INDEX  |
> +			  PERF_SAMPLE_BRANCH_NO_FLAGS  |
> +			  PERF_SAMPLE_BRANCH_NO_CYCLES |
> +			  PERF_SAMPLE_BRANCH_TYPE_SAVE;
> +
> +	csr_write(CSR_CTRCTL, ~0);
> +	ctr_ctl =3D csr_read(CSR_CTRCTL);
> +	csr_write(CSR_CTRCTL, 0);

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
> +
> +	/* Set depth to maximum. */\n> +	csr_write(CSR_SCTRDEPTH, SCTRDEPTH_MAS=
K);
> +	riscv_pmu->ctr_depth =3D ctr_get_depth(csr_read(CSR_SCTRDEPTH));

[Severity: Medium]
Calling __init check_available_filters() from non-__init
riscv_pmu_ctr_init() causes a section mismatch warning and will execute
freed .init.text if PMU probe is deferred or rebound after boot.

In addition, check_available_filters() and riscv_pmu_ctr_init() write ~0 to
CSR_CTRCTL (temporarily setting CTRCTL_U_ENABLE and CTRCTL_KERNEL_ENABLE)
and probe per-CPU CSRs in preemptible context without disabling preemption
or calling riscv_pmu_ctr_reset().  check_available_filters() also checks
whether each filter's own inhibit bit is writable rather than the
complement inhibit bits that branch_type_to_ctr() relies on, and
riscv_pmu_ctr_valid() never checks that at least one branch type filter is
set in branch_type.

[ ... ]

> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pm=
u.h
> index 448e0589875e5..f61e1fd364040 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -108,6 +108,44 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *n=
um_hw_ctr);
>  int riscv_pmu_get_event_info(u32 type, u64 config, u64 *econfig);
>  #endif
> =20
> +static inline bool riscv_pmu_ctr_supported(struct riscv_pmu *pmu)
> +{
> +	return !!pmu->ctr_depth;
> +}
> +
>  #endif /* CONFIG_RISCV_PMU */
> =20
> +#ifdef CONFIG_RISCV_CTR
> +
> +bool riscv_pmu_ctr_valid(struct perf_event *event);
> +void riscv_pmu_ctr_consume(struct cpu_hw_events *cpuc, struct perf_event=
 *event);
> +void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *pmu_ctx, st=
ruct task_struct *task,
> +			      bool sched_in);
> +void riscv_pmu_ctr_add(struct perf_event *event);
> +void riscv_pmu_ctr_del(struct perf_event *event);
> +void riscv_pmu_ctr_enable(struct perf_event *event);
> +void riscv_pmu_ctr_disable(struct perf_event *event);
> +void riscv_pmu_ctr_dying_cpu(void);
> +void riscv_pmu_ctr_starting_cpu(void);
> +int  riscv_pmu_ctr_init(struct riscv_pmu *riscv_pmu);
> +void riscv_pmu_ctr_finish(struct riscv_pmu *riscv_pmu);
> +
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
Does this build when CONFIG_RISCV_CTR=3Dn or CONFIG_RISCV_PMU=3Dn?

In the !CONFIG_RISCV_CTR stubs, riscv_pmu_ctr_sched_task() omits the first
parameter name (which fails under -std=3Dgnu11), and riscv_pmu_ctr_add() and
riscv_pmu_ctr_del() are missing inline (triggering -Wunused-function
warnings).  Also, placing this block outside #ifdef CONFIG_RISCV_PMU
references struct cpu_hw_events and struct riscv_pmu when they have not
been declared.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125083942.3695=
072-1-vikram.singh3@oss.qualcomm.com?part=3D5
