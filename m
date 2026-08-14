Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA330EF97
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715478; cv=none; b=oh/USqr1jB9yTtt0c/27v2+/83Xqu++NSqMS/GXVmo+QDMis1j9Z+24QZzEIIsAwY4RowG+UrdE51pP/o+gGOfEgVVJSmgBdKPfGurwYGI4n5kMikGFcuw2074wmuWd2L2wzze3O0b8CxW7vV5MGNGjDjZWCLq9JQ1/xLm2JWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715478; c=relaxed/simple;
	bh=MsWrRIcatRkULB3+XKo847rzyA/iHrSUE56/z+U9Fbc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NR3XcSRts54VvWqVSvSCIwB1aAHm2nIpUiD/UOmgc8w7vfLGKa/wgYpRPP9SFHZwmCdeetXw4QIgQngjsCfwopDMYhYmbBTCGTHWH5QsDZH9EsdKFRBOptl49uj+CbE0/4OkTmU+42twbVuzUtnlUXA5KsWAtmRldBbJ35ECncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX6gNzPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX6gNzPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216AB1F00A3A;
	Fri, 14 Aug 2026 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715473;
	bh=dymGqhZn33Nk00Z5Fej7/bAlRhLsi5AOlWoPFnFFYbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OX6gNzPn4H26zagTRigHJxsoJUgUVpM9J0tvNoYwJ24yjlc3P9h5tYOYdVt2QCT5e
	 Y+1ePKDHS35yhNwxi2gCDYrSiyQaw2PP45hY/G8w/96cTE/lcLKBUrmXEU50V6Jo9e
	 GaPkqSuTXUssK3R+9RTzyOGB86Gv4QxUw29eYiJu9QFixr8uxULrjL0fEYzCicUc5g
	 BIUTJhGCuETIw5YnaUrp8PVZzy9nJa9HWkRYXLUYmq0DrhBO59Y/7jOp4t7q+zTG73
	 4XV86J5c5aGZ1iBsiH1U8G/q+096ysoLiMk6yMTkdg1oK3DKR0N2wXtz++Dt9eStvH
	 sam5PtC15xO6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/dwc_pcie: Fix PCI device reference leak in probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260814133925.1385687-1-ruoyuw560@gmail.com>
References: <20260814133925.1385687-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 13:51:12 +0000
Message-Id: <20260814135113.216AB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The PMU driver stores a pointer to the PCI device (`pdev`) without=
 retaining a reference, exposing the system to a Use-After-Free (UAF) if th=
e PCI device is hot-removed.
- [High] Concurrent modification of the global dwc_pcie_dev_info_head list =
without locking.
--

--- Patch [1]: [PATCH] perf/dwc_pcie: Fix PCI device reference leak in prob=
e ---
commit 2589eb488a31451ac7fb41c9454a6b4efd3a7453
Author: Ruoyu Wang <ruoyuw560@gmail.com>

perf/dwc_pcie: Fix PCI device reference leak in probe

This commit addresses a PCI device reference leak when the subsequent RAS
DES capability lookup fails. It moves the pci_dev_put call immediately
after capability discovery to release the reference on both success and
failure paths.

> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 6b9ed59de26eb..976e09f0d81b7 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -763,10 +763,10 @@ static int dwc_pcie_pmu_probe(struct platform_devic=
e *plat_dev)
>  	}
> =20
>  	vsec =3D dwc_pcie_des_cap(pdev);
> +	pci_dev_put(pdev);

[Severity: High]
This is a pre-existing issue, but I have a question about how the PCI device
reference is managed here.

Since pci_dev_put(pdev) is called to drop the reference, is it safe to
subsequently store and dereference this pointer?

In drivers/perf/dwc_pcie_pmu.c:dwc_pcie_pmu_probe(), the pdev pointer is
stored in the PMU structure:

	pcie_pmu->pdev =3D pdev;

If the PCI device is hot-removed during the initialization window before the
bus notifier is registered in dwc_pcie_pmu_init(), the BUS_NOTIFY_DEL_DEVICE
event could be missed. This would mean the PMU platform device is never
unregistered, and the PCI subsystem would free the struct pci_dev.

Could this leave pcie_pmu->pdev pointing to freed memory, leading to a
use-after-free when subsequent PMU operations or CPU hotplug callbacks like
dwc_pcie_pmu_online_cpu() access it?

>  	if (!vsec)
>  		return -ENODEV;
> =20
> -	pci_dev_put(pdev);
>  	name =3D devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", =
sbdf);

[ ... ]

[Severity: High]
This is a pre-existing issue, but can the global linked list be corrupted
if multiple PCI devices are hot-plugged concurrently?

In drivers/perf/dwc_pcie_pmu.c, the global list dwc_pcie_dev_info_head is
modified without acquiring a lock:

dwc_pcie_register_dev() {
...
	list_add(&dev_info->dev_node, &dwc_pcie_dev_info_head);
...
}

dwc_pcie_unregister_dev() {
...
	list_del(&dev_info->dev_node);
...
}

These functions are invoked by the driver's PCI bus notifier
(dwc_pcie_pmu_nb) responding to BUS_NOTIFY_ADD_DEVICE and
BUS_NOTIFY_DEL_DEVICE events.

Since the driver core's bus notifier chain uses a read-write semaphore
which allows concurrent hotplug events across different devices to invoke
notifiers simultaneously, couldn't this trigger a data race on list_add
and list_del?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814133925.1385=
687-1-ruoyuw560@gmail.com?part=3D1
