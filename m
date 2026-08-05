Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D554582EF
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946074; cv=none; b=otiX8a1IjbX2xDYCEVMvzH/QC7eNRRT5P0Bc7SdEx7GieaaW6QZg1i8OaKijBX4aefuiqTkM7c9+gT59Ey5+IUoXxSV6YTOfR1fFlyK2X3Jf8yZGv4jOuq+tdDdN62lyD8eB+fuunay1M8k8AhyHkauQzeRZWSDQ6XTgXbfKnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946074; c=relaxed/simple;
	bh=YmBA/w4Jf1r7Xrryhp5T9qKYwFWyTlk2/YDtCrUPZMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nX8DgttyMxa441Nn4xKGDpQblNAyjxeBZZ+1nDD5K84hIJtcFdiu1zJE0v3Zgvxq6itDZ9eBzd3Tkp3+rpem/qCcFh/tZ+L7kyDD+G+UFfnsk2o+RsbT5eb6sv+KkbSY0n1JS6egEO7ICSIVj2ZxHwgdxI0Chk5XdGyA1eLO9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpW4LJ21; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpW4LJ21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E671F00A3D;
	Wed,  5 Aug 2026 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785946069;
	bh=/Y8UIN3NG9jAUoqcziRBpJzXinu0TuNuepShbeJ6gR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dpW4LJ21tsNN4oxP5f663qS+VxQ6pru/+fg/qdUQknineVpznws8vGhQwIzZRY9Yz
	 HfL5U2bo+fxjtGJLJ7H3L8myLvzq1QVrbyLAj4g+kn5qoQG1ndxh16CrPPFgvnw554
	 f6P7jbwZlf76lmkdKygT1zCWsW1YhMEY1WOkZuUpUzbkJTGkpI2OwPBlMpQbnB4IsG
	 CXzJsqgZp3EtXcRZqEIP6abCdcN8gomWKvbjOErPiGxTemeAAUH5k509ixHxXzqGsx
	 /ltqPByojBSDXvMVkU2kAfnHk4Gh2bceqqS/msmzUbKJWR6jGBB+hR5nYmTjKQIA5G
	 1Oj/FZrljzWHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/11] perf/cxl: Clear stale event fields before
 reprogramming a counter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805155501.1294472-3-dave.jiang@intel.com>
References: <20260805155501.1294472-1-dave.jiang@intel.com>
 <20260805155501.1294472-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:07:49 +0000
Message-Id: <20260805160749.A0E671F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Writing to the 32-bit filter configuration register with `writeq` =
(64-bit) overwrites the adjacent filter register, causing silent event drop=
s on hardware with multiple filters.
- [High] The overflow calculation in `__cxl_pmu_read()` double-counts event=
s by erroneously adding `2^width` to a correctly computed delta.
--

--- Patch [2]: [PATCH v4 02/11] perf/cxl: Clear stale event fields before r=
eprogramming a counter ---
commit 54f01a971c5fe0d0d8f7face1960b3232e30fafb
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Clear stale event fields before reprogramming a counter
   =20
This commit uses FIELD_MODIFY() to clear stale event fields before
reprogramming a counter. This ensures new selections don't land on top of
old ones when reusing counters.

Link: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.=
net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c

[ ... ]

> @@ -638,30 +638,30 @@ static void cxl_pmu_event_start(struct perf_event *=
event, int flags)
>  	if (info->filter_hdm) {
>  		if (cxl_pmu_config1_hdm_filter_en(event))
>  			cfg =3D cxl_pmu_config2_get_hdm_decoder(event);
>  		else
>  			cfg =3D GENMASK(31, 0); /* No filtering if 0xFFFF_FFFF */
>  		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));

[Severity: High]
This isn't a bug introduced by this patch, but could this writeq()
unintentionally overwrite the adjacent filter register?

Since CXL_PMU_FILTER_CFG_REG is a 32-bit register and writeq() performs a
64-bit write, the variable cfg (which has 0 in its upper 32 bits) will
inadvertently zero out the adjacent 32 bits corresponding to Filter 1.

Because writing 0 enables a filter and forces an exact match of 0, any
hardware implementing Filter 1 will logically AND it with Filter 0,
effectively dropping all non-zero events.

>  	}
> =20
>  	cfg =3D readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
>  	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
>  	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW, 1);
>  	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_ENABLE, 1);
> -	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EDGE,
> -			  cxl_pmu_config1_get_edge(event) ? 1 : 0);
> -	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_INVERT,
> -			  cxl_pmu_config1_get_invert(event) ? 1 : 0);
> +	FIELD_MODIFY(CXL_PMU_COUNTER_CFG_EDGE, &cfg,
> +		     cxl_pmu_config1_get_edge(event) ? 1 : 0);
> +	FIELD_MODIFY(CXL_PMU_COUNTER_CFG_INVERT, &cfg,
> +		     cxl_pmu_config1_get_invert(event) ? 1 : 0);

[ ... ]

> @@ -700,10 +700,10 @@ static void __cxl_pmu_read(struct perf_event *event=
, bool overflow)
>  	/*
>  	 * If we know an overflow occur then take that into account.
>  	 * Note counter is not reset as that would lose events
>  	 */
>  	delta =3D (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0=
);
>  	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
>  		delta +=3D (1UL << info->counter_width);

[Severity: High]
This is a pre-existing issue, but is it possible this addition double-counts
events?

The 2's complement arithmetic delta =3D (new_cnt - prev_cnt) & GENMASK_ULL(=
...)
already naturally calculates the delta across a single wrap-around. For
example, with a 32-bit counter, 0x10 - 0xFFFFFFF0 masked strictly yields 0x=
20.

If this condition evaluates to true, it injects an additional 2^width into
the delta, reporting billions of extraneous events per normal overflow.

Additionally, if info->counter_width is 64, does 1UL << 64 result in
undefined behavior in C?

>  	local64_add(delta, &event->count);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805155501.1294=
472-1-dave.jiang@intel.com?part=3D2
