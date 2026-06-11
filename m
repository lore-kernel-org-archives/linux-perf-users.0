Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903521F099C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195927; cv=none; b=PZp1eJszHZ8ztk8u78C2ysS34aGDx08CdoA7xl9FDmNOVBC3uribB44dfYA/bsKFg+mugLg1E0wvkqK0iqLjT9mDm/TJw1ND7ofXr2LaFryrVWpXY7LYyg9m0BhAXh0yBYZLXAECBOWdFP+yT0j/Dc36JFDZxL9tID3eaJfl2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195927; c=relaxed/simple;
	bh=Uec6s1ZIpKotny7Nn56++hwuzu3bMrHXnNllxKjc6iU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kEdocV767vVmwlW7BLAs69Pjn0ytKJ3wA1Q9NXPS6tcaYr6eXCM+5Jcp3YGnrRB4N+j6gfswJ2cx1wNDQQof8sPN5ftKGnlyPWP0MISuZR8vnKfWOECenSlUL//h5jCy6r/NuK0F92V9gs2AbDuV1TsXifvlymVogFs6QnXVVYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwZzSGrQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwZzSGrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCAF1F00893;
	Thu, 11 Jun 2026 16:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781195926;
	bh=dgrfq2jq0Nm3nVzNiTyhIEIZ6FWc7kb8SLgsgwvUcsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BwZzSGrQAkn4WFf/9YQAUaSOmZpUd7uY0JC2EjI6/Y/d2Ol4U8V6k/Wb+ocvr5pHa
	 HrZB+2jp6LgvqOcSNBHmvNog/IrQ0k+4yQtDzrgJYBkHoFI1/1dGlIqp+2PegVdDN3
	 cttO4yfE9zWGANRv/T7gQWwCTdnUp4fdczwfRQcw44aLsHpxD51JP4BKTm2XAbSxax
	 m8jV2Adze2sygGolYmDuS4UvC4VSBS+7h+AlCTghUIP3sVaMLUhpAPpS6buqujm5zE
	 ZqfyXuIQ8oblysCQSEZ8Rv2l/M2Opt083ZZWYmLR7UJtJUiX4wcTlzRi3YWADMzOw/
	 cORpWSOYW6PKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 3/8] perf/x86/intel/uncore: Let init_box() callback
 report failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611160033.66760-4-zide.chen@intel.com>
References: <20260611160033.66760-4-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 16:38:45 +0000
Message-Id: <20260611163846.1CCAF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The `adl_uncore_msr_ops` struct lacks an `init_box` callback, ca=
using `exit_box` to be skipped during teardown and leaving hardware PMU log=
ic enabled.
- [Low] PCI `init_box` callbacks return positive `PCIBIOS_*` error codes in=
stead of negative error codes as documented.

Pre-existing issues:
- [High] `ptl_uncore_sncu_init_box` performs a `writel()` gated by a check =
on `box->io_addr` rather than checking for initialization success, leading =
to Use-After-Unmap if reinitialization fails.
- [High] `uncore_mmio_exit_box()` calls `iounmap()` on `box->io_addr` but f=
ails to clear the pointer to NULL, leaving a dangling pointer.
--

commit eb92519036a2afbd738b5e91732e11fc662b60f7
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Let init_box() callback report failures

The init_box() callback currently returns void, so initialization
failures are silently ignored and the box is still marked initialized.
This patch changes the callback to return int so platform code can report
errors back to the common uncore layer.

> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncor=
e.h
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
[ ... ]
> @@ -557,12 +557,18 @@ static inline u64 uncore_read_counter(struct intel_=
uncore_box *box,
>  	return box->pmu->type->ops->read_counter(box, event);
>  }
> =20
> -static inline void uncore_box_init(struct intel_uncore_box *box)
> +static inline int uncore_box_init(struct intel_uncore_box *box)
>  {
> -	if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {
> -		if (box->pmu->type->ops->init_box)
> -			box->pmu->type->ops->init_box(box);
> +	int ret =3D 0;
> +
> +	if (!test_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags) &&
> +	    box->pmu->type->ops->init_box) {
> +		ret =3D box->pmu->type->ops->init_box(box);
> +		if (!ret)
> +			__set_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags);
>  	}

[Severity: Medium]
Will this cause exit_box() to be skipped for PMUs that lack an init_box()
callback?

For example, adl_uncore_msr_ops defines exit_box but lacks an init_box.

Because ops->init_box is NULL, the UNCORE_BOX_FLAG_INITIALIZED flag is
never set for Alder Lake MSR PMUs.

During teardown, uncore_box_exit() checks the initialized flag.

Since it is false, adl_uncore_msr_exit_box() is skipped, and the
ADL_UNC_PERF_GLOBAL_CTL MSR is never cleared.

Does this leave the hardware PMON logic improperly enabled?

> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/i=
ntel/uncore_discovery.c
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
[ ... ]
> @@ -578,15 +579,16 @@ static inline int intel_pci_uncore_box_ctl(struct i=
ntel_uncore_box *box)
>  	return UNCORE_DISCOVERY_PCI_BOX_CTRL(intel_generic_uncore_box_ctl(box));
>  }
> =20
> -void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
> +int intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
>  {
>  	int box_ctl =3D intel_pci_uncore_box_ctl(box);
> =20
>  	if (!box_ctl)
> -		return;
> +		return -ENODEV;
> =20
>  	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
> -	pci_write_config_dword(box->pci_dev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
> +	return pci_write_config_dword(box->pci_dev, box_ctl,
> +				      GENERIC_PMON_BOX_CTL_INT);
>  }

[Severity: Low]
Does this violate the contract mentioned in the commit message to "return 0
on success or a negative error code on failure"?

pci_write_config_dword() yields positive PCIBIOS_* error codes on failure.

Returning positive values directly mixes standard Linux error codes with PCI
BIOS error codes.

> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/u=
ncore_snb.c
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
[ ... ]
> @@ -1887,13 +1907,15 @@ static struct intel_uncore_type ptl_uncore_imc =
=3D {
>  	.mmio_map_size		=3D 0xf00,
>  };
> =20
> -static void ptl_uncore_sncu_init_box(struct intel_uncore_box *box)
> +static int ptl_uncore_sncu_init_box(struct intel_uncore_box *box)
>  {
> -	intel_generic_uncore_mmio_init_box(box);
> +	int ret =3D intel_generic_uncore_mmio_init_box(box);
> =20
>  	/* Clear the global freeze bit */
>  	if (box->io_addr)
>  		writel(0, box->io_addr + PTL_UNCORE_GLOBAL_CTL_OFFSET);
> +
> +	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but should this check if (!ret) instead of
if (box->io_addr)?

When a CPU goes offline, the MMIO region is unmapped by
uncore_mmio_exit_box(), but the pointer box->io_addr is not cleared to NULL.

If the CPU is later brought back online,
intel_generic_uncore_mmio_init_box() may fail early (e.g., returning
-ENODEV) without overwriting the stale box->io_addr pointer.

Because the stale pointer evaluates to true, the kernel would execute
writel(0, box->io_addr + PTL_UNCORE_GLOBAL_CTL_OFFSET) to an unmapped
address.

Could this trigger a page fault?

[Severity: High]
This isn't a bug introduced by this patch, but does uncore_mmio_exit_box()
leave a dangling pointer?

uncore_mmio_exit_box() calls iounmap() on box->io_addr but fails to clear
the pointer to NULL.

If the box is later reused and suffers an early initialization failure,
box->io_addr remains non-NULL.

Core handlers (such as uncore_mmio_read_counter) validate readiness by
checking if (!box->io_addr).

Since the pointer is not cleared, these checks can bypass validation and
permit perf events to trigger memory accesses.

Could this lead to a use-after-unmap memory access?

> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
[ ... ]
> @@ -627,12 +627,12 @@ static u64 snbep_uncore_pci_read_counter(struct int=
el_uncore_box *box, struct pe
>  	return count;
>  }
> =20
> -static void snbep_uncore_pci_init_box(struct intel_uncore_box *box)
> +static int snbep_uncore_pci_init_box(struct intel_uncore_box *box)
>  {
>  	struct pci_dev *pdev =3D box->pci_dev;
>  	int box_ctl =3D uncore_pci_box_ctl(box);
> =20
> -	pci_write_config_dword(pdev, box_ctl, SNBEP_PMON_BOX_CTL_INT);
> +	return pci_write_config_dword(pdev, box_ctl, SNBEP_PMON_BOX_CTL_INT);
>  }

[Severity: Low]
Similar to intel_generic_uncore_pci_init_box(), does this also violate the
negative error code API contract by returning positive PCIBIOS error codes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611160033.6676=
0-1-zide.chen@intel.com?part=3D3
