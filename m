Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93443E9F5;
	Wed,  5 Aug 2026 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946601; cv=none; b=CTmPtpsZo18U6vw+jGxC06PKi4uOUx7PGLyZF3xikiTmJCxIRTVZx6KuuxWYEJZx2wGR3StjisdKfLQdkziqe3UQIVJ0+TdtQQWtsG9kuBIwcjZ8GYubI36Vg/RxWYUzBn2CcR/Qe8YBQUTGjMJfT9ShJhMnV10CnmDb48H0o18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946601; c=relaxed/simple;
	bh=yyZqchTIvMc6Az1DFdRuIxgetRrRljdmwPlkkE0vCVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WtVCZXgjWYi98Zj0UNK+5EiGKP4QI8AodRcIQ9Rsbma/fNuErQ1cPlMSeNkyHPpiaqxT03BUBVxVvVTBRwNephn5MP9QpBsmj3hejwFfTl4NweJ15ZuIDP+N0EWHmI+f6OvuVpJqi0ZsIPsmoXKq4WIvwFoXUX/G+QFkn4rcLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqZVRgzz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqZVRgzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18771F000E9;
	Wed,  5 Aug 2026 16:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785946595;
	bh=bcHhDGakhIocECs0dRJvq9X58e3eSv37ZHxVLztH5fg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IqZVRgzzHr8ApDHAHwqdPSIRc5336QKSMSVimDeazZnI1GImAAdcbdFoQbY+ujAkp
	 NISs9GivbqOrT7Zj+OECPPZIxa5XALLIBaCAhskoIHGhdSwAH0AN3FfHlXu4xki0tk
	 PyOnzSIWO8oXrRW7uOh27rP6U1QIFbOpccrzysEUgjb72RPVTq0W0pDMrAsucR8pvj
	 vS123bpYQ3ACv6eypLptPHQ/wyHjTTR3PbmLumlwc1n49Lq3kYiQnFWw2MbJoMA2c8
	 EqU4IWu08fuiT5rIF/xfyJ9nRK6lQEwncky9rrRcWeM6cM6nyLv8wcLKFLgq2npeoE
	 8MyJWdELLPdSg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v4 09/11] perf/cxl: Validate the
 hardware-reported counter width
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260805155911.1304807-10-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
 <20260805155911.1304807-10-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:16:35 +0000
Message-Id: <20260805161635.B18771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition between manual perf event reads and the PMU overflo=
w interrupt handler causes spurious full-period additions.
- [High] Missing cleanup of the hardware overflow status bit when stopping =
or starting a counter leads to massive overcounting for subsequently schedu=
led events.
--

--- Patch [9]: [RESEND PATCH v4 09/11] perf/cxl: Validate the hardware-repo=
rted counter width ---
commit 194e381f35d23ddbc6cc781235e1bc6b38fb673a
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Validate the hardware-reported counter width

cxl_pmu_parse_caps() takes the Counter Width straight from the CPMU
Capability register without a bounds check. Reject a counter width
outside 1..64 at probe to prevent shifting out of range.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index a081fcba69917..84ebc7da181d5 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -142,6 +142,15 @@ static int cxl_pmu_parse_caps(struct device *dev, st=
ruct cxl_pmu_info *info)
> =20
>  	info->num_counters =3D FIELD_GET(CXL_PMU_CAP_NUM_COUNTERS_MSK, val) + 1;
>  	info->counter_width =3D FIELD_GET(CXL_PMU_CAP_COUNTER_WIDTH_MSK, val);
> +	/*
> +	 * The Counter Data register is 64 bits wide, so a Counter Width of 0 or
> +	 * >64 is invalid. Reject it rather than let GENMASK_ULL(width - 1, 0) =
in
> +	 * the read path shift out of range.
> +	 */
> +	if (info->counter_width =3D=3D 0 || info->counter_width > 64) {
> +		dev_err(dev, "Invalid counter width %d\n", info->counter_width);
> +		return -ENODEV;
> +	}
>  	info->num_event_capabilities =3D FIELD_GET(CXL_PMU_CAP_NUM_EVN_CAP_REG_=
SUP_MSK, val) + 1;
> =20
>  	info->filter_hdm =3D FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) & CXL_=
PMU_FILTER_HDM;

[Severity: High]
This is a pre-existing issue, but can a race condition between manual perf
event reads and the PMU overflow interrupt handler cause spurious additions?

drivers/perf/cxl_pmu.c:__cxl_pmu_read() {
    ...
	mask =3D GENMASK_ULL(info->counter_width - 1, 0);
	delta =3D (new_cnt - prev_cnt) & mask;
	if (overflow && new_cnt >=3D prev_cnt)
		delta +=3D mask + 1;
    ...
}

If a hardware counter wraps and asserts the PMU interrupt, and a manual read
occurs before the interrupt handler executes, the manual read handles the w=
rap
natively via 2's complement subtraction and updates prev_count.

When the IRQ handler subsequently runs, it sees the stale hardware overflow
bit still set and evaluates new_cnt >=3D prev_cnt. Will it then spuriously
add a full period (mask + 1) to the event count?


[Severity: High]
This is a pre-existing issue, but does missing cleanup of the hardware over=
flow
status bit when stopping or starting a counter lead to overcounting for
subsequently scheduled events?

drivers/perf/cxl_pmu.c:cxl_pmu_event_stop() {
    ...
	cfg &=3D ~(FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1) |
		 FIELD_PREP(CXL_PMU_COUNTER_CFG_ENABLE, 1));
	writeq(cfg, base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
    ...
}

If cxl_pmu_event_stop disables a counter's interrupt but does not clear the
hardware overflow status bit in CXL_PMU_OVERFLOW_REG, the bit remains set.

drivers/perf/cxl_pmu.c:cxl_pmu_event_start() {
    ...
	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW, 1);
	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_ENABLE, 1);
    ...
}

When cxl_pmu_event_start later reuses the counter index for a new event, it
initializes the counter to 0 and re-enables the interrupt without clearing =
the
pending overflow bit.

Could the IRQ handler process the stale overflow bit and incorrectly add ma=
sk + 1
to the new event's count?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805155911.1304=
807-1-dave.jiang@intel.com?part=3D9
