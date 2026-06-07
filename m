Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD830C170;
	Sun,  7 Jun 2026 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780837329; cv=none; b=KW+PJldgl5QZ9CMyZCpfUpZOr31zMg8oAvh3Z99eqGaCSU/jugC+vTekERiMUdO7FXX6QvcWzfDz84zg0zwN+bUBZT2MvrBMJyhkMnQkwWeKPPI3LEJEwtOW0dVD0bi+3goghMb2w/r4yiPvuXi8PuNI+sYzEQN9gBwnHT1Accw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780837329; c=relaxed/simple;
	bh=Wyks9TvSAL4hkSIV38sgxdRU8L4q3KW0E6wtAi3+KMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LiFKwsHmYRDTR4UZoAebLB2x6faAMibw94wkoESaUh0LoKi7g5jXUQyotHaq8M97rUgnX3rfL9eShVtwoMxmvcZjpslxgRB+fLjC8oRgsVAlNRfzv8B+/8N1BCLiBjH6aveKzlnZQBqX8FgkXkCUGXLU3op5WGRzVvUfHofJEpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2PQbMKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2PQbMKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B931F00893;
	Sun,  7 Jun 2026 13:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780837327;
	bh=stmqhoETigfH+8EpPioztGEeIEgoSqdDsZGsfvKotPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B2PQbMKRWeWtmU3C8n64n2oGIssuMaKCHaSVY3HV8T8cTIVFWLNyPxL5ghJynhzN3
	 lf9x9XxXLLHL3JrSi06nLH4YlHOPWbbGpSjyrID+bSOEaXRlLNXb/iooT9LZALMAy1
	 Qnj1KqnxDmlBApLy4hIedg/TiMnf1JFnYrhTzspCMtV1OmXAs3meUeoEIQe+ZSY2hA
	 ciH9nfBZCKsB03n7ZUs4EMI+RYnZhheGr+n60F5hr/vjX4FNO/zoyuEbV9x+lPHHGA
	 kwb/NLhNw3uGv7yY1k5Au5jduknku4al9MMn1stOuqf91IhuWpbOqRkmTtn6hKaksp
	 0rLkru0HRha7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf: marvell: Add MPAM partid filtering to CN10K
 TAD PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geetha sowjanya" <gakula@marvell.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260607125101.17778-2-gakula@marvell.com>
References: <20260607125101.17778-2-gakula@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 13:02:06 +0000
Message-Id: <20260607130207.82B931F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] The MPAM partition ID filter incorrectly conflates `partid =3D=
=3D 0` with 'filter disabled', making it impossible to specifically monitor=
 traffic for the default partition (Partition 0).
- [Medium] The driver fails to validate `config1` during event initializati=
on, silently ignoring unsupported filter requests instead of rejecting them.

Pre-existing issues:
- [High] The probe function permanently mutates the platform device's memor=
y resource, corrupting it and causing subsequent PMU probes to fail.
- [High] If the memory resource size is smaller than expected, an early loo=
p termination leaves region pointers unmapped but sets `region_cnt` incorre=
ctly, causing a kernel panic.
- [High] Registering the CPU hotplug instance before the PMU creates a race=
 window where a concurrent CPU offline event triggers context migration on =
an uninitialized PMU context.
--

commit f8a0b0ecde1dfeec7798c8aca48869ad592602c8
Author: Tanmay Jagdale <tanmay@marvell.com>

perf: marvell: Add MPAM partid filtering to CN10K TAD PMU

The TAD PMU exposes counters that can be filtered by MPAM partition id
for a subset of allocation and hit events.

Add a 16-bit partid format attribute (config1) and route counter
programming through variant-specific ops so CN10K keeps MPAM-capable
programming while Odyssey keeps the reduced event set without
advertising partid in sysfs.

> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_=
cn10k_tad_pmu.c
> index 51ccb0befa05d..7a3b659c999a2 100644
> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
[ ... ]
> @@ -27,30 +30,92 @@ struct tad_region {
>  	void __iomem	*base;
>  };
> =20
[ ... ]
> +static void tad_pmu_start_counter(struct tad_pmu *pmu,
> +				  struct perf_event *event)
> +{
> +	const struct tad_pmu_data *pdata =3D pmu->pdata;
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u32 event_idx =3D event->attr.config;
> +	u32 counter_idx =3D hwc->idx;
> +	u64 partid_filter =3D 0;
> +	u64 reg_val;
> +	u32 partid;
> +	int i;
> +
> +	partid =3D (u32)(event->attr.config1 & GENMASK(15, 0));
> +
> +	for (i =3D 0; i < pmu->region_cnt; i++)
> +		writeq_relaxed(0, pmu->regions[i].base +
> +			       TAD_PFC(pdata->tad_pfc_offset, counter_idx));
> +
> +	if (partid && event_idx > 0x19 && event_idx < 0x21) {

[Severity: Medium]
Since an unconfigured perf_event_attr defaults to 0, using 0 as a sentinel
for "no filter" means explicit requests for Partition 0 will bypass the fil=
ter.

Can this be changed so that users can specifically monitor traffic for
Partition 0?

> +		partid_filter =3D TAD_PRF_MATCH_PARTID | TAD_PRF_PARTID_NS |
> +				((u64)partid << 11);
> +	}
[ ... ]
> @@ -242,9 +288,11 @@ static const struct attribute_group ody_tad_pmu_even=
ts_attr_group =3D {
>  };
> =20
>  PMU_FORMAT_ATTR(event, "config:0-7");
> +PMU_FORMAT_ATTR(partid, "config1:0-15");

[Severity: Medium]
Is there missing validation for config1 in tad_pmu_event_init()?

Without it, the driver silently ignores unsupported filter requests instead=
 of
rejecting them with -EINVAL, returning globally aggregated counts rather th=
an
the requested isolated counts.

> =20
>  static struct attribute *tad_pmu_format_attrs[] =3D {
>  	&format_attr_event.attr,
> +	&format_attr_partid.attr,
>  	NULL
>  };
[ ... ]
> @@ -344,7 +411,6 @@ static int tad_pmu_probe(struct platform_device *pdev)
>  	if (!regions)
>  		return -ENOMEM;
> =20
> -	/* ioremap the distributed TAD pmu regions */
>  	for (i =3D 0; i < tad_cnt && res->start < res->end; i++) {
>  		regions[i].base =3D devm_ioremap(&pdev->dev,
>  					       res->start,

[Severity: High]
This is a pre-existing issue, but the probe function mutates the platform
device's memory resource (res->start +=3D tad_page_size inside the loop).

If the driver is unbound and rebound, does this corrupted res->start cause
the loop condition to fail, leaving regions[i].base unpopulated and causing
a NULL pointer dereference later?

[Severity: High]
This is also a pre-existing issue, but if this loop terminates early because
the memory resource size is smaller than expected, tad_pmu->region_cnt is
later set to tad_cnt instead of the number of mapped regions (i).

Could this result in out-of-bounds NULL pointer dereferences during PMU
operations?

> @@ -374,14 +440,16 @@ static int tad_pmu_probe(struct platform_device *pd=
ev)
>  		.read		=3D tad_pmu_event_counter_read,
>  	};
> =20
> -	if (version =3D=3D TAD_PMU_V1)
> +	if (version =3D=3D TAD_PMU_V1) {
>  		tad_pmu->pmu.attr_groups =3D tad_pmu_attr_groups;
> -	else
> +		tad_pmu->ops		 =3D &tad_pmu_ops;
> +	} else {
>  		tad_pmu->pmu.attr_groups =3D ody_tad_pmu_attr_groups;
> +		tad_pmu->ops		 =3D &tad_pmu_v2_ops;
> +	}
> =20
>  	tad_pmu->cpu =3D raw_smp_processor_id();
> =20
> -	/* Register pmu instance for cpu hotplug */
>  	ret =3D cpuhp_state_add_instance_nocalls(tad_pmu_cpuhp_state,
>  					       &tad_pmu->node);

[Severity: High]
This is a pre-existing issue, but does registering the CPU hotplug instance
before the PMU is fully initialized create a race window?

If a CPU offline event happens before perf_pmu_register() completes,
could perf_pmu_migrate_context() dereference an unallocated
pmu->cpu_pmu_context, leading to a kernel panic?

>  	if (ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607125101.1777=
8-1-gakula@marvell.com?part=3D1
