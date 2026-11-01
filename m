Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561629;
	b=b6z5/G0A65/f65B1YrxT/1vMI9Iu0LzLLhGKNNJEX+Jjn3BqAieEcZSqgvW62lLZbDgn
	 YxfEV30+AY4GohWay6Dson6yhRSJxkW/n1i1laWQtIjzRg++U+WPFPNFELwaUk8svr7O9
	 GrrnPtQFsryQndeGrPfUCkX9/Tsj6jl/nr4ms8HuzO1wXQFmv/87Fuj3hhCQk3thI42lf
	 XWass9bifEBjcB8wC1LULTqsmjA3pSRytxOeLk9antuNlprq+a3Gp/n9ZVIbvTEIw1Mtn
	 X79xuYLn41SZlAfCUIxOjOCArvGYO7QPL7TbJmkX5/3r7OCqVya3zpvBy4T6UH0IN/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561629;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BMQ9/FSMKnhiGLoWifTkVHsSa4dLO0YpgVCabkQfEok=;
	b=v3UyyjIPXiYUE+05wwJ+nCgeWTqk3u41pTAFGE3TK3+hIetZuuPWKLSgt46f5AC1OMe+
	 9wm2xVgRPJhvElLiPdW2/UZdxG8FKgkqiXHcfBm4r2ZBxy6EsYl3/aWaswgr1+Bigtdf4
	 hsEzrjYkIaKKN1vVrBa/aPXobFAj982mgNIgl1c319bI30AfRvJGQXMAfA08s3Aek+LKB
	 yTgYghIWRLSpve/7CAX94fUYn/TbC0Dp2ntkfeKusOyG1xJRjUqQt0nllla9BvR8SP3re
	 Pv/yXqnqlh3PVK8NgN3qTZTL57POSX12ZDuJdpZZMi1LQGeZ4XAOcbNa1rC/cQa1OVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQIcVS2b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC5E606A324
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQIcVS2b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D2F1F00919;
	Sun,  1 Nov 2026 19:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561628;
	bh=BMQ9/FSMKnhiGLoWifTkVHsSa4dLO0YpgVCabkQfEok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AQIcVS2b3cCFLaapA2O4r7RthGvogY2wQ0h2TE1w5q2pFgzrcoHhPbHgeGVVWrpLh
	 Trj953M/kB3xd231lVSiDoERrc1hMYncC5rqJPgDMHujPv5++5Fd7B32qVDIbqoMMM
	 0hvLOeb3FTKttYbcplR4gx23oq3x+0Ki9nByGCXMcOlrkUbYHaqjG+aXaO8+LRkKjx
	 P7lS58bJ3UTteNEXb5UE6JfjCF2F4oHyaRHERnwL1lhcf47r9kCFqzf6ABdKWqJDQC
	 u3htj0oRUvXzWxrXvkOMv+oK1FPjxjVhtUY5tus8APT7TZzxUwYIN0v5mau9v9CtDg
	 A2i4ZkCmSP22w==
Message-ID: <sashiko-outbox-192617@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] alpha/perf: add sysfs format and event
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261101-alpha-profileme-v3-2-92d511b5a044@gmail.com>
References: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
 <20261101-alpha-profileme-v3-2-92d511b5a044@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:33:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Alpha PMU registers with no attribute groups, so the perf tool has no
> way to learn the raw config layout, and the PMU's own events can only be
> named as raw hex numbers.
>=20
> Describe the event field in format/event and export aliases for the four
> EV67 event types. mbox-replay has no generic hardware event, and can now
> be named as cpu/mbox-replay/.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101-alpha-prof=
ileme-v3-0-92d511b5a044@gmail.com?part=3D2

