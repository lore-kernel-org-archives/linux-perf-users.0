Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162B34F247
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046539; cv=none; b=P1CAzrBdydbbR7GkcX4EK21K7ETYx1OuPTfwH7lYR4Yso6t1GVFXcFA9I38Z+lLKSkWmB6MSOo3wRYjEEiXWTzHRv2s4fjcA6Ihlt6aKojBIzluho+O4LY7M9b0Ixq+sGei+kc9WkGTpYEmZkr+lu1W3lp+K9kWBSboSbzTgVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046539; c=relaxed/simple;
	bh=o+DI2ATmHmmMShZsrAW5XTL+OqcZWl5OjU5wQ7YREJs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DXqwDVlmorWiaHdMefM+LeHR4wujMQQf4/Krtm8rQUVxgi/Yi0mb5/iyCITiMAJyqNLm9vctrCQEGMN02zpYopPKnpQ7MBfRx91hGrgjkUEUfPx8ZpJKXfCFZt6s1PJnhJ1RbomvYjFfwMPz7e1ocn3cLkZIYB5F1MoSqB4GUOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXt0Z5pG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXt0Z5pG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61841F000C4;
	Thu, 15 Oct 2026 06:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792046537;
	bh=WARS0vPHNwwx/EAvLS/qEiEmnNgMVZNIOkPrG3QfCQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WXt0Z5pGH++N6wLzb7AhIeyV1l1Tp4jeOeDOdywWbrbojRg7RGrUyzbOHi/oX4ji1
	 oMN1hMLDDGceTK9OogJjSEIa8JfE/9bm6tGvxCLPtAcGetviEj4/aCHjqkH7+Vc5m/
	 hHO3gr0iExvXEbQj06lMTXLCBrVBp/bwFNynVqDwWPGnMu8HANBwdxS6zmnMKJG2SG
	 BIFGxVTBq6Lj1JuWGkkfwRiYFoqtlsKfACPL1gncnlPN3kVVUn/oZiLxny3lpkN+IA
	 T7gvA/6dh/S7+GWG9PnFoe6K090zrExfJ6dC04Ogw9+HeSwH+CdEhQrx4GnO1mWpuG
	 rkUaKx7c67jkA==
Message-ID: <sashiko-outbox-172355@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: arm_spe: Support heterogeneous ACPI systems
Reply-To: sashiko-reviews@lists.linux.dev
To: Johnny.Fan <johnny.fan@cixtech.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015062908.3565761-1-johnny.fan@cixtech.com>
References: <20261015062908.3565761-1-johnny.fan@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 06:42:17 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf: arm_spe: missing heterogeneity check for optional PMUs
- [Medium] perf/arm_spe: spurious probe failure due to CPU hotplug race
--

commit 9ac6f1b22e8955b2543af029311236c9a14923ec
Author: Johnny.Fan <Johnny.Fan@cixtech.com>

perf: arm_spe: Support heterogeneous ACPI systems

The ACPI MADT describes the SPE overflow interrupt on a per-CPU basis
in the GICC structure, where a CPU that does not implement SPE simply
reports 0. Heterogeneous systems therefore only report the interrupt
on the CPUs that implement SPE, but arm_pmu_acpi.c rejects this as a
non-homogeneous mapping and never creates the SPE platform device.

> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index ca6bf8f86cfe9..4ece1070827b9 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
[ ... ]
> @@ -97,6 +100,20 @@ arm_acpi_register_pmu_device(struct platform_device *=
pdev, u8 len,
>  			return gsi ? -ENXIO : 0;
> =20
>  		this_gsi =3D parse_gsi(gicc);
> +
> +		if (optional) {
> +			if (!this_gsi)
> +				continue;
> +
> +			if (gsi && gsi !=3D this_gsi) {
> +				pr_warn("ACPI: %s: CPU%d: inconsistent interrupt %u/%u\n",
> +					pdev->name, cpu, gsi, this_gsi);
> +				return -ENXIO;
> +			}
> +			gsi =3D this_gsi;
> +			continue;
> +		}
> +
>  		this_hetid =3D find_acpi_cpu_topology_hetero_id(cpu);
>  		if (!gsi) {
>  			hetid =3D this_hetid;

[Severity: High]
Does skipping find_acpi_cpu_topology_hetero_id() allow grouping CPUs from
different microarchitectural clusters into a single PMU device?

The SPE PMU driver (arm_spe_pmu_dev_init()) assumes a single PMU device is
homogeneous. It probes SPE parameters (e.g., align, max_record_sz, features)
on a single CPU via smp_call_function_any() and applies them to all CPUs in
spe_pmu->supported_cpus.

If heterogeneous CPUs with different SPE capabilities are grouped together,
scheduling a perf event on a CPU from a different cluster could program the
hardware with mismatched constraints or feature flags. Could the this_hetid
check be preserved for the CPUs that actually implement the optional PMU?

> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 604ae6ba3b076..c1ff875be9577 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
[ ... ]
> @@ -1277,6 +1291,12 @@ static int arm_spe_pmu_cpu_startup(unsigned int cp=
u, struct hlist_node *node)
>  	if (!cpumask_test_cpu(cpu, &spe_pmu->supported_cpus))
>  		return 0;
> =20
> +	/* The CPU was offline during probe; trim it if it lacks SPE */
> +	if (!arm_spe_pmu_pmsver()) {
> +		cpumask_clear_cpu(cpu, &spe_pmu->supported_cpus);
> +		return 0;
> +	}
> +
>  	__arm_spe_pmu_setup_one(spe_pmu);

[Severity: High]
Is it possible for the newly online CPU to have a different version of SPE
than what was cached during the initial probe?

This startup check only verifies that the CPU has some version of SPE
(checking pmsver !=3D 0), but does not verify that the SPE parameters match
the ones cached from the initial probe.

[ ... ]
> @@ -1346,6 +1366,21 @@ static int arm_spe_pmu_irq_probe(struct arm_spe_pm=
u *spe_pmu)
> =20
>  	cpumask_copy(&spe_pmu->supported_cpus, affinity);
> =20
> +	/*
> +	 * Heterogeneous systems may only implement SPE on a subset of the
> +	 * CPUs covered by the interrupt affinity (ACPI in particular has
> +	 * no affinity information and falls back to cpu_possible_mask).
> +	 * SPE is self-describing through PMSVer, so drop the online CPUs
> +	 * that do not implement it. CPUs that are offline at probe time
> +	 * are checked when they come up.
> +	 */
> +	for_each_cpu(cpu, &spe_pmu->supported_cpus) {
> +		if (cpu_online(cpu))
> +			smp_call_function_single(cpu,
> +						 __arm_spe_pmu_trim_supported_cpus,
> +						 spe_pmu, 1);
> +	}
> +
>  	spe_pmu->irq =3D irq;
>  	return 0;
>  }

[Severity: Medium]
Could this cpu_online(cpu) check without holding cpus_read_lock() lead to a
race condition with CPU hotplug?

If an offline CPU lacking SPE comes online immediately after this loop, it
could remain in supported_cpus because the hotplug callback is not yet
registered.

Later, arm_spe_pmu_dev_init() consumes this mask:

	ret =3D smp_call_function_any(mask,  __arm_spe_pmu_dev_probe, spe_pmu, 1);
	if (ret || !(spe_pmu->features & SPE_PMU_FEAT_DEV_PROBED))
		return -ENXIO;

This could select the newly online CPU that lacks SPE, causing the driver
probe to spuriously fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015062908.3565=
761-1-johnny.fan@cixtech.com?part=3D1
