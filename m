Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949445;
	b=Yw99qqGrtWsuvVX8thVdLc2OZQkWKvgtrYYwIT/LIv2l01J/IOYYRJOjl/YducXt2IKQ
	 XOFZORnkW4QuDHzxy8TOglMVFtkIcpLc73ngmuHQzCPKB5zAMErmI/cUAuP508rIuWObQ
	 dVDD+8+qnyp1PZx7GzUuiQe+omKBurZdd1Wg4Elfl2t6EPpY2zUcKB3q5IFOmN7zrpuCn
	 yleS3AV14l5APcJCWT51wdBasZ5IiI4S0sE1Tj0cE1gpJ5sDDVBB+Lk6opOP6Qy31eT3a
	 fvJygBrdElW2VF6UOdkFNGtlMEns4Gmq9IOjXFzY/XV5AAjWP5N8P08UlrXDaqim8bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949445;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FggdEAdUjkrNq8j6TvpJJXu1PTwKlYOjjKZ17DTo9Zg=;
	b=pYFV/wMzy4gDAEq8p5RBFBoezj2SEIHcNAZqBJfPEsOk9rgVqYnuNxls25gbemEf0JT0
	 NNEsuQqHT7RUK02zj4n6kh6ejtUJxPRFqL3CNkeM4kR5KZi5eUxHHbXtZ3/fObnUxvhON
	 XMrx5/2RUJG6Z/yXDADsCRPHxA0RNg+NbZ0QvqvDQxHPWiXVrBRUCCXUrgdY3CR5zK1DT
	 UoRDgApNe35EgzXj12JIqJ+H9LmRO9XplDqcGg/sphBtvXFluikXMTo+Xp+IjBhMtAJVV
	 BRXI+Wg9FQoZUNacig2wZDFwZE9+IapZ8Pz3B8Jv1l4iPR2c0LzsVMR9iKM+wgWBmzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNhQulmX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B0606A331
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNhQulmX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912291F008BC;
	Fri,  6 Nov 2026 07:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949444;
	bh=FggdEAdUjkrNq8j6TvpJJXu1PTwKlYOjjKZ17DTo9Zg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dNhQulmXUpCj3hb0AOMJ0FqVJKOcniXLEQHimL455z8D9Jc/Nom7xGKyRtmwU4Ql6
	 pBpLf2LIBgU3UkjDhBWkLTPSI+kpeGMu34WT0vFlco8IgL1cds+f0LFOZXRbTTxEyu
	 n4PbDZKk0W5pq166DkY98ihTXEdwEWyp7lUIpFjxzSvaopt58bEec0PJwkm8VD5R9U
	 7AhXUu+ssP629vnJAMlgYMN/l2dSSnhLDuoxM4k+mygFPFiODn5ZhL13M5/pUNYCnV
	 n3QlIdHTsjj0Vw0cG8QvdjTmjb2OR7r0+wuBT8l4IgZDBTJtHwKOrHSIpQBxZYKTLE
	 pXpyXg566Fyhw==
Message-ID: <sashiko-outbox-200983@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 19/20] perf maps: Fix map index lookup fallback and
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-20-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:17:24 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D19

