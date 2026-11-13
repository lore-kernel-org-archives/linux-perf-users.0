Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589660;
	b=Azxey4j+qBsMH3P7iWyYQflFPdN1n1CMA0x6Fb3Y3gGGhgbNgnyL4mqV0TwpCcYn+RZh
	 26mcPpQaOjY3LNwfylM22zC7mJ3D8Wm/qgOZcO7JyKziQMEyt2bOPJHmyY5Y8bMdLIHyc
	 P+Lz3nRHN8czvtSRH70uA7MYgJ+sJW++ewIqopC9hTJgVPADocTfu8fpmY5RTkgJ9s7Ih
	 iNJVpp8RYIWnTE50waj1HhVwu5EBJUP283+7ojJ7yWRsb/XiH8naruQkPENoi90k/V9Oq
	 lZklrubiYYQ/I2mzVo6QgogzK1pCbmg91J0aMw6gyQ7Tuqtl0AzzpjTENkjBkBf94mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589660;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ypCwICKRN0QEI5Hnb2MTUbZcsa8k5y5YqmtfAlndPf0=;
	b=3IU+449AYHwwoHWLmRRoeiu6kc8Zp8FZy/mTvCPNtKF/iF+m+jL1/dnUJ4lubl90AVZ3
	 ZRlnzmqS/6YybtQnMu9Os7T1iViSKs/Ea1CzKifycJx+/GnouyOIm/hu11JHheFMHIhZe
	 2wMV2cfkQtjTZwPGCOG4NHyuhFniOKauu84BWf08MYfokAC5VQjuC1p89XE3Iw7gjzyD7
	 ujYpMElpBqv+B5EsBtzi5rEsBMPBJS5WDvCaDDHk6cBgT2gwu1AgY5l6glWg6fbxbcyrM
	 VNEnproMloTg12MlrJNtLX7ec/rax3fucVrZbeGGlSUht3YHy1g29z6PcEGtXDFDFpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCg9W0j9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A10F606A330
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCg9W0j9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD03E1F000C4;
	Fri, 13 Nov 2026 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589659;
	bh=ypCwICKRN0QEI5Hnb2MTUbZcsa8k5y5YqmtfAlndPf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CCg9W0j9sFY/EP/zPBGmqssV4G1ilFNybHMgZHddr9t0VIxXcwUXqA4/RPD7TvpZU
	 BCB8+wrNpGeKPirGfnKsvZjm4l7yTmUK29KFTN5TxcAP6zYZGG0CVsN6ZZiMSEQhLI
	 lppN410gkFivtZkjq0kqhCaf4BLDp9mzzJzIMCnk3bFEy9dio+8WfUu3cSvwpo3TWh
	 qP3BHeAyPZCzSWVIaO8E88rnmQWAy8HzI2DuYIV9apRgYAn9F3uxcjkc+Hw/g9/wwt
	 lb572AX30k8q1/N9KzFT2Y7RoEFEvWaChPFLgZtn1tq5ylaDePTBHTebGukhpferGC
	 ugdve2Db6n3Yg==
Message-ID: <sashiko-outbox-213272@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 20/21] perf maps: Fix map index lookup fallback and
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-21-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:07:39 +0000
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
>   - Check map__start(prev) < map__start(new) in __maps__insert() before
> [ ... ]
> Add a unit test in tests/maps.c covering maps__remove(),
> maps__remove_maps(), maps__fixup_end(), and maps__find_next_entry().
>=20
> Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted arra=
y for addresses")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D20

