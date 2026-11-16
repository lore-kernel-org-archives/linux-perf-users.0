Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854311;
	b=dfrqxPKcuxRUFNyoCPylBDM3tVMhU74W3IyEI/Aw629+olQ+tgyOm2yT0xA7Nv3+1/KR
	 otSCjsIflVokWaE7ydqbsUnSVAZBzgSRF4M4LcpBa0LcbZPxvtJSDnTYuvICsDyyGz5/B
	 0hTp09a7Jj3GYJmNbSplpNfJysPgmuAE25PYBqa0YG04/E2wnr67S9dhQtya4X2NRZQVi
	 nZ5IJfLvVNuoTkbaef2zpm9oaWDLMXMYCOCZX9en86amqvDzcxS80UDERWSu4Ksk2Y9o8
	 2b4hBv1JmxYFdkX/f6/FEmptApB6gw2mB/P0ScW9Q82p0nUURANvMiz1JQGwQKS91JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854311;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gyNkzmLcY6lF/yQgk6syenWEmWEhWKrMXuK3hfBI+G8=;
	b=G47EPH2/ZZTRER+6WJ3w1RQAmvY0foJP0Koqw1nMB8tTVXUj7Omjj19rVjPB7H0o277e
	 jeEH3vWc/HPH4wqXAXwkonC2iX712yOtpjmeDuZ5zi2fGGEccUK/YV2V0Ou4MsyFk+opw
	 iErxtV6ZnCIiRnw9nfmHUkBh6G1OzUlHLc3+UcFu0EYhLdsqZg49U+RY8QOUu+y5B0Pbl
	 DkPULev6ze+hO1lrnPVgn5Esuyhspa00DdQt6g3e2gbL12K5qcma0Su2nTNVXgChpTvUc
	 yRVKqrHQYfXN3aof19SStWcvwc2sAgvEDnwdUKN00ZVlbcm6oM5hToVfwiPgEMvloXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZU24T6vm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C3606A332;
	Mon, 16 Nov 2026 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZU24T6vm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C323B1F000CD;
	Mon, 16 Nov 2026 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794854311;
	bh=gyNkzmLcY6lF/yQgk6syenWEmWEhWKrMXuK3hfBI+G8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZU24T6vmws0venIEvLpnxXXzMZT2Xiaee69SJKdG/0AJbPHZTYkkUMyivCgQR3jAQ
	 yVyVcul0P3liPZ60/GaSz5f/53t3luAgSEe9Pr12Xa8+SsIlzStGLFhvFO/HGwkWch
	 Jg+LJyery52ffZ4BInB+zHX7LWRfeLA+M+eVqeRu3Q4creDmy/9BpP+dv06iL21ltw
	 pX4kkFEw+wU0K0boNrN+FN47s8CI+KBHa1Svbe66u77wzumLnFBLe08a23WzdkpWr5
	 8H+FgZbKMqRDLNwkNfTKGBAa1VmFAXFh1iVTYVYL4Xtisu/rOPmcNfn0vDHfP6by0p
	 ydX+XJ10/oukA==
Message-ID: <sashiko-outbox-217507@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] perf/arm_pmu: Register ACPI SPE and TRBE devices
 with software nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116-acpi_arm_pmu_registration_hmp-v1-3-0371d4eca626@arm.com>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
 <20261116-acpi_arm_pmu_registration_hmp-v1-3-0371d4eca626@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 18:38:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf/arm_pmu: arm_acpi_alloc_pmu_groups() fails and warns on
  older MADT tables
--

commit 0dc63259559ab5780db0b0b7b9fa3866f77b52f2
Author: Johnny.Fan <johnny.fan@cixtech.com>

perf/arm_pmu: Register ACPI SPE and TRBE devices with software nodes

This commit groups initialized CPUs by MIDR and registers one SPE or TRBE
platform device per group with a software node describing its IRQ
affinity.

> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index ca6bf8f86cfe9..7ae291acb0452 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
[ ... ]
> @@ -68,92 +72,297 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
[ ... ]
> +static struct arm_pmu_acpi_group **
> +arm_acpi_alloc_pmu_groups(const struct arm_pmu_acpi_device_info *info,
> +			 int *nr_groups_out)
> +{
> +	struct arm_pmu_acpi_group **groups;
> +	int cpu, nr_groups =3D 0;
> +
> +	*nr_groups_out =3D 0;
> +
> +	groups =3D kcalloc(num_possible_cpus(), sizeof(*groups), GFP_KERNEL);
> +	if (!groups)
> +		return NULL;
> =20
> -	/*
> -	 * Sanity check all the GICC tables for the same interrupt
> -	 * number. For now, only support homogeneous ACPI machines.
> -	 */
>  	for_each_possible_cpu(cpu) {
>  		struct acpi_madt_generic_interrupt *gicc;
> +		struct arm_pmu_acpi_group *group;
> +		u32 gsi;
> +
> +		/* CPUs that have never booted have no saved MIDR */
> +		if (!per_cpu(cpu_data, cpu).reg_midr)
> +			continue;
> =20
>  		gicc =3D acpi_cpu_get_madt_gicc(cpu);
> -		if (gicc->header.length < len)
> -			return gsi ? -ENXIO : 0;
> -
> -		this_gsi =3D parse_gsi(gicc);
> -		this_hetid =3D find_acpi_cpu_topology_hetero_id(cpu);
> -		if (!gsi) {
> -			hetid =3D this_hetid;
> -			gsi =3D this_gsi;
> -		} else if (hetid !=3D this_hetid || gsi !=3D this_gsi) {
> -			pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
> -			return -ENXIO;
> +		if (gicc->header.length < info->len) {
> +			pr_warn("ACPI: %s: miss GICC entries\n", info->name);
> +			goto out_free;
>  		}

[Severity: Medium]
Does this cause spurious boot warnings on platforms with older MADT
revisions?

Previously, gicc->header.length < len returned 0 silently when no prior
CPU had advertised a non-zero GSI.  Now, on systems with MADT GICC entries
predating ACPI 6.3 (for SPE) or ACPI 6.5 (for TRBE),
arm_acpi_alloc_pmu_groups() logs a warning and returns NULL, which
arm_acpi_register_pmu_devices() turns into -ENOMEM and a second "Unable
to register device" warning in arm_spe_acpi_register_device() and
arm_trbe_acpi_register_device().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-acpi_arm_p=
mu_registration_hmp-v1-0-0371d4eca626@arm.com?part=3D3
