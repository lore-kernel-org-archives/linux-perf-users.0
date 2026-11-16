Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854063;
	b=4TuyWLze2Mw9rzcaJvfRiDT16A2F6uWPY31rh/afQGwWGum2BdDADhJN+CKW3E/UtNPG
	 MJ9kH9o422CsrQ7lHcGUj9pNLrV43Zq7RqHZvOA6MFTUGFtsxHc6EHMkjE6lN5YfgAe7y
	 jsY78xv+QrVUBZxZcdEOF6jkRA2c2KWm6Gnnw+wSXrO/EH5GkOR+wHmtSNBD6cioBqDiz
	 TEbjVQQ4W9j2opaISj9c183DAbkNBJIlhRO3tnrevqtOIIdsde3eGtXewHUa7uFGjQ3QX
	 zuCWEzbnPW0mrgxRNjNMj6J5QFrj/foo5DUA3bKP642by3pvuoIRSpC2yr9vWOUJK8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854063;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JxRYWegJ+VLmj1ATViLg9fU389wo40a4f428yZ371X8=;
	b=YRj1wt6NNyKDDz6hu+MYYNbBZ0iavY52sXoph8U0k5QdlwgbfkWM7WRLQzAadYIVHZ9g
	 6JJ+ZrGPcC4HPUO8ahaRpsy5hHCrRRfx0HwXjEW1QUWAhrYlLggMAC1R6EAJ0ojoY9+i1
	 2p81cZha7x6x/wvs0ggZC75zepr0bDm1c4358vZSnNUN+2W4nrxN7zZnXbvhy+Qs8iGDa
	 GeiizsRelJN4f0suZcJkWhJ5AqxSRaLblrB3w8WfatWi3eIRB8jntTC4GWCTjayQqshE3
	 fFDvpUZrSgLKR+JQWVX2j1jhSYcjg+NvdZ0NDyqtjYEm8vntYhXiQtO7kv7hgOhVt4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLYELU3Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F106606A330
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLYELU3Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8501F000CA;
	Mon, 16 Nov 2026 18:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794854063;
	bh=JxRYWegJ+VLmj1ATViLg9fU389wo40a4f428yZ371X8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TLYELU3ZzCvKXXOG6gja5mpXVCsZSbfAt4HV3EPuJhvSRckGCfUVPYhgF4g/tS9K6
	 OSkWqmJs8uUAhjmHHfky+c4sfC64P1iPt0kGcMt2GHV1Mm8LhSxX5gMHMtWYym5rZV
	 jHBiFpuU98CWgBw/cN9SGwS1fmK5B38Mvc6FiKZqOnfARsIoAZ2p2MlZ3eLvLlBeit
	 oJAvtKNyvq9TahWm/vV8ixtIekBMSsrgnNlpOl+Eyc0QVy1/gapiVW7lqDGLubwOLz
	 FuI+nzGerYUGcnDk5je6GF5tRnSMN9DGIJWQMWAchoe3tAJxWJncwgknhQko4rwq1p
	 io9fnpOBjJRVg==
Message-ID: <sashiko-outbox-217502@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] perf/arm_pmu: Use ACPI CPU affinity in IRQ handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116-acpi_arm_pmu_registration_hmp-v1-7-0371d4eca626@arm.com>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
 <20261116-acpi_arm_pmu_registration_hmp-v1-7-0371d4eca626@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 18:34:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Read each IRQ resource's CPU mask through platform_get_irq_affinity().
> For ACPI SPIs, select the CPU from that resource's singleton mask.
>=20
> Add pmu_get_irq_affinity() for counting-only PMUs, which have no IRQ
> resource to query. Fall back to cpu_possible_mask when firmware provides
> no affinity mask.
>=20
> Select DT handling from the device's OF node. Preserve the DT SPI
> interrupt-affinity phandle order and the single-PPI path.
>=20
> The common platform probe initializes the per-CPU PMU pointers and
> supported CPU mask before requesting interrupts. Use that mask in
> armpmu_request_irq() and remove the cpu_possible_mask fallback needed
> by the former ACPI pre-probe IRQ setup.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-acpi_arm_p=
mu_registration_hmp-v1-0-0371d4eca626@arm.com?part=3D7

