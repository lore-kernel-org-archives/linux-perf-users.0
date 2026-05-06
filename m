Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041449463
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031951; cv=none; b=Mg3KVJmq1u7o9qBCKBfWsX+YhaVpKEKhXqN2N+dRXeIuFQBAD5x86nS5nBUHXfKJM8cZk0OHeiovsqEAbHJ37VuRdrBoCH/rkYEZht2QXBBIMrLvOT1njkxHW4qs/q40HBEe1DT9QXVwHH+ADk9/Egwgn3seOJmfSydvVb3UQao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031951; c=relaxed/simple;
	bh=PmOUWOVDVOXyC86xvW4td6wxg6052kMfHSKTdMhmeMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fECbtf9ZK2GWnBRZmle3J1IfqJrmObg4p4qrb1ktymaMaQhHN1AeK02/wFKeMWw8953NKZjzFgl04uIf+dPHvEZVe7b6xQ5xeady1rEb18YH/JCV6JO5fkj6MRJ9Mudubw8nuhhyOT6sYP8uVzZeeJZlVX5Y+uI8htOBVuVU1us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY1Q3s9i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY1Q3s9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B39C2BCB4;
	Wed,  6 May 2026 01:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778031950;
	bh=PmOUWOVDVOXyC86xvW4td6wxg6052kMfHSKTdMhmeMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SY1Q3s9id4iZTaw/nyaPP/am/YGwhLXjkrhaTX/+EhCr5mqfP2ZoIGOUlDIn96aMm
	 3zdUfw4DZYJrrWKrGo0RYvTtr82noQOnEYtt63NTZCZKhgBPURDwrObiBc3F/cpyvH
	 40LK3vSyYgo2JkMF7DZski3djTqCqxBHlHushI+3eNxCjKHU0dVe0BJf8Mlrlqmjk9
	 wN+S5ylJup+gIp5dbUzpQcliikbX6yyOF4nWqIcwVaq9TqkOYBT3dn8Q6AcGJBYU9v
	 ah2QT1ccnmnaJncWn6/Na7cPWhW85H/kgTKCyXFxtWxSTfLZiWxOJgbkLZsbzhqpiS
	 SXBzoKgd3X1Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] perf symbols: Fix map removal sequence inside
 dso__process_kernel_symbol()
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260506004546.3140141-4-irogers@google.com>
References: <20260506004546.3140141-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 01:45:50 +0000
Message-Id: <20260506014550.B5B39C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Incomplete implementation missing identical map mutation anti-pa=
tterns in the kallsyms loading path.
- [Medium] Out-of-bounds array access and crash on session teardown if `map=
s__insert()` fails.
- [Medium] Lockless window exposes missing kernel map to concurrent worker =
threads, causing dropped samples.
--

commit bf2ae4502d20517901689001acc83f0ec6ca94db
Author: Ian Rogers <irogers@google.com>

perf symbols: Fix map removal sequence inside dso__process_kernel_symbol()

This commit addresses a binary search indexing issue by ensuring a map is
removed from its cache list before mutating its address key fields. After t=
he
in-place mutations are complete, the map is re-inserted to preserve the
sorting invariants of the underlying array.

> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 7afa8a1171396..f31d481a8627a 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1372,20 +1372,31 @@ static int dso__process_kernel_symbol(struct dso =
*dso, struct map *map,
>  		 */
>  		if (*remap_kernel && dso__kernel(dso) && !kmodule) {
>  			*remap_kernel =3D false;
> -			map__set_start(map, shdr->sh_addr + ref_reloc(kmap));
> -			map__set_end(map, map__start(map) + shdr->sh_size);
> -			map__set_pgoff(map, shdr->sh_offset);
> -			map__set_mapping_type(map, MAPPING_TYPE__DSO);
> -			/* Ensure maps are correctly ordered */
> +			/*
> +			 * If the map is tracking inside the kmaps cache list array, we
> +			 * MUST remove it before mutating its virtual address key fields
> +			 * in place. Otherwise, downstream binary search lookups (bsearch)
> +			 * will search for mutated keys inside an array sorted under old
> +			 * invariants, causing indexing desynchronization faults.
> +			 */
>  			if (kmaps) {
>  				int err;
>  				struct map *tmp =3D map__get(map);
> =20
>  				maps__remove(kmaps, map);

Does this introduce a window where the kernel map is missing from kmaps?

maps__remove() and maps__insert() each independently acquire and release the
kmaps write lock. During the gap between these operations, the kernel map is
missing from the collection.

For KVM guests, kernel symbols are loaded lazily when the first guest sample
is received. If concurrent perf top worker threads process samples during
this window, will their maps__find() queries fail and cause samples to be
dropped or misattributed as unknown?

> +				map__set_start(map, shdr->sh_addr + ref_reloc(kmap));
> +				map__set_end(map, map__start(map) + shdr->sh_size);
> +				map__set_pgoff(map, shdr->sh_offset);
> +				map__set_mapping_type(map, MAPPING_TYPE__DSO);
>  				err =3D maps__insert(kmaps, map);

If maps__insert() fails here (for example, due to an ENOMEM when reallocati=
ng
the array), is the kernel map left permanently detached from kmaps?

If it remains detached but is still referenced by machine->vmlinux_map, what
happens during session teardown? It looks like machine__destroy_kernel_maps=
()
unconditionally calls maps__remove().

Inside __maps__remove(), if maps__by_address_index() fails to find the map
and returns -1 (UINT_MAX), it seems the code will use this index to call
map__put(maps_by_address[UINT_MAX]) and perform a memmove(). Could this
trigger an out-of-bounds memory access and crash?

>  				map__put(tmp);
>  				if (err)
>  					return err;
> +			} else {
> +				map__set_start(map, shdr->sh_addr + ref_reloc(kmap));
> +				map__set_end(map, map__start(map) + shdr->sh_size);
> +				map__set_pgoff(map, shdr->sh_offset);
> +				map__set_mapping_type(map, MAPPING_TYPE__DSO);
>  			}
>  		}

Also, this commit fixes the in-place map boundary mutations for ELF symbols,
but does it miss similar patterns in the kallsyms loading path?

In dso__load_kernel_sym() and dso__load_guest_kernel_sym(), it appears
map__fixup_start(map) directly mutates map->start in place after the map is
already inserted into the kmaps array. Will this lockless mutation break the
sorting invariants of the maps_by_address array in the same way, causing
bsearch lookups to fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506004546.3140=
141-1-irogers@google.com?part=3D3
