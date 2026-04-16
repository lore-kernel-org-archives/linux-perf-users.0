Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350801DA60D
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776320173; cv=none; b=VPY0KJ/8YJSONeaf2ZC+SmK6ExG/P1jeC0eXesTlKuJbraH5o1vizGhdYgxj4GZ68H1y+E4gmc4uirAecyHrWZ5Qc/Iem/6Xu+FJHmPzjBV5DPI0E7itPEr29OK4lep7rs8PuA0qVEGDphTSPK2yQDQ2qGxuF48zqEjxh5D1osY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776320173; c=relaxed/simple;
	bh=QG726S2UJCuBuVXGvcVWhqTE39Nuffe2Ix2Ttnu0CNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qY8CeqzVTm2tAzwl9BbgnYw4daVa+QeuwqnjRRlBwLiPShq8pi0nb3p2w9k8gRSbtQIZhBBCh6JSuysTODgcNtwPCZ78YNbL+TREOfCnwljNApX3CSS2eK7B/ueSMe8Y1/oIh8xXxfYUpmKnFIiBXStdh/wCpBoHOiinefS+ouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkaOst91; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkaOst91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B03C2BCAF;
	Thu, 16 Apr 2026 06:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776320172;
	bh=QG726S2UJCuBuVXGvcVWhqTE39Nuffe2Ix2Ttnu0CNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hkaOst917xjakUCpeO8vNLQUQGivKgVwFIjJ/YwPh0OUWpjGmQaje/G2HkXNi74FY
	 42HHFxkvLnJ+rQiJ+4nSfBkvlJ2Q8C7MRFQWMIiCceuYgoGXv+ylGclVDw0hh1b9Si
	 EGjzxr2BbxxfGkwOQWSjodToKsBe2AK41k9kSj4OCpYlJu0v36lCGJX/+6eBe7soyy
	 dyhpVYi/mokXRq8Wn1RGP4oIQgC9zOoljcWI9icqcYy6sDX6TDR5sWmfDHqGLvg3Z6
	 7oNRHwS0sa7eoezHY0jADk8ce1kjSLBWnUsk5IM94LEoxTuN9DEd9uSE2FRn4H29Ln
	 2fX8Qczbs26DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/intel/uncore: Re-register PMU on PCI device
 hot-add
Reply-To: sashiko@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260416054549.45585-1-kanie@linux.alibaba.com>
References: <20260416054549.45585-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 06:16:12 +0000
Message-Id: <20260416061612.A7B03C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] The patch does not fully resolve the NULL pointer dereference =
because it ignores registration failures during hot-add, leaving the unregi=
ster function vulnerable.
- [Critical] Pre-existing Use-After-Free and state corruption when removing=
 unregistered alias PCI devices.
- [Critical] Pre-existing Use-After-Free due to uncore box being freed whil=
e hrtimer and performance events are active.
--

commit d861b5908dfa0b5575cf18dc6c31bb0673e86c3a
Author: Guixin Liu <kanie@linux.alibaba.com>

perf/x86/intel/uncore: Re-register PMU on PCI device hot-add

This commit extends the uncore PCI bus notifier to handle
BUS_NOTIFY_ADD_DEVICE events. When a previously-registered uncore PCI device
is re-added, it calls uncore_pci_pmu_register to recreate the box and
restore the PMU state.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index e228e564b15ea..4a8fec0590465 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c

[ ... ]

> @@ -1284,7 +1283,16 @@ static int uncore_bus_notify(struct notifier_block=
 *nb,
>  	if (uncore_pci_get_dev_die_info(pdev, &die))
>  		return NOTIFY_DONE;
> =20
> -	uncore_pci_pmu_unregister(pmu, die);
> +	switch (action) {
> +	case BUS_NOTIFY_DEL_DEVICE:
> +		uncore_pci_pmu_unregister(pmu, die);

Are there pre-existing issues with uncore_pci_pmu_unregister during
device removal?

If a duplicate or alias PCI device mapping to the same PMU and die is
hotplugged, uncore_pci_pmu_register safely rejects it. However, if that
rejected device is later removed, could uncore_pci_pmu_unregister wrongfully
free the legitimate box belonging to the original active device, since it d=
oes
not verify device ownership?

Also, could calling uncore_pci_pmu_unregister here cause a use-after-free
if the uncore box is freed while the hrtimer and performance events are
still active?

> +		break;
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		uncore_pci_pmu_register(pdev, pmu->type, pmu, die);

What happens if uncore_pci_pmu_register fails during a hot-add event, such
as when uncore_alloc_box returns -ENOMEM?

The notifier currently ignores the return value, which would leave the box
uninitialized. If the device is subsequently removed, BUS_NOTIFY_DEL_DEVICE
would unconditionally call uncore_pci_pmu_unregister.

Could this lead to a NULL pointer dereference when uncore_pci_pmu_unregister
retrieves the missing box and passes it to uncore_box_exit? Would adding a
check for a missing box in uncore_pci_pmu_unregister help prevent this?

> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> =20
>  	return NOTIFY_OK;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416054549.4558=
5-1-kanie@linux.alibaba.com?part=3D1
