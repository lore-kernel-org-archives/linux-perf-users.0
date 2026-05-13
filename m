Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E49937BE63
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636960; cv=none; b=kBSgygerc5s3P9WRJce3NeVFlYz8rq9bZhe6leqNsOT7oEpuT/CsOKn276vWHT63qIxCSFr7B6/LDyldP6YUpGPz7xMy563Yw0QCE5iZyA+uZ+3i90/A/SpXWh1YK9HJCG2JqtOAyZL+62PHqKoS9S8RPVvMX8mY0qODSgBm5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636960; c=relaxed/simple;
	bh=7+hgPTHxHmKAnn3m6DjfzYYhTBVDhPA92VxKR2rDaOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MBBIF0yX1CYod0k6wmY2DK5zXm+Dl96XjomJOmw1izz0UZEYRCBQm2wLZt5uAmK+AWUOb2ZtpjWsc9oFGnTcbdjkXZW1QUUmUEAZMFUI9XFXRYslhawCBd8yAZp5tVkwzUGeCylVfs6Ggl1Qx0+G3sUYQ0ZPqkaVO067SQRaoEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrM2WZ/0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrM2WZ/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D66C2BCB0;
	Wed, 13 May 2026 01:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778636959;
	bh=7+hgPTHxHmKAnn3m6DjfzYYhTBVDhPA92VxKR2rDaOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SrM2WZ/07QIc7rKD/4vR/0Qatfs+zyJXsZq07ZBfaySUWSiR+iQrrKM/qvvlFmMkW
	 TWft3zUfckLLH/OkzGjClNIImVPfXbQmdGkKSHd18V8sd8P4e2FD+W6r+bY8yYZZl4
	 vkA51I40nDPcW+moBis2E9Pz2Z71vFnIVJkge/JBKgNSbvEFR4vR37GqX852+XBvOd
	 p6liV1nYeuIp8ZNVpuDPcLWDXPuofijehdgv8gdCIpM6oQZ02XRkjyXNXHV9Hy6xa7
	 df8B5tqJ/pouZkEg30wA6/AE1M1zPcBbe6Aqf4znZvOEAowiaBmgYr7ivIr3yq3Ooh
	 x5VRyJBl1i52Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] perf/x86/intel/uncore: Fix discovery unit lookup
 for multi-die systems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260511230527.26096-2-zide.chen@intel.com>
References: <20260511230527.26096-2-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 01:49:18 +0000
Message-Id: <20260513014918.E1D66C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unchecked return value causes a write to MSR 0x0 when a PMON disco=
very unit is not found for the current die, leading to a #GP fault and kern=
el panic.
--

commit 618972be846a765ebeeda359a995bf217a4d825c
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems

This commit updates intel_generic_uncore_box_ctl() to look up discovery
units using box->dieid instead of hardcoding -1. This ensures the
correct node is selected on multi-die systems.

> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/i=
ntel/uncore_discovery.c
> index 583cbd06b9b88..1d22d7c00ee06 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -481,7 +481,7 @@ static u64 intel_generic_uncore_box_ctl(struct intel_=
uncore_box *box)
>  	struct intel_uncore_discovery_unit *unit;
> =20
>  	unit =3D intel_uncore_find_discovery_unit(box->pmu->type->boxes,
> -						-1, box->pmu->pmu_idx);
> +						box->dieid, box->pmu->pmu_idx);
>  	if (WARN_ON_ONCE(!unit))
>  		return 0;

Could returning 0 here cause a regression during CPU hotplug if a die is
brought online later?

If a CPU die is offline during boot, uncore_discovery_msr() skips it,
meaning no PMON units are added to the discovery RB-tree for that dieid.

When the die is later brought online, uncore_event_cpu_online()
allocates boxes based on the globally maximum number of discovered units
and calls uncore_box_init().

The initialization function unconditionally calls
intel_generic_uncore_msr_init_box(), which writes to the returned address
without checking if it is 0:

arch/x86/events/intel/uncore_discovery.c:intel_generic_uncore_msr_init_box(=
) {
	wrmsrq(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
}

Because the lookup now strictly matches box->dieid instead of safely
falling back with -1 to an identical unit on another die,
intel_uncore_find_discovery_unit() will return NULL for this die.

This results in intel_generic_uncore_box_ctl() returning 0. Calling
wrmsrq(0, ...) writes directly to MSR 0x0 (IA32_P5_MC_ADDR), which will
trigger a #GP fault and crash the system.

Similar unvalidated accesses also occur in PCI configuration space
via intel_generic_uncore_pci_init_box():

arch/x86/events/intel/uncore_discovery.c:intel_generic_uncore_pci_init_box(=
) {
	struct pci_dev *pdev =3D box->pci_dev;
	int box_ctl =3D intel_pci_uncore_box_ctl(box);

	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
}

Should the callers be updated to check the return value of
intel_generic_uncore_box_ctl() before attempting hardware accesses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511230527.2609=
6-1-zide.chen@intel.com?part=3D1
