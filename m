Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9A3B058B;
	Wed, 29 Jul 2026 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337740; cv=none; b=ium03SecVvEZ0G1gkDUvAwVRTiaJSi4dhOGcAFXKfFUPTQz88a4stdb+HPjLcF+5Pjo2fTN69TRz1DAB8xkoQyo4IEjXxwDbfdQ2vam++0wqZKbrSlhFrAmPvr4yx8I2obanKEu56pNGJn+9RzBmuOKb/otzFp2a7pxXXegahN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337740; c=relaxed/simple;
	bh=OB7xhIwvcsJjw5BWZ/HYiav2aDqpfmRXoFPDFdt3W/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qJmWUNbdvsVFCM0BgSfaSnT5UoZ9myxo/PKBT6VvsbSuODB8S3ZdcnQbai4H+CnhFJ1X83y81Hy5S7gA9ULlOPjwpBNeUx8mi2HTQ44YEOCJJcd5lVEGpiUg13wtPbR707Bt/tNtoqmqBtRiMD5rIGc+VBcykOPVijJ3UUbpbSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BP+TC+ou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BP+TC+ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303A41F000E9;
	Wed, 29 Jul 2026 15:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337739;
	bh=k73djmGx0aCahZJtWSCSldOTZ+JgW3p4VuFXV8AupyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BP+TC+ouf2O2eWW2xbaTk4DIa3ApqsELuVOul7NFqw/lVFfYIOChH1KvZcCB2XmUA
	 y5QTdCjkXfkCOa41zL5xkeF7p/yavOkPPwZ6zoNYCS2aPNn5kDvwL8c+ymOwit+6lU
	 lGIAroitRc1h+BoVipyQSFzRm1cz4yz3hthFCC5wxpcXn0us1SmP+lOorkOpaJowQ6
	 WBjU5woQtk0RCPARxLZaG1wPrZngSccB/uRtT7WW/y9CQtcv4pGlOpQENfO5ccuEtP
	 VhgGZGkcbODiQsy0W+u6ChS1f7bN9+es0+aVB0MVj+YShwSmc+qyFqE6xUjenO6PTA
	 RBocZalnLhrwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/9] perf/cxl: Clear stale event fields before
 reprogramming a counter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260729145555.3919550-3-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:08:58 +0000
Message-Id: <20260729150859.303A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A 64-bit `writeq()` is incorrectly used to write a 32-bit filter c=
onfiguration register, corrupting the adjacent filter register.
- [High] The PMU event read logic incorrectly adds `2^width` to the event d=
elta on typical overflows, causing massive overcounting and undefined behav=
ior.
- [Medium] The PMU sysfs format attribute for `threshold` accepts a 16-bit =
value, but the accessor silently truncates it to 8 bits.
--

--- Patch [2]: [PATCH v2 2/9] perf/cxl: Clear stale event fields before rep=
rogramming a counter ---
commit 4bfb25bc15d355490e2f63cedff157f6adb1461a
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Clear stale event fields before reprogramming a counter

This commit fixes an issue where reprogramming a performance counter leaves
stale values in the configuration register. It ensures the event group id,
event mask, edge, and invert fields are cleared before being reprogrammed.
This prevents the counter from accumulating statistics with old selections.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index e77c0650a7eb6..3138514157cde 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c

[ ... ]

> @@ -641,6 +641,7 @@ static void cxl_pmu_event_start(struct perf_event *ev=
ent, int flags)
>  	}
> =20
>  	cfg =3D readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
> +	cfg &=3D ~(CXL_PMU_COUNTER_CFG_EDGE | CXL_PMU_COUNTER_CFG_INVERT);
>  	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
>  	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW, 1);
>  	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_ENABLE, 1);

[Severity: High]
This isn't a bug introduced by this patch, but does the filter configuration
overwrite the adjacent Filter 1 register?

drivers/perf/cxl_pmu.c:cxl_pmu_event_start()
	if (info->filter_hdm) {
		if (cxl_pmu_config1_hdm_filter_en(event))
			cfg =3D cxl_pmu_config2_get_hdm_decoder(event);
		else
			cfg =3D GENMASK(31, 0); /* No filtering if 0xFFFF_FFFF */
		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
	}

Because CXL_PMU_FILTER_CFG_REG uses a 4-byte stride, the registers are
expected to be 32-bit wide. A 64-bit writeq() will write 8 bytes, which
on a little-endian system clobbers the adjacent Filter 1 register when
writing to Filter 0.

> @@ -651,6 +652,8 @@ static void cxl_pmu_event_start(struct perf_event *ev=
ent, int flags)
> =20
>  	/* Fixed purpose counters have next two fields RO */
>  	if (test_bit(hwc->idx, info->conf_counter_bm)) {
> +		cfg &=3D ~(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK |
> +			 CXL_PMU_COUNTER_CFG_EVENTS_MSK);
>  		cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK,
>  				  hwc->event_base);
>  		cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENTS_MSK,

[Severity: Medium]
This is a pre-existing issue, but could the threshold accessor silently
truncate user-provided values?

drivers/perf/cxl_pmu.c:cxl_pmu_config1_get_threshold()
static u8 cxl_pmu_config1_get_threshold(struct perf_event *event)
{
	return FIELD_GET(CXL_PMU_ATTR_CONFIG1_THRESHOLD_MSK,
			 event->attr.config1);
}

The accessor returns a u8, but the PMU sysfs format attribute for threshold
accepts a 16-bit value (config1:0-15). If a user requests an event with a
threshold configuration greater than 255, the value gets silently truncated
before being programmed into the hardware.

[Severity: High]
This isn't a bug introduced by this patch, but does the event read logic
cause massive overcounting when a counter overflows?

drivers/perf/cxl_pmu.c:__cxl_pmu_read()
	delta =3D (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0);
	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
		delta +=3D (1UL << info->counter_width);

The calculation (new_cnt - prev_cnt) & mask correctly handles a single
wrap-around when new_cnt < prev_cnt due to two's complement arithmetic.
Because delta < mask is almost always true during an overflow, the subseque=
nt
addition double counts the wrap-around.

Additionally, if info->counter_width is 64, shifting 1UL by 64 will invoke
undefined behavior.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729145555.3919=
550-1-dave.jiang@intel.com?part=3D2
