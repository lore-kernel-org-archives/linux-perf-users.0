Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66CB360EF2;
	Fri, 12 Jun 2026 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259259; cv=none; b=Dl15e1/lmVBHelnysN9DnwBwOIndv2CcU4pfeNHtY2axDldO2iE5vboNTVwUvK/8MtojJeRJV701Q9LgiRSrr7zOQVDvEl8IXz2HuNydOHvzsEibSDvvxPsSbXTxIzCFmpbbhQ4eAvYngUpisnXuoIJP+7MLIWMXYBcZPtLEVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259259; c=relaxed/simple;
	bh=tEmcEXxvLYoHM4sH4rMlQvgwzu6WEIQmfvXDIsa8WpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cPpP2FP2SnQQoM2KYi4uX5EzwuKyzd9zzvf/2pzvRiNNynlbnHg42VoWgrsdDVOvBthh9Y4r465Mq5mLTsN8LDa9KmRPX0Ne9TWQoIgTkJK97MDytN1phW4Kx/w8jsCRHV4hTvwDlvmsz0Sp6IZxNKaGrKGoLw3tX7xFsD+i+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDWBDJ8G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDWBDJ8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB5D1F000E9;
	Fri, 12 Jun 2026 10:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781259258;
	bh=maLilZDWgF+74Kk7sHYF+LxSJJp1j/twR+KKsrm64u0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nDWBDJ8GqJPBRbFypdr6Tzj5et4cNmCFTjAPFCQahu4vEHEzWEjvC6easau+EoiL8
	 DWUlow+f+NL5PzuUWlGiBWcVVngD5JLTdVkCWDhe+QbWHUQWAFIRtf93yKmqSbLw6m
	 UooSfAsZ22IaBMxnDL2EvomTPen3rDDbElRiZcFGgH5TnaGeXLz+N1tNFVvrpxgh/I
	 ruAq+IcOhdSWq6ECyUdXyED+dqDBgTSkPh/O6PJfgPftHTnmxOj5hs3RuyiH9EyYsc
	 DgAyyoDaw/2TrMwhuakGKv1L/ICuT5BSi7M3PXW1RRieuEJ47zfRa669t7ALAmY1FB
	 J6NAAfJOh/BtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf: marvell: Add MPAM partid filtering to
 CN10K TAD PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geetha sowjanya" <gakula@marvell.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260612095746.19679-2-gakula@marvell.com>
References: <20260612095746.19679-2-gakula@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 10:14:17 +0000
Message-Id: <20260612101418.3FB5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Inconsistent masking of `event->attr.config` causes valid MPAM p=
artition ID filters to be silently bypassed (or hardware programming to be =
skipped entirely) when upper bits are set.
--

commit f4f2ecc176ec6e4641448761b6600d2344554e81
Author: Tanmay Jagdale <tanmay@marvell.com>

perf: marvell: Add MPAM partid filtering to CN10K TAD PMU

The TAD PMU exposes counters that can be filtered by MPAM partition id
for a subset of allocation and hit events.

> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_=
cn10k_tad_pmu.c
> index 51ccb0befa05d..af706b890bf17 100644
> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
[ ... ]
> @@ -27,30 +35,92 @@ struct tad_region {
[ ... ]
> +static void tad_pmu_start_counter(struct tad_pmu *pmu,
> +				  struct perf_event *event)
> +{
> +	const struct tad_pmu_data *pdata =3D pmu->pdata;
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u32 event_idx =3D event->attr.config;

[Severity: Medium]
Does this cause valid MPAM partition ID filters to be silently bypassed if
upper bits are set in event->attr.config?

In tad_pmu_event_init(), the event_idx is masked to 8 bits:
u32 event_idx =3D (u32)(event->attr.config & GENMASK(7, 0));

Since it is masked there, an event with upper bits set successfully passes
the validation checks. However, because it is unmasked here in
tad_pmu_start_counter(), it will fail the bounds checks below while the
lower 8 bits are still eventually programmed into the hardware counter:

> +	u32 counter_idx =3D hwc->idx;
> +	u64 partid_filter =3D 0;
> +	u64 reg_val;
> +	u64 cfg1 =3D event->attr.config1;
> +	bool use_mpam =3D cfg1 & TAD_PARTID_FILTER_EN;
> +	u32 partid =3D (u32)(cfg1 & GENMASK(8, 0));
> +	int i;
> +
> +	for (i =3D 0; i < pmu->region_cnt; i++)
> +		writeq_relaxed(0, pmu->regions[i].base +
> +			       TAD_PFC(pdata->tad_pfc_offset, counter_idx));
> +
> +	if (use_mpam && event_idx > 0x19 && event_idx < 0x21) {
> +		partid_filter =3D TAD_PRF_MATCH_PARTID | TAD_PRF_PARTID_NS |
> +				((u64)partid << 11);
> +	}
> +
> +
> +	for (i =3D 0; i < pmu->region_cnt; i++) {
> +		reg_val =3D event_idx & 0xFF;
> +		reg_val |=3D partid_filter;
> +		writeq_relaxed(reg_val, pmu->regions[i].base +
> +			       TAD_PRF(pdata->tad_prf_offset, counter_idx));
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612095746.1967=
9-1-gakula@marvell.com?part=3D1
