Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEFB369D66;
	Thu,  1 Oct 2026 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866095; cv=none; b=Q0D0DvpXJe3BmS97Q9JD2E4EJ2B5LK2iNktB6RpLyPJCKWvCfR2QawmnuFTp1ag0BDh//wJC3dJg2dKGh0rCAtW7WreHdQxtxhhqGnS5MHLoEfeyGwIh3wbrq4nd9UQNTiJMa+4w+V5Nv6wmus1EQP4M4+pGD7LL/tYl906t6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866095; c=relaxed/simple;
	bh=lQVGaTUbKX3vZNKbfXHrVv0k2dyG9x0SfA0zdkw58/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=foiUw+nRcz1p9RLhyvn2U4i+HJ4A7A3XkfBFrS5vyTK9s/XGG7ia8kV2P8B+/mbOYWgZeepznCBWO4aMv3L1XdVxR2wSCS+bf5XOtWCfepUsXdqWC8xA9li/MgMIWGNfM5LOWd13WYbkc5OULzV7kWaYEBjuJpsTzHSMC5OBITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsCQneNN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsCQneNN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CA61F000FF;
	Thu,  1 Oct 2026 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790866092;
	bh=5EVX07OiZ7f9Gz2BmfxtwvOPv3wrI169p7Uv2M27k5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VsCQneNNQ8tMAPM3ls8Xc4lyu6eg0daaZV0aIMijOCZqBu09vCNYkrpuSN+COgTuR
	 xz7AhH7OEjeSw8L8TbEtfSWy6uyyr7uGi5yexBfowepmh5+F6VNo6Bjfy24IIpmuDC
	 7LOmxc26/BTEC3vUQGJW9eoreQ3JCliDQInxCnWMrqHeEa0rmqJZK5fhSi41lDOz3g
	 9+JfmMyyZG3FtxhLS5/RcSz6plBbfLBvTzqIAcOb78tXZ6CfZGY8JK5reLsSlmTToS
	 KnYJNVGxSADH/vslc/UEi0+UuKT/2UcuxcmG6CV3oNRvqQ3fVOYC94WvraeMMo9Uyg
	 hVIZVaNMpoQtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP
 notification to task_work()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261001143516.Ew8C97WS@linutronix.de>
References: <20261001143516.Ew8C97WS@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:48:12 +0000
Message-Id: <20261001144812.66CA61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] events: delayed or lost SIGTRAP for hardware watchpoints hit in =
blocking syscalls
--

commit f836aefea872e6050b4535461bc8040c46ae9a47
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

ARM, ARM64, LONGARCH, XTENSA: Delay HW BP notification to task_work()

This commit addresses sleeping while atomic warnings on PREEMPT_RT caused by
hardware breakpoints on ARM64. It delays the hardware event callback
execution until the return to userland by queueing it via task_work_add().
The same pattern is also adopted for ARM, LongARCH, and Xtensa.

Closes: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index db7b76d6b68aa..b95e4d3a4f7c9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -13374,6 +13374,28 @@ static void account_event(struct perf_event *eve=
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

[Severity: Medium]
Could queuing the task work with TWA_RESUME instead of TWA_SIGNAL cause
delayed or lost SIGTRAP deliveries for hardware watchpoints?

If a tracee hits a hardware watchpoint while in a blocking syscall (for
example, when the syscall accesses memory via get_user or put_user),
using TWA_RESUME will only set TIF_NOTIFY_RESUME.=20

Because it does not set TIF_SIGPENDING or TIF_NOTIFY_SIGNAL, the syscall
will not be interrupted. Does this allow the tracee to hang indefinitely in
the blocking syscall instead of aborting the syscall to deliver the
synchronous SIGTRAP?

> +		put_event(bp);
> +}
> +#endif
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001143516.Ew8C=
97WS@linutronix.de?part=3D1
