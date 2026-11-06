Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989430;
	b=ypeO2HoETWmwX0VmG6ID2FSijKHUaUCR692s6aKaJzWKhq+cEhz3yeu/wyR+Y4cBEVij
	 TzjcKFBrcrfL5MoIYlZsUBfHHpKxaApwhv4n5ooPHokLUUhAj8Z7C+6ys2UL5JYSzXfZX
	 vPoYMEbs3RFVUw1MFDz9m3E0EQxO1KsKThQRyaiE8ZjFklpYSFivoJVLqYGFj5PsBDEgF
	 3/iT93CKyLhiMIFaXNWN/27xxpvrs86ONfNJlJA5In2zqTSLGH0fvRWHVUtc5UZ+OuJZl
	 GbgQGfulaLhMCZ15Iud94qIIugPgcShxFMBGZ2sfsaaeZoonMGaYiGU2jQppOCMmYVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989430;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EevbR18taSbmnGLs3y5y6EscFlRAudvoUrgAbP6XhbI=;
	b=L2mro6NDJfO9Tx7nMBAxxHxmk+jwWxLHQn1TGWgocDLOy5XOmL2/vhec4WUv81tdf+up
	 FjUMb5nPzLTCEO/3IBLXlmQccr6kozZ2vkLxLAN6AkwmGihMan/JglxdEiqHDxDBqeGzX
	 kIIIZCjo3ynaz+FJswgVeLPEb2mskw8Rubq+djnlOP//BWg2mb+vjiZVd8+UWM7niGUlf
	 /RiSEJPKzgKadY46eyVavOlIzKKIOmxY282h76PVRXrPGXYWO2mCZsUvAybhs13gVrfoI
	 wnkRpdt/LcFzL/stp91/Ime4MOPyHGzu9bjQFE31GMZKbQBVL+PnM0HoJ+eg4kzHtnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJ7jXaLz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D18606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJ7jXaLz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAE41F008A1;
	Fri,  6 Nov 2026 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989430;
	bh=EevbR18taSbmnGLs3y5y6EscFlRAudvoUrgAbP6XhbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JJ7jXaLzf7okAZzrCuJE/UFJS8nHOo7KXGGEwjUFcB0125i+DDci0sTzScJEZBMvm
	 orG/8tx4Ql6O7/VYa04d/HUKRHy+YxMKghuZ+SUZPYOs3tNNGpTpS6NDaj4mOuE1KX
	 /fojIBzsRkR07eYfuTFKg+FvUYYWCnG5B1dPz8JbLe8elP3R6HDq6Jsm39Hleica/g
	 lP2sIWRhe3bwmnO6b00Du9DbXJchdsfkpp8HTHyLLJhoUhtuFTzdOudmhfpHaX+2rq
	 JXCGZBQfTHiY9TEgLjFNI5DqJMlj5zZRh11X/k+CJfX2SjpxE1A2NrB8XfWoO0qcBg
	 Hw/yZ2MLeImyA==
Message-ID: <sashiko-outbox-202020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] perf: Add Arm Bus Monitor Unit driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <7bf3b15677548c7e0c88aa03fa18a2b5673ab363.1793986672.git.robin.murphy@arm.com>
References: <cover.1793986672.git.robin.murphy@arm.com>
 <7bf3b15677548c7e0c88aa03fa18a2b5673ab363.1793986672.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:23:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf: arm-bmu: driver omitted when
  ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU is n or m
--

commit 0be62f2184bd603abec9ec13cdc4790db8588fea
Author: Robin Murphy <robin.murphy@arm.com>

perf: Add Arm Bus Monitor Unit driver

This commit adds a perf driver for Arm's Bus Monitor Unit in
drivers/perf/arm_cspmu/ to support transaction matching and counting across
interface monitoring units.

> diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kcon=
fig
> index 25bd55f036a4f..48c2a3ac7fab5 100644
> --- a/drivers/perf/arm_cspmu/Kconfig
> +++ b/drivers/perf/arm_cspmu/Kconfig
> @@ -34,3 +34,9 @@ config ARM_SYSTEM_PMU
>  	help
>  	  Support additional event filtering attributes for the CoreSight-based
>  	  PMU blocks found in various parts of Arm Compute Subsystems and SoCs.
> +
> +config ARM_BMU
> +	tristate "ARM Bus Monitor Unit"
> +	depends on (ARM64 && ACPI) || COMPILE_TEST
> +	help
> +	  Support perf event counting on Arm Bus Monitor Unit devices.
> diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Mak=
efile
> index 90c3cd7101577..4e0b420a2b55f 100644
> --- a/drivers/perf/arm_cspmu/Makefile
> +++ b/drivers/perf/arm_cspmu/Makefile
> @@ -9,3 +9,5 @@ arm_cspmu_module-y :=3D arm_cspmu.o
>  obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) +=3D nvidia_cspmu.o
>  obj-$(CONFIG_AMPERE_CORESIGHT_PMU_ARCH_SYSTEM_PMU) +=3D ampere_cspmu.o
>  obj-$(CONFIG_ARM_SYSTEM_PMU) +=3D arm_syspmu.o
> +
> +obj-$(CONFIG_ARM_BMU) +=3D arm-bmu.o

[Severity: Medium]
Will arm-bmu.o be skipped during the build when
CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU is disabled or modular?

Unlike the other drivers in this directory, CONFIG_ARM_BMU does not depend =
on
CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU, but drivers/perf/Makefile only
descends into arm_cspmu/ via:

drivers/perf/Makefile:
	obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) +=3D arm_cspmu/

When CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=3Dn, Kbuild never enters
drivers/perf/arm_cspmu/ and arm-bmu.o is not built at all; when
CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=3Dm and CONFIG_ARM_BMU=3Dy, arm_cs=
pmu/
is only visited for modules and the built-in arm-bmu driver is omitted from
vmlinux.

drivers/perf/Makefile should also add arm_cspmu/ for CONFIG_ARM_BMU (or use
obj-y +=3D arm_cspmu/).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793986672.gi=
t.robin.murphy@arm.com?part=3D2
