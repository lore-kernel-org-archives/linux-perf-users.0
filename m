Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4C3438A7;
	Thu, 16 Jul 2026 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215603; cv=none; b=B0P9fvbcTiezUmGaV2QC8KUvj2TlGK+jjz7vU937/b0W2orYEqC3PowWRIRe6+pvHu6WNOMyJIxsx8p3TSBQUiACImr1C7Aj9SdpsTc50SHp+hNfA4SBFoebY3wj01Hq/TZQer7JRKXDetKh8PSrDu0C6LDri37HCXiIyUit558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215603; c=relaxed/simple;
	bh=3XPQ3pUFvXvJ9zpTOdCTlCbKI1OUsPIauyK/P4lHtQ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p4MbNcnYI/mAjproav/7FhrR/dGDJmK+KsHbzI6coV5n1+d/RIACdawveYFxocxpiaP9s4UfrYWDZ1h6OXrChXMhbQZv6cjQ+5rQyChC37eLPvAKKtXNym2qT59jEmaRzMxA2HbG+rMrN2Kl4kBGpnv3eHFHufn1LVEEG1HAij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD9LpUGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD9LpUGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172B31F000E9;
	Thu, 16 Jul 2026 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784215602;
	bh=bXCrjwQ1SQxd+/3B2gEZ5t0RRHblVDCiWKv+BWA245U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WD9LpUGN/rsuIe3CAV7iBozBu6kcmHyFk61Q8YM2X9lIeWuQFmzQmq1KVV8ATjcNw
	 birrbFxN++ET4bt+irIAOGA1nJ+nIDdlrL4mxD7981hYJyqmLhzbTXSr2T5xl1qnwz
	 VTLGZ6f/bo3ge0s8itzkKGBvlyF7WHOktOMed19rjkvkPg6StpXndrPaNprOvfEPpU
	 pIDDFQMRkLTPMcZI0J8DoyGKBj+XyM1fpF/FngxyhYeazCSTkWMC0tdoaleLwoQKDC
	 a6uweNshPg26tSm1R2N3ROrfd9MdSdLq9Ee8wxfpV8WsRYOk7zR7KXBXZbd7XzWYjG
	 Eh1Km9M9SwYRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf/arm-bmu: Add Devicetree support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: conor+dt@kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <c797080aaa2f51273267a24e256cab083e64b156.1784214112.git.robin.murphy@arm.com>
References: <cover.1784214112.git.robin.murphy@arm.com>
 <c797080aaa2f51273267a24e256cab083e64b156.1784214112.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:26:41 +0000
Message-Id: <20260716152642.172B31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Implicit declaration of function 'acpi_device_uid' causes a build f=
ailure when CONFIG_ACPI is disabled.
--

--- Patch [3]: [PATCH v2 3/3] perf/arm-bmu: Add Devicetree support ---
commit b787d1765a1d6aaa8fa04e23d64224ec5f6d4dc3
Author: Robin Murphy <robin.murphy@arm.com>

perf/arm-bmu: Add Devicetree support

This commit introduces Devicetree support for the ARM Bus Monitor Unit. It
adds the necessary OF match tables and relaxes the Kconfig dependencies so
the driver is no longer strictly tied to ACPI.

> diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kcon=
fig
> --- a/drivers/perf/arm_cspmu/Kconfig
> +++ b/drivers/perf/arm_cspmu/Kconfig
> @@ -30,6 +30,6 @@ config AMPERE_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> =20
>  config ARM_BMU
>  	tristate "ARM Bus Monitor Unit"
> -	depends on (ARM64 && ACPI) || COMPILE_TEST
> +	depends on ARM64 || COMPILE_TEST
>  	help

[ ... ]

> diff --git a/drivers/perf/arm_cspmu/arm-bmu.c b/drivers/perf/arm_cspmu/ar=
m-bmu.c
> --- a/drivers/perf/arm_cspmu/arm-bmu.c
> +++ b/drivers/perf/arm_cspmu/arm-bmu.c

[ ... ]

> @@ -406,7 +407,10 @@ static int arm_bmu_probe(struct platform_device *pde=
v)
>  		.read =3D arm_bmu_event_read,
>  	};
> =20
> -	name =3D acpi_device_uid(ACPI_COMPANION(dev));
> +	if (has_acpi_companion(dev))
> +		name =3D acpi_device_uid(ACPI_COMPANION(dev));

[Severity: Low]
Does this cause a build failure in arm_bmu_probe() when CONFIG_ACPI is
disabled?

Since the strict ACPI dependency was removed in Kconfig, building for stand=
ard
ARM64 without ACPI is now possible. It appears acpi_device_uid() might not =
be
stubbed out or available when CONFIG_ACPI is turned off, leading to an impl=
icit
function declaration error during compilation.

> +	else
> +		device_property_read_string(dev, "label", &name);
> =20
>  	if (name)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784214112.gi=
t.robin.murphy@arm.com?part=3D3
