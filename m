Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262679;
	b=wZlRR64FPRt1cBvECB0g3YYfRPk6Etzxkab0zuG5JCzRC3rb7n2Ej1rR388VH9k5hFgs
	 xt7OnddbwSI/4W0S+8i/TBA3FJ41+ISOfIj9eN2hC4Lwvz1Uxlus9W5FSvTzc/CqKckXh
	 UfMels5JYrwP/2FLdf/OcrJt0C+UPeF/IYYOTe2LiYBf0XtI3rrS78OQ3Iw57jDTTVrtg
	 dsY1PtKFQnJBNbixnk7bdCa92ZJqTskC/jC409/BaG/PvzPebGmDICQPeSFdNVqF5o/mq
	 11sMEBXXF9uI3tUrD/BEMTLZMZZxHAwFSaGWWV68yr7pxyoe3QcoDbMUr6gqasozftQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262679;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eAdh3HjPoC4J53kFx7CHlIPZNOhSVR/h1LobXZzTc+8=;
	b=VEE0KLmsxJGQ3blt5pLs8VKZzuHjUPLgo1/BNRFoIZCe3lelROaqZ7zstctfGQB6CHXn
	 isne1jgUiAILR/NvM4rSN/vLtw8BbzqaoTWg8EE0K+BFOWKcY6YhTL8xhhvhC0gy9HJLM
	 y6VhGgp+meSkBaGP/vxo629sgDbhzw4eXub3kDULklbvPq+wNUIPPKX6+4X1p0YvkIqf9
	 V2Xql7ptoPTTE5odcy0YmuSHmVDHhNRi0fEnKaX9cvxZeyvCV+HqpGk9AADSeFwP6DicT
	 lhWC1xzOO5RF0s5MrWcRYEvmLYfuscfgXhfNp0gCMVlCbrVbLv8xxBwCnms3yTxP/nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLatqZYq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF00606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLatqZYq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B711F0089F;
	Mon,  9 Nov 2026 22:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262679;
	bh=eAdh3HjPoC4J53kFx7CHlIPZNOhSVR/h1LobXZzTc+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KLatqZYqMoYIsrx24aJQLXgiJCTZh0tjpWjiejIqxe/7mbYTd+N3vJxoaEV+rjVdz
	 DJQpAoAhhRuiTbuKGL23ZJa+QlQZD7CNW8Kc8Ku+FBfIbtQvcjgCzOi59bqvkPlXBt
	 DXQneI3e8oV3VQgTVygc/S8q6B3ei5pszDz/bDkfOIIUjpQlPAuIOdKh1nlFakOjM0
	 UltmQ9OEn2XxXfvsWRFHfcAhk8wsm3Z1xo662g70V5FyMOHp4X/7PvLZ3YXQZ575vY
	 swiVfjjER7spPpknNvrJX9ph6SsyIUu7diomgznDZ9bkkPmmnjOgSdk/AT70+h+HJT
	 exCNvTpNL27oA==
Message-ID: <sashiko-outbox-205711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 19/20] perf maps: Fix map index lookup fallback and
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-20-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:17:58 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D19

