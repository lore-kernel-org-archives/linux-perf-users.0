Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2646DFF6;
	Fri, 31 Jul 2026 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541241; cv=none; b=Oo4lUbv6vZlkXAdD3xpMRDpqVZ9C0jsMY3Iv7fcFDHQPvnOHk05KtvcJc1/aBDSC+tIAzSuopCxDUI5Zf7iHgCtjs0WR97VDeIQ4IgCVZthRBoxbe5bwqt4EaaCbqBPB//kjDfToJpsySdgL1rmlwX/vKUxmgXrbQ2r4vrK+4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541241; c=relaxed/simple;
	bh=zAPoIHo9Sw0Pa8KhlliXVTFTMU0/1NjrYJ+qY1UA7LM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sHJeVUNoKY0prQM439aPt2HwKbPZ4KfpF1sgUYOQgIY9uYumVt1pGGZQ6HI4nPMtKKT5wiMqOxbci6r5o8GGoKmAiX2RbVsSXN5n2ht+KxUVZjy2A4H9ian/UZSfutRnOEmPOr1nvUjcN7TkncjfyCF17TUMSWlW4OcICCuSdSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6IMa5XQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6IMa5XQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627B01F00AC4;
	Fri, 31 Jul 2026 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541239;
	bh=o/FjPsnFkJkaHXDaSK+ssn+hHf8/X7Zr6GetgkMA6ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l6IMa5XQ0+VC2KRgGcXuJcYaLNzh8zYSGFpPLgN4VABzZ+Rp2x+KhjpFCh4gcNJXM
	 H2+tekRLCYSVnu+395hNLpR87/AR1CQjWZRrNQQdiaVc2jKrPQiC77VPU/Lxm/5diU
	 RZLu97K/hD50OiDpdpTCh+UB5QxJWNBKupoRCcg54r9CwRQS4tpZ+mB4Tc1+j/5yT8
	 ICsTOl3cI1ExkzAIu2CVjBhKWX04fZ3EDAf6O4hxr9XNrfbvrrMtmP5vdF7eJqRoAA
	 ffCQAmQYKgodZf/MopTDDrFEpMKuSvQvBAoxEpYtZpiCIVc+p1JXltIEaKo88g/BIr
	 EhNQLTRLfIfvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] perf/cxl: Unfreeze counters after handling an
 overflow interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260731232827.401447-8-dave.jiang@intel.com>
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-8-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 23:40:39 +0000
Message-Id: <20260731234039.627B01F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Cross-CPU data race on local64_t variables and spurious counter in=
crements during CPU hotplug migration.
- [High] Unregistering the PMU before removing the CPU hotplug instance cre=
ates a Use-After-Free window during driver removal.
--

--- Patch [7]: [PATCH v3 7/9] perf/cxl: Unfreeze counters after handling an=
 overflow interrupt ---
commit d6decd45c5a5019eddbbf261ba3f712c1ad75535
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Unfreeze counters after handling an overflow interrupt

This patch ensures CXL PMU counters are unfrozen after clearing an overflow
interrupt. Previously, counters remained frozen until the next pmu_enable(),
causing events to be lost during that window. It tracks the PMU enabled
state to avoid unfreezing if the PMU was disabled concurrently.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 6fdc66a01fb67..580a75bc9210a 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c

[ ... ]

> @@ -803,6 +807,9 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
> =20
>  	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);
> =20
> +	if (READ_ONCE(info->enabled))
> +		writeq(0, base + CXL_PMU_FREEZE_REG);
> +
>  	return IRQ_HANDLED;
>  }

[Severity: High]
This is a pre-existing issue, but can this sequence corrupt performance
counters during CPU hotplug?

Looking at cxl_pmu_offline_cpu(), perf_pmu_migrate_context() is called
before the IRQ affinity is updated:

drivers/perf/cxl_pmu.c:cxl_pmu_offline_cpu() {
	...
	perf_pmu_migrate_context(&info->pmu, cpu, target);
	info->on_cpu =3D target;
	/*
	 * CPU HP lock is held so we should be guaranteed that this CPU hasn't
	 * yet gone away.
	 */
	WARN_ON(irq_set_affinity(info->irq, cpumask_of(target)));
	...
}

If an overflow MSI is delivered to the old CPU in this narrow window,
cxl_pmu_irq() runs on the old CPU. If the new CPU has already re-added and
started the event, it has cleared hwc->prev_count to 0.

Because the hardware overflow register is only cleared by the IRQ handler,
the old CPU sees a stale overflow flag and invokes __cxl_pmu_read(). The
condition new_cnt >=3D prev_cnt passes (since prev_cnt is 0), causing it to
erroneously add a full period (mask + 1) to the counter:

drivers/perf/cxl_pmu.c:__cxl_pmu_read() {
	...
	do {
		prev_cnt =3D local64_read(&hwc->prev_count);
		new_cnt =3D cxl_pmu_read_counter(event);
	} while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) !=3D prev_cn=
t);

	/* ... */
	mask =3D GENMASK_ULL(info->counter_width - 1, 0);
	delta =3D (new_cnt - prev_cnt) & mask;
	if (overflow && new_cnt >=3D prev_cnt)
		delta +=3D mask + 1;

	local64_add(delta, &event->count);
}

Does this also cause a data race since local64_t operations lack cross-CPU
atomic guarantees?

[Severity: High]
This isn't a bug introduced by this patch, but does the devm teardown order
create a use-after-free window during driver removal?

In cxl_pmu_probe(), the CPU hotplug instance is registered before the PMU:

drivers/perf/cxl_pmu.c:cxl_pmu_probe() {
	...
	rc =3D cpuhp_state_add_instance(cxl_pmu_cpuhp_state_num, &info->node);
	if (rc)
		return rc;

	rc =3D devm_add_action_or_reset(dev, cxl_pmu_cpuhp_remove, info);
	if (rc)
		return rc;

	rc =3D perf_pmu_register(&info->pmu, info->pmu.name, -1);
	if (rc)
		return rc;

	rc =3D devm_add_action_or_reset(dev, cxl_pmu_perf_unregister, info);
	...
}

During driver removal, devm executes actions in LIFO order.
cxl_pmu_perf_unregister() runs first, delegating to perf_pmu_unregister(),
which frees pmu->cpu_pmu_context.

If a CPU is offlined concurrently before cxl_pmu_cpuhp_remove() runs,
cxl_pmu_offline_cpu() is invoked:

drivers/perf/cxl_pmu.c:cxl_pmu_offline_cpu() {
	...
	perf_pmu_migrate_context(&info->pmu, cpu, target);
	...
}

Will perf_pmu_migrate_context() access the freed cpu_pmu_context when it
calls find_get_pmu_context()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731232827.4014=
47-1-dave.jiang@intel.com?part=3D7
