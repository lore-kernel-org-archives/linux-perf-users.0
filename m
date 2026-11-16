Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854698;
	b=3YOswO57kN/63cB1Wzhlel8KQvYoGI8p7BY0WVHOwpxR40+t+Mo3eHIxE0nmxfn4gsrf
	 DYS4zuD5oOZZWaxvNYwppubVCLOmjdaZahwPuWTYFwNhIhyhQZGgOOXaBqXal52nFFJjk
	 ULcRqWTrC4CNSDPUuSuuqks2s89LTwr4yERsFsRXbvNjQlGcZAZ3hJkkzDJT5x0aCZT3N
	 ZoQb137WGq7e7wMPToZKhbs+IKKSwVrQQ85SOmw7YwMKfF5KTcBEBqR32D6wJEK1ADa1N
	 gmg1jz/DjHokMced91rhKEf8yq+nqV0XPXngoiiNaI84IvCg+O6SkQ++ifdW9llw5bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854698;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m2TJ8F8hlsy16bmoYIK0LSSfl90uoQQ5umjbslB0sOI=;
	b=nK0Xnl2jirSwi4x1wHtxN9IL+on+VMtdRWLwstAMqJXgvHscSjf4FxH0quDrZvGhOjrj
	 VfROQzuQEzUfBgO18sSNhuqVLDdo8e6VR8Vx0jsdlDUr24PZau++kv1PcyPmVmt9040ub
	 hF6xmXnOyzVkc8H1t8yHV+7r+UKzA8vMp1FPlS0DHOh7nAVQu0nwUBpyMdWtndyIOkIM2
	 GlytRHTl75f/MiEP9o7EWIjNiOPxYJ1DLtYb3Y+7Ab5NjdiZOZmR2j/R+TEX1SSfvJI7v
	 8DWmPnCrgI97Di/W7xX0nBGvm4+U9AuRrM02tSctxLur2vDJFObsvNmwwoxBJHfec/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yz1a0ap1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC0606A323
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yz1a0ap1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711431F000C4;
	Mon, 16 Nov 2026 18:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794854697;
	bh=m2TJ8F8hlsy16bmoYIK0LSSfl90uoQQ5umjbslB0sOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yz1a0ap18A64bGLRVwFW2zCPjYNYRXLH15fqGmCnfW68JN0vw7Tty/4sF0zKwN01k
	 XO7Q1ukafYCLD4AxOB2eN9RvoY43Oda1HVkMakfiGnWEr/oHCYgLLIV40IB2R14ifW
	 P3n52IYcuVncOuaZj5KybRpIFqToz24+4nHA3XKJo+03Hf55j42Waeo9V6d4DHv7Oh
	 djcm9GtjZEAXivNVukJ5o0V59Ul1qxSMEwq9TefmVaURa28Aw2hx6XhoNdjMV1oekq
	 L5LVOvttqSYkzUsDNw2NYPVK3l+OmHOsqSGdYn8h+JyiW4LIzxSED/dQ0wE4ddiWc7
	 SnZrCo74spPRA==
Message-ID: <sashiko-outbox-217508@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] perf/arm_pmu: Register ACPI CPU PMUs as platform
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116-acpi_arm_pmu_registration_hmp-v1-5-0371d4eca626@arm.com>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
 <20261116-acpi_arm_pmu_registration_hmp-v1-5-0371d4eca626@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 18:44:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Register CPU PMU platform devices through arm_acpi_register_pmu_devices(),
> reusing the common MIDR grouping, software-node IRQ affinity and IRQ
> resource handling.
>=20
> Name the ACPI platform devices and the PMUv3 driver "arm,armv8-pmuv3".
> This lets the following platform-probe change match the device name
> against the OF table and select armv8_pmuv3_pmu_init(), preserving the
> initializer previously passed directly to arm_pmu_acpi_probe().
>=20
> Keep the platform-device name outside the ARM_PMU guard so common ACPI
> enumeration can use it without the CPU PMU framework.
>=20
> Remove the legacy ACPI probe, pre-probe IRQ setup, dedicated CPU hotplug
> state and associated declarations. Register the PMUv3 platform driver
> for both DT and ACPI; the following change adds ACPI support to the
> common platform probe path.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-acpi_arm_p=
mu_registration_hmp-v1-0-0371d4eca626@arm.com?part=3D5

