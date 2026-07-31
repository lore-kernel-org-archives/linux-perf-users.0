Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214347CA92;
	Fri, 31 Jul 2026 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541123; cv=none; b=BstXdm3UcIx7QzzZnfVYFZnF3fEG7ORlsZAC983ghMWVEbGQC0HyEgTpIOiI1HseNV7EBJmlF2CJZiWqCkNU1YJB2D9WWrO6yj3ByyLn8z8R3vMy+n4s7F7qytcZU3/h9JPkC7G5hCWacBYIhuntE08daYxp60vs87vf78z2n3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541123; c=relaxed/simple;
	bh=X/549qbC3Hwkbin27tH2rxmcpOzghfm/m75Dl1SYvDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JTFbayQCGXx8mmagiF+EbWJSBkTd8X3slsrDk0SvKd9kbCTSB7W4HFRbtC2WrCfZ0cs9ovQD3ujHd8tpdUBdbn8TYxOy586Es4KDv8kKfa24LMmOX8839ioXfafVaZ5ub/u0STroymXF0eQ7tggqe3eXhCHs2FLO/uMp+6l+LJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+IfQUK8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+IfQUK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68851F00AC4;
	Fri, 31 Jul 2026 23:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541122;
	bh=3qt/6WMPjIHOeMkVZHtR7u2VFvtLYpXMM2R8j2M1/cU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S+IfQUK8gPpHIwTj1TkM33CZBgdHcVJIsJOpvFuT2ynM9J8RAQq+WRj2B8WGqqZzo
	 XpNwS1YZ2ShCCOREkQEGb6eDVqKGaOckxOMCFk68TlGQVc0umuiPjWIkoOmlQlOIdp
	 qg6vA+C7XYC4yHF2lvNF9Jc4qpSjO2dSab0WmETz+cv2AJsYfCZhAjogjNCDTU4Iqv
	 0p+xFgyFepvFjF2S8mxZG5Z9c+oMMti0MAxRplnr29tC6zvDu91+lxkjpNBXO/i+BZ
	 8YgSoGwvi5H7tz+mvHTngcdGvQ/5y8gxkIm7OEoFhBRODVPt1O2VcckZwswLWFd1O6
	 cm+biaunw2fjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] perf/cxl: Program the requested event group on
 configurable counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260731232827.401447-2-dave.jiang@intel.com>
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 23:38:41 +0000
Message-Id: <20260731233841.B68851F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Counter configuration fields are not cleared before being modifi=
ed in cxl_pmu_event_start(), causing corrupted event group IDs when a count=
er is reused.
--

--- Patch [1]: [PATCH v3 1/9] perf/cxl: Program the requested event group o=
n configurable counters ---
commit 8ade5d557a8fda7df4834e1f36fcc4dfd34e953d
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Program the requested event group on configurable counters

cxl_pmu_get_event_idx() sets *counter_idx for a configurable counter but
never *event_idx. hwc->event_base stays 0, so cxl_pmu_event_start()
programs event group 0 no matter which group the user asked for.

Return the matched capability's event_idx.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 68a54d97d2a8a..ff01b658e1b45 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
[ ... ]
> @@ -541,7 +544,7 @@ static int cxl_pmu_get_event_idx(struct perf_event *e=
vent, int *counter_idx,
> =20
>  	pmu_ev =3D cxl_pmu_find_config_counter_ev_cap(info, vid, gid, mask);
>  	if (!IS_ERR(pmu_ev)) {
> -		if (!counter_idx)
> +		if (!counter_idx || !event_idx)
>  			return 0;
> =20
>  		bitmap_andnot(configurable_and_free, info->conf_counter_bm,
> @@ -552,6 +555,7 @@ static int cxl_pmu_get_event_idx(struct perf_event *e=
vent, int *counter_idx,
>  			return -EINVAL;
> =20
>  		*counter_idx =3D i;
> +		*event_idx =3D pmu_ev->event_idx;

[Severity: Medium]
Will this corrupt the hardware counter configuration when a counter is reus=
ed?

By populating event_idx here, hwc->event_base will now contain the actual
event group ID rather than 0.

However, in cxl_pmu_event_start(), the configuration is updated using a
read-modify-write without clearing the previous fields:

drivers/perf/cxl_pmu.c:cxl_pmu_event_start() {
    ...
    cfg =3D readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
    ...
	if (test_bit(hwc->idx, info->conf_counter_bm)) {
		cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK,
				  hwc->event_base);
		cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENTS_MSK,
				  cxl_pmu_config_get_mask(event));
	}
    ...
    writeq(cfg, base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
}

If a counter is freed and reused for a new event with a different event gro=
up
ID, won't the bitwise OR merge the old and new event_base values since the
CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK bits are never cleared from cfg?

>  		return 0;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731232827.4014=
47-1-dave.jiang@intel.com?part=3D1
