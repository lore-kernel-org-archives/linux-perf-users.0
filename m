Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A123A6404
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715013; cv=none; b=B46mMzz18FpynICwmSiVc+JQkwXYoR5/uyC2m3ai/CqUsW8XTuUHfydRafjF7qcBvF8Zp3prM2mWTcdQGfb7ZSTSu6XOvflJaG61CEd7F7QMdRLbsk7yHNRSyUbHaUByCVoXePRkGxfD3cpLN444sFXfMR9dt0PNySBIgkFnIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715013; c=relaxed/simple;
	bh=TII+5D3oBlpeIVG0oujl07MMWVwqdTCzECCqckZKk98=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FMwyFR2CYuXyef3R5XjZnG4MaXwz59xe/zsxy/JJkZGpBnR6ho9GfEcEKt3NXpUsJCKuIZ3h3TkrzDPeYtEZWafuol86G2hfV8YimunG0In0ARV8YGU1xRRn6DmmIAsXfIdbQoFA46W1NRIGbpAf2MZkwv2KflosFOLuc58BqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fig2MSj9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fig2MSj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00D6C19425;
	Wed, 13 May 2026 23:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778715012;
	bh=TII+5D3oBlpeIVG0oujl07MMWVwqdTCzECCqckZKk98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Fig2MSj9TozBzhkNQu9RVosTnO9fhhGkG97EmgkoAAxKQvfxlK+Xjfom9H0d26Maa
	 FaIUbRD8+j1F0Ovpl36TvmqmxOdP29pmmxtSt5Vx7Z08pVQAHvtGCFlxA2zmAo6lg6
	 Fz5Qq8SD4F0iTBhewzYuR2eS3F4aneK7iLtpUq63Y1R3IP6eaA/ev2qs2hoQHw0VDA
	 fh1gh3YWagGf7RT/QZ4FqTxCDKrzCDf903VIZh4Q/H1h428h8JgcZad3AZMCFo1OGg
	 8ZgrTuFa16wkIVOibVd8s4VTFPAvDFSwZ9dEyFQr2t8uimVT/eVSobSbZsgbTOaUG2
	 euxgbeNbCifug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Revert "perf: Fix the POLL_HUP delivery breakage"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512-arm_cs_clean_perf_handle-v1-2-75ff373ecd22@arm.com>
References: <20260512-arm_cs_clean_perf_handle-v1-2-75ff373ecd22@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:30:12 +0000
Message-Id: <20260513233012.A00D6C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the synchronous `event->pmu->stop(event, 0)` re-introduce=
s a race condition where the PMU hardware is not stopped synchronously when=
 `event_limit` reaches 0, allowing spurious hardware interrupts to clobber =
the `POLL_HUP` signal.
--

commit 0345ee403573bb4c49df3d0db2209160312a4bd6
Author: Leo Yan <leo.yan@arm.com>
Revert "perf: Fix the POLL_HUP delivery breakage"

This commit reverts the addition of a synchronous PMU stop call during
event overflow when the event limit reaches zero. It relies instead on
the asynchronous irq_work scheduled by perf_event_disable_inatomic() to
disable the event, removing the direct hardware stop.

Link: https://lore.kernel.org/lkml/aICYAqM5EQUlTqtX@li-2b55cdcc-350b-11b2-a=
85c-a78bff51fc11.ibm.com/

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10750,7 +10750,6 @@ static int __perf_event_overflow(struct perf_even=
t *event,
>  		ret =3D 1;
>  		event->pending_kill =3D POLL_HUP;
>  		perf_event_disable_inatomic(event);
> -		event->pmu->stop(event, 0);

Does removing this synchronous stop introduce a race condition with
subsequent hardware interrupts?

Looking at perf_event_disable_inatomic(), it does not synchronously stop
the PMU hardware. Instead, it queues an asynchronous irq_work. Because
architecture PMU interrupt handlers generally re-enable the PMU globally
before returning from the NMI/IRQ, the counter can remain active and
overflow again before the scheduled irq_work actually executes.

If a subsequent overflow occurs, __perf_event_overflow() is re-entered
and unconditionally sets pending_kill to POLL_IN:

__perf_event_overflow() {
    ...
    event->pending_kill =3D POLL_IN;
    if (events && atomic_dec_and_test(&event->event_limit)) {
        ret =3D 1;
        event->pending_kill =3D POLL_HUP;
        perf_event_disable_inatomic(event);
    }
    ...
}

Since event_limit is already 0 at this point, the if condition fails, and
pending_kill remains set to POLL_IN.

When the irq_work finally runs, could this sequence cause it to deliver
POLL_IN instead of the expected POLL_HUP, silently breaking userspace
expectations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512-arm_cs_cle=
an_perf_handle-v1-0-75ff373ecd22@arm.com?part=3D2
