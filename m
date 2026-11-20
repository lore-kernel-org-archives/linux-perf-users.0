Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187745;
	b=PqYTvSbWS7T+LmX6f8LYcRiA5Ashp1GSFzwCDpaq6uCFreBQS2i0aA/BcbZAll432WOq
	 f97nGA+CRMHuidOUQIx/+TBQgJ5nInEpJ7E2FeIXaM96Q2dhV5hFvZN3/P7eZWX9Ax8Gu
	 ANO1s4ASuDqeWg4TNzyXe1B1Qm13LtKgXiFZBZVV94I5yfs58G07ht6am/zXnpsYzyqmG
	 sYEhkhhVVjedIGeK6LJFd8djWvPnL20euYyDEg+jGdP+xPGS0fziIdRWKXMUTqNPjAqkx
	 c0aSMbcwpskcgtmP3+V889vy/h9szgrD0OgKQo2kOuj2hoM2TpYmaUYnZzQVrNUMpKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187745;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5PvVbdw1H4TaeeEEy3gzS8gsdBLbvbj7MYrxcM3C5gE=;
	b=Da/QyhTdWwDw0w3fxqN3ijiV6zoOde9JCGtaN7yeMlBfb73QIVHCWKKGl9GSn9QRcJ7l
	 sUm1f1vIS+8Fe0dnF5iO13oMvwX8+5P/DCUr9oJvYUeMyKbzfEEuSE90/DBrgmyrTqtV3
	 ekZCJlmYBN1xK44KkY8CNrQR3NLZgERcFyeIb7pYmkuVlf333NrQny/7hyfQX3IDTJsqb
	 l4/VNsouuRmY57YutmAxmCNZKoQNmmO+059EqlgGAXYlPxzlXiyCDfIBtdIVtN3hcktrm
	 sl+WIOkyfBVjdT8Hg5bFrDjhHI5+AklOFGhBlFZLtU3RaNZuIVQx0g5T3u2kebxcMwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNPz6git;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F7606A32A;
	Fri, 20 Nov 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNPz6git
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010C01F000C0;
	Fri, 20 Nov 2026 15:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795187745;
	bh=5PvVbdw1H4TaeeEEy3gzS8gsdBLbvbj7MYrxcM3C5gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MNPz6gitvITlFlI/IrUP0B85yEFWhKJAQbcUfuOqS+hoeqD3PQUgEum1j2RzFD66r
	 +EJEqSk5fXaiXFwqNXfQEfiYm40Efp3iofToYc7VKbTbrNeDnkJBhG6vd58pHyNwiz
	 d/2d0nQ20nfQwOnAE4acaJHXaAkplcRGuHhjw6jSnw2eOSiIyARNjcImOavyoKL5re
	 M9BBY1ymEmMNN4bOPLb8lpdswRp8A34lZYJsjBxxoRXD+mGx39JTPJK0RKnEsuIjT+
	 /Zyia5oFWZVJRY7fi04TiSvQxCyEMJQ0XtIDQir7WBWFX/HRdDZVnfJpUTp1IsYq0N
	 YG5hUARYDorEw==
Message-ID: <sashiko-outbox-225444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP
 notification to task_work()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20261120144553.TjgAd_G6@linutronix.de>
References: <20261120144553.TjgAd_G6@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:15:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] loongarch: ptrace: do_watch() forces SIGTRAP before
  perf_arch_hwbp_send_sig()
--

commit e42e3194215f3def1d0ba2e055fc294e66e5d8ac
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

ARM, ARM64, LONGARCH, XTENSA: Delay HW BP notification to task_work()

This commit defers ptrace hardware breakpoint signal notifications on ARM,
ARM64, LoongArch, and Xtensa to task_work via perf_hwbp_notify() so that
sighand->siglock is not acquired with interrupts disabled on PREEMPT_RT.

> diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrac=
e.c
> index be38430f7e280..27e7e64591592 100644
> --- a/arch/loongarch/kernel/ptrace.c
> +++ b/arch/loongarch/kernel/ptrace.c
> @@ -384,9 +384,7 @@ static int lbt_set(struct task_struct *target,
>  /*
>   * Handle hitting a HW-breakpoint.
>   */
> -static void ptrace_hbptriggered(struct perf_event *bp,
> -				struct perf_sample_data *data,
> -				struct pt_regs *regs)
> +void perf_arch_hwbp_send_sig(struct perf_event *bp)
>  {
>  	int i;
>  	struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
> @@ -479,7 +477,7 @@ static struct perf_event *ptrace_hbp_create(unsigned =
int note_type,
>  	attr.bp_type	=3D type;
>  	attr.disabled	=3D 1;
> =20
> -	bp =3D register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL, ts=
k);
> +	bp =3D register_user_hw_breakpoint(&attr, perf_hwbp_notify, NULL, tsk);
>  	if (IS_ERR(bp))
>  		return bp;

[Severity: High]
Does deferring force_sig_ptrace_errno_trap() to task_work cause do_watch()
to queue a generic SI_KERNEL SIGTRAP first and drop the TRAP_HWBKPT
siginfo?

On LoongArch, do_watch() runs with interrupts disabled and forces SIGTRAP
before returning through irqentry_exit():

arch/loongarch/kernel/traps.c:do_watch() {
	...
	bool need_sigtrap =3D !!current->ptrace;
	...
	if (test_tsk_thread_flag(current, TIF_SINGLESTEP)) {
		...
	} else {
		need_sigtrap |=3D breakpoint_handler(regs);
		need_sigtrap |=3D watchpoint_handler(regs);
	}

	if (need_sigtrap)
		force_sig(SIGTRAP);
out:
#endif
	irqentry_exit(regs, state);
}

Previously, breakpoint_handler() and watchpoint_handler() ran
ptrace_hbptriggered() synchronously, queueing SIGTRAP with TRAP_HWBKPT, the
slot index in si_errno, and the breakpoint address in si_addr before
do_watch() reached force_sig(SIGTRAP), which __send_signal_locked() then
ignored via legacy_queue().

With perf_arch_hwbp_send_sig() deferred to TWA_RESUME, force_sig(SIGTRAP)
in do_watch() now runs first while interrupts are still disabled.  That
queues a generic SI_KERNEL SIGTRAP, causing __send_signal_locked() to drop
the subsequent TRAP_HWBKPT siginfo from perf_arch_hwbp_send_sig(), and
still acquires sighand->siglock in atomic context on PREEMPT_RT.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120144553.TjgA=
d_G6@linutronix.de?part=3D1
