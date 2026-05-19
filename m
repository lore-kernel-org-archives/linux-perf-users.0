Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C942F260F
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779163657; cv=none; b=gMllDHH3xlM49uiWGm/wHVCyN1NmI1118qbMBn3tdNBxzYCtNT+Wqavg3yEmujZgDM04omY97YmVD/SlQy+pWZOZGRcrfp3DbuMsCHqYyqMaVEU7JXkvClsYuJi+hKIdoIaWwl5xiBsP6jWbaEgP8kDSalQkLTsBCTnbCExdQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779163657; c=relaxed/simple;
	bh=hrIi8ODvmyooj/p5pDpUxud0y4xpXyALL+SE63penZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q/Cu5myl7mXsOIyoPHPh0oiZhN0U9BxlJC4PKHBu0pji3pDwdl7TiJGq5tAehQ+YOIHSjNg11TnAaBYKKU/Rzm5uK4VyVaybBfSry3uo/aokd0HgDiUYDhKfL61FsY60mlK/envYiaVg0AsxKcfkiMoo2HA9nRf1hXxu3cmgUh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M13DL0LB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M13DL0LB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9206C2BCB3;
	Tue, 19 May 2026 04:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779163656;
	bh=hrIi8ODvmyooj/p5pDpUxud0y4xpXyALL+SE63penZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=M13DL0LBnkAc2F2odobLII/yFbrge5CcAi7OuX2II8//57MwH8GaBKMzuw2USC7hE
	 k1bZ0EoO3YASZroDdh+xQPpM/NgIdFaCqk2LIxlI6syefRPwFkmnRt/4D2yWeWU7tG
	 geSR6lx+S1VGho9L3oQKY27kU0db+vyd4f+2S63ZwyUfbpHFdrno0YVnE32x9BvLIk
	 bAIHXBDabCca1ebvFKRh4hhzhyczE8lbNwJyCxwSANMw1O1qKqpUScUZcjHZLWuluq
	 WnqRNswmoaEbm0U4UZ1NEtpriuq74IEzEK2W4tTJ2Gjl7ClLT2Lfb60V0/X+VLjE/q
	 hmRqe8Xy55jpQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] perf/x86/amd/uncore: Add common PMU helper
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Liu" <liuqi@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260519033225.1479907-2-liuqi@hygon.cn>
References: <20260519033225.1479907-2-liuqi@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 04:07:36 +0000
Message-Id: <20260519040736.A9206C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] uncore_common_ctx_free() frees the PMU context without cancelling =
its hrtimer or verifying all events are removed, leading to UAF and NULL-po=
inter dereferences.
- [High] Unconditional double-stop of PMU events underflows ctx->nr_active,=
 permanently breaking the hrtimer.
- [High] Unsanitized event->attr.config is written directly to hardware MSR=
s, enabling kernel panics and failing to stop counters.
- [Medium] Race condition during CPU context migration permanently disables=
 the hrtimer on the destination CPU.
- [Low] Missing bounds check on pmu->num_counters can lead to an out-of-bou=
nds write.
--

commit f16450b9a54bbeb570f328c8a8626473a456f6b8
Author: Qi Liu <liuqi@hygon.cn>

perf/x86/amd/uncore: Add common PMU helper functions
   =20
Add common helper functions for AMD-family uncore PMU handling.
The helpers cover event initialization, counter allocation, counter
read/update, event start/stop and per-CPU context management.

> diff --git a/arch/x86/events/amd/uncore_common.c b/arch/x86/events/amd/un=
core_common.c
> new file mode 100644
> index 0000000000000..a6d50fe803df3
> --- /dev/null
> +++ b/arch/x86/events/amd/uncore_common.c
[ ... ]
> +void uncore_common_stop(struct perf_event *event, int flags)
> +{
> +	struct uncore_common_pmu *pmu =3D event_to_uncore_common_pmu(event);
> +	struct uncore_common_ctx *ctx =3D *per_cpu_ptr(pmu->ctx, event->cpu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +
> +	wrmsrq(hwc->config_base, hwc->config);
> +	hwc->state |=3D PERF_HES_STOPPED;
> +
> +	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
> +		event->pmu->read(event);
> +		hwc->state |=3D PERF_HES_UPTODATE;
> +	}
> +
> +	if (!--ctx->nr_active)
> +		uncore_common_cancel_hrtimer(ctx);

When a perf event is closed, free_event() calls pmu->del(), which maps to
uncore_common_del(). Since uncore_common_del() unconditionally calls
event->pmu->stop(), and the event was likely already stopped by
event_sched_out(), could this cause ctx->nr_active to underflow (e.g., from
0 to -1) because there is no check if the event is already stopped?

If ctx->nr_active underflows, a subsequent event start will evaluate
!ctx->nr_active++ as false (!-1 is 0), which would fail to call
uncore_common_start_hrtimer(), causing the hardware counters to silently
overflow.

> +
> +	__clear_bit(hwc->idx, ctx->active_mask);
> +}
> +
> +int uncore_common_event_init(struct perf_event *event)
> +{
> +	struct uncore_common_pmu *pmu;
> +	struct uncore_common_ctx *ctx;
> +	struct hw_perf_event *hwc =3D &event->hw;
> +
> +	if (event->attr.type !=3D event->pmu->type)
> +		return -ENOENT;
> +
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	pmu =3D event_to_uncore_common_pmu(event);
> +	ctx =3D *per_cpu_ptr(pmu->ctx, event->cpu);
> +	if (!ctx)
> +		return -ENODEV;
> +
> +	hwc->config =3D event->attr.config;

Is it safe to copy the user-supplied event->attr.config directly to
hwc->config without any sanitization or bit masking?

If a user configures an event with reserved hardware bits set, could the
later call to wrmsrq() trigger a General Protection Fault and crash the
kernel?

Additionally, if the user explicitly sets the hardware enable bit (e.g.,
ARCH_PERFMON_EVENTSEL_ENABLE), wouldn't uncore_common_stop() fail to
actually stop the counter when it writes this configuration back to the MSR?

> +	hwc->idx =3D -1;
> +
> +	event->cpu =3D ctx->cpu;
> +
> +	return 0;
> +}
> +
> +int uncore_common_add(struct perf_event *event, int flags)
> +{
> +	struct uncore_common_pmu *pmu =3D event_to_uncore_common_pmu(event);
> +	struct uncore_common_ctx *ctx =3D *per_cpu_ptr(pmu->ctx, event->cpu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int i;
> +
> +	/* are we already assigned? */
> +	if (hwc->idx !=3D -1 && ctx->events[hwc->idx] =3D=3D event)
> +		goto out;
> +
> +	for (i =3D 0; i < pmu->num_counters; i++) {

Is there a bounds check to ensure pmu->num_counters does not exceed
NUM_COUNTERS_MAX?

ctx->active_mask is sized based on NUM_COUNTERS_MAX. If a PMU is initialized
with more than 64 counters, couldn't a later __set_bit(hwc->idx,
ctx->active_mask) write out of bounds and corrupt adjacent memory?

> +		if (ctx->events[i] =3D=3D event) {
> +			hwc->idx =3D i;
> +			goto out;
> +		}
> +	}
[ ... ]
> +void uncore_common_ctx_free(struct uncore_common *uncore, unsigned int c=
pu)
> +{
> +	struct uncore_common_pmu *pmu;
> +	struct uncore_common_ctx *ctx;
> +	int i;
> +
> +	if (!uncore->init_done)
> +		return;
> +
> +	for (i =3D 0; i < uncore->num_pmus; i++) {
> +		pmu =3D &uncore->pmus[i];
> +
> +		if (!pmu->ctx)
> +			continue;
> +
> +		ctx =3D *per_cpu_ptr(pmu->ctx, cpu);
> +		if (!ctx)
> +			continue;
> +
> +		if (cpu =3D=3D ctx->cpu)
> +			cpumask_clear_cpu(cpu, &pmu->active_mask);
> +
> +		if (!--ctx->refcnt) {
> +			kfree(ctx->events);
> +			kfree(ctx);
> +		}

When the last CPU in the PMU's domain goes offline, ctx->refcnt will drop
to 0 and ctx is freed. However, is there anything ensuring hrtimer_cancel()
is called if there are still active events attached?

If the hrtimer is still running, it will execute on the freed ctx memory.

> +
> +		*per_cpu_ptr(pmu->ctx, cpu) =3D NULL;

Additionally, since the user's perf_event file descriptors remain valid,
when the user later closes them, uncore_common_del() will attempt to access
the context.

Since *per_cpu_ptr(pmu->ctx, cpu) is set to NULL here, won't that result
in a NULL-pointer dereference?

> +	}
> +}
> +
> +void uncore_common_ctx_move(struct uncore_common *uncore, unsigned int c=
pu)
> +{
> +	struct uncore_common_ctx *curr, *next;
> +	struct uncore_common_pmu *pmu;
> +	int i, j;
[ ... ]
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

Should next->cpu =3D j be set before calling perf_pmu_migrate_context()?

perf_pmu_migrate_context() synchronously installs and starts events on the
destination CPU, which arms the hrtimer. If the hrtimer expires before the
migration thread reaches next->cpu =3D j, uncore_common_hrtimer() will
observe that ctx->cpu !=3D smp_processor_id() and return HRTIMER_NORESTART.

This would permanently disable the PMU timer on the new CPU.

> +				break;
> +			}
> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519033225.1479=
907-1-liuqi@hygon.cn?part=3D1
