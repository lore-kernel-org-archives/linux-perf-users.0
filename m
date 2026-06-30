Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D443368AA
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809728; cv=none; b=OAlYtzt7+uWa+RuwxgAxXle5aM1ghIzv22AmGuqn9+wy03CTKqF/Ug/EtGIr0liGkGemVynR+6Q/9NoWqYGf2EKNKMK4vF4b6xkQ/sd4i+eWhsr8U54SwA6PiRBRoFKq2U2LLzuedCfqftfLcTQXKzLah8t8qtzgr4/6JLTGiiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809728; c=relaxed/simple;
	bh=WRDxViXynqj0rzcw7oIEpP1jLQ9wc+pcm94OOHGnb9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Obfo92xL15Pw8FiIhkHatDih+9gqIw5C2haANCanADwBO2EBopZvrIHUf/u9I5m1B5fsIL0EudSXM+wiwtp4EMG4nSyKMaLGk63E5LEjdWj5Z56fGaSFh3R7+te/BQza1x7E5Bxa/Z0zSHrVkmCK0219FUziK+ol4UoeOCNhAbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwE4Ie70; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwE4Ie70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3127A1F000E9;
	Tue, 30 Jun 2026 08:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782809725;
	bh=T3SrMN4chYNddm+I8+W3r5h02T28vybvEvjexk51Fao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nwE4Ie70PTC4wav8JIusyl+Jl804446GVN4ODH/pv+OwgRCOl1kc2pP682OuYfLIh
	 dadIv2kWJ67oXLWw2MOAws4KXtPibH6ixnP5ThooYRmhfkrudiEHff9ONiqSfB6DhZ
	 nbCUvdibK+s/e/Nr5QWXeL1L5P4W4Fns9RzRWJjmvgQwAUOjV46NeRHIgFPToFubPL
	 Y+n6S3S7W3L5ECwrKCmiWAWUJ4K9a6vEFj6OlAsVLJTN77o6xE/Aytc09KNR8LrlwV
	 Uc70kCnAJFYhvQ5k0z6VLkDCLjPGlZEFs2lZWLYQ+mAlEmqMDvWBInRRGEpzMZgQmP
	 PJ9XRGdLC//Cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] iommu/riscv: create a auxiliary device for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260630083833.1275837-3-zong.li@sifive.com>
References: <20260630083833.1275837-1-zong.li@sifive.com>
 <20260630083833.1275837-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 08:55:24 +0000
Message-Id: <20260630085525.3127A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Sysfs name collision due to hardcoded auxiliary device ID.
- [Medium] Lifecycle mismatch between IOMMU teardown and PMU devres cleanup.
- [Low] Missing Kconfig dependency for CONFIG_AUXILIARY_BUS.
- [Low] Direct usage of internal double-underscored API `__devm_auxiliary_d=
evice_create`.

Pre-existing issues:
- [High] Use-After-Free in PMU driver upon manual unbind due to devres mism=
atch.
- [High] Resource leak of perf PMU and CPU hotplug nodes on driver unbind.
--

commit 872414a6347d3097cbc668062dca56187aba912d
Author: Zong Li <zong.li@sifive.com>

iommu/riscv: create a auxiliary device for HPM

Create an auxiliary device for HPM when the IOMMU supports a
hardware performance monitor.

> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index cec3ddd7ab103..36ad4aa814651 100644
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

[Severity: Low]
Does this code require a Kconfig dependency for CONFIG_AUXILIARY_BUS?

Building the kernel without the auxiliary bus subsystem enabled leads to
an unresolved symbol for __devm_auxiliary_device_create.

[Severity: Low]
Is there a reason to invoke the internal __devm_auxiliary_device_create()
function directly?

The driver passes KBUILD_MODNAME and 0 manually instead of using the
standard devm_auxiliary_device_create() macro wrapper.

> +						"pmu", iommu, 0);

[Severity: High]
Will this hardcoded device ID of 0 cause a sysfs name collision for
secondary IOMMUs?

Booting a system with multiple RISC-V IOMMU instances (e.g., multiple PCIe
root complexes) will cause the first instance to register
riscv_iommu.pmu.0. The second instance passes id=3D0 and attempts to regist=
er
the exact same name, causing device_add() to fail with -EEXIST.

[Severity: Medium]
Does registering the PMU auxiliary device via devres here create a lifecycle
mismatch during driver removal?

In riscv_iommu_remove(), the IOMMU hardware queues and capabilities are
manually disabled before the devres-managed PMU auxiliary device is
destroyed. This asymmetry leaves the PMU driver bound to disabled hardware
during the window between remove() and devres cleanup.

[Severity: High]
This isn't a bug introduced by this patch, but enabling the auxiliary device
surfaces a use-after-free regression in the PMU driver during unbind:

drivers/perf/riscv_iommu_pmu.c:riscv_iommu_pmu_request_irq() {
    ...
    return devm_request_irq(iommu->dev, irq, riscv_iommu_pmu_irq_handler,
            IRQF_ONESHOT | IRQF_SHARED, dev_name(iommu->dev), pmu);
}

If an administrator manually unbinds the PMU driver via sysfs, the auxiliary
device's devres runs and frees the struct riscv_iommu_pmu. However, the IRQ
is incorrectly requested against the parent iommu->dev, so it is not freed.
If a PMU interrupt fires subsequently, the handler will dereference the
freed state.

[Severity: High]
This is a pre-existing issue, but enabling the PMU auxiliary device also
exposes a resource leak in the auxiliary driver definition:

drivers/perf/riscv_iommu_pmu.c:
static struct auxiliary_driver iommu_pmu_driver =3D {
    .probe      =3D riscv_iommu_pmu_probe,
    .id_table   =3D riscv_iommu_pmu_id_table,
};

Does the omission of the .remove callback here leave perf PMU and CPU hotpl=
ug
nodes permanently registered?

Manually unbinding the driver fails to call perf_pmu_unregister() and
cpuhp_state_remove_instance_nocalls(), leading to subsequent crashes if
userspace interacts with the dangling objects.

> +	if (!auxdev)
> +		return -ENODEV;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630083833.1275=
837-1-zong.li@sifive.com?part=3D2
