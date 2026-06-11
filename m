Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16231607A4;
	Thu, 11 Jun 2026 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140494; cv=none; b=LPG9+QJIIuDnUEk6FglssyKD9rfUjIPu+YXryTT2WhXTAAOUFlNhakbjzV23x05Bic+keH8lc754ygnTBZH1m3JTkLih6H+OWriUg+XhKsoX7XgltBiD97VZjuUhOH5hBCJwtHMqIDhTFsIvMq3roB11NUgWPkkS2HdIm2oPzs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140494; c=relaxed/simple;
	bh=aKjZZs5gSoWr8SCjbTIQSW7gjhHgd/cl24/F7RKFGbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g9gDbqMYq8EyH0lzvhqQP0pAhWzbsjxkuTWRqCo2fVdQSQ8BxPPTrR3RR2zknP77etGRRZmHQErinoAAlCoM1X/l7g4e1p7llOtNjoLmli//1XZZdeDvamOq6dIHXhMVhGQ8O3HlCkA+6vAGfyH8E7h2QmTn4s6260tI+3P/HEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4FKi5HA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4FKi5HA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15121F00893;
	Thu, 11 Jun 2026 01:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781140492;
	bh=uLROrLkrMlNu2thLVtO7SNC5ExyFtAkVrQerHZ6RqIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z4FKi5HADjCk1RextUCJau4Euu98qTZ39w4DXXlQBG/XpDklijiXb9XSN3x0ZQVKZ
	 c5xlZkG/uEYHAvWWEZv5onaI2tw3VhWX7sreGbNnqrLhWkW+XQG2+uC5J/taIU/mBZ
	 +we8wIs5laltYhNNr6ndPyggzKA6l355U8KDCpXBpKZEJQTogWKjtYI7dv2HE1Hh5C
	 6sBWoXlBwkcf8fIlTuJWsCc7qsClehu559+3dR3w815aijD+Tyal9EyDFETqSt+siK
	 O+6Sxocmmj+LkTQLfPtSqgzsobepA/8yY8EzGj7hchwfn+/SZk2+IJcvrQLIcYEMNl
	 by4GpQyRhYJ0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/cxlpmu: Support Channel/Rank/Bank filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260611010409.2776635-1-dave@stgolabs.net>
References: <20260611010409.2776635-1-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 01:14:52 +0000
Message-Id: <20260611011452.A15121F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The function `cxl_pmu_config2_get_crb()` returns `u16`, silently t=
runcating the 32-bit CRB filter value.
- [High] Using `writeq()` to program the 32-bit CRB filter register causes =
unaligned MMIO access and clobbers adjacent registers.
- [Low] The mask `CXL_PMU_ATTR_CONFIG2_CRB_MSK` is defined using `GENMASK(6=
3, 32)`, causing compilation errors and undefined behavior on 32-bit archit=
ectures.
--

commit a9330e1fbdf601456995f95b96ae724e328f12a5
Author: Harshal Thakkar <harshal.t@samsung.com>

perf/cxlpmu: Support Channel/Rank/Bank filter

Implement CRB filtering per CXL 4.0 8.2.7.2.2, and extend the current filte=
ring
support beyond HDM. These filters are only for DDR Interface events.

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 68a54d97d2a8a..b709b2e6c0d95 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c

[ ... ]

> @@ -246,7 +253,9 @@ static struct attribute *cxl_pmu_format_attr[] =3D {
>  #define CXL_PMU_ATTR_CONFIG1_INVERT_MSK		BIT(16)
>  #define CXL_PMU_ATTR_CONFIG1_EDGE_MSK		BIT(17)
>  #define CXL_PMU_ATTR_CONFIG1_FILTER_EN_MSK	BIT(18)
> +#define CXL_PMU_ATTR_CONFIG1_CRB_FILTER_EN_MSK	BIT(19)
>  #define CXL_PMU_ATTR_CONFIG2_HDM_MSK		GENMASK(15, 0)
> +#define CXL_PMU_ATTR_CONFIG2_CRB_MSK		GENMASK(63, 32)

[Severity: Low]
Does this code cause compilation errors on 32-bit architectures?

GENMASK generates an unsigned long, which is 32 bits wide on 32-bit
architectures. Shifting by 32 or more results in undefined behavior and
triggers the macro's internal BUILD_BUG_ON_ZERO(h >=3D BITS_PER_LONG).

Should this use GENMASK_ULL(63, 32) for a 64-bit mask?

[ ... ]

> @@ -319,6 +333,17 @@ static u16 cxl_pmu_config2_get_hdm_decoder(struct pe=
rf_event *event)
>  	return FIELD_GET(CXL_PMU_ATTR_CONFIG2_HDM_MSK, event->attr.config2);
>  }
> =20
> +static u16 cxl_pmu_config1_crb_filter_en(struct perf_event *event)
> +{
> +	return FIELD_GET(CXL_PMU_ATTR_CONFIG1_CRB_FILTER_EN_MSK,
> +			 event->attr.config1);
> +}
> +
> +static u16 cxl_pmu_config2_get_crb(struct perf_event *event)
> +{
> +	return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
> +}

[Severity: High]
Does this function truncate the 32-bit CRB filter value?

The CRB filter mask config2:32-63 is 32 bits wide, but
cxl_pmu_config2_get_crb() returns u16. When the 32-bit value is extracted
using FIELD_GET(), the upper 16 bits are silently dropped.

Should the return type be changed to u32 to preserve the full filter value?

[ ... ]

> @@ -627,8 +660,8 @@ static void cxl_pmu_event_start(struct perf_event *ev=
ent, int flags)
>  	hwc->state =3D 0;
> =20
>  	/*
> -	 * Currently only hdm filter control is implemented, this code will
> -	 * want generalizing when more filters are added.
> +	 * Filter ID=3D0: HDM decoder filter
> +	 * Filter ID=3D1: Channel/Rank/Bank (CRB) filter
>  	 */
>  	if (info->filter_hdm) {
>  		if (cxl_pmu_config1_hdm_filter_en(event))
> @@ -638,6 +671,14 @@ static void cxl_pmu_event_start(struct perf_event *e=
vent, int flags)
>  		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
>  	}
> =20
> +	if (info->filter_chan_rank_bank) {
> +		if (cxl_pmu_config1_crb_filter_en(event))
> +			cfg =3D cxl_pmu_config2_get_crb(event);
> +		else
> +			cfg =3D GENMASK(31, 0); /* no filtering if 0xFFFF_FFFF */
> +		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 1));

[Severity: High]
Can this writeq() trigger an unaligned MMIO access fault and clobber
adjacent registers?

The CXL PMU filter configuration registers are 32 bits wide with a 4-byte
stride:

0x400 + 4 * (f + n * 8)

For f=3D1, CXL_PMU_FILTER_CFG_REG() resolves to an unaligned offset like
0x404. Using a 64-bit writeq() on a 4-byte unaligned device memory
address triggers undefined behavior and hardware alignment faults, such as
a Synchronous External Abort on ARM64.=20

Additionally, writing 64 bits to a 32-bit register clobbers the adjacent
register (f=3D2).

Would writel() be safer here?

> +	}
> +
>  	cfg =3D readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
>  	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
>  	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW, 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611010409.2776=
635-1-dave@stgolabs.net?part=3D1
