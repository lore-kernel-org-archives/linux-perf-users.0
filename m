Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B51395AC7;
	Fri, 14 Aug 2026 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698186; cv=none; b=ZNwxgpp4V5Lu2DYhKpWfLAO4DtQdlDmTNKbwHQZ8eKJO83Qp1OVrN68biuyTm3lp+wYCUuXub05HQj82oiVvFz8SsVCnZiQ07+dVugUwuFQ8UagaNX+5wiLVI35Ihh14lQhO/DU5QLLN67IVFqAYnjwMSlM1kMyS83ItHiC0z6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698186; c=relaxed/simple;
	bh=8XIwE8ky7v9949diwEgszMVnOvFGTRkGpeaUiFWUiRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MX+Xhmd85ccI3aCs3684BjFER1qdsEBMuQycX1ubw2iLFmxXxU4liJEquEmeoLkE4FzDiIaIDbJHliOnIC4/hV3q7GtPxXNYLw27TKF8YRk5vxj30TFUAb7ucmIjevZlhEM2xO5bvpe/SWC4MpViT7bZiVF6YU9BfK9jc0tpYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbP7EXTc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbP7EXTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558901F0155A;
	Fri, 14 Aug 2026 09:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786698184;
	bh=rLjU10Fc5hOl+UKE3CGFNff9Yztjeck+X9rjVsBM9N4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbP7EXTcqGN+nVV9AcbRhVPDRw89sOol1DevTgWY3ZPaUuR8vZzI0ixk60qiAWq6G
	 ypIFUqCjC02KKq1CvuLshXEUe7+N0X566YUgpdQjl0BGzD62xo0yJ2yj/Po2mGJVHU
	 QTUCEmjD+5JFpWwuH6aOo+Sd/v0IV3wLJisqcnzNpd5cEBKpY62sepa4LoS1WI6kZF
	 fDxpLBTYF5ZKeFh+dpisQCM0rKiPQ0eiQVnvOyD/yL+CKdjOvWAZaa+j/UvD7emaT6
	 tfYEqGzFl96pzQaHokvGvv56rHStqsRb6RTjfRhwsVVHPUugkahUhkJ6kP8vLOfFE3
	 h6x6LT06AelmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ARM, ARM64, LONGARCH: Delay HW BP notification to
 task_work()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org
In-Reply-To: <20260814085118.OPEA_Ssn@linutronix.de>
References: <20260814085118.OPEA_Ssn@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 09:03:03 +0000
Message-Id: <20260814090304.558901F0155A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Deadlock/hang in blocking syscalls due to missing TWA_SIGNAL when =
delaying hardware breakpoint notification
--

--- Patch [1]: [PATCH v2] ARM, ARM64, LONGARCH: Delay HW BP notification to=
 task_work() ---
commit 5153bc880ca6886ee1fe14a21ba3ae8477562c21
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

ARM, ARM64, LONGARCH: Delay HW BP notification to task_work()
   =20
This commit delays hardware breakpoint event callbacks to task_work to
prevent "sleeping while atomic" warnings on PREEMPT_RT. The architecture-
specific callbacks now use perf_arch_hwbp_notify() to queue the SIGTRAP
delivery until the return to userland.

Closes: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ba5bd6a78fe7b..1ca91208e1524 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -13338,6 +13338,28 @@ static void account_event(struct perf_event *eve=
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
> +	xchg_relaxed(&bp->hw.arch_hw_notif_busy, 0);
> +	put_event(bp);
> +}
> +
> +void perf_arch_hwbp_notify(struct perf_event *bp, struct perf_sample_dat=
a *data,
> +			   struct pt_regs *regs)
> +{
> +	if (WARN_ON_ONCE(!atomic_long_inc_not_zero(&bp->refcount)))
> +		return;
> +	if (xchg_relaxed(&bp->hw.arch_hw_notif_busy, 1) ||
> +	    WARN_ON_ONCE(task_work_add(current, &bp->hw.arch_hw_notif, TWA_RESU=
ME)))
[Severity: High]
Will using TWA_RESUME here cause a hang if a hardware watchpoint is trigger=
ed
during a blocking syscall like futex() or read()?

When a blocking syscall accesses watched memory (e.g., via get_user()), the
watchpoint synchronously triggers and queues the SIGTRAP task work via
task_work_add(). Since TWA_RESUME only sets TIF_NOTIFY_RESUME, and
signal_pending() ignores TIF_NOTIFY_RESUME, the syscall wait loop will not
abort.=20

Does this need to use TWA_SIGNAL instead so that TIF_NOTIFY_SIGNAL is set a=
nd
the interruptible sleep correctly aborts to deliver the pending task work?

> +		put_event(bp);
> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814085118.OPEA=
_Ssn@linutronix.de?part=3D1
