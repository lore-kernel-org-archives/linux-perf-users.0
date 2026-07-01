Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E938F252
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878655; cv=none; b=hn3MSSRSj2WwqYI4h/GhPeL6UhloKbhDwaRUrNr0fg3C3T2e+2HEI5m0UVWWfFZgpTmc/T9XFVpQ8ec1s77/ulE7Nqyynw5GWT/C7lf/zMKnW++qa4+FuJCc8cV8pr1k4aAXRn2lpbEvT+hqPc52XYJsXPGu8nYcPEyJX5onA/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878655; c=relaxed/simple;
	bh=+g+8+srrQlhZuF2LuTtdtFqGtUOPJvWLkGTd6JMSTHQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qj95uUA/xl1tnpkzfAGnGAAIO0TzQ/pSjY0Q6lWXc6B+DM2UeqkwKCxOdiYKZ4JvONGy4f4rWOcutvtIuahq2NxJm948QptP13EoK8ctMQmRcNB/lpoghgcR4wN6eq/xEaVcUwIj2Tme6SH4SBTbfQb8xQI06Jgfc6EBQuf/9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br7tjpmA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br7tjpmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FC61F000E9;
	Wed,  1 Jul 2026 04:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782878650;
	bh=oWvYVwrhh0KRWHHwEhss6IN4tPMS0TI3vWbmQpy1nZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=br7tjpmA1xqO78O2VS8uiQOEnG+gH/y4rcC9xgV7PZWsdLp3cNBAvR/1DRawHwGSy
	 CaO3j9xLKq9mwKPYUsDE2aUE+gY4/22Rooexf+dXSGgTva8JdQS98fMAeMVyqcMSSL
	 v+Y0A1szIrQoo80mxLhMV/vyJ6LSz3IrU5nmwRHm6dB4CrbubwSueM7Ewpbpt7bwvo
	 m0Ooem3biZvDwq1XFc0F/67wF7XsY+v3AKN91jThc4BxJgCp6j6Z7xDPdT7GhHKZcZ
	 qbDAFVBNY4AQ031aInR3qXqKy2y4njbiAcNZd6QlsiCo5HH6SgXTJdU5AN/pFcQMs8
	 jayxmb5qzkJxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf/x86/amd/uncore: Add common PMU helper
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Liu" <liuqi@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701034413.718872-2-liuqi@hygon.cn>
References: <20260701034413.718872-1-liuqi@hygon.cn>
 <20260701034413.718872-2-liuqi@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:04:09 +0000
Message-Id: <20260701040409.E5FC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional and improperly ordered context hijacking in `uncore_=
common_ctx_move` permanently breaks the PMU.
--

commit 43a9758bb17897ce6b1730e5454983946f9d832d
Author: Qi Liu <liuqi@hygon.cn>

perf/x86/amd/uncore: Add common PMU helper functions

This patch introduces common helper functions for AMD-family uncore PMU
handling. It provides infrastructure for event initialization, counter
allocation, reading, and context management for reuse by similar drivers.

> diff --git a/arch/x86/events/amd/uncore_common.c b/arch/x86/events/amd/un=
core_common.c
> new file mode 100644
> index 0000000000000..81affaab319a2
> --- /dev/null
> +++ b/arch/x86/events/amd/uncore_common.c
[ ... ]
> +static enum hrtimer_restart uncore_common_hrtimer(struct hrtimer *hrtime=
r)
> +{
> +	struct uncore_common_ctx *ctx;
> +	struct perf_event *event;
> +	int bit;
> +
> +	ctx =3D container_of(hrtimer, struct uncore_common_ctx, hrtimer);
> +
> +	if (!ctx->nr_active || ctx->cpu !=3D smp_processor_id())
> +		return HRTIMER_NORESTART;

[Severity: High]
This is a pre-existing issue, but could this condition trigger incorrectly =
and
permanently stop the hrtimer?

If ctx->cpu is left pointing to an old CPU or assigned to a different sibli=
ng,
this will evaluate to true and prevent the timer from restarting.

[ ... ]
> +void uncore_common_ctx_move(struct uncore_common *uncore, unsigned int c=
pu)
> +{
> +	struct uncore_common_ctx *curr, *next;
> +	struct uncore_common_pmu *pmu;
> +	int i, j;
> +
> +	if (!uncore->init_done)
> +		return;
> +
> +	for (i =3D 0; i < uncore->num_pmus; i++) {
> +		pmu =3D &uncore->pmus[i];
> +		if (!pmu->ctx)
> +			continue;
> +
> +		curr =3D *per_cpu_ptr(pmu->ctx, cpu);
> +		if (!curr)
> +			continue;
> +
> +		for_each_online_cpu(j) {
> +			if (cpu =3D=3D j)
> +				continue;
> +
> +			next =3D *per_cpu_ptr(pmu->ctx, j);
> +			if (!next)
> +				continue;
> +
> +			if (curr =3D=3D next) {
> +				perf_pmu_migrate_context(&pmu->pmu, cpu, j);
> +				cpumask_clear_cpu(cpu, &pmu->active_mask);
> +				cpumask_set_cpu(j, &pmu->active_mask);
> +				next->cpu =3D j;
> +				break;
> +			}
> +		}
> +	}
> +}

[Severity: High]
This isn't a bug introduced by this patch, but does the way this context is
moved cause the hrtimer to permanently break in two scenarios?

First, if a non-active sibling CPU goes offline, this code unconditionally
assigns next->cpu =3D j without verifying if (cpu =3D=3D curr->cpu). If the=
 first
online sibling it finds is not the currently active CPU (where events are
running), the active CPU gets hijacked. When the hrtimer fires on the active
CPU, ctx->cpu !=3D smp_processor_id() will be true, permanently stopping the
timer.

Second, if the active CPU is offlining, the next->cpu =3D j assignment happ=
ens
after perf_pmu_migrate_context(). If the thread is preempted after migration
but before the assignment, could the newly armed timer on CPU j fire before
next->cpu is updated? This would also permanently stop the timer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701034413.7188=
72-1-liuqi@hygon.cn?part=3D1
