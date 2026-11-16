Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854273;
	b=S0wU+ruabUF3Qum8xpXCbVdjM8j+C3uFo1cVr+mPXGG8KOt3tHmBrmE4Z124/oYdIZoD
	 PrNxHILpuyaJBi/53n8UnK+pZcNVoAk8eCS7D929E+lO2NZjsLbx3TFKEwPlM/XogU5au
	 Jr/KGq4djtwJtP19pcsGtkT55axXQ3nNZ/NP8BoicqpE8B1DdIbmiFE3+U7Lzy5Rm506I
	 6XJ1HPwp4BlKEEwMteFgUokPbfVnZ6/KUzm2EKz2Z5A3eUfk5dPOF2ROLM15U4NqKJUjO
	 rK9GJhg1U2JRjdrwrCjZmV+yJF5mCDGl3UAA6b4OvtXUdVCygRSuYdV7Cm0fqnzMk8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QjcAaYMEc7CLCzl8qWnRPjr+hWR3bPUZCwmR+JjZI64=;
	b=dfrHQAKw3QcjshA1KAoFnfVQLEduowUhz0OZb8DssFFvb9DOPMU7OoxY0VlPKJySBmO6
	 llnVfhowyOmjuOhIYyRPSmemoi/fV+iS3AtFfE6G8VlrTqhsicgyhyclUmG3lCHb6Oh45
	 b/RWdIrOkGdnEZmR6ZArgBQeUUwEFDrDZfL5ffxXLi+YTcX70uKOuPEIynQJy+5RH8eIm
	 NyKQmi3RjEne6Sztc4ZqYUtxsoniZRtDSqK8gOFMUdeYD2A/v4rzqKOENiIonfuYn8kdj
	 HTZIN9X4eoKr9gHoOwdLk+4pRMiruC4i5KlN7YiOFVl/8gQwL8mdqgtsNq6hXe+vF4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0FQnCts;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8452D606A32C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0FQnCts
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B47A1F000CE;
	Mon, 16 Nov 2026 18:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794854273;
	bh=QjcAaYMEc7CLCzl8qWnRPjr+hWR3bPUZCwmR+JjZI64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V0FQnCtsL/ntSK1JhNRdPB55qW400QZAT0tjs4aY9mvHSIRQSSlq5QdtbOHpOy8Do
	 1CG2k/G4gAjcbFSiynB3QFjUw4tney7h+j9GfDH/VjVWpRZvHyLANla4cJrVaxBxIv
	 EAJJ/1yMrpIN89OgG49gJftaAKPVkXpFdMMGaWwgjyWSude7HmIJXzp7/7+3KGLmHC
	 fQCdNHhDDShSDNq/Xab0zGl4iY+HFaYeRFwbStJ45B4MzJbOie8BoVSPQihJ0rjD9C
	 Dh8oOS4m6loHLqFMjmYIMjbQCkjrI7W9Qxw0FaD0t49xLXGt54EicWbB94+5jdza2D
	 nFOBvhd/TZVcg==
Message-ID: <sashiko-outbox-217506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] ACPI: arm64: Move PMU device registration to
 drivers/acpi/arm64/
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116-acpi_arm_pmu_registration_hmp-v1-8-0371d4eca626@arm.com>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
 <20261116-acpi_arm_pmu_registration_hmp-v1-8-0371d4eca626@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 18:37:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The ACPI PMU code now registers platform devices for the CPU PMU, SPE
> and TRBE. Move it to drivers/acpi/arm64/pmu.c with the other Arm ACPI
> device enumeration code.
>=20
> Move its Kconfig entry alongside it and rename the hidden ARM_PMU_ACPI
> symbol to ACPI_PMU. Drop the ARM_PMU dependency: enumeration does not
> use the CPU PMU framework, and each device type is guarded by its driver
> configuration. This allows SPE and TRBE enumeration with ARM_PMU disabled.
>=20
> Keep the default-y setting, update the build guard and retain PMU
> maintainer coverage for the new path.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-acpi_arm_p=
mu_registration_hmp-v1-0-0371d4eca626@arm.com?part=3D8

