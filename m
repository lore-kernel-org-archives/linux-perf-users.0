Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B13ED12D
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469091; cv=none; b=d/wCMN5vm08QjI81GNbCbGocgXBJ5Z52YhzKmWGlaOvylXQE0tQHz/1i3MAhjT1lfGro11tYbQ9qnXd4D+RIwkPpTynckmzOSp9g/oK+VyiSK2zREqQcp1ULBT2GhRZjZkmMRJgOAuKc96xJk3f6vtH+g/InQpzZDxh7HKkKdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469091; c=relaxed/simple;
	bh=FxDz30n0QguB3ttYJ5ueNZJIba7/0ZM/ZVg0PFm9PNQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GL31y3UpJj9x4uNKAiNmfmesr6CX43ki648129K6m5IgFvCqq1smNJkfRj0ruI6WowVGtRQbDcu4Dbjw5SaSKr+cTqCEZJCgNg/tavxiabSEj2ZMKNrkPKvF2Tz5bj+sd9ySbXTWEE/6owlc20Uae/EjMyJSicpw/bJyM+BRpv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB1PkaJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB1PkaJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B181F00A3A;
	Fri, 26 Jun 2026 10:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782469087;
	bh=P/w8oNcjeONHjzZUE98GFKB0hvKEglbHQw+Gk/LH8es=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jB1PkaJ/uar+0HbZLivmHZtxaW+Od9im3Y+7rTrAGZe8aC+eLfQA0CLhDRcUZBGT7
	 qOlESzmcDIzxQnuLwv2DWZiKxveb4TUi72s3iem1iCVFNmzh/6stfKHbTcoHiki40w
	 ArQjD3ofAIiFWw1ROYvYUWj1l3Pv+/cj94luXAjHJtbG1o5SSGrVL7IdQS8jrsdlmE
	 QxGO5wU6XztmE+v/YfMdYTYbrjZ5tkXuoKrF/33P7h7u96ffao9s17EN7SV1pdSQjp
	 09pYKXt7oXJ5ir430YgwXjazPuGa35rQLHRsqrNoFvqPxOKzAZnMFPTR0Q+Hz+5WJA
	 QVkufnKz11/BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: x86/events/intel/uncore: discover_upi_topology:
 inner loop leaks PCI   device references from pci_get_domain_bus_and_slot
Reply-To: sashiko-reviews@lists.linux.dev
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260626100031.31494-1-vulab@iscas.ac.cn>
References: <20260626100031.31494-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 10:18:06 +0000
Message-Id: <20260626101807.28B181F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes a PCI device reference leak in `discover_upi_topol=
ogy()`, but misses an identical leak in `skx_upi_topology_cb()` within the =
same file.
- [High] `uncore_pci_pmus_register()` leaks PCI device references acquired =
via `pci_get_domain_bus_and_slot()`.
- [High] Uninitialized variable `ret` is returned from `skx_upi_topology_cb=
()` if no PCI devices are found.
--

commit 353e07e70f653f5204fbf8fbdb47ac7e0d92375b
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: x86/events/intel/uncore: discover_upi_topology: inner loop leaks PCI d=
evice references from pci_get_domain_bus_and_slot
   =20
In the inner for loop, dev is repeatedly overwritten by
pci_get_domain_bus_and_slot() without first releasing the previous dev
via pci_dev_put(). The err label only releases the last ubox and dev
references, while the references from earlier loop iterations are
permanently leaked. Fix by adding pci_dev_put(dev) before the overwriting
assignment.

> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c
> index e1f370b8d065f..9eacc0b3d1212 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -5600,6 +5600,7 @@ static int discover_upi_topology(struct intel_uncor=
e_type *type, int ubox_did, i
>  		for (idx =3D 0; idx < type->num_boxes; idx++) {
>  			upi =3D &type->topology[lgc_pkg][idx];
>  			devfn =3D PCI_DEVFN(dev_link0 + idx, ICX_UPI_REGS_ADDR_FUNCTION);
> +			pci_dev_put(dev);
>  			dev =3D pci_get_domain_bus_and_slot(pci_domain_nr(ubox->bus),
>  							  ubox->bus->number,
>  							  devfn);

[Severity: High]
This is a pre-existing issue, but while you are fixing this leak here, I
noticed an identical leak in skx_upi_topology_cb() in the same file.

In arch/x86/events/intel/uncore_snbep.c:skx_upi_topology_cb():

	for (idx =3D 0; idx < type->num_boxes; idx++) {
		upi =3D &type->topology[die][idx];
		devfn =3D PCI_DEVFN(SKX_UPI_REGS_ADDR_DEVICE_LINK0 + idx,
				  SKX_UPI_REGS_ADDR_FUNCTION);
		dev =3D pci_get_domain_bus_and_slot(segment, bus, devfn);

If type->num_boxes > 1, dev is repeatedly overwritten without calling
pci_dev_put(dev) on the previous reference. Should skx_upi_topology_cb() be
updated to include the same fix?


[Severity: High]
This is another pre-existing issue, but looking closely at
skx_upi_topology_cb() in arch/x86/events/intel/uncore_snbep.c, the ret
variable is declared without initialization:

	int idx, ret;
	struct intel_uncore_topology *upi;
	unsigned int devfn;
	struct pci_dev *dev =3D NULL;
...
	for (idx =3D 0; idx < type->num_boxes; idx++) {
...
		dev =3D pci_get_domain_bus_and_slot(segment, bus, devfn);
		if (dev) {
			ret =3D upi_fill_topology(dev, upi, idx);
			if (ret)
				break;
		}
	}

	pci_dev_put(dev);
	return ret;

If pci_get_domain_bus_and_slot() returns NULL for all iterations, the loop
completes without executing the if (dev) block, and the function returns the
uninitialized ret. Could this result in returning stack garbage and treating
a failed discovery as successful?


[Severity: High]
This is also a pre-existing issue, but I noticed a broader leak involving
pci_get_domain_bus_and_slot() during uncore PMU registration.

In arch/x86/events/intel/uncore.c:uncore_pci_pmus_register():

			pdev =3D pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(unit->a=
ddr),
							   UNCORE_DISCOVERY_PCI_BUS(unit->addr),
							   UNCORE_DISCOVERY_PCI_DEVFN(unit->addr));

			if (!pdev)
				continue;
			pmu =3D &type->pmus[unit->pmu_idx];
			uncore_pci_pmu_register(pdev, type, pmu, unit->die);

It seems the reference-counted pdev acquired here is stored but never relea=
sed
during module teardown (such as in uncore_free_boxes() and
uncore_pci_pmu_unregister()), which would leak the PCI device reference on
module unload. Does this teardown path need to call pci_dev_put(box->pci_de=
v)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626100031.3149=
4-1-vulab@iscas.ac.cn?part=3D1
