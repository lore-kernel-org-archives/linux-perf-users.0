Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1C395AF5;
	Wed, 15 Jul 2026 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784146060; cv=none; b=NyhqIRyaB5jUCV/DelkQbmolj8in795CYjUU4pwKZWVE1THbVulRZgSE3rqAg/aNi/O3s6unSM8AlIE6qm9wnTCInjYNLB/xqAphiCqPW+znhMhXbxgjx7cm2HY5IlO/Nn3MR5qOld1EKn3wIRvLfkFl1wcQa0hP/kmVZRyv2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784146060; c=relaxed/simple;
	bh=F3SFr5brgqcEl/ySD/OLX1l0nukwaoO7RUJUyX0CsYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XQJyvyLheT2D1HsaZLiEiW8DqnUEAsHt1TmBIRkfbtijVy7MVKr9khj2mDr6Q6WMB3pJxQ5LBjTu38psQdG+1Oese86noKcyFWRX0m1hwppP63HquXuvXsQeXV0Bg8b9SKSlO0wrLdIqpLZfxl8LwdpuF+plHDiQKCLbYN0UfS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEib2G7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEib2G7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752801F000E9;
	Wed, 15 Jul 2026 20:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784146058;
	bh=4O9RsrXMZkTT74INtHWJeLGYsnB7XL033aH/Eg1rVE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lEib2G7gOcLGEfiNd3lwYAI2TbidPxTURPSJT78+hB4YOkYu6NML6QUlQAvQEISKP
	 ndNUpEX/97iHwuefzEhlVcstNpFvUg81Wn/r7buNWE131RHelw/85/FBr2uuQlpljC
	 2gYMREhLzlkWC/F3FYaNTJKv4GxM+ddsqHdgx+0QuiuUKI9bA8hLvC0m/ZVuwomX2Y
	 /Vd+oH1zoxZYGy7Jy7VBx0AspjNdz9xTQNGSIqeJyx8K4y2+5zPZQB1Ytw0Smx+fft
	 5y1DCf1jAcALNvYDh00x7OP5/95YfA2MqCGIS9EOKYiRAZVxLT70PeGXNxDnGrJAE/
	 bjBDZvz4lSEpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] perf/cxlpmu: Fix 64-bit write to 32-bit HDM
 filter register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260715191454.459673-2-dave@stgolabs.net>
References: <20260715191454.459673-1-dave@stgolabs.net>
 <20260715191454.459673-2-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 20:07:37 +0000
Message-Id: <20260715200738.752801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver updates the counter configuration register using bitwis=
e OR without first clearing the relevant fields, causing stale bits to accu=
mulate from previous events.
- [High] The CPU hotplug instance is removed after the PMU is unregistered =
during driver teardown, causing a Use-After-Free if a CPU goes offline conc=
urrently.
- [High] The `cxl_pmu_get_event_idx` function fails to set the `event_idx` =
output parameter for configurable counters, resulting in silently measuring=
 the wrong events.
--

--- Patch [1]: [PATCH v4 1/3] perf/cxlpmu: Fix 64-bit write to 32-bit HDM f=
ilter register ---
commit 1a1b5ade4d63271a0649378648434d5656079fd5
Author: Davidlohr Bueso <dave@stgolabs.net>

perf/cxlpmu: Fix 64-bit write to 32-bit HDM filter register

The HDM decoder filter configuration register is 32 bits wide, but the
driver programs it with a 64-bit writeq(). The filter value never
exceeds 32 bits, so the upper half of the write is always zero and
lands in the adjacent Filter ID 1 (Channel/Rank/Bank) configuration
register at offset+4.

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 68a54d97d2a8a..39b46550a5109 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -635,7 +635,7 @@ static void cxl_pmu_event_start(struct perf_event *ev=
ent, int flags)
>  			cfg =3D cxl_pmu_config2_get_hdm_decoder(event);
>  		else
>  			cfg =3D GENMASK(31, 0); /* No filtering if 0xFFFF_FFFF */
> -		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
> +		writel(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
>  	}
> =20
>  	cfg =3D readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
>  	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK,
>  			  hwc->event_base);
>  	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENTS_MSK,
>  			  cxl_pmu_config_get_mask(event));

[Severity: High]
This is a pre-existing issue, but does this bitwise OR accumulate stale bits
from previous events?

When setting CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK and
CXL_PMU_COUNTER_CFG_EVENTS_MSK, the fields are not cleared first. If a new
event is allocated to a previously used counter, it seems it will inherit
the old event's bits, resulting in a bitwise OR of both events.

Should the relevant masks be cleared before applying the new fields to prev=
ent
incorrect statistics?


While reviewing this, I also noticed a few other pre-existing issues in
this file that might need addressing:

> drivers/perf/cxl_pmu.c:cxl_pmu_get_event_idx() {
> [ ... ]
> 		if (test_bit(i, info->conf_counter_bm) &&
> 		    test_bit(i, info->used_counter_bm)) {
> 			*counter_idx =3D i;
> 			return 0;
> 		}
> [ ... ]
> }

[Severity: High]
This isn't a bug introduced by this patch, but are we missing an assignment
to the event_idx output parameter here?

When a configurable counter is matched, *counter_idx is set, but it
appears *event_idx is omitted.

Since the caller initializes event_idx to 0, does this mean the counter
will always be programmed to count the event group at index 0, silently
ignoring the requested event group?


> drivers/perf/cxl_pmu.c:cxl_pmu_probe() {
> [ ... ]
> 	rc =3D cpuhp_state_add_instance(cxl_pmu_cpuhp_state_num, &info->node);
> 	if (rc)
> 		return rc;
>=20
> 	rc =3D devm_add_action_or_reset(dev, cxl_pmu_cpuhp_remove, info);
> 	if (rc)
> 		return rc;
>=20
> 	rc =3D perf_pmu_register(&info->pmu, info->pmu.name, -1);
> [ ... ]
> }

[Severity: High]
This is a pre-existing issue, but does the registration order here create a
use-after-free race during teardown?

The devm framework executes teardown actions in last-in first-out order.
Because the CPU hotplug instance is registered before the PMU, the PMU is
unregistered first during teardown.

When perf_pmu_unregister() frees the PMU's per-CPU context, if a CPU
hotplug offline event occurs concurrently:

cxl_pmu_offline_cpu()
   perf_pmu_migrate_context()

Could this access the freed per-CPU context since the hotplug instance
has not been removed yet?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715191454.4596=
73-1-dave@stgolabs.net?part=3D1
