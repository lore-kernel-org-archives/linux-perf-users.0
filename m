Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809894;
	b=cIqpfsU97TCFXa3YC0jhL9ELMSMZcRL6kj8cXqzabX5uIYbpacOi5fOB0MnIZhmxycOB
	 ag1c4nmrLTavkjK6v4N55Yq+xnd2p3soBpz2hoNDVLmBA9tyAVNu7XdkfEZJxxumCQG/w
	 T/6+XZFmW1z86q7JQEfICI1OrK970mlFZOmK0iQRp/wmIPOv1iIgL9yG2j1r4hwaqeIai
	 daTl3dFIzw+IZLOxNlWOpn3Yag/VmPGMtuFdurG5cWzUWQmPJ7L0V1oFiihIxOoHKbSOq
	 BtO0jQitDMNtmweyqcNv0ITH+I5MEzd23KLZpLqMZFWMdJDXdDaHK6Vy9/HkL+9Wgdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809894;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9wUo4WfgeLsDF8xdev+3HwguHru2unfC1qnH9sNqqX8=;
	b=Lz51wSVuV7uLJCTQT+LLny81aID5HSaUtNwkeUNeuApM2eVW4kwnZdUVlZ8nC5fXuLK/
	 4PiMnM0rivRLkNlDLKHQKU7t2pDlJHZ9pOz209Yr8km05er+ouvIL/V/ab2SGDgr0/Wqs
	 40z43tFzPrtU24GR/oSc8K2/tY4XR1w+GqlCmyKjRZ6v8H1FoYF2kG50m5KjB2pwjgnWK
	 8wZqeVSlFXbuQvfbUclIvuKQm2McIbjV9KHpGGUG0wSpb1gCfbmOOLdXOFmmJAdwKwGbn
	 bCIOwC0xR8nOU22N3reT0PLTjDhDPJifGEDMM4o30SU6ByVvhVguxJ8fonfrGWjxlJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsRaYP9n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CB4606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsRaYP9n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA251F000C1;
	Wed,  4 Nov 2026 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809894;
	bh=9wUo4WfgeLsDF8xdev+3HwguHru2unfC1qnH9sNqqX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MsRaYP9nbTEd3bZSU47GNPuiJZGUhXW8Gfvho4aSSdnr634EfZa3m2HTBz1qmZ8ep
	 JvM1YIkUmQImJb/zTRtN3NfHjWjJPSCyIj3qFyXLorpsQhNwIYs1adzwhFiSM8ZDj2
	 nQ2P4CBdX11I4kXoSs5vW9HH99tDuXo1O0pld+DAK8lPgdhCCu7VRROhYz2c9lO7ae
	 9JQK3AyGtQAlLPAKqOkW7GkueTeXSeqqOQdlmBP45xnB5SFlowM4OmKtMZ6NWTmoxH
	 rYa4+pmS34PSEjggKKWcni60s4SvUOrOyrftT5Jeba8Cr/Gx75p59RhYyhvZbuMk5d
	 zPitlF8Dcz8jA==
Message-ID: <sashiko-outbox-197620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] perf jevents: Add support for NVIDIA Tegra410
 PCIE PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104160716.2910873-3-bwicaksono@nvidia.com>
References: <20261104160716.2910873-1-bwicaksono@nvidia.com>
 <20261104160716.2910873-3-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:31:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add alias support for NVIDIA Tegra410 PCIE PMU events and metrics.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104160716.2910=
873-1-bwicaksono@nvidia.com?part=3D2

