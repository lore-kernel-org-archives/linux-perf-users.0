Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62121313534;
	Mon, 13 Jul 2026 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955157; cv=none; b=npPWyNaHgYqxwu5gI3NTru6S55l2xWngLhiT73hv1cdEO/M3jTEQjXKee0fJfwdRqFizsjL4lAjBMJJafX8XQy+sEwyAox6S9O/7FidAuDUznjhDRBe/kDBL6YxdO4oy2tFESXL+LGuZeB27izrmlQrLUsp4+zw9D1E4syeDDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955157; c=relaxed/simple;
	bh=3GThBURQcgAt6dgeExEh2qVmRkwxWye5dYW3q76RUPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B1xxyTZnSqb9YeQHuxcfMq0FUhzFyBbP6IhHKMCh2lEwg0UxeoPkAOubZtgU1/BkLzXuTTmDhDI97iwYVpnYouOJR4RwtQTv+8nP2UfduGlVR9psTpBruwyT+f0UBXycn8aYoDudv515XzvEsIRkqVuBF3eMxNeF2KDwCffpUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ipy/n8E/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ipy/n8E/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3551F000E9;
	Mon, 13 Jul 2026 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783955156;
	bh=MNMr+1zvqqeE1FTtwG0gHlz0i9hZHdDOMqUrbec5zY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ipy/n8E/AgTATwVj0jr1hez5su0f+6QgGGiW2E36HjNpGJnInF/gjhlliJ8CD98H0
	 FU1h2KuZBwS/beOqvTJ24HLJW13pPeJLtRZT73XxsDosYm97xib8Yq3MUCWB+QYC3M
	 km2LaoXB/UW85LFdIlgUviDh+CK7VCemM+4zZdUl4NUHFCe+BTXYXR3gKJR/k8C53a
	 ke9oBeKUYafQY/Ia4HkAf/46PBHL2JlaU1CFtqtQbSYJIisdpQy96JqEmng985xn5h
	 YU+gQ2aGCwSMdyZzXgkEugPSnYQOuEBNnmO1zOo7cQ9Zhnxdd3Y47tIVVFSeXTIQfz
	 pH4ncayTZLG6w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] ARM, ARM64, LOONGARCH: Delay HW BP notification to
 task_work()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260713144939.FuCj9yvZ@linutronix.de>
References: <20260713144939.FuCj9yvZ@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:05:55 +0000
Message-Id: <20260713150555.BB3551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Queueing the same hardware breakpoint callback_head multiple t=
imes corrupts the task_works list, leading to an infinite loop and Use-Afte=
r-Free.
- [High] The use of TWA_RESUME fails to interrupt blocking system calls whe=
n a watchpoint triggers, potentially hanging the tracee.
--

--- Patch [1]: [RFC PATCH] ARM, ARM64, LOONGARCH: Delay HW BP notification =
to task_work() ---
commit edeb5ce1fcde3854d06fcd1845bb9a1a8e7ef02e
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

ARM, ARM64, LOONGARCH: Delay HW BP notification to task_work()

This patch delays the delivery of hardware breakpoint events to task_work()
to avoid sleeping while atomic warnings on PREEMPT_RT. It introduces a
generic callback perf_arch_hwbp_notify() that defers the architecture
specific signal generation to a return to user space.

Link: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6d1f8bad7e1c5..9674cd59703fb 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -13259,6 +13259,26 @@ static void account_event(struct perf_event *eve=
nt)
>  	account_pmu_sb_event(event);
>  }
> =20
> +#ifdef ARCH_NEED_PERF_HW_NOTIF
> +static void perf_arch_hwbp_send_sig(struct callback_head *head)
> +{
> +	struct perf_event *bp;
> +
> +	bp =3D container_of(head, struct perf_event, hw.arch_hw_notif);
> +	arch_hwbp_send_sig(bp);
> +	put_event(bp);
> +}
> +
> +void perf_arch_hwbp_notify(struct perf_event *bp, struct perf_sample_dat=
a *data,
> +			   struct pt_regs *regs)
> +{
> +	if (WARN_ON_ONCE(!atomic_long_inc_not_zero(&bp->refcount)))
> +		return;
> +	if (WARN_ON_ONCE(task_work_add(current, &bp->hw.arch_hw_notif, TWA_RESU=
ME)))

[Severity: Critical]
If a user-space process sets a hardware watchpoint on a buffer and passes it
to a syscall that accesses the buffer multiple times (like copy_to_user),
can this queue the same callback_head multiple times before returning to
user space?

Because arch_hw_notif is a statically embedded callback_head, calling
task_work_add() a second time for the same event without checking if it is
already pending will overwrite its next pointer to point to itself. When
task_work_run() executes, the subsequent execution loop will loop infinitely
because next and work remain the same.=20

The callback perf_arch_hwbp_send_sig() also calls put_event(bp), dropping
the refcount to zero and freeing the event. The next iteration reads
work->next and calls work->func(work) from freed memory, resulting in a
use-after-free and CPU lockup.

[Severity: High]
Is TWA_RESUME the correct mode here, or should it use TWA_SIGNAL?

Prior to this patch, hardware breakpoint handlers directly called
force_sig_fault(), which set TIF_SIGPENDING and properly interrupted
blocking system calls (like select or futex) to deliver the SIGTRAP.

TWA_RESUME only sets TIF_NOTIFY_RESUME and leaves signal_pending() false,
meaning the task could potentially block indefinitely without returning to
user space to process the task work, potentially deadlocking the tracee.

> +		put_event(bp);
> +}
> +#endif

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713144939.FuCj=
9yvZ@linutronix.de?part=3D1
