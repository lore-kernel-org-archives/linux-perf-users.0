Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44836212566
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Apr 2026 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277899; cv=none; b=j9njUW1BftuJTOOiTBvpD/cleoXd+kJLHnKwrkawm+YBBuDUiH/FEbs3SdDn7U82sHRKJ6h9bm8na97cq3uZ4t6CC5nzGXW6q6knv2ql0+wd00B9YUlGfDcD6yIjXHbS7RIML+gJs8WlSKKuvSGbxjQlzkltF59UqxMWb9AQh54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277899; c=relaxed/simple;
	bh=eGsGktjT2G1Nh3cNmX82smd5+4wPPrtcTpiiSvGzozM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OD1BCwWiMfoLfW2sUywdLneV8ug5glnyAH+QuzWfTd1PafT5dNSToH03KXqxRzto/d17XUqcaHjeLPl9I7HCHb0ihttyf47arloOzXrkqua/gi2sMEPjS6CTcvlROKAlR3gL1IHaChHtWvcEFb+q3uxLXw2csMeYGc9jX2WLP6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsCf4+5H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsCf4+5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64C7C19424;
	Wed, 15 Apr 2026 18:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776277898;
	bh=eGsGktjT2G1Nh3cNmX82smd5+4wPPrtcTpiiSvGzozM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nsCf4+5HgNWFfWAFh7e8XPV7huMKDBM9LxyaCy0ypKRGWrABRsw3tpWYHX5CWm+5m
	 uOGJIsJnASxYN6X9KSaU2RVuZIPki48xlDKNPudP9o74vIubBSHcZra+vqiKxhX5F1
	 2L+B7WpVd7tJzWCPB9a3MkxcNnVb1OGNHPAJOLnaloPmQV62JDPLli5wnKmKgY6QLH
	 unxgFqmALZCItHK79mGu9rLgJawhzVRi3PuudeKQjEgVgRGiv6AbH7vHF/fh4eeSd8
	 PUqhDdXMYAGWRnPxYmTHZQ6MqtBgYN2B5XEwLvp7rit1C3jOJQZ83tOkYSy5ZHyKYa
	 BBZ/WLxfjxkTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] arm_pmu: acpi: fix reference leak on failed device
 registration
Reply-To: sashiko@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260415174159.3625777-1-lgs201920130244@gmail.com>
References: <20260415174159.3625777-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 18:31:38 +0000
Message-Id: <20260415183138.C64C7C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Calling platform_device_put() on statically allocated platform dev=
ices triggers a kernel WARN.
--

commit 3d6b3748275060c9fa53f46ef32bdbc93f8522c7
Author: Guangshuo Li <lgs201920130244@gmail.com>

arm_pmu: acpi: fix reference leak on failed device registration

This commit attempts to fix a reference leak when platform_device_register()
fails in arm_acpi_register_pmu_device() by calling platform_device_put()
on the failed path.

> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index e80f76d95e68b..5ce382661e344 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
[ ... ]
> @@ -119,8 +119,10 @@ arm_acpi_register_pmu_device(struct platform_device =
*pdev, u8 len,
> =20
>  	pdev->resource[0].start =3D irq;
>  	ret =3D platform_device_register(pdev);
> -	if (ret)
> +	if (ret) {
>  		acpi_unregister_gsi(gsi);
> +		platform_device_put(pdev);

Does this cause a kernel warning when called on statically allocated platfo=
rm
devices?

The arm_acpi_register_pmu_device() function is called with statically
allocated platform devices:

arm_spe_acpi_register_device()
    arm_acpi_register_pmu_device(&spe_dev, ...)

arm_trbe_acpi_register_device()
    arm_acpi_register_pmu_device(&trbe_dev, ...)

Because these devices are statically allocated and not created via
platform_device_alloc(), they do not have a .dev.release callback
configured.

When platform_device_put() drops the reference count to 0, the driver core's
device_release() function will see the missing release callback and trigger
a warning splat.

On systems with panic_on_warn enabled, could this turn a benign device
registration failure into a kernel panic?

> +	}
> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415174159.3625=
777-1-lgs201920130244@gmail.com?part=3D1
