Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548892;
	b=dmDyXajn/bk312x2cg+QobH2WRUcncaCOrYqvwmADylMJ7sYVhH9DgdPEQshwn20x4wh
	 WDEMKCmbbHDTZS+wnC+w/PQBmUDBf8K+bT9fE7bHUiBLhOnWluNJd+1NriRGCPTC7KzjJ
	 b9CLNS4L6CC1jje1S0PUJ+ceY/O6KGVsYId6+5xIK46FLzFjVe57GzUyGTLDM3HK53zrn
	 p++zzIcRLYM5GBClnGQuxPB7IO6y4nBac4jdZuk6dx3OER080vZgKf0eZ5HkNFWX2QYof
	 npnMdjV8EgyOT7SYca/BVXnhhPZevyZkp3z/zh/+c/QRPBmJjF3I6aEe5yGeIQlrBYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548892;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CC9ZEH7TYZy17mupHpeJeG/kH88P+EfBdqRFPWmx4+w=;
	b=MPtU3KJGcYGelPW02Uf3OIfqy+uM8MqaUMmyZNIchXv4qFVgCXrXAUVluIZA0mFH4zlP
	 yJ2GWEhD2A+VpWCD3ge/GM2TAptSYmo4GfE0zvpUpkpG+sqKsd0hG+7dwiEZWWmQhd1yn
	 AmpDMJRzEV6a9wR7CJk8kMx0U5+4xuBSYhIjVwpxnVbnS7vYVsjSJS1nKW1JtOSbONtdp
	 OgHrxpO9vh5cr9QdYDKVEvydATZLHvOdXlc+u2rMlOb6ppR4VbF1FH3No0pyEdQizOkrP
	 FSzcA4Slg7hBZyWNFt0DkwC6/0brngjUZP8ciN+1MmkHjRquwcYur2lOZjcgbmFK53g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Taby59BF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C28606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 02:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Taby59BF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F8F1F000CA;
	Wed, 21 Oct 2026 02:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792548892;
	bh=CC9ZEH7TYZy17mupHpeJeG/kH88P+EfBdqRFPWmx4+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Taby59BFx4qgANU7rHJxhxfvdHUrcjLBO+nv1khlA8DeC2Q7zJnrQNiZdCsPi3+4u
	 pQFvoCYiMZtS6MQr8mjKQ3oObhWOEHohK465uEDWfM2WuSaYquiPPTARGgfZp73yY9
	 vvRPYnvbKmtGHB/qrME931r+p7CTfFHCTsyLiMnEyBzX6ow2xoSDj9I0ZRP5aMPw43
	 mQP2hcz6uOfMEW7WbIGT8t436JRbPU3ayjjzYP8O3uH6NMbzfD1hdri+CljRW+Ix4x
	 GDJvkK9qfd7FP8q9Ut0nevPjs2Xs1aJrz3TKus8Ol+xr1bvY568VeRvUEU6/b4y+6l
	 sQReWXewduHCg==
Message-ID: <sashiko-outbox-179692@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf: arm_spe: Support heterogeneous ACPI systems
Reply-To: sashiko-reviews@lists.linux.dev
To: Johnny.Fan <johnny.fan@cixtech.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021020322.3015121-1-johnny.fan@cixtech.com>
References: <20261021020322.3015121-1-johnny.fan@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 02:14:51 +0000
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
- [Medium] perf: arm_pmu_acpi: GSI leak in arm_acpi_register_group() when s=
hared
--

commit 07d4d2d60385c80c0a1df910cfddbd2fb128123f
Author: Johnny.Fan <Johnny.Fan@cixtech.com>

perf: arm_spe: Support heterogeneous ACPI systems

This commit updates ACPI registration for ARM SPE and TRBE to group CPUs by
hetero ID and interrupt number, registering one platform device per group
and passing the group's CPU mask via platform data.

> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index ca6bf8f86cfe9..fdf39673648f3 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
[ ... ]
> +static bool arm_acpi_gsi_is_shared(struct arm_pmu_acpi_group *groups,
> +				   int nr_groups, int idx)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < nr_groups; i++) {
> +		if (i !=3D idx && groups[i].gsi =3D=3D groups[idx].gsi)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int arm_acpi_register_group(struct arm_pmu_acpi_group *group,
> +				   const char *name, bool gsi_shared)
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
> +
> +	pdev =3D platform_device_alloc(name, PLATFORM_DEVID_AUTO);
> +	if (!pdev) {
> +		ret =3D -ENOMEM;
> +		goto err_unreg;
> +	}
> =20
> -	if (pdev->resource[0].flags !=3D IORESOURCE_IRQ)
> -		return -ENXIO;
> +	res =3D DEFINE_RES_IRQ(irq);
> +	data.cpus =3D group->cpus;
> =20
> +	ret =3D platform_device_add_resources(pdev, &res, 1);
> +	if (ret)
> +		goto err_put;
> +
> +	ret =3D platform_device_add_data(pdev, &data, sizeof(data));
> +	if (ret)
> +		goto err_put;
> +
> +	ret =3D platform_device_add(pdev);
> +	if (!ret)
> +		return 0;
> +
> +err_put:
> +	platform_device_put(pdev);
> +err_unreg:
>  	/*
> -	 * Sanity check all the GICC tables for the same interrupt
> -	 * number. For now, only support homogeneous ACPI machines.
> +	 * The GSI mapping is not reference counted, so only drop it if no
> +	 * other group shares it.
>  	 */
> +	if (!gsi_shared)
> +		acpi_unregister_gsi(group->gsi);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused
> +arm_acpi_register_pmu_devices(const char *name, u8 len,
> +			      u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
> +{
[ ... ]
> +	for (i =3D 0; i < nr_groups; i++) {
> +		ret =3D arm_acpi_register_group(&groups[i], name,
> +					      arm_acpi_gsi_is_shared(groups,
> +								     nr_groups, i));
> +		if (ret) {
> +			pr_warn("ACPI: %s: %*pbl: add device failed (%d)\n",
> +				name, cpumask_pr_args(&groups[i].cpus), ret);
> +			last_err =3D ret;
> +		} else {
> +			nr_devices++;
> +		}
> +	}

[Severity: Medium]
Can this leak the GSI mapping if all groups sharing an interrupt fail to
register their platform devices?

In drivers/perf/arm_pmu_acpi.c, arm_acpi_register_pmu_devices() calls
arm_acpi_gsi_is_shared(), which checks whether any other entry in groups[]
has the same gsi, regardless of whether any of those groups actually
succeeded in registering a platform device.

When two or more groups share the same gsi, arm_acpi_gsi_is_shared() returns
true for every group in that set. If the first group creates the mapping via
acpi_register_gsi() in arm_acpi_register_group() and then fails in
platform_device_alloc(), platform_device_add_resources(),
platform_device_add_data(), or platform_device_add(), the err_unreg path se=
es
gsi_shared as true and skips acpi_unregister_gsi(group->gsi). If the
remaining groups sharing that gsi also fail during registration, none of th=
em
will call acpi_unregister_gsi(group->gsi) either, leaving the GSI mapping
registered with no platform device using it.

Would it make sense to track whether another group sharing the gsi has
already registered successfully, or clean up the mapping if all groups
sharing that gsi fail?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021020322.3015=
121-1-johnny.fan@cixtech.com?part=3D1
