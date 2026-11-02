Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609549;
	b=Y7hsjodJrYC3zvOpu+4T90eZL3YPum8t83UnckDTWXhdpJmmXm1zgI4Fjazjuf2e7vxA
	 s7JqPsRV+g7158czgYYvGoqI6BIWd5c6yLnAUvReDGnyaDatrlAKHPlve2u6P0cWE5Opg
	 qoJJL7lXuDGIiHGWfK3yYAiUnybQQCDsoWTjAFL0nFJ0kCPDBbOigHZyzVxTLSB96CYbz
	 y+oGb+o9sTEZ58iXCVJhJjkbiOZebeV93XAWzz2AGd0NF9CaoJTisN3M+rDsZT2I3zSw/
	 wj019DHHDzFQnL6caq7Tv3MflHSmsRtgw/p7pPEMUWV59hnasUSd8jC/S9NBeBfCpZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609549;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oXlwWNv0AB7RVPq06a/SOny/QMKnPuzfLB/vY96tk3Q=;
	b=mdvAqwLFWHUk3dv//dug/+SNa4NlTkfP4L3cmrzTzBRBfT/G6LLjW8oUWPaZizhQI2QB
	 zjdKlh6/2MiZK5SpKyjeGZ5xdQEgRcXnnAHWC9ui5lvEowuToQHoXDFdWc2mtXsXo0AKC
	 eXU5uHNfcIvQ6Oj3++GJMTGwyLEAXi7qqCYT4gcRjgyYONTFx2Qh7GN2pVTT2vzdsain4
	 paDqitA9GqTEAfWA9xmLgush5a13lqm10IxYHd5mJwFI+7md7KenPpU+ms7yE/9W8IbO5
	 vBfg3FrdM9r1VHWgvavp+d1c7eEpK57htpPEdKnwjklN/dZDjEoTdZ1/uAFrM9//fqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B/cCvI93";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D1606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B/cCvI93
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3176E1F000C1;
	Mon,  2 Nov 2026 08:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793609549;
	bh=oXlwWNv0AB7RVPq06a/SOny/QMKnPuzfLB/vY96tk3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B/cCvI93oE7QNZBeigyEmnwbHFZd1f7BrYCEh2WmdF/UdUIOqiL7EiwtQ4zgGmEtK
	 BNBl8MZLssJprmiT8NeocvbbZA9NOKja0Dj8uMLsoBszxdhwVeGoZitC6WPqoGCXEn
	 wvOchIVoCBB+7qZgyxOZvN5jmdeCnD7ZVlZVz3fW53OkyEHa+RkMK0ETm2e8KlhBuh
	 HzofW85lhinmV3VIWneuM1Etxqll5zR8Kpt51R+P/bL+DbSS8qjRx8513EVLTUYcoj
	 LGgWBb/1vA+grB1s+AWk2ghxUpmvmprneYnCDoTasHY4BOG6ttIYOPkBtzd3hV6PUf
	 lIy+3TKYYtgBA==
Message-ID: <sashiko-outbox-193138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf: arm_pmu_acpi: Support heterogeneous ACPI
 systems
Reply-To: sashiko-reviews@lists.linux.dev
To: Johnny.Fan <johnny.fan@cixtech.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102084153.3975282-3-johnny.fan@cixtech.com>
References: <20261102084153.3975282-1-johnny.fan@cixtech.com>
 <20261102084153.3975282-3-johnny.fan@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 08:52:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: arm_pmu_acpi: unbalanced acpi_unregister_gsi() on group er=
ror
--

commit 160cc5903c9a42ca04c98cc8b994a9fea642d22f
Author: Johnny.Fan <Johnny.Fan@cixtech.com>

perf: arm_pmu_acpi: Support heterogeneous ACPI systems

This commit updates arm_pmu_acpi to support heterogeneous ACPI systems by
grouping CPUs by their PPTT hetero ID and MADT GICC overflow interrupt GSI,
and registering one SPE or TRBE platform device per group with its CPU mask
passed as platform data.

> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index ca6bf8f86cfe9..bffeeb0638004 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
[ ... ]
> @@ -68,91 +70,196 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>  		acpi_unregister_gsi(gsi);
>  }
> =20
> +struct arm_pmu_acpi_group {
> +	int hetid;
> +	u16 gsi;
> +	bool registered;
> +	struct cpumask cpus;
> +};
[ ... ]
> +static bool arm_acpi_gsi_in_use(struct arm_pmu_acpi_group **groups,
> +				int nr_groups, int idx)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < nr_groups; i++) {
> +		if (i =3D=3D idx)
> +			continue;
> +		if (groups[i]->registered && groups[i]->gsi =3D=3D groups[idx]->gsi)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int arm_acpi_register_group(struct arm_pmu_acpi_group *group,
> +				   const char *name)
> +{
> +	struct arm_pmu_acpi_dev_data data =3D { };
> +	struct platform_device *pdev;
> +	struct resource res;
> +	int irq, ret;
> +
> +	irq =3D acpi_register_gsi(NULL, group->gsi, ACPI_LEVEL_SENSITIVE,
> +				ACPI_ACTIVE_HIGH);
> +	if (irq < 0)
> +		return irq;
[ ... ]
> +	for (i =3D 0; i < nr_groups; i++) {
> +		ret =3D arm_acpi_register_group(groups[i], name);
> +		if (ret) {
> +			pr_warn("ACPI: %s: %*pbl: add device failed (%d)\n",
> +				name, cpumask_pr_args(&groups[i]->cpus), ret);
> +			last_err =3D ret;
> +			continue;
> +		}
> +
> +		groups[i]->registered =3D true;
> +		nr_devices++;
> +	}
> +
> +	/*
> +	 * acpi_register_gsi() does not reference count the GSI mapping, so
> +	 * release a shared GSI only once no successfully registered device
> +	 * uses it any more.
> +	 */
> +	for (i =3D 0; i < nr_groups; i++) {
> +		if (groups[i]->registered)
> +			continue;
> +		if (arm_acpi_gsi_in_use(groups, nr_groups, i))
> +			continue;
> +		acpi_unregister_gsi(groups[i]->gsi);
> +	}

[Severity: Medium]
Can this cleanup loop in arm_acpi_register_pmu_devices() make unbalanced
or duplicate calls to acpi_unregister_gsi()?

In arm_acpi_register_group(), if acpi_register_gsi() fails and returns a
negative error code, the function returns early and leaves
groups[i]->registered as false. The cleanup loop in
arm_acpi_register_pmu_devices() then calls acpi_unregister_gsi() for that
group even though acpi_register_gsi() never succeeded.

Looking at drivers/acpi/irq.c:acpi_unregister_gsi():

	if (WARN_ON(acpi_irq_model =3D=3D ACPI_IRQ_MODEL_GIC && gsi < 16))
		return;

	d =3D irq_find_matching_fwnode(acpi_get_gsi_domain_id(gsi),
				     DOMAIN_BUS_ANY);
	irq =3D irq_find_mapping(d, gsi);
	irq_dispose_mapping(irq);

If a malformed MADT GICC entry specifies an SGI (0 < gsi < 16) that
acpi_register_gsi() rejected, calling acpi_unregister_gsi() will hit the
WARN_ON(). Or if acpi_register_gsi() failed in irq_create_fwspec_mapping()
due to a trigger type mismatch with an existing mapping, calling
acpi_unregister_gsi() will dispose of that pre-existing IRQ mapping.

In addition, arm_acpi_gsi_in_use() only checks whether another group with
the same GSI has registered =3D=3D true. If two or more groups share the sa=
me
GSI and all of them fail platform device registration after
acpi_register_gsi() succeeds, arm_acpi_gsi_in_use() returns false for each
of them, causing the loop to call acpi_unregister_gsi() multiple times for
the same GSI.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102084153.3975=
282-1-johnny.fan@cixtech.com?part=3D2
