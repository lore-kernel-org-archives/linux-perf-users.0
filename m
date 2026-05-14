Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF3C18AE2
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778729671; cv=none; b=KTHyzZSOBcD2uV4E1Grrl8VyDAr0rBRI/mY8dM6WiffKmJe4ZGAAU7Lu/BRSvANk2h8/k6awNVvTfEXN5GGLeLCWquftSbhz7+qOoWzexEabLgs7VPLwSyHJcSJc3mFM4YURv4apP5L6rKgXtAbQT5wfa40jfdS9c3hwdc8z490=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778729671; c=relaxed/simple;
	bh=sN6iO53t0NlD91ZdOjXRheHj0c+4/Cdt3+8gt4LgXLo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UN5ra7bpTDMy5PPwBdJfJGZG/v8ZiKvOHeT9Sv5FFEoYo7EARFx/h3feRusf3QN1nAz7AfF5Ld9FkQVST8tDv5Ak7RLb/RcMmCgqJhgQQfCRV8HDNasL3VXqvHpzOvVAhV0+l4XUTFbBMlAVfOVW9zI7N8ZUr2387BMJHBDqBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw05mJqc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw05mJqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4425C19425;
	Thu, 14 May 2026 03:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778729670;
	bh=sN6iO53t0NlD91ZdOjXRheHj0c+4/Cdt3+8gt4LgXLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nw05mJqcPeMZtFuCC4ChEBYZdrZh4+EAwF/YZosSoP8UqxqYBfia2jMfQS3Ukiq+I
	 epMBzgFfZ4o1QNLsw3BYQzLyIKhWl448Mn8oqVBwE/D0pWoiyr3ChUZ1T6hM9tRY98
	 PVb06+FXcYWuuPCuzTRc7bOFLcsIc/8EFNa79kVKVysYXVcDXhl1Dfa0EuxJgmuHv4
	 T8hEdyA2btxUnI2F8DnkbVkzf6F3oHYs5LbbBo7GQpGaKbpvYHLOdkjsK823Yl1WOl
	 9mx2HF5R3+uNfgqoDkbZLePnOvSBJ5PTjyjQWCKxiJ9+tyjxyay+0V3gZi2DjV1UBP
	 b3Sr6kbGXUgZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] perf/x86/intel/uncore: Factor out box setup code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512233048.9577-5-zide.chen@intel.com>
References: <20260512233048.9577-5-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 03:34:30 +0000
Message-Id: <20260514033430.B4425C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Fatal NULL pointer dereference in uncore_bus_notify() on removal o=
f unbound PCI devices.
--

commit 6a9ba5cde2aa109e895cd057ed9fdc789f5590c7
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Factor out box setup code

This commit factors the lazy registration management of the PCI uncore PMU
path into a shared helper function. This allows the same code to be reused
by the MSR and MMIO paths in future changes.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 65e9d0c64f8f9..617a68c1d76c3 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c

[ ... ]

> @@ -1154,19 +1177,13 @@ static int uncore_pci_pmu_register(struct pci_dev=
 *pdev,
>  	box->dieid =3D die;
>  	box->pci_dev =3D pdev;
>  	box->pmu =3D pmu;
> -	uncore_box_init(box);
> -
> -	pmu->boxes[die] =3D box;
> -	if (atomic_inc_return(&pmu->die_refcnt) > 1)
> -		return 0;
> =20
> -	/* First active box registers the pmu */
> -	ret =3D uncore_pmu_register(pmu);
> -	if (ret) {
> -		pmu->boxes[die] =3D NULL;
> -		uncore_box_exit(box);
> +	ret =3D uncore_box_setup(pmu, box);
> +	if (!ret)
> +		pmu->boxes[die] =3D box;
> +	else
>  		kfree(box);

This isn't a bug introduced by your patch, but can this cause a NULL pointer
dereference if the device is later removed?

If uncore_box_setup() fails, pmu->boxes[die] remains NULL while the device
remains on the PCI bus without a bound driver. If this device is later
removed, uncore_bus_notify() fires for BUS_NOTIFY_DEL_DEVICE:

uncore_bus_notify() {
	...
	if (action !=3D BUS_NOTIFY_DEL_DEVICE)
		return NOTIFY_DONE;

	pmu =3D uncore_pci_find_dev_pmu(pdev, ids);
	...
	uncore_pci_pmu_unregister(pmu, die);
}

This identifies the PMU via PCI IDs and unconditionally calls
uncore_pci_pmu_unregister(), without checking if the driver actually
bound to the device.

uncore_pci_pmu_unregister() {
	struct intel_uncore_box *box =3D pmu->boxes[die];
	...
	uncore_box_exit(box);
	kfree(box);
}

Since box is NULL here, will uncore_box_exit() dereference the NULL pointer
when it calls test_and_clear_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)?

> +
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512233048.9577=
-1-zide.chen@intel.com?part=3D4
