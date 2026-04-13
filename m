Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C4CA6F
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776108682; cv=none; b=pg5nlbKKrNunExN6mtTD0qn1IKie6D/qcs7EwcvmG8NMmBA8hqwAtsHexFYxE3xQz4DcEi8fwGASVNyNAa2N6iJv7+Ufgkw8CVsv9gOosvVXu/a2KoDunmnL0gdQZfeYGojIqvE/JUip3vnVKnJEKYZMCeHR1GqY5gqrslexUdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776108682; c=relaxed/simple;
	bh=OHnzae83jl2j9URTj5hHsGgo0HsMtOBc/xeKY6e60qg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ui6ykc5lsN2caoGF1N6DRWLWqQdZlpT5yr/s4wi9UyGgBEmp8BUpMXP1MlEextMYAaM8+YZMYJWX82NoHbWxowDQrZ7oWjpUDKSw0R24UBl0b0EEh1d1962SrvQiS78GE/3YwFnUJ7owh5P4Cx8gRqP2FdbzDHHcKZD84h+aAEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRvwTI0P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRvwTI0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79536C2BCAF;
	Mon, 13 Apr 2026 19:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776108681;
	bh=OHnzae83jl2j9URTj5hHsGgo0HsMtOBc/xeKY6e60qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sRvwTI0PJayxvXEiatKYGfxvFrw+2QjzGlLobtUKEythVK+oR1aN6Rn//sUkg+17w
	 njLAHn+/p2EZcgHp5InQEoAqKBspPmRFQwuDyxur7fc2WLzGnzI5mI1zHvN+z8pC6I
	 XMHm2jtCvgo28KZc04lLqoX/jHfXHsMjzUVWwYPKgsdUw2dUkiBPzlwL2r3hB+OZqS
	 gr0vRtffkg7keA51GY9ffbIl7aEmwHFQIvv3KcxOCFgrxDDSVHuLGzjcUT1o6qnzoM
	 Bfleh12WB2/8MP7LBZPl/EDaCbUU1aAxo3qV7ZfQrWSyqVRw5lTYiiOb3Lam2csjuI
	 rzkk5/pYCX4xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] perf/core: Fix NULL pmu_ctx passed to PMU
 sched_task callback
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413185740.3286146-2-puranjay@kernel.org>
References: <20260413185740.3286146-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 19:31:20 +0000
Message-Id: <20260413193121.79536C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Incomplete Fix / Architectural Regression Masking in __perf_pmu_sc=
hed_task()
--

commit f71d68607ec5b88fb13bb33d01fafd22533f428b
Author: Puranjay Mohan <puranjay@kernel.org>

perf/core: Fix NULL pmu_ctx passed to PMU sched_task callback

This commit modifies __perf_pmu_sched_task() to avoid a NULL pointer
dereference when a task has no perf events for a specific PMU. It falls
back to using the CPU context when the task context is NULL, which
prevents crashes when using CPU-wide branch-stack events.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1f5699b339ec8..2a8fb78e13471 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3906,7 +3906,8 @@ static void __perf_pmu_sched_task(struct perf_cpu_p=
mu_context *cpc,
>  	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>  	perf_pmu_disable(pmu);
> =20
> -	pmu->sched_task(cpc->task_epc, task, sched_in);
> +	pmu->sched_task(cpc->task_epc ? cpc->task_epc : &cpc->epc,
> +			task, sched_in);

While this prevents the NULL pointer dereference when __perf_pmu_sched_task=
()
is called, does this fully resolve the issue if the task has an unrelated
perf event?

Looking at the caller perf_pmu_sched_task():

static void perf_pmu_sched_task(struct task_struct *prev,
				struct task_struct *next,
				bool sched_in)
{
	...
	if (prev =3D=3D next || cpuctx->task_ctx)
		return;
	...
}

If the task has an unrelated event, like a software event, cpuctx->task_ctx
is not NULL, and this returns early.

The fallback path perf_event_context_sched_in/out() calls
perf_ctx_sched_task_cb(), which iterates over ctx->pmu_ctx_list.

Since a PMU with only CPU-wide events is not in ctx->pmu_ctx_list, will this
PMU be silently bypassed?

Could this regression cause branch records to leak across tasks if the
scheduled task has an unrelated perf event?

> =20
>  	perf_pmu_enable(pmu);
>  	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413185740.3286=
146-1-puranjay@kernel.org?part=3D1
