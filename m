Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604080;
	b=VpCAsEj6swcCI7iihTdUSe+9ae7Rh3JBleVjShZuvrwTn7+TlFKJcv4gwwDQytUth/ww
	 91Y0USOw8cbjoZg8NHn387bmDgp6exGKRVYccAGyJ5yMTwzbodRNSYFKyhyZ8iT6jJXN6
	 xEoBgkYaU7RwCBsPUid3q4xB5n8PCd7CETJQ3p87ry4RfTFho+PJLMkrXuvmcriVFDpm8
	 aTtxLOY6egqQpOBV/nlb6p5zX21G/tBx0HEWo6dytb0tFHCKljc2jw1MVR/sTqfHgIWah
	 s2cKogNW2Oaa8DMNkkRIlcintUnUD9hdIUCobYZZlHMg7o88zKTT1kzdkgMxmXZnhjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604080;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MXLWbLz/rPmG63VUy4UjJRWFiNmtPW4sQ3kHdVyH3ek=;
	b=fhzlAX3AOaEjJziRlCzFX0IyedV/ks08z/cdcFbuQD7W2wCSVwh4wHdJCB9lc2B4Iia7
	 +ZO3Rwj9f1k2YU+YVMJ+9EopR5vU22QQHyYM5NnMfPklfSascOvcM9Fa0PrCUMXNlAbMI
	 OjuZ3gutV5Abc7Sj6VqNpJwM5CZMCAWL0y4/nOYzeKWo7SoSLJqBbjYa97DhVArTvvTyU
	 sYeqTbUZCIEJ6qGv45TnMfxbOZOoiPIhk2AFsSOuS0nNw3y2cbmT7xhkQOT+OljiVfCmS
	 EqjKylZ5XgjsxxlNx5Rj7WlGw2BNXv5kXn6HvEFqTwYkazkLi7HmSUmhQYf5KZYBdlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WY6KZQHh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11F606A31B
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WY6KZQHh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377EB1F000C1;
	Wed, 21 Oct 2026 17:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792604079;
	bh=MXLWbLz/rPmG63VUy4UjJRWFiNmtPW4sQ3kHdVyH3ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WY6KZQHhFsC0DhDSkUVrDSbjfzzzzF7JcvaHDjPR+s1qhAGhYKVlp5lI47I+NbXjj
	 259VHhljfQytkJbgVrFZlJxoefJBxS+0hwuk66oZS5znq18fu5+2toQ1/K/WquVQEg
	 lqKyNQobaWQiVGa1oa0tGqycAAYXZk79inZEXm+pR7OZTqy9M4SSUw4UqfpzhmY6nZ
	 FAOPAAd7BnqGBhKncpI0Jyj5HH8S7K2kLfD5rm0iO3ww2XpCrms+ZoqfLIfGDm7ZUr
	 76JzJm8aYDdKzaKK/iEd59BHYLMVQ7Ob4VWMFrP35b8ijiryJFL4agf69LsBxMXg/r
	 Cw0X5We0zv8dA==
Message-ID: <sashiko-outbox-180528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/17] perf maps: Fix lock inversion in
 maps__load_first() and bounds check in __maps__remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-17-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:34:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf maps: use-after-free of map handle in __maps__remove()
--

commit 8a75936c25e2b3785a0195a9ee3f7cc0ea3327d3
Author: Ian Rogers <irogers@google.com>

perf maps: Fix lock inversion in maps__load_first() and bounds check in __m=
aps__remove()

This commit avoids a read-to-write lock inversion in maps__load_first() by
taking a reference to the first map and releasing the read lock before call=
ing
map__load(). It also adds bounds checks in __maps__remove() on the indices
returned by maps__by_address_index() and maps__by_name_index().

> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index f808df2fe77b4..acaf93c7c206b 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c

[ ... ]

> @@ -548,6 +549,8 @@ static void __maps__remove(struct maps *maps, struct =
map *map)
> =20
>  	/* Slide later mappings over the one to remove */
>  	address_idx =3D maps__by_address_index(maps, map);
> +	if (address_idx >=3D nr_maps)
> +		return;
>  	map__put(maps_by_address[address_idx]);
>  	memmove(&maps_by_address[address_idx],
>  		&maps_by_address[address_idx + 1],
> @@ -556,10 +559,14 @@ static void __maps__remove(struct maps *maps, struc=
t map *map)
>  	if (maps_by_name) {
>  		unsigned int name_idx =3D maps__by_name_index(maps, map);
> =20
> -		map__put(maps_by_name[name_idx]);
> -		memmove(&maps_by_name[name_idx],
> -			&maps_by_name[name_idx + 1],
> -			(nr_maps - name_idx - 1) *  sizeof(*maps_by_name));
> +		if (name_idx < nr_maps) {
> +			map__put(maps_by_name[name_idx]);
> +			memmove(&maps_by_name[name_idx],
> +				&maps_by_name[name_idx + 1],
> +				(nr_maps - name_idx - 1) * sizeof(*maps_by_name));
> +		} else {
> +			__maps__free_maps_by_name(maps);
> +		}
>  	}

[Severity: Medium]
Can calling map__put(maps_by_address[address_idx]) before
maps__by_name_index(maps, map) in __maps__remove() cause a use-after-free on
the map handle when built with REFCNT_CHECKING?

In tools/perf/util/maps.c, maps__remove_maps() (for example, via
dso__load_kcore() -> maps__remove_maps() -> __maps__remove()) passes
maps_by_address[i] directly as the map argument without holding a separate
handle:

tools/perf/util/maps.c:maps__remove_maps() {
	...
	for (unsigned int i =3D 0; i < maps__nr_maps(maps);) {
		if (cb(maps_by_address[i], data)) {
			__maps__remove(maps, maps_by_address[i]);
			removed =3D true;
		} else {
			i++;
		}
	}
	...
}

When map =3D=3D maps_by_address[address_idx], calling
map__put(maps_by_address[address_idx]) invokes RC_CHK_PUT() in
tools/lib/perf/include/internal/rc_check.h, which sets map->orig =3D NULL a=
nd
frees the wrapper handle even though maps_by_name still holds a reference:

#define RC_CHK_PUT(object)			\
	do {					\
		if (object) {			\
			object->orig =3D NULL;	\
			free(object);		\
		}				\
	} while(0)

When maps_by_name is non-NULL, the subsequent call to
maps__by_name_index(maps, map) then reads RC_CHK_ACCESS(map) from the freed
handle. If maps_by_name_sorted is true, bsearch() calls map__strcmp() and
dereferences map->orig; if maps_by_name_sorted is false, the linear scan se=
es
RC_CHK_ACCESS(map) =3D=3D NULL, logs "Map missing from maps", returns -1, a=
nd hits
the new __maps__free_maps_by_name(maps) fallback.

Would it be safer to look up name_idx (or defer
map__put(maps_by_address[address_idx])) until after maps__by_name_index() h=
as
finished using map?

> =20
>  	--RC_CHK_ACCESS(maps)->nr_maps;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D16
