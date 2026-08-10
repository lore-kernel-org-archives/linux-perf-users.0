Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9753E0C66;
	Mon, 10 Aug 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370588; cv=none; b=qH9UmvD1puOibPTVx808M7/UwmPoWB1f+kVlM62tDegMuZ+ivuIu6r7LYCpW7TCMbPPS46PHCBiWW/XCsFRZ9wGAoM/qEE/xdQx80tSXAmP4jDdOIOwjUIJfkeAil6NSuRkIj3zBH6uAiOy6SNcfRO9SDLrkpDUXxNpG0VMbYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370588; c=relaxed/simple;
	bh=LfIdTTqg5c/Ob/ZERkYbe5RZBCzNz+U1lGkS43Ss5A8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U+OpMMET3BblzbK6eIK8DNnoV/2+YrlltGUYKCjVhpN7IrF14kdlTI2U5wkG4uTp1wYQAbYZ9qnLUOd5ObnnmCDvPcRzHn+qDIT+04O65U7oZL77DbVjnRUMDYpJ4DGLLJ+uPoeAJukPtRihDj2VINhhvqDBpkj/HUBiwOUwLu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdbpnzDS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdbpnzDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D721F000E9;
	Mon, 10 Aug 2026 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786370587;
	bh=C0wCGWqawOoqvyJErYnhEtp8F0veVA1BCLHQW05MDlU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdbpnzDSfgpJ2lP5FPLfSg6whNh/Hj65WNKYk+37WA90MChqGg6ZZYzK+2eFjgyvT
	 675Rqj1Eorwke4zoiGQc2X79ncNS33Ue0CUc5EoBIVfVBIKUPgzo+KAUYEDo8USG1F
	 4+tISCQADGCraM6oExhmQpONHaHvBjJaPTSwefD2JlP1ct0or/knab+R4594V5zHPC
	 thcz7CtG/imc3X14m3R0bnC+0KF3NFQD8xfXC5oY05S7bfveLzKEALu4+cRJp/hgtM
	 x020iAGLtZY+4unFQjevGYDZorXpIhMdvOMiZakCXMTZxGx+p+ANsFO6nGpICva7q+
	 OVm+vrOaFxA1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] perf/core: Fix NULL pmu_ctx passed to
 pmu->sched_task()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260810133540.1947118-2-puranjay@kernel.org>
References: <20260810133540.1947118-1-puranjay@kernel.org>
 <20260810133540.1947118-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 14:03:05 +0000
Message-Id: <20260810140306.C1D721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Per-CPU PMUs missing `sched_task` callbacks during context switche=
s if a task context exists.
--

--- Patch [1]: [PATCH v7 1/3] perf/core: Fix NULL pmu_ctx passed to pmu->sc=
hed_task() ---
commit 333df3e02c2d6b54e5bd528f91779820677d118e
Author: Puranjay Mohan <puranjay@kernel.org>

perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()

perf_pmu_sched_task() returns early when cpuctx->task_ctx is set, and
cpc->task_epc is only non-NULL while a task context is scheduled in on
this CPU. This patch passes &cpc->epc instead, which is the CPU-wide
context for this PMU, avoiding a NULL pointer dereference.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ba5bd6a78fe7b..c372213ffc883 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3907,7 +3907,7 @@ static void __perf_pmu_sched_task(struct perf_cpu_p=
mu_context *cpc,
>  	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>  	perf_pmu_disable(pmu);
> =20
> -	pmu->sched_task(cpc->task_epc, task, sched_in);
> +	pmu->sched_task(&cpc->epc, task, sched_in);

[Severity: High]
This isn't a bug introduced by this patch, but does the early return in
perf_pmu_sched_task() skip callbacks for CPU-wide PMUs?

If a system-wide PMU event is active (sched_cb_usage > 0), and a context
switch occurs to or from a task with an active perf event (meaning
cpuctx->task_ctx is set), perf_pmu_sched_task() returns early:

kernel/events/core.c:perf_pmu_sched_task() {
	...
	/* cpuctx->task_ctx will be handled in perf_event_context_sched_in/out */
	if (prev =3D=3D next || cpuctx->task_ctx)
		return;
	...
}

It seems to rely on perf_event_context_sched_out/in() to handle the
callbacks. However, perf_ctx_sched_task_cb() only iterates over the task's
pmu_ctx_list:

kernel/events/core.c:perf_ctx_sched_task_cb() {
	...
	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
		cpc =3D this_cpc(pmu_ctx->pmu);

		if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
			pmu_ctx->pmu->sched_task(pmu_ctx, task, sched_in);
	}
	...
}

If the task's perf event is for a different PMU (like a software event), the
CPU-wide PMU won't be in ctx->pmu_ctx_list. Does this mean the CPU-wide
PMU's sched_task() callback is completely skipped during the context switch,
potentially corrupting hardware tracing or leaking branch records across ta=
sks?

> =20
>  	perf_pmu_enable(pmu);
>  	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810133540.1947=
118-1-puranjay@kernel.org?part=3D1
