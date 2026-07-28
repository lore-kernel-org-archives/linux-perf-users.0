Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC44746C9;
	Tue, 28 Jul 2026 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274364; cv=none; b=uPMDSEuZ1C+4EQ+iZnE/Z2OvJwe/zAJiY3Bre/qQ66njigPecFzptuRf3wjZCcb3tPAivgQAALfdcSc+pw62f5jc7vln7sMbNwawLBlz1RjtAZJxlriCSnDb24OYi21v0TMCLCgJXEXxdGDS2vBCwWuLOucbhwPjKCRC/kZ+EnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274364; c=relaxed/simple;
	bh=iyv9OS198OCeyWA0n/MCG7YBoiNg6P5+pD0cz5gs8l0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r9pFNuW+QNdgW70wXXozFMySW9F6V4z83ZzojE+xuxDbi9c5ghvKH0O6ykOjzd0xx9/t2TwDPKQYXLuVOEPK4ncc22t1ECwB1DANhoNhmKkOPQASHbPRsBPAONli4d0cUQKpulRaKKu+Loc4fhPKI/XnLYV4G3tAxDBt8A7zUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFMs+xUi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFMs+xUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653521F000E9;
	Tue, 28 Jul 2026 21:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785274363;
	bh=dZYkde4Aa68PZCTxWZ/Tt1dK27ocgNnB9/uNH7SwpHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DFMs+xUi+Hhr0tE8QHojLHngWUr6VyzjyfbM3jg3Lu3KqCdux5AIRUjiE5zGhxAb5
	 wIkhhkEA+p+C9Zr7vGBfMqgN3lHX1LosTT86N4IJDu3dkn780kqZ2weoH8+VSYfRMr
	 NuHOBBy2fZ0LVuPhZXeptoh4xxGcxj/qpcufaXBjKDVs4QtctLcHL57sr+YFu7xeJw
	 xa2CHikxwYrXde0e4aYULvgP4Bk5ZwUSGlBRrQ8YHNG/uo13POplz8rBM/1ra+7cBF
	 1bCWscrqpg8OXMi/hMWji1nS6e6NwVXwatTaj/x34rGDl/YU3sNegauIm2brZoHNWG
	 78N5hGGg/3fog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] perf/cxl: Program the requested event group on
 configurable counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260728210551.2449093-2-dave.jiang@intel.com>
References: <20260728210551.2449093-1-dave.jiang@intel.com>
 <20260728210551.2449093-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 21:32:42 +0000
Message-Id: <20260728213243.653521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In cxl_pmu_event_start(), configuration bitfields are bitwise-ORed=
 with the existing register value without being cleared first, leading to c=
orrupted register state.
--

--- Patch [1]: [PATCH 1/9] perf/cxl: Program the requested event group on c=
onfigurable counters ---
commit a96f996812668f5b85e51cf8c46d25fbd3781fce
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Program the requested event group on configurable counters

cxl_pmu_get_event_idx() sets the counter index for a configurable counter b=
ut
never sets the event index, causing the event base to stay 0. This change
returns the matched capability's event index to correctly program the group.

Link: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.=
net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -552,6 +552,8 @@ static int cxl_pmu_get_event_idx(struct perf_event *e=
vent, int *counter_idx,
>  			return -EINVAL;
> =20
>  		*counter_idx =3D i;
> +		if (event_idx)
> +			*event_idx =3D pmu_ev->event_idx;

[Severity: High]
This is a pre-existing issue, but does assigning non-zero event indices here
expose a bit accumulation bug in cxl_pmu_event_start()?

When the event starts, cxl_pmu_event_start() updates the configuration
register using a bitwise-OR against the existing value:

drivers/perf/cxl_pmu.c:cxl_pmu_event_start() {
    cfg =3D readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
    ...
    if (test_bit(hwc->idx, info->conf_counter_bm)) {
        cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK,
                          hwc->event_base);
        cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENTS_MSK,
                          cxl_pmu_config_get_mask(event));
    }
    ...
}

Since cxl_pmu_event_stop() only clears the ENABLE and INT_ON_OVRFLW fields,
the old group ID bits remain in the register. Because the event base is
now correctly populated by this patch instead of remaining 0, won't
consecutive events reusing the same counter cause EVENT_GRP_ID_IDX_MSK
and other fields to accumulate stale bits from previous events?

Could this lead to corrupted hardware state over time, and should the
relevant register fields be explicitly cleared before applying the new
configuration?

>  		return 0;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728210551.2449=
093-1-dave.jiang@intel.com?part=3D1
