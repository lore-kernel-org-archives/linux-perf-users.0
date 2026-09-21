Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5AD33E347
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979213; cv=none; b=BzP1BwOfyEckrMLfHbbIUUwkAzHnOk7rTJ0Xb0/Lx8OTF6C1m94Dov9YJbYRGt3r+HNBtJx3xaBGUzdVRgl3Bar/ACvEMFwXH+p/0N7A04M7KDZjjRcQVbWT4P4DF0mdzhBoLJRYvToWEsc606MtIu3+W8V6PmltOfr5VPUQjXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979213; c=relaxed/simple;
	bh=BEJWIhRIWXAWqklwfvfcWpi7BMO2mipQEGVe7lz1BTE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TNHSyeyhp/sR+/aBPv9I3iENWln9Rf6iQrjJzdJFfmpFJE4rQE9ee9LAkVt+LhaD8qS3bq6VsjyKM9Uu5JyVWNewJLnM/GW3bKwTzbbNy1BYdOJDesJ+RAsJNXD3TfHlPli0ec1xAKaEQZ4G8wCzEZVt6DSTQ5EFKcdLQFt1bF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m64jveWR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m64jveWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6EB1F000FF;
	Mon, 21 Sep 2026 08:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979211;
	bh=QY+9TpzLlBCCWuvk8VjlAfu2CP4C6eWCQviYDeAZrZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m64jveWRAMF6Dbp6GKlnck49mJMblrNTeZ0+1evdmPWdzHGLXYKNns+VaGF14UisM
	 ZTNEGrEKmN4at4Z1ykn+igqox7oKHjm0gRsdEOPIkBS0OcbW4/YoNPdACC7h70z4Fz
	 ABa/bp7CnDc3fCxmgVb5RjMcdqDEokDmw4/OKyX39QQX195I96ke1Ngbv4YUVkNr5Q
	 ZJjOuvOgEP8xv3faebSjRbh8eJ2lWDLjq+2tl6Q9QFgiN0E8t7nneU979Pd+V1wM/K
	 jfv06ugHh4zWGaqY8Z/UuddEC6iMUUAj2ZBwWhVeI/0CBBgAyUB/XvPChGK+gWLm+A
	 oSwxMfLYxhD3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921081544.1797510-2-zong.li@sifive.com>
References: <20260921081544.1797510-1-zong.li@sifive.com>
 <20260921081544.1797510-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:26:51 +0000
Message-Id: <20260921082651.6F6EB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf/riscv-iommu: use-after-free on driver unbind due to devres LI=
FO order
- [Medium] perf/riscv-iommu: invalid write to read-only IPSR register
--

commit 2511b2dad68cf3d12e748952ca89116c8fc1ba49
Author: Zong Li <zong.li@sifive.com>
drivers/perf: riscv-iommu: add risc-v iommu pmu driver

Add a new driver to support the RISC-V IOMMU PMU. This driver introduces ev=
ent
and cycle counters for the PMU, using a raw spinlock to serialize accesses.
It registers as an auxiliary device of the RISC-V IOMMU.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c

[ ... ]

> +static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
> +{
> +	struct riscv_iommu_pmu *pmu =3D (struct riscv_iommu_pmu *)dev_id;

[ ... ]

> +	/* Clear performance monitoring interrupt pending bit */
> +	writel_relaxed(RISCV_IOMMU_IPSR_PMIP, pmu->reg + RISCV_IOMMU_REG_IPSR);

[Severity: Medium]
Will this write trigger a bus access fault on strict hardware implementatio=
ns?

According to the RISC-V IOMMU specification, the IPSR (Interrupt Pending=20
Status Register) is read-only and combinatorial. While some hardware might=
=20
silently drop writes to read-only registers, writing to it here in the IRQ=
=20
handler explicitly attempts to clear the performance-monitoring interrupt=20
pending (pmip) bit. This could lead to a crash or unexpected behavior on=20
strict hardware interconnects.

> +
> +	riscv_iommu_pmu_start_all(pmu, inhibit);
> +
> +	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> +
> +	return IRQ_HANDLED;
> +}

[ ... ]

> +static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
> +				 const struct auxiliary_device_id *id)
> +{

[ ... ]

> +	ret =3D cpuhp_state_add_instance(cpuhp_state, &iommu_pmu->node);
> +	if (ret) {
> +		dev_err(&auxdev->dev, "Failed to register hotplug %s: %d\n", name, ret=
);
> +		return ret;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(&auxdev->dev,
> +				       riscv_iommu_pmu_remove_cpuhp_instance,
> +				       iommu_pmu);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D perf_pmu_register(&iommu_pmu->pmu, name, -1);
> +	if (ret) {
> +		dev_err(&auxdev->dev, "Failed to register %s: %d\n", name, ret);
> +		return ret;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(&auxdev->dev,
> +				       riscv_iommu_pmu_do_unregister,
> +				       iommu_pmu);

[Severity: High]
Does this sequence create a use-after-free window during device unbind?

The devm cleanup actions operate in LIFO order. Because=20
riscv_iommu_pmu_do_unregister() is added after=20
riscv_iommu_pmu_remove_cpuhp_instance(), it will run first when the driver=
=20
unbinds, unregistering the PMU context.

During this window, the CPU hotplug callback remains active. If a CPU offli=
ne=20
event occurs before the hotplug instance is removed, the kernel will execut=
e=20
riscv_iommu_pmu_offline_cpu(), which dereferences the freed context:

perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target_cpu);

Could we reverse the registration order so the hotplug callback is safely=20
removed before the PMU is unregistered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921081544.1797=
510-1-zong.li@sifive.com?part=3D1
