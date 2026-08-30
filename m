Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86E3BA253;
	Sun, 30 Aug 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100809; cv=none; b=cSnwUeTqwYoePpGDhYdU8roVi05yF7hbSM+gDZDVDywd6QgWuQUZ0tMix418r8hnF50NXT7kNzgtHJ1RUCvSNnXMHe+uAfPP5ZcVIe2JzmuGihoVpkm4QMMG7jqgOUxBIWR075w0TW5Bk6gy0tee0xi6YsN6JYmYIgTYypl5PRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100809; c=relaxed/simple;
	bh=JOiB/aoLS0sWm/4U7j8MfAIf+xyILqQChOkSfzOPqGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WjSymm9VxFMPFGEMvZBAlX1HESA1jWQEzHc1d+8XjGllLFTLgrQjFPSns8LkX8kiVgQQNa5mrCc3DULX4L/JQaWLUlekI3cSmNJJozaMYrMT7sbm+yWUShaUwxwu5YY9AxWDa1gcbDS23Eqx8IElc9ETUyq57parSREM4v+kSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJUqO4Y1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJUqO4Y1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28ED1F000E9;
	Sun, 30 Aug 2026 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100806;
	bh=I2kxi/RRnt8U0NVH5PSG9fQuAUjd3sOAcSoSyl4nGjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AJUqO4Y1hXD2IGE6Nu8FFEVa4Q6HreIPIdWNeeoCyH53Z+eC4JgiUkItnEBe7HhTH
	 A21Qze7JUdl5RQefH7mKM/AM4VMfp25y7JzFyrmCBqBuwv+kwQ+svBLIwGMU4Ydlah
	 MJk3bG7mIpr0PbKnrCQYMdPg3VibG+RinRBQu87YOjeDUz5HhjA2/WNfcgnTLlrdU8
	 9rIeceIC9F9G1xWZvNoG7j/cbinhZMLYqKfBcKMtSRIDtYSBPpLfWs08rNx2JCKk6M
	 yxDk4JbIyLbi6jjDAGpvUKErrybyJyhdMOYTf11QaqtcegMuzme4IJG/7ul/iQHk2y
	 8Gln3kIpqEEBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 01/14] x86/mce: Fix hardware debug register
 corruption on task migration
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178810002334.64882.15357388305843450280.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810002334.64882.15357388305843450280.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:40:05 +0000
Message-Id: <20260830144005.C28ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving local_db_save() inside exc_machine_check_kernel() exposes e=
arly #MC entry code to hardware breakpoints, partially reverting commit cd8=
40e424f27 and allowing nested #DB exceptions that can fatally corrupt the #=
DB IST stack.
--

commit 22e84ef34bc3d02a04e2e3356bffad4d11749a7a
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

x86/mce: Fix hardware debug register corruption on task migration

In exc_machine_check_user(), local_db_save() and local_db_restore() are
invoked in the outer entry stubs, surrounding exc_machine_check_user().
However, exc_machine_check_user() handles pending thread work and may
schedule(), causing the task to migrate to another CPU. This patch moves
local_db_save() and local_db_restore() inside exc_machine_check_user()
and exc_machine_check_kernel() to prevent hardware debug register corruptio=
n.

> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
> index cfb74be19994d..61ade8b5c9d7b 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -2108,6 +2108,7 @@ bool filter_mce(struct mce *m)
>  static __always_inline void exc_machine_check_kernel(struct pt_regs *reg=
s)
>  {
>  	irqentry_state_t irq_state;
> +	unsigned long dr7;
> =20
>  	WARN_ON_ONCE(user_mode(regs));
> =20
> @@ -2118,18 +2119,24 @@ static __always_inline void exc_machine_check_ker=
nel(struct pt_regs *regs)
>  	if (mca_cfg.initialized && mce_check_crashing_cpu())
>  		return;
> =20
> +	dr7 =3D local_db_save();

[Severity: High]
Does moving local_db_save() below the early checks in
exc_machine_check_kernel() expose this early #MC entry code to hardware
breakpoints?

If a privileged user sets a hardware data breakpoint on a kernel variable
accessed here, such as mca_cfg.initialized or variables inside
mce_check_crashing_cpu(), a #DB exception could fire in kernel mode.

If a Machine Check Exception (#MC) then occurs and preempts the #DB handler,
it switches to the #MC IST stack. Because local_db_save() is not called
until after these variable accesses, the code could trigger a nested #DB
exception.

Since x86 uses a fixed-size Interrupt Stack Table (IST) for #DB exceptions
that unconditionally resets the stack pointer to the top of the #DB IST
stack, wouldn't the nested #DB overwrite the active stack frame of the
interrupted #DB handler, leading to a fatal crash when it attempts to
return?

Could local_db_save() be called at the very beginning of
exc_machine_check_kernel() to prevent this IST stack corruption?

>  	irq_state =3D irqentry_nmi_enter(regs);
> =20
>  	do_machine_check(regs);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D1
