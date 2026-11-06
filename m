Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988877;
	b=jMb8IwNHw0XH5HSQHp5YiPHfFwUct3Jl3N7fT5xk1TxG1CJV/sWy+D/3nRWihF/cUc1G
	 pHXM73Yhi6PaPagap9bbkcM2jHg2twIpW0H53mBEEdGFmZ0uwcdfcFpZdhh9+I8TB/IdN
	 eeJj5uaKaAJh/H9bzqmud0Zs7O3zxe7twvcVQR32gCapmu++aEUMGehuL2ZAx5NjQYXIf
	 +v0YeK7BOsdL3Qd31aVwfQ90OgAQs5umEkJZ2FV8cSHKK7tuAMTt2n3Va8TMWKiImfEYQ
	 ZNAeOcXQWIZzUgA9zyMy7XRUkfoo05sKXUXzcLjowqdweCb7uW/w/Q/9CF+LskxuKgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988877;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9rUYgMdJVU4Nr1uqaqILxz2JC36p7c9uhqM4k0c4LeA=;
	b=cbJaX3p+TgJYS0U3ceA+Kuwfm38faRJP4mxdnMerOezcs73FZvkWi1ZJHcgikZiJQJAK
	 9A1iutJZqy2NuNFFnlAxpY/OCihfDvzZ0UHQOxoQsg0jZG5cVkaWVyiLZDb0DnQ2btsud
	 XO7fkCAU+xVlW2T2MEn9gY5G2CPkyibSF8Wz7PEMRT/SUcYtEvaPW2giWcIFInPB2aPim
	 m5EqGGTvyvOUy9jzKF0up9eQYeB1BWQenWangdXxiKNNmnCdRpDDAgjvf4vihUxpxXTbg
	 W8IvG5UYJg0nHEL9cN/xah5flqyXFKgdz4zZpjT+HWSekgUBiaBp6J8thVH4J1uDb7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="knnxWo/k";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C1606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knnxWo/k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3631F0089F;
	Fri,  6 Nov 2026 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793988877;
	bh=9rUYgMdJVU4Nr1uqaqILxz2JC36p7c9uhqM4k0c4LeA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knnxWo/kVdX2jzck5qExoYIT3VCRxe6DnXFPLuxefNHk7sOpT6ZsvD9kE1M70pA6D
	 6OP2cZthefUFSTQOqYCGiWufVUMwqWZxOxXckuIsnsl0kCNmKreJ4HE90fDa3+E4rl
	 inekOubc7HzvF9on/3gmoDJ68n183pQ+NyAnjHEDh2m14vrIddhV27R67aXvGNn5DC
	 0TivviAMF4tOESIstHa8snWgfdMUeJkhZnG3Zeb3LCRvGdFKYEnZnp4R/kMtJ310nc
	 9f9YXKlF3GBgbOZ4YENlVotORtgprHo/52FOnOIF09oM6gIRV4HM8TM/kdxq+BH4R1
	 H4VhdzQYHed8g==
Message-ID: <sashiko-outbox-202000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] perf/arm-bmu: Add Devicetree support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <80f15ad90b1d1f447f072f6d9d82630f847379bf.1793986672.git.robin.murphy@arm.com>
References: <cover.1793986672.git.robin.murphy@arm.com>
 <80f15ad90b1d1f447f072f6d9d82630f847379bf.1793986672.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:14:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Initial production BMU users will be ACPI-based, but DT consumers
> will almost certainly come along sooner or later.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793986672.gi=
t.robin.murphy@arm.com?part=3D4

