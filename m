Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66C47988D;
	Fri, 31 Jul 2026 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541231; cv=none; b=npF5cKpX8c6OOd6iwUek9bsKlocKHc9kGzKjYqaoSYzPOfH1q+E5IES3shP4uX4yk8ngerUTFn36xd30d5upFYp0a/Sca+/jS9H8hWcnCfpSKUa+AvdvAl3lv4VjBoWoamTZiUeLLo9BZHYK/SKe9fr5XUk0Qpvz/3O2Q27ULv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541231; c=relaxed/simple;
	bh=74g6ifi5Mua94lMDuKotEGbdlU1+fgkzb9KUjm2bFt8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mLLX44VOer+bWB3TXUaDr/PbPhzlugWI19QFUjkCtGtpd00pQDaLW3stHoZ0KY6NGpSaif3fCdSl++nifwcd6K4azrIweLlELEsPEuDSG4j9qAfgAk0FfdnerNvywlO9x6/eteD6NB1o0YeQjSvEOgCdklcxYmRV9dA4Y6PsxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyOuAqgg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyOuAqgg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A111F00AC4;
	Fri, 31 Jul 2026 23:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541228;
	bh=5VAIV4jCxzXydVrNk2kvfEuVpONEk6FGwd73JUtodq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jyOuAqggbgcyab0Jw1j6dlQWmeQ+JnkLcjbJaby9oKYs3vDAhfhMi6BC4Mv6zmtH8
	 sCpxSsp1cON3ydv3QvnBWsOGshzmLkuvlaEYOL5dpP6wOgwtYYgoVP8ak6hEYQXgJZ
	 3Rtrtoh0jFWVP1idpIKJ8wpl5T9xmO0KNHFBuJSmvQUSt0IuxI6xmZrcNm73aOIUq/
	 YPBh+9p5uKIXf65rXia/sqRYufIiCFFMo5aWixen4vDOY7kUkqJwUMDYptbn2/YMvx
	 mEAmPwc7GfVDKaHTiSjdsaAQZK01Ef9KcRNRuSBQE1i5b/7EkCAoSKvBKEY7gyKZmA
	 UkuqwvhIFhayQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/9] perf/cxl: Clear stale event fields before
 reprogramming a counter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260731232827.401447-3-dave.jiang@intel.com>
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 23:40:28 +0000
Message-Id: <20260731234028.77A111F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] writeq() used on 32-bit CXL PMU Filter Config registers clobbers t=
he adjacent Filter 1 configuration with zeros.
- [High] Pending hardware overflows from stopped events are erroneously att=
ributed to newly started events on the same counter, causing massive spurio=
us counts.
- [High] Two's complement arithmetic misunderstanding causes the driver to =
overcount by exactly 2^width on almost every overflow interrupt.
--

--- Patch [2]: [PATCH v3 2/9] perf/cxl: Clear stale event fields before rep=
rogramming a counter ---
commit e2d9388d1e46f8effd5efea9988cf263ff2efd2c
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Clear stale event fields before reprogramming a counter

cxl_pmu_event_start() ORs the event group id, event mask, edge and invert
selections into a configurable counter's config register without clearing
them first, and cxl_pmu_event_stop() leaves them set. Reuse the counter for
another event and the new selection lands on top of the old one, so the
counter counts the wrong events with stale edge and invert behaviour.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index ff01b658e1b45..b16e2e4090a39 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -646,17 +646,17 @@ static void cxl_pmu_event_start(struct perf_event *=
event, int flags)

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem earlier in
cxl_pmu_event_start():

drivers/perf/cxl_pmu.c:cxl_pmu_event_start() {
    ...
    if (info->filter_hdm) {
        if (cxl_pmu_config1_hdm_filter_en(event))
            cfg =3D cxl_pmu_config2_get_hdm_decoder(event);
        else
            cfg =3D GENMASK(31, 0);
        writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
    ...
}

Does using the 64-bit writeq() here overwrite the adjacent Filter 1
configuration register at offset +4 with the upper 32 bits of cfg (which are
zeros)? This might cause the PMU hardware to silently drop events that do n=
ot
match 0 for Filter 1's property, breaking PMU counting for this counter.

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
This isn't a bug introduced by this patch, but I spotted a potential issue =
with
hardware overflow attribution when stopping and starting events.

If a counter overflows right before being stopped, the hardware sets the
overflow bit and raises an interrupt, but the pending overflow bit in
CXL_PMU_OVERFLOW_REG is not cleared:

drivers/perf/cxl_pmu.c:cxl_pmu_event_stop() {
    ...
    cfg &=3D ~(FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1) |
             FIELD_PREP(CXL_PMU_COUNTER_CFG_ENABLE, 1));
    writeq(cfg, base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
    ...
}

When a new event is scheduled onto the same counter via cxl_pmu_event_start=
()
and the interrupt fires, will the ISR attribute the overflow to the newly
started event?

drivers/perf/cxl_pmu.c:cxl_pmu_irq() {
    ...
    for_each_set_bit(i, overflowedbm, info->num_counters) {
        struct perf_event *event =3D info->hw_events[i];
        if (!event)
            continue;
        __cxl_pmu_read(event, true);
    }
    ...
}

Could this cause massive spurious event counts to be falsely attributed to =
new
events during normal perf multiplexing?


[Severity: High]
This is a pre-existing issue, but does __cxl_pmu_read() overcount on overfl=
ow
interrupts?

drivers/perf/cxl_pmu.c:__cxl_pmu_read() {
    ...
    delta =3D (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0=
);
    if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
        delta +=3D (1UL << info->counter_width);
    ...
}

Because these are unsigned 64-bit integers, the masked subtraction natively
accounts for exactly one counter wrap, yielding the correct positive event
delta.=20

Since delta is already correct, does adding (1UL << info->counter_width) on=
 top
of it cause the driver to overcount by exactly 2^width on almost every over=
flow
interrupt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731232827.4014=
47-1-dave.jiang@intel.com?part=3D2
