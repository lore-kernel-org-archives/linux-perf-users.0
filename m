Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382973;
	b=we/+sPQneO5J00zlEi0k0YjJF8yr7R4CCgHDxlc9ohaH02jTi2Rg7h/wvvV3i6m4AMq9
	 rudhHtDJaEPhstcZQfwB+0omTF8Db6wEFX7vZb+YMFeVLYeqepzOupAqur5NAihAWZLAH
	 Dg9T9F6oNJIQ4rK5awdSJiSnV6AJGSh3wi1zWLizSPbYAhIh4FNYcCu2xuG61y/K0mb33
	 7Wm8Xu0HvocmvFoBTWLzSovGR/TYjIrJ+ZdHqM88kX/sMeQ5OC3+IYAfRrkNFPZjwdITa
	 ljQEyz6eTWo1vHuE+JsS4UzAtTZSPc2JOg0539yiF/EHjEv3LFmfTQNA+FP8nl0/mZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382973;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3J8ZkueaRQuLrfOV3xknQQmLAMU2/6LMyh3RIvWw9BE=;
	b=3XbFzx4YeTZgx259Uj+oklukXimf5sAdCOREAujdz0+ojj87//VZ/Yx4UNBjOS9nBxnF
	 g6sCPQ7Mqf4B0rAO8tgjVN8A3KJFS3hKwR1QmtHE2N8krRSfr7hkuO08wXmAOEAnKdyI+
	 c34dYoh+OflAlr72pawZ32iLSTGVqeDNXC1pxIUoNv/eCmBbwlcqK4iWT5mnqBZh2VWmr
	 CD+oloozWT0ZcDi0m56JFtEViSbGJbir1PF10YPWJuXn+9rJdnDFQacoU7GzzfqALPFgC
	 1ztQgJ9Zt/yBfzdU7isWRI2X6n/3fApSiQTquUYjCAX4BulqgAfHOgustNS1nzWgEdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccbvwSDt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B87D606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccbvwSDt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D0C1F000C1;
	Fri, 30 Oct 2026 17:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382972;
	bh=3J8ZkueaRQuLrfOV3xknQQmLAMU2/6LMyh3RIvWw9BE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ccbvwSDt4Q6HKKfY8/zUCTI908DndKIER3KUCGlw0fr2RoX5Pf9usJI/qO5emftJj
	 4ktlQtNpyIK5JmRtEkRd5foF+CQ3XRxYraxx2QP6vmQ/Tximl4gEjLg4G+bXQIUqO1
	 XA07H4NivhrB35DWhPSCrWxepkMMWoG4SZbCcOIGc/qLvwZhAzZb+N9PXZXB9cRVJ7
	 J/n+cN1MDHgcfoCfztB/7ytWje8DbBEOWAJhXi9xeTGb3nn30z7Ujt6z5TqdbaK6Nt
	 vUhH+N4PkzZXKyYbcEEXR6qrqGRTrADipOAgEizlyOBbPXHZBoWW52yucg+ewR6sJy
	 IkTAx981Za8QQ==
Message-ID: <sashiko-outbox-191377@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/9] perf jevents: Add support for NVIDIA Tegra410
 PCIE-TGT PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030174816.1544471-4-bwicaksono@nvidia.com>
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
 <20261030174816.1544471-4-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:56:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add alias support for NVIDIA Tegra410 PCIE-TGT PMU events and metrics.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030174816.1544=
471-1-bwicaksono@nvidia.com?part=3D3

