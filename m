Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C8330D43
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280522; cv=none; b=d0y/cs6a5yVgqZcBTaeIEh2NHmkmDedDZt6ust4LcJV2MloJUD1Udiz/xm5lnpzqaYJR5C/tuxrJckoogoGK+rM/X58yhmNZFDREQDOWUS50IfniqY3P3IqFCHxfC6g3nlVavLMijVdin+Wp0LLfZZQYRA24sJpDa7FrldMrYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280522; c=relaxed/simple;
	bh=7d3xt9sJ3YkpAspLfAT0mf8fVB2qv6w5JXmXvkOFCac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gKb2/yhnRaNQSQdOemczE4muPLhAFsHbh5snBi+KoFbIPo8/GF9uJpubU1dEYQ/Vlkhn0P+/5klXJ0W6PnKsTnyoXd9ZnqZQr9fn2u0hdVqt0gzk0nnoYxOHw8aXW+myYV2yEQYeYWN2DCtZY0tGI3Y4vpYog44uE1ZtPdIOKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWL6vdLn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWL6vdLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BB51F000E9;
	Fri, 21 Aug 2026 02:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787280520;
	bh=kjLsMr3srGt63zAiOWDZynDrAKYkGoEZhF3W6PYBYsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AWL6vdLnPEZA4/0KPcOUjtsTGJswEMa8ojznLW1IVcH7I+sTzKG/3wEt2UGj6+pyt
	 Pcnx7CU1LVzmUHhfqi8rpYykRFOqflTJM4XqBvatq6lCOCYVEUU/zenFzR2tW7jl3D
	 oyGOP+3mNCurPRyAi71pcoKTSB7MkYbgUPWROFe8z7aN1u4os+rXYvAVGol7wIXeBN
	 6L59+GEJCvnKN+w/BCpiQnRiPWjM6mko84UtgTGgMNMHTyi1dXwwAfAYMsLDcxiUox
	 BvqOwoXyFcDzyUwkHf+qHvlCjVPx78dLHBCKnBHoXVgxlk6XtargxIo5si38ZQeDMu
	 duIxhEsxM0Atg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] iommu/riscv: create a auxiliary device for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821023854.2746349-3-zong.li@sifive.com>
References: <20260821023854.2746349-1-zong.li@sifive.com>
 <20260821023854.2746349-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 02:48:40 +0000
Message-Id: <20260821024840.A1BB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free in perf and CPU hotplug subsystems due to missing P=
MU auxiliary device teardown.
--

--- Patch [2]: [PATCH v5 2/2] iommu/riscv: create a auxiliary device for HP=
M ---
commit b2eacf422db59a71568f8ca57785c37570b8d0bc
Author: Zong Li <zong.li@sifive.com>

iommu/riscv: create a auxiliary device for HPM

Create an auxiliary device for HPM when the IOMMU supports a
hardware performance monitor.

> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index cec3ddd7ab103..7f619971bb701 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c

[ ... ]

> @@ -565,6 +569,36 @@ static irqreturn_t riscv_iommu_fltq_process(int irq,=
 void *data)
>  	return IRQ_HANDLED;
>  }
> =20
> +/*
> + * IOMMU Hardware performance monitor
> + */
> +static void riscv_iommu_pmu_id_free(void *data)
> +{
> +	ida_free(&riscv_iommu_pmu_ida, (unsigned long)data);
> +}
> +
> +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> +{
> +	struct auxiliary_device *auxdev;
> +	int id, ret;
> +
> +	id =3D ida_alloc(&riscv_iommu_pmu_ida, GFP_KERNEL);
> +	if (id < 0)
> +		return id;
> +
> +	ret =3D devm_add_action_or_reset(iommu->dev, riscv_iommu_pmu_id_free,
> +				       (void *)(unsigned long)id);
> +	if (ret)
> +		return ret;
> +
> +	auxdev =3D __devm_auxiliary_device_create(iommu->dev, "riscv-iommu",
> +						"pmu", iommu, id);

[Severity: High]
If the parent RISC-V IOMMU device is removed (e.g., via PCI hot-unplug hand=
led=20
by riscv_iommu_pci_remove()), the driver core triggers devres cleanup which=
=20
destroys this auxiliary device.

However, the corresponding PMU driver in drivers/perf/riscv_iommu_pmu.c
does not have a .remove callback to unregister the PMU and CPU hotplug
instances globally.

Since devm will free the struct riscv_iommu_pmu memory when this auxiliary=
=20
device is destroyed, won't this leave dangling pointers in the perf and CPU=
=20
hotplug subsystems?

Could a subsequent CPU hotplug event or userspace perf interaction=20
(e.g., via perf_event_open) trigger a use-after-free on the freed memory?

> +	if (!auxdev)
> +		return -ENODEV;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821023854.2746=
349-1-zong.li@sifive.com?part=3D2
