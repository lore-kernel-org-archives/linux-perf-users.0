Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114806;
	b=nkuSTTBn5wdpAt45IsjotGRNFYdBqSlzVnwWWairn/29PvoTOUAt9eGzdHFCFNx0aHD4
	 cGvaMhXrf0tgbuD/mMpBoI6ESWVRNve+dTlO6Ln0xrFVEgPy+6AczaxLXjqyH35li3Y8E
	 M7sWSNqxfjuxVtTMzjejqNrrSMOFQ8ZBQBfl+8Dr4xu0BM4xS2akFFigs+8iDTYwf0Xp+
	 eMEB6W4Gf0GB45KyMBFvknydVoQVxaWyHN/AJoOvPhCcRGkoOimUGsmerj4MryZBYTt0+
	 judx7oR1QA28YtbmC50iYEU5qY5NfG8OvEfyEeH6jFb6vd0fUm/JI+NiUZygga7brRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114806;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VF7DjTZKGUrELAzhKL2OvVafbTJaYXApPiQdi91yWz8=;
	b=vxIM41NVx6G84+R4720O0JjXVsTUh2I6GEz8uF6uqk8AI1Mvm0SC9TpuzAb4Bl0gMXHi
	 um3gGXCM4OzyCmJUmhi6CPavurJF6XKlceFhDyn3Uxi19ULX9WjseE1mvOq+DSQIh/R/l
	 tCR2ztXEr5++fol1Nj6XvLEEkAS7e+aokjng0sJIE3ALF8LusevRhrSQ2b+zw1PGYxZ6p
	 pQ07X8wwKJXQzVY2cHmxFCBgV/NzcOgcExKwCPN+D9j1h1lojTbUYTvwJPor8t3ngIbUf
	 jgdw0qY411FvDh/TyEVvWuH9MqfE6LwHJFeG+/OBZeaMA8Vc2LvXy671CpJZFjhxB1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLQdpnB9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376660A2608
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLQdpnB9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFFA1F000C8;
	Thu, 19 Nov 2026 19:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114805;
	bh=VF7DjTZKGUrELAzhKL2OvVafbTJaYXApPiQdi91yWz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nLQdpnB9o3KFYxCD7ndM+Px4qu+pNCOaMBpYXwUQelIVi0qEWNCz/wBuEdtjq6QWb
	 Kf0OW6vhTIejTH4NjdfJsJlfapbErSJLxxEChrYyiKTlHwYrAxstsTyzUv38XKanOX
	 iOPQUV0hWEDFr332Oh3eO+Atxp0jv+D3YXxrzDHuXiPPIyCkuC/OkH07eClEyXnnBH
	 /sKxNVbbr8c3nd8eV/8pGEe+Fih4MiIkWmpZNz3P3q+8jZOPLMh3SMYLR1m/UHsDT/
	 HZnvs7niZtLJxDZMHGLN3rOkAlHLpsFO0sPCbpc5SNWJLbIV6x2mZ0/mCHM3dw1Itl
	 EidoZKJzCQBqQ==
Message-ID: <sashiko-outbox-223819@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/33] KVM: arm64: Reorganize PMU includes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-3-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-3-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:00:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Marc Zyngier <maz@kernel.org>
>=20
> Including *all* of asm/kvm_host.h in asm/arm_pmuv3.h is a bad idea
> because that is much more than arm_pmuv3.h logically needs and creates
> a circular dependency that makes it easy to introduce compiler errors
> when editing this code.
>=20
> asm/kvm_host.h includes kvm/arm_pmu.h includes perf/arm_pmuv3.h
> includes asm/arm_pmuv3.h includes asm/kvm_host.h
>=20
> Reorganize the PMU includes to be more sane. In particular:
>=20
> - Remove the circular dependency by removing the kvm_host.h include
>   from asm/arm_pmuv3.h since 99% of it isn't needed.
>=20
> - Move the remaining tiny bit of KVM/PMU interface from kvm_host.h
>   into arm_pmu.h
>=20
> - Conditionally on ARM64, include the more targeted arm_pmu.h directly
>   in the arm_pmuv3.c driver.
>=20
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D2

