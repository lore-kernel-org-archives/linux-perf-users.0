Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4953FE34D
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990579; cv=none; b=jg66BZHtvF4dnnkyw9xWgvjuYuXWF86np48F63UlTla1fzhnX7oquBV1BGMaYPfwetKFifu2L2qtEA46jz5HxMeYIw7dSVzCIkyfIOYyBqP97esAB69ja76PIiVohvAFPZ/ZdieEx2/JP/QPY+6gyq0BhjTTFMirgwO1WuQIDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990579; c=relaxed/simple;
	bh=4BjTUe3PKlGeZTxcDyWBCzIRK2v5eMCGjvBHGlfyKAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oa14PLvCoZq4aLnA0LIlCRzlf5HiXpy64m6p1iEfUdYAL1X2OnFFDGJH+HHmme6NRtEuTljcnQFEcrbXoJApHga2trDxYmciSsCVwyAf2TW2MjFzxMlonpbd+9tKc8r4Hi8R8G3bzmhf9cHWeXJunBgCe45ITpWtaGHbB7Lpgmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbJGS2Gf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbJGS2Gf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387221F000FF;
	Mon, 21 Sep 2026 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789990577;
	bh=SQ3KzWp+UbEzQgcUNQDdWGK+lLs9ivSoZf99q7S5Klc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MbJGS2GfeFQTKLzhURVYjdEnJ/JR33XRAiMUJ0tolqhHBaibWbS0tEdNkf9zRDSXe
	 VToHqDFqyCFWAj/Y8D5ocx+t99HUtBB9jOA/J6PoWyeyUlOBdDhWPwoKZJaO1iiNf1
	 yoEJt0nUd6EzfGt3yqcsISC+J0hP0nQVnA+T8xrhMuQriz0nl2faSeeMQEwCN2yIXy
	 0aLy1/i9yGbsKrx0hcZxnlSToLR9aANTTAGKmM2I28zlEk3m60MhDmWqu01JiW7JXy
	 cQOoMjZEpuczb7g9WRG7/Yx3R2Kpb1yjqPxeNvF9YvQslyLWL4GCckH+6KwIuDxIN1
	 30hCkYvr6OHQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 RESEND 6/9] perf: RISC-V: support callchains with
 SSE delivery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <270f3bcd3a9933c8be59492ae4d7c6ff2414d7d7.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
References: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
 <270f3bcd3a9933c8be59492ae4d7c6ff2414d7d7.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:36:16 +0000
Message-Id: <20260921113617.387221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf: RISC-V: user stack unwinder retains context-corrupting neste=
d faults
- [Medium] perf: RISC-V: kernel callchain truncation without CONFIG_FRAME_P=
OINTER
--

commit a95d15a6320c76f0780598b2a4d0ec479bdebc3c
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

perf: RISC-V: support callchains with SSE delivery

PMU overflow delivery through SSE enters Linux with a synthetic supervisor
context on a dedicated event stack. This patch implements an SSE-specific
RISC-V user and kernel callchain unwinder that attempts to avoid
exception-table handled faults.

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

[Severity: Medium]
Does this logic unconditionally enforce frame pointer validity, which might
break stack unwinding when the kernel doesn't use frame pointers?

When CONFIG_FRAME_POINTER is disabled, regs->s0 (fp) is a general-purpose
callee-saved register containing arbitrary data, not a valid frame pointer.
Unconditionally validating fp as a valid stack address could fail, causing
sse_callchain_kernel() to skip the walk_stackframe() fallback and truncate
PMU kernel callchains to a single PC entry.

The walk_stackframe() fallback correctly handles CONFIG_FRAME_POINTER=3Dn by
iterating the stack pointer. Can we avoid unconditionally requiring a valid
frame pointer here?

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

[Severity: High]
Does this still invoke the user unwinder which relies on
__copy_from_user_inatomic(), conflicting with the patch's goal of avoiding
hardware faults in SSE handlers?

The commit message states that taking an exception-table handled fault
from the SSE handler can corrupt the interrupted kernel context. While this
patch introduces arch_perf_out_copy_user() to bypass
__copy_from_user_inatomic() for raw stack sampling, perf_callchain_user()
continues to use arch_stack_walk_user().

Since arch_stack_walk_user() reads user memory via
__copy_from_user_inatomic() and hardware traps could corrupt the SSE
context, won't the user stack unwinder trigger the same context
corruption when encountering a non-resident page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789974241.gi=
t.zhangzhanpeng.jasper@bytedance.com?part=3D6
