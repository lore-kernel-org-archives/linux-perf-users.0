Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276426;
	b=i4R75vgnlWndeCYibGSIIyximsfGA/K77bNGRJqce7hD6lrPGTSuMFaWRePDbaZhpkZ9
	 /gNafiDhBSqSMpb0Bp9HO9edUyPjltMKeUc84rSpxdrL3cgZ3jgmvAvn0qZYyJHeb6Qju
	 Y7t9nZPo2a3gPmjZStlXI6HLgBqWVCA8TRF3b2EsMOuyYt8spP0dH838b6WPBjGKcocm0
	 tCD4YYiPJjWaSrlZg6d3FSYX3ObHE3ozHBjdt6/+T1HcHcL7k0I4tIujntr5L3HXtWdBT
	 YiN+ZMB0imuAG/5JPSgDM0oPOpAISwqDf82poGV1Kn/8KCxGVjLeuw/kZ/v1dXbqIPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276426;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ELqSdu0+LBGBh7vtdGF4EQIzyhB6GUgDxsxF9o2AlUs=;
	b=CBdsWepD11EzcNHFBET88LQCU2j3vv8F9+DN6+98Bh73x4vQTaoYmx3iR+Nsdd9KzgOw
	 geseWSn+SZkSoxPx2tCi3/Pv6wDifhzGqNisqDe8vlzjQbZulrz9G1V46VeXZKInSHoEa
	 VR79qrN0R/cifePsKhoYHV53T4xoxodu1vVSHbhXfXXIc7r95yHh9pIY78P4hUGaYxoSf
	 Z7E3xjw6yOfIA/EmEGXsKWiJidZgm0fEJ5tp6/0UYae73w9wGYqBbu+d6qTFPfxNuoNOZ
	 I5Zo2lTAIEGjDpf1tmXyzQNhMm6f3w6ppUm8au1TqgWe9q+0bJ+79GRYFfNQxZWqGiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=is4zlA3J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A16606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=is4zlA3J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041D51F01829;
	Thu, 29 Oct 2026 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793276426;
	bh=ELqSdu0+LBGBh7vtdGF4EQIzyhB6GUgDxsxF9o2AlUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=is4zlA3JTD+TmTappVcB48G78Es4/sRjvE3aWjaMMeLQKHf21JP+5IL2x6DsBu95o
	 5nquxH3A0ndTFOo9TU01y2aV0ZR2W5hFKCnCpvS89y+m8a4AZYBipSL/1Qw5jL4jV9
	 jh5omrI7/ZC+w3nTVZf6giOO74Y+hxX9pcg9mETkzcs1zIdLxPMmndaXDGosRdtuMl
	 2VSiNjgPaNdI1TKF1ySVmwGrlMa4Zwi840v0kh/d4c/U9G7zPt0A2QmioAKaWwWIyv
	 VDFBDg57Gce4tNa1SJ0Wpof3DUJVMpCVAl+2iBti6sB5rUI6Bsnk8d+2+gzo7Hvcas
	 bNz4K+zT7ZBug==
Message-ID: <sashiko-outbox-189275@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 07/11] perf: RISC-V: support callchains with SSE
 delivery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029074853.35467-8-zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
 <20261029074853.35467-8-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 12:20:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] perf: riscv: missing guest check in riscv_perf_out_copy_user()
- [High] perf: riscv: missing CSR_SATP check in perf_callchain_user()
- [High] perf: riscv: unsafe entry unwind and OOB read in sse_kernel_regs_s=
afe()
- [High] perf: riscv: NULL task dereference via walk_stackframe() in fgraph
- [High] perf: riscv: NULL mm dereference in riscv_perf_out_copy_user()
--

commit 1d4832e59d0c42c6027b431628d4fdd87c2373eb
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

perf: RISC-V: support callchains with SSE delivery

This commit adds callchain and raw user-stack sampling support on RISC-V wh=
en
PMU overflow events are delivered via SBI Supervisor Software Events (SSE).=
 It
validates the interrupted context before walking kernel or user stacks and
provides an SSE-aware riscv_perf_out_copy_user() helper.

Link: https://lore.kernel.org/r/as79MHtNYd-VbUug@hu-himchau-blr.qualcomm.co=
m/

> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_=
callchain.c
> index b465bc9eb870e..216f5bd14c001 100644
> --- a/arch/riscv/kernel/perf_callchain.c
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -11,6 +17,126 @@ static bool fill_callchain(void *entry, unsigned long=
 pc)
>  	return perf_callchain_store(entry, pc) =3D=3D 0;
>  }
> =20
> +#ifdef CONFIG_RISCV_SBI_SSE
> +static bool sse_addr_on_task_stack(unsigned long addr, unsigned long siz=
e)
> +{
> +	unsigned long end =3D addr + size;
> +	unsigned long stack;
> +
> +	if (end < addr)
> +		return false;
> +
> +	stack =3D (unsigned long)task_stack_page(current);
> +	if (addr >=3D stack && end <=3D stack + THREAD_SIZE)
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool sse_kernel_regs_safe(struct pt_regs *regs)
> +{
> +	unsigned long fp =3D frame_pointer(regs);
> +	unsigned long pc =3D instruction_pointer(regs);
> +	unsigned long sp =3D user_stack_pointer(regs);
> +
> +	if (!__kernel_text_address(pc))
> +		return false;
> +	if (!sse_addr_on_task_stack(sp, sizeof(unsigned long)))
> +		return false;
> +	if (fp < sizeof(struct stackframe))
> +		return false;
> +
> +	return sse_addr_on_task_stack(fp - sizeof(struct stackframe),
> +				      sizeof(struct stackframe));
> +}

[Severity: High]
Can sse_kernel_regs_safe() return true in sensitive entry windows where s0 =
is
not a valid kernel frame pointer, or when fp equals stack + THREAD_SIZE,
causing walk_stackframe() to read out of bounds past the end of the task
stack?

In arch/riscv/kernel/entry.S, once sp points to the kernel task stack, there
are three windows where s0 does not point to a valid struct stackframe:

1. In ret_from_exception when returning to userspace:

   addi s0, sp, PT_SIZE_ON_STACK
   REG_S s0, TASK_TI_KERNEL_SP(tp)

Here s0 (fp) is set to stack + THREAD_SIZE while sp is on the task stack.
Because [fp - sizeof(struct stackframe), fp] lies within
[stack, stack + THREAD_SIZE], sse_kernel_regs_safe() returns true.

In arch/riscv/kernel/stacktrace.c:walk_stackframe():

   frame =3D (struct stackframe *)fp - 1;
   sp =3D fp;
   ...
   if (pc >=3D (unsigned long)handle_exception &&
       pc < (unsigned long)&ret_from_exception_end) {
           if (unlikely(!fn(arg, pc)))
                   break;

           pc =3D ((struct pt_regs *)sp)->epc;
           fp =3D ((struct pt_regs *)sp)->s0;
   }

When fp is stack + THREAD_SIZE, frame aliases the end of task_pt_regs(curre=
nt)
(pt_regs->cause and pt_regs->orig_a0), and sp becomes stack + THREAD_SIZE. =
If
frame->ra (pt_regs->orig_a0, which is user-controlled a0 on a syscall) falls
in [handle_exception, ret_from_exception_end), walk_stackframe() dereferenc=
es
((struct pt_regs *)sp)->epc at stack + THREAD_SIZE, reading out of bounds i=
nto
the unmapped VMAP_STACK guard page in SSE context.

2. In handle_exception and ret_from_exception right after switching sp to t=
he
kernel stack (or before restoring user sp), s0 still holds the untrusted
userspace s0 value. If userspace sets s0 to an address within its kernel ta=
sk
stack range, sse_kernel_regs_safe() succeeds and walk_stackframe() unwinds
from the user-chosen kernel stack address.

3. In handle_exception on a trap from kernel mode, REG_L s0,
TASK_TI_USER_SP(tp) sets s0 to sp + PT_SIZE_ON_STACK before s0 is saved,
causing walk_stackframe() to interpret the top of the incomplete pt_regs as=
 a
stackframe.

Should sse_kernel_regs_safe() reject PCs in
[handle_exception, ret_from_exception_end) and require fp to be strictly be=
low
(unsigned long)task_pt_regs(current)?

> +
> +static bool sse_callchain_is_guest(const struct riscv_sse_interrupted_co=
ntext *context)
> +{
> +	return context && (context->hstatus & HSTATUS_SPV);
> +}
> +
> +static bool sse_callchain_kernel(struct perf_callchain_entry_ctx *entry,
> +				 struct pt_regs *regs)
> +{
> +	const struct riscv_sse_interrupted_context *context;
> +	unsigned long pc;
> +
> +	context =3D riscv_sse_get_interrupted_context();
> +	if (!context || context->regs !=3D regs)
> +		return false;
> +
> +	/* A guest stack cannot be walked using the host kernel address space. =
*/
> +	if (sse_callchain_is_guest(context))
> +		return true;
> +
> +	if (user_mode(regs))
> +		return true;
> +
> +	if (sse_kernel_regs_safe(regs)) {
> +		walk_stackframe(NULL, regs, fill_callchain, entry);
> +		return true;
> +	}

[Severity: High]
Does passing NULL as the task argument to walk_stackframe() in
sse_callchain_kernel() (and in perf_callchain_kernel()) cause a NULL pointer
dereference when function_graph tracing is active?

In arch/riscv/kernel/stacktrace.c:walk_stackframe(), when regs is non-NULL,
task is not initialized to current and remains NULL:

   if (regs) {
           fp =3D frame_pointer(regs);
           sp =3D user_stack_pointer(regs);
           pc =3D instruction_pointer(regs);
   } else if (task =3D=3D NULL || task =3D=3D current) {
           ...
   }
   ...
   fp =3D READ_ONCE_TASK_STACK(task, frame->fp);
   pc =3D READ_ONCE_TASK_STACK(task, frame->ra);
   pc =3D ftrace_graph_ret_addr(task, &graph_idx, pc,
                              &frame->ra);

When a stack frame's return address is hooked by function_graph
(ret =3D=3D return_handler), kernel/trace/fgraph.c:ftrace_graph_ret_addr()
evaluates:

   i =3D *idx ? : task->curr_ret_stack;

With *idx =3D=3D 0 and task =3D=3D NULL, this dereferences a NULL task poin=
ter in SSE
context. Should walk_stackframe() be called with current instead of NULL?

[ ... ]

> +unsigned long riscv_perf_out_copy_user(void *dst, const void *src,
> +				       unsigned long n)
> +{
> +	unsigned long ret;
> +

[ ... ]

> +	if (riscv_sse_get_interrupted_context()) {
> +		if (!access_ok(src, n))
> +			return n;
> +		if (!current->mm ||
> +		    (csr_read(CSR_SATP) & SATP_PPN) !=3D virt_to_pfn(current->mm->pgd))
> +			return n;
> +	}
> +
> +	pagefault_disable();
> +	ret =3D __copy_from_user_inatomic(dst, src, n);
> +	pagefault_enable();
> +
> +	return ret;
> +}
> +#endif

[Severity: High]
What prevents riscv_perf_out_copy_user() from copying host VMM user memory
when an SSE interrupts a running KVM guest?

The comment notes that comparing CSR_SATP against current->mm->pgd avoids
walking an unrelated address space after interrupting a KVM guest. However,=
 on
RISC-V with the H-extension, arch/riscv/kvm/vcpu.c:kvm_riscv_vcpu_enter_exi=
t()
switches hstatus, vsatp, and hgatp while leaving the host HS-mode CSR_SATP
loaded with the host VMM process's current->mm->pgd.

When an SSE with PERF_SAMPLE_STACK_USER interrupts a guest in VU-mode
(SR_PP =3D=3D 0) or VS-mode (SR_PP =3D=3D 1),
perf_prepare_sample()->perf_sample_regs_user() populates data->regs_user.re=
gs
(using the guest's regs->sp for VU-mode, or task_pt_regs(current) for
VS-mode), and perf_output_sample_ustack() calls riscv_perf_out_copy_user().
Because CSR_SATP still matches virt_to_pfn(current->mm->pgd), the check
passes and __copy_from_user_inatomic() reads host VMM user memory at the
guest-controlled stack pointer into the perf sample.

Should riscv_perf_out_copy_user() check sse_callchain_is_guest(context) just
like sse_callchain_kernel() and perf_callchain_user() do?

[Severity: High]
Additionally, in riscv_perf_out_copy_user(), can calling access_ok(src, n)
before checking !current->mm (or calling __copy_from_user_inatomic() outside
SSE context when current->mm is NULL) dereference a NULL current->mm when
CONFIG_RISCV_ISA_SUPM is enabled?

In arch/riscv/include/asm/uaccess.h, access_ok() and raw_copy_from_user()
invoke untagged_addr(addr), which passes current->mm to
__untagged_addr_remote():

   static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,=
 unsigned long addr)
   {
           if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM)) {
                   u8 pmlen =3D mm->context.pmlen;

If a user task is sampled in do_exit() after exit_mm() has set
current->mm =3D NULL while is_user_task(current) is still true,
perf_sample_regs_user() sets regs_user->regs =3D task_pt_regs(current) and
perf_output_sample_ustack()->__output_copy_user() calls
riscv_perf_out_copy_user(dst, src, 0), dereferencing current->mm->context.p=
mlen
before reaching the !current->mm check.

[ ... ]

> @@ -28,6 +154,15 @@ static bool fill_callchain(void *entry, unsigned long=
 pc)
>  void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>  			 struct pt_regs *regs)
>  {
> +#ifdef CONFIG_RISCV_SBI_SSE
> +	const struct riscv_sse_interrupted_context *context;
> +
> +	context =3D riscv_sse_get_interrupted_context();
> +	/* A guest stack cannot be walked using the host address space. */
> +	if (sse_callchain_is_guest(context))
> +		return;
> +#endif
> +
>  	if (perf_guest_state()) {
>  		/* TODO: We don't support guest os callchain now */
>  		return;

[Severity: High]
When perf_callchain_user() runs in SSE context, does it also need the
!current->mm and CSR_SATP page-table root check that riscv_perf_out_copy_us=
er()
performs?

When an SSE interrupts a user task executing in kernel mode
(!user_mode(regs) && is_user_task(current)),
kernel/events/callchain.c:get_perf_callchain() substitutes
regs =3D task_pt_regs(current) and calls
perf_callchain_user()->arch_stack_walk_user()->unwind_user_frame(), which c=
alls
access_ok() and __copy_from_user_inatomic().

Because SSE can interrupt kernel regions where IRQs are disabled, CSR_SATP =
or
current->mm may not match the current user task: for example, in
context_switch() after switch_mm_irqs_off() loads next->mm->pgd into CSR_SA=
TP
before __switch_to() updates tp and __sbi_sse_entry_task, during
efi_virtmap_load() when CSR_SATP points to efi_mm.pgd, or in do_exit() after
exit_mm() sets current->mm to NULL. Without checking !current->mm and CSR_S=
ATP
in perf_callchain_user(), unwind_user_frame() can walk the wrong address sp=
ace
or dereference a NULL current->mm in access_ok().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029074853.3546=
7-1-zhangzhanpeng.jasper@bytedance.com?part=3D7
