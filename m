Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431777;
	b=ycRuEwxuLZ11vAK7mDJ0bvE4RaBJ1sRWtfBTw75JKT1/Ya2+K9uPXbIJ2ouM82D0IKHn
	 LYKIC/vCEU6fdC/xG2Xy9Dks7zqCDI7U9tqKOZRjbHIDcfgsbF/zQ/1OLyHDnixbC6eAP
	 YrshcmhATUkuK42PR1PlUIUPRjvcqnBcaH+H5Y62dszQI6SoLakweNjtifOuUkHjFArPa
	 T85D//71aFZY93/GH6iaEvA5n6EAMeeyFgwXzRCXHbW/M1P1TqLXJMUDgh1H32FQhvdf7
	 IFewDggvwW/mz8l3JABucFpqxnDi7ClswDt+U9g2iWhHmml4RgC8qNeXmNFHG4wA0TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431777;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uei4glz8zNQHTulXNdTr+dLzdbV4AEe0tukjwQlJm/M=;
	b=pdKCYDuRJTferAUbRiosBUewNV0fLXKGjZCxmQXc1UZn2k/MVNkmbciJIN17e+jpNDRq
	 mG3JPFULxcixEwRFZe4b9W/sJTTQruInc8LnUjvI0Or98DZ4fhX/w7zve5kByTHR5x9ul
	 1elVTEqI1I1JNuVaHNf66t/DGnx3NaW1FPQESVGDfF4gcqgcN6EW9gPBH1Hk49rmUoV9u
	 Yz8SpE6U+A25noKH4BkA5OTjabE4tnJmR5p5O3o/yaCAo6EDg55hh7dubOjnZ2sVxPw79
	 odK9U74Gl/jgV63wMy5Of6D+uGI5nl7POMAncFdkWqla/snQS2PUViv3p0XvTQvaxcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZ1lEB6d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3C606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZ1lEB6d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287CA1F00A05;
	Wed, 11 Nov 2026 21:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794431777;
	bh=uei4glz8zNQHTulXNdTr+dLzdbV4AEe0tukjwQlJm/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SZ1lEB6du6iL9jqN5YXPo6fJkG+y8xzlh7069mhvxiw6Mv8t4QhqjUl8FrMYmznir
	 fv07hclqkF87C8h+mGGhhdjt27lFJSzACFV2+0//4EruzzGG4BF5BwIU2mlUXIHavu
	 xN/arbfRK6uYcL6KCsVnvMwwBn4XIVWe//u9FOkmwhQKRe9U4xlZbYLlq50xeFQ/bM
	 z4gGMZRZb5CvKQI8tKGyVQv6GsCBkkGzpaHyxOuXZ8mhoFPxqWuaMhLsSGotAKkULb
	 jmxUOgBEJM2V4+TNjswKLvEM7f7T47eKhKo6BF6wJAKMqUUUGbC4at5tjee+b/Jyx8
	 AS0ap7xCknljA==
Message-ID: <sashiko-outbox-209691@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 19/20] perf maps: Fix map index lookup fallback and
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-20-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 21:16:16 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D19

