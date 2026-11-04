Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828285;
	b=MBvrcm+hw5M81lwgEkV9vqL4Kbabb9ERrntR9FNqiDrjBQAyzIDs1hqWYwPiIyBj3Pm5
	 49LQ6VP40pbW80OYw9VvSK1OwhuZiLukEnoAppFhn+z7PLKqjIVYVoVUm6+QBE9gKtUPe
	 lc01D/pXm8KJKHj+XYK4Z21uygmIktIFoMjZioqNOYMASYjvr9YFFY+utanbaHWUHoU74
	 tgj35ePOaT+SHBDI+ZLqtNwvNTAsDsCX2mTaS9rPvsRaOH0UY+LfBtw+1nhyvon34DeR3
	 JeL8k/iWoHRjOC3Pz0FAo2ct1gTnPoKb5822W4s0BSyqEwNZ5sMxU59kwZCyzLuDh4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828285;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vsWTWAWa0oamYAkVZDYXI63k5FqiRwV125nmy8AMJvE=;
	b=GKXOVrbvq3Jigddt7l9PNaQukw2dRGx9X2lD1ORQvWahaoBpgPSPRjVIJM3FiAPKIYqY
	 3SmJl0QvmOvJfIXzurej/I4z+cPp45X2x8h5xqH7YzEYaz3yUorhik9WR48A2yXpEgnwt
	 zT/7GFYI4jpglOJLfdWSuJ1Y6X3vzvmYNjk9RmjDtnGRzeGhILQWehQUl8xx4XeK4veO8
	 W4YcfOP44rQw9o8+qVgx3OPJ6+ucbGEXtE2CmMe7uR2tR7fPMbkesUKoUDO0Dfa6wymWq
	 OEhi6m6arGhO54VB2mooRWljoYzgmsHrP7OzWzozYgGubHM47ssvPiTlKcvVdCYBiWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kW2kSvxb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFD606D4F0
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kW2kSvxb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879971F000C1;
	Wed,  4 Nov 2026 21:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793828284;
	bh=vsWTWAWa0oamYAkVZDYXI63k5FqiRwV125nmy8AMJvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kW2kSvxbX2yKpVRDSQ8KJeIGZuQnzt88sh8Va50AuSNlD9K1I4S1Y/2Llu7oO9Up6
	 Y+CXYaSXZCD2j6ap3b7woul45Shrf+6/oxwZNxXQGfuINNSV+p/N6LKKR5Pqh77Leu
	 gbZ7/mXUMmikm20lmdPkRlIYAim/jUZ1+cKPA9gVlNLDqrwJfYJtBNr9Bhkp6LEKUX
	 kAjwGZdsKBANeTWILrNfX2ASgAhYxgeVu/M0FMske1x7wQaQjPyWal00RtMp6J+ssT
	 6i015ePBe2kFaG+6s/pOTrjZUX0Z98n6pgSOImImdnoMdeoCeR78yo9VT5b4nLo4PH
	 qZ4HMDR2ctMhA==
Message-ID: <sashiko-outbox-198127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 18/19] perf maps: Fix lock inversion in
 maps__load_first() and bounds check in __maps__remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-19-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:38:04 +0000
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
- [Medium] perf maps: infinite loop in maps__remove_maps() on lookup failure
--

commit 0a54f1b25f8fdf637e12b3625e802bfd90f83a0e
Author: Ian Rogers <irogers@google.com>

perf maps: Fix lock inversion in maps__load_first() and bounds check in __m=
aps__remove()

This commit fixes a lock inversion in maps__load_first() by taking a refere=
nce
to the first map and releasing the read lock before calling map__load(). It
also adds bounds checks and reorders reference releases in __maps__remove().

> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index f808df2fe77b4..e947506c60a54 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <linux/zalloc.h>
>  #include "debug.h"
>  #include "dso.h"
> @@ -548,20 +549,27 @@ static void __maps__remove(struct maps *maps, struc=
t map *map)
> =20
>  	/* Slide later mappings over the one to remove */
>  	address_idx =3D maps__by_address_index(maps, map);
> -	map__put(maps_by_address[address_idx]);
> -	memmove(&maps_by_address[address_idx],
> -		&maps_by_address[address_idx + 1],
> -		(nr_maps - address_idx - 1) * sizeof(*maps_by_address));
> +	if (address_idx >=3D nr_maps)
> +		return;

[Severity: Medium]
Can returning early here cause an infinite loop in maps__remove_maps() while
holding the maps write lock?

In tools/perf/util/maps.c, maps__remove_maps() iterates over maps_by_address
and relies on __maps__remove() to shift subsequent entries down and decreme=
nt
nr_maps instead of incrementing i:

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

However, in maps__by_address_index(), if maps_by_address_sorted is true, it
only checks bsearch() with map__start_cmp() and does not fall back to the
linear pointer scan if bsearch() returns NULL:

tools/perf/util/maps.c:maps__by_address_index() {
	...
	if (maps__maps_by_address_sorted(maps)) {
		struct map **mapp =3D
			bsearch(&map, maps__maps_by_address(maps), maps__nr_maps(maps),
				sizeof(*mapp), map__start_cmp);

		if (mapp)
			return mapp - maps_by_address;
	} else {
		for (unsigned int i =3D 0; i < nr_maps; i++) {
			if (RC_CHK_EQUAL(maps_by_address[i], map))
				return i;
		}
	}
	pr_err("Map missing from maps");
	return -1;
}

When a map's start or end address is updated in place without clearing
maps_by_address_sorted (for instance in machine__create_kernel_maps() where
maps__find_next_entry() sorts kmaps while vmlinux_map has end =3D=3D ~0ULL =
before
machine__set_kernel_mmap() and maps__fixup_end() adjust map end addresses, =
or
in machine__create_module() and machine__process_kernel_mmap_event()),
bsearch() can fail to find maps_by_address[i] and maps__by_address_index()
returns -1 (UINT_MAX).

When dso__load_kcore() then calls maps__remove_maps(kmaps, remove_old_maps,
map), __maps__remove() will return early on address_idx >=3D nr_maps without
removing maps_by_address[i] or decrementing nr_maps, causing
maps__remove_maps() to repeat the same iteration i indefinitely.

Should maps__by_address_index() (and maps__by_name_index()) fall back to the
linear scan when bsearch() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D18
