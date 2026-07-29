Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F903EC812;
	Wed, 29 Jul 2026 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337618; cv=none; b=eqWymdCmMX00NMopdz4z7YK8c6y2a+dgh/bEwa9s9BT4qHGGUUBpYIbT/DcpEYlnSNWuEbPvDlBkMA5nu2gjUGP1pmjRcMtsGWLaToZgwfCbpILDm03S5qQlTNLSweHo7mvHjRs7xO+gars++6Htnji7+jAJCO4rcGdPVFUms/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337618; c=relaxed/simple;
	bh=VKurCtOVNqG5A5m5crOAuNAlkxGZno+f0X00hPebgZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OLYifuzCjGLXFqQlfjguX+Mb3jHiafqYeF7lGxgKNdEmLPE0mGGM4/X0Mva3uprcxi0KJGhmN4IfXbB0ZebV2iaavBHI6VYHN64uYcB8LYCUOEqBh0L/pDsIRcMxqw5vYBfgDoMVqJ16UubqQxFQuuvfU3o/Ra+3YAJS2BfNtj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtsP/KWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtsP/KWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4169C1F000E9;
	Wed, 29 Jul 2026 15:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337617;
	bh=QblsDXET2hm+LhUiNa1DfHn4lRxpWvr6LV2Qc9HeoME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DtsP/KWH1yR/14GTq1gbLzCoUdNuCDVjHfp3cysFbYPEs27Q2vSEMt6E4o+VeeVQ2
	 RjFu98vS3Au+yxxV99TWh45xhpxQ0TAn8QmBRBwdJhnV2TLRUlXCLrz6igpvUvdfZz
	 V1VZEPQBSd+URHocdhSoWzJD/41XbAGb30TAWqLy+EE4itrVZ4BG/+PJY5lvEOIYe+
	 oQ/yKoHGa53Ln/oygN+mxPoMKgY4ZaKQSHyzg3tm6OCBL3BUuuhNgFBjEkKoDgeoUV
	 QtrM2pvlKTENSYdZQJIpnC0zfwK9edZ2xjcP8YiqaLV5fTO728prP0P5+F+IPgbAzC
	 n0NY0cIJUjL+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/9] perf/cxl: Program the requested event group on
 configurable counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260729145555.3919550-2-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:06:56 +0000
Message-Id: <20260729150657.4169C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware State Pollution / Missing Bitmask Clear on PMU Counter Re=
use
- [High] Invalid 64-bit Write on a 32-bit PCIe Register
- [High] Undefined Behavior Due to Out-of-Bounds Shift in Overflow Handling
--

--- Patch [1]: [PATCH v2 1/9] perf/cxl: Program the requested event group o=
n configurable counters ---
commit 3f34f60eb49c6f10c29064fdd1d2a3cf3e95a287
Author: Dave Jiang <dave.jiang@intel.com>
Date:   Wed Jul 29 14:55:47 2026 +0000

perf/cxl: Program the requested event group on configurable counters

cxl_pmu_get_event_idx() sets *counter_idx for a configurable counter but
never sets *event_idx, so hwc->event_base stays 0 and cxl_pmu_event_start()
programs event group 0 regardless of the group the user requested.

Return the matched capability's event_idx.

Link: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.=
net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 68a54d97d2a8a..e77c0650a7eb6 100644
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
This isn't a bug introduced by this patch, but returning the correct=20
event_idx here fully exposes an existing state pollution issue in=20
cxl_pmu_event_start().

When a hardware counter is reused, the configuration is bitwise-ORed:

drivers/perf/cxl_pmu.c:cxl_pmu_event_start() {
...
	cfg =3D readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
...
	if (test_bit(hwc->idx, info->conf_counter_bm)) {
		cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK,
				  hwc->event_base);
		cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENTS_MSK,
				  cxl_pmu_config_get_mask(event));
	}
...
}

Because the previous bits are not cleared, does this code accumulate=20
garbage on reused counters (e.g., ORing the new hwc->event_base with=20
the old one)?


[Severity: High]
This is another pre-existing issue, but I noticed a potential hardware acce=
ss
violation in cxl_pmu_event_start() when dealing with HDM filtering:

drivers/perf/cxl_pmu.c:cxl_pmu_event_start() {
...
		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
...
}

Since CXL_PMU_FILTER_CFG_REG is a 32-bit register, could sending a 64-bit
write with writeq() trigger a PCIe Unsupported Request error or silently
overwrite the adjacent Filter 1 register?


[Severity: High]
This is a pre-existing issue, but there appears to be a shift out of bounds
in the overflow handling path:

drivers/perf/cxl_pmu.c:__cxl_pmu_read() {
...
	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
		delta +=3D (1UL << info->counter_width);
...
}

If the platform supports a counter_width of 64 (or >=3D 32 on 32-bit
architectures), does the use of 1UL rather than 1ULL invoke undefined
behavior and silently corrupt the delta calculation?

>  		return 0;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729145555.3919=
550-1-dave.jiang@intel.com?part=3D1
