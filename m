Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942236;
	b=w4JtPhRxZJbnGkBDHmHXGCVNx9AchrG/OM7ksz8BrFfPsIp4qN0w6muuSMly6u/6bjXd
	 isuJnuslEj16K4Gwme2+kk6sGyTlFUBjWIj2wRdLNcy2f/35mIzk2QOUFwyuN+ZZsYLIe
	 8l0UhC2UtuGSvlgIvtRY+4TAmZ/WOIc4TgYSN8WMrViz+O8450v2Icy/0EZz+Wu+8MzjY
	 0nlaxl1EbDAHzAucQYcg9Tqt1/Ub1Ukg8wA3sqLVrYm5By6nZJF0DNw+Sr7BS/SGjqSic
	 lFGHPpHbN1osqngSXPiTcppp0OVNOYxOBsISE2pfoWY2b1+WizZyyFqUnSwogdm/KQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942236;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ma/0h2g7JM4DunfT6oReI3cT5FwmspORejdcgZXrgC4=;
	b=R5AmUhad3mIQAr8/o/pRpuM0zOcJaiAIQOkm1h5KS7kvp28unDb84tVN6JUfe4wmh5P8
	 fAvDYfZ/O0zDVHHrbAOG6bcyboQK1eRap9Rg8C0dC6SilHs7J7S6rQHkTp6uqX7uAdJhK
	 s0/SqTnJjpi7usCLF/x8Hu0fNRc68DFroGnWKrzhg4Zc4F7EG00gktanYNu3ko7m//o9R
	 k3Ydho5td/9uefju5XZilWuSsj3VlXLM3bkWijq3WuLT/NsSmiJj7VIKTdpGzt9Z4rlVq
	 TcZ/fw62tJNmN54gqObiSv/vMeRi+gChb+zVUDsVOKz6iap+TJsr6Sqtkg65Szsc6tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDbJNpRT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F9A606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDbJNpRT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CB31F000C6;
	Tue, 17 Nov 2026 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942236;
	bh=Ma/0h2g7JM4DunfT6oReI3cT5FwmspORejdcgZXrgC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jDbJNpRTTcKdICxCFXVO3VDEkN8FrVOQmF2HbFKiPSs9VkH+1E1kEsc7z9cYHWkmp
	 d69srP6WI1t2ISw6rLQnear5hTJqRNu2czf9KxvjbV+kobFzoBERNigh//3wtf4FXI
	 xOVbxBj0Ty8PM2oT8RMF5ParhmEiZXQUVxlWtMvikpqgM0LPZOyb7TAG5UW09F9bi7
	 PEQZuRY5hVt5yzBjQKfxWpIz34vHavwhbk05Y2gPblUVFRfo0O9yGqd2aqRKqGs0HX
	 z+IJi8h0rxvwYZV3zGEAXqGhO5ZotDIJfxxA+buuWauUYfpa6vpERIPURGmpmc9YEB
	 RWU4CDOaktIOg==
Message-ID: <sashiko-outbox-219431@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 20/23] perf maps: Fix map index lookup fallback and
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-21-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:03:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> maps__by_address_index() and maps__by_name_index() currently only run
> their linear pointer scan when maps_by_address_sorted or
> maps_by_name_sorted is false, returning -1 (UINT_MAX) immediately if
> bsearch() returns NULL. When a map's start/end address or DSO short_name
> is updated in place without clearing the sorted flags (for example
> during module map setup), map__start_cmp() or map__strcmp() tie-breakers
> can become stale and cause bsearch() to miss an entry that is present in
> the array.
>=20
> Fix the lookup and removal paths so stale sort keys or missing maps are
> handled safely:
>   - Fall back to the linear pointer scan in maps__by_address_index() and
>     maps__by_name_index() when bsearch() returns NULL, and avoid calling
>     bsearch() on empty or NULL arrays.
>   - Factor out __maps__remove_at() with bounds checks on address_idx and
> [ ... ]
> Add a unit test in tests/maps.c covering maps__remove(),
> maps__remove_maps(), maps__fixup_end(), and maps__find_next_entry().
>=20
> Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted arra=
y for addresses")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D20

