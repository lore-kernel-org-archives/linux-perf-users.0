Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644413BED7D;
	Tue, 28 Jul 2026 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273964; cv=none; b=bQQGnKp0YNCUEg2WWEMKAbB34YzAqz3Li8R0TdHUyIDYIvxNPDdgKdyUXeL2yqU5H5Sgr5mLKHKoqi3htDu4Qii5Wzmwh3SwSRFlDcKiSNZBN3P2D7fYCGJySSYwtS9zj2b3Nie0ROzPfcnPpkehDrt7lgupPUl+WqxGQX+9Z7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273964; c=relaxed/simple;
	bh=TI7STE90aWripsjQxMiKSk1gFe4YB7FyxAPtCicahzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hTatC00eyi9roAEcEr2j8GRl0kTqOuQUxKoeEtH0GZI0g90A880EdUdaa7bBALy288bgxS09Nd1RFpnwckA75o8yV6UFL0cNrkfNf83fjW7VL/0a3WuNBLMr82PwrS1ELkD8/991J3QjPxUAXX98oJkJEA22vWYijcY0VgoGAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaClP0Bd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaClP0Bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF1E1F00A3A;
	Tue, 28 Jul 2026 21:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785273963;
	bh=cQj68nnpzmP/I6Mb5vh6Dv7Tpoxp0KVkB4bK4K9jNbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LaClP0Bdp4xiM+ezcBZLfhHdX32Si8zOH8/WoOw2ItuFKk+JjMMKvv84jSwH1TgC1
	 +NDxy9iXozAYvp84MSii9d3pHWundYxaDRxWj87RWD1giyItVAx2znquaHqhdS4NpP
	 QL7CsGCXtmBmHXk/xI2m6jlPv593twsfA5HOXxkt1jXFwsVG0V4JknvPysaCtZRPDV
	 JvXc3x8V/DheHjQphuy8SklPWO5OlAU3mmwk9hbPYqWFtCmJkNyDFGISlVWogyy8ub
	 1X5TT06MYgmr6RrlmTM3faZmFYznZVzh8Idd/N8dh1tQKOV+3EJfLEuQo6ShqLNMBw
	 b7pSSAUpNkDbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] perf/cxl: Clear stale event fields before
 reprogramming a counter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260728210551.2449093-3-dave.jiang@intel.com>
References: <20260728210551.2449093-1-dave.jiang@intel.com>
 <20260728210551.2449093-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 21:26:02 +0000
Message-Id: <20260728212602.BBF1E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect overflow handling in __cxl_pmu_read() double-counts even=
ts and invokes undefined behavior via an out-of-bounds shift.
--

--- Patch [2]: [PATCH 2/9] perf/cxl: Clear stale event fields before reprog=
ramming a counter ---
commit 7bcf06641417cf2542677bb2d2607c683f730512
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Clear stale event fields before reprogramming a counter

This commit clears stale event fields from the configuration register
before reprogramming a counter in the CXL PMU driver. This ensures
the counter does not count the wrong events with old edge or invert
behavior when reused.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index e77c0650a7eb6..3138514157cde 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -641,6 +641,7 @@ static void cxl_pmu_event_start(struct perf_event *ev=
ent, int flags)
>  	}
> =20
>  	cfg =3D readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
> +	cfg &=3D ~(CXL_PMU_COUNTER_CFG_EDGE | CXL_PMU_COUNTER_CFG_INVERT);
>  	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);

[ ... ]

> @@ -651,6 +652,8 @@ static void cxl_pmu_event_start(struct perf_event *ev=
ent, int flags)
> =20
>  	/* Fixed purpose counters have next two fields RO */
>  	if (test_bit(hwc->idx, info->conf_counter_bm)) {
> +		cfg &=3D ~(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK |
> +			 CXL_PMU_COUNTER_CFG_EVENTS_MSK);
>  		cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK,
>  				  hwc->event_base);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential problem
in how overflows are handled in __cxl_pmu_read() in this same file:

drivers/perf/cxl_pmu.c:__cxl_pmu_read() {
    ...
    delta =3D (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0=
);
    if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
        delta +=3D (1UL << info->counter_width);
    ...
}

Does this double-count the overflow events? Since the subtraction is already
masked by GENMASK_ULL(), the wraparound is correctly accounted for in delta.
Adding (1UL << info->counter_width) appears redundant and might corrupt the
resulting metrics.

Additionally, does this shift operation risk undefined behavior? If
info->counter_width is 64 (the maximum width allowed by the CXL 3.0
specification) on 64-bit systems, or 32 or greater on 32-bit systems,
shifting 1UL by that width would cause an out-of-bounds shift.

Is it safe to rely on this delta calculation when counter_width can be large
enough to trigger this undefined behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728210551.2449=
093-1-dave.jiang@intel.com?part=3D2
