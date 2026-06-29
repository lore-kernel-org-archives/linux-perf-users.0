Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F793C37B3
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717503; cv=none; b=K0eeC5t0wAp7oyPKjslsD73Z47Sch3/uukXr2AYUaoOSTGwTTphveAJaHe63E+GdH2g92eENYWdd+E7GAgjXHpoADQzeuL79++iVd4nAIHV13Myr0TItJbvnMCL5Fs4muIK2yRnxFAH31tf4IfW2M5XcE9tz4Z7BeyJnbuoK01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717503; c=relaxed/simple;
	bh=PLNYHZ4MFLZYwtb/434Xxiec7fhL04r9imEcnTFNRb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TmnvPNryFA+vLK2DrkvXfG4gnOMi0+2A15lsY+/ufn6QAdBM9LWFN6hqHlO6zMjL6DfWTgASptwNeVaptYE7jZKRNMvgXEHLXwFQO2EOpVog5UqeezhVegVQxnUoQjtlYuYbqdBU/wGsiiwcmVFAXyleLQrGQE1SznI6038FOtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHunICRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHunICRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EE01F000E9;
	Mon, 29 Jun 2026 07:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782717500;
	bh=u2CqrPOqXqUUpj4Erp24JKVywGVM72Z1Hoi7btq5oWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eHunICRipiL85/KtpkRNkv9wf6amS3knYFrPm054ZMVbRwpFqsFtEr5mputhUJ3YQ
	 frYJ5cRFp5FqAee7faJhCxGlFC6PF4mGfXQ6tWd0xCeNnpWJ5BP/z/33woMfWMbqCl
	 vGEDRMeWi0Ng1Rt4S5PWatMW4l3QNlks8yAaXREZM2TPeiHcYvamBR4OH20+NZddfL
	 yTIkWF04D9/ChHRivTWfHJiflVjlGGqNcyR13IuNs+VBnLSBnRmJcLcnopE1hPYEBy
	 xyfn47/N1g5RwvJdpIyDiWVZ6EJvg0/1eJhEuvvuXBKa5EOYGoHiquq523w29XhpbJ
	 XQ/BFLFzQOyWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] riscv: stacktrace: introduce stack-bound
 tracking helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Han" <wanghan@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260629064228.3195856-5-wanghan@linux.alibaba.com>
References: <20260629064228.3195856-5-wanghan@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 07:17:58 +0000
Message-Id: <20260629071820.60EE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Linker error for `irq_stack_ptr` when `CONFIG_IRQ_STACKS` is disabl=
ed.
--

commit 77c89ba9a3694750005502f08315093729bc5952
Author: Wang Han <wanghan@linux.alibaba.com>

riscv: stacktrace: introduce stack-bound tracking helpers

This commit introduces common stack unwinder types and helpers for RISC-V,
modeled after the arm64 implementation. It adds struct stack_info and acces=
sors
for different stack types like IRQ, task, and overflow stacks. The unwinder
switch to use these helpers is planned for a follow-up commit.

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
Will this cause a linker error when CONFIG_IRQ_STACKS is disabled?

This unconditionally references irq_stack_ptr, which lacks a definition when
CONFIG_IRQ_STACKS is disabled. While these helpers aren't wired up to calle=
rs
in this commit, when they are used in the follow-up commit, could this break
the build for configurations with CONFIG_FRAME_POINTER=3Dy and
CONFIG_IRQ_STACKS=3Dn?

> +	unsigned long high =3D low + IRQ_STACK_SIZE;
> +
> +	return (struct stack_info) {
> +		.low =3D low,
> +		.high =3D high,
> +	};
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629064228.3195=
856-1-wanghan@linux.alibaba.com?part=3D4
