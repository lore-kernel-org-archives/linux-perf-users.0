Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092349;
	b=H+/IpWG+0lTgNEOnsfHVdzR1jgOv6tJMF1rQMwZ343sbCDxKkNR89U041qSLTXfnY9eL
	 F2UM9TGUWUDLmy9325AP8wR+3c8Yzj487rzhhUelfGfXR16i0fvKsFoKF0cVCELQlqm4G
	 DvalsgJzhbKrGXbrURJP+werHml+mJE/PI62KkDR6UKhOJaqdSP7aJKCqVts+9HZvtcUH
	 hFRUISyY8gWi2uZZUwjA/tN1viPPVDZjwtJutFbdnLV1QpRZWFwL1j+EArfe+tHlHfxIV
	 lzZhTxnOWMIbmNILccSQQrtDdKlnDP64U+B6NKtdLzo68i1n6FqR2O2qeou8ghuL3YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092349;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3BA0Xi6Ht+zQ+hrw6PXt3gZm/G4V9h+f/LVTeYZAWZc=;
	b=ZKFr0gN5bmZRGW/8mCM77e3om1Jr3wWTHAGNDJsgU0qCnXQxIDjeet70QGbXWOu6lIbR
	 UQOZKnnuA9n0UlziSVnoF/hitbgOnk+opCwxqj9NXyeu5bbSRQA2AgqTsUdPraaQbMKY7
	 fSPnBNSSicF7M736d1635wrMMgTXeJZtvEsQZ4YoixNiC6X4m5LDjkcWLBYDbYM8YCIMb
	 eSHNOdcSIhu+OYI1wvPmNpTcHoQDo2e4HHATC1xK5THCSLBYR7r8D9gO7jp15p7TMyVGv
	 GU1uZ9QbcDSBnn8AFoXCs/bzULEmHUQFCYNUwohGTm28BfBHN6+iB4TiblvsqQMp0gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvVpz4s0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B408606A326
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvVpz4s0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23BF1F000C4;
	Thu, 19 Nov 2026 12:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795092348;
	bh=3BA0Xi6Ht+zQ+hrw6PXt3gZm/G4V9h+f/LVTeYZAWZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CvVpz4s0ANcwUyUd3Z/0qZxuCsDrpYdedFJ+Fm2iB7dgj6Pq/goZ2sH64v5Ql/PPX
	 h0N4i15Z1ee6iWXiKUqZGHwxfIZtVpFDaYxJgBdxUw4s5yjenxymAPKhF/S3JpXxLX
	 aoqwqTWlNgHOoqn9Z4LN1yTdg8NFVEM2YpB8tgZNVUPPC/KgzwtjA4pOpkYv95qhfW
	 EBMkLhEkKm+ijPeLiKHib74R2IZtwygAmlhYStO8jzsoeHn7OT9HQUVFIIBjA3+T63
	 da9XAp8O1JDTPmf1AkER8z5wvPDsFuD3uosn3k/esvw6E2sjZnirgg4q+zjDUch5Sa
	 sGf6klp8/rSmw==
Message-ID: <sashiko-outbox-223113@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 07/11] perf: RISC-V: support callchains with SSE
 delivery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119120824.13969-20-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
 <20261119120824.13969-20-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:45:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] perf: riscv: missing sse_callchain_is_guest() check in
  riscv_perf_out_copy_user()
- [High] perf: riscv: missing current->mm and CSR_SATP checks in
  perf_callchain_user()
- [High] perf: riscv: unsafe entry unwind and stack OOB read in
  sse_kernel_regs_safe()
- [High] perf: riscv: NULL task pointer passed to walk_stackframe()
  crashes in fgraph
- [High] perf: riscv: NULL current->mm dereference in
  riscv_perf_out_copy_user()
--

commit 6c97040a7b3339404ccd87297e5e59c6632d3219
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

perf: RISC-V: support callchains with SSE delivery

This commit adds perf kernel, frame-pointer user, and DWARF user-stack
callchain sampling support on RISC-V when PMU overflow events are
delivered via SBI Supervisor Software Events (SSE).

Link: https://lore.kernel.org/r/as79MHtNYd-VbUug@hu-himchau-blr.qualcomm.co=
m/

> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_=
callchain.c
> index b465bc9eb870e..216f5bd14c001 100644
> --- a/arch/riscv/kernel/perf_callchain.c
> +++ b/arch/riscv/kernel/perf_callchain.c

[ ... ]

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
Can sse_kernel_regs_safe() accept an entry/exit frame where s0 is not a
valid frame pointer and cause walk_stackframe() to read past the top of
the task stack?

In ret_from_exception, sp points to task_pt_regs(current) (stack +
THREAD_SIZE - PT_SIZE_ON_STACK) and s0 (fp) is set to stack +
THREAD_SIZE:

arch/riscv/kernel/entry.S:ret_from_exception {
    ...
	/* Save unwound kernel stack pointer in thread_info */
	addi s0, sp, PT_SIZE_ON_STACK
	REG_S s0, TASK_TI_KERNEL_SP(tp)
    ...
}

Because sse_addr_on_task_stack() allows fp - sizeof(struct stackframe)
all the way up to stack + THREAD_SIZE, an SSE interrupting this window
passes sse_kernel_regs_safe().  Under CONFIG_FRAME_POINTER,
walk_stackframe() then reads frame =3D (struct stackframe *)fp - 1 (the
last two words of task_pt_regs(current), cause and orig_a0), advances sp
=3D fp =3D stack + THREAD_SIZE, and sets pc =3D frame->ra (pt_regs->orig_a0=
).
If orig_a0 falls in [handle_exception, ret_from_exception_end),
walk_stackframe() dereferences ((struct pt_regs *)sp)->epc at stack +
THREAD_SIZE, hitting the unmapped CONFIG_VMAP_STACK guard page.

Entry and exit windows in [handle_exception, ret_from_exception_end) also
leave s0 holding the user s0 register or sp + PT_SIZE_ON_STACK while sp
is already on the kernel stack.  Rejecting PCs in [handle_exception,
ret_from_exception_end) and requiring fp <=3D (unsigned
long)task_pt_regs(current) would avoid unwinding these windows.

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
> +	/* A guest stack cannot be walked using the host address space. */
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
Does passing NULL as the task argument to walk_stackframe() here (and in
perf_callchain_kernel() below) cause a NULL pointer dereference when
function_graph tracing is active?

When regs is non-NULL, walk_stackframe() takes the if (regs) branch and
leaves task as NULL, then passes task to ftrace_graph_ret_addr():

arch/riscv/kernel/stacktrace.c:walk_stackframe() {
    ...
			fp =3D READ_ONCE_TASK_STACK(task, frame->fp);
			pc =3D READ_ONCE_TASK_STACK(task, frame->ra);
			pc =3D ftrace_graph_ret_addr(task, &graph_idx, pc,
						   &frame->ra);
    ...
}

When an unwound frame's return address is return_to_handler,
ftrace_graph_ret_addr() evaluates task->curr_ret_stack without a NULL
check, panicking in SSE context.  Passing current (or defaulting task to
current in walk_stackframe() when task is NULL) avoids this.

[ ... ]

> +unsigned long riscv_perf_out_copy_user(void *dst, const void *src,
> +				       unsigned long n)
> +{
> +	unsigned long ret;

[ ... ]

> +	if (riscv_sse_get_interrupted_context()) {
> +		if (!access_ok(src, n))
> +			return n;
> +		if (!current->mm ||
> +		    (csr_read(CSR_SATP) & SATP_PPN) !=3D virt_to_pfn(current->mm->pgd))
> +			return n;
> +	}

[Severity: High]
Should riscv_perf_out_copy_user() also reject interrupted KVM guest
contexts with sse_callchain_is_guest(context), the same way
sse_callchain_kernel() and perf_callchain_user() do?

On RISC-V with the Hypervisor extension, guest stage-1 and stage-2
translations use CSR_VSATP and CSR_HGATP while the host HS-mode CSR_SATP
stays loaded with the host VMM task's current->mm->pgd across
__kvm_riscv_switch_to().  When an SSE PMU overflow traps from a running
guest into HS-mode, current->mm is non-NULL and (csr_read(CSR_SATP) &
SATP_PPN) =3D=3D virt_to_pfn(current->mm->pgd) still holds, so
riscv_perf_out_copy_user() copies from the host VMM user address space at
the guest's sp into the perf ring buffer.

> +
> +	pagefault_disable();
> +	ret =3D __copy_from_user_inatomic(dst, src, n);
> +	pagefault_enable();
> +
> +	return ret;
> +}
> +#endif

[Severity: High]
Can calling access_ok() and __copy_from_user_inatomic() before verifying
current->mm !=3D NULL dereference a NULL current->mm under
CONFIG_RISCV_ISA_SUPM?

On RISC-V, both access_ok() and raw_copy_from_user() expand
untagged_addr(), which passes current->mm to __untagged_addr_remote() and
dereferences mm->context.pmlen when RISCV_ISA_EXT_SUPM is active.  If a
perf sample hits a user task in do_exit() after exit_mm() has cleared
current->mm (where perf_output_sample_ustack() still invokes
__output_copy_user() with size 0), riscv_perf_out_copy_user() calls
access_ok() before checking !current->mm in the SSE path, and never
checks !current->mm in the non-SSE path.

> +
>  /*
>   * This will be called when the target is in user mode
>   * This function will only be called when we use
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

[Severity: High]
When context is non-NULL, does perf_callchain_user() also need the
!current->mm and (csr_read(CSR_SATP) & SATP_PPN) !=3D
virt_to_pfn(current->mm->pgd) check from riscv_perf_out_copy_user()?

When an SSE event interrupts the kernel while current is a user task,
get_perf_callchain() substitutes task_pt_regs(current) and calls
perf_callchain_user().  If the SSE arrived during an address-space
transition such as context_switch() (after switch_mm_irqs_off() writes
next->mm->pgd to CSR_SATP before __switch_to() updates current) or
efi_virtmap_load(), arch_stack_walk_user() -> unwind_user_frame() copies
user stack frames from the wrong page tables, and if current->mm is NULL
(reachable via bpf_get_stackid(BPF_F_USER_STACK) in do_exit() after
exit_mm()), access_ok() in unwind_user_frame() dereferences NULL
current->mm->context.pmlen under CONFIG_RISCV_ISA_SUPM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119120824.1396=
9-13-zhangzhanpeng.jasper@bytedance.com?part=3D7
