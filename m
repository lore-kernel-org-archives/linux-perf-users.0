Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD9476065
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130110; cv=none; b=Qp2FotYZUbmx85aBXX8ODg7mOhrNyZyjcfVKIMJDAV3PYWyvqDbMWXqX54d3Iz5OVPL0oDQkP1DRGD37xT0/xop/Qa5A/OpOZ97Xp12veWu71l8hBkTWFv5kgQXmK2JOVFKzDNQV0Kk9BGGu2AXcvsA4/r4rVYoa64D0eAxFd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130110; c=relaxed/simple;
	bh=qCeTDMNlOFdnV9gp6ZhHSuzYL6SvxIJcUIL4gz1szfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o76hV8qtawW9egV9QzjqarfRt1q/B5re7yvwEJqIuonr9K7jVuITopD9wv1aEtVpCHPVX1mhT3eer63NAOHCM7wUHp17PPmGJrgrmsLRIHD3jab8M9ArV7UVsM6lf110fqUHSWe0tb/2lQa7QZ1Qflx9RSVNgIfGeqhYC8uXQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2etB/6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2etB/6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA301F00893;
	Fri, 11 Sep 2026 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130108;
	bh=1FmvR77tz+cXcmT1WA3hB6TRJU5zszkXUgNLtAY5TPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e2etB/6uwNlsTl7sZ6HTTq76o/PUV/3lN8v49ihxvaDAc+zu/qvoGqMZKHRHff/XC
	 WQ7yXt3X5bfYtTuZ7abykkG9kslykphJx44Qfx1cjWJVY29EvpRpw2jcFH5hshOAv+
	 GO4za4DUap4xVpJphS4/ZXfM7p2hJjAEV5ILoBZ2ieqpLI2KHsTM8ICcakVtG5r12w
	 dZwPakI4U/sS8Xvp+fWZ4vZofQZggQDL3iXFwbFL4IIUpxHyCM50FqHifLoZbeQlXz
	 wToEoUPTbdXyTyb8SBV4sWPLpmCGnddIVEzLNmG7TzDnX1M1Mk8PY7JspmEUkLhqcw
	 +rriy2fpHuuLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/9] perf: RISC-V: support callchains with SSE
 delivery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260911121456.33223-7-zhangzhanpeng.jasper@bytedance.com>
References: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
 <20260911121456.33223-7-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:35:08 +0000
Message-Id: <20260911123508.ABA301F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Kernel callchains for SSE PMU events are incorrectly disabled when=
 CONFIG_FRAME_POINTER is not set.
- [High] arch_stack_walk_user still uses __copy_from_user_inatomic, trigger=
ing exception-table handled hardware page faults from the SSE handler conte=
xt.

Pre-existing issues:
- [High] Missing access_ok() check in the non-SSE fast path allows dumping =
arbitrary kernel memory.
--

commit 43924918205cbb887aeaebe13586db0a4ccfaa5d
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

perf: RISC-V: support callchains with SSE delivery

This commit adds support for perf callchains through the RISC-V SSE PMU
overflow delivery. It attempts to provide a non-faulting user memory copy
for DWARF stacks and restricts kernel stack walks when interrupted contexts
are not safe.

> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_=
callchain.c
> index b465bc9eb870e..ec75689c7aecb 100644
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
Does this code silently break kernel callchains for kernels compiled without
CONFIG_FRAME_POINTER?

When an SSE PMU overflow occurs, sse_kernel_regs_safe() unconditionally rea=
ds
frame_pointer(regs) and verifies it falls within the task's stack bounds. If
CONFIG_FRAME_POINTER is disabled, s0 is a general-purpose register containi=
ng
arbitrary values, causing the bounds check to fail and the stack walk to be
discarded.

The non-frame-pointer implementation of walk_stackframe() unwinds sequentia=
lly
using only sp and pc, so enforcing a valid fp seems unnecessary and breaks =
the
heuristic stack walker.

[ ... ]
> +unsigned long riscv_perf_out_copy_user(void *dst, const void *src,
> +				       unsigned long n)
> +{
> +	unsigned long addr =3D (unsigned long)src;
> +	unsigned long copied =3D 0;
> +
> +	/* Keep the generic fast path unchanged outside an SSE handler. */
> +	if (!riscv_sse_get_interrupted_context()) {
> +		unsigned long ret;
> +
> +		pagefault_disable();
> +		ret =3D __copy_from_user_inatomic(dst, src, n);
> +		pagefault_enable();
> +		return ret;
> +	}

[Severity: High]
This is a pre-existing issue, but does this missing access_ok() check in the
non-SSE fast path allow arbitrary kernel memory reads?

If riscv_sse_get_interrupted_context() returns false, the function directly
calls __copy_from_user_inatomic() without verifying access_ok(src, n). On
RISC-V, this translates to raw_copy_from_user(), which executes loads in
supervisor mode.

Since supervisor mode has inherent read access to kernel pages, the loads
succeed regardless of the SUM bit. A malicious user could craft a perf event
with PERF_SAMPLE_STACK_USER, spoof their regs->sp to a kernel address, and
trigger a PMU interrupt to dump kernel memory into the perf ring buffer.

[ ... ]
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
>  	}
> =20
>  	arch_stack_walk_user(fill_callchain, entry, regs);
>  }

[Severity: High]
Is it safe to invoke arch_stack_walk_user() unconditionally from the SSE PMU
overflow handler?

The commit message states "User callchains continue through the existing
nofault RISC-V user unwinder", but arch_stack_walk_user() is not completely
fault-free. It calls unwind_user_frame(), which uses
__copy_from_user_inatomic():

arch/riscv/kernel/stacktrace.c:unwind_user_frame() {
    ...
    if (__copy_from_user_inatomic(&buftail, user_frame_tail,
                                  sizeof(buftail)))
        return 0;
    ...
}

If the user stack page is not resident, this triggers an exception-table
handled hardware page fault. While the exception table handles the fault
gracefully, the CPU still takes a hardware trap through handle_exception(),
which routes execution through the exact dangerous trap entry path this
patch intends to avoid during an SSE PMU handler.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911121456.3322=
3-1-zhangzhanpeng.jasper@bytedance.com?part=3D6
