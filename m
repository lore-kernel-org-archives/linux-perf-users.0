Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D4481FD0;
	Wed,  5 Aug 2026 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946376; cv=none; b=fOqXMLyXAA9nnUalF/E6Totko2Qhal/5scOIWi+L93+cqSs4I7xC+QmZfoGpXLaA3oZxaJVDmfivPpYvX2Lu3J5yjXgDAzkHax7ghSDyu5naVMjmPnsEcX8FAbU/ARMA3UuI4OeR3XipbyRdznTj7viJ7dVyrAjqKGNeHEqrDDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946376; c=relaxed/simple;
	bh=CCGnQR/4Z5yg0hm3+6o1I14J4gjGxFnrMXienxGqprs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kGCL72buDn5bw4PO/lZrrIomVilmkrKmxekYmlKxUZvu4J0Vu/+5LA0bwy/Y3oJzaHo8AbUaEPEelvtPde86ixN1BYLpvWnAI9YbgfCzxo5AArmz3dREsAdslzRx5zWVpJ9tHtc8j4hkumM0w/jCZ1LkTO8/ALt8+J9HqxQOGtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lnyw7cd+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lnyw7cd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32991F000E9;
	Wed,  5 Aug 2026 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785946374;
	bh=Q89lm7fd8mLESN6OLNhIQz7xQs6QhRGlEWKoEBMIQqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lnyw7cd+Bl+CeeryyBxh8OOcNJcvO5l8FDevD+xSMrxNSZ1hyPJtdnvdDR4giOyuf
	 ygTck9CzupgVzKBH3VLtLWKecwa7EHu94913KXb4yXokLM3E0EETX+5sjFGeWPS3kw
	 SPgSLrYc2g5Uwhfk0OYPEi/ZrEUSOvPO6L9PDeUvLacbJIIx2fHgelprM1zQjvXRpC
	 dzZI98wyV+XWDnWeV5SbgVyPb+EFPH4Vh/ZoUrrilG6BlcF73FVoicyBxZ177wbDRM
	 qJoPCwiOuLSW/64QFNQaAu2ZH8FptWFqQFLr8zNKdcHt3Kqv1mvBmgARLjks55qZlD
	 RADQv0Nqq+/zQ==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v4 02/11] perf/cxl: Clear stale event fields
 before reprogramming a counter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260805155911.1304807-3-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
 <20260805155911.1304807-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:12:52 +0000
Message-Id: <20260805161253.C32991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect 64-bit write (writeq) to a 32-bit hardware filter config=
uration register.
- [High] Incorrect PMU counter overflow handling logic leads to massive ove=
rcounting and Undefined Behavior (UB) via out-of-bounds bitwise shift.
--

--- Patch [2]: [RESEND PATCH v4 02/11] perf/cxl: Clear stale event fields b=
efore reprogramming a counter ---
commit 215e20dd2e223d030442e8b7a911140cd3ebb0bf
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Clear stale event fields before reprogramming a counter

This patch fixes an issue in cxl_pmu_event_start() where previous event
settings were accumulated instead of cleared. It uses FIELD_MODIFY() to
ensure event group ID, mask, edge, and invert selections replace the old
values, preventing counters from using stale configuration.

Link: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.=
net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index ff01b658e1b45..b16e2e4090a39 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -646,17 +646,17 @@ static void cxl_pmu_event_start(struct perf_event *=
event, int flags)
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
> =20
>  	/* Fixed purpose counters have next two fields RO */
>  	if (test_bit(hwc->idx, info->conf_counter_bm)) {
> -		cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK,
> -				  hwc->event_base);
> -		cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENTS_MSK,
> -				  cxl_pmu_config_get_mask(event));
> +		FIELD_MODIFY(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, &cfg,
> +			     hwc->event_base);
> +		FIELD_MODIFY(CXL_PMU_COUNTER_CFG_EVENTS_MSK, &cfg,
> +			     cxl_pmu_config_get_mask(event));
>  	}
>  	cfg &=3D ~CXL_PMU_COUNTER_CFG_THRESHOLD_MSK;
>  	/*

[Severity: High]
This isn't a bug introduced by this patch, but while looking at
cxl_pmu_event_start(), does this writeq() overwrite the configuration
for the adjacent filter?

drivers/perf/cxl_pmu.c:cxl_pmu_event_start() {
    ...
	if (info->filter_hdm) {
		if (cxl_pmu_config1_hdm_filter_en(event))
			cfg =3D cxl_pmu_config2_get_hdm_decoder(event);
		else
			cfg =3D GENMASK(31, 0); /* No filtering if 0xFFFF_FFFF */
		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
	}
    ...
}

CXL_PMU_FILTER_CFG_REG has a 4-byte stride, making it a 32-bit hardware
register. Using the 64-bit writeq() here spills into filter 1. If filter 0
is disabled (cfg =3D 0xFFFFFFFF), writeq() writes 0x00000000 to filter 1,
which would inadvertently enable filter 1 with a 0-match condition.


[Severity: High]
This is a pre-existing issue, but I also noticed a potential undefined
behavior in the overflow handling logic nearby:

drivers/perf/cxl_pmu.c:__cxl_pmu_read() {
    ...
	delta =3D (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0);
	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
		delta +=3D (1UL << info->counter_width);

	local64_add(delta, &event->count);
}

Since delta already accounts for one wraparound via the bitwise AND when
new_cnt is less than prev_cnt, does unconditionally adding 2^width on
overflow cause massive overcounting?=20

Also, can (1UL << info->counter_width) cause an out-of-bounds bitwise
shift resulting in undefined behavior? The CXL specification allows
counter_width to be 64, which would shift beyond the width of an unsigned
long, and on 32-bit architectures this could happen for a width of 32 or
greater.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805155911.1304=
807-1-dave.jiang@intel.com?part=3D2
