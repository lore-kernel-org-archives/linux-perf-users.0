Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FBA426ED3
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019841; cv=none; b=rdU+fJrKlW89g21v/K8eelA7ksWIvzhfwphdqRDkKAR0wVeaKQHW7ou2mvQRlcP1Q+Rb88ynyo4ueo2TtWhmJAcoRZvl8H9ih8ghHaw0lwO9oJm5BsHjICzgjnBBHxY4zE+I3bA2H1SuSTs4b7B5a1F63u/+UyHbLQtsUgeP4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019841; c=relaxed/simple;
	bh=DGk8dvkkQ5ogMFuduNLrnjVSSOdLmz4IXeHGmcK0YJ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gi53DDzY0/kbasAhP8vnXi6xTL9NcZWGJhgDG9qhWKe+oiKQg9fxEwAnXgdBXeEtWAGLnbNw44VbhmXQDL3qXRP9hOijLw+/ROuD5/q4WZIbkycGR9lyoqUuf9DERZ55Eyadz0wZMc/xjSewK/R8nbg6wuAqNQhipp7E2y9+PNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQB//8pY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQB//8pY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87F81F000E9;
	Tue, 14 Jul 2026 09:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784019840;
	bh=7GFuEB4GmeSFevNn6hzPw7t9apH6UxZRJvNM/rkn2Qw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQB//8pYhZbNPdb5qByKMxhZ5tdUinKinao+CHD3EroSPdTPUcNOz6NDooQcfjtW5
	 1OcwuBp1Ng0NnFMHqkhBuO8RzGZPHVhM6nxqE0zRGFboT516O//8G1TC2pgdwvGSnr
	 jNwiLyRnd1NzMJglkKP1tFMdq96DWDkyC8hRoJNsGiVfsikfoPuG+SRib/s2RjDFHs
	 CgMqD+mHpTU5sLO3MB7NA4P8bauvdMvWwpJrcXb7YzSc+br2quQtDprd1Mzn6HLapu
	 ypFDnoWUKjF9ND+Nt2y/ACc8gA/5uGxR9N7X7rOjCj4VsattT6yLDqSN9pJNXxysfY
	 n3+aD8wpvQthA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] iommu/riscv: create a auxiliary device for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714083625.1083606-3-zong.li@sifive.com>
References: <20260714083625.1083606-1-zong.li@sifive.com>
 <20260714083625.1083606-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 09:03:59 +0000
Message-Id: <20260714090359.D87F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Data truncation, negative sysfs ID, and information leak when pass=
ing physical address to auxiliary device ID.
- [High] Teardown asymmetry causing Use-After-Disable and guaranteed Use-Af=
ter-Free of PMU structure.
- [Medium] Overly generic auxiliary device namespace risking collisions.
--

--- Patch [2]: [PATCH v4 2/2] iommu/riscv: create a auxiliary device for HP=
M ---
commit b51f5eeba53f86d299b4eda15a076df1b60764b8
Author: Zong Li <zong.li@sifive.com>

iommu/riscv: create a auxiliary device for HPM

This commit creates an auxiliary device for the hardware performance monitor
when supported by the IOMMU. It uses the physical address of the device
directory table as the unique ID for the auxiliary device.

> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c

[ ... ]

> @@ -565,6 +566,21 @@ static irqreturn_t riscv_iommu_fltq_process(int irq,=
 void *data)
>  	return IRQ_HANDLED;
>  }
> =20
> +/*
> + * IOMMU Hardware performance monitor
> + */
> +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> +{
> +	struct auxiliary_device *auxdev;
> +
> +	auxdev =3D __devm_auxiliary_device_create(iommu->dev, KBUILD_MODNAME,
> +						"pmu", iommu, iommu->ddt_phys);

[Severity: High]
Will this cause truncation and potentially negative sysfs IDs?

The fifth argument to __devm_auxiliary_device_create() is an int id, but we
are passing iommu->ddt_phys which is a 64-bit dma_addr_t.

If bit 31 of the physical address is set (which is common for RAM on RISC-V=
),
the truncated integer becomes negative, resulting in malformed sysfs
directories.

Could this also cause sysfs naming collisions if two IOMMUs share the same
lower 32-bits of their physical address?

[Severity: Medium]
Could KBUILD_MODNAME result in an overly generic namespace for the auxiliary
bus?

Since this source file is compiled as iommu.o, KBUILD_MODNAME evaluates to
"iommu", creating an auxiliary device named "iommu.pmu.<id>".

If another IOMMU driver also registers a "pmu" auxiliary device using
KBUILD_MODNAME, would they collide on the bus, or could the riscv_iommu_pmu
driver incorrectly bind to the wrong device in a multi-arch build?

[Severity: High]
Does using a devm-managed allocation here create a teardown asymmetry with
the manual hardware shutdown in the remove path?

Because devm cleanup executes after the driver's remove callback returns,
the auxiliary device will remain active while the IOMMU hardware is disable=
d:

riscv_iommu_remove()
    ...
    riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
    ...
<driver remove returns>
<devm cleanup destroys the auxiliary device>

Does this leave a window where an active devm-managed PMU interrupt could f=
ire
and attempt to access disabled hardware?

> +	if (!auxdev)
> +		return -ENODEV;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714083625.1083=
606-1-zong.li@sifive.com?part=3D2
