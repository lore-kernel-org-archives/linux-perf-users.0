Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71F133F59B
	for <linux-perf-users@vger.kernel.org>; Sat,  9 May 2026 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334798; cv=none; b=kYfdCIhJjFVkDf6/9UPTtwVCafU4eHeVQ+tEbrKAofyMlGl21qRbOVR+HjpmWhPB3YtvRyhMBuusZiVtYi1TUrOWMcTHdFjjnBdzLPlNDIXYYMmPqdVW/aKAhmeNu0IR3y5BAjC7gS/hzIwOvaV+mglPwOoeHjK+Yqhatv9cON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334798; c=relaxed/simple;
	bh=AupdPsMxyFJmEDxXQnNzUARxbICHIQvTsuD6QC4mcQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=txshDTd7+XE8E2rF0Wfi5va7BHjDQUVMEv5Dtpjr4c3rv7jqIp1CkuRvtzDELuYyP2UHIDvLfg72qDMQEL+rx/g/Op+DMBf/bwr+O0IJ/6tKiUnBKSjp2cGxpJXop3f3+u+inh7/Ycinr24oK2yHq5oyiOxkWC2x9nd+GQhikGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTsIGKXi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTsIGKXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6F9C2BCB2;
	Sat,  9 May 2026 13:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778334798;
	bh=AupdPsMxyFJmEDxXQnNzUARxbICHIQvTsuD6QC4mcQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sTsIGKXixghYcoyP7DXZ1L/CwF/H/Ehc8iz2joWd4msn7HPhPDvSDNJmDousXxz3e
	 PzvHzuG1KPQXNsOjRWMe21gnK9jSZaYMOukw1MLQ+pxtXhmZSbOSOLabPq3fFjLM76
	 /QjDMyewAR15HwPZQG2oMPc+36OVYbCGSRT2UyaXCwbENYuE0CifPMVLTfDPF126iT
	 pDFgac0Xz59kZRcXRSIEFiZCt781c1qD9NEZxKoEZ7TszvQ6GjGQVTF7LxpFIVUWFr
	 YNzKasCVLBqY8a1pTyNWEqn4Bj/PKx7m2HreFXedpSTuOhsOEoBrJGx+jz6AILQRu0
	 tGL+/oB90RvOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/5] riscv: add support for SBI Supervisor Software
 Events extension
Reply-To: sashiko@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <45918ddc68df98ec25ac93c0bbab7da90a4ecbf9.1778331862.2.git.zhangzhanpeng.jasper@bytedance.com>
References: <45918ddc68df98ec25ac93c0bbab7da90a4ecbf9.1778331862.2.git.zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 13:53:17 +0000
Message-Id: <20260509135318.4A6F9C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Uninitialized loop counter `t3` in the slow path causes out-of=
-bounds memory access and incorrect context tracking.
- [Critical] `__sbi_sse_entry_task` is uninitialized for the boot CPU, lead=
ing to a NULL pointer dereference.
- [High] `stack_pointer_to_alloc()` performs blind pointer arithmetic on `N=
ULL`, causing a kernel crash during error cleanup.
- [High] Missing signal delivery interrupt simulation described in the comm=
it message.
- [High] Data truncation of `interrupted_phys` corrupts physical memory on =
32-bit systems with 64-bit physical addresses.
- [High] Missing TLB flush for vmap-backed Shadow Call Stack risks vmalloc =
faults in NMI context.
- [High] Kernel silently drops modifications to `a6` and `a7` registers, br=
eaking kernel ABIs.
- [Medium] Truncation of `hart_id` to 32 bits and sign extension breaks the=
 fast path for large hart IDs.
--

commit 984b54245d1919f79774c39971ea6d6896737561
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
Subject: riscv: add support for SBI Supervisor Software Events extension

This commit introduces support for the SBI Supervisor Software Events (SSE)
extension on RISC-V. It allows the supervisor software to handle non-maskab=
le
events dispatched by the SBI, tracking context via an additional per-cpu
array to safely handle interruptions.

The commit message states:
"simulate an interrupt exception by setting IE_SIE in CSR_IP to allow
delivery of signals to user task."

Looking at do_sse() and handle_sse(), there doesn't appear to be any logic
that checks if interrupts were enabled or writes to CSR_IP/CSR_SIP. Because
handle_sse() completes via an SBI call and returns directly to the
interrupted context, will signals queued during the handler (such as a
SIGBUS) fail to be delivered until an unrelated hardware interrupt occurs?

> diff --git a/arch/riscv/include/asm/sse.h b/arch/riscv/include/asm/sse.h
> index 0000000000000..d3ce8c2b52212
> --- /dev/null
> +++ b/arch/riscv/include/asm/sse.h
[ ... ]
> +struct sse_event_arch_data {
> +	void *stack;
> +	void *shadow_stack;
> +	unsigned long tmp;
> +	struct sse_event_interrupted_state interrupted;
> +	unsigned long interrupted_phys;

On 32-bit systems with 64-bit physical addresses (Sv32), virt_to_phys()
returns a 64-bit phys_addr_t. Does assigning it to an unsigned long truncate
the upper 32 bits, causing the SBI firmware to read the interrupted state
from the wrong physical address when passed to sbi_ecall() in do_sse()?

> +	u32 evt_id;
> +	unsigned int hart_id;

Since RISC-V hart IDs are 64-bit (unsigned long), will storing this as a
32-bit unsigned int cause issues?

In sbi_sse_entry.S, this is loaded using lw which sign-extends the value. If
a hart ID has bit 31 set, it will become a negative 64-bit value and never
match the true 64-bit hart ID passed by SBI in a6, unnecessarily forcing the
slow path.

> +	unsigned int cpu_id;
> +};
[ ... ]
> diff --git a/arch/riscv/kernel/sbi_sse.c b/arch/riscv/kernel/sbi_sse.c
> index 0000000000000..f30ae9ff77c97
> --- /dev/null
> +++ b/arch/riscv/kernel/sbi_sse.c
[ ... ]
> +DEFINE_PER_CPU(struct task_struct *, __sbi_sse_entry_task);

Is it possible for an unmaskable SSE event to fire before the first context
switch? Since __sbi_sse_entry_task defaults to NULL and is only updated
during a context switch, the boot CPU or secondary idle tasks might not have
this initialized. Could this lead to a NULL pointer dereference when NMI
context attempts to access current via tp?

> +
> +void __weak sse_handle_event(struct sse_event_arch_data *arch_evt, struc=
t pt_regs *regs)
> +{
> +}
> +
> +void do_sse(struct sse_event_arch_data *arch_evt, struct pt_regs *regs)
> +{
> +	nmi_enter();
> +
> +	/* Retrieve missing GPRs from SBI */
> +	sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, arch_evt->evt_id,
> +		  SBI_SSE_ATTR_INTERRUPTED_A6,
> +		  (SBI_SSE_ATTR_INTERRUPTED_A7 - SBI_SSE_ATTR_INTERRUPTED_A6) + 1,
> +		  arch_evt->interrupted_phys, 0, 0);
> +
> +	memcpy(&regs->a6, &arch_evt->interrupted, sizeof(arch_evt->interrupted)=
);
> +
> +	sse_handle_event(arch_evt, regs);

If a kernel subsystem like ptrace or a signal handler modifies regs->a6
or regs->a7 during sse_handle_event(), are those changes lost?

The SBI firmware restores the interrupted context's a6 and a7 from its
internal state, but it looks like we only read these attributes here and
never execute SBI_SSE_EVENT_ATTR_WRITE to sync any modifications back.

> +
> +	nmi_exit();
> +}
> +
> +static void *alloc_to_stack_pointer(void *alloc)
> +{
> +	return alloc ? alloc + SSE_STACK_SIZE : NULL;
> +}
> +
> +static void *stack_pointer_to_alloc(void *stack)
> +{
> +	return stack - SSE_STACK_SIZE;

If arch_sse_free_event() is called to clean up after a partial initializati=
on
failure, arch_evt->stack could be NULL. Does subtracting SSE_STACK_SIZE
from NULL create an invalid pointer that could cause a crash when passed
to vfree() or kfree()?

> +}
[ ... ]
> +static void arch_sse_stack_cpu_sync(struct sse_event_arch_data *arch_evt)
> +{
> +	void *p_stack =3D arch_evt->stack;
> +	unsigned long stack =3D (unsigned long)stack_pointer_to_alloc(p_stack);
> +	unsigned long stack_end =3D stack + SSE_STACK_SIZE;
> +
> +	/*
> +	 * Flush the tlb to avoid taking any exception when accessing the
> +	 * vmapped stack inside the SSE handler
> +	 */
> +	if (sse_event_is_global(arch_evt->evt_id))
> +		flush_tlb_kernel_range(stack, stack_end);
> +	else
> +		local_flush_tlb_kernel_range(stack, stack_end);
> +}

This function flushes the TLB for the vmap-backed arch_evt->stack to avoid
taking a vmalloc exception inside the non-reentrant SSE handler.

However, when Shadow Call Stack is enabled, scs_alloc() also allocates a
vmap-backed stack. Does arch_evt->shadow_stack need a similar TLB flush to
prevent vmalloc faults when pushing return addresses?

[ ... ]
> diff --git a/arch/riscv/kernel/sbi_sse_entry.S b/arch/riscv/kernel/sbi_ss=
e_entry.S
> index 0000000000000..59ec62607adcb
> --- /dev/null
> +++ b/arch/riscv/kernel/sbi_sse_entry.S
[ ... ]
> +#ifdef CONFIG_SMP
> +.Lfind_hart_id_slowpath:
> +
> +	/* Restore current task struct from __sbi_sse_entry_task */
> +	li t1, ASM_NR_CPUS
> +	/* Slowpath to find the CPU id associated to the hart id */
> +	la t0, __cpuid_to_hartid_map

Should t3 be initialized to 0 here before the loop begins?

If the fastpath check fails earlier, t3 retains its previous value from
arch_evt->cpu_id. When a match is found at index N during the loop, the
calculated CPU ID would be arch_evt->cpu_id + N instead of N. Could this
incorrect index lead to an out-of-bounds pointer being loaded into tp?

> +
> +.Lhart_id_loop:
> +	REG_L t2, 0(t0)
> +	beq t2, a6, .Lcpu_id_found
> +
> +	/* Increment pointer and CPU number */
> +	addi t3, t3, 1
> +	addi t0, t0, RISCV_SZPTR
> +	bltu t3, t1, .Lhart_id_loop

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1778331862.gi=
t.zhangzhanpeng.jasper@bytedance.com?part=3D2
