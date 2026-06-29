Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31C3C3451
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718958; cv=none; b=H6YjiY70Pco6QILPuYqdhjYFoSsZ/iz2RZORDO0lCrq4VKh+lUYWfRHiHX9INWARWcYJZD8jQfLyT2SYGrQl4g2ElKKxbp/ErjtORsP1b9eHlUMzOkPSII+sEIEIF27EAWPwZW3PqKCMa6CPy9caLmjplr6Xbdcrme03tyVk9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718958; c=relaxed/simple;
	bh=lfVsb/euxFwx4aQaVYg9BkHcjIFFz6YgWu8lMP6M3KY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qr1J9zoeesNUvpaxm5tEy2F+swbrk1UG3vze7FoUZRTQEys96XE9gpFEdMsIg3hekjgL8CZ/iKD8DWq8rX6scS5J0txwFq9s7slY2TmR574HDMwDVBPMsiCid6n7mjbG6q7fM3lX/I7+IzMK1aSlmfBB/St0RajbgPo5n0ApAoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwCjiAPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwCjiAPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133DB1F000E9;
	Mon, 29 Jun 2026 07:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782718953;
	bh=uTXermlok/dm7qGYRoU2w9v1+iEu+I7P+0BRrDzT5KY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mwCjiAPmfG4fLkCKFwA2EIrh4xeReZAx+DdhhvoGcXThCTgf4ru2OAk6Woix1uHG6
	 QtxHTmf5enuxcSWeXFpt41zE5VUvjkmKEPCz8DYLosNgwyE0cAw4CmxYfrZmn7T4bP
	 krwSfYE4KAPaEvobk+M2ugFEm0byb47PLjf+5uUz1AElAdN0j4EF4uEHzyXrrwKo6O
	 W2nkNS2vZbXB4L7v1WZD66T4lQZeLeDAxfBQc2TWe2fImI72J5GHfYmwaPEvE3fcIP
	 /PjZmarFR2f2tBzilk9K3EBWr6BaPyQN8V/nn3S/DD2JM/gLd6tqYbG1s0Hs/Xi1zd
	 Oae5occSPV1tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 RESEND 4/7] riscv: stacktrace: introduce stack-bound
 tracking helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Han" <wanghan@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260629072713.3273743-5-wanghan@linux.alibaba.com>
References: <20260629072713.3273743-1-wanghan@linux.alibaba.com>
 <20260629072713.3273743-5-wanghan@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 07:42:32 +0000
Message-Id: <20260629074233.133DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unconditional reference to conditionally defined irq_stack_ptr caus=
es a link-time error when CONFIG_IRQ_STACKS is disabled.
--

commit 64aa629bbd032157beeb94e2add8faf14c975e32
Author: Wang Han <wanghan@linux.alibaba.com>

riscv: stacktrace: introduce stack-bound tracking helpers

This commit introduces building blocks for a reliable stack unwinder=20
in RISC-V. It adds stack-bound tracking helpers such as stack_info=20
and unwind_state, along with accessors for IRQ, task, and overflow stacks.

> diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm=
/stacktrace.h
> index b1495a7e06ce6..bc87c49403798 100644
> --- a/arch/riscv/include/asm/stacktrace.h
> +++ b/arch/riscv/include/asm/stacktrace.h

[ ... ]

> @@ -16,14 +21,70 @@ extern void notrace walk_stackframe(struct task_struc=
t *task, struct pt_regs *re
>  extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tas=
k,
>  			   const char *loglvl);
> =20
> -static inline bool on_thread_stack(void)
> +/*
> + * IRQ stack accessors
> + */
> +static inline struct stack_info stackinfo_get_irq(void)
> +{
> +	unsigned long low =3D (unsigned long)raw_cpu_read(irq_stack_ptr);

[Severity: Low]
Will this cause a link error when CONFIG_IRQ_STACKS is disabled?=20

Looking at arch/riscv/kernel/irq.c, irq_stack_ptr is defined inside an=20
#ifdef CONFIG_IRQ_STACKS block. Since stackinfo_get_irq() unconditionally
references it here, it seems this might result in an undefined reference
to irq_stack_ptr during linking.=20

Should this accessor be conditionally compiled, or should it provide a
fallback when CONFIG_IRQ_STACKS is not set?

> +	unsigned long high =3D low + IRQ_STACK_SIZE;
> +
> +	return (struct stack_info) {
> +		.low =3D low,
> +		.high =3D high,
> +	};
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629072713.3273=
743-1-wanghan@linux.alibaba.com?part=3D4
