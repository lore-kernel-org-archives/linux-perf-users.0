Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854161;
	b=eeJ308reGCvqnFDketDAq73jFHqRD5dfqIlYM6IG7tBq4bfrawGgAgePckbzsvZbwd3k
	 mTK4A5E9k0xqNpv/B9vNeKfOUR+lk+v+UqP4haKeuQN1bwAxpdCLq6wRnbAhyIsHHVOi+
	 TM3fiyNTHk2wSFWgafW+rNqmwMX0W6FuCnZsjh8jYIyQVBFyqIw1pcqd/8gvMnj6XwGSV
	 MlS0TlSsF6rBkPfd528vb3PhC+zzJU0diDqw4qOwpIYSwTnVV09jQ6mtdNbTLCfLxHGsV
	 4z5dzAFRCmHTUdu5hUM+wtGXbbkeudDhXI/7rZkb/WUHuh0F19UdRhLDommWGw42Z2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854161;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gqK5TKxhHWjwFpdDrrcTlQ1Am3L9bAe8F2mUB4tpgSc=;
	b=zeoe2+mva30qyMD41MAFr2nES5miNVfg6ZK2P8wTN3WibP3GSv0dimviu5Om/WU8Y+QD
	 bkUTO6WiD0msm0Ea5Gt3vCk0AlIsAkktD1eElpOYfUQZwrwS1PSa5vuEHdhYsBUSynup9
	 DEahXgHNyL8u9B80EzASXs/wOUz7KSriuvltc8V268+pl77MQxLKfFp6h65RmGZzopi2e
	 dWC/Ob5NqtugSxK5FDe/ND8arLNc8foWs5doTWhIOHCm3zwTemEbSdwOmUi3YGyXRdQiJ
	 twcWhyZMUMvQi1wuQw1B81Lp/ULbfIWgXxdupRKXEzTgZ1WALb4GrYimqAKEE7IpgcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqjpGX4W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D951606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqjpGX4W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77531F000C4;
	Mon, 16 Nov 2026 18:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794854160;
	bh=gqK5TKxhHWjwFpdDrrcTlQ1Am3L9bAe8F2mUB4tpgSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nqjpGX4WDOGAwiRThIQ9jyWS41nUM6jMmBXvdRava9/ygcWgVdzWTdhvUtY0c5hdA
	 1qtz1pd5lcdfm2X/hVxuSwicLRRh4DzXuYmNBgPylznA9iPjnMrj+e23xl4GfWLvWs
	 28EzG5tuxYuIqHWRFQoEjwRN1W5q46TJmCr6coTUE65+epireauyUKfMhFsD+/QdwP
	 i/sElmJOz8HFYqmVlrQZoNHpIDf0EEOx/4p6SLNGaekPb/SN/ikeLsQKP5ABA5nbl9
	 qD+/l8xSbg2RtFOxRxWJj8sYI0I/maf3e611gmrKR/ckKa7HwNG94jBn3YQei0G/Rv
	 587uUUsJ5axcA==
Message-ID: <sashiko-outbox-217504@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] perf/arm_pmu: Support ACPI devices in the platform
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116-acpi_arm_pmu_registration_hmp-v1-6-0371d4eca626@arm.com>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
 <20261116-acpi_arm_pmu_registration_hmp-v1-6-0371d4eca626@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 18:36:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add pmu_get_match_data() to select the initialization callback for DT
> and ACPI devices. Use OF match data for devices with a DT node, and
> match the platform device name against the existing compatible table
> otherwise. This also handles devices described by software nodes.
>=20
> Return -ENODEV when no initializer or fallback probe table is available.
> Append the platform device ID to numbered PMU names, leaving unnumbered
> DT device names unchanged.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-acpi_arm_p=
mu_registration_hmp-v1-0-0371d4eca626@arm.com?part=3D6

