Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279703254A9
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789358945; cv=none; b=rccnia3Ftb/vi1Ucm8b1Q79JjoI3k7PkOlvBFZlvsZj6sCnhQ3f4RPS2HXpZljBb+1XMna2vJtNiOiD+Q3vtQkkiVdF7ahVRJzn3Is6cjdi5O64VJ5aX3dd/FZi0pmto+hiDlGjDV8lqE02wzyG0c7Z8Ry5BbdBZQkeyO1T1vPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789358945; c=relaxed/simple;
	bh=/ZUImpz0I57/zSR6iZWbGTI2EzbEFw3a8rTxeePfx/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qUu1Pho90mgsOTOUqudyNUnFQNb4FW2vP//lSLel0LTzx40sOC4CwEKok1FnNcGxwsSF7Mxg962zXLZyScr4gcNPCKELfPRjEmc6i1A/SXvaMdNCEsS4x0u5PP6iD5m9IB649+ZXMUCq8sB/yMnsLHvw98UCmaPrFuOPtAMfVkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvRTjyrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvRTjyrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1CB1F000FF;
	Mon, 14 Sep 2026 04:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789358943;
	bh=4pluU1SUKiwHX7BSHb8mV3BYukQgQ//VDbUQpV27lTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZvRTjyrwyF+ZeRcyHj1WwNhlPe54e2OrQ2kRertAG4u+hWNVlQWcfof0a8qm7NtBd
	 96aSfM7k0VG+vuQEKEq1jnUMJ/HM5ulLYQXUjGUvd0RPiQ/LWEsZaGPCyGT3drQVki
	 LjyV00EQXQ7umVnhOnAXONkyulpQWqNcowbOi8hHlZt3FzVAktI3PSpqurGr0FETOA
	 YpesvzJFl1gmibvxdmjkwumcwbrXsCJxhVlflKqe1iBXldcI10TNQl7fWkZ8WJ/Ba4
	 QpbzVTNy7Sqg+8WJBKXDlVNxwMpnmreHXP4hjvA+y2OSduKT8D11xjDbpOQw9zMeXy
	 43QngtWy9wCRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/2] iommu/riscv: create a auxiliary device for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914035723.2922057-3-zong.li@sifive.com>
References: <20260914035723.2922057-1-zong.li@sifive.com>
 <20260914035723.2922057-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 04:09:02 +0000
Message-Id: <20260914040902.BE1CB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The PMU auxiliary device is destroyed during the devres phase, aft=
er the IOMMU hardware and IRQs have already been torn down in the parent dr=
iver's remove callback.

Pre-existing issues:
- [High] Missing release barrier when locklessly updating the IOMMU Device =
Directory Table.
--

commit 93eb137b97dbeb7d61f4f9e3cac367ef538ba9b7
Author: Zong Li <zong.li@sifive.com>

iommu/riscv: create a auxiliary device for HPM

This commit creates an auxiliary device for the hardware performance
monitor (HPM) when supported by the RISC-V IOMMU.

> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c

[ ... ]

> @@ -587,6 +591,36 @@ static irqreturn_t riscv_iommu_fltq_process(int irq,=
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
Will this devm-managed auxiliary device be destroyed too late during teardo=
wn?

When the driver is unbound (for example, via sysfs), the parent driver's
remove callback in riscv_iommu_platform_remove() is called. This manually
disables the IOMMU and calls platform_device_msi_free_irqs_all() to tear
down MSIs.

Because __devm_auxiliary_device_create() manages the auxiliary device via
devres on the parent device, its destruction and the PMU driver's unbind
happen after the parent remove callback returns.

Could this cause the PMU driver's unbind process to access torn-down MSI
descriptors or disabled hardware when it tries to free its IRQ handler or
stop the PMU?

> +	if (!auxdev)
> +		return -ENODEV;
> +
> +	return 0;
> +}

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a missing
release barrier when locklessly updating the IOMMU Device Directory Table.

Looking at riscv_iommu_get_dc(), a new page is allocated and published
using cmpxchg_relaxed():

        ptr =3D riscv_iommu_get_pages(iommu, SZ_4K);
        if (!ptr)
                return NULL;

        new =3D phys_to_ppn(__pa(ptr)) | RISCV_IOMMU_DDTE_V;
        old =3D cmpxchg_relaxed((unsigned long *)ddtp, ddt, new);

Since cmpxchg_relaxed() lacks release semantics, could the CPU reorder
the page zeroing stores to happen after the pointer is published?

If the IOMMU hardware or another CPU traverses the table concurrently,
is there a risk it might follow the valid pointer and read uninitialized
memory, interpreting it as valid context entries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914035723.2922=
057-1-zong.li@sifive.com?part=3D2
