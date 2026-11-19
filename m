Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795111358;
	b=Qi2ugzfHPurz5LlN65+DSOjrZ3ZMykHkYmSTT12EanenfJVL1Xa7ImGBquaxQ6mCNcZu
	 vX4QJpISiUfF2VlYhBNfAL7JnTrpP6ISqy9FtO+r8F5FW8i6VSDOLDF+8ZZ33syub1TM7
	 PuS0Rw7W/BbWawzQ6q90AIC98UpaO2aMExQseUAaMDPExEPBiwj8lUmKAE3deubG1T3mh
	 KaJIuyVKWHxu7LQIB6NsZv7FgGsld8hhj78gZpkv6hVV/NAIcV9mXLMTpqgkMccHyaE2c
	 z718bSFgXsrxNCGn+yo538h2+8lDysUsSNpkWSOHhYarZXGrgrk0lvzUnCknkKcP1Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111358;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=npCY1o4eKP+wmXGkV2wRu5shPlpvP7ZwA+ZYxLp2iVI=;
	b=aRxvNvYV0J1rjPaegyG3M2b7CJRUxib9hK0QvCP17nv864esRIgA/lBMFsg1uLowacRp
	 ZGHb+r2+aWX6N7CdgOozJ4Cr1oKFKoFS6dCXjk/Fl0d8goGJKIq5obEBVCr2WtwE/j+yR
	 dY/NrYk3MUJRX3Ar+Ctif5fcU+FWW4gD7gHpepvoPwmHkEBQQgSlMTmPP4gJWI5FroMuw
	 NUxqYGoZXmzyAXMY2eTTwIg7KEHWuCMQXTWwHQK13ZsPlANpIUUexi9+pn+nsZHOkGdFb
	 sbzlnS2w8FqUr5EhvY08kQCr8U2kT+pgxL9i5+Z+P8KrW1Hgq7nJ84FeGiuRSI1AWgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iube3myD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086F606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iube3myD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3FC1F000C5;
	Thu, 19 Nov 2026 18:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795111358;
	bh=npCY1o4eKP+wmXGkV2wRu5shPlpvP7ZwA+ZYxLp2iVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iube3myDvX7Dddrz65ru5iQw0PSzm7Ljz4AjUgKXFj6oPcB4cQc0jlxDQVGI79ILh
	 p1yzmA2QyU6z+1bBGb1Jp9IBCSbe/8LMCfET+o8qb3Q4Snw8//gFaXe2rNm9gPYc5E
	 1dU4lBSS5GmbPwDy5TYCcbLKUulF9qJ4+Vg3a8w23LGNFrjWWaWCyNQ9Gcejgk8bFK
	 sh7zeSO/lk0Nk0hFZqX4QYTYdMpBhylZ1aTF8U2SWgQgupCV1y+kok5ME3Ig5qvkAE
	 yEZdS/QgfQzZ67BqlnpgsmxbFL1X+Owisqa66tA7Bojp7NXgFeuJhBGOuksehuHN2l
	 DuOqfsCzASPPg==
Message-ID: <sashiko-outbox-223748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] mips: {cm,cpc}: Make cm_core_lock, cpc_core_lock
 raw spinlocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119-i6500-cm3-pmu-v3-1-c86410934b51@mobileye.com>
References: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
 <20261119-i6500-cm3-pmu-v3-1-c86410934b51@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:02:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Paul Burton <paul.burton@mips.com>
>=20
> cm_core_lock and cpc_core_lock are used to protect access to a CPU's
> core-other/redirect CM and CPC register blocks. Since each CPU sees
> its own copy of this block, we need to ensure that critical sections
> holding a cm_core_lock run on one CPU - ie. we need to disable
> preemption.
>=20
> Use raw_spinlock_t to implement cm_core_lock and cpc_core_lock in
> order to provide the guarantees we need on PREEMPT_RT systems.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> [added CPC part]
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-i6500-cm3-=
pmu-v3-0-c86410934b51@mobileye.com?part=3D1

