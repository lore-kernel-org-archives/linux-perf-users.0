Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD873E4105
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751509; cv=none; b=RWg69y8bp3TGwPn8U5kdgUjZ+1pp3zLkcupEpi6/XA7YaiFQIUVMTaKyYVKsZBOktyTvTSUzo90Lv28/Pdp2M1l2o6+Hps/m4y9baJUZEYgijNcJAqaS4uiXX82MJbxVEZizzrGSDYSzkPpSguek7Go5tIn6z91YFXtvHvgP7Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751509; c=relaxed/simple;
	bh=Y405iLMJ/0+watf6ekvoYSJNlDMy5jsn8R6AGhU/H+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JfpMcF43/PZI7OflZpvLYMf6aSkZ17mYVKfOYv6NcXlK/Xsjlct4bheoM7z4qeeX8k/mDBs4D5ES9WTk0otkvSIHM44aPHwKICSInCZstTIAWBgYXoupEhexjOk2RHQ9GKol0E9Ce+fmzEnSk5m2/vF3VMQF+B6i3RxdyrvkfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAyQWAie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAyQWAie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F431F000FF;
	Wed, 30 Sep 2026 06:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751503;
	bh=HJHwY9rsevl5M5e8wo9SlZrH+UnNKnORjn3AOYFrOac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mAyQWAie+bO9/A62NwK6cp75J1SJHneKVpEL4kv/iciyuh1Nubo3w7QoUk0B457mK
	 9k1/eEnBx+7YYOezptO4MUM3HVUJ/wZDLbrRJz+vjymSthCV/FgiMRX9PzbIZq8zx0
	 ubR1jzohiDNRelSsxlcr7D2sDyBBl/NdB8SubpBAzim6jeC0eXp2rDu7A3fX5/SWIg
	 7qEh2rlt0fnx7OSrLxyOmKX06BdgGr2+w4VVkmMqoInC0AxUtGy/qlrvlvJUmMY7ln
	 Dd5Pz+kJuAT1iqIReY0j3CD9/T8aJRYWsPcDfWwHlUyPAku915qgN6agSQnP5JufrL
	 4b0nc5UxQ1PIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/8] riscv: Introduce support for hardware
 break/watchpoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Chauhan" <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930063919.608911-2-himanshu.chauhan@oss.qualcomm.com>
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
 <20260930063919.608911-2-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 06:58:22 +0000
Message-Id: <20260930065823.14F431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] perf/riscv: deadlock and IRQ state corruption via per-CPU lock fla=
gs
- [High] perf/riscv: hardware trigger hit bit is not cleared causing stuck =
triggers
- [High] perf/riscv: arch_update_hw_breakpoint passes zero count and corrup=
ts memory
- [High] perf/riscv: use-after-free of sbi_dbtr_shmem on hotplug setup fail=
ure
- [Medium] perf/riscv: hardware triggers are leaked on software allocation =
failure
- [Medium] perf/riscv: integer underflow in arch_check_bp_in_kernelspace
- [Medium] perf/riscv: race condition in arch_uninstall_hw_breakpoint crash=
es kernel
- [Medium] perf/riscv: uninitialized tstate passed to hypervisor on trigger=
 install
- [Low] perf/riscv: arch_hw_breakpoint_init returns positive integer on suc=
cess
--

commit 43e04941130b3d79825bf1347e698fc0ed2e7a0d
Author: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

riscv: Introduce support for hardware break/watchpoints

This commit introduces hardware breakpoint and watchpoint support for RISC-=
V.
It builds on the perf subsystem and uses the SBI debug trigger extension to
manage hardware triggers.

> diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_bre=
akpoint.c
> --- /dev/null
> +++ b/arch/riscv/kernel/hw_breakpoint.c
> @@ -0,0 +1,746 @@
[ ... ]
> +/* Registered per-cpu bp/wp */
> +static DEFINE_PER_CPU(struct perf_event *, pcpu_hw_bp_events[RISCV_HW_BP=
_NUM_MAX]);
> +static DEFINE_PER_CPU(unsigned long, ecall_lock_flags);

[Severity: High]
Does defining ecall_lock_flags as a global per-CPU variable cause IRQ state
corruption? The raw_spin_lock_irqsave() macro expects a local stack variable
to save the IRQ state, but this variable is shared globally across the CPU.

> +static DEFINE_PER_CPU(raw_spinlock_t, ecall_lock);
[ ... ]
> +int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
> +{
> +	unsigned int len;
> +	unsigned long va;
> +
> +	va =3D hw->address;
> +	len =3D hw->len;
> +
> +	return (va >=3D TASK_SIZE) && ((va + len - 1) >=3D TASK_SIZE);

[Severity: Medium]
For execute breakpoints, len is 0. Does va + len - 1 underflow, causing the
bounds check to wrap around when added to a 64-bit kernel address? This
might evaluate to less than TASK_SIZE and erroneously return false.

> +}
[ ... ]
> +static int hw_breakpoint_handler(struct die_args *args)
> +{
> +	int ret =3D NOTIFY_DONE;
> +	struct arch_hw_breakpoint *bp;
> +	struct perf_event *event;
> +	int i;
> +
> +	for (i =3D 0; i < dbtr_total_num; i++) {
> +		event =3D this_cpu_read(pcpu_hw_bp_events[i]);
> +		if (!event)
> +			continue;
> +
> +		bp =3D counter_arch_bp(event);
> +		switch (bp->type) {
> +		/* Breakpoint */
> +		case HW_BREAKPOINT_X:
> +		{
> +			bool hit =3D bp->address =3D=3D args->regs->epc;
> +
> +			if (!hit && dbtr_type =3D=3D RISCV_DBTR_TRIG_MCONTROL6)
> +				hit =3D mc6_read_and_clear_hit(i) !=3D RISCV_DBTR_MC6_HIT_FALSE;

[Severity: High]
If the address matches, this short-circuit logic prevents calling
mc6_read_and_clear_hit(i). Does skipping this leave the hardware hit bit
stuck at 1, causing endless spurious traps on unrelated exceptions?

> +
> +			if (hit) {
> +				perf_bp_event(event, args->regs);
> +				ret =3D NOTIFY_STOP;
> +			}
> +			break;
> +		}
[ ... ]
> +			if (dbtr_type =3D=3D RISCV_DBTR_TRIG_MCONTROL) {
> +				unsigned long tdata1;
> +				struct sbiret sret;
> +				union sbi_dbtr_shmem_entry *shmem;
> +
> +				raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> +						      *this_cpu_ptr(&ecall_lock_flags));

[Severity: High]
If a synchronous exception like a hardware breakpoint occurs while ecall_lo=
ck
is already held, this trap handler will attempt to acquire the exact same
non-recursive local lock and overwrite ecall_lock_flags. Could this result
in an immediate inescapable deadlock?

> +				shmem =3D this_cpu_ptr(sbi_dbtr_shmem);
> +				sret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_READ,
> +						 i, 1, 0, 0, 0, 0);
> +				if (!sret.error) {
> +					tdata1 =3D le_to_cpu(shmem->data.tdata1);
> +					hit =3D !!(tdata1 & RISCV_DBTR_MC_HIT_BIT_MASK);

[Severity: High]
For MCONTROL triggers, the hit bit is read here, but it doesn't appear to be
cleared in tdata1 or updated via SBI_EXT_DBTR_TRIG_UPDATE. Does this leave
the hardware state corrupted with the hit bit permanently set?

> +				}
> +				raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> +							   *this_cpu_ptr(&ecall_lock_flags));
> +			}
[ ... ]
> +/* atomic: counter->ctx->lock is held */
> +int arch_install_hw_breakpoint(struct perf_event *event)
> +{
> +	struct arch_hw_breakpoint *bp =3D counter_arch_bp(event);
> +	union sbi_dbtr_shmem_entry *shmem =3D this_cpu_ptr(sbi_dbtr_shmem);
> +	struct sbi_dbtr_data_msg *xmit;
> +	struct sbi_dbtr_id_msg *recv;
> +	struct perf_event **slot;
> +	unsigned long idx;
> +	struct sbiret ret;
> +	int err =3D 0;
> +
> +	raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> +			      *this_cpu_ptr(&ecall_lock_flags));
> +
> +	xmit =3D &shmem->data;
> +	recv =3D &shmem->id;
> +	xmit->tdata1 =3D cpu_to_le(bp->tdata1);
> +	xmit->tdata2 =3D cpu_to_le(bp->tdata2);
> +	xmit->tdata3 =3D cpu_to_le(bp->tdata3);

[Severity: Medium]
Because shmem->id and shmem->data share the same memory via a union, does
xmit->tstate need to be initialized here? Otherwise, it might retain the
trigger index from previous recv->idx calls and pass uninitialized garbage
to the hypervisor as the trigger configuration state.

> +
> +	ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_INSTALL,
> +			1, 0, 0, 0, 0, 0);
> +
> +	if (ret.error) {
> +		pr_warn("Failed to install trigger\n");
> +		err =3D sbi_err_map_linux_errno(ret.error);
> +		goto done;
> +	}
> +
> +	idx =3D le_to_cpu(recv->idx);
> +	if (idx >=3D dbtr_total_num) {
> +		pr_warn("Invalid trigger index %lu\n", idx);
> +		err =3D -EINVAL;
> +		goto done;

[Severity: Medium]
If this software validation fails, the error path jumps to done without
issuing an SBI_EXT_DBTR_TRIG_UNINSTALL. Does this permanently leak the
successfully allocated hardware trigger?

> +	}
> +
> +	slot =3D this_cpu_ptr(&pcpu_hw_bp_events[idx]);
> +	if (*slot) {
> +		pr_warn("Slot %lu is in use\n", idx);
> +		err =3D -EBUSY;
> +		goto done;

[Severity: Medium]
Similarly, does this slot check also bail out without cleaning up the
hardware state, causing a trigger leak?

> +	}
[ ... ]
> +/* atomic: counter->ctx->lock is held */
> +void arch_uninstall_hw_breakpoint(struct perf_event *event)
> +{
> +	struct sbiret ret;
> +	int i;
> +
> +	raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> +			      *this_cpu_ptr(&ecall_lock_flags));
> +
> +	for (i =3D 0; i < dbtr_total_num; i++) {
> +		struct perf_event **slot =3D this_cpu_ptr(&pcpu_hw_bp_events[i]);
> +
> +		if (*slot =3D=3D event) {
> +			*slot =3D NULL;
> +			break;
> +		}
> +	}

[Severity: Medium]
Does clearing the software slot before uninstalling the hardware trigger
open a dangerous race window? If a kernel watchpoint fires right here before
SBI_EXT_DBTR_TRIG_UNINSTALL completes, the handler will observe a NULL slot
and return NOTIFY_DONE, causing handle_break() to crash the system with an
unhandled DIE_DEBUG trap.

> +
> +	if (i =3D=3D dbtr_total_num) {
> +		pr_warn("Breakpoint not installed.\n");
> +		goto out;
> +	}
> +
> +	ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UNINSTALL,
> +			i, 1, 0, 0, 0, 0);
[ ... ]
> +void arch_update_hw_breakpoint(struct perf_event *event)
> +{
> +	struct arch_hw_breakpoint *bp =3D counter_arch_bp(event);
> +	union sbi_dbtr_shmem_entry *shmem =3D this_cpu_ptr(sbi_dbtr_shmem);
> +	struct sbi_dbtr_data_msg *xmit;
> +	struct sbi_dbtr_id_msg *id;
> +	struct perf_event **slot;
> +	struct sbiret ret;
> +	int i;
[ ... ]
> +	raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> +			      *this_cpu_ptr(&ecall_lock_flags));
> +
> +	id =3D &shmem->id;
> +	xmit =3D &shmem->data;
> +	id->idx =3D cpu_to_le(i);
> +	xmit->tdata1 =3D cpu_to_le(bp->tdata1);

[Severity: High]
Writing to id->idx and xmit->tdata1 here accesses the same shared memory un=
ion.
Does writing to id->idx corrupt the aliased xmit->tstate before it is sent =
to
the hypervisor?

> +	xmit->tdata2 =3D cpu_to_le(bp->tdata2);
> +	xmit->tdata3 =3D cpu_to_le(bp->tdata3);
> +
> +	ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UPDATE,
> +			1, 0, 0, 0, 0, 0);

[Severity: High]
Are we invoking the update call with a hardcoded zero count in a1? This see=
ms
like it would make the update a hardware no-op and cause breakpoint updates
to silently fail.

> +	if (ret.error)
> +		pr_warn("Failed to update trigger %d.\n", i);
[ ... ]
> +static int __init arch_hw_breakpoint_init(void)
> +{
[ ... ]
> +	/* Allocate per-cpu shared memory */
> +	sbi_dbtr_shmem =3D __alloc_percpu(sizeof(*sbi_dbtr_shmem) * dbtr_total_=
num,
> +					PAGE_SIZE);
> +
> +	if (!sbi_dbtr_shmem) {
> +		pr_warn("Failed to allocate shared memory.\n");
> +		rc =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Hotplug handler to register/unregister shared memory with SBI */
> +	rc =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +			       "riscv/hw_breakpoint:prepare",
> +			       arch_smp_setup_sbi_shmem,
> +			       arch_smp_teardown_sbi_shmem);
> +
> +	if (rc < 0) {
> +		pr_warn("Failed to setup CPU hotplug state\n");
> +		free_percpu(sbi_dbtr_shmem);
> +		return rc;
> +	}

[Severity: High]
If cpuhp_setup_state() fails, we free sbi_dbtr_shmem. However, since the PMU
has already been registered earlier in the generic subsystem, can users sti=
ll
create hardware breakpoints and cause a use-after-free when they access the
freed sbi_dbtr_shmem?

> + out:
> +	return rc;

[Severity: Low]
When cpuhp_setup_state() succeeds, it returns a positive state ID which is
stored in rc. Should this initcall return 0 on success to avoid the initcall
core logging an erroneous failure message?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930063919.6089=
11-1-himanshu.chauhan@oss.qualcomm.com?part=3D1
